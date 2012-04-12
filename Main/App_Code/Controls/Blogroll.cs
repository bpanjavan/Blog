#region Using

using System;
using System.IO;
using System.Web;
using System.Net;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Xml;
using System.Web.UI;
using System.Web.UI.HtmlControls;

#endregion

using BlogEngine.Core;

namespace Controls
{
  /// <summary>
  /// Creates and displays a dynamic blogroll.
  /// </summary>
  public class Blogroll : Control
  {
    static Blogroll()
    {
      BlogSettings.Changed += new EventHandler<EventArgs>(BlogSettings_Changed);
    }

    protected override void Render(HtmlTextWriter writer)
    {
      if (!Page.IsPostBack && !Page.IsCallback)
      {
        HtmlGenericControl ul = DisplayBlogroll();
        StringWriter sw = new StringWriter();
        ul.RenderControl(new HtmlTextWriter(sw));
        string html = sw.ToString();

        writer.WriteLine("<div id=\"blogroll\">");
        writer.WriteLine(html);
        writer.WriteLine("</div>");
      }
    }

    private static void BlogSettings_Changed(object sender, EventArgs e)
    {
      _Items = null;
    }

    #region Private fields

    private static Collection<RssItem> _Items;
    private static DateTime _LastUpdated = DateTime.Now;

    #endregion

    #region Methods

    public static void Update()
    {
      _Items = null;
    }

    private static object _SyncRoot = new object();

    /// <summary>
    /// Displays the RSS item collection.
    /// </summary>
    private HtmlGenericControl DisplayBlogroll()
    {
      if (DateTime.Now > _LastUpdated.AddMinutes(BlogSettings.Instance.BlogrollUpdateMinutes) && BlogSettings.Instance.BlogrollVisiblePosts > 0)
      {
        _Items = null;
        _LastUpdated = DateTime.Now;
      }

      if (_Items == null)
      {
        lock (_SyncRoot)
        {
          if (_Items == null)
          {
            _Items = new Collection<RssItem>();
            CreateList();
          }
        }
      }

      return BindControls();
    }

    /// <summary>
    /// Adds the feeds to the blogroll.
    /// </summary>
    private void CreateList()
    {
      string fileName = Context.Server.MapPath(BlogSettings.Instance.StorageLocation) + "blogroll.xml";
      if (File.Exists(fileName))
      {
        XmlDocument doc = new XmlDocument();
        doc.Load(fileName);

        foreach (XmlNode node in doc.SelectNodes("opml/body/outline"))
        {
          string title = node.Attributes["title"].InnerText;
          string description = node.Attributes["description"].InnerText;
          string rss = node.Attributes["xmlUrl"].InnerText;
          string website = node.Attributes["htmlUrl"].InnerText;
          string xfn = null;
          if (node.Attributes["xfn"] != null)
            xfn = node.Attributes["xfn"].InnerText.Replace(";", string.Empty);

          AddBlog(title, description, rss, website, xfn);
        }
      }
    }

    /// <summary>
    /// Parses the processed RSS items and returns the HTML
    /// </summary>
    private HtmlGenericControl BindControls()
    {
      HtmlGenericControl ul = new HtmlGenericControl("ul");
      ul.Attributes.Add("class", "xoxo");
      foreach (RssItem item in _Items)
      {
        HtmlAnchor feedAnchor = new HtmlAnchor();
        feedAnchor.HRef = item.RssUrl;

        HtmlImage image = new HtmlImage();
        image.Src = Utils.RelativeWebRoot + "pics/rssButton.gif";
        image.Alt = "RSS feed for " + item.Name;

        feedAnchor.Controls.Add(image);

        HtmlAnchor webAnchor = new HtmlAnchor();
        webAnchor.HRef = item.WebsiteUrl;
        webAnchor.InnerHtml = EnsureLength(item.Name);

        if (!String.IsNullOrEmpty(item.Xfn))
          webAnchor.Attributes["rel"] = item.Xfn;

        HtmlGenericControl li = new HtmlGenericControl("li");
        li.Controls.Add(feedAnchor);
        li.Controls.Add(webAnchor);

        AddRssChildItems(item, li);
        ul.Controls.Add(li);
      }

      return ul;
    }

    private void AddRssChildItems(RssItem item, HtmlGenericControl li)
    {
      if (item.ItemTitles.Count > 0 && BlogSettings.Instance.BlogrollVisiblePosts > 0)
      {
        HtmlGenericControl div = new HtmlGenericControl("ul");
				for (int i = 0; i < item.ItemTitles.Count; i++)
				{
					if (i >= BlogSettings.Instance.BlogrollVisiblePosts) break;

					HtmlGenericControl subLi = new HtmlGenericControl("li");
					HtmlAnchor a = new HtmlAnchor();
					a.HRef = item.ItemLinks[i];
					a.Title = HttpUtility.HtmlEncode(item.ItemTitles[i]);
					a.InnerHtml = EnsureLength(item.ItemTitles[i]);

					subLi.Controls.Add(a);
					div.Controls.Add(subLi);
				}

        li.Controls.Add(div);
      }
    }

    /// <summary>
    /// Ensures that the name is no longer than the MaxLength.
    /// </summary>
    private string EnsureLength(string textToShorten)
    {
      if (textToShorten.Length > BlogSettings.Instance.BlogrollMaxLength)
        return textToShorten.Substring(0, BlogSettings.Instance.BlogrollMaxLength).Trim() + "...";

      return HttpUtility.HtmlEncode(textToShorten);
    }

    /// <summary>
    /// Adds a blog to the item collection and start retrieving the blogs.
    /// </summary>
    private static void AddBlog(string name, string description, string feedUrl, string website, string xfn)
    {
      RssItem item = new RssItem();
      item.RssUrl = feedUrl;
      item.WebsiteUrl = website;
      item.Name = name;
      item.Description = description;
      item.Xfn = xfn;

      item.Request = (HttpWebRequest)WebRequest.Create(feedUrl);
      item.Request.Credentials = CredentialCache.DefaultNetworkCredentials;

      _Items.Add(item);

      item.Request.BeginGetResponse(ProcessRespose, item);
    }

    /// <summary>
    /// Gets the request and processes the response.
    /// </summary>
    private static void ProcessRespose(IAsyncResult async)
    {
      RssItem item = (RssItem)async.AsyncState;
      try
      {
        using (HttpWebResponse response = (HttpWebResponse)item.Request.EndGetResponse(async))
        {
          XmlDocument doc = new XmlDocument();
          doc.Load(response.GetResponseStream());

          XmlNodeList nodes = doc.SelectNodes("rss/channel/item");
          foreach (XmlNode node in nodes)
          {
            string title = node.SelectSingleNode("title").InnerText;
            string link = node.SelectSingleNode("link").InnerText;
            DateTime date = DateTime.Now;
            if (node.SelectSingleNode("pubDate") != null)
              date = DateTime.Parse(node.SelectSingleNode("pubDate").InnerText);

						item.ItemTitles.Add(title);
						item.ItemLinks.Add(link);
          }
        }
      }
      catch
      { }
    }

    #endregion

    #region RssItem class

    /// <summary>
    /// The RSS items used to display on the blogroll.
    /// </summary>
    private class RssItem
    {
      public HttpWebRequest Request;
      public string RssUrl;
      public string WebsiteUrl;
      public string Name;
      public string Description;
      public string Xfn;
			public List<string> ItemTitles = new List<string>();
			public List<string> ItemLinks = new List<string>();
    }

    #endregion

  }
}

public static class Updater
{
  public static void UpdateBlogroll()
  {
    Controls.Blogroll.Update();
  }
}
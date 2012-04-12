#region Using

using System;
using System.Xml;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Globalization;
using BlogEngine.Core.DataStore;
using System.Text.RegularExpressions;

#endregion

public partial class widgets_Twitter_widget : WidgetBase
{

	public override string Name
	{
		get { return "Twitter"; }
	}

	public override bool IsEditable
	{
		get { return true; }
	}

	private static DateTime LastModified = DateTime.MinValue;
	private const string CACHE_KEY = "twits";

	public override void LoadWidget()
	{
		StringDictionary settings = GetSettings();
		hlTwitterAccount.NavigateUrl = settings["accounturl"];
		int maxItems = 3;
		int.TryParse(settings["maxitems"], out maxItems);

		if (settings.ContainsKey("feedurl"))
		{			
			if (HttpRuntime.Cache[CACHE_KEY] != null)
			{
				string xml = (string)HttpRuntime.Cache[CACHE_KEY];
				XmlDocument doc = new XmlDocument();
				doc.LoadXml(xml);
				BindFeed(doc, maxItems);
			}

			if (DateTime.Now > LastModified.AddMinutes(15))
			{
				LastModified = DateTime.Now;
				BeginGetFeed(settings["feedurl"]);
			}
		}
	}

	protected void repItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
	{
		Label text = (Label)e.Item.FindControl("lblItem");
		Label date = (Label)e.Item.FindControl("lblDate");
		Twit twit = (Twit)e.Item.DataItem;
		text.Text = twit.Title;
		date.Text = twit.PubDate.ToString("MMMM d. HH:mm");
	}

	private void BeginGetFeed(string url)
	{
		HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
		request.Credentials = CredentialCache.DefaultNetworkCredentials;
		request.BeginGetResponse(EndGetResponse, request);
	}

	private void EndGetResponse(IAsyncResult result)
	{
		HttpWebRequest request = (HttpWebRequest)result.AsyncState;
		using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
		{
			XmlDocument doc = new XmlDocument();
			doc.Load(response.GetResponseStream());
			HttpRuntime.Cache[CACHE_KEY] = doc.OuterXml;
		}
	}

	private void BindFeed(XmlDocument doc, int maxItems)
	{
		XmlNodeList items = doc.SelectNodes("//channel/item");
		List<Twit> twits = new List<Twit>();
		int count = 0;
		for (int i = 0; i < items.Count; i++)
		{
			if (count == maxItems)
				break;

			XmlNode node = items[i];
			Twit twit = new Twit();
			string title = node.SelectSingleNode("description").InnerText;
			
			if (title.Contains("@"))
				continue;

			if (title.Contains(":"))
			{
				int start = title.IndexOf(":") + 1;
				title = title.Substring(start);
			}
			
			twit.Title = ResolveLinks(title);
			twit.PubDate = DateTime.Parse(node.SelectSingleNode("pubDate").InnerText, CultureInfo.InvariantCulture);
			twit.Url = new Uri(node.SelectSingleNode("link").InnerText, UriKind.Absolute);
			twits.Add(twit);

			count++;
		}
		
		twits.Sort();
		repItems.DataSource = twits;
		repItems.DataBind();
	}

	private static readonly Regex regex = new Regex("((http://|https://|www\\.)([A-Z0-9.\\-]{1,})\\.[0-9A-Z?;~&\\(\\)#,=\\-_\\./\\+]{2,})", RegexOptions.Compiled | RegexOptions.IgnoreCase);
	private const string link = "<a href=\"{0}{1}\" rel=\"nofollow\">{1}</a>";

	/// <summary>
	/// The event handler that is triggered every time a comment is served to a client.
	/// </summary>
	private string ResolveLinks(string body)
	{
		CultureInfo info = CultureInfo.InvariantCulture;

		foreach (Match match in regex.Matches(body))
		{
			if (!match.Value.Contains("://"))
			{
				body = body.Replace(match.Value, string.Format(info, link, "http://", match.Value));
			}
			else
			{
				body = body.Replace(match.Value, string.Format(info, link, string.Empty, match.Value));
			}
		}

		return body;
	}

	private struct Twit : IComparable<Twit>
	{
		public string Title;
		public Uri Url;
		public DateTime PubDate;

		public int CompareTo(Twit other)
		{
			return other.PubDate.CompareTo(this.PubDate);
		}
	}
}

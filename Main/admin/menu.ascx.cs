using System;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using BlogEngine.Core.Providers;
using BlogEngine.Core;

public partial class admin_menu : System.Web.UI.UserControl
{
	protected void Page_Load(object sender, EventArgs e)
	{
		if (!Page.IsCallback)
			BindMenu();
	}

	private void BindMenu()
	{
		SiteMapNode root = SiteMap.Providers["SecuritySiteMap"].RootNode;
		if (root != null)
		{
			foreach (SiteMapNode adminNode in root.ChildNodes)
			{
				if (adminNode.IsAccessibleToUser(HttpContext.Current))
				{
					if (!Request.RawUrl.ToUpperInvariant().Contains("/ADMIN/") && (adminNode.Url.Contains("xmanager") || adminNode.Url.Contains("PingServices")))
						continue;

					HtmlAnchor a = new HtmlAnchor();
					a.HRef = adminNode.Url;

					a.InnerHtml = "<span>" + Translate(adminNode.Title) + "</span>";//"<span>" + Translate(info.Name.Replace(".aspx", string.Empty)) + "</span>";
					if (Request.RawUrl.EndsWith(adminNode.Url, StringComparison.OrdinalIgnoreCase))
						a.Attributes["class"] = "current";
					HtmlGenericControl li = new HtmlGenericControl("li");
					li.Controls.Add(a);
					ulMenu.Controls.Add(li);
				}
			}
		}

		if (!Request.RawUrl.ToUpperInvariant().Contains("/ADMIN/"))
			AddItem(Resources.labels.changePassword, Utils.RelativeWebRoot + "login.aspx");
	}

	public void AddItem(string text, string url)
	{
		HtmlAnchor a = new HtmlAnchor();
		a.InnerHtml = "<span>" + text + "</span>";
		a.HRef = url;

		HtmlGenericControl li = new HtmlGenericControl("li");
		li.Controls.Add(a);
		ulMenu.Controls.Add(li);
	}

	public string Translate(string text)
	{
		try
		{
			return this.GetGlobalResourceObject("labels", text).ToString();
		}
		catch (NullReferenceException)
		{
			return text;
		}
	}

}

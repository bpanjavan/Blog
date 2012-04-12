#region Using

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;

#endregion

public partial class widgets_Twitter_edit : WidgetEditBase
{
	protected void Page_Load(object sender, EventArgs e)
	{
		StringDictionary settings = GetSettings();
		if (settings.ContainsKey("feedurl"))
		{
			txtUrl.Text = settings["feedurl"];
			txtAccountUrl.Text = settings["accounturl"];
			txtTwits.Text = settings["maxitems"];
		}
	}

	public override void Save()
	{
		StringDictionary settings = GetSettings();		
		settings["feedurl"] = txtUrl.Text;
		settings["accounturl"] = txtAccountUrl.Text;
		settings["maxitems"] = txtTwits.Text;
		SaveSettings(settings);
	}
}

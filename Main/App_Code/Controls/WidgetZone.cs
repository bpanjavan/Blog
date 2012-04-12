#region Using

using System;
using System.Web.UI.WebControls;
using System.Threading;
using System.Xml;
using System.Web;
using System.Web.Hosting;
using BlogEngine.Core;
using BlogEngine.Core.DataStore;
using System.IO;

#endregion

namespace Controls
{
	public class WidgetZone : PlaceHolder
	{

		static WidgetZone()
		{
			if (XML_DOCUMENT == null)
				XML_DOCUMENT = RetrieveXml();

			WidgetEditBase.Saved += delegate { XML_DOCUMENT = RetrieveXml(); };
		}

		private static XmlDocument XML_DOCUMENT = RetrieveXml();

		private static XmlDocument RetrieveXml()
		{
			WidgetSettings ws = new WidgetSettings("be_WIDGET_ZONE");
			ws.SettingsBehavior = new XMLDocumentBehavior();
			XmlDocument doc = (XmlDocument)ws.GetSettings();
            System.Diagnostics.Debug.WriteLine("XMLDoc line");
            System.Diagnostics.Debug.WriteLine("XMLDoc: " + doc.InnerXml);
            
			return doc;
		}

		/// <summary>
		/// Raises the <see cref="E:System.Web.UI.Control.Load"></see> event.
		/// </summary>
		/// <param name="e">The <see cref="T:System.EventArgs"></see> object that contains the event data.</param>
		protected override void OnLoad(EventArgs e)
		{
			base.OnLoad(e);

			XmlNodeList zone = XML_DOCUMENT.SelectNodes("//widget");
			foreach (XmlNode widget in zone)
			{
				string fileName = Utils.RelativeWebRoot + "widgets/" + widget.InnerText + "/widget.ascx";
				try
				{
					WidgetBase control = (WidgetBase)Page.LoadControl(fileName);
					control.WidgetID = new Guid(widget.Attributes["id"].InnerText);
					control.ID = control.WidgetID.ToString().Replace("-", string.Empty);
					control.Title = widget.Attributes["title"].InnerText;
					
					if (control.IsEditable)
						control.ShowTitle = bool.Parse(widget.Attributes["showTitle"].InnerText);
					else
						control.ShowTitle = control.DisplayHeader;

					control.LoadWidget();
					this.Controls.Add(control);
				}
				catch (Exception ex)
				{
					Literal lit = new Literal();
					lit.Text = "<p style=\"color:red\">Widget " + widget.InnerText + " not found.<p>";
					lit.Text += ex.Message;
					lit.Text += "<a class=\"delete\" href=\"javascript:void(0)\" onclick=\"removeWidget('" + widget.Attributes["id"].InnerText + "');return false\" title=\"" + Resources.labels.delete + " widget\">X</a>";

					this.Controls.Add(lit);
				}
			}
		}

		/// <summary>
		/// Sends server control content to a provided <see cref="T:System.Web.UI.HtmlTextWriter"></see> 
		/// object, which writes the content to be rendered on the client.
		/// </summary>
		/// <param name="writer">
		/// The <see cref="T:System.Web.UI.HtmlTextWriter"></see> object 
		/// that receives the server control content.
		/// </param>
		protected override void Render(System.Web.UI.HtmlTextWriter writer)
		{
			writer.Write("<div id=\"widgetzone\">");

			base.Render(writer);

			writer.Write("</div>");

			if (Thread.CurrentPrincipal.IsInRole(BlogSettings.Instance.AdministratorRole))
			{
				writer.Write("<select id=\"widgetselector\">");
				DirectoryInfo di = new DirectoryInfo(Page.Server.MapPath(Utils.RelativeWebRoot + "widgets"));
				foreach (DirectoryInfo dir in di.GetDirectories())
				{
					if (File.Exists(Path.Combine(dir.FullName, "widget.ascx")))
						writer.Write("<option value=\"" + dir.Name + "\">" + dir.Name + "</option>");
				}

				writer.Write("</select>&nbsp;&nbsp;");
				writer.Write("<input type=\"button\" value=\"Add\" onclick=\"addWidget($('widgetselector').value)\" />");
				writer.Write("<div class=\"clear\" id=\"clear\">&nbsp;</div>");
			}
		}

	}
}

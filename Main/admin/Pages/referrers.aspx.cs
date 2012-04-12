#region Using

using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BlogEngine.Core;

#endregion

public partial class admin_Pages_referrers : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!Page.IsPostBack)
    {      
      if (BlogSettings.Instance.EnableReferrerTracking)
      {
        BindDays();
        BindReferrers(DateTime.Now.ToString("dddd", System.Globalization.CultureInfo.InvariantCulture));
      }
      else
      {
        ddlDays.Enabled = false;
      }

      cbEnableReferrers.Checked = BlogSettings.Instance.EnableReferrerTracking;
    }

    ddlDays.SelectedIndexChanged += new EventHandler(ddlDays_SelectedIndexChanged);
    cbEnableReferrers.CheckedChanged += new EventHandler(cbEnableReferrers_CheckedChanged);
    Page.Title = Resources.labels.referrers;
  }

  private void cbEnableReferrers_CheckedChanged(object sender, EventArgs e)
  {
    if (cbEnableReferrers.Checked)
    {
      BindDays();
      BindReferrers(DateTime.Now.ToString("dddd", System.Globalization.CultureInfo.InvariantCulture));
    }
    else
    {
      ddlDays.Enabled = false;
    }

    BlogSettings.Instance.EnableReferrerTracking = cbEnableReferrers.Checked;
    BlogSettings.Instance.Save();
  }

  void ddlDays_SelectedIndexChanged(object sender, EventArgs e)
  {
    BindReferrers(ddlDays.SelectedValue);
  }

  private void BindDays()
  {
    int count = 0;
    ddlDays.ClearSelection();
    ddlDays.Enabled = true;
    foreach (ListItem item in ddlDays.Items)
    {
      item.Text = DateTime.MinValue.AddDays(count).ToString("dddd");
      if (item.Value == DateTime.Now.ToString("dddd", System.Globalization.CultureInfo.InvariantCulture))
      {
        item.Selected = true;
      }

      count++;
    }
  }

  private void BindReferrers(string day)
  {
      string filename = Server.MapPath(BlogSettings.Instance.StorageLocation + "log/" + day + ".xml");
    if (File.Exists(filename))
    {
      DataSet ds = new DataSet();
      ds.ReadXml(filename);

      DataTable table = new DataTable();
      table.Columns.Add("url", typeof(string));
      table.Columns.Add("shortUrl", typeof(string));
      table.Columns.Add("hits", typeof(int));

      DataTable spamTable = table.Clone();

      foreach (DataRow row in ds.Tables[0].Rows)
      {
        DataRow newRow = table.NewRow();
        if (row.Table.Columns.Contains("isSpam") && row["isSpam"].ToString().ToLowerInvariant() == "true")
          newRow = spamTable.NewRow();

        newRow["url"] = Server.HtmlEncode(row["address"].ToString());
        newRow["shortUrl"] = MakeShortUrl(row["address"].ToString());
        newRow["hits"] = int.Parse(row["url_text"].ToString());

        if (row.Table.Columns.Contains("isSpam") && row["isSpam"].ToString().ToLowerInvariant() == "true")
          spamTable.Rows.Add(newRow);
        else
          table.Rows.Add(newRow);
      }

      BindTable(table, grid);
      BindTable(spamTable, spamGrid);
    }
  }

  private void BindTable(DataTable table, GridView grid)
  {
    string total = table.Compute("sum(hits)", null).ToString();

    DataView view = new DataView(table);
    view.Sort = "hits desc";

    grid.DataSource = view;
    grid.DataBind();
    
    if (grid.Rows.Count > 0)
    {
      grid.FooterRow.Cells[0].Text = "Total";
      grid.FooterRow.Cells[1].Text = total;
    }

    PaintRows(grid, 3);
  }

  private string MakeShortUrl(string url)
  {
    if (url.Length > 150)
      return url.Substring(0, 150) + "...";

    return Server.HtmlEncode(url.Replace("http://", string.Empty).Replace("www.", string.Empty));
  }

  /// <summary>
  /// Paints the background color of the alternate rows
  /// in the gridview.
  /// </summary>
  private void PaintRows(GridView grid, int alternateRows)
  {
    if (grid.Rows.Count == 0)
      return;

    int count = 0;
    for (int i = 0; i < grid.Controls[0].Controls.Count - 1; i++)
    {
      if (count > alternateRows)
        (grid.Controls[0].Controls[i] as WebControl).CssClass = "alt";

      count++;

      if (count == alternateRows + alternateRows + 1)
        count = 1;
    }
  }

}

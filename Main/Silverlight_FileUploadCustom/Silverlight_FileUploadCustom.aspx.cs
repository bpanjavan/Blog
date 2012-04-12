using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Silverlight_FileUploadCustom_Silverlight_FileUploadCustom : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string thisPageURL = Request.Url.AbsoluteUri;
        string urlWithoutPage = thisPageURL.Substring(0, thisPageURL.LastIndexOf('/') + 1);
        string fileReaderURL = urlWithoutPage + "FileUploadCustom_Reader.ashx?guid=";

        this.Silverlight0.InitParameters = "CustomReaderPath=" + fileReaderURL;
    }
}

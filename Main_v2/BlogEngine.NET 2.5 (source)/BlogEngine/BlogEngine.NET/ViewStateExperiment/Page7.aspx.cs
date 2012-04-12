using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Page7 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //labelMain.Text = "Hello World!";        
    }

    protected void  labelMain_Init(object sender, EventArgs e)
    {
        labelMain.Text = "Goodbye Cruel World!";
    }


    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
    }

}

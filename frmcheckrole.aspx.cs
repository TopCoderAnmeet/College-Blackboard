using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class frmcheckrole : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.IsInRole("Admin"))
            Response.Redirect("~\\Admin\\frmhome.aspx");
        else if (User.IsInRole("User"))
            Response.Redirect("~\\user\\frmhome.aspx"); 
    }
}
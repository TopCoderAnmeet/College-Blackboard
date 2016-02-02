using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        SqlCommand comm = new SqlCommand();
        try
        {
            string dbConnectionString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            comm.CommandText = "select * from tblLogin where emailid =@emailid and pwd=@pwd";
            comm.CommandType = CommandType.Text;

            comm.Connection = new SqlConnection(dbConnectionString);

            comm.Parameters.AddWithValue("@emailid", TextBox1.Text);
            comm.Parameters.AddWithValue("@pwd", TextBox2.Text);

            comm.Connection.Open();
            if (comm.Connection.State == ConnectionState.Open)
            {
                SqlDataReader dr = comm.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows)
                {
                    dr.Read();
                    FormsAuthenticationTicket ticket = new
          FormsAuthenticationTicket(1, TextBox1.Text, DateTime.Now, DateTime.Now.AddMinutes(30),
          false, dr["roleName"].ToString(), FormsAuthentication.FormsCookiePath);

                    string hash = FormsAuthentication.Encrypt(ticket);
                    HttpCookie ht = new HttpCookie(FormsAuthentication.FormsCookieName);

                    Session["emailid"] = TextBox1.Text;
                    ht.Value = hash;
                    Response.Cookies.Add(ht);
                   // Response.Write("Ok");
                    Response.Redirect("frmcheckrole.aspx");
                }
                else
                    Response.Write("Invalid Details");

            }

        }
        catch (Exception)
        {
            
            throw;
        }
    }
}
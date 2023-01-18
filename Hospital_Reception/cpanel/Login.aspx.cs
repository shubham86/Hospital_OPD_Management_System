using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital_Reception.cpanel
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            VerifyLoginUser();
        }
        
        //verify login
        private void VerifyLoginUser()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Admin_Verify";

                objDAL.SetParameters("@userName", "varchar", txtUsername.Value, 50);
                objDAL.SetParameters("@password", "varchar", txtPassword.Value, 20);

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    HttpCookie Cookie = new HttpCookie("AdminID");
                    Cookie.Value = DT.Rows[0]["adminID"].ToString() == "" ? "0" : DT.Rows[0]["adminID"].ToString();
                    Cookie.Expires = DateTime.Now.AddMinutes(360);
                    Response.Cookies.Add(Cookie);

                    HttpCookie Cookie1 = new HttpCookie("AdminName");
                    Cookie1.Value = DT.Rows[0]["adminName"].ToString();
                    Cookie1.Expires = DateTime.Now.AddMinutes(360);
                    Response.Cookies.Add(Cookie1);

                    HttpCookie Cookie2 = new HttpCookie("role");
                    Cookie2.Value = DT.Rows[0]["role"].ToString() == "" ? "" : DT.Rows[0]["role"].ToString();
                    Cookie2.Expires = DateTime.Now.AddMinutes(360);
                    Response.Cookies.Add(Cookie2);

                    Response.Redirect("Dashboard.aspx",false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "User Name or Password is Incorrect...Please try again !!!";
                }
            }
            catch (Exception ex)
            {
                throw ex;
                string x = ex.ToString();
                //pnlAlert.Attributes.Add("class", "alert alert-danger");
                //pnlAlert.Visible = true;
                //lblalert.Text = "ERROR !!! Please try after some time";
            }
            finally
            {
                objDAL.Dispose();
            }
        }
    }
}
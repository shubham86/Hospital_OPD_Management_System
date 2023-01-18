using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital_Reception.cpanel
{
    public partial class OneDayList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Logout.aspx", false);
                return;
            }

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["action"] == "insert")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Prescription save successfully!";
                }

                fillRepeater(DateTime.Now);
            }
        }

        private void fillRepeater(DateTime date)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Appointment_Oneday_fetchInRepeater";

                objDAL.SetParameters("@date", "date", date, 20);

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    rptrAppointment.DataSource = DT;
                    rptrAppointment.DataBind();
                }
                else
                {
                    rptrAppointment.DataSource = null;
                    rptrAppointment.DataBind();
                }

                datepicker.Value = Convert.ToDateTime(date).ToString("dd-MM-yyyy");
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "ERROR to load appointment list !!!";
            }
            finally
            {
                objDAL.Dispose();
            }
        }

        protected void Date_onclick(object sender, EventArgs e)
        {
            DateTime userDate = DateTime.ParseExact(datepicker.Value, "dd-MM-yyyy", null);
            fillRepeater(Convert.ToDateTime(userDate));
        }

        protected void rptrPatient_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');

            if (e.CommandName == "checked" && Request.Cookies["role"].Value == "admin")
            {
                Response.Redirect("patientprescription.aspx?id=" + arg[0] + "&Aid=" + arg[1]);
            }
        }
    }
}
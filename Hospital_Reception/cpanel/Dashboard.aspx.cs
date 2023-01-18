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
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Logout.aspx", false);
                return;
            }

            if (Request.Cookies["role"] != null)
            {
                if (Request.Cookies["role"].Value == "admin")
                {
                    middle.HRef = "OneDayList.aspx";
                }
                else
                {
                    middle.HRef = "BookAppointment.aspx";
                }
            }

            if (!Page.IsPostBack)
            {
                getDesktopCount();
            }
        }

        private void getDesktopCount()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Dashboard_fetchCount";

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    h3Cecked.Attributes.Add("data-to", DT.Rows[0]["checked"].ToString());
                    h3Pending.Attributes.Add("data-to", DT.Rows[0]["pending"].ToString());
                    h3Total.Attributes.Add("data-to", DT.Rows[0]["total"].ToString());
                    
                    lblCecked.Text = DT.Rows[0]["checked"].ToString();
                    lblPending.Text= DT.Rows[0]["pending"].ToString();
                    lblHappyPatient.Text = DT.Rows[0]["total"].ToString();

                    int total = Convert.ToInt32(lblCecked.Text) + Convert.ToInt32(lblPending.Text);

                    decimal CheckedPerc = 0;
                    decimal PendingPerc = 0;

                    if (total != 0)
                    {
                        CheckedPerc = (Convert.ToInt32(lblCecked.Text) * 100 / total);
                        PendingPerc = (Convert.ToInt32(lblPending.Text) * 100 / total);
                    }                    
                    
                    lblCeckedPercent.Text = CheckedPerc + " %";
                    lblPendingPercent.Text = PendingPerc + " %";

                    progressChecked.Attributes.Add("style", "width:" + CheckedPerc.ToString() + "%");
                    progressPending.Attributes.Add("style", "width:" + PendingPerc.ToString() + "%");
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = x; //"ERROR to load Dashboard values !!!";
            }
            finally
            {
                objDAL.Dispose();
            }
        }

        public string getCheckedcount()
        {
            return lblCecked.Text;
        }
    }
}
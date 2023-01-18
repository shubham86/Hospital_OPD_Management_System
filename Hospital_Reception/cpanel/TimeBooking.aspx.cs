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
    public partial class TimeBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Logout.aspx", false);
                return;
            }
            else
            {
                if (Request.Cookies["role"] != null)
                {
                    if (Request.Cookies["role"].Value != "admin")
                    {
                        Response.Redirect("Logout.aspx", false);
                    }
                }
            }

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["action"] == "insert")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Admin Add successfully!";
                }
                
                fillRepeater();
            }
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            WIHO.DHO objBAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(txtDate.Value);

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
            objBAL.QueryType = "procedure";

            objBAL.QueryName = "proc_Hospital_Holiday_AddValidation";

            //DateTime d = DateTime.Now;
           
            objBAL.SetParameters("@date", "date", dt.ToString("yyyy-MM-dd"), 15);

            DT = objBAL.FetchDatainDT();

            if (DT.Rows.Count <= 0)
            {
                if (addHoliday())
                {
                    Response.Redirect("TimeBooking.aspx?action=insert", false);
                    return;
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Holiday could not be Declare... Please try again !!!";
                    return;
                }
            }
            else
            {
                pnlAlert.Attributes.Add("class", "alert alert-warning");
                pnlAlert.Visible = true;
                lblalert.Text = "This Patient already exist in appointment list !";
            }

            objBAL.Dispose();
        }

        private Boolean addHoliday()
        {
            Boolean retval = false;
            WIHO.DHO objDAL = new WIHO.DHO();
            
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(txtDate.Value);

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Holiday_Add";

                objDAL.SetParameters("@date", "datetime", dt.ToString("yyyy-MM-dd"), 20);

                if (objDAL.IUDData())
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "ERROR !!! Please try after some time";
            }
            finally
            {
                objDAL.Dispose();
            }
            return retval;
        }

        private void fillRepeater()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Holiday_fetchInRepeater";

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    rptrHoliday.DataSource = DT;
                    rptrHoliday.DataBind();
                }
                else
                {
                    rptrHoliday.DataSource = null;
                    rptrHoliday.DataBind();
                }
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


        protected void rptrAppointment_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                WIHO.BHO objBAL = new WIHO.BHO();

                objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objBAL.QueryType = "procedure";
                objBAL.QueryName = "proc_Hospital_Holiday_Delete";
                try
                {

                    if (objBAL.DeleteRecord("@holidayID", Convert.ToInt32(e.CommandArgument)))
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Record delete successfully !!!";
                        fillRepeater();
                        return;

                    }
                    else
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-danger");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Unable to delete record...Please try again !!";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Delete record ERROR !!! Please try after some time";
                }
            }
        }
    }
}
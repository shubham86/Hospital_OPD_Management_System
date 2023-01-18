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
    public partial class MedicinesEntry : System.Web.UI.Page
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
                if (Request.Cookies["role"].Value != "admin")
                {
                    Response.Redirect("Logout.aspx", false);
                }
            }

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["action"] == "insert")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Medicine Added Successfully!";
                }
                else if (Request.QueryString["action"] == "update")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Medicine Updated successfully!";
                }

                fillRepeater();
            }
        }

        private void fillRepeater()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_getActiveMedicines";

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    rptrMedicines.DataSource = DT;
                    rptrMedicines.DataBind();
                }
                else
                {
                    rptrMedicines.DataSource = null;
                    rptrMedicines.DataBind();
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "ERROR to load medicines list !!!";
            }
            finally
            {
                objDAL.Dispose();
            }
        }


        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            WIHO.DHO objBAL = new WIHO.DHO();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
            objBAL.QueryType = "procedure";

            if (lblMedicineID.Text != "0")
            {
                objBAL.QueryName = "proc_Hospital_Medicine_Update";

                objBAL.SetParameters("@medicineName", "varchar", txtName.Value, 150);
                objBAL.SetParameters("@medicineID", "int", lblMedicineID.Text, 4);

                if (objBAL.IUDData())
                {
                    Response.Redirect("MedicinesEntry.aspx?action=update", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Appointment could not be Booked... Please try again !!!";
                    return;
                }
            }
            else
            {
                objBAL.QueryName = "proc_Hospital_Medicine_Add";

                objBAL.SetParameters("@medicineName", "varchar", txtName.Value, 150);

                if (objBAL.IUDData())
                {
                    Response.Redirect("MedicinesEntry.aspx?action=insert", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Appointment could not be Booked... Please try again !!!";
                    return;
                }
            }

            objBAL.Dispose();
        }

        protected void rptrMedicines_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {                
                WIHO.BHO objBAL = new WIHO.BHO();

                objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objBAL.QueryType = "procedure";
                objBAL.QueryName = "proc_Hospital_Medicine_delete";
                try
                {
                    if (objBAL.ChangeRecordStatus("@medicineID", Convert.ToInt32(e.CommandArgument)))
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Medicine Deleted !!!";
                        fillRepeater();


                    }
                    else
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-danger");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Unable to delete...Please try again !!";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Delete ERROR !!! Please try after some time";
                }
            }

            if (e.CommandName == "edit")
            {
                string[] arg = new string[2];
                arg = e.CommandArgument.ToString().Split(';');

                lblMedicineID.Text = arg[0].ToString();
                txtName.Value = arg[1].ToString();
            }
        }
    }
}
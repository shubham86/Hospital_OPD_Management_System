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
    public partial class ManageAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Logout.aspx", false);
                return;
            }
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
                else if (Request.QueryString["action"] == "update")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Admin Update successfully!";
                }

                fillRepeater();
            }
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            WIHO.BHO objBAL = new WIHO.BHO();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
            objBAL.QueryType = "procedure";

            if (lblAdminID.Text != "0")
            {

                objBAL.QueryName = "proc_Hospital_Admin__UpdateValidation";

                if (objBAL.IsDuplicateRecord("@userName", txtUserName.Value.ToString(), 50, "@adminID", Convert.ToInt32(lblAdminID.Text)) == false)
                {
                    if (updateAdmin())
                    {
                        reset();
                        Response.Redirect("ManageAdmin.aspx?action=update", false);
                        lblAdminID.Text = "0";
                        return;                        
                    }
                    else
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-danger");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Record could not be Updated... Please try again !!!";
                        return;
                    }
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-warning");
                    pnlAlert.Visible = true;
                    lblalert.Text = "This Username already exist !";
                }
            }
            else
            {
                objBAL.QueryName = "proc_Hospital_Admin__AddValidation";

                if (objBAL.IsDuplicateRecord("@userName", txtUserName.Value.ToString(), 50) == false)
                {
                    if (addAdmin())
                    {
                        reset();
                        Response.Redirect("ManageAdmin.aspx?action=insert", false);
                        lblAdminID.Text = "0";
                        return;
                    }
                    else
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-danger");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Record could not be Inserted... Please try again !!!";
                        return;
                    }
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-warning");
                    pnlAlert.Visible = true;
                    lblalert.Text = "This Username already exist !";
                }
            }            
        }

        private Boolean addAdmin()
        {
            Boolean retval = false;
            WIHO.DHO objDAL = new WIHO.DHO();
            string Name = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtName.Value.ToString().ToLower());

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Admin_Add";

                objDAL.SetParameters("@name", "varchar", txtName.Value, 150);
                objDAL.SetParameters("@username", "varchar", txtUserName.Value, 50);
                objDAL.SetParameters("@password", "varchar", txtPassword.Value, 20);
                objDAL.SetParameters("@mobile", "varchar", txtMobile.Value, 15);
                objDAL.SetParameters("@role", "varchar", ddlRole.SelectedItem.Value, 20);
                objDAL.SetParameters("@isActive", "bit", 1, 1);

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

        private Boolean updateAdmin()
        {
            Boolean retval = false;
            WIHO.DHO objDAL = new WIHO.DHO();
            string Name = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtName.Value.ToString().ToLower());

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Admin_Update";

                objDAL.SetParameters("@adminID", "integer", lblAdminID.Text, 4);
                objDAL.SetParameters("@name", "varchar", txtName.Value, 150);
                objDAL.SetParameters("@username", "varchar", txtUserName.Value, 50);
                objDAL.SetParameters("@password", "varchar", txtPassword.Value, 20);
                objDAL.SetParameters("@mobile", "varchar", txtMobile.Value, 15);
                objDAL.SetParameters("@role", "varchar", ddlRole.SelectedItem.Value, 20);

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

        private void reset()
        {
            txtMobile.Value = "";
            txtName.Value = "";
            txtPassword.Value = "";
            txtUserName.Value = "";
        }

        private void fillRepeater()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Admin_fetchInRepeater";

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    rptrAdmin.DataSource = DT;
                    rptrAdmin.DataBind();
                }
                else
                {
                    rptrAdmin.DataSource = null;
                    rptrAdmin.DataBind();
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

        protected void rptrAdmin_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                WIHO.BHO objBAL = new WIHO.BHO();

                objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objBAL.QueryType = "procedure";
                objBAL.QueryName = "proc_Hospital_Admin_ChangeStatus";
                try
                {
                    if (objBAL.ChangeRecordStatus("@adminID", Convert.ToInt32(e.CommandArgument)))
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Admin delete sucessfully !!!";
                        fillRepeater();
                        return;
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
                    lblalert.Text = "Status change ERROR !!! Please try after some time";
                }
            }

            if (e.CommandName == "edit")
            {
                lblAdminID.Text = e.CommandArgument.ToString();

                WIHO.DHO objDAL = new WIHO.DHO();
                DataTable DT = new DataTable();

                try
                {
                    objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                    objDAL.QueryType = "procedure";
                    objDAL.QueryName = "proc_Hospital_Admin_fetchInForm";

                    objDAL.SetParameters("@adminID", "integer", Convert.ToInt32(e.CommandArgument), 4);

                    DT = objDAL.FetchDatainDT();

                    if (DT.Rows.Count > 0)
                    {                        
                        txtName.Value = DT.Rows[0]["adminName"].ToString();
                        txtMobile.Value = DT.Rows[0]["mobile"].ToString();
                        txtUserName.Value = DT.Rows[0]["userName"].ToString();
                        txtPassword.Value = DT.Rows[0]["password"].ToString();
                        ddlRole.ClearSelection();
                        ddlRole.Items.FindByValue(DT.Rows[0]["role"].ToString()).Selected = true;
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
        }
    }
}
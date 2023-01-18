using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital_Reception
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                filldateddl();

                if (Request.QueryString["action"] == "insert")
                {
                    pnlAlert.Style.Add("display", "block");
                    lblalert.Text = "<span style='color:#00d73f'>Appointment booked successfully !</span> <br/> <span style='color:#6c6c6c'>Your Appointment No is :</span> <span style='font-size:20px;font-weight:bold;color:#f05697;'> " + Request.QueryString["sequence"].ToString() + "</span> <br/> <span style='color:#6c6c6c'>Your Appointment Time is :</span> <span style='font-size:20px;font-weight:bold;color:#f05697;'> " + Request.QueryString["time"].ToString() + "</br> <span style='color:#6c6c6c;font-weight:normal;font-size:12px'>वेळेवर उपस्थित नसल्यास, सगळ्यात शेवटी नंबर लावण्यात येईल.</span>";

                    ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#appointment';", true);
                }
                else if (Request.QueryString["action"] == "full")
                {
                    pnlAlert.Style.Add("display", "block");
                    lblalert.Text = "<span style='color:#e2a600'>Appointment List full for today, Please try for Tomorrow!</span>";

                    ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#appointment';", true);
                }
                else if (Request.QueryString["action"] == "sat")
                {
                    pnlAlert.Style.Add("display", "block");
                    lblalert.Text = "<span style='color:#e2a600'>Appointment List full for today, Please try for Monday!</span>";

                    ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#appointment';", true);
                }
            }
        }

        private void filldateddl()
        {
            DataTable dt = fetchHolidays();
            ListItem lstItem = new ListItem();

            Boolean today = true;
            Boolean tomorrow = true;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (DateTime.Now.ToString("yyyy-MM-dd") == Convert.ToDateTime(dt.Rows[i]["holidayDate"]).ToString("yyyy-MM-dd"))
                {
                    today = false;
                }

                if (DateTime.Now.AddDays(1).ToString("yyyy-MM-dd") == Convert.ToDateTime(dt.Rows[i]["holidayDate"]).ToString("yyyy-MM-dd"))
                {
                    tomorrow = false;
                }
            }

            if (!today)
            {
                lstItem = new ListItem();
                lstItem.Text = "Closed Today";
                lstItem.Value = "0";
                ddlDate.Items.Add(lstItem);
                lstItem.Attributes.Add("disabled", "disabled");
                lstItem.Attributes.Add("style", "color:red");
            }
            else
            {
                if (DateTime.Now.DayOfWeek.ToString() == "Sunday")
                {
                    lstItem = new ListItem();
                    lstItem.Text = "Closed on Sunday...";
                    lstItem.Value = "0";
                    ddlDate.Items.Add(lstItem);
                    lstItem.Attributes.Add("disabled", "disabled");
                    lstItem.Attributes.Add("style", "color:red");
                }
                else
                {
                    lstItem = new ListItem();
                    lstItem.Text = (DateTime.Now).ToString("dd-MMM-yyyy") + " " + DateTime.Now.DayOfWeek.ToString();
                    lstItem.Value = (DateTime.Now).ToString("yyyy-MM-dd");
                    ddlDate.Items.Add(lstItem);
                }
            }

            if (!tomorrow)
            {
                lstItem = new ListItem();
                lstItem.Text = "Closed Tomorrow";
                lstItem.Value = "0";
                ddlDate.Items.Add(lstItem);
                lstItem.Attributes.Add("disabled", "disabled");
                lstItem.Attributes.Add("style", "color:red");
            }
            else
            {
                if (DateTime.Now.AddDays(1).DayOfWeek.ToString() == "Sunday")
                {
                    lstItem = new ListItem();
                    lstItem.Text = "Closed on Sunday...";
                    lstItem.Value = "0";
                    ddlDate.Items.Add(lstItem);
                    lstItem.Attributes.Add("disabled", "disabled");
                    lstItem.Attributes.Add("style", "color:red");
                }
                else
                {
                    lstItem = new ListItem();
                    lstItem.Text = (DateTime.Now.AddDays(1)).ToString("dd-MMM-yyyy") + " " + DateTime.Now.AddDays(1).DayOfWeek.ToString();
                    lstItem.Value = (DateTime.Now.AddDays(1)).ToString("yyyy-MM-dd");
                    ddlDate.Items.Add(lstItem);
                }
            }
        }

        private void registerPatient()
        {
            String strConnString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            string middlename = txtMiddleName.Text == "" ? txtMiddleName.Text : (txtMiddleName.Text + " ");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proc_Hospital_Patient_Register";

            cmd.Parameters.Add("@name", SqlDbType.NVarChar).Value = CultureInfo.CurrentCulture.TextInfo.ToTitleCase((txtFirstName.Text + " " + middlename + txtLastName.Text).ToLower()).Trim();
            cmd.Parameters.Add("@dob", SqlDbType.VarChar).Value = txtDOB.Value;
            cmd.Parameters.Add("@mobile1", SqlDbType.VarChar).Value = txtMobile1.Value.ToString() == "" ? "-" : txtMobile1.Value.ToString();
            cmd.Parameters.Add("@mobile2", SqlDbType.VarChar).Value = txtMobile2.Value.ToString() == "" ? "-" : txtMobile2.Value.ToString();
            cmd.Parameters.Add("@address", SqlDbType.NVarChar).Value = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtAddress.Text.ToString().ToLower());
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = "-";
            cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = ddlGender.SelectedItem.Value;
            cmd.Parameters.Add("@id", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Connection = con;
            try
            {
                con.Open();
                int retval = cmd.ExecuteNonQuery();
                if (retval.ToString() == "-1")
                {
                    string id = cmd.Parameters["@id"].Value.ToString();
                    if (id != "0")
                    {
                        lblSMSMobile.Text = txtMobile1.Value;
                        addAppointment(Convert.ToInt32(id));
                    }
                    else
                    {
                        lblRegisterAlert.Text = "Registration Error Please try again !";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        protected void getPatientDetails()
        {
            WIHO.DHO objBAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
            objBAL.QueryType = "procedure";

            objBAL.QueryName = "proc_Hospital_Patient_Verification";

            DateTime d = DateTime.Now;

            objBAL.SetParameters("@mobile", "varchar", txtMobile.Value.ToString(), 10);

            DT = objBAL.FetchDatainDT();

            if (DT.Rows.Count > 0)
            {
                tblDetails.Visible = true;

                lblID.Text = DT.Rows[0]["patientID"].ToString();
                lblName.Text = DT.Rows[0]["patientName"].ToString();
                lblDOB.Text = DT.Rows[0]["age"].ToString();
                lblAddress.Text = DT.Rows[0]["address"].ToString();
                Mobile.Text = txtMobile.Value.ToString();
                lblSMSMobile.Text = txtMobile.Value.ToString();
                Date.Text = Convert.ToDateTime(ddlDate.SelectedItem.Value).ToString("dd-MMM-yyyy") + " " + Convert.ToDateTime(ddlDate.SelectedItem.Value).DayOfWeek;
            }

            objBAL.Dispose();
        }
        

        protected void btnBookAppointment_Click(object sender, System.EventArgs e)
        {
            WIHO.DHO objBAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            try
            {
                objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objBAL.QueryType = "procedure";

                objBAL.QueryName = "proc_Hospital_Patient_MobileRegister_Validation";

                DateTime d = DateTime.Now;

                objBAL.SetParameters("@mobile", "varchar", txtMobile.Value.ToString(), 10);

                DT = objBAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#loginModal';", true);
                    Loginalert.Visible = false;
                    tdRegisterBtn.Visible = false;
                    tdConfirmBtn.Visible = true;
                    getPatientDetails();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#loginModal';", true);
                    Mobile.Text = txtMobile.Value.ToString();
                    Date.Text = Convert.ToDateTime(ddlDate.SelectedItem.Value).ToString("dd-MMM-yyyy") + " " + Convert.ToDateTime(ddlDate.SelectedItem.Value).DayOfWeek;

                    lblLoginAllert.Text = "You are not registerd Patient. Please Register.";
                    lblLoginAllert.ForeColor = System.Drawing.ColorTranslator.FromHtml("#edb600");
                    tdRegisterBtn.Visible = true;
                    tdConfirmBtn.Visible = false;
                    tblDetails.Visible = false;
                    Loginalert.Visible = true;
                }
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            finally
            {
                objBAL.Dispose();
            }
        }

        protected void btnRegister_Click(object sender, System.EventArgs e)
        {
            WIHO.DHO objBAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            try
            {
                objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objBAL.QueryType = "procedure";

                objBAL.QueryName = "proc_Hospital_Patient_Register_Validation";

                DateTime d = DateTime.Now;

                objBAL.SetParameters("@mobile1", "varchar", txtMobile1.Value.ToString(), 10);
                objBAL.SetParameters("@mobile2", "varchar", txtMobile2.Value.ToString(), 10);
                objBAL.SetParameters("@name", "varchar", CultureInfo.CurrentCulture.TextInfo.ToTitleCase((txtFirstName.Text + " " + txtMiddleName.Text + " " + txtLastName.Text).ToLower()).Trim(), 150);
                objBAL.SetParameters("@dob", "varchar", txtDOB.Value, 20);
                objBAL.SetParameters("@address", "varchar", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtAddress.Text.ToLower()).Trim(), 150);

                DT = objBAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    lblRegisterAlert.Text = "You are allready register with another mobile number.";
                    ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#rgisterModal';", true);
                }
                else
                {
                    registerPatient();
                }
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            finally
            {
                objBAL.Dispose();
            }
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            WIHO.DHO objBAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
            objBAL.QueryType = "procedure";

            objBAL.QueryName = "proc_Hospital_Appointment_AddValidation";

            DateTime d = DateTime.Now;

            objBAL.SetParameters("@patientID", "integer", lblID.Text, 10);
            objBAL.SetParameters("@date", "date", ddlDate.SelectedItem.Value + " " + DateTime.Now.ToString("h:mm:ss tt"), 15);

            DT = objBAL.FetchDatainDT();

            if (DT.Rows.Count <= 0)
            {
                addAppointment(Convert.ToInt32(lblID.Text));
            }
            else
            {
                pnlAlert.Style.Add("display", "block");
                lblalert.Text = "<span style='color:#e2a600'>You already have an appointment for this date !</span>";
                ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#appointment';", true);
            }

            objBAL.Dispose();
        }

        private DataTable fetchHolidays()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Holiday_fetchActiveHolidays ";

                DT = objDAL.FetchDatainDT();

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
            return DT;
        }

        private void addAppointment( int ID)
        {
            try
            {
                string query = "";
                if (ddlDate.SelectedItem.Value == DateTime.Now.ToString("yyyy-MM-dd"))
                {
                    query = "addAppointment";
                }
                else
                {
                    query = "proc_Hospital_Appointment_AddFromSite";
                }
                string Sequence = "0";
                string time = "";
                string connect = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        //string x = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@patientID", ID);
                        cmd.Parameters.AddWithValue("@onePatientTime", ConfigurationManager.AppSettings["CONST_TimeFor_OnePatient"].ToString());
                        cmd.Parameters.AddWithValue("@OPDstartTime", ConfigurationManager.AppSettings["CONST_TimeOf_StartOPD"].ToString());
                        cmd.Parameters.AddWithValue("@date", ddlDate.SelectedItem.Value + " " + DateTime.Now.ToString("h:mm:ss tt"));
                        cmd.Parameters.AddWithValue("@curDateTime", DateTime.Now.ToString("yyyy-MM-dd") + " " + DateTime.Now.ToString("h:mm tt"));
                        cmd.Parameters.Add("@sequence", SqlDbType.VarChar, 10, "sequence");
                        cmd.Parameters.Add("@time", SqlDbType.VarChar, 10, "time");
                        cmd.Parameters["@sequence"].Direction = ParameterDirection.Output;
                        cmd.Parameters["@time"].Direction = ParameterDirection.Output;
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        Sequence = (string)cmd.Parameters["@sequence"].Value;
                        time = (string)cmd.Parameters["@time"].Value;
                    }
                    conn.Close();
                }

                if (Sequence != "0")
                {                    reset();
                    if (time == "full")
                    {
                        Response.Redirect("Index.aspx?action=full", false);
                    }
                    else if (time == "saturday")
                    {
                        Response.Redirect("Index.aspx?action=sat", false);
                    }
                    else
                    {
                        sendSMS(Sequence.ToString(), (Convert.ToDateTime(ddlDate.SelectedItem.Value).ToString("dd MMM yyyy") + " " + time));
                        Response.Redirect("Index.aspx?action=insert" + "&Sequence=" + Sequence + "&time=" + time, false);
                    }
                }                
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Style.Add("display", "block");
                lblalert.Text = "<span style='color:#ff0000'>Book Appointment ERROR !!! Please try after some time</span>";
                ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#appointment';", true);
            }
        }

        public string sendSMS(string token, string time)
        {
            String message = HttpUtility.UrlEncode("Your appointment booked successfully. Your token number is " + token + " and Appointment time is " + time + " www.drkamblesfertilitycenter.in");
            string mobileNo = lblSMSMobile.Text;
            using (var wb = new WebClient())
            {
                byte[] response = wb.UploadValues("https://api.textlocal.in/send/", new NameValueCollection()
                {
                {"apikey" , "VifASt5OzrQ-6ZQyb9OEt84nI6fHtRn45pDFOtPOAn"},
                {"numbers" , mobileNo},
                {"message" , message},
                {"sender" , "DRKFCY"}
                });
                string result = System.Text.Encoding.UTF8.GetString(response);
                return result;
            }
        }

        private void reset()
        {
            txtAddress.Text = "";
            txtDOB.Value = "";
            txtFirstName.Text = "";
            txtMiddleName.Text = "";
            txtLastName.Text = "";
            txtMobile1.Value = "";
            txtMobile2.Value = "";
            lblID.Text = "0";
        }
    }
}
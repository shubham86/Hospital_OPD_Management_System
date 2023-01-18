using SpeechLib;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text;
using System.Text;

namespace Hospital_Reception.cpanel
{
    public partial class BookAppointment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {   
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["action"] == "insert")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Appointment booked successfully!";
                }
                else if (Request.QueryString["action"] == "absent")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Patient Send to last !!!";
                }

                fillRepeater();
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

            objBAL.SetParameters("@patientID", "integer", lblPatientID.Text, 10);
            objBAL.SetParameters("@date", "date", Convert.ToDateTime(txtDate.Value).ToString("yyyy-MM-dd"), 20);

            DT = objBAL.FetchDatainDT();

            if (DT.Rows.Count <= 0)
            {
                if (lblPatientID.Text != "0")
                {
                    if (addAppointment())
                    {
                        reset();
                        Response.Redirect("BookAppointment.aspx?action=insert", false);
                        return;
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
                    registerAndAddAppointment();
                    reset();
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

        private void registerAndAddAppointment()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            string Name = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtName.Value.ToString().ToLower());
            string Address = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtAddress.Value.ToString().ToLower());

            DateTime dt = new DateTime();;
            dt = Convert.ToDateTime(txtDate.Value);

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Appointment_RegisterAndAdd";
                
                objDAL.SetParameters("@name", "varchar", Name, 150);
                objDAL.SetParameters("@dob", "varchar", txtDOB.Value, 20);
                objDAL.SetParameters("@mobile1", "varchar", txtMobile1.Value.ToString(), 10);
                objDAL.SetParameters("@mobile2", "varchar", txtMobile2.Value.ToString() == "" ? "-" : txtMobile2.Value.ToString(), 10);
                objDAL.SetParameters("@address", "varchar", Address, 150);
                objDAL.SetParameters("@gender", "varchar", rdblGender.SelectedItem.Value, 10);
                objDAL.SetParameters("@date", "datetime", dt.ToString("yyyy-MM-dd") + " " + DateTime.Now.ToString("h:mm:ss tt"), 20);

                if (objDAL.IUDData())
                {
                    reset();
                    Response.Redirect("BookAppointment.aspx?action=insert", false);
                    return;
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Appointment could not be Booked... Please try again !!!";
                    return;
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
        }


        private Boolean addAppointment()
        {
            Boolean retval = false;
            WIHO.DHO objDAL = new WIHO.DHO();
            string Name = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtName.Value.ToString().ToLower());
            string Address = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtAddress.Value.ToString().ToLower());

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(txtDate.Value);

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Appointment_Add";

                objDAL.SetParameters("@patientID", "integer", lblPatientID.Text, 10);
                objDAL.SetParameters("@date", "datetime", dt.ToString("yyyy-MM-dd") + " " + DateTime.Now.ToString("h:mm:ss tt"), 20);

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

        

        //protected Boolean getFollowup(string Name)
        //{
        //    Boolean _retVal = false;

        //    WIHO.DHO objDAL = new WIHO.DHO();
        //    DataTable DT = new DataTable();

        //    try
        //    {
        //        objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
        //        objDAL.QueryType = "procedure";
        //        objDAL.QueryName = "proc_Hospital_Appointment_FolloupStatus";

        //        objDAL.SetParameters("@name", "varchar", Name, 150);

        //        DT = objDAL.FetchDatainDT();
        //        if (DT.Rows.Count > 0)
        //        {
        //            return true;
        //        }
        //        else
        //        {
        //            return false;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        string x = ex.ToString();
        //        pnlAlert.Attributes.Add("class", "alert alert-danger");
        //        pnlAlert.Visible = true;
        //        lblalert.Text = "ERROR !!! Please try after some time";
        //    }

        //    return _retVal;
        //}

        //protected decimal getFees(Boolean followup)
        //{
        //    decimal _retVal = 0;

        //    WIHO.DHO objDAL = new WIHO.DHO();
        //    DataTable DT = new DataTable();

        //    try
        //    {
        //        objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
        //        objDAL.QueryType = "procedure";
        //        objDAL.QueryName = "proc_Hospital_Fees_fetchFees";

        //        if (followup)
        //        {
        //            objDAL.SetParameters("@status", "varchar", "Followup", 15);
        //        }
        //        else
        //        {
        //            objDAL.SetParameters("@status", "varchar", "New", 15);
        //        }

        //        DT = objDAL.FetchDatainDT();

        //        if (DT.Rows.Count > 0)
        //        {
        //            return Convert.ToDecimal(DT.Rows[0]["fees"]);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        string x = ex.ToString();
        //        pnlAlert.Attributes.Add("class", "alert alert-danger");
        //        pnlAlert.Visible = true;
        //        lblalert.Text = "ERROR !!! Please try after some time";
        //    }

        //    return _retVal;
        //}

        private void reset()
        {
            txtAddress.Value = "";
            txtDOB.Value = "";
            txtDate.Value = "";
            txtName.Value = "";
            txtMobile1.Value = "";
            txtMobile2.Value = "";
            lblPatientID.Text = "";
        }

        [WebMethod]
        public static string[] GetPatient(string prefix)
        {
            List<string> customers = new List<string>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {                    
                    cmd.CommandText = "select patientName from TB_Patient where patientName like '%' + @SearchText + '%'";
                    cmd.Parameters.AddWithValue("@SearchText", prefix);
                    cmd.Connection = conn;
                    conn.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(string.Format("{0}", sdr["patientName"]));
                        }
                    }
                    conn.Close();
                }
            }
            return customers.ToArray();
        }

        [WebMethod]
        public static string[] GetPatientByMobile(string prefix)
        {
            List<string> customers = new List<string>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "(SELECT mobile1 as mobile FROM TB_Patient where mobile1 != '-' and mobile1 like @SearchText + '%') UNION (SELECT mobile2 as mobile FROM TB_Patient where mobile2 != '-' and mobile2 like @SearchText + '%')";
                    cmd.Parameters.AddWithValue("@SearchText", prefix);
                    cmd.Connection = conn;
                    conn.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(string.Format("{0}", sdr["mobile"]));
                        }
                    }
                    conn.Close();
                }
            }
            return customers.ToArray();
        }

        [System.Web.Services.WebMethod]
        public static string GetDetails(string name)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Appointment_getPatienDetails";

                objDAL.SetParameters("@name", "varchar", name, 150);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    return DT.Rows[0]["age"].ToString() + "," + DT.Rows[0]["mobile1"].ToString() + "," + DT.Rows[0]["mobile2"].ToString() + "," + DT.Rows[0]["address"].ToString() + "," + DT.Rows[0]["patientID"].ToString() + "," + DT.Rows[0]["patientName"].ToString() + "," + DT.Rows[0]["gender"].ToString();                    
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
            }
            finally
            {
                objDAL.Dispose();
            }
            return retval;
        }

        [System.Web.Services.WebMethod]
        public static string GetDetailsByMobile(string name)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Appointment_getPatienDetails_byMobile";

                objDAL.SetParameters("@mobile", "varchar", name, 10);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    return DT.Rows[0]["age"].ToString() + "," + DT.Rows[0]["mobile1"].ToString() + "," + DT.Rows[0]["mobile2"].ToString() + "," + DT.Rows[0]["address"].ToString() + "," + DT.Rows[0]["patientID"].ToString() + "," + DT.Rows[0]["patientName"].ToString();                    
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
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
                objDAL.QueryName = "proc_Hospital_Appointment_fetchInRepeater";

                objDAL.SetParameters("@date", "date", DateTime.Now.ToString("yyyy/MM/dd"), 12);

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

        private DataTable getPatientList()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Appointment_TodaysListPDF";

                objDAL.SetParameters("@date", "date", DateTime.Now.ToString("yyyy/MM/dd"), 12);

                DT = objDAL.FetchDatainDT();

                return DT;
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "ERROR to load appointment list !!!";
                throw null;
            }
            finally
            {
                objDAL.Dispose();
            }
        }

        protected void rptrAppointment_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {            
            if (e.CommandName == "status")
            {
                WIHO.BHO objBAL = new WIHO.BHO();

                objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objBAL.QueryType = "procedure";
                objBAL.QueryName = "proc_Hospital_Appointment_ChangeStatus";
                try
                {                        
                    if (objBAL.ChangeRecordStatus("@appointmentID", Convert.ToInt32(e.CommandArgument)))
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Patient Checked !!!";
                        fillRepeater();

                        anounceFirstPatient();
                        return;
                    }
                    else
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-danger");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Unable to change status...Please try again !!";
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

            if (e.CommandName == "absent")
            {
                string[] arg = new string[3];
                arg = e.CommandArgument.ToString().Split(';');

                WIHO.DHO objBAL = new WIHO.DHO();

                objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objBAL.QueryType = "procedure";
                objBAL.QueryName = "proc_Hospital_Appointment_ChengeSequence";

                objBAL.SetParameters("@appointmentID", "integer", Convert.ToInt32(arg[0]), 10);
                objBAL.SetParameters("@sequence", "integer", Convert.ToInt32(arg[1]), 10);
                objBAL.SetParameters("@tokenNo", "varchar", arg[2].ToString(), 10);

                try
                {
                    if (objBAL.IUDData())
                    {
                        //pnlAlert.Attributes.Add("class", "alert alert-success");
                        //pnlAlert.Visible = true;
                        //lblalert.Text = "Patient Send to last !!!";
                        //fillRepeater();
                        Response.Redirect("BookAppointment.aspx?action=absent");
                        return;

                    }
                    else
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-danger");
                        pnlAlert.Visible = true;
                        lblalert.Text = "Unable to change sequence...Please try again !!";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "Sequence change ERROR !!! Please try after some time";
                }
                finally
                {
                    objBAL.Dispose();
                }
            }
        }

        private void anounceFirstPatient()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Appointment_fetchTop5";

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    SpVoice voice = new SpVoice();
                    voice.Speak( "number " + DT.Rows[0]["sequence"].ToString() + ". " + DT.Rows[0]["patientName"].ToString());
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
            }
            finally
            {
                objDAL.Dispose();
            }
        }

        protected void ExportToPDF(object sender, EventArgs e)
        {
            DataTable dt = getPatientList();

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();

                    sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");
                    sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>Patient Appointment</b></td></tr>");
                    sb.Append("<tr><td colspan = '2'></td></tr>");
                    sb.Append("<tr><td></td><td align = 'right'><b>Date: </b>");
                    sb.Append(DateTime.Now);
                    sb.Append(" </td></tr>");
                    sb.Append("</table>");
                    sb.Append("<br />");
                    
                    sb.Append("<table border = '1' width='100%' >");
                    sb.Append("<tr>");

                    sb.Append("<th width=\"10%\" style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Number");
                    sb.Append("</th>");

                    sb.Append("<th width='25%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Name");
                    sb.Append("</th>");

                    sb.Append("<th width='10%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Alloted Time");
                    sb.Append("</th>");

                    sb.Append("<th width='20%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Booking Date");
                    sb.Append("</th>");

                    sb.Append("<th width='15%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Mobile");
                    sb.Append("</th>");

                    sb.Append("<th width='20%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Address");
                    sb.Append("</th>");
                    sb.Append("</tr>");

                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<tr>");
                        foreach (DataColumn column in dt.Columns)
                        {
                            sb.Append("<td style='text-align:center;font-size:10px'>");
                            sb.Append(row[column]);
                            sb.Append("</td>");
                        }
                        sb.Append("</tr>");
                    }
                    sb.Append("</table>");

                    //Export HTML String as PDF.
                    StringReader sr = new StringReader(sb.ToString());
                    Document pdfDoc = new Document(PageSize.A4, 15f, 15f, 10f, 10f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=Appintment_List " + DateTime.Now.ToShortDateString() + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
        }

        protected void btnRefreshDB_Click(object sender, System.EventArgs e)
        {
            string query = "";
            try
            {
                string connect = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                using (SqlConnection conn = new SqlConnection(connect))
                query = "proc_Hospital_delete_0PatientID_fromAppointment";
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "Database refresh ERROR !!! Please try after some time";
            }
        }

    }
}
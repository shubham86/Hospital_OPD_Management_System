using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital_Reception.cpanel
{
    public partial class OurPatient : System.Web.UI.Page
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
                objDAL.QueryName = "proc_Hospital_OurPatient_fetchInRepeater";
               
                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    rptrPatient.DataSource = DT;
                    rptrPatient.DataBind();
                }
                else
                {
                    rptrPatient.DataSource = null;
                    rptrPatient.DataBind();
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
                objDAL.QueryName = "proc_Hospital_OurPatient_fetchInRepeater";

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

        protected void rptrAdmin_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "history")
            {
                Response.Redirect("PatientHistory.aspx?ID=" + e.CommandArgument);
            }
        }

        protected void ExportToPDF(object sender, EventArgs e)
        {
            //Dummy data for Invoice (Bill).
            DataTable dt = getPatientList();

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sb = new StringBuilder();

                    //Generate Invoice (Bill) Header.
                    sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");
                    sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>Our Patient List</b></td></tr>");
                    sb.Append("<tr><td colspan = '2'></td></tr>");
                    sb.Append("<tr><td></td><td align = 'right'><b>Date: </b>");
                    sb.Append(DateTime.Now);
                    sb.Append(" </td></tr>");
                    sb.Append("</table>");
                    sb.Append("<br />");

                    //Generate Invoice (Bill) Items Grid.
                    sb.Append("<table border = '1' width='100%' >");
                    sb.Append("<tr>");

                    sb.Append("<th width=\"15%\" style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Number");
                    sb.Append("</th>");

                    sb.Append("<th width='25%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Patient Name");
                    sb.Append("</th>");

                    sb.Append("<th width='20%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Age");
                    sb.Append("</th>");
                    
                    sb.Append("<th width='25%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Address");
                    sb.Append("</th>");

                    sb.Append("<th width='15%' style = 'text-align:center;vertical-align:middle;font-size:11px'>");
                    sb.Append("Mobile");
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
                    Response.AddHeader("content-disposition", "attachment;filename=Our_Patients" + DateTime.Now.ToShortDateString() + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
        }
    }
}
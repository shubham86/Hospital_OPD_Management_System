using System;
using System.Configuration;
using System.Data;
using System.Media;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital_Reception.cpanel
{
    public partial class DisplayScreen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                objDAL.QueryName = "proc_Hospital_Appointment_fetchTop5";

                objDAL.SetParameters("@date", "date", DateTime.Now.ToString("yyyy/MM/dd"), 12);

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    lblFirstID.Text = DT.Rows[0]["appointmentID"].ToString();
                    rptrPatient.DataSource = DT;
                    rptrPatient.DataBind();
                }
                else
                {
                    lblBlank.Visible = true;
                    rptrPatient.DataSource = null;
                    rptrPatient.DataBind();
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

        protected void OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemIndex == 0)
            {
                ((Panel)e.Item.FindControl("pnlName")).CssClass = "col-md-10 patient first-patient";
            }
            else if (e.Item.ItemIndex == 1)
            {
                ((Panel)e.Item.FindControl("pnlName")).CssClass = "col-md-10 patient second-patient";
            }
            else
            {
                ((Panel)e.Item.FindControl("pnlName")).CssClass = "col-md-10 patient";
            }
        }

        protected void btnNext_Onclick(object sender,EventArgs e)
        {
            WIHO.BHO objBAL = new WIHO.BHO();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
            objBAL.QueryType = "procedure";
            objBAL.QueryName = "proc_Hospital_Appointment_ChangeStatus";
            try
            {
                if (objBAL.ChangeRecordStatus("@appointmentID", Convert.ToInt32(lblFirstID.Text)))
                {
                    //using (var soundPlayer = new SoundPlayer("assets/bell.wav"))
                    //{
                    //    soundPlayer.Play(); // can also use soundPlayer.PlaySync()
                    //}
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "playAudio()", true);
                    fillRepeater();
                    //anounceFirstPatient();
                    //Console.Beep(5000, 1000);
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
                lblalert.Text = "Unable to change status !!! Please try after some time";
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

                objDAL.SetParameters("@date", "date", DateTime.Now.ToString("yyyy/MM/dd"), 12);

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "playAudio()", true);
                    //SpVoice voice = new SpVoice();
                    //voice.Speak("number " + DT.Rows[0]["sequence"].ToString() + ". " + DT.Rows[0]["patientName"].ToString(), SpeechVoiceSpeakFlags.SVSFlagsAsync);
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = x;
            }
            finally
            {
                objDAL.Dispose();
            }
        }
    }
}
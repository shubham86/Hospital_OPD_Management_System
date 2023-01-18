using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital_Reception.cpanel
{
    public partial class patientprescription : System.Web.UI.Page
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
                if (Request.QueryString["id"] != null)
                {
                    lblPatientID.Text = Request.QueryString["id"].ToString();
                    lblAppointmentID.Text = Request.QueryString["Aid"].ToString();
                }

                fetchPatientDetails();
            }
        }

        private void fetchPatientDetails()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataSet DS = new DataSet();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Patient_fetchDetailsByID";

                objDAL.SetParameters("@patientID", "int", lblPatientID.Text, 10);

                DS = objDAL.FetchDatainDS();

                if (DS.Tables[0].Rows.Count > 0)
                {
                    string c = DS.Tables[0].Rows[0]["lastvisit"].ToString();
                    lblName.Text = DS.Tables[0].Rows[0]["patientName"].ToString();
                    lblAddress.Text = DS.Tables[0].Rows[0]["address"].ToString();
                    lblMobiles.Text = DS.Tables[0].Rows[0]["mobile1"].ToString() + (DS.Tables[0].Rows[0]["mobile2"].ToString() == "-" ? "" : " / " + DS.Tables[0].Rows[0]["mobile2"].ToString());
                    lblPRN.Text = DS.Tables[0].Rows[0]["PRN"].ToString();
                    lblAge.Text = DS.Tables[0].Rows[0]["age"].ToString() + " years " + DS.Tables[0].Rows[0]["gender"].ToString();

                    if (DS.Tables[0].Rows[0]["lastvisit"].ToString() != "Null")
                    {
                        if (Convert.ToDateTime(DS.Tables[0].Rows[0]["lastvisit"].ToString()).ToString("yyyy/dd/MM") == DateTime.Now.ToString("yyyy/dd/MM"))
                        {
                            todayPrescription.Attributes.Add("style","display:none");
                        }
                        lblLastVisit.Text = Convert.ToDateTime(DS.Tables[0].Rows[0]["lastvisit"].ToString()).DayOfWeek + " " + Convert.ToDateTime(DS.Tables[0].Rows[0]["lastvisit"].ToString()).ToString("dd MMM yyyy");

                    }
                    else
                    {
                        oldPrescription.Visible = false;
                    }
                    lblDOR.Text = Convert.ToDateTime(DS.Tables[0].Rows[0]["registerDate"].ToString()).ToString("dd MMM yyyy");
                    imgPatientPhoto.Src = DS.Tables[0].Rows[0]["gender"].ToString() == "Male" ? "../images/male.png" : "../images/female.png";

                }

                if (DS.Tables[1].Rows.Count > 0)
                {
                    DataTable dt = new DataTable();
                    dt = DS.Tables[1];

                    dt.DefaultView.Sort = "bookingDate asc";
                    dt = dt.DefaultView.ToTable();

                    rptrCheckup.DataSource = dt;
                    rptrCheckup.DataBind();
                }
                else
                {
                    rptrCheckup.DataSource = null;
                    rptrCheckup.DataBind();
                }

                if (DS.Tables[2].Rows.Count > 0)
                {
                    rptrHistoryDigno.DataSource = DS.Tables[2];
                    rptrHistoryDigno.DataBind();
                }
                else
                {
                    rptrHistoryDigno.DataSource = null;
                    rptrHistoryDigno.DataBind();
                }

                if (DS.Tables[3].Rows.Count > 0)
                {
                    rptrHistoryMedi.DataSource = DS.Tables[3];
                    rptrHistoryMedi.DataBind();
                }
                else
                {
                    rptrHistoryMedi.DataSource = null;
                    rptrHistoryMedi.DataBind();
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "ERROR to load patient details !!!";
            }
            finally
            {
                objDAL.Dispose();
            }
        }


        [System.Web.Services.WebMethod()]
        public static List<string> fetchOldPrescription(string date, string id)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataSet DS = new DataSet();
            List<string> retval = new List<string>();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_fetchOldPresctiption";

                objDAL.SetParameters("@date", "varchar", date, 15);
                objDAL.SetParameters("@patientID", "int", id, 15);

                DS = objDAL.FetchDatainDS();

                List<string> presc = new List<string>();
                string diagnosis = "";
                string medicine = "";

                if (DS.Tables[0].Rows.Count > 0)
                {                    
                    for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                    {
                        diagnosis += DS.Tables[0].Rows[i]["diagnosis"].ToString() + "$";
                    }
                    presc.Add(diagnosis.Remove(diagnosis.Length - 1));
                }

                if (DS.Tables[1].Rows.Count > 0)
                {
                    for (int i = 0; i < DS.Tables[1].Rows.Count; i++)
                    {
                        medicine += "<div class=\"col-lg-6 align-left\"><span>" + DS.Tables[1].Rows[i]["medicineName"].ToString() + "</span></div>" +
                                    "<div class=\"col-lg-3 align-center\"><span>" + DS.Tables[1].Rows[i]["morning"].ToString() + "-" + DS.Tables[1].Rows[i]["afternoon"].ToString() + "-" + DS.Tables[1].Rows[i]["evening"].ToString() + "-" + DS.Tables[1].Rows[i]["night"].ToString() + "</span></div>" +
                                    "<div class=\"col-lg-3 align-center\"><span>" + DS.Tables[1].Rows[i]["days"].ToString() + " days</span></div> $";
                    }
                    presc.Add(medicine.Remove(medicine.Length - 1));
                }

                presc.Add(date);
                return presc;
                
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

        [System.Web.Services.WebMethod()]
        public static string fetchAllDiagnosis()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_getActiveDiagnosis";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    string diagnosis = "";
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        diagnosis += DT.Rows[i]["diagnosis"].ToString() + "$";
                    }
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        diagnosis += DT.Rows[i]["diagnosisID"].ToString() + "$";
                    }
                    return diagnosis.Remove(diagnosis.Length - 1);
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

        [System.Web.Services.WebMethod()]
        public static string searchDiagnosis(string txt)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_searchDiagnosis";

                objDAL.SetParameters("@searchText", "varchar", txt, 100);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    string diagnosis = "";
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        diagnosis += DT.Rows[i]["diagnosis"].ToString() + "$";
                    }
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        diagnosis += DT.Rows[i]["diagnosisID"].ToString() + "$";
                    }
                    return diagnosis.Remove(diagnosis.Length - 1);
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

        [System.Web.Services.WebMethod()]
        public static string insertDiagnosis(string txt)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_insertDiagnosis";

                objDAL.SetParameters("@diagnosisName", "nvarchar", txt, 150);

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    return DT.Rows[0]["id"].ToString();
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
        
        [System.Web.Services.WebMethod()]
        public static string insertMedicine(string txt)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_insertMedicine";

                objDAL.SetParameters("@medicineName", "varchar", txt, 150);

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    return DT.Rows[0]["id"].ToString();
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
        
        [System.Web.Services.WebMethod()]
        public static string insertAdvice(string txt)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_insertAdvice";

                objDAL.SetParameters("@advice", "nvarchar", txt, 300);

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    return DT.Rows[0]["id"].ToString();
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

        [System.Web.Services.WebMethod()]
        public static string fetchAllMedicines()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_getActiveMedicines";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    string medicine = "";
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        medicine += DT.Rows[i]["medicineName"].ToString() + "$";
                    }
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        medicine += DT.Rows[i]["medicineID"].ToString() + "$";
                    }
                    return medicine.Remove(medicine.Length - 1);
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

        [System.Web.Services.WebMethod()]
        public static string searchMedicines(string txt)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_searchMedicines";

                objDAL.SetParameters("@searchText", "varchar", txt, 100);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    string medicine = "";
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        medicine += DT.Rows[i]["medicineName"].ToString() + "$";
                    }
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        medicine += DT.Rows[i]["medicineID"].ToString() + "$";
                    }
                    return medicine.Remove(medicine.Length - 1);
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

        [System.Web.Services.WebMethod()]
        public static string fetchAllAdvice()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_getActiveAdvice";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    string advice = "";
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        advice += DT.Rows[i]["advice"].ToString() + "$";
                    }
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        advice += DT.Rows[i]["adviceID"].ToString() + "$";
                    }
                    return advice.Remove(advice.Length - 1);
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

        [System.Web.Services.WebMethod()]
        public static string searchAdvice(string txt)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_searchAdvice";

                objDAL.SetParameters("@searchText", "nvarchar", txt, 100);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    string advice = "";
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        advice += DT.Rows[i]["advice"].ToString() + "$";
                    }
                    for (int i = 0; i < DT.Rows.Count; i++)
                    {
                        advice += DT.Rows[i]["adviceID"].ToString() + "$";
                    }
                    return advice.Remove(advice.Length - 1);
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

        [System.Web.Services.WebMethod()]
        public static string btnSaveClick(string id,string diagnosis, string medicine, string morning, string afternoon, string evening, string night, string dose, string days, string advice, string appoId)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            string retval = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_Hospital_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_Hospital_Prescription_Save";

                objDAL.SetParameters("@patientID", "int", id, 20);
                objDAL.SetParameters("@diagno", "nvarchar", diagnosis, 700);
                objDAL.SetParameters("@medi", "varchar", medicine, 500);
                objDAL.SetParameters("@morn", "varchar", morning, 100);
                objDAL.SetParameters("@noon", "varchar", afternoon, 100);
                objDAL.SetParameters("@even", "varchar", evening, 100);
                objDAL.SetParameters("@ngt", "varchar", night, 100);
                objDAL.SetParameters("@de", "varchar", days, 100);
                objDAL.SetParameters("@dos", "nvarchar", dose, 100);
                objDAL.SetParameters("@adv", "nvarchar", advice, 700);
                objDAL.SetParameters("@date", "datetime", DateTime.Now.ToString(), 100);
                objDAL.SetParameters("@appoID", "int", appoId, 20);

                if (objDAL.IUDData())
                {
                    return "Success";
                }
                else
                {
                    objDAL.Dispose();
                    return "Prescription not save successfully ! try again .";
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                // return "Prescription not save successfully ! try again .";
                return x;
            }
            finally
            {
                objDAL.Dispose();
            }
        }
    }
}
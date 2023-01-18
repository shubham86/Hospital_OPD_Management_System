using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital_Reception.cpanel
{
    public partial class MasterCP : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.Cookies["role"] != null)
                {
                    
                    if (Request.Cookies["role"].Value == "admin")
                    {
                        admin.Visible = true;
                        img1.Visible = true;
                        holiday.Visible = true;
                        ourPatient.Visible = true;
                        oldPatient.Visible = true;
                        master.Visible = true;
                        medicinesentry.Visible = true;
                    }
                    else
                    {
                        img2.Visible = true;
                    }

                    lblAdminName.Text = Request.Cookies["AdminName"].Value;
                    lblRole.Text = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Request.Cookies["role"].Value.ToLower());
                }                
            }            
        }
    }
}
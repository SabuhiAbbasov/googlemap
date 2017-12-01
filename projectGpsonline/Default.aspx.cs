using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Services;

namespace projectGpsonline
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateLocation();
            }
        }

        private void PopulateLocation()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString))
            {
                string query = "Select * from Locations";
                SqlCommand cmd = new SqlCommand(query, con);
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                dt.Load(cmd.ExecuteReader());
            }

            ddFrom.DataSource = dt;
            ddFrom.DataTextField = "LocName";
            ddFrom.DataValueField = "LocID";
            ddFrom.DataBind();

            ddTo.DataSource = dt;
            ddTo.DataTextField = "LocName";
            ddTo.DataValueField = "LocID";
            ddTo.DataBind();
        }

        [WebMethod]
        public static string GetDirection(string from, string to)
        {
            string returnVal = "";
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetDirection", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@LocFrom", from);
                cmd.Parameters.AddWithValue("@LocTo", to);
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                dt.Load(cmd.ExecuteReader());
            }
            returnVal = "from: " + dt.Rows[0]["FromLoc"].ToString() + "to: " + dt.Rows[0]["ToLoc"].ToString();
            return returnVal;
        }
    }
}
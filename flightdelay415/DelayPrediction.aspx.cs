using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace flightdelay415
{
    public partial class DelayPrediction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadLists(); 
        }

        protected void loadLists()
        {
            //DDL for Airlines
            SqlConnection cn = new SqlConnection("Server=tcp:is415ss.database.windows.net,1433;Initial Catalog=flightdelayDB415;Persist Security Info=False;User ID=cashbyu1;Password=zx3R$cmcvnqwurhgpsud;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            SqlCommand cmd;            
            SqlDataReader dr;
            ListItem li;
            cn.Open();
            cmd = new SqlCommand("SELECT * FROM Airlines", cn);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                li = new ListItem(dr["AIRLINE"].ToString(), dr["IATA_CODE"].ToString());
                ddlAirline.Items.Add(li);
            }
            dr.Close();
            ddlAirline.DataBind();
            cn.Close();

            //DDL for Airports
            cn.Open();
            cmd = new SqlCommand("SELECT IATA_CODE, AIRPORT FROM Airports", cn);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                li = new ListItem(dr["AIRPORT"].ToString(), dr["IATA_CODE"].ToString());
                ddlOriginAirport.Items.Add(li);
                ddlDestinationAirport.Items.Add(li);
            }
            dr.Close();
            ddlOriginAirport.DataBind();
            ddlDestinationAirport.DataBind();
            cn.Close();
        }

    }
}
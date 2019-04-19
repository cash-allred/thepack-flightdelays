using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace flightdelay415
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadListsFB();
        }

        protected void loadListsFB()
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
                ddlAirlineFB.Items.Add(li);
            }
            dr.Close();
            ddlAirlineFB.DataBind();
            cn.Close();

            //DDL for Airports
            cn.Open();
            cmd = new SqlCommand("SELECT IATA_CODE, AIRPORT FROM Airports", cn);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                li = new ListItem(dr["AIRPORT"].ToString(), dr["IATA_CODE"].ToString());
                ddlOriginAirportFB.Items.Add(li);
                ddlDestinationAirportFB.Items.Add(li);
            }
            dr.Close();
            ddlOriginAirportFB.DataBind();
            ddlDestinationAirportFB.DataBind();
            cn.Close();

            //DDL for Day of the month
            for (int i = 1; i < 32; i++)
            {
                li = new ListItem(i.ToString(), i.ToString());
                ddlDayFB.Items.Add(li);
            }
            ddlDayFB.DataBind();
        }

        protected void btnFeedback_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection("Server=tcp:is415ss.database.windows.net,1433;Initial Catalog=flightdelayDB415;Persist Security Info=False;User ID=cashbyu1;Password=zx3R$cmcvnqwurhgpsud;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            SqlCommand cmd;
            cmd = new SqlCommand("INSERT INTO Flights (AIRLINE, ORIGIN_AIRPORT, DESTINATION_AIRPORT, MONTH, DAY, DAY_OF_WEEK, SCHEDULED_DEPARTURE, SCHEDULED_ARRIVAL, DEPARTURE_TIME, ARRIVAL_TIME) VALUES ('" + ddlAirlineFB.SelectedValue.ToString() + "', '" + ddlOriginAirportFB.SelectedValue.ToString() + "', '" + ddlDestinationAirportFB.SelectedValue.ToString() + "', " + ddlMonthFB.SelectedValue + ", " + ddlDayFB.SelectedValue + ", " + ddlDayOfWeekFB.SelectedValue + ", " + tbScheduledDepartureFB.Text + ", " + tbScheduledArrivalFB.Text + ", " + tbActualDepartureFB.Text + ", " + tbActualArrivalFB.Text + ");", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblThanks.Text = "Thank you for your feedback!";
        }
    }
}
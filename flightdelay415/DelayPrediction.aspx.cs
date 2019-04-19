using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using RestSharp;
using Newtonsoft.Json.Linq;

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

            //DDL for Day of the month
            for (int i = 1; i < 32; i++)
            {
                li = new ListItem(i.ToString(), i.ToString());
                ddlDay.Items.Add(li);
            }
            ddlDay.DataBind();
        }

        protected void btnPrediction_Click(object sender, EventArgs e)
        {
            double dArrivalDelay;
            double dArrivalDelay2;
            //from postman arrival
            var client = new RestClient("https://ussouthcentral.services.azureml.net/workspaces/e1fc1ce7a0a943dd84acf96dedd87e36/services/6b0753c6291e42fc9f0a69022523f7d2/execute?api-version=2.0&details=true");
            var request = new RestRequest(Method.POST);
            request.AddHeader("Postman-Token", "36ed43b1-9333-4207-a5b9-f6fca2fbff7b");
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("Content-Type", "application/json");
            request.AddHeader("Authorization", "Bearer HrRqJqteFg5qRK4bbLlJnXUrgBqnQ+jzkGA+Podj3SKAbZlKl0viH1nbu7XL1U8nS5am0MOPW4OvX6IkxGvT9w==");
            request.AddParameter("undefined", "{\r\n  \"Inputs\": {\r\n    \"input1\": {\r\n      \"ColumnNames\": [\r\n        \"MONTH\",\r\n        \"DAY\",\r\n        \"DAY_OF_WEEK\",\r\n        \"AIRLINE\",\r\n        \"ORIGIN_AIRPORT\",\r\n        \"DESTINATION_AIRPORT\",\r\n        \"SCHEDULED_ARRIVAL\",\r\n        \"ARRIVAL_DELAY\"\r\n      ],\r\n      \"Values\": [\r\n        [\r\n          \"" + ddlMonth.SelectedValue + "\",\r\n          \"" + ddlDay.SelectedValue + "\",\r\n          \"" + ddlDayOfWeek.SelectedValue + "\",\r\n          \"" + ddlAirline.SelectedValue + "\",\r\n          \"" + ddlOriginAirport.SelectedValue + "\",\r\n          \"" + ddlDestinationAirport.SelectedValue + "\",\r\n          \"" + tbScheduledArrival.Text + "\",\r\n          \"0\"\r\n        ]\r\n      ]\r\n    }\r\n  }\r\n}", ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);

            //from postman departure
            var client2 = new RestClient("https://ussouthcentral.services.azureml.net/workspaces/e1fc1ce7a0a943dd84acf96dedd87e36/services/a6f6741a6cb9431c8c4648ed271cdf0b/execute?api-version=2.0&details=true");
            var request2 = new RestRequest(Method.POST);
            request2.AddHeader("Postman-Token", "636710f4-c88c-4b59-9fb5-36f4bca23fd9");
            request2.AddHeader("cache-control", "no-cache");
            request2.AddHeader("Content-Type", "application/json");
            request2.AddHeader("Authorization", "Bearer qY3f8t+/EzYBIk7grkxTXdtC6ZGiil2w4tbm6W7K2i5QmFR/Y/tbmOH37sApa4tAL+MTZkAO47qpopTJj3ZsLA==");
            request2.AddParameter("undefined", "{\r\n  \"Inputs\": {\r\n    \"input1\": {\r\n      \"ColumnNames\": [\r\n        \"MONTH\",\r\n        \"DAY\",\r\n        \"DAY_OF_WEEK\",\r\n        \"AIRLINE\",\r\n        \"ORIGIN_AIRPORT\",\r\n        \"DESTINATION_AIRPORT\",\r\n        \"SCHEDULED_DEPARTURE\",\r\n        \"DEPARTURE_DELAY\"\r\n      ],\r\n      \"Values\": [\r\n        [\r\n          \"" + ddlMonth.SelectedValue + "\",\r\n          \"" + ddlDay.SelectedValue + "\",\r\n          \"" + ddlDayOfWeek.SelectedValue + "\",\r\n          \"" + ddlAirline.SelectedValue + "\",\r\n          \"" + ddlOriginAirport.SelectedValue + "\",\r\n          \"" + ddlDestinationAirport.SelectedValue + "\",\r\n          \"" + tbScheduledDeparture.Text + "\",\r\n          \"0\"\r\n        ]\r\n      ]\r\n    }\r\n  }\r\n}", ParameterType.RequestBody);
            IRestResponse response2 = client2.Execute(request2);

            //parse out the reponse
            var results = JObject.Parse(response.Content.ToString());
            var results2 = JObject.Parse(response2.Content.ToString());

            string arrivalDelay = results["Results"]["output1"]["value"]["Values"][0][0].ToString();
            string arrivalDelay2 = results2["Results"]["output1"]["value"]["Values"][0][0].ToString();

            dArrivalDelay = Convert.ToDouble(arrivalDelay);
            dArrivalDelay2 = Convert.ToDouble(arrivalDelay2);

            decimal d1 = Math.Round(Convert.ToDecimal(dArrivalDelay), 1);
            decimal d2 = Math.Round(Convert.ToDecimal(dArrivalDelay2), 1);

            lblArrivalPrediction.Text = d1.ToString() + " minutes";
            lblDeparturePrediction.Text = d2.ToString() + " minutes";

            //document.getElementById('about').scrollIntoView(true);
            ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#signup';", true);
        }
    }
}
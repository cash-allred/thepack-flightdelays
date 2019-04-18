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
            for (int i = 0; i < 31; i++)
            {
                li = new ListItem(i.ToString(), i.ToString());
                ddlDay.Items.Add(li);
            }
            ddlDay.DataBind();
        }

        protected void btnPrediction_Click(object sender, EventArgs e)
        {
            //from postman
            var client = new RestClient("https://ussouthcentral.services.azureml.net/workspaces/e1fc1ce7a0a943dd84acf96dedd87e36/services/6b0753c6291e42fc9f0a69022523f7d2/execute?api-version=2.0&details=true");
            var request = new RestRequest(Method.POST);
            request.AddHeader("Postman-Token", "36ed43b1-9333-4207-a5b9-f6fca2fbff7b");
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("Content-Type", "application/json");
            request.AddHeader("Authorization", "Bearer HrRqJqteFg5qRK4bbLlJnXUrgBqnQ+jzkGA+Podj3SKAbZlKl0viH1nbu7XL1U8nS5am0MOPW4OvX6IkxGvT9w==");
            request.AddParameter("undefined", "{\r\n  \"Inputs\": {\r\n    \"input1\": {\r\n      \"ColumnNames\": [\r\n        \"MONTH\",\r\n        \"DAY\",\r\n        \"DAY_OF_WEEK\",\r\n        \"AIRLINE\",\r\n        \"ORIGIN_AIRPORT\",\r\n        \"DESTINATION_AIRPORT\",\r\n        \"SCHEDULED_ARRIVAL\",\r\n        \"ARRIVAL_DELAY\"\r\n      ],\r\n      \"Values\": [\r\n        [\r\n          \"5\",\r\n          \"22\",\r\n          \"2\",\r\n          \"AA\",\r\n          \"SLC\",\r\n          \"PHX\",\r\n          \"1436\",\r\n          \"0\"\r\n        ]\r\n      ]\r\n    }\r\n  }\r\n}", ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);

            //parse out the reponse
            var results = JObject.Parse(response.Content.ToString());
            string arrivalDelay = results["Results"]["output1"]["value"]["Values"][0][0].ToString();
            lblArrivalPrediction.Text = arrivalDelay;

            //document.getElementById('about').scrollIntoView(true);
            ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#about';", true);
        }
    }
}
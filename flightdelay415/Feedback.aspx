<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="flightdelay415.Feedback" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>

  <title>Flight Delay Predictor</title>

  <!-- Bootstrap core CSS -->
  <link href="core.css" rel="stylesheet"/>
    
  <!-- Custom fonts for this template -->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet"/>

  <!-- Custom styles for this template -->
  <link href="custom.css" rel="stylesheet"/>
</head>
<body id="page-top">
    <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="#page-top">Home</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        Menu
        <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="DelayPrediction.aspx#about">Make a Prediction</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="DelayPrediction.aspx#projects">Flight Data Dashboards</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="DelayPrediction.aspx#signup">Results</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#">Report Feedback</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- Arrival Recommender Section -->
  <section id="feedback" class="about-section text-center">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 mx-auto">
          <h2 class="text-white mb-4">Submit Feedback</h2>
          <p class="text-white-50">Your input is essential to make our algorithm smarter.
              <br /><br />
              Please fill out the form to record how close our prediction was.</p>
        </div>
      </div>
        <form id="form2" runat="server">
            <div>
                <asp:DropDownList ID="ddlAirlineFB" runat="server" CssClass="btn btn-light js-scroll-trigger" style="max-width: 250px;">
                    <asp:ListItem>Airline</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlOriginAirportFB" runat="server" CssClass="btn btn-light js-scroll-trigger" style="max-width: 400px;">
                    <asp:ListItem>Origin Airport</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlDestinationAirportFB" runat="server" CssClass="btn btn-light js-scroll-trigger" style="max-width: 400px;">
                    <asp:ListItem>Destination Airport</asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
                <asp:DropDownList ID="ddlMonthFB" runat="server" CssClass="btn btn-light js-scroll-trigger">
                    <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">June</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlDayFB" runat="server" CssClass="btn btn-light js-scroll-trigger">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlDayOfWeekFB" runat="server" CssClass="btn btn-light js-scroll-trigger">
                    <asp:ListItem Value="1">Sunday</asp:ListItem>
                    <asp:ListItem Value="2">Monday</asp:ListItem>
                    <asp:ListItem Value="3">Tuesday</asp:ListItem>
                    <asp:ListItem Value="4">Wednesday</asp:ListItem>
                    <asp:ListItem Value="5">Thursday</asp:ListItem>
                    <asp:ListItem Value="6">Friday</asp:ListItem>
                    <asp:ListItem Value="7">Saturday</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:DropDownList ID="ddlArrivalTimeFB" runat="server" CssClass="btn btn-primary js-scroll-trigger">
                    <asp:ListItem Value="1400">2:00PM</asp:ListItem>
                </asp:DropDownList>--%>
                <br />
                <br />
                <!--Scheduled time-->
                <asp:TextBox ID="tbScheduledDepartureFB" runat="server" CssClass="form-control" style="max-width: 250px; display:inline-block; margin-left:auto; margin-right: auto;" placeholder="Scheduled Departing Time (2400)"></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="requiredvScheduledDepartureFB" runat="server" ErrorMessage="Please enter a value" ControlToValidate="tbScheduledDepartureFB" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="rvScheduledDepartureFB" runat="server" ControlToValidate="tbScheduledDepartureFB" ErrorMessage="Enter a time in military format (1400)" MaximumValue="2400" MinimumValue="1" Type="integer" ForeColor="Red"></asp:RangeValidator>
                <br />
                <asp:TextBox ID="tbScheduledArrivalFB" runat="server" CssClass="form-control " style="max-width: 250px; display:inline-block; margin-left:auto; margin-right: auto;" placeholder="Scheduled Arriving Time (2400)"></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2FB" runat="server" ErrorMessage="Please enter a value" ControlToValidate="tbScheduledArrivalFB" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="rvScheduledArrivalFB" runat="server" ControlToValidate="tbScheduledArrivalFB" ErrorMessage="Enter a time in military format (1400)" MaximumValue="2400" MinimumValue="1" Type="integer" ForeColor="Red"></asp:RangeValidator>     
                <br />
                <br />
                <!--actual time-->
                <asp:TextBox ID="tbActualDepartureFB" runat="server" CssClass="form-control" style="max-width: 250px; display:inline-block; margin-left:auto; margin-right: auto;" placeholder="Actual Departing Time (2400)"></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1FB" runat="server" ErrorMessage="Please enter a value" ControlToValidate="tbScheduledDepartureFB" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="RangeValidator1FB" runat="server" ControlToValidate="tbScheduledDepartureFB" ErrorMessage="Enter a time in military format (1400)" MaximumValue="2400" MinimumValue="1" Type="integer" ForeColor="Red"></asp:RangeValidator>
                <br />
                <asp:TextBox ID="tbActualArrivalFB" runat="server" CssClass="form-control " style="max-width: 250px; display:inline-block; margin-left:auto; margin-right: auto;" placeholder="Actual Arriving Time (2400)"></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3FB" runat="server" ErrorMessage="Please enter a value" ControlToValidate="tbScheduledArrivalFB" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="RangeValidator2FB" runat="server" ControlToValidate="tbScheduledArrivalFB" ErrorMessage="Enter a time in military format (1400)" MaximumValue="2400" MinimumValue="1" Type="integer" ForeColor="Red"></asp:RangeValidator>     
                <br /><br />
                <asp:Button ID="btnFeedback" runat="server" Text="Submit" CssClass="btn btn-primary js-scroll-trigger" OnClick="btnFeedback_Click"/>
                <br />
                <br />
                <br /><br /><br /><br /><br /><br /><br /><br /><br />
            </div>
          </form>
<!--<img src="img/ipad.png" class="img-fluid" alt="">-->
    </div>
      <asp:Label ID="lblThanks" runat="server" Text=""></asp:Label>
  </section>
</body>
</html>

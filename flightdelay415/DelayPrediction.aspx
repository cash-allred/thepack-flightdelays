<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DelayPrediction.aspx.cs" Inherits="flightdelay415.DelayPrediction" %>

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
            <a class="nav-link js-scroll-trigger" href="#about">Make a Prediction</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#projects">Flight Data Dashboards</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#signup">Results</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="Feedback.aspx">Report Feedback</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Header -->
  <header class="masthead">
    <div class="container d-flex h-100 align-items-center">
      <div class="mx-auto text-center">
        <h1 class="mx-auto my-0 text-uppercase">Flight Delay Predictor</h1>
        <h2 class="text-white mx-auto mt-2 mb-5">Plan ahead as you compare layovers, time your arrival for meetings, or optimize your flight home</h2>
        <a href="#about" class="btn btn-primary js-scroll-trigger">Get Started</a>
      </div>
    </div>
  </header>

  <!-- Arrival Recommender Section -->
  <section id="about" class="about-section text-center">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 mx-auto">
          <h2 class="text-white mb-4">Arrival Prediction</h2>
          <p class="text-white-50">Our regression model uses thousands of flights to predict how close a flight's arrival time will be to the scheduled arrival.
              <br /><br />
              You may find this helpful when evaluating how much time you would like to have at a particular layover, or if you are on a schedule to get to 
              a meeting.</p>
        </div>
      </div>
      <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="ddlAirline" runat="server" CssClass="btn btn-light js-scroll-trigger" style="max-width: 250px;">
                <asp:ListItem>Airline</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlOriginAirport" runat="server" CssClass="btn btn-light js-scroll-trigger" style="max-width: 400px;">
                <asp:ListItem>Origin Airport</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlDestinationAirport" runat="server" CssClass="btn btn-light js-scroll-trigger" style="max-width: 400px;">
                <asp:ListItem>Destination Airport</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:DropDownList ID="ddlMonth" runat="server" CssClass="btn btn-light js-scroll-trigger">
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
            <asp:DropDownList ID="ddlDay" runat="server" CssClass="btn btn-light js-scroll-trigger">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlDayOfWeek" runat="server" CssClass="btn btn-light js-scroll-trigger">
                <asp:ListItem Value="1">Sunday</asp:ListItem>
                <asp:ListItem Value="2">Monday</asp:ListItem>
                <asp:ListItem Value="3">Tuesday</asp:ListItem>
                <asp:ListItem Value="4">Wednesday</asp:ListItem>
                <asp:ListItem Value="5">Thursday</asp:ListItem>
                <asp:ListItem Value="6">Friday</asp:ListItem>
                <asp:ListItem Value="7">Saturday</asp:ListItem>
            </asp:DropDownList>
            <%--<asp:DropDownList ID="ddlArrivalTime" runat="server" CssClass="btn btn-primary js-scroll-trigger">
                <asp:ListItem Value="1400">2:00PM</asp:ListItem>
            </asp:DropDownList>--%>
            <br />
            <br />
            <asp:TextBox ID="tbScheduledDeparture" runat="server" CssClass="form-control" style="max-width: 200px; display:inline-block; margin-left:auto; margin-right: auto;" placeholder="Departing Time (2400)"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="requiredvScheduledDeparture" runat="server" ErrorMessage="Please enter a value" ControlToValidate="tbScheduledDeparture" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvScheduledDeparture" runat="server" ControlToValidate="tbScheduledDeparture" ErrorMessage="Enter a time in military format (1400)" MaximumValue="2400" MinimumValue="1" Type="integer" ForeColor="Red"></asp:RangeValidator>
            <br />
            <asp:TextBox ID="tbScheduledArrival" runat="server" CssClass="form-control " style="max-width: 200px; display:inline-block; margin-left:auto; margin-right: auto;" placeholder="Arriving Time (2400)"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter a value" ControlToValidate="tbScheduledArrival" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvScheduledArrival" runat="server" ControlToValidate="tbScheduledArrival" ErrorMessage="Enter a time in military format (1400)" MaximumValue="2400" MinimumValue="1" Type="integer" ForeColor="Red"></asp:RangeValidator>     
            <br />
            <br />
            <asp:Button ID="btnPrediction" runat="server" Text="Predict" CssClass="btn btn-primary js-scroll-trigger" OnClick="btnPrediction_Click"/>
            <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
        </div>
      </form>
      <!--<img src="img/ipad.png" class="img-fluid" alt="">-->
    </div>
  </section>

  <!-- Projects Section -->
  <section id="projects" class="projects-section bg-light">
    <div class="container">
        <!-- Featured Project Row -->
      <div class="row align-items-center no-gutters mb-auto mb-lg-5">
        <div class="col-xl-10 col-lg-7">
          <!--tableau arrival-->
            <div class='tableauPlaceholder' id='viz1555611820907' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ar&#47;Arrivals_15556117889090&#47;Arrivals&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='Arrivals_15556117889090&#47;Arrivals' /><param name='tabs' value='yes' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ar&#47;Arrivals_15556117889090&#47;Arrivals&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='filter' value='publish=yes' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1555611820907');                    var vizElement = divElement.getElementsByTagName('object')[0];                    vizElement.style.width='1000px';vizElement.style.height='850px';                    var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
        </div>
        <div class="col-xl-2 col-lg-5">
          <div class="featured-text text-center text-lg-left">
            <h4>Arrival Data</h4>
            <p class="text-black-50 mb-0">Leverage the live Tableau dashboard to visulaize your flight data. </p>
          </div>
        </div>
      </div>

      <div class="row align-items-center no-gutters mb-auto mb-lg-5">
        <div class="col-xl-10 col-lg-7">
          <!--tableau arrival-->
          <div class='tableauPlaceholder' id='viz1555611873451' style='position: relative;'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;De&#47;Departures_15556115531240&#47;Departures&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='Departures_15556115531240&#47;Departures' /><param name='tabs' value='yes' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;De&#47;Departures_15556115531240&#47;Departures&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='filter' value='publish=yes' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1555611873451');                    var vizElement = divElement.getElementsByTagName('object')[0];                    vizElement.style.width='1000px';vizElement.style.height='850px';                    var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
        </div>
        <div class="col-xl-2 col-lg-5">
           <div class="featured-text text-center text-lg-left">
             <h4>Departure Data</h4>
             <p class="text-black-50 mb-0">Interact with beautifully displayed and filterable data of flight departures </p>
           </div>
        </div>
      </div>


     <%-- <!-- Project One Row -->
      <div class="row justify-content-center no-gutters mb-5 mb-lg-0">
        <div class="col-lg-6">
          <img class="img-fluid" src="img/demo-image-01.jpg" alt="">
        </div>
        <div class="col-lg-6">
          <div class="bg-black text-center h-100 project">
            <div class="d-flex h-100">
              <div class="project-text w-100 my-auto text-center text-lg-left">
                <h4 class="text-white">Misty</h4>
                <p class="mb-0 text-white-50">An example of where you can put an image of a project, or anything else, along with a description.</p>
                <hr class="d-none d-lg-block mb-0 ml-0">
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Project Two Row -->
      <div class="row justify-content-center no-gutters">
        <div class="col-lg-6">
          <img class="img-fluid" src="img/demo-image-02.jpg" alt="">
        </div>
        <div class="col-lg-6 order-lg-first">
          <div class="bg-black text-center h-100 project">
            <div class="d-flex h-100">
              <div class="project-text w-100 my-auto text-center text-lg-right">
                <h4 class="text-white">Mountains</h4>
                <p class="mb-0 text-white-50">Another example of a project with its respective description. These sections work well responsively as well, try this theme on a small screen!</p>
                <hr class="d-none d-lg-block mb-0 mr-0">
              </div>
            </div>
          </div>
        </div>
      </div>--%>

    </div>
  </section>

  <!-- Signup Section -->
  <section class="signup-section" id="signup">
    <div class="container" >
      <div class="row">
        <div class="col-md-10 col-lg-8 mx-auto text-center">

          <i class="far fa-paper-plane fa-2x mb-2 text-white"></i>
            <br />
            <br />
            <h2 class="text-white mb-5">Takeoff of your flight will likly be delayed*:</h2>
            <h2><asp:Label ID="lblDeparturePrediction" runat="server" CssClass="text-white mb-5" Text=""></asp:Label></h2>
            <br />
            <br />
            <h2 class="text-white mb-5">Your arrival will likely be delayed*:</h2>
            <h2><asp:Label ID="lblArrivalPrediction" runat="server" CssClass="text-white mb-5" Text=""></asp:Label></h2>
            <br />
            <br />
            <a href="#about" class="btn btn-primary js-scroll-trigger">Predict Another Flight</a>
            <br />
            <br />
            <p class="text-white-50">*Calculated in minutes. <br />
                A positive number represents a delay while a negative number represents being early. <br />
                Our algorithm has an RMSE score of 38, meaning our prediction is most likely within 38 minutes within the true arrival time, depending on other variables such as weather.
            </p>
            <br />
            <br />
            <br />
          <%--<form class="form-inline d-flex">
            <input type="email" class="form-control flex-fill mr-0 mr-sm-2 mb-3 mb-sm-0" id="inputEmail" placeholder="Enter email address...">
            <button type="submit" class="btn btn-primary mx-auto">Subscribe</button>
          </form>--%>
        </div>
      </div>
    </div>
  </section>

 
     <!-- Contact Section 
  <section class="contact-section bg-black">
    <div class="container">
 
        <div class="row">

        <div class="col-md-4 mb-3 mb-md-0">
          <div class="card py-4 h-100">
            <div class="card-body text-center">
              <i class="fas fa-map-marked-alt text-primary mb-2"></i>
              <h4 class="text-uppercase m-0">Address</h4>
              <hr class="my-4">
              <div class="small text-black-50">4923 Market Street, Orlando FL</div>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-3 mb-md-0">
          <div class="card py-4 h-100">
            <div class="card-body text-center">
              <i class="fas fa-envelope text-primary mb-2"></i>
              <h4 class="text-uppercase m-0">Email</h4>
              <hr class="my-4">
              <div class="small text-black-50">
                <a href="#">hello@yourdomain.com</a>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-3 mb-md-0">
          <div class="card py-4 h-100">
            <div class="card-body text-center">
              <i class="fas fa-mobile-alt text-primary mb-2"></i>
              <h4 class="text-uppercase m-0">Phone</h4>
              <hr class="my-4">
              <div class="small text-black-50">+1 (555) 902-8832</div>
            </div>
          </div>
        </div>
      </div>

      <div class="social d-flex justify-content-center">
        <a href="#" class="mx-2">
          <i class="fab fa-twitter"></i>
        </a>
        <a href="#" class="mx-2">
          <i class="fab fa-facebook-f"></i>
        </a>
        <a href="#" class="mx-2">
          <i class="fab fa-github"></i>
        </a>
      </div>
    </div>
  </section>      -->

  <!-- Footer -->
  <footer class="bg-black small text-center text-white-50">
    <div class="container">
      Copyright &copy; PACK Consulting - Parker Frame, Autumn Clark, Cash Allred, Katrina Peterson
    </div>
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="scripts/jquery.js"></script>
  <script src="scripts/bundle.js"></script>

  <!-- Plugin JavaScript -->
  <script src="scripts/jquery-easing.js"></script>

  <!-- Custom scripts for this template -->
  <script src="scripts/grayscale.js"></script>

</body>
</html>

<!doctype html>
<html lang="en">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">


<%
    String userName = request.getParameter("userName");
    System.out.println("userName::::::::::::::"+userName);
    if(userName ==null ||  userName.isEmpty()){
        userName = "-";
    }
%>
<head>
    <meta charset="utf-8"/>
    <link rel="apple-touch-icon" sizes="76x76" href="../../assets/img/apple-icon.png">
    <link rel="icon" type="image/png" sizes="96x96" href="../../assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>ADWIZE</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>--%>


    <link href="../../assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="../../css/executiveDashboard.css" rel="stylesheet"/>
    <link href="../../css/speaking.css" rel="stylesheet"/>
    <link href="../../css/writing.css" rel="stylesheet"/>
    <link href="../../css/listening.css" rel="stylesheet">
    <link href="../../css/reading.css" rel="stylesheet">


    <!--  Paper Dashboard core CSS    -->
    <link href="../../assets/css/paper-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="../../assets/css/demo.css" rel="stylesheet"/>


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href="../../assets/css/themify-icons.css" rel="stylesheet">



</head>

<body>
<div class="wrapper">
    <div class="sidebar" data-background-color="brown" data-active-color="danger">
        <!--
            Tip 1: you can change the color of the sidebar's background using: data-background-color="white | brown"
            Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
        -->
        <div class="logo">
            <a href="http://www.creative-tim.com" class="simple-text logo-mini">
                BT
            </a>
            <a href="http://www.creative-tim.com" class="simple-text logo-normal">

            </a>

            <div class="logo-name">ADWIZE</div>
            <div class="project-title">Overseas Education Consultancy</div>
        </div>
        <div class="sidebar-wrapper">
            <div class="user">
                <div class="info">
                    <div class="photo">
                        <img src="../../assets/img/faces/face-1.jpg"/>
                    </div>

                    <a data-toggle="collapse" href="#collapseExample" class="collapsed">
                        <span></span><%=userName%><b class="caret"></b></span>
                    </a>
                    <div class="clearfix"></div>

                    <div class="collapse" id="collapseExample">
                        <ul class="nav">
                            <li>
                                <a href="#profile">
                                    <span class="sidebar-mini">Mp</span>
                                    <span class="sidebar-normal">My Profile</span>
                                </a>
                            </li>
                            <li>
                                <a href="#settings">
                                    <span class="sidebar-mini">S</span>
                                    <span class="sidebar-normal">Settings</span>
                                </a>
                            </li>
                            <li>
                                <a href="#decide">
                                    <span class="sidebar-mini">L</span>
                                    <span class="sidebar-normal logout">Logout</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <%--Dashboard changes--%>

            <ul class="nav">


                <%--<li class="active">
                    <a data-toggle="collapse" href="#dashboardOverview" aria-expanded="true">
                        <i class="ti-panel"></i>
                        <p>Excel Speaking
                            <b class="caret"></b>
                        </p>
                    </a>
                    <div class="collapse in" id="componentsExamples">
                        <ul class="nav">
                            <li class="active">
                                <div class="speaking-page read_aloud">
                                    &lt;%&ndash;<span class="sidebar-mini">icon - </span>&ndash;%&gt;
                                    <span class="sidebar-normal">Read aloud</span>
                                </div>
                            </li>
                            <li>
                                <div class="speaking-page repeat_sentence">
                                   &lt;%&ndash; <span class="sidebar-mini">icon - </span>&ndash;%&gt;
                                    <span class="sidebar-normal">Repeat sentence</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>--%>


                <li class="active">
                    <a data-toggle="collapse" href="#componentsExamples">
                        <i class="ti-panel"></i>
                        <p>Speaking
                            <b class="caret"></b>
                        </p>
                    </a>
                    <div class="collapse" id="componentsExamples">
                        <ul class="nav">
                            <li>
                                <div class="speaking-page read_aloud">
                                    <span class="sidebar-mini">RA - </span>
                                    <span class="sidebar-normal">Read aloud</span>
                                </div>
                            </li>
                            <li>
                                <div class="speaking-page repeat_sentence">
                                    <span class="sidebar-mini">RS - </span>
                                    <span class="sidebar-normal">Repeat sentence</span>
                                </div>
                            </li>
                            <li>
                                <div class="speaking-page describe_image">
                                    <span class="sidebar-mini">DI - </span>
                                    <span class="sidebar-normal">Describe image</span>
                                </div>
                            </li>
                            <li>
                                <div class="speaking-page retell_lecture">
                                    <span class="sidebar-mini">RL - </span>
                                    <span class="sidebar-normal">Re-tell lecture</span>
                                </div>
                            </li>
                            <li>
                                <div class="speaking-page short-question">
                                    <span class="sidebar-mini">ASQ - </span>
                                    <span class="sidebar-normal">Answer short question</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>


                <%--  <li>
                      <a data-toggle="collapse" href="#formsExamples">
                          <i class="ti-package"></i>
                          <p>Writing
                              <b class="caret"></b>
                          </p>
                      </a>
                      <div class="collapse" id="formsExamples">
                          <ul class="nav">
                              <li>
                                  <div class="writing-page summarizeWrittenText">
                                      <span class="sidebar-mini">SWT- </span>
                                      <span class="sidebar-normal">Summarize written text</span>
                                  </div>
                              </li>
                          </ul>
                      </div>
                  </li>--%>

                <li class="active">
                    <a data-toggle="collapse" href="#tablesExamples">
                        <i class="ti-clipboard"></i>
                        <p>Writing
                            <b class="caret"></b>
                        </p>
                    </a>
                    <div class="collapse" id="tablesExamples">
                        <ul class="nav">
                            <li>
                                <div class="writing-page summarizeWrittenText">
                                    <span class="sidebar-mini">SWT-</span>
                                    <span class="sidebar-normal">Summarize written text</span>
                                </div>
                            </li>
                        </ul>
                        <ul class="nav">
                            <li>
                                <div class="writing-page writeEssay">
                                    <span class="sidebar-mini">WE-</span>
                                    <span class="sidebar-normal">Write essay</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>





                <li class="active">
                    <a data-toggle="collapse" href="#mapsExamples">
                        <i class="ti-clipboard"></i>
                        <p>Reading
                            <b class="caret"></b>
                        </p>
                    </a>
                    <div class="collapse" id="mapsExamples">
                        <ul class="nav">
                            <li>
                                <div class="reading-page ra-choose-single-answer">
                                    <span class="sidebar-mini">CSA-</span>
                                    <span class="sidebar-normal">Choose single answer</span>
                                </div>
                            </li>
                        </ul>
                        <ul class="nav">
                            <li>
                                <div class="reading-page ra-choose-multiple-answer">
                                    <span class="sidebar-mini">CMA-</span>
                                    <span class="sidebar-normal">Choose multiple answer</span>
                                </div>
                            </li>
                        </ul>
                        <ul class="nav">
                            <li>
                                <div class="reading-page read-and-write-fill-in-the-blanks">
                                    <span class="sidebar-mini">FITB-</span>
                                    <span class="sidebar-normal">Fill in the blanks</span>
                                </div>
                            </li>
                        </ul>
                        <ul class="nav">
                            <li>
                                <div class="reading-page re-order-paragarph">
                                    <span class="sidebar-mini">ROP-</span>
                                    <span class="sidebar-normal">Re-order paragraph</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="active">
                    <%--<a data-toggle="collapse" href="#dashboardOverview" &lt;%&ndash;aria-expanded="true"&ndash;%&gt; >
                        <i class="ti-panel"></i>
                        <p>Listening
                            <b class="caret"></b>
                        </p>
                    </a>--%>
                    <a data-toggle="collapse" href="#formsExamples">
                        <i class="ti-bar-chart-alt"></i>
                        <p>Listening
                            <b class="caret"></b>
                        </p>
                    </a>

                    <div class="collapse" id="formsExamples">
                        <ul class="nav">
                            <li class="active">
                                <div class="listening-page summarize_spoken_text">
                                    <span class="sidebar-mini">SST -</span>
                                    <span class="sidebar-normal ">Summarize spoken text</span>
                                </div>
                            </li>

                            <li>
                                <div class="listening-page choose-multiple-answers">
                                    <span class="sidebar-mini">MC -</span>
                                    <span class="sidebar-normal">choose multiple answers</span>
                                </div>
                            </li>


                            <li>
                                <div class="listening-page fill-in-the-blanks">
                                    <span class="sidebar-mini">LFIB -</span>
                                    <span class="sidebar-normal">Fill in the blanks</span>
                                </div>
                            </li>

                            <li>
                                <div class="listening-page highlight-correct-summary">
                                    <span class="sidebar-mini">HCS -</span>
                                    <span class="sidebar-normal">Highlight correct summary</span>
                                </div>
                            </li>

                            <li>
                                <div class="listening-page choose-single-answer">
                                    <span class="sidebar-mini">CSA -</span>
                                    <span class="sidebar-normal">Choose single answer</span>
                                </div>
                            </li>

                            <li>
                                <div class="listening-page select-missing-words">
                                    <span class="sidebar-mini">SMW -</span>
                                    <span class="sidebar-normal">Select missing words</span>
                                </div>
                            </li>

                            <li>
                                <div class="listening-page highlight-incorrect-words">
                                    <span class="sidebar-mini">HIC -</span>
                                    <span class="sidebar-normal">Highlight incorrect words</span>
                                </div>
                            </li>


                            <li>
                                <div class="listening-page  write-from-dictation">
                                    <span class="sidebar-mini">WFD -</span>
                                    <span class="sidebar-normal">Write from dictation</span>
                                </div>
                            </li>


                        </ul>
                    </div>
                </li>




            </ul>
        </div>
        </li>
        </ul>
    </div>
</div>

<div class="col-md-12 header oec-header">
    <div class="col-md-2"> </div>
    <div class="col-md-10 oce-header-details">

        <form class="navbar-form navbar-left navbar-search-form" role="search">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-search"></i></span>
                <input type="text" value="" class="form-control" placeholder="Search...">
            </div>
        </form>

        <div class="settings">
            <a href="#settings" class="btn-rotate oce-settings">
                <i class="ti-settings"></i>
                <p class="hidden-md hidden-lg">
                    Settings
                </p>
            </a>
        </div>

        <div class="loginDetails"><i class="fas fa-user"></i><%=userName%></div>
    </div>
</div>

<div class="main-panel">



    <nav class="navbar navbar-default">

        <div class="container-fluid">

            <%-- <div class="navbar-minimize">
                 <button id="minimizeSidebar" class="btn btn-fill btn-icon"><i class="ti-more-alt"></i></button>
             </div>
             <div class="navbar-header">
                 <button type="button" class="navbar-toggle">
                     <span class="sr-only">Toggle navigation</span>
                     <span class="icon-bar bar1"></span>
                     <span class="icon-bar bar2"></span>
                     <span class="icon-bar bar3"></span>
                 </button>
                 <a class="navbar-brand" href="#Dashboard">
                     Overview
                 </a>
             </div>--%>

            <%--<div class="collapse navbar-collapse">

                <form class="navbar-form navbar-left navbar-search-form" role="search">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-search"></i></span>
                        <input type="text" value="" class="form-control" placeholder="Search...">
                    </div>
                </form>

                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#stats" class="dropdown-toggle btn-magnify" data-toggle="dropdown">
                            <i class="ti-panel"></i>
                            <p>Stats</p>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="#notifications" class="dropdown-toggle btn-rotate" data-toggle="dropdown">
                            <i class="ti-bell"></i>
                            <span class="notification">5</span>
                            <p class="hidden-md hidden-lg">
                                Notifications
                                <b class="caret"></b>
                            </p>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="#not1">Notification 1</a></li>
                            <li><a href="#not2">Notification 2</a></li>
                            <li><a href="#not3">Notification 3</a></li>
                            <li><a href="#not4">Notification 4</a></li>
                            <li><a href="#another">Another notification</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#settings" class="btn-rotate">
                            <i class="ti-settings"></i>
                            <p class="hidden-md hidden-lg">
                                Settings
                            </p>
                        </a>
                    </li>
                </ul>
            </div>--%>

            <div class="oec-main">
                <div class="content-header-title">ADWIZE</div>
                <div class="content-header-content">Overseas Education Consultancy</div>
                <div class="about-header">PTE Academic</div>
                <div class="about-description">
                    PTE Academic is a 3 hour long, computer-based assessment of a person's English language ability in an academic context.
                    The test assesses an individual's communicative skills of Reading, Writing, Listening and Speaking skills
                    through questions using authentically-sourced material. In addition, the test provides feedback on enabling
                    skills in the form of Oral Fluency, Grammar, Vocabulary, Written Discourse, Pronunciation and Spelling.
                </div>
            </div>



        </div>
    </nav>

    <%--<div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-3 col-sm-6">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-xs-5">
                                    <div class="icon-big icon-warning text-center">
                                        <i class="ti-server"></i>
                                    </div>
                                </div>
                                <div class="col-xs-7">
                                    <div class="numbers">
                                        <p>Capacity</p>
                                        105GB
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <hr/>
                            <div class="stats">
                                <i class="ti-reload"></i> Updated now
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-xs-5">
                                    <div class="icon-big icon-success text-center">
                                        <i class="ti-wallet"></i>
                                    </div>
                                </div>
                                <div class="col-xs-7">
                                    <div class="numbers">
                                        <p>Revenue</p>
                                        $1,345
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <hr/>
                            <div class="stats">
                                <i class="ti-calendar"></i> Last day
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-xs-5">
                                    <div class="icon-big icon-danger text-center">
                                        <i class="ti-pulse"></i>
                                    </div>
                                </div>
                                <div class="col-xs-7">
                                    <div class="numbers">
                                        <p>Errors</p>
                                        23
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <hr/>
                            <div class="stats">
                                <i class="ti-timer"></i> In the last hour
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-xs-5">
                                    <div class="icon-big icon-info text-center">
                                        <i class="ti-twitter-alt"></i>
                                    </div>
                                </div>
                                <div class="col-xs-7">
                                    <div class="numbers">
                                        <p>Followers</p>
                                        +45
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <hr/>
                            <div class="stats">
                                <i class="ti-reload"></i> Updated now
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-sm-6">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-xs-7">
                                    <div class="numbers pull-left">
                                        $34,657
                                    </div>
                                </div>
                                <div class="col-xs-5">
                                    <div class="pull-right">
												<span class="label label-success">
		 											+18%
												</span>
                                    </div>
                                </div>
                            </div>
                            <h6 class="big-title">total earnings <span class="text-muted">in last</span> ten <span
                                    class="text-muted">quarters</span></h6>
                            <div id="chartTotalEarnings"></div>
                        </div>
                        <div class="card-footer">
                            <hr>
                            <div class="footer-title">Financial Statistics</div>
                            <div class="pull-right">
                                <button class="btn btn-info btn-fill btn-icon btn-sm">
                                    <i class="ti-plus"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-xs-7">
                                    <div class="numbers pull-left">
                                        169
                                    </div>
                                </div>
                                <div class="col-xs-5">
                                    <div class="pull-right">
												<span class="label label-danger">
		 											-14%
												</span>
                                    </div>
                                </div>
                            </div>
                            <h6 class="big-title">total subscriptions <span class="text-muted">in last</span> 7 days
                            </h6>
                            <div id="chartTotalSubscriptions"></div>
                        </div>
                        <div class="card-footer">
                            <hr>
                            <div class="footer-title">View all members</div>
                            <div class="pull-right">
                                <button class="btn btn-default btn-fill btn-icon btn-sm">
                                    <i class="ti-angle-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="card">
                        <div class="card-content">
                            <div class="row">
                                <div class="col-xs-7">
                                    <div class="numbers pull-left">
                                        8,960
                                    </div>
                                </div>
                                <div class="col-xs-5">
                                    <div class="pull-right">
												<span class="label label-warning">
		 											~51%
												</span>
                                    </div>
                                </div>
                            </div>
                            <h6 class="big-title">total downloads <span class="text-muted">in last</span> 6 years</h6>
                            <div id="chartTotalDownloads"></div>
                        </div>
                        <div class="card-footer">
                            <hr>
                            <div class="footer-title">View more details</div>
                            <div class="pull-right">
                                <button class="btn btn-success btn-fill btn-icon btn-sm">
                                    <i class="ti-info"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-sm-6">
                    <div class="card card-circle-chart" data-background-color="blue">
                        <div class="card-header text-center">
                            <h5 class="card-title">Dashboard</h5>
                            <p class="description">Monthly sales target</p>
                        </div>
                        <div class="card-content">
                            <div id="chartDashboard" class="chart-circle" data-percent="70">70%</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card card-circle-chart" data-background-color="green">
                        <div class="card-header text-center">
                            <h5 class="card-title">Orders</h5>
                            <p class="description">Completed</p>
                        </div>
                        <div class="card-content">
                            <div id="chartOrders" class="chart-circle" data-percent="34">34%</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card card-circle-chart" data-background-color="orange">
                        <div class="card-header text-center">
                            <h5 class="card-title">New Visitors</h5>
                            <p class="description">Out of total number</p>
                        </div>
                        <div class="card-content">
                            <div id="chartNewVisitors" class="chart-circle" data-percent="62">62%</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card card-circle-chart" data-background-color="brown">
                        <div class="card-header text-center">
                            <h5 class="card-title">Subscriptions</h5>
                            <p class="description">Monthly newsletter</p>
                        </div>
                        <div class="card-content">
                            <div id="chartSubscriptions" class="chart-circle" data-percent="10">10%</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>--%>



    <%--<footer class="footer">
        <div class="container-fluid">
            <nav class="pull-left">
                <ul>
                    <li>
                        <a href="http://www.creative-tim.com">
                            Creative Tim
                        </a>
                    </li>
                    <li>
                        <a href="http://blog.creative-tim.com">
                            Blog
                        </a>
                    </li>
                    <li>
                        <a href="http://www.creative-tim.com/license">
                            Licenses
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="copyright pull-right">
                &copy;
                <script>document.write(new Date().getFullYear())</script>
                , made with <i class="fa fa-heart heart"></i> by <a href="http://www.creative-tim.com">Creative Tim</a>
            </div>
        </div>
    </footer>--%>


</div>
</div>

<div class="load-audio">
    <audio class="loader" controls>
        <source class="loader" src="../../resource/loader/load.mp3" type="audio/ogg">
    </audio>
</div>

<div class="col-md-12 footer oec-footer">
    <div class="col-md-2"> </div>
    <div class="col-md-10 oce-footer-details">
        <div class="copyright-oce">Copyright &copy; 2019 <a href="http://adwize.co.in">www.adwize.co.in</a> All rights reserved.</div>
        <%--<div class="copyright-oce">Copyright &copy; 2019 <a href="www.overseaseducationconsultancy.com">www.overseaseducationconsultancy.com</a> All rights reserved.</div>--%>
        <%--<div class="designer">Designed by : <a href="https://www.facebook.com/praveeno.range.12">Praveen Kuber</a></div>--%>
    </div>
</div>



</body>


<!--   Core JS Files. Extra: TouchPunch for touch library inside jquery-ui.min.js   -->
<%--<script src="../../assets/js/jquery-3.1.1.min.js" type="text/javascript"></script>
<script src="../../assets/js/jquery-ui.min.js" type="text/javascript"></script>--%>



<%--
<script src="../../assets/js/perfect-scrollbar.min.js" type="text/javascript"></script>
<script src="../../assets/js/bootstrap.min.js" type="text/javascript"></script>
--%>




<%--
<script src="src/recorder.js"></script>
<script src="src/Fr.voice.js"></script>--%>

<%--<script src="js/jquery.js"></script>--%>

<%--<script src="js/app.js"></script>--%>

<%--<script src="//code.jquery.com/jquery-1.12.4.js"></script>--%>




<%--Clicking--%>
<script src="../../js/listening/listening.js"></script>
<%--<script src="../../js/speaking/speaking.js"></script>
<script src="../../js/speaking/repeatSentence.js"></script>
<script src="../../js/speaking/describeImage.js"></script>
<script src="../../js/speaking/retellLecture.js"></script>
<script src="../../js/speaking/shortQuestion.js"></script>
<script src="../../js/writing/summarizeWrittenText.js"></script>
<script src="../../js/writing/writeEssay.js"></script>
<script src="../../js/listening/writeFromDictation.js"></script>
<script src="../../js/listening/chooseMultipleAnswers.js"></script>
<script src="../../js/listening/highlightCorrectSummary.js"></script>
<script src="../../js/listening/chooseSingleAnswer.js"></script>
<script src="../../js/listening/selectMissingWord.js"></script>
<script src="../../js/listening/hightlightIncorrectWords.js"></script>
<script src="../../js/listening/fillInTheBlanks.js"></script>

<script src="../../js/reading/readingChooseSingleAnswer.js"></script>
<script src="../../js/reading/readingChooseMultipleAnswer.js"></script>
<script src="../../js/reading/readingFillInTheBlanks.js"></script>--%>


<script src="../../js/reading/reOrderParagraph.js"></script>









<%--
<script type="text/javascript">
    $(document).ready(function () {
        demo.initOverviewDashboard();
        demo.initCirclePercentage();

    });
</script>--%>

</html>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Clippings</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet" media="screen">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- This file store project specific CSS -->
    <link href="static/css/custom.css" rel="stylesheet">
    <link href="static/css/lightbox.css" rel="stylesheet">
    <link href="static/css/sweet-alert.css" rel="stylesheet">
    <link href="static/css/jquery-ui-1.10.3.custom.css" rel="stylesheet">
    <link href="static/css/bootstrap-switch.css" rel="stylesheet" media="screen">

    <script src="static/ckeditor/ckeditor.js"></script>

  </head>

  <body>

    <!---    modal window    --->
    <cfinclude template="_inc_modal.cfm"/>

    <div class="navbar navbar-inverse navbar-fixed-top" style="opacity:0.95;">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/fw1/clipping">Clippings SIP</a>
        </div>
        <div class="collapse navbar-collapse">

          <form class="navbar-form navbar-left" role="form" >
            <div class="form-group right-inner-addon">
              <i class="glyphicon glyphicon-search"></i>
              <input type="text" class="form-control" name="q" id="q"
               placeholder="Busca" onkeyup="javascript: ajaxBusca();"/>
            </div>
          </form>

          <ul class="nav navbar-nav navbar-right">
            <!-- dropdown relatórios-->
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Options <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Something</a></li>
              </ul>
            </li>

            <!-- Login/logout -->
<!-------------------------------------------------------------
           {% if user.is_authenticated %}
            <!-- <li class="navbar-text">Welcome, {{ user.username }}!</li> -->
            <li><a href="{% url 'logout">Logout de <b>{{ user.username }}</b></a></li>
           {% else %}
            <li><a href="{% url 'login">Login</a></li>
           {% endif %}
--------------------------------------------------------------->

          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <!-- container -->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="col-sm-1" id="div_lefttCol">
            <br/>
            <!-------------------------------------------------------------

                            <div class="well" id="divMenuCategorias"> <!-- class="well sidebar-nav" -->
                                <div id="divListaCategorias">


                                </div>
                            </div><!--/.well -->

            --------------------------------------------------------------->
            </div><!--/ right col-->

            <!-- ********************  main body ********************  -->
            <div class="col-sm-8" id="div_body">

                <h2><strong>FW/1 Clipping System</strong></h2>

                <cfoutput>#body#</cfoutput>


            </div>
            <!-- ********************  /main body ********************  -->

              <!-- menu lateral direito-->
<!-------------------------------------------------------------
              {% if user.is_authenticated %}
                <div class="col-sm-3" id="div_righttCol">
                  <p>
                    {% block menu_block %}
                    {% endblock %}
                </div><!-- /menu lateral direito -->
              {% endif %}
--------------------------------------------------------------->

        </div><!--/row-->
    </div><!--/.fluid-container-->
    <!-- <hr> -->
    <!-- footer -->
    <footer>
        <div class="container">
            <!-- <p>&copy; Copyright ...</p> -->
        </div>
    </footer>

    <!-- Le javascript
    ================================================== -->
    <!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
    <script src="static/js/jquery-2.1.0.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/bootstrap-switch.js"></script>
    <script src="static/js/lightbox-2.6.min.js"></script>
    <script src="static/js/jquery.sticky.js"></script>
    <script src="static/js/jquery-ui-1.10.3.custom.js"></script>
    <script src="static/js/clipping.js"></script>
    <script src="static/js/sweet-alert.js"></script>

  </body>
</html>

<br/>
<br/>
<br/>

<!-------------------------------------------------------------
<cfdump var="#rc#"
  label="Request Context">

--------------------------------------------------------------->

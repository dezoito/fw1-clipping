<CFSILENT>
<!----------------------------------------------------

Copyright ©2001, Macromedia, Inc. & Allaire Corporation.
All rights reserved.

CLIENT: Allaire/Macromedia

CUSTOM TAG: Flash UI Calendar Custom Tag
TEMPLATE: uicalendar.cfm


HISTORY:
DATE		USER			ACTION
10/26/2000	Dave Gallerizzo	Startd builind tag

17/07/2001  - coloquei valor default no campo
							e alterei o tamanho deste para 10


DESCRIPTION:
This custom tag is used to call a file that loads
a Flash date picker application.  Once a user picks
their date this file will copy the appropriate data
to a passed in formfield.


======= Variables =======
VARIABLES:
SCOPE.NAME				DESCRIPTION
Attributes.FormField	Name of FormField to put
						date information into.
						REQUIRED

Attributes.Width		Width of DIV/Layer to hold
						date picker movie
						REQUIRED

Attributes.Height		Height of DIV/Layer to hold
						date picker movie
						REQUIRED

Attributes.Month		Numeric value of Month for
						default date for picker
						OPTIONAL

Attributes.Day			Numeric value of Day for
						default date for picker
						OPTIONAL

Attributes.Year			Numeric value of Year for
						default date for picker
						OPTIONAL

Attributes.stFormatting	Structure variable containing
						genric formatting attributes
						OPTIONAL


JAVASCRIPTS:
FUNCTION		PARAMETERS		DESCRIPTION


OTHER INFORMATION:

---------------------------------------------------->
</CFSILENT>
<CFSET CurrentTag = "Calendar">




<CFINCLUDE TEMPLATE="#request.uitoolkitCFpath#templates/uitoolkitinitialize.cfm">




<CFSILENT>

<!---  Set parameters to allow multiple instances of the calculator--->
<CFSET request.uitoolkitstatus.calendar.instanceid = request.uitoolkitstatus.calendar.instanceid + 1>
<CFSET ErrorCodeStub = "UItCalendar">
<CFSET OkHandler = "UIt#Variables.CurrentTag#OK#request.uitoolkitstatus.calendar.instanceid#">
<CFSET CancelHandler = "UIt#Variables.CurrentTag#Cancel#request.uitoolkitstatus.calendar.instanceid#">
<CFSET DataHandler = "">

<META NAME="generator" CONTENT="Allaire HomeSite 4.0">

<!---  Autoset some default parameters --->
<CFPARAM NAME="Attributes.FormField" default="">
<CFPARAM NAME="Attributes.Width" 	default="">
<CFPARAM NAME="Attributes.Height" default="">
<CFPARAM NAME="Attributes.stFormatting" default="#structnew()#">
<CFPARAM NAME="attributes.zindex" default="100">
<CFPARAM NAME="attributes.id" default="calendarpopup#request.uitoolkitstatus.calendar.instanceid#">
<CFPARAM NAME="attributes.Message" default="Invalid Date Format">
<CFPARAM NAME="attributes.popup" default="Yes">
<CFPARAM NAME="attributes.Required" default="no">

<!---  Autoset some tag specific parameters --->
<CFPARAM name="Attributes.Month" default="#month(now())#">
<CFPARAM name="Attributes.Day" default="#day(now())#">
<CFPARAM name="Attributes.Year" default="#year(now())#">
<CFPARAM name="Attributes.DateFormat" default="date">


<CFPARAM name="Attributes.currBdrColor" default="">
<CFPARAM name="Attributes.currFillColor" default="">
<CFPARAM name="Attributes.currTxtColor" default="">
<CFPARAM name="Attributes.selBdrColor" default="##AABB0011">
<CFPARAM name="Attributes.selFillColor" default="">
<CFPARAM name="Attributes.selTxtColor" default="">
<CFPARAM name="Attributes.otherFillColor" default="">
<CFPARAM name="Attributes.otherTxtColor" default="">
<CFPARAM name="Attributes.dayTxtFont" default="">





<!--- Call included file to check and set aspect ratio for movie --->
<CFTRY>
	<CFINCLUDE TEMPLATE="#request.uitoolkitCFpath#templates/aspectratioset.cfm">
	<CFCATCH TYPE="toolkit.aspectRatio">
		<CFTHROW Message="#CFCATCH.Message#"
				 ErrorCode="#CFCATCH.Errorcode#"
 				 Type="toolkit.AspectRatioError">
    </CFCATCH>
</CFTRY>

<!--- Call custom tag to set stformatting variables into memory --->
<CFTRY>
	<CFINCLUDE TEMPLATE="#request.uitoolkitCFpath#templates/stformatset.cfm">
	<CFCATCH TYPE="toolkit.stFormatting">
		<CFTHROW Message="#CFCATCH.Message#"
				 ErrorCode="#CFCATCH.Errorcode#"
 				 Type="toolkit.stFormattingError">
    </CFCATCH>
</CFTRY>

<!---  Test to see if required parameters are present
		if not throw a custom exception --->
<CFIF Attributes.FormField is "">
	<CFTHROW Message="Missing required parameter Formfield"
			 ErrorCode="UICAL-200"
			 Type="toolkit.missingattribute">
</cfif>

<CFIF Attributes.Required is not "yes" AND Attributes.Required is not "no">
	<CFTHROW Message="Parameter required must be set to 'yes' or 'no'"
			 ErrorCode="UICal-201"
			 Type="toolkit.missingattribute">
</cfif>

<!---  Test to see if a proper date is present
		if not throw a custom exception --->
<CFIF not isDate("#Attributes.Month#/#Attributes.Day#/#Attributes.Year#")>
	<CFTHROW Message="Invalid Date"
			 ErrorCode="UICAL-202"
 			 Type="toolkit.invaliddate">
</cfif>

<CFIF attributes.Dateformat is not "date" AND attributes.Dateformat is not "eurodate">
	<CFTHROW Message="Invalid Date format mask.  Valid masks are 'date' or 'eurodate'"
			 ErrorCode="UICAL-203"
 			 Type="toolkit.invaliddate">
</cfif>



<!--- Tag Specific attributes --->
<CFLOCK Name="TagSpecific" TIMEOUT="2">
	<CFSCRIPT>
	 server.datastruct[variables.UUID].FormField = Attributes.FormField;
	 server.datastruct[variables.UUID].Month = Attributes.Month;
	 server.datastruct[variables.UUID].Day = Attributes.Day;
	 server.datastruct[variables.UUID].Year = Attributes.Year;
	 server.datastruct[variables.UUID].currBdrColor = Attributes.currBdrColor;
	 server.datastruct[variables.UUID].currFillColor = Attributes.currFillColor;
	 server.datastruct[variables.UUID].currTxtColor = Attributes.currTxtColor;
	 server.datastruct[variables.UUID].selBdrColor = Attributes.selBdrColor;
	 server.datastruct[variables.UUID].selFillColor = Attributes.selFillColor;
	 server.datastruct[variables.UUID].selTxtColor = Attributes.selTxtColor;
	 server.datastruct[variables.UUID].otherFillColor = Attributes.otherFillColor;
	 server.datastruct[variables.UUID].otherTxtColor = Attributes.otherTxtColor;
	 server.datastruct[variables.UUID].dayTxtFont = Attributes.dayTxtFont;
	</CFSCRIPT>
</CFLOCK>
</CFSILENT>

<CFOUTPUT>

<CFIF cgi.user_agent contains "MSIE">
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
<!--
	// Clicking on the OK button in the Flash calendar
	// will call the function ok in javascript.  This
	// function will fill in the formfield with the
	// chosen date and hide the layer or DIV

	function #variables.OkHandler#(objname,month,day,year){
		<CFIF Attributes.DateFormat is "date">
		  document.all[objname].value = month+"/"+day+"/"+year;
		<CFELSE>
		  document.all[objname].value = day+"/"+month+"/"+year;
		</CFIF>
		<CFIF attributes.popup>
		document.all.#attributes.id#.style.display='none';
		unhideformelements();
		</cfif>
	}

	// Clicking on the OK button in the Flash calendar
	// will call the function cancel in javascript.  This
	// function will simply hide the layer or DIV

	function #Variables.CancelHandler#(objname,month,day,year){
		<CFIF attributes.popup>
			document.all.#attributes.id#.style.display='none';
			unhideformelements();
		</cfif>
	}

//-->
</SCRIPT>

	<!--- Create a formfield with the name of the passed in FormField attribute --->

	<CFIF attributes.popup><!--- Use a button for the calendar popup --->

			<!---		passamos uma data default ???		 --->
			<cfif IsDefined("Attributes.value")>
				<cfset value="#Attributes.value#">
			<cfelse>
				<cfset value="">
			</cfif>

	<CFINPUT TYPE="Text"
			NAME="#Attributes.FormField#"
			MESSAGE="#Attributes.Message#"
			VALIDATE="#Attributes.DateFormat#"
			REQUIRED="#Attributes.Required#"
			VALUE="#value#"
			SIZE="10">

			<IMG align="top"  hspace="0" width="32" height="24" vspace="0" SRC="#request.uitoolkitsupportpath#templates/date.gif" BORDER="0" onClick="<CFIF cgi.user_agent does not contain "Mac" and cgi.user_agent does not contain "MSIE 4.0">detectCollision(document.all.#attributes.id#);</CFIF>  document.all.#attributes.id#.style.display=''" alt="Click here to popup a date selector">
	<cfelse>
			<INPUT Type="hidden" name="#Attributes.FormField#">
	</cfif>
	<!--- mac compatibility layer --->
    <CFIF cgi.user_agent contains "Mac">
		 <div  ID="#attributes.id#"
		 		<CFIF attributes.popup>
					Style="position:absolute ;display:none;z-index:#attributes.zindex#"
				<CFELSE>
					Style="position:absolute;z-index:#attributes.zindex#" </cfif>>
				<EMBED src="#request.uitoolkitsupportpath#swf/calendar.swf?CallBackUrl=#urlencodedformat(variables.CallBackURL)#"
			 		quality=high
					WIDTH=#Attributes.Width#
					HEIGHT=#Attributes.Height#
					SCALE="exactfit"
					TYPE="application/x-shockwave-flash"
					PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
				</EMBED>
		 </div>
	<CFELSE>

<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---SIM
DEBBUGIN
#request.uitoolkitsupportpath#
<BR>
#request.uitoolkitsupportpath#swf/calendar.swf?CallBackUrl=
<BR>
#urlencodedformat(variables.CallBackURL)#
<BR><BR>
#HtmlEditFormat(variables.CallBackURL)#
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
		<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			 ID="#attributes.id#"
			 codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=5,0,0,0"
			 WIDTH=#Attributes.Width#
			 HEIGHT=#Attributes.Height#
			<CFIF attributes.popup>
				Style="position:absolute;display:none;z-index=#attributes.zindex#"
			<CFELSE>
				Style="position:absolute;z-index=#attributes.zindex#"
			</CFIF>
		>
		<PARAM NAME=movie VALUE="#request.uitoolkitsupportpath#swf/calendar.swf?CallBackUrl=#urlencodedformat(variables.CallBackURL)#">
		<PARAM NAME=quality VALUE=high>
		<PARAM NAME=scale value=exactfit>
		 <CFIF attributes.popup>
		 	<PARAM NAME=wmode VALUE=Opaque>
		 <CFELSE>
			<PARAM NAME=wmode VALUE=Transparent>
		 </CFIF>
	</OBJECT>




 	</CFIF>
<CFELSE>

		<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
		<!--
			// Clicking on the OK button in the Flash calendar
			// will call the function ok in javascript.  This
			// function will fill in the formfield with the
			// chosen date and hide the layer or DIV

			function #variables.OkHandler#(objname,month,day,year){
				<CFIF Attributes.DateFormat is "date">
				 document.forms[0].#attributes.FormField#.value = month+"/"+day+"/"+year;
				<CFELSE>
				 document.forms[0].#attributes.FormField#.value = day+"/"+month+"/"+year;
				</CFIF>
				<CFIF attributes.popup>
				document.calendarpopup#request.uitoolkitstatus.calendar.instanceid#.visibility='hide';
				unhideformelements();
				</cfif>
			}

			// Clicking on the OK button in the Flash calendar
			// will call the function cancel in javascript.  This
			// function will simply hide the layer or DIV

			function #Variables.CancelHandler#(objname,month,day,year){
				<CFIF attributes.popup>
					document.calendarpopup#request.uitoolkitstatus.calendar.instanceid#.visibility='hide';
					//unhideformelements();
				</cfif>
			}

		//-->
		</SCRIPT>

		<CFIF attributes.popup>

			<!---		passamos uma data default ???		 --->
			<cfif IsDefined("Attributes.value")>
				<cfset value="#Attributes.value#">
			<cfelse>
				<cfset value="">
			</cfif>

			<CFINPUT TYPE="Text"
				NAME="#Attributes.FormField#"
				MESSAGE="#Attributes.Message#"
				VALIDATE="#Attributes.DateFormat#"
				REQUIRED="#Attributes.Required#"
				VALUE="#value#"
				SIZE="10"
				>

			<!--- Create a formfield with the name of the passed in FormField attribute --->
			<!--- Use a button for the calendar popup --->
			<A HREF="javascript:void(0)" onClick="document.calendarpopup#request.uitoolkitstatus.calendar.instanceid#.visibility='show'; document.calendarpopup#request.uitoolkitstatus.calendar.instanceid#.moveTo(event.x+30,event.y);"><IMG align="top" SRC="#request.uitoolkitsupportpath#templates/date.gif" BORDER="0"></a>
			<CFSET Visibility = "hide">
			<CFSET Position = "position:positioned; position:absolute;">
		<cfelse>
			<INPUT Type="hidden" name="#Attributes.FormField#">
			<CFSET Visibility = "show">
			<CFSET Position = "position: relative;">
		</cfif>

		<CFIF cgi.user_agent does not contain "Mac">
		<!--- Build a Netscape layer for the Flash movie--->
		 <CFIF attributes.popup>
		 <CFHTMLHEAD TEXT='
		  <div ID="calendarpopup#request.uitoolkitstatus.calendar.instanceid#"
  			  style="#variables.position# height: #attributes.height#px; width: #attributes.width#px; clip: rect(0 #attributes.width# #attributes.height# 0); visibility: #variables.visibility#; z-index:30">
				 <EMBED SRC="#request.uitoolkitsupportpath#swf/calendar.swf?CallBackUrl=#urlencodedformat(variables.CallBackURL)#"
				        WIDTH=#Attributes.Width#
				        HEIGHT=#Attributes.Height#
				        AUTOSTART=true
				        QUALITY="high"
						SCALE="exactfit"
					    TYPE="application/x-shockwave-flash"
				        PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">

		  </div>'>
		  <CFELSE>
		  	<div ID="calendarpopup#request.uitoolkitstatus.calendar.instanceid#"
  			  style="#variables.position# height: #attributes.height#px; width: #attributes.width#px; clip: rect(0 #attributes.width# #attributes.height# 0); visibility: #variables.visibility#; z-index:30">
				 <EMBED SRC="#request.uitoolkitsupportpath#swf/calendar.swf?CallBackUrl=#urlencodedformat(variables.CallBackURL)#"
				        WIDTH=#Attributes.Width#
				        HEIGHT=#Attributes.Height#
				        AUTOSTART=true
				        QUALITY="high"
						SCALE="exactfit"
					    TYPE="application/x-shockwave-flash"
				        PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">

		  	</div>
		  </CFIF>
		<CFELSE>
		 <CFIF attributes.popup>
		 <CFHTMLHEAD TEXT='
			  <div ID="calendarpopup#request.uitoolkitstatus.calendar.instanceid#"
  				  style="#variables.position# height: #attributes.height#px; width: #attributes.width#px; top: -#attributes.height#px; clip: rect(0 #attributes.width# #attributes.height# 0); visibility: #variables.visibility#; z-index:30">
				<EMBED SRC="#request.uitoolkitsupportpath#swf/calendar.swf?CallBackUrl=#urlencodedformat(variables.CallBackURL)#"
				       WIDTH="#Attributes.Width#"
				       HEIGHT="#Attributes.Height#"
				       STYLE="visibility: hide;"
				       QUALITY="high"
					   SCALE="exactfit"
   		     		   TYPE="application/x-shockwave-flash"
   	    			   PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
   			  </div>'>
		  <CFELSE>
			  <div ID="calendarpopup#request.uitoolkitstatus.calendar.instanceid#"
  				  style="#variables.position# height: #attributes.height#px; width: #attributes.width#px; clip: rect(0 #attributes.width# #attributes.height# 0); visibility: #variables.visibility#; z-index:30">
				<EMBED SRC="#request.uitoolkitsupportpath#swf/calendar.swf?CallBackUrl=#urlencodedformat(variables.CallBackURL)#"
			       WIDTH="#Attributes.Width#"
			       HEIGHT="#Attributes.Height#"
			       STYLE="visibility: hide;"
			       QUALITY="high"
				   SCALE="exactfit"
        		   TYPE="application/x-shockwave-flash"
       			   PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
	   		  </div>
		  </CFIF>
		</CFIF>
</CFIF>


</cfoutput>

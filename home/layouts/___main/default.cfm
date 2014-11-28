<!-------------------------------------------------------------
this layout is called only for the main/default view
--------------------------------------------------------------->
<h1>Layouts/Main: Welcome to FW/1!</h1>
(The higher layout won't be loaded, since we have layouts/main/default.cfm)<br/>

<cfoutput>#body#</cfoutput>

<!---    stops higher level layout from loading     --->
<!---    <cfset request.layout = false>     --->


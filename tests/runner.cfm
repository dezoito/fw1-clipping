<!-------------------------------------------------------------
tests can only be run locally
--------------------------------------------------------------->
<cfif IsLocalHost(CGI.REMOTE_ADDR)>
    <cfsetting showDebugOutput="false">
    <!--- Executes all tests in the 'specs' folder with simple reporter by default --->
    <cfparam name="url.reporter" 		default="simple">
    <cfparam name="url.directory" 		default="root.tests.specs">
    <cfparam name="url.recurse" 		default="true" type="boolean">
    <cfparam name="url.bundles" 		default="">
    <cfparam name="url.labels" 			default="">
    <!---    <cfparam name="url.reportpath"         default="#expandPath( "/results" )#">     --->
    <cfparam name="url.propertiesFilename" 	default="root.tests.properties">
    <cfparam name="url.propertiesSummary" 	default="false" type="boolean">

    <!--- Include the TestBox HTML Runner --->
    <cfinclude template="/testbox/system/runners/HTMLRunner.cfm" >
<cfelse>
    <p>Tests cannot be run remotely.</p>
</cfif>

/**
* Copyright Since 2005 Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com | www.gocontentbox.org
**************************************************************************************
*/

component{
	this.name = "A TestBox Runner Suite " & hash( getCurrentTemplatePath() );
	// any other application.cfc stuff goes below:
	this.sessionManagement = true;
	// prevent bots creating lots of sessions
	if (structKeyExists(cookie, "CFTOKEN")) this.sessiontimeout = createTimeSpan(0, 0, 5, 0);
	else this.sessiontimeout = createTimeSpan(0, 0, 0, 1);

	// any mappings go here, we create one that points to the root called test.
	this.mappings[ "/test" ] = getDirectoryFromPath( getCurrentTemplatePath() );

	// create mapping for this apps's root dir
	this.applicationroot = ReReplace(getDirectoryFromPath(getCurrentTemplatePath()), "tests.$", "", "all");
	this.name = ReReplace("[^W]", this.applicationroot & "tests", "", "all");
	this.mappings[ "/root" ] = this.applicationroot;

	this.mappings["/frameworks"] = this.applicationroot & "frameworks/";


	// any orm definitions go here.
	this.dataSource = "dtb_clipping";
	this.ormEnabled = true;
	this.ormsettings = {
	    // cfclocation="./model/beans",
	    dbcreate="update",       // update database tables only
	    dialect="MySQL",         // assume MySql, other dialects available http://help.adobe.com/en_US/ColdFusion/9.0/Developing/WSED380324-6CBE-47cb-9E5E-26B66ACA9E81.html
	    eventhandling="False",
	    eventhandler="root.home.model.beans.eventhandler",
	    logsql="true",
	    flushAtRequestEnd = false
	};

	// request start
	public boolean function onRequestStart( String targetPage ){
		return true;
	}

	/**
	 * sets up Application and framework vars
	 */
	function setupApplication() {
	    var bf = new framework.ioc( "model" );
	    setBeanFactory( bf );

	    // if we are using subsystems, this is how you setup the BeanFactory
	    // for the "home" subsystem
	    // https://github.com/framework-one/fw1/wiki/Using-Subsystems#setting-bean-factories-with-setupsubsystem
	    var homeBf = new framework.ioc( "home/model" );
	    setBeanFactory( homeBf );
	    setSubsystemBeanFactory('home', homeBf);
	    variables.frameworkTrace( "<b>Just setup a TEST Bean Factory</b>", 'homeBf');

	    application.datasource = this.datasource;

	    // include UDF functions
	    // the functions inside the CFC cann be referred by application.UDFs.functionName()
	    application.UDFs = createObject("component", "lib.functions");
	}

	/**
	 * sets up session vars and logic when a session starts
	 */
	function setupSession(){
	    // CSRF Token, unique for each user/session
	    session.csrftoken = CSRFGenerateToken();
	}
}

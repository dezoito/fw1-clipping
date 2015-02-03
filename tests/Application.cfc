/**
 * Inherits Main apps's Application.cfc settings
 *
 * (Change only what's needed for testing)
 */
component extends="../Application"{

    // sets datasource to a test database
    this.datasource = this.test_datasource;
    application.datasource = this.datasource;

    this.ormsettings = {
        dbcreate="update", // update database tables only
        cfclocation="../home/model/beans",
        dialect="MySQL",         // assume MySql, other dialects available http://help.adobe.com/en_US/ColdFusion/9.0/Developing/WSED380324-6CBE-47cb-9E5E-26B66ACA9E81.html
        logsql="true",
        flushAtRequestEnd = false
    };


    this.triggerDataMember = true // so we can access properties directly (no need for getters and setters)


}

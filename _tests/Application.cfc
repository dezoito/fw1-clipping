/* This CFC is used solely for running tests
 *
 * It is based (I mean, copied) fron  the one on Xindi:
 * https://github.com/simonbingham/xindi/blob/master/_tests/Application.cfc
 */
component{

    // set real application path as the root
    this.applicationroot = ReReplace(getDirectoryFromPath(getCurrentTemplatePath()), "_tests.$", "", "all");
    // this.name = ReReplace("[^W]", this.applicationroot & "_tests", "", "all");
    this.name = "Clipping_tests";
    this.sessionmanagement = true;
    // prevent bots creating lots of sessions
    if (structKeyExists(cookie, "CFTOKEN")) this.sessiontimeout = createTimeSpan(0, 0, 5, 0);
    else this.sessiontimeout = createTimeSpan(0, 0, 0, 1);
    // "frameworks" mapping is defined in administrator
    // this.mappings["/frameworks"] = this.applicationroot & "frameworks/";
    this.mappings["/model"] = this.applicationroot & "home/model/";
    this.datasource = "dtb_clipping";
    this.ormenabled = true;
    this.ormsettings = {
        flushatrequestend = false
        , automanagesession = false
        , cfclocation = this.mappings["/model"]
        , dialect="MySQL"  // mirror what's in the main application.cfc
        , eventhandling="False"
        , eventhandler="root.home.model.beans.eventhandler"
        , dbcreate = "update"
    };

}

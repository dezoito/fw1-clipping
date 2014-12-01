component accessors="true" {

    /**
     * and we add a declaration that the controller depends on the new clipping.cfc
     * (in model/services):
     */
    property clippingService;


    /**
     * init FW variables and methods so that they are available to this controller
     */
    function init(fw) {
        variables.fw = fw;
        return this;
    }


    /**
     * action = main or action = main.default
     */
    function default( struct rc ) {
        fw.frameworkTrace( "<b>Running query to list articles</b>");
        // rc.qry_clipping = variables.clippingService.getAll(); // returns query
        rc.qry_clipping = variables.clippingService.list(perpage=5); // returns a struct
    }

    /**
     * returns data without using layouts
     * a view with the same name (action=main.nolayout)
     */
    function nolayout( struct rc ) {
        // defines content type:
        // application/json; charset=utf-8
        // text/xml; charset=utf-8
        // text/plain; charset=utf-8
        var contentType = 'JSON';
        param name="rc.name" default="String returned without a layout";
        setting showdebugoutput='false';  // no debug output
        // return the whole RC struct as JSON
        variables.fw.renderData( contentType, rc);
    }
}

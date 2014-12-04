component accessors="true" {

    /**
     * This controller needs the services bellow
     * (they are found in <subsystem>/models/services)
     */
    property clippingService;
    property summaryService;

    /**
     * init FW variables and methods so that they are available to this controller
     */
    function init(fw) {
        variables.fw = fw;
        return this;
    }

    /**
     * Generates clipping form
     * either for a new one, or for an update
     */
    function form (struct rc){
        param name="rc.clipping_id" default="0";

        if(isValid("integer",rc.clipping_id) && val(rc.clipping_id)) {
            rc.Clipping = variables.clippingService.getClipping(rc.clipping_id);
            // if a valid instance was not returned, return error.
            if(IsNull(rc.Clipping)) {
                variables.fw.frameworkTrace( "<b>ORM query returned no Objects...redirecting to main</b>");
                variables.fw.redirect("main");
            }
        } else {
            // if we don't have a valid id, initialize object with the needed defaults
            rc.Clipping = entityNew("clipping");
        }
        // will render clipping.form view from here...
    }

    /**
     * Generates clipping form
     * either for a new one, or for an update
     * to be displayed in a modal window
     */
    function ajaxForm (struct rc){
        // disable trace and debug info
        variables.fw.disableFrameworkTrace();
        setting showdebugoutput="false";

        // builds the form just like the non-ajax version
        return form( rc );

        // will render clipping.ajaxform view from here...
    }

    /**
     * saves an article
     */
    function save( struct rc ) {
        variables.fw.frameworkTrace( "<b>Save Method on Clipping Controller</b>");

        // ------------ validation ---------
        // if we have errors, go back to the form passing "ALL" rc values
        isValidForm = variables.clippingService.validate( rc );
        if(!isValidForm) {
            variables.fw.redirect("clipping.form", "all");
        }
        // ------------ end validation ---------

        // save (insert or update) this object
        // using the clippingService
        rc.Clipping = variables.clippingService.save(rc);

        // since there's no clipping.save view, we have to redirect somewhere
        // (in this case, to the main list)
        variables.fw.redirect("main.default");
    }

    /**
     * deletes an article - on POST requests only!!!
     */
    function delete( struct rc ) {
        variables.fw.frameworkTrace( "<b>Delete Method on Clipping Controller</b>");
        if (cgi.request_Method=="post"){
            // delete this object using the clippingService
            rc.Clipping = variables.clippingService.delete(rc.clipping_id);
        }
        variables.fw.redirect("main.default");
    }

    /**
     * Uses webservice to summarize the Article's text
     */
    function summary( struct rc ) {
        variables.fw.frameworkTrace( "<b>Summary Method on Clipping Controller</b>");
        rc.Clipping = variables.clippingService.getClipping(rc.clipping_id);
        rc.Summary = variables.summaryService.getSummary(rc.Clipping.getClipping_texto());
    }
}

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
    property framework;

    /**
     * Generates clipping form
     * either for a new one, or for an update
     */
    function form (struct rc){

        // Checks if the form is being displayed after a failed validation
        // (i.e. if this function was called from the save() method in this controller)
        // If NOT, instantiate a clipping entity to fill the form fields
        // If so, just display the last data used when filling the forms
        if(!structKeyExists(rc, "Clipping")){

            param name="rc.clipping_id" default="0";

            if(isValid("integer",rc.clipping_id) && val(rc.clipping_id)) {
                rc.Clipping = variables.clippingService.getClipping(rc.clipping_id);
                // if a valid instance was not returned, return error.
                if(IsNull(rc.Clipping)) {
                    framework.frameworkTrace( "<b>ORM query returned no Objects...redirecting to main</b>");
                    framework.redirect("main");
                }
            } else {
                // if we don't have a valid id, initialize object with the needed defaults
                rc.Clipping = entityNew("clipping");
            }
        }
        // will render clipping.form view from here...
    }

    /**
     * saves an article
     */
    function save( struct rc ) {
        framework.frameworkTrace( "<b>Save Method on Clipping Controller</b>");

        // abort execution in case of CRSF attack (use UDF defined in lib.functions.cfc)
        application.UDFs.abortOnCSRFAttack( rc );

        // save (insert or update) this object
        // using the clippingService
        rc.Clipping = variables.clippingService.save(rc);

        // passed validation?
        if(rc.Clipping.validate().isValid){
            // since there's no clipping.save view, we have to redirect somewhere
            // (in this case, to the main list)
            framework.redirect("main.default");
        } else {
            // Invalid data!
            // copy errors to struct in RC and display form again
            rc.stErrors = rc.Clipping.validate().stErrors
            framework.redirect("clipping.form", "all");
        }
    }

    /**
     * deletes an article - on POST requests only!!!
     */
    function delete( struct rc ) {
        framework.frameworkTrace( "<b>Delete Method on Clipping Controller</b>");

        // abort execution in case of CRSF attack (use UDF defined in lib.functions.cfc)
        application.UDFs.abortOnCSRFAttack( rc );

        if (cgi.request_Method=="post"){
            // delete this object using the clippingService
            rc.Clipping = variables.clippingService.delete(rc.clipping_id);
        }
        framework.redirect("main.default");
    }

    /**
     * Uses webservice to summarize the Article's text
     * It retuns only TEXT and does not use a layout
     */
    function summary( struct rc ) {
        framework.frameworkTrace( "<b>Summary Method on Clipping Controller</b>");
        rc.Clipping = variables.clippingService.getClipping(rc.clipping_id);
        rc.Summary = variables.summaryService.getSummary(rc.Clipping.getClipping_texto());

        // comment out the three lines below
        // to render the clipping.summary view instead
        // (useful for debugging)
        var contentType = 'text';
        setting showdebugoutput='false';
        framework.renderData( contentType, rc.Summary );
    }
}


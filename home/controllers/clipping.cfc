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
            // if we don't have a valid id, initiaslize object with the needed defaults
            rc.Clipping = entityNew("clipping");
        }
        // will render clipping.form view from here...
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
}

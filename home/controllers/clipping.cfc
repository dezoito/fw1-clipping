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
        // ------------ default values for forms ---------
        param name="rc.clipping_id" default="0";
        // param name="rc.clipping_titulo" default="";
        // param name="rc.clipping_texto" default="";
        // param name="rc.clipping_fonte" default="";
        // param name="rc.clipping_link" default="";
        // param name="rc.published" default="#now()#";

        // if we are updating, load form pre-populated
        // if(isdefined("rc.clipping_id") && isValid("integer",rc.clipping_id)  && rc.clipping_id > 0){
        //     Clipping = variables.clippingService.getClipping(rc.clipping_id);

        //     // copies obj properties to rc (so we can fill forms)
        //     application.copyORMPropertiesToStruct(Clipping, rc);
        // }
        if(isValid("integer",rc.clipping_id) && val(rc.clipping_id)) {
                rc.Clipping = variables.clippingService.getClipping(rc.clipping_id);
            } else {
                rc.Clipping = entityNew("clipping");
                // update rc.Clipping with defaults here???
            }
        // will render clipping.form view from here...
    }

    /**
     * save an article
     */
    function save( struct rc ) {
        fw.frameworkTrace( "<b>Save Method on Clipping Controller</b>");

        // if we have errors, go back to the form passing "ALL" rc values
        isValidForm = variables.clippingService.validate( rc );
        if(!isValidForm) {
            variables.fw.redirect("clipping.form", "all");
        }
        // ------------ end validation ---------

        // save (insert or update) this object
        // using the clippingService
        rc.data = variables.clippingService.save(rc);
        // rc.Clipping = rc.data
        // rc.clipping_id = rc.data.getClipping_id();

        // since there's no clipping.save view, we have to redirect somewhere
        variables.fw.redirect("main.default");
    }
}

/**
 *  This service must be defined in Application.cfc
 *  for now, it just prepends a string
 */
component {
    function greet( string name ) {
        // stops controller execution
        // abortController();
        return "so-called " & name;
    }
}

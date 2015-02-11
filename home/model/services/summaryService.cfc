/**
 * I am the summary service
 * All I do is query a remote webservice to get a summary for a string
 */
component {

    public function getSummary(string clipping_texto){

        cfhttp(url='http://localhost:5000/ajax_resumo' method='post' result='st_summary'){
            cfhttpparam (type="formfield" name = "texto" value = clipping_texto);
        }

        // the CFHHTP call returns the results in a struct called st_summary
        // that contains several keys, including errordetail and filecontent
        // if there's a error, return a generic error message
        // if not, just the string we need
        // dump(st_summary);
        if (len(st_summary.errordetail) > 0) {
            return "There was an error trying to use summary service :'(";
        } else {
            return st_summary.filecontent;
        }
    }
}

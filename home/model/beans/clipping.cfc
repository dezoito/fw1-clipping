component persistent="true" table="tbl_clipping" accessors="true" {

    property name="clipping_id" generator="native" ormtype="integer" fieldtype="id";
    property name="clipping_titulo" ormtype="string" length="255";
    property name="clipping_texto" ormtype="text";
    property name="clipping_link"  ormtype="string" length="200";
    property name="clipping_fonte"  ormtype="string" length="200";
    property name="published" ormtype="timestamp";
    property name="created" ormtype="timestamp";
    property name="clipping_incluido_por"  ormtype="string" length="100";


    /**
     * initialize this object, setting defaults if needed
     */
    public function init() {
        if (IsNull(variables.Published)) {
            this.setPublished(Now());
        }
        return this;
    }

    /**
     * performs data validation
     */
    public function validate() {
        stValidation = {};
        stErrors = {};

        if(!len(trim(variables.clipping_titulo))) {
            structInsert(stErrors,"clipping_titulo","You must include a title for your clipping.");
        }

        if(!len(trim(variables.clipping_texto))) {
            structInsert(stErrors,"clipping_texto","You must include text for your clipping.");
        }

        if(len(trim(variables.clipping_link)) && !isValid("url", variables.clipping_link)) {
            structInsert(stErrors,"clipping_link","If you include a link, it has to be formatted. Ex: http://www.link.com.");
        }

        if(!len(trim(variables.published)) || !isValid("eurodate", trim(variables.published))) {
            structInsert(stErrors,"published","You must specify a valid publishing date.");
        }

        stValidation.isValid = !val(structCount(stErrors)); // true if no errors
        stValidation.stErrors = stErrors;
        return stValidation;
    }
}

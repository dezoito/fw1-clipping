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
}

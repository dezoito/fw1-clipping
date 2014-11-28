component persistent="true" table="tbl_clipping" accessors="true" {

    property name="clipping_id" generator="native" ormtype="integer" fieldtype="id";
    property name="clipping_titulo" ormtype="string" length="255";
    property name="clipping_texto" ormtype="text";
    property name="clipping_link"  ormtype="string" length="200";
    property name="clipping_fonte"  ormtype="string" length="200";
    property name="published" ormtype="timestamp";
    property name="created" ormtype="timestamp";
    property name="clipping_incluido_por"  ormtype="string" length="100";

    // you can create functions that are specific for each record
    // see example below
    // public function getAnswered() {
    //     var hql = "
    //         select a.id
    //         from question q join q.answers a
    //         where a.selectedanswer = 1 and q.id = ?
    //     ";
    //     var r = ormExecuteQuery(hql, [variables.id]);
    //     return arrayLen(r) is 1;
    // }

}

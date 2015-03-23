/**
 * The Clipping Service
 * - Validates data before saving (inser/Update)
 * - saves a valid object
 * - Returns a struct with validation errors and corresponding fields (if invalid)
 * - returns a single instance of a clipping
 * - returns a list of clipping articles
 * - deletes an instance
 */
component {

    /**
     * insert or update clipping article
     */
    public any function save(struct rc) {
        transaction {

            //  Insert or Update?
            if(val(arguments.rc.clipping_id)){
                    var c = entityLoadByPk("Clipping", arguments.rc.clipping_id);
                } else {
                    var c = entityNew("clipping");
                }

            // filter user input
            // use functions to "clean" each string field and then insert or update
            UDFs = application.UDFs
            c.setClipping_titulo(UDFs.prepara_string(UDFs.stripHTML(arguments.rc.clipping_titulo)));
            c.setClipping_texto(UDFs.safetext(arguments.rc.clipping_texto, true));
            c.setClipping_link(UDFs.prepara_string(UDFs.stripHTML(arguments.rc.clipping_link)));
            c.setClipping_fonte(UDFs.prepara_string(UDFs.stripHTML(arguments.rc.clipping_fonte)));
            c.setCreated(Now());

            // try to format only if the user submitted a valid eurodate
            if(isValid("eurodate", arguments.rc.Published)){
                c.setPublished(dateformat(arguments.rc.Published, "dd/mm/yyyy")); // handle eurodates
            }

            // commit changes IF data is valid
            if (c.validate().isValid) {
                entitySave(c);
                transactionCommit();
            } else {
                // since the data was invalid, don't save and
                // rollback any pending transactions
                // (we are checking for validation errors in the controller)
                transactionRollback();
            }
        }
        return c;
    }

    /**
     * returns a single instance
     */
    public any function getClipping(numeric clipping_id) {
        return entityLoadByPk("clipping", arguments.clipping_id);
    }

    /**
     * deletes a single instance
     */
    public any function delete(numeric clipping_id) {
        transaction {
            Clipping = entityLoadByPk("clipping", arguments.clipping_id);
            EntityDelete(Clipping);
            transactionCommit();
        }
    }

    /**
     * returns an struct with an array of Clipping instances (paginated) and the total record count
     */
    public any function list(numeric page=1, numeric perpage=application.recordsPerPage) {
        var result = {};
        var hql = "from clipping order by clipping_id desc";
        var result.data = ormExecuteQuery(hql, false, {
            maxResults=arguments.perpage,
            offset=( arguments.page - 1 ) * application.recordsPerPage
        });
        var totalhql = "select count(id) as total from clipping";
        var result.count = ormExecuteQuery(totalhql, true);

        return result;
    }

    /**
     * returns all clippings through SQL
     */
    function getAll() {
        var qry="";
        qry = new Query(datasource="#application.datasource#",
                        sql="select * from tbl_clipping"
                        ).execute().getResult();
        return qry;
    }
}

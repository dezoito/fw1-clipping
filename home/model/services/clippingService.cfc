/**
 * I am the clipping service.
 */
component {


    /**
     * validates formfields before saving object
     * @param   struct rc
     * @return boolean
     */
    public any function validate(struct rc) {
        rc.errors = [];

        // ------------ start validation ---------
        // for now we are handling validation in the controllers.
        // later, we will move this to the model using validateThis()
        // https://groups.google.com/forum/#!topic/framework-one/Hh-YcyCQcJA
        if(!len(trim(rc.clipping_titulo))) {
            arrayAppend(rc.errors, "You must include a title for your clipping.");
        }

        if(!len(trim(rc.clipping_texto))) {
            arrayAppend(rc.errors, "You must include text for your clipping.");
        }

        if(len(trim(rc.clipping_link)) && !isValid("url", rc.clipping_link)) {
            arrayAppend(rc.errors, "If you include a link, it has to be formatted. Ex: http://www.link.com.");
        }

        if(!len(trim(rc.published)) || !isValid("eurodate", trim(rc.published))) {
            arrayAppend(rc.errors, "You must specify a valid publishing date.");
        }
        // we are saving the errors to rc.errors anyway
        // return true if there are NONE
        return !val(arrayLen(rc.errors));
    }


    /**
     * insert or update clipping article
     */
    public any function save(struct rc) {
        transaction {
            // var thisUser = entityLoadByPk("user", user);
            //  Insert or Update?
            if(val(arguments.rc.clipping_id)){
                    var c = entityLoadByPk("Clipping", arguments.rc.clipping_id);
                } else {
                    var c = entityNew("clipping");
                }

            c.setClipping_titulo(trim(application.stripHTML(arguments.rc.clipping_titulo)));
            c.setClipping_texto(application.safetext(arguments.rc.clipping_texto, true));
            c.setClipping_link(trim(application.stripHTML(arguments.rc.clipping_link)));
            c.setClipping_fonte(trim(application.stripHTML(arguments.rc.clipping_fonte)));
            c.setPublished(arguments.rc.Published);
            c.setCreated(Now());
            entitySave(c);
            transactionCommit();
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
            // Clipping = entityLoadByPk("clipping", arguments.clipping_id);
            // EntityDelete(Clipping);

            // entityDelete wasn't working at all
            // delete by using HQL and parameters
            hql = "delete from clipping where clipping_id = ?";
            queryParameters = [arguments.clipping_id];
            var r = ormExecuteQuery(hql, queryParameters);
            return true;
    }

    /**
     * returns an array of Clipping instances
     */
    public any function list(numeric start=1, numeric perpage=10) {
        var result = {};
        var hql = "from clipping order by clipping_id desc";
        var result.data = ormExecuteQuery(hql, false, {
            maxResults=arguments.perpage,
            offset=arguments.start-1
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

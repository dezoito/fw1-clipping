/**
 * I am the clipping service.
 */
component {

    // insert or update clipping article
    public any function post(struct rc) {
        transaction {
            // var thisUser = entityLoadByPk("user", user);
            var c = entityNew("clipping");
            c.setClipping_titulo(arguments.rc.clipping_titulo);
            c.setClipping_texto(arguments.rc.clipping_texto);
            c.setClipping_link(arguments.rc.clipping_link);
            c.setClipping_fonte(arguments.rc.clipping_fonte);
            c.setPublished(arguments.rc.Published);
            c.setCreated(Now());
            entitySave(c);
            transactionCommit();
        }
        return c;
    }

    // returns a single instance
    public any function getClipping(numeric clipping_id) {
        return entityLoadByPk("clipping", arguments.clipping_id);
    }

    // returns a struct
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

    // returns all clippings through SQL
    function getAll() {
        var qry="";
        qry = new Query(datasource="#application.datasource#",
                        sql="select * from tbl_clipping"
                        ).execute().getResult();
        return qry;
    }
}

/**
 * Runs CRUD tests against a mock database
 * for this, we created a test database "dtb_clipping_test"
 * and a datasource with the same name
 *
 */
component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        // How to dump application settings
        // dump(application.getApplicationSettings());

        // reinitialise ORM for the application
        ORMReload();

        // initialize ORM, Services, create and populate the tables we need
        clippingService = createObject("component", "root.home.model.services.clippingService");
        str_default_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. <br>Integer nec nulla ac justo viverra egestas.";

        // add a few fake articles using ORM
        rc = structNew();
        for(i=1; i<=10; i=i+1){
            rc.Clipping_id = 0;
            rc.Clipping_titulo = createUUID();
            rc.Clipping_texto = str_default_text;
            rc.Clipping_link = "http://localhost/";
            rc.Clipping_fonte = "This is the source for the article";
            rc.Published = now(); // handle eurodates
            Clipping = clippingService.save(rc);
        }
    }

    // executes after all suites
    function afterAll(){
        // destroy test data
        var q = new Query();
        q.setDatasource(application.datasource);
        q.setSQL("
            DROP TABLE tbl_clipping;
        ");
        q.execute();

        // clear first level cache and remove any unsaved objects
        ORMClearSession();
    }

    // All suites go in here
    function run( testResults, testBox ){

        // --------- tests using SQL --------------
        describe("Can run SQL on the TEST DATABASE: " & application.datasource, function(){

            var queryObj = new query();
            queryObj.setDatasource(application.datasource);

            it("Must be able to access tables on the database", function(){
                queryObj.setName("qry_show_tables");
                result = queryObj.execute(sql="show tables ");
                qry_show_tables = result.getResult();
                metaInfo = result.getPrefix();

                expect( qry_show_tables ).toBeTypeOf( "query" );
            });

            it("Must be able to query clipping table", function(){
                queryObj.setName("qry_clipping");
                result = queryObj.execute(sql="select count(clipping_id) as total from tbl_clipping");
                qry_clipping = result.getResult();
                metaInfo = result.getPrefix();

                expect( qry_clipping ).toBeTypeOf( "query" );
            });

            it("Querying clipping table should take less than 500ms", function(){
                queryObj.setName("qry_clipping");
                result = queryObj.execute(sql="select count(clipping_id) as total from tbl_clipping");
                qry_clipping = result.getResult();
                metaInfo = result.getPrefix();

                expect( metainfo.executionTime ).toBeLt( 500 );
            });

            it("Must be able to query clipping table (using params)", function(){
                queryObj.setName("qry_clipping");
                queryObj.addParam(name="clipping_id",value="0",cfsqltype="NUMERIC");
                result = queryObj.execute(sql="select count(clipping_id) as total from tbl_clipping WHERE clipping_id >= :clipping_id");
                qry_clipping = result.getResult();
                metaInfo = result.getPrefix();
                queryObj.clearParams();
                // dump(metaInfo);
                // dump(qry_clipping);

                expect( qry_clipping ).toBeTypeOf( "query" );
            });
        });

        // --------- tests using ORM --------------
        describe("Using ORM", function(){

            it("Clipping table must contain exactly 10 records", function(){
                // run simple query
                var totalhql = "select count(id) as total from clipping";
                var result.count = ormExecuteQuery(totalhql, true);
                expect( result.count ).toBe( 10 );
            });

            it("Must be able to load a single instance by ID", function(){
                C = entityLoadByPk("clipping", 1);
                expect( C ).toBeTypeOf( "Component" );
            });

            it("Must be able to update an instance of a Clipping article", function(){
                strNewTitle = "This is an updated title"
                C.Clipping_titulo = strNewTitle;
                ORMFlush();
                C = entityLoadByPk("clipping", 1);
                expect( C.Clipping_titulo ).toBe( strNewTitle );
            });

            it("Must be able to delete instances", function(){
                entityDelete(C);
                ORMFlush();
                var totalhql = "select count(id) as total from clipping";
                var result.count = ormExecuteQuery(totalhql, true);
                expect( result.count ).toBe( 9 );
            });
        });

    }
}

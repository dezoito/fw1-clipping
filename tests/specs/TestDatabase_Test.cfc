/**
 * Runs CRUD tests against a mock database
 *
 *
 */
component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
       // How to dump application settings
       // (http://www.bennadel.com/blog/1686-accessing-coldfusion-application-settings.htm)
       // dump(application.getApplicationSettings());
    }

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){


        // --------- tests using SQL --------------
        describe("Can run SQL on the TEST DATABASE: " & application.datasource, function(){

            queryObj = new query();
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

            it("Clipping table must contain records", function(){

                // run simple query
                var totalhql = "select count(id) as total from clipping";
                var result.count = ormExecuteQuery(totalhql, true);
                expect( result.count ).toBeGT( 0 );
            });
        });

    }
}

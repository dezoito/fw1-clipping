/**
 * This test suit makes simple tests against the production database
 * IE: Connections and simple queries
 * It does not change any data.
 *
 * See TestDatabase_Test for tests involving CRUD operations.
 */
component extends="testbox.system.BaseSpec" accessors="true"{

    // executes before all suites
    function beforeAll(){}

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){

        // set the string for PROD datasource
        prod_datasource = replace(application.datasource, "_test", "", "all");

        describe("Can run SQL on the PRODUCTION DATABASE: " & prod_datasource, function(){

            queryObj = new query();
            queryObj.setDatasource(prod_datasource);

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

    }
}

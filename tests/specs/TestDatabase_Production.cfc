/**
 * This test suit makes simple tests against the production database
 * IE: Connections and simple queries
 * It does not change any data.
 *
 * See TestDatabase_Test for tests involving CRUD operations.
 */
component extends="testbox.system.BaseSpec" accessors="true"{



    // executes before all suites
    function beforeAll(){
        writeoutput("beforeAll() just ran, believe it or not!");

       // How to dump application settings
       // (http://www.bennadel.com/blog/1686-accessing-coldfusion-application-settings.htm)
       // dump(application.getApplicationSettings());

    }

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){

        prod_datasource = replace(application.datasource, "_test", "", "all");

        describe("Can run SQL on the PRODUCTION DATABASE: " & prod_datasource, function(){

            queryObj = new query();
            queryObj.setDatasource(prod_datasource);
            queryObj.setName("qry_clipping");
            // queryObj.addParam(name="clipping_id",value="0",cfsqltype="NUMERIC");
            // result = queryObj.execute(sql="SELECT * FROM clipping WHERE clipping_id = :clipping_id");
            result = queryObj.execute(sql="select count(clipping_id) as total from tbl_clipping");
            qry_clipping = result.getResult();
            metaInfo = result.getPrefix();
            // queryObj.clearParams();
            // writeDump(qry_clipping);
            // writeDump(metaInfo);

            it("Must return a valid query object", function(){
                expect( qry_clipping ).toBeTypeOf( "query" );
            });

        });

        // describe("Can connect to database", function(){

        //     // run simple query
        //     var totalhql = "select count(id) as total from clipping";
        //     var result.count = ormExecuteQuery(totalhql, true);

        //     it("Must not generate database connection errors", function(){
        //         expect( result.count ).toBeGT( 0 );
        //     });

        // });

    }
}

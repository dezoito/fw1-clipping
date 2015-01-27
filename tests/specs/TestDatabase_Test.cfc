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


        describe("Can run SQL on the TEST DATABASE: " & application.datasource, function(){

            queryObj = new query();
            queryObj.setDatasource(application.datasource);
            queryObj.setName("qry_show_tables");
            // queryObj.addParam(name="clipping_id",value="0",cfsqltype="NUMERIC");
            // result = queryObj.execute(sql="SELECT * FROM clipping WHERE clipping_id = :clipping_id");
            result = queryObj.execute(sql="show tables ");
            qry_show_tables = result.getResult();
            metaInfo = result.getPrefix();
            queryObj.clearParams();
            writeDump(qry_show_tables);
            writeDump(metaInfo);

            it("Must return a valid query object", function(){
                expect( qry_show_tables ).toBeTypeOf( "query" );
            });

        });

    }
}

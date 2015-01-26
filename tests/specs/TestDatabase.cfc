component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
       // dump(this);
    }

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){

        describe("Can connect to database", function(){
            var totalhql = "select count(id) as total from clipping";
            var result.count = ormExecuteQuery(totalhql, true);
            it("Must not generate database connection errors", function(){
                expect( result.count ).toBeGT( 0 );
            });

        });

        // ------- UDF abrevia_string -------------
        describe("Function abrevia_string", function(){
            var strSample = "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit";

            it("Must add elipses to a string longer than N chars", function(){
                expect( application.UDFs.abrevia_string(strSample, 20) ).toBe("Neque porro quisquam...");
            });

            it("Must NOT add ellipses to a string shorter than N chars", function(){
                expect( application.UDFs.abrevia_string(strSample, 2000) ).toBe(strSample);
            });
        });


    }
}

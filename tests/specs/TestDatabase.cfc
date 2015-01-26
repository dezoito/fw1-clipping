component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        ORMReload();
    }

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){


        describe("Can connect to database", function(){
                it("Must not generate database connection errors", function(){
                expect( application.UDFs.abrevia_string("Inception", 20) ).toBe("Inception");
            });

            // it("Must NOT add ellipses to a string shorter than N chars", function(){
            //     expect( UDFs.abrevia_string(strSample, 2000) ).toBe(strSample);
            // });
        });


    }
}

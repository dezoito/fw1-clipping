component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){}

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){

        describe("A suite", function(){
            it("contains a very simple spec", function(){
                expect( true ).toBeTrue();
            });

            it("makes sure we are running on Railo Server", function(){
                expect( structKeyExists( server, "railo" ) ).toBeTrue();
            });

        });


    }
}

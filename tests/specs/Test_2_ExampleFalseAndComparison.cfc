component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){}

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){

        describe("A suite", function(){
            it("sees that a false value is always false", function(){
                expect( false ).toBeFalse();
            });

            it("makes sure we are running on Railo Server", function(){
                expect( !structKeyExists( server, "railo" ) ).toBeFalse();
            });

            it("contains a very value comparison", function(){
                var smallNumber = 1;
                var biggerNumber = 1000;
                expect( smallNumber ).toBeLT(biggerNumber);
            });

        });


    }
}

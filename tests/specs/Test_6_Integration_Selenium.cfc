/**
 * Runs CRUD tests against a mock database
 * for this, we created a test database "dtb_clipping_test"
 * and a datasource with the same name
 *
 */
component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        // set url of Xindi installation
        browserURL = "http://#CGI.HTTP_HOST#/fw1/clipping";
        // set browser to be used for testing
        browserStartCommand = "*googlechrome";
        // create a new instance of CFSelenium
        selenium = createobject("component", "CFSelenium.selenium").init();
        // start Selenium server
        selenium.start(browserUrl, browserStartCommand);
        // set timeout period to be used when waiting for page to load
        timeout = 60000;
        // rebuild Xindi (reset data in database)
        httpService = new http();
        httpService.setUrl(browserURL & "/index.cfm?rebuild=true");
        httpService.send();
    }

    // executes after all suites
    function afterAll(){
        selenium.stopServer();
        // selenium.stop();

    }

    // All suites go in here
    function run( testResults, testBox ){


        // --------- Start page tests --------------
        describe("Loading home page", function(){

            it("Should load and have the correct title", function(){
                selenium.open(browserUrl);
                selenium.waitForPageToLoad(timeout);
                expect( selenium.getTitle() ).toBe( "Clippings" );
            });

        });

    }
}

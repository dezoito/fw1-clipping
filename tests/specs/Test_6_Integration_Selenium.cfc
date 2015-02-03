/**
 * Runs intergration tests using CFSelenium
 * (which must be installed at the server's root)
 *
 * Visit the following links for references:
 * https://github.com/teamcfadvance/CFSelenium
 * http://www.thoughtdelimited.org/thoughts/post.cfm/quick-guide-for-installing-and-running-cfselenium
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
        timeout = 120000;
        // rebuild Xindi (reset data in database)
        httpService = new http();
        httpService.setUrl(browserURL & "/index.cfm?rebuild=true");
        httpService.send();
    }

    // executes after all suites
    function afterAll(){
        selenium.stop();
        selenium.stopServer();
    }

    // All suites go in here
    function run( testResults, testBox ){

        describe("Loading home page", function(){

            it("Should load and have the correct title", function(){
                selenium.open(browserUrl);
                selenium.waitForPageToLoad(timeout);
                expect( selenium.getTitle() ).toBe( "Clippings" );
            });

        });

        describe("Testing the add clipping form:", function(){

            it("Clicking add an article link should load the form page", function(){
                selenium.open(browserURL);
                selenium.waitForPageToLoad(timeout);
                selenium.click("link=Add an Article");
                // selenium.waitForPageToLoad(timeout);
                // selenium.click("link=exact:Sample Article A");
                expect( selenium.isTextPresent("Published:") ).toBe( true );
            });

            it("The app must validade form entry", function(){
                selenium.open(browserURL & "?action=clipping.form");
                selenium.waitForPageToLoad(timeout);
                selenium.type("id=clipping_titulo", "test");
                selenium.type("id=clipping_texto", "");
                selenium.click("id=btn_save");
                selenium.waitForPageToLoad(timeout);
                // didn't fill all the required fileds...should return with error
                expect( selenium.isTextPresent("Your article could not be posted!") ).toBe( true );
            });

        });
    }
}

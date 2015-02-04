/**
 * Runs intergration tests using CFSelenium
 * (which must be installed at the server's root)
 *
 * Visit the following links for references:
 * https://github.com/teamcfadvance/CFSelenium
 * http://www.thoughtdelimited.org/thoughts/post.cfm/quick-guide-for-installing-and-running-cfselenium
 *
 * see this for a complete test method reference
 * https://github.com/teamcfadvance/CFSelenium/blob/master/selenium.cfc
 */
component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        // set url of Xindi installation
        browserURL = "http://#CGI.HTTP_HOST#/fw1/clipping";
        // set browser to be used for testing
        browserStartCommand = "*googlechrome";
        // browserStartCommand = "*firefox";
        // create a new instance of CFSelenium
        selenium = createobject("component", "CFSelenium.selenium").init();
        // start Selenium server
        selenium.start(browserUrl, browserStartCommand);
        // set timeout period to be used when waiting for page to load
        timeout = 40000;
        // rebuild current App
        httpService = new http();
        httpService.setUrl(browserURL & "/index.cfm?rebuild=true");
        httpService.send();

        // create some random title string (we will use this to delete the article later)
        str_random_title = createUUID();
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

        describe("Testing the clipping form:", function(){

            it("Clicking add an article link should load the form page", function(){
                selenium.open(browserURL);
                selenium.waitForPageToLoad(timeout);
                selenium.click("link=Add an Article");
                selenium.waitForPageToLoad(timeout);
                expect( selenium.isElementPresent("id=f_clipping") ).toBe( true );
                expect( selenium.isTextPresent("Published:") ).toBe( true );
            });

            it("The app must validade form entry (leave article TEXT empty)", function(){
                selenium.open(browserURL & "?action=clipping.form");
                selenium.waitForPageToLoad(timeout);
                selenium.type("id=clipping_titulo", "test");
                selenium.type("id=clipping_texto", "");
                selenium.click("id=btn_save");
                selenium.waitForPageToLoad(timeout);
                // didn't fill all the required fields...should return with error
                expect( selenium.isTextPresent("Your article could not be posted!") ).toBe( true );
            });

            it("The app must validade form entry (leave article only TITLE empty", function(){
                selenium.open(browserURL & "?action=clipping.form");
                selenium.waitForPageToLoad(timeout);
                selenium.type("id=clipping_titulo", "");

                // Have to use Javascript to add text to CKEditor
                selenium.runScript("CKEDITOR.instances['clipping_texto'].setData('<p>test</p>');");
                selenium.runScript("document.getElementById('f_clipping').onsubmit=function() {CKEDITOR.instances['clipping_texto'].updateElement();};");
                selenium.click("id=btn_save");
                selenium.waitForPageToLoad(timeout);
                // didn't fill all the required fields...should return with error
                expect( selenium.isTextPresent("Your article could not be posted!") ).toBe( true );
            });

            it("If all required fields are filled correctly, go back to main page and new article should be there", function(){

                selenium.open(browserURL & "?action=clipping.form");
                selenium.waitForPageToLoad(timeout);
                selenium.type("id=clipping_titulo", str_random_title);
                // Have to use Javascript to add text to CKEditor
                selenium.runScript("CKEDITOR.instances['clipping_texto'].setData('<p>another test with a random title</p>');");
                selenium.runScript("document.getElementById('f_clipping').onsubmit=function() {CKEDITOR.instances['clipping_texto'].updateElement();};");
                selenium.click("id=btn_save");
                selenium.waitForPageToLoad(timeout);
                // should NOT return with error
                expect( selenium.isTextPresent("Your article could not be posted!") ).toBe( false );

                // the random titled article should be on the list
                expect( selenium.isTextPresent(str_random_title) ).toBe( true );
            });

            // testing form updates
            it("Should load the form for an EXISTING article", function(){
                selenium.open(browserUrl);
                selenium.waitForPageToLoad(timeout);

                // click on the article we've just created
                selenium.click("link=" & str_random_title);
                selenium.waitForPageToLoad(timeout);
                expect( selenium.isElementPresent("id=f_clipping") ).toBe( true );
                expect( selenium.isElementPresent("id=btn_delete") ).toBe( true );
                // test to see if the "title" field has the current article's title
                expect( selenium.getValue( "id=clipping_titulo" ) ).toBe( str_random_title );
            });

            it("Should be able to delete an article", function(){
                selenium.click("id=btn_delete");
                selenium.click("css=button.confirm"); // clicks the sweet-alert "confirm" buttom
                // selenium.open(browserURL); // needed when using firefox
                selenium.waitForPageToLoad(timeout);
                // the random titled article should NOT be on the list
                expect( selenium.isTextPresent(str_random_title) ).toBe( false );
            });
        });
    }
}

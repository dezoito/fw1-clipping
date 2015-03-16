/**
 * Runs intergration tests using CFSelenium
 * (which must be installed at the server's root)
 *
 * Visit the following links for references:
 * https://github.com/teamcfadvance/CFSelenium
 *
 * see this for a complete test method reference
 * https://github.com/teamcfadvance/CFSelenium/blob/master/selenium.cfc
 */
component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        // set url of Xindi installation
        browserURL = application.testsBrowseURL;
        // set browser to be used for testing
        browserStartCommand = "*googlechrome";
        // browserStartCommand = "*firefox";
        // create a new instance of CFSelenium
        selenium = createobject("component", "CFSelenium.selenium").init();
        // start Selenium server
        selenium.start(browserUrl, browserStartCommand);
        // set timeout period to be used when waiting for page to load
        timeout = 120000;
        // rebuild current App
        httpService = new http();
        httpService.setUrl(browserURL & "/index.cfm?rebuild=true");
        httpService.send();

        // create some random title string (we will use this to delete the article later)
        str_random_title = createUUID();
        // text to be used in articles
        str_default_text = repeatString("<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. <br>Integer nec nulla ac justo viverra egestas.</p>", 10);
    }

    // executes after all suites
    function afterAll(){
        selenium.stop();
        selenium.stopServer();
    }

    // All suites go in here
    function run( testResults, testBox ){

        //----------------------------------------------------------------------
        // Testing main page
        //----------------------------------------------------------------------
        describe("Loading home page", function(){

            it("Should load and have the correct title", function(){
                selenium.open(browserUrl);
                selenium.waitForPageToLoad(timeout);
                expect( selenium.getTitle() ).toBe( "Clippings" );
            });

        });

        //----------------------------------------------------------------------
        // Testing forms
        //----------------------------------------------------------------------
        describe("Testing the clipping form:", function(){

            it("Clicking -add an article- link should load the form page", function(){
                selenium.open(browserURL);
                selenium.waitForPageToLoad(timeout);
                selenium.click("link=Add an Article");
                selenium.waitForPageToLoad(timeout);
                expect( selenium.isElementPresent("id=f_clipping") ).toBe( true );
                expect( selenium.isElementPresent("id=published") ).toBe( true );
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
                selenium.runScript("CKEDITOR.instances['clipping_texto'].setData('#str_default_text#');");
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
                // created in beforeAll()
                expect( selenium.getValue( "id=clipping_titulo" ) ).toBe( str_random_title );
            });

        });

        //----------------------------------------------------------------------
        // Testing Article record on main listing
        //----------------------------------------------------------------------
        describe("Testing a single article", function(){

            it("Should NOT have tags in the preview description", function(){
                // get contents from first article preview (use xpath to find it)
                // note: if we were NOT using getText(), the actual xpath expression
                // would be "xpath=(//div[@class='previewDiv'])[1]/text()"
                selenium.open(browserUrl);
                selenium.waitForPageToLoad(timeout);
                printedPreview = selenium.getText( "xpath=(//div[@class='previewDiv'])[1]" );
                expect( printedPreview ).toBe( application.UDFs.stripHTML(printedPreview) );
            });

            it("AND that preview should have less than 200 chars", function(){
                expect( len(printedPreview) ).toBeLTE( 200 );
            });

        });

        //----------------------------------------------------------------------
        // Testing summary service
        // This is an external python based API running on port 5000,
        // that might not be running during the tests.
        // I believe this is a good way to simulate external dependencies
        //----------------------------------------------------------------------
        describe("Testing access to the summary service", function(){

            // sending a string to the summary service
            cfhttp(url='http://localhost:5000/ajax_resumo' method='post' result='st_summary'){
                cfhttpparam (type="formfield" name = "texto" value = "Some Test String");
            }

            // is the service working? (store the answer in a bool var)
            var boolIsServiceWorking = (structKeyExists(st_summary, "status_code") and st_summary["status_code"] is 200);

            it("This app should be able to obtain a response from the summary service", function(){
                expect( boolIsServiceWorking ).ToBeTrue();
            });

            // test that the app shows the correct response whether summaries are working or not
            if(boolIsServiceWorking){
                it("The service is available, it should return a summarized string", function(){
                    selenium.click("xpath=(//a[@class='summaryLink'])[1]");
                    summaryText = selenium.getText( "xpath=(//div[@class='modal-body'])[1]" );
                    expect( summaryText ).ToBeString();
                    expect( summaryText ).notToInclude( "There was an error trying to use summary service :'(" );
                });

            }else{
                // service unnavailable
                it("The service is NOT available, it should return a pre-defined error message", function(){
                    selenium.click("xpath=(//a[@class='summaryLink'])[1]");
                    summaryText = selenium.getText( "xpath=(//div[@class='modal-body'])[1]" );
                    expect( summaryText ).ToBe( "There was an error trying to use summary service :'(" );
                });
            }

            it("Should NOT have tags in the preview description", function(){

                printedPreview = selenium.getText( "xpath=(//div[@class='previewDiv'])[1]" );
                expect( printedPreview ).toBe( application.UDFs.stripHTML(printedPreview) );
            });

            it("AND that preview should have less than 200 chars", function(){
                expect( len(printedPreview) ).toBeLTE( 200 );
            });

        });

        //----------------------------------------------------------------------
        // Deleting Test article
        //----------------------------------------------------------------------
        describe("Deleting an article", function(){

            it("We should be able to delete the article we cretaed for this test", function(){
                selenium.open(browserUrl);
                selenium.waitForPageToLoad(timeout);

                // click on the article we've created for tests
                selenium.click("link=" & str_random_title);
                selenium.waitForPageToLoad(timeout);
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

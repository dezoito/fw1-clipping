/**
 * Tests the Applicatrion´s controllers
 *
 */
component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        // reinitialise ORM for the application
        ORMReload();

        // invoke controller object
        mainController = createObject("component", "root.home.controllers.main");

        // injects the framework into the tested controller
        mainController.framework = createObject("component", "framework.one");

        // binds service to main controller
        mainController.clippingService = createObject("component", "root.home.model.services.clippingService");

        // Mock request Context struct
        rc = structNew();

        //creates fake data for tests
        str_default_text = repeatString("<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. <br>Integer nec nulla ac justo viverra egestas.</p>", 10);
        for(i=1; i<=20; i=i+1){
            rc.Clipping_id = 0;
            rc.Clipping_titulo = createUUID();
            rc.Clipping_texto = str_default_text;
            rc.Clipping_link = "http://localhost/";
            rc.Clipping_fonte = "This is the source for the article";
            rc.Published = dateformat(now(), "dd/mm/yyyy"); // handle eurodates
            Clipping = mainController.clippingService.save(rc);
        }
    }

    // executes after all suites
    function afterAll(){
        // destroy test data (MAKE SURE YOU USE THE TEST DSN!!!)
        var q = new Query();
        q.setDatasource(application.datasource);
        q.setSQL("
            DROP TABLE tbl_clipping;
        ");
        q.execute();

        // clear first level cache and remove any unsaved objects
        ORMFlush();
        ORMClearSession();
    }


    function run( testResults, testBox ){

        describe("Main Controller: ", function(){

            beforeEach( function( currentSpec ){
                // don´t let rc persist through tests
                structClear(rc);
            });

            it("The DEFAULT method returns an ORM object with a list of articles", function(){
                // execute default method
                mainController.default( rc );
                expect( structKeyExists(rc, "qry_clipping")).toBeTrue();
                expect( rc.qry_clipping.count).toBe( 20 );
            });

        });

    }

}

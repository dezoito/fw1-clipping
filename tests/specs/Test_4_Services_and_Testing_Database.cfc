/**
 * Runs CRUD tests against a testing database
 * for this, we created a test database "dtb_clipping_test"
 * and a datasource with the same name
 *
 */
component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        // How to dump application settings
        // dump(application.getApplicationSettings());

        // reinitialise ORM for the application
        ORMReload();

        // initialize ORM, Services, create and populate the tables we need
        clippingService = createObject("component", "root.home.model.services.clippingService");
        str_default_text = repeatString("<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. <br>Integer nec nulla ac justo viverra egestas.</p>", 10);

        // add a few fake articles using ORM
        rc = structNew();
        for(i=1; i<=20; i=i+1){
            rc.Clipping_id = 0;
            rc.Clipping_titulo = createUUID();
            rc.Clipping_texto = str_default_text;
            rc.Clipping_link = "http://localhost/";
            rc.Clipping_fonte = "This is the source for the article";
            rc.Published = now(); // handle eurodates
            Clipping = clippingService.save(rc);
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

    // All suites go in here
    function run( testResults, testBox ){

        // --------- tests using SQL --------------
        describe("Can run SQL on the TEST DATABASE: " & application.datasource, function(){

            var queryObj = new query();
            queryObj.setDatasource(application.datasource);

            it("Must be able to access tables on the database", function(){
                queryObj.setName("qry_show_tables");
                result = queryObj.execute(sql="show tables ");
                qry_show_tables = result.getResult();
                metaInfo = result.getPrefix();

                expect( qry_show_tables ).toBeTypeOf( "query" );
            });

            it("Must be able to query clipping table", function(){
                queryObj.setName("qry_clipping");
                result = queryObj.execute(sql="select count(clipping_id) as total from tbl_clipping");
                qry_clipping = result.getResult();
                metaInfo = result.getPrefix();

                expect( qry_clipping ).toBeTypeOf( "query" );
            });

            it("Querying clipping table should take less than 500ms", function(){
                queryObj.setName("qry_clipping");
                result = queryObj.execute(sql="select count(clipping_id) as total from tbl_clipping");
                qry_clipping = result.getResult();
                metaInfo = result.getPrefix();

                expect( metainfo.executionTime ).toBeLt( 500 );
            });

            it("Must be able to query clipping table (using params)", function(){
                queryObj.setName("qry_clipping");
                queryObj.addParam(name="clipping_id",value="0",cfsqltype="NUMERIC");
                result = queryObj.execute(sql="select count(clipping_id) as total from tbl_clipping WHERE clipping_id >= :clipping_id");
                qry_clipping = result.getResult();
                metaInfo = result.getPrefix();
                queryObj.clearParams();
                // dump(metaInfo);
                // dump(qry_clipping);

                expect( qry_clipping ).toBeTypeOf( "query" );
            });
        });


        // --------- tests using ORM --------------
        describe("Using ORM", function(){

            it("Clipping table must contain exactly 20 records", function(){
                // run simple query
                var totalhql = "select count(id) as total from clipping";
                var result.count = ormExecuteQuery(totalhql, true);
                expect( result.count ).toBe( 20 );
            });

            it("Must be able to load a single instance by ID", function(){
                C = entityLoadByPk("clipping", 1);
                expect( C ).toBeTypeOf( "Component" );
            });

            it("Must be able to update an instance of a Clipping article", function(){
                strNewTitle = "This is an updated title"
                C.Clipping_titulo = strNewTitle;
                ORMFlush();
                C = entityLoadByPk("clipping", 1);
                expect( C.Clipping_titulo ).toBe( strNewTitle );
            });

            it("Must be able to delete instances", function(){
                entityDelete(C);
                ORMFlush();
                var totalhql = "select count(id) as total from clipping";
                var result.count = ormExecuteQuery(totalhql, true);
                expect( result.count ).toBe( 19 );
            });
        });


        // --------- Services Layer Tests --------------
        describe("The clippingService", function(){

            it("Must return a struct with an array clipping objects", function(){
                clippingList = clippingService.list();
                // dump(clippingList);
                expect( clippingList.count ).toBe( 19 ); // we deleted one record already
                expect( clippingList ).toBeTypeOf( "struct" );
                expect( clippingList.data ).toBeTypeOf( "array" );
                expect( clippingList.data[1].getClipping_texto()).toBe( str_default_text );
            });

            it("Must return #application.recordsPerPage# articles per page", function(){
                clippingList = clippingService.list();
                // dump(clippingList);
                expect( arrayLen(clippingList.data) ).toBe( application.recordsPerPage ); // we deleted one record already
            });

            it("Must be able to update records ", function(){

                // get a single article
                Clipping = clippingService.getClipping(2);

                //define new data for the update
                rc = structNew();
                rc.Clipping_id = Clipping.getClipping_id();
                rc.Clipping_titulo = "LEGLOCK";
                rc.Clipping_texto = "REVERSE";
                rc.Clipping_link = "ABRACADABRA";
                rc.Clipping_fonte = ""; //this is OK
                rc.Published = "01/01/2015"; // invalid empty date

                // update the instance with new data
                clippingService.save( rc );

                // requery the article to see if data changed
                updatedClipping = clippingService.getClipping(2);

                expect( updatedClipping.getClipping_texto()).toBe( "REVERSE" );
                expect( updatedClipping.getClipping_titulo()).toBe( "LEGLOCK" );
            });

            it("Must validate input before inserting new clipping articles", function(){
                rc = structNew();
                rc.Clipping_id = 0;
                rc.Clipping_titulo = "";
                rc.Clipping_texto = "";
                rc.Clipping_link = "ABRACADABRA";
                rc.Clipping_fonte = ""; //this is OK
                rc.Published = ""; // invalid empty date

                // attempts validation with horrible data
                isValidForm = clippingService.validate( rc );

                expect( isValidForm ).toBe( false );
                expect( rc.stErrors ).toBeTypeOf( "struct" );
                expect( StructKeyExists(rc.stErrors, "clipping_titulo") ).toBe( true );
                expect( StructKeyExists(rc.stErrors, "clipping_texto") ).toBe( true );
                expect( StructKeyExists(rc.stErrors, "clipping_link") ).toBe( true );
                expect( StructKeyExists(rc.stErrors, "clipping_fonte") ).toBe( false ); // empty is OK
                expect( StructKeyExists(rc.stErrors, "Published") ).toBe( true );
            });

            it("Must only allow valid dates in Eurodate format", function(){
                rc = structNew();
                rc.Clipping_id = 0;
                rc.Clipping_titulo = "";
                rc.Clipping_texto = "";
                rc.Clipping_link = "";
                rc.Clipping_fonte = "";

                rc.Published = "01/01/2015"; // OK
                isValidForm = clippingService.validate( rc );
                expect( StructKeyExists(rc.stErrors, "Published") ).toBe( false );// this one is ok

                rc.Published = "30/02/2015"; // Invalid
                isValidForm = clippingService.validate( rc );
                expect( StructKeyExists(rc.stErrors, "Published") ).toBe( true );

                rc.Published = "01/15/2015"; // Invalid
                isValidForm = clippingService.validate( rc );
                expect( StructKeyExists(rc.stErrors, "Published") ).toBe( true );

                rc.Published = "01012015"; // Not Eurodate
                isValidForm = clippingService.validate( rc );
                expect( StructKeyExists(rc.stErrors, "Published") ).toBe( true );

                rc.Published = "2015/01/01"; // Not Eurodate
                isValidForm = clippingService.validate( rc );
                expect( StructKeyExists(rc.stErrors, "Published") ).toBe( true );

                rc.Published = "notevenadate"; // Not Eurodate
                isValidForm = clippingService.validate( rc );
                expect( StructKeyExists(rc.stErrors, "Published") ).toBe( true );
            });


        });

    }
}

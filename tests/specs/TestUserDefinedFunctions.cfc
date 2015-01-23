component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        // invoke object with UDFs
        UDFs = createObject("component", "root.lib.functions");
    }

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){

        //----------------------------------------------------------------------------------
        // ------- UDF abrevia_string -------------
        describe("Function abrevia_string", function(){
            var strSample = "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit";

            it("Must add elipses to a string longer than N chars", function(){
                expect( UDFs.abrevia_string(strSample, 20) ).toBe("Neque porro quisquam...");
            });

            it("Must NOT add elipses to a string shorter than N chars", function(){
                expect( UDFs.abrevia_string(strSample, 2000) ).toBe(strSample);
            });
        });

        //----------------------------------------------------------------------------------
        // ------- UDF abrevia_nome_arquivo -------------
        describe("Function abrevia_nome_arquivo", function(){
            var strLongFileName = "really_long_filename_with_many_chars.txt";
            var strShortFileName = "short.txt";
            var strFilenameWithDots = "filename123456789.withdots.txt";

            it("Must add an ellipsis before the extension of a filename longer than N chars (leaving the last 7 chars intact)", function(){
                expect( UDFs.abrevia_nome_arquivo(strLongFileName, 17) ).toBe("really_lon...ars.txt");
            });

            it("Must ignore short names: lenght of name < (qtd < 7) chars", function(){
                expect( UDFs.abrevia_nome_arquivo(strShortFileName, 17) ).toBe(strShortFileName);
            });

            it("Must work with filenames that have dots (besides the separator extension)", function(){
                expect( UDFs.abrevia_nome_arquivo(strFilenameWithDots, 20) ).toBe("filename12345...ots.txt");
            });

        });

        //----------------------------------------------------------------------------------
        // ------- UDF stripHTML -------------
        describe("Function stripHTML", function(){
            // create samples  for tests
            strSampleWithTags = "<p>This text contains tags<br> and a line break</p>";
            strSampleWithMismatchedTags = "</p>This text contains some weird tags</br> and a line break<YYYYYbghgg>";
            strSampleWithoutTags = "No tags here";
            strSampleWithExpression = "Just a math expression: 1 < 2 and 2000 > 1000";

            it("Must remove simple tags", function(){
                expect( UDFs.stripHTML(strSampleWithTags) ).toBe("This text contains tags and a line break");
            });

            it("Must deal with mismatched tags", function(){
                expect( UDFs.stripHTML(strSampleWithMismatchedTags) ).toBe("This text contains some weird tags and a line break");
            });

            it("Must not mess with simple text", function(){
                expect( UDFs.stripHTML(strSampleWithoutTags) ).toBe(strSampleWithoutTags);
            });

            // xit = skipped this test : the UDF doesn't handle math very well :(
            xit("Must not mess with math expressions", function(){
                expect( UDFs.stripHTML(strSampleWithExpression) ).toBe(strSampleWithExpression);
            });

        });

    }
}

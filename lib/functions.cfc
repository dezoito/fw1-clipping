<!-------------------------------------------------------------
Contains UDFs that are available through the application scope.

EXAMPLE

cleanStr = application.stripHTML(some_string);

or

<p>#application.stripHTML(some_string)#</p>
--------------------------------------------------------------->
<cfcomponent cacheUse="read-only" output="false">

    <cfscript>
        /**
         * stripHTML description: removes HTML tags from a string
         */
        string function stripHTML(str) output="false" {
            return REReplaceNoCase(arguments.str,"<[^>]*>","","ALL");
        }
        application.stripHTML = stripHTML;

        /**
         * copyPropertiesToRC
         * description: copies to the Request Context structures
         * all the properties that can be accessed through getter methods
         * (this is useful when returning ORM querie values to the rc to fill a form)
         */
        string function copyPropertiesToRC(obj, rc) output="true" returnType="struct" {
            for (key in obj) {
                // only use getters (ie: getId, getName, etc...)
                if(left(key, 3) == "get"){
                    // extract propertie name and add it (and the value) to RC
                    str_property = (mid(key,4,len(key)));
                    if(!StructKeyExists(rc, str_property)){
                        structInsert(rc,str_property,evaluate("obj." & key & "()"));
                    }
                }
            }
            return rc;
        }
        application.copyPropertiesToRC = copyPropertiesToRC;

    </cfscript>

</cfcomponent>


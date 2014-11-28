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
         * copyORMPropertiesToStruct
         * description: copies to the target structure (usually RC)
         * all the properties that can be accessed through getter methods of the Object
         * (this is useful when returning ORM querie values to the rc to fill a form)
         */
        string function copyORMPropertiesToStruct(obj, rcStruct) output="true" returnType="struct" {
            for (key in obj) {
                // only use getters (ie: getId, getName, etc...)
                if(left(key, 3) == "get"){
                    // extract property name and add or update it on the target struct
                    str_property = (mid(key,4,len(key)));
                    if(!StructKeyExists(rcStruct, str_property)){
                        structInsert(rcStruct,str_property,evaluate("obj." & key & "()"));
                    } else {
                        structUpdate(rcStruct,str_property,evaluate("obj." & key & "()"));
                    }
                }
            }
            return rcStruct;
        }
        application.copyORMPropertiesToStruct = copyORMPropertiesToStruct;

    </cfscript>

</cfcomponent>


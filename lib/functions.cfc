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

    </cfscript>

</cfcomponent>


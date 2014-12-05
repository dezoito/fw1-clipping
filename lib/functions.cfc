<!-------------------------------------------------------------
Contains UDFs that are available through the application scope.

EXAMPLE:

cleanStr = application.stripHTML(some_string);
or
<p>#application.stripHTML(some_string)#</p>
--------------------------------------------------------------->

<cfcomponent cacheUse="read-only" output="false">

    <cfscript>
        /**
         * prevents CSRF attacks by checking for valid CSRF Tokens
         */
        function preventCSRFAttack( struct rc ){
            if(!structKeyExists(rc, "csrfToken") || (!CSRFVerifyToken(rc.csrfToken))){
                abort showerror="Invalid CSRF Token...aborting execution.";
            }
        }
        application.preventCSRFAttack = preventCSRFAttack;

        /**
         * stripHTML description: removes HTML tags from a string
         * (from http://www.cflib.org/udf/stripHTML)
         */
        string function stripHTML(str) output="false" {
            // return REReplaceNoCase(arguments.str,"<[^>]*>","","ALL");
            var str = reReplaceNoCase(str, "<*style.*?>(.*?)</style>","","all");
            var str = reReplaceNoCase(str, "<*script.*?>(.*?)</script>","","all");

            var str = reReplaceNoCase(str, "<.*?>","","all");
            //get partial html in front
            var str = reReplaceNoCase(str, "^.*?>","");
            //get partial html at end
            var str = reReplaceNoCase(str, "<.*$","");
            return trim(str);
        }
        application.stripHTML = stripHTML;

        /**
         * removes a selection of BAD HTML tags and JS events
         * (useful to display HTML rich content)
         * (from http://www.cflib.org/udf/safetext)
         */
        function safetext(text) {
            //default mode is "escape"
            var mode = "escape";
            //the things to strip out (badTags are HTML tags to strip and badEvents are intra-tag stuff to kill)
            //you can change this list to suit your needs
            var badTags = "SCRIPT,OBJECT,APPLET,EMBED,FORM,LAYER,ILAYER,FRAME,IFRAME,FRAMESET,PARAM,META";
            var badEvents = "onClick,onDblClick,onKeyDown,onKeyPress,onKeyUp,onMouseDown,onMouseOut,onMouseUp,onMouseOver,onBlur,onChange,onFocus,onSelect,javascript:";
            var stripperRE = "";

            //set up variable to parse and while we're at it trim white space
            var theText = trim(text);
            //find the first open bracket to start parsing
            var obracket = find("<",theText);
            //var for badTag
            var badTag = "";
            //var for the next start in the parse loop
            var nextStart = "";
            //if there is more than one argument and the second argument is boolean TRUE, we are stripping
            if(arraylen(arguments) GT 1 AND isBoolean(arguments[2]) AND arguments[2]) mode = "strip";
            if(arraylen(arguments) GT 2 and len(arguments[3])) badTags = arguments[3];
            if(arraylen(arguments) GT 3 and len(arguments[4])) badEvents = arguments[4];
            //the regular expression used to stip tags
            stripperRE = "</?(" & listChangeDelims(badTags,"|") & ")[^>]*>";
            //Deal with "smart quotes" and other "special" chars from MS Word
            theText = replaceList(theText,chr(8216) & "," & chr(8217) & "," & chr(8220) & "," & chr(8221) & "," & chr(8212) & "," & chr(8213) & "," & chr(8230),"',',"","",--,--,...");
            //if escaping, run through the code bracket by bracket and escape the bad tags.
            if(mode is "escape"){
                //go until no more open brackets to find
                while(obracket){
                    //find the next instance of one of the bad tags
                    badTag = REFindNoCase(stripperRE,theText,obracket,1);
                    //if a bad tag is found, escape it
                    if(badTag.pos[1]){
                        theText = replace(theText,mid(TheText,badtag.pos[1],badtag.len[1]),HTMLEditFormat(mid(TheText,badtag.pos[1],badtag.len[1])),"ALL");
                        nextStart = badTag.pos[1] + badTag.len[1];
                    }
                    //if no bad tag is found, move on
                    else{
                        nextStart = obracket + 1;
                    }
                    //find the next open bracket
                    obracket = find("<",theText,nextStart);
                }
            }
            //if not escaping, assume stripping
            else{
                theText = REReplaceNoCase(theText,stripperRE,"","ALL");
            }
            //now kill the bad "events" (intra tag text)
            theText = REReplaceNoCase(theText,'(#ListChangeDelims(badEvents,"|")#)[^ >]*',"","ALL");
            //return theText
            return theText;
        }
        application.safetext = safetext;


        // ---------------------------------------------------------------------
        // *old* custom UDFs added for compatibility
        // (sorry for leaving some parts in Portuguese)
        // ---------------------------------------------------------------------

        /**
         * Esta função apenas retornará uma string com a quantidade de
         * caracteres determinado pelo usuário como se estivesse abreviada,
         * mais os últimos 7 caracteres do nom incluindo a extensão.
         * ex: #abrevia_nome_arquivo(superLongFileName.txt, "5")# - RETORNS: "supe_...me.txt"
         */
        function abrevia_nome_arquivo(texto, qtd)
        {
            if(len(texto) gt (qtd-7)){
                var texto = mid(texto, "1", (qtd-7)) & "..." & right(upload_nome, 7);
            }
            return texto;
        }
        application.abrevia_nome_arquivo = abrevia_nome_arquivo;

        /**
         * Slices a string at QTD chars and adds "..." at the end
         * Ex: #abrevia_string(a casa é de papel, "5")# - RETORNO: "a cas..."
         */
        function abrevia_string(texto, qtd){
            if(len(texto) gt qtd)
            {
                var texto = mid(texto, "1", qtd) & "...";
            }
            return texto;
        }
        application.abrevia_string = abrevia_string;

        /**
         * Brazilian Decimal format (needed after CFMX changed things)
         */
        function decimal_format_br(numero){
            if(listfirst(Server.ColdFusion.ProductVersion) GTE "6"){
                var texto = replace(decimalformat(numero), ".", "", "ALL");
                var texto = replace(texto, ",",  ".", "ALL");
            }else{
                var texto = replace(decimalformat(numero), ",", "", "ALL");
            }

            return texto;
        }
        application.decimal_format_br = decimal_format_br;

        /**
         * define_virgula: use it in a query to separate records by commas (except the last)
         * so we have something like reg1, reg2, reg3.....regn.
         */
        function define_virgula(currentrow, recordcount){
            if(currentrow neq recordcount)
            {
                var texto = ", ";
            }
            else
            {
                var texto="";
            }
            return texto;
        }
        application.define_virgula = define_virgula;

        /**
         * formata_label: generates a "slug", removing funky characters from a string
         */
        function formata_label(texto){
            //Substitui caracteres acentuados pelos mesmos caracteres s/ acentuação, em uma nova variável
            var label_s_acentos = trim(replacelist(texto, "á,é,í,ó,ú,ç,ã,õ,à,ô,ê", "a,e,i,o,u,c,a,o,a,o,e"));
            var label_s_acentos = replacelist(label_s_acentos, "Á,É,Í,Ó,Ú,Ç,Ã,Õ,À,Ô,Ê", "A,E,I,O,U,C,A,O,A,O,E");

            // retira caracteres indesejados
            var label_s_acentos = replace(label_s_acentos, "|", "_", "ALL");
            var label_s_acentos = replace(label_s_acentos, ",", "_", "ALL");
            var label_final = replace(label_s_acentos, " ", "_", "ALL");
            return label_final;
        }
        application.formata_label = formata_label;

        /**
         *  Prepares a string to be inserted (or updated on a DB):
         *  - rememoves extra espaces
         *  - removes unnecessary single quotes
         *  - keeps numeral characters consistent
         */
        function prepara_string(texto){
            return application.remove_aspas_simples_extras(application.normaliza_numeral(application.remove_espaco_extra(trim(texto))));
        }
        application.prepara_string = prepara_string;

        /**
         *  Prepares a string to be inserted (or updated on a DB):
         *  - removes unnecessary single quotes
         */
        function remove_aspas_simples_extras(texto){
            return rereplace(texto, "('+)", "''", "all");
        }
        application.remove_aspas_simples_extras = remove_aspas_simples_extras;

        /**
         *  - rememoves extra espaces: "  " --> " "
         */
        function remove_espaco_extra(texto){
            return rereplace(texto, "( +)", " ", "all");
        }
        application.remove_espaco_extra = remove_espaco_extra;

                 /**
                  *  - keeps numeral characters consistent
                  * troca numeral "errado" pelo ASC 167
                  */
        function normaliza_numeral(texto)
        {
            return replace(texto, "°", "º", "all");
        }
        application.normaliza_numeral = normaliza_numeral;

    </cfscript>

</cfcomponent>


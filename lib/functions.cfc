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
         * stripHTML description: removes HTML tags from a string
         */
        string function stripHTML(str) output="false" {
            return REReplaceNoCase(arguments.str,"<[^>]*>","","ALL");
        }
        application.stripHTML = stripHTML;


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
                texto = mid(texto, "1", (qtd-7)) & "..." & right(upload_nome, 7);
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
                texto = mid(texto, "1", qtd) & "...";
            }
            return texto;
        }
        application.abrevia_string = abrevia_string;

        /**
         * Brazilian Decimal format (needed after CFMX changed things)
         */
        function decimal_format_br(numero){
            if(listfirst(Server.ColdFusion.ProductVersion) GTE "6"){
                texto = replace(decimalformat(numero), ".", "", "ALL");
                texto = replace(texto, ",",  ".", "ALL");
            }else{
                texto = replace(decimalformat(numero), ",", "", "ALL");
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
                texto = ", ";
            }
            else
            {
                texto="";
            }
            return texto;
        }
        application.define_virgula = define_virgula;

        /**
         * formata_label: generates a "slug", removing funky characters from a string
         */
        function formata_label(texto){
            //Substitui caracteres acentuados pelos mesmos caracteres s/ acentuação, em uma nova variável
            label_s_acentos = trim(replacelist(texto, "á,é,í,ó,ú,ç,ã,õ,à,ô,ê", "a,e,i,o,u,c,a,o,a,o,e"));
            label_s_acentos = replacelist(label_s_acentos, "Á,É,Í,Ó,Ú,Ç,Ã,Õ,À,Ô,Ê", "A,E,I,O,U,C,A,O,A,O,E");

            // retira caracteres indesejados
            label_s_acentos = replace(label_s_acentos, "|", "_", "ALL");
            label_s_acentos = replace(label_s_acentos, ",", "_", "ALL");
            label_final = replace(label_s_acentos, " ", "_", "ALL");
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


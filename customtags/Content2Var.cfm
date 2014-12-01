<CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: CustomTag

	TEMPLATE: CF_Content2Var

	Armazena o conteúdo que a tag involve numa var de Coldfusion,
	que pode ou não ser prefixada

	ATRIBUTOS:
	Field: Nome do campo que será gerado:

	Exemplos:

	<CF_Content2var	Field="Whatever">
	A B C D
	</CF_Content2var>

	Gera o seguinte campo:



 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<!---		Verifica se a tag foi fechada		 --->
<CFIF NOT THISTAG.HASENDTAG>
	<CFSET THISTAG.GENERATEDCONTENT="">
	<CFOUTPUT>You must have an end Tag</CFOUTPUT>
	<CFABORT>
</CFIF>

<!---		Verifica se foi setado o atributo "field"		 --->
<CFIF NOT ISDEFINED("ATTRIBUTES.Field")>
	<CFOUTPUT>ERRO: Por favor especifique o campo Field</CFOUTPUT>
	<CFABORT>
</CFIF>

<CFSET FIELD = ATTRIBUTES.FIELD>

<!---		A tag está iniciando ou terminando ?		 --->
<CFSWITCH EXPRESSION="#thistag.executionmode#">

	<!---		Início		 --->
	<CFCASE VALUE="start">
	</CFCASE>


	<!---		Fim		 --->
	<CFCASE VALUE="end">
	<!---		Cria um campo hidden com o conteúdo que foi gerado dentro desta tag		 --->

		<CFSET Content =THISTAG.GENERATEDCONTENT>
		<CFSET X = SetVariable(field, Content)>

	</CFCASE>
</CFSWITCH>
<CFSETTING ENABLECFOUTPUTONLY="NO">

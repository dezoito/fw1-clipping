<cfsetting enablecfoutputonly="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: CustomTag

	TEMPLATE: CF_ContentReplace_v2

	Faz um Replace Simples ou NoCase, no conteúdo gerado dentro da tag

	V2.0
	Corrige Bug de cx alta/baixa
	Permite BYPASS de replace se o param input for uma string nula

	ATRIBUTOS:
	IN = String que vememos achar
	OUT = Palavra que deve substituir
	Scope = ONE ou ALL -- número de substituições (Default = ALL)
	NOCASE = Especifica se devemos ignorar o Case (Default = NO)
	Exemplos:

	<CF_ContentReplace
	INPUT = "OBJECT">
	OUTPUT = "APPLET"
	SCOPE="ALL"
	>


	Conteúdo Aqui

	</CF_ContentReplace>


 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->


<!---		Verifica se a tag foi fechada		 --->
<cfif not thistag.hasendtag>
	<cfset thistag.generatedcontent="">
	You must have an end Tag
	<cfabort>
</cfif>




	<!---		Verifica se foi setado o atributo "INPUT"		 --->
	<cfif not isdefined("ATTRIBUTES.INPUT")>
		<cfoutput>ERRO: Por favor especifique o campo INPUT</cfoutput>
		<cfabort>
	</cfif>

	<cfif len(trim(attributes.input))>

	<!---		Verifica se foi setado o atributo "OUTPUT"		 --->
	<cfif not isdefined("ATTRIBUTES.OUTPUT")>
		<cfoutput>ERRO: Por favor especifique o campo OUTPUT</cfoutput>
		<cfabort>

	</cfif>

	<cfparam name="ATTRIBUTES.SCOPE" default="ALL">
	<cfparam name="ATTRIBUTES.NOCASE" default="No">

	<cfset input = attributes.input>
	<cfset output = attributes.output>
	<cfset scope = attributes.scope>
	<cfset nocase = attributes.nocase>



	<!---		A tag está iniciando ou terminando ?		 --->
	<cfswitch expression="#thistag.executionmode#">

		<!---		Início		 --->
		<cfcase value="start">
		</cfcase>


		<!---		Fim		 --->
		<cfcase value="end">
			<cfset content =thistag.generatedcontent>



				<!---		Replace simples ou NOCASE		 --->
				<cfif nocase>
					<cfset content = #replacenocase(content, input, output, scope)#>
				<cfelse>
					<cfset content = #replacenocase(content, input, output, scope)#>
				</cfif>

				<!---		Faz com que o conteúdo retornado por esta tag seja igual ao que acabamos de fazero replace		 --->
				<cfset thistag.generatedcontent = content >

		</cfcase>
	</cfswitch>
</cfif>

<cfsetting enablecfoutputonly="NO">

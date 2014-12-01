<cfsetting enablecfoutputonly="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --
	PROJETO: CustomTag - Dump Query Text
	
	TEMPLATE: dump_query_text.cfm		[23/01/2006]	FCR

	Retorna os resultados de uma consulta, SEM os nomes de colunas
	separados apenas por tabulações.
	
	Estes resultados são uteis como forma de preencher índices, tanto em campos TEXT do SQL server ou Otacle, 
	quanto em collections de verity
	
	ALTERAÇÕES:



	RECEBE: qry
	RETORNA: qry_text
	
	DEPENDENCIAS:
	Content2var.cfm
				
	EXEMPLO:
		<cfmofule template="../../customtags/dump_query_text.cfm"
			qry="#consulta#"
			>
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<!--- verificar se foi definido o texto para o alerta --->
<cfif not isdefined("attributes.qry")>
	<cfoutput><p>Esta TAG necessita de uma consulta !</cfoutput>
	<cfabort>
</cfif>

<cfset qry= attributes.qry>
<cfset l_colunas=qry.columnlist>


	<!---		armazena o conteudo gerado dentro da tag numa var		 --->
	<CF_Content2var	Field="request.qry_text">
		<!---		para cada linha na consulta, apresentar os VALORES de cada coluna		 --->
		<!---		separados por TAB		 --->
		<cfoutput query="qry">
			<cfloop index="coluna" list="#l_colunas#">#evaluate(coluna)#	</cfloop>
		</cfoutput>
	</CF_Content2var>
	

	<cfset caller.qry_text=trim(request.qry_text)>

<cfsetting enablecfoutputonly="No">



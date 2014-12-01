

<!---		primeira execução		 --->
<cfif NOT isdefined("attributes.qry_arquivos")>

<!---		lista arquivos no dir inicial		 --->
	<cfdirectory action="LIST" 
		directory="#attributes.path_arquivos#" 
		name="qry_arquivos" 
		sort="Name">
		

		<!---		concatena path ao nome de arquivos e diretórios		 --->
		<cfoutput query="qry_arquivos">
				<cfset querysetcell(qry_arquivos, "name", "#attributes.path_arquivos##qry_arquivos.name#", currentrow)>		
		</cfoutput>
		
		<cfset qry_atual = qry_arquivos>
		<cfset request.qry = qry_arquivos>
		
<cfelse>

	<!---		lista qrquivos em subdiretório		 --->
	<cfdirectory action="LIST" 
		directory="#attributes.path_arquivos#" 
		name="qry_temp" 
		sort="Name">
		
		
		<!---		concatena path ao nome de arquivos e diretórios		 --->
		<!---		(apenas na consulta deste subdir)		 --->
		<cfoutput query="qry_temp">
				<cfset querysetcell(qry_temp, "name", "#attributes.path_arquivos##qry_temp.name#", currentrow)>		
		</cfoutput>		
		
		<!---		<cfoutput>#attributes.path_arquivos#</cfoutput>		 --->

	
	<!--- --- --- --- --- --- --- --- --- --- --- --- --- 
	UNION da consulta temporária com a consulta final
	 --- --- --- --- --- --- --- --- --- --- --- --- --->		
	<cfset qry_atual = qry_temp>
		
	<cfset qry_arquivos=request.qry>	
	<cfoutput query="qry_temp">
		<cfset queryaddrow(qry_arquivos)>
		<cfset querysetcell(qry_arquivos, "name", "#qry_temp.name#")>
		<cfset querysetcell(qry_arquivos, "size", "#qry_temp.size#")>
		<cfset querysetcell(qry_arquivos, "type", "#qry_temp.type#")>
		<cfset querysetcell(qry_arquivos, "datelastmodified", "#qry_temp.datelastmodified#")>
		<cfset querysetcell(qry_arquivos, "attributes", "#qry_temp.attributes#")>
		<cfset querysetcell(qry_arquivos, "mode", "#qry_temp.mode#")>	
	</cfoutput>
	
	<!---		"salva consulta concatenada em var de request"		 --->
	<cfset request.qry  = qry_arquivos>

</cfif>

<!---		loop pela consulta (apenas dir ou subdir atual)		 --->	
<cfoutput query="qry_atual">

	<cfif listlast(name, "\") neq "." 
		AND listlast(name, "\") neq "..">
	
		<cfset novo_path = name & "\">

		<!---		processar recursivamente subdiretórios		 --->
		<cfmodule template="dir_explorer.cfm"
			path_arquivos="#novo_path#"
			qry_arquivos="#qry_arquivos#">		
			
	</cfif>


</cfoutput>


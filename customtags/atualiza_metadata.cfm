<cfsilent>
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --
	PROJETO:

	TEMPLATE: atualiza_metadata.cfm		[16/01/2006]


	serializa os dados de um objeto e
	atualiza o campo correspondente em tbl_obj

	ALTERAÇÕES:
	23/01/2006 -FCR
	Passa a utilizar os dados em plaintext,
	gerados pela tag dump_query_text, ao invés de daods em WDDX,
	pois, ao serializar um objeto, os caracteres acentuados eram substituídos por
	códigos que impediam uma busca precisa



--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<!---		traz os dados atualizados		 --->
<cfmodule template="qry/qry_obj.cfm"
	obj_id="#attributes.obj_id#">

	<cfmodule template="dump_query_text.cfm"
	qry="#qry_obj#">

	<!---		atualiza		 --->
	<cfquery name="upd_metadata" datasource="#request.DSN#">
	UPDATE tbl_obj
	set obj_xml = '#qry_text#'
	WHERE obj_id = <cfqueryparam value="#attributes.obj_id#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>

<!--- --- --- --- --- --- --- --- --- --- --- --- ---
	<!---		serializar		 --->
	<cfwddx action="CFML2WDDX" input="#qry_obj#" output="wddx_obj">

	<!---		atualiza		 --->
	<cfquery name="upd_metadata" datasource="#request.DSN#">
	UPDATE tbl_obj
	set obj_xml = '#wddx_obj#'
	WHERE obj_id = <cfqueryparam value="#attributes.obj_id#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
 --- --- --- --- --- --- --- --- --- --- --- --- --->

</cfsilent>

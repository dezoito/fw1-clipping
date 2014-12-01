<cfsetting enablecfoutputonly="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: Custom Tag

	TEMPLATE: audit_evento.cfm
	versão 2.0: registra tabela Pai

	Esta Custom tag adiciona um evento numa tabela de auditoria.
	Ou seja, sempre que um usuário insere, atualiza ou exclui um registro
	(de determinadas tabelas apenas), esse evento fica registrado

	Os atributos (TODOS OBRIGATÓRIOS são)
	Tipo_Evento: I=Inserção; U=Atualização (Update); D=Exclusão (Delete)
				(15/01/2009):  Passa a registar R (reading) para LEITURA ou visualização de registro
	Tabela Nome da tabela que está sendo alterada
	Nome_Chave: Nome da Chave Primaria na tabela
	Id_Chave: Id do registro alterado

	ATRIBUTO OPCIONAL:
	StoreWDDX
	Quando presente, armazena o conteúdo do registro inteiro como
	um pacote WDDX, que pode ser deserializado para uma query.

	Isso é MUITO útil para históricos de atualização ....
	(é óbvio que, nestes casos, a tag deve ser invocada ANTES da alteração



EXEMPLO:

<!---		registra uma atualização de usuário --->
<cfmodule template="../audit_evento.cfm"
	tipo_evento="U"
	tabela="tbl_usuario"
	nome_chave = "Usuario_Id"
	id_chave="#Usuario_Id#">


	ALTERAÇÕES:
	16-01-2009 - FCR
	acrescentei os campos p. relacionamento com tabela pai
	:
	tabela_pai
	nome_chave_pai
	id_chave_pai
	audit_desc (breve descrição do fato auditado)

 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<!---		verifica atributos		 --->
<cfif not isdefined("ATTRIBUTES.Tipo_Evento")>
	<p>Erro !<br>
	A TAG CF_AUDIT_EVENTO Necessita do atributo <b>Tipo_Evento</b>
	<cfabort>

</cfif>

<cfif not isdefined("ATTRIBUTES.Tabela")>
	<p>Erro !<br>
	A TAG CF_AUDIT_EVENTO Necessita do atributo <b>Tabela</b>
	<cfabort>

</cfif>

<cfif not isdefined("ATTRIBUTES.Nome_Chave")>
	<p>Erro !<br>
	A TAG CF_AUDIT_EVENTO Necessita do atributo <b>Nome_Chave</b>
	<cfabort>

</cfif>

<cfif not isdefined("ATTRIBUTES.Id_Chave")>
	<p>Erro !<br>
	A TAG CF_AUDIT_EVENTO Necessita do atributo <b>Id_Chave</b>
	<cfabort>

</cfif>

 <!---		"localiza" as variáveis de sessão		 --->
	<cflock scope="session" timeout="3" type="READONLY">
		<cfset site_usuario_id = session.site_usuario_id>
	</cflock>

<!---		devemos armazenar o conteúdo antigo do registro ?		 --->
<cfif isdefined("ATTRIBUTES.StoreWDDX")>


	<cfquery name="qry_registro" datasource="#Request.DSN#">
		SELECT *
		 FROM #trim(ATTRIBUTES.Tabela)#
		WHERE #trim(ATTRIBUTES.Nome_Chave)#=#trim(ATTRIBUTES.Id_Chave)#
	</cfquery>

	<!---		serializa a consulta acima		 --->
	<cfwddx action="CFML2WDDX" input="#qry_registro#" output="Audit_WDDX" usetimezoneinfo="No">

</cfif>

<!---		Insere o evento na tabela de auditoria		 --->
<cfquery name="Ins_audit" datasource="#REQUEST.DSN#">
	INSERT INTO Tbl_Auditoria
	(
	Audit_Tipo_Evento,
	Audit_Tabela,
	Audit_Nome_Chave,
	Audit_Id_Chave,
	Usuario_Id
	<cfif isdefined("Audit_WDDX")>,Audit_WDDX</cfif>
	<cfif isdefined("attributes.tabela_pai")>,Audit_Tabela_Pai</cfif>
	<cfif isdefined("attributes.nome_chave_pai")>,Audit_Nome_Chave_Pai</cfif>
	<cfif isdefined("attributes.id_chave_pai")>,Audit_Id_Chave_Pai</cfif>
	<cfif isdefined("attributes.audit_desc")>,Audit_desc</cfif>

	)
	VALUES
	(
	'#trim(ATTRIBUTES.Tipo_Evento)#',
	'#trim(ATTRIBUTES.Tabela)#',
	'#trim(ATTRIBUTES.Nome_Chave)#',
	#trim(ATTRIBUTES.Id_Chave)#,
	#Site_Usuario_Id#
	<cfif isdefined("ATTRIBUTES.StoreWDDX")>,'#trim(Audit_WDDX)#'</cfif>
	<cfif isdefined("attributes.tabela_pai")>,'#trim(attributes.Tabela_Pai)#'</cfif>
	<cfif isdefined("attributes.nome_chave_pai")>,'#trim(attributes.Nome_Chave_Pai)#'</cfif>
	<cfif isdefined("attributes.id_chave_pai")>,#attributes.Id_Chave_Pai#</cfif>
	<cfif isdefined("attributes.audit_desc")>,'#trim(attributes.Audit_desc)#'</cfif>
	)
</cfquery>

 <cfsetting enablecfoutputonly="No">

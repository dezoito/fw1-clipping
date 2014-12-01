<cfsetting enablecfoutputonly="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: Custom Tag

	TEMPLATE: verifica_permissao.cfm		 (27/08/2001)

	Esta Custom tag verifica se um usuário possui uma determinada função relacionada a ele.
	Dependendendo da forma como ela é invocada, caso o usuário não possua uma determinada permissão

	- [apenas uma tag] - é gerada uma mensagem de erro ou retorna False (se utilizado o atributo TESTONLY)
	- [tag de abertura e fechamento]- o conteúdo ENTRE as tags não é apresentado


	IMPORTANTE:
	Esta TAG NÃO deve ser invocada por CF_MODULE


	ATRIBUTOS:
	PERMISSAO_ID : (obrigatório)
	TESTONLY (opcional): caso utilizado, indica que a tag irá retornar uma var
							(TRUE ou FALSE) indicando se o usuário possue ou não a
							permissão especificada.
							O nome "default" para esta var é verifica_permissao
	R_VARIABLE: (opcional) nome da var que retorna o teste de permissão,
								aplicável apenas se existe o param TESTONLY



	ALTERAÇÕES:
	04/10/2001 FCR
	no caso de ser chamada com a tag de fechamento, não irá processar CFML
	dentro da tag caso o usuário não possua a permissão (anteriormente só ocultava)


	10/10/2001 FCR
	Adicionei o attrib "r_variable", permitindo que o usuário escolha o nome da var
	que armazena o resultado de teste


	RECEBE: SESSION. Site_Usuario_ID
						permisao_id


			EXEMPLOS:

			<!---		protege a página inteira após a execução da tag:		 --->
			<cf_verifica_permissao
			permissao_id="11">

			<!---		verifica se um usuário possui uma permissão, retornando true ou false		 --->
			<cf_verifica_permissao
			permissao_id="11"
			testonly>

			<!---		protege um ítem de menu		 --->
			<cf_verifica_permissao
				permissao_id="11">
				.....	Algum ítem
			</cf_verifica_permissao >


 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
 <!---		verifica se foi passada uma permissão para a tag checar		 --->

<cfif not isdefined("ATTRIBUTES.PERMISSAO_ID")>
	<cfoutput>
	<p>Erro !<br>
	A TAG CF_verifica_permissao necessita do atributo Permissao_ID
	</cfoutput>
	 <cfsetting enablecfoutputonly="NO">
	<cfabort>

<cfelse>
	<!---		passa para escopo local		 --->
	<cfset permissao_id = trim(attributes.permissao_id)>

</cfif>


 <!---		"localiza" as variáveis de sessão		 --->
	<cflock scope="session" timeout="3" type="READONLY">
		<cfset site_usuario_id = session.site_usuario_id>
		<cfset site_usuario_lista_permissao = session.site_usuario_lista_permissao>
	</cflock>

<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
verifica se o usuário possui ou não a permissão:
caso possua, seta var booleana indicando isso, em caso contrário, decide
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<cfif not listcontains(site_usuario_lista_permissao, "'#Permissao_ID#'")>

	<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	decde se devemos mostrar uma mensagem de erro o ocultar
	o conteúdo dentro da tag.

	para tanto, vamos verificar se esta tag foi "fechada"
	 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
	 <cfif thistag.hasendtag>

	 <!---		terminar o processamento (dentro da tag)		 --->
	 	<cfif thistag.executionmode is "Start">
			 <cfsetting enablecfoutputonly="NO"><!---		importante		 --->
			<cfexit method="EXITTAG">	<!---		"pula" para o final da tag de fechamento		 --->
		</cfif>

	 <!---		ocultar conteúdo	(caso estejamos na tag de fechamento)	 --->
	 	<cfif thistag.executionmode is "End">
			<cfset thistag.generatedcontent = "">
		</cfif>


	 <cfelse>
	 <!---		exibir mensagem de erro ou retornar booleano		 --->

	 	<cfif isdefined("ATTRIBUTES.TESTONLY")>

			<!---		retorna var específica		 --->
		 	<cfif isdefined("ATTRIBUTES.R_VARIABLE")>
				<cfset temp = "Caller." & attributes.r_variable>
				<cfset temp = setvariable(temp, false)>
			<cfelse>
				<cfset caller.verifica_permissao = false>
			</cfif>


		<cfelse>

		 <!---		descobre o nome da função		 --->
		 <cfquery name="qry_permissao" datasource="#request.DSN#">
			SELECT *
			 FROM TBL_permissao
			WHERE Permissao_ID = #Permissao_ID#
		</cfquery>


	 	<cfoutput>
			<div align="center">
				<div align="left" style="background-color: f0f0f0; width: 500; padding: 5 5 5 5;">
				<!---		O usuário não pode executar esta função		 --->
				<font size="2" face="arial" color="RED">
					<p>&nbsp;<p>
					O usuário atual não tem permissão para executar esta função do sistema:
					</font>
					<p>
					<b><font size="+1">#qry_permissao.permissao_nome#</font></b><br>
					Descrição: #qry_permissao.permissao_descricao#
					<font color="GRAY">
					<p>Tente efetuar o Login como outro usuário, ou consulte o administrador do sistema.
					<hr align="LEFT" size="1" width="90%">

					Usuário: <b>#SESSION.Site_Usuario_Nome#</b><br>
					Endereço IP: #REMOTE_ADDR#<br>
					<!--- --- --- --- --- --- --- --- --- --- --- --- ---
										CFTOKEN: #CFTOKEN#<br>
										CFID: #CFID#
					 --- --- --- --- --- --- --- --- --- --- --- --- --->
					</font>
					<br>
					<br>

				</div>
			</div>
		</cfoutput>

		 <cfsetting enablecfoutputonly="NO"><!---		importante		 --->
		<cfabort>

		</cfif> <!---		mostrar erro ou retorna boolean		 --->

	</cfif><!---		 a tag foi fechada		 --->

<cfelse>
			<!---		retorna var específica		 --->
		 	<cfif isdefined("ATTRIBUTES.R_VARIABLE")>
				<cfset temp = "Caller." & attributes.r_variable>
				<cfset temp = setvariable(temp, true)>
			<cfelse>
				<cfset caller.verifica_permissao = true>
			</cfif>
</cfif>

 <cfsetting enablecfoutputonly="NO">

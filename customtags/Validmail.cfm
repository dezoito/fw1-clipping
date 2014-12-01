<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
********************************** CUSTOM TAG **********************************

	TEMPLATE: ValidMail.cfm				NOME: Kléber Kihara

	Esta CustomTag irá verificar se o e-mail informado é válido ou não. Se
	não for válido retornará autmaticamente para o formulário anterior.

	ALTERAÇÕES:

	RECEBE:
		Mail (obrigatório) - Define o e-mail que deveremos validar, para
			o script, que invocou a CustomTag.
	RETORNA:
		ValidMail - Define se o e-mail está, ou não, correto (True ou Fal-
			se).

	EXEMPLOS:

<CF_ValidMail
	MAIL="seunome@empresa.com.br">	

<CFMODULE TEMPLATE="../../CustomTags/ValidMail.cfm"
	MAIL="seunome@empresa.com.br">
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<!---	Iremos criar uma valor "Default", que irá definir que o e-mail está correto	--->
<CFSET ValidMail = True>

<!---	Iremos armazenar todos os parâmetros recebidos, em variáveis locais	--->
<CFSET Mail = Trim(Attributes.Mail)>

<!---	Iremos verificar se o e-mail recebido pode ser verificado pela CustomTag	--->
<CFIF Mail IS NOT "">

	<!---	Iremos verificar se o e-mail que recebemos tem apenas uma arroba (@)	--->
	<CFIF ListLen(Mail, "@") IS NOT 2>

		<CFSET ValidMail = False>

	</CFIF>



	<!---	Iremos verificar se o e-mail que recebemos tem ao menos um ponto (.)	--->
	<CFIF ListLen(Mail, ".") LT 2>

		<CFSET ValidMail = False>

	</CFIF>


	<!---	Iremos verificar se o e-mail tem ao menos um ponto (.), após a arroba (@)	--->
	<CFIF ListLen(ListLast(Mail, "@"), ".") LT 2>

		<CFSET ValidMail = False>

	</CFIF>

	
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	COMENTADO POR Mário K. [18/10/2001]
	- Se o usuário tiver um e-mail contendo pontos antes da arroba 
	(ex: impacsis.informatica@.impacsis.com.br), a validação abaixo
	não aceita.
	<!---	Iremos verificar se o e-mail contém algum ponto (.), antes da arroba (@)	--->
	<CFIF ListLen(ListFirst(Mail, "@"), ".") GT 1>

		<CFSET ValidMail = False>

	</CFIF>
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
</CFIF>

<!---	Iremos retornar para o Script, se o e-mail recebido está, ou não, correto	--->
<CFSET Caller.ValidMail = ValidMail>
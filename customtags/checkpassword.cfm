<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	DATA: 11/09/2001

	PROJETO: CustomTags								NOME: Kléber Kihara
	TEMPLATE: checkpassword.cfm

	Iremos validar uma determinada "senha", verificando se a mesma satisfaz certas regras. Sen-
	do que, estas "regras de validação" deverão ser definidas, juntamente com a senha.

	ALTERAÇÕES:

	RECEBE:
		Password (obrigatório) - Define a senha que deveremos validar;
		Type (obrigatório) - Define que "tipo de senha" deveremos autorizar:
			- AlphaNumeric;
			- Alpha;
			- Numeric;
		MinLength (opcional) - Define a quantidade mínima de caractéres;
		MaxLength (opcional) - Define a quantidade máxima de caractéres;
		ContainSpecialChar (opcional) - Define se a senha deve, obrigatoriamente, conter
			"caractéres especiais" (ex: !, @, #, $, etc.);
		InvalidChars (opcional) - Define determinados caractéres como inválidos;
			Obs: Os caractéres inválidos não devem ser separados por vírgula (Ex: abcd);
		ReturnMessage (opcional) - Define se devemos, ou não, retornar uma "Mensagem Pa-
			drão" de erro;

	RETORNA:
		CheckPassword (obrigatório) - Define se a senha informada é realmente válida;
		CheckPasswordMessage (opcional) - Define uma "mensagem padrão" de erro;
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<CFSET Password_Status = 1>
<CFSET Password_Message = "">

<!---	Iremos definir "valores padrão" para todas as "regras de validação"	--->
<CFPARAM NAME="Attributes.Password" DEFAULT="">
<CFPARAM NAME="Attributes.Type" DEFAULT="alphanumeric">
<CFPARAM NAME="Attributes.MinLength" DEFAULT="">
<CFPARAM NAME="Attributes.MaxLength" DEFAULT="">
<CFPARAM NAME="Attributes.ContainSpecialChar" DEFAULT="No">
<CFPARAM NAME="Attributes.InvalidChars" DEFAULT="">
<CFPARAM NAME="Attributes.ReturnMessage" DEFAULT="No">

<!---	Iremos verificar se a Senha informada, satisfaz o "Tipo de Senha"	--->
<!---	Obs: Alfa-Numérico - A senha deverá ter ambos os tipos de caractér	--->
<CFIF LCase(Attributes.Type) IS "alphanumeric">

	<CFIF ReFind("[A-Za-z]", Attributes.Password) IS 0>

		<CFSET Password_Status = 0>

	</CFIF>

	<CFIF ReFind("[0-9]", Attributes.Password) IS 0>

		<CFSET Password_Status = 0>

	</CFIF>

	<CFIF Password_Status IS 0>

		<CFIF Attributes.ReturnMessage IS 1>

			<CFSET Password_Message = "A Senha deve ser composta por Letras e Números.\nPor favor, preencha corretamente o campo Senha.">

		</CFIF>

	</CFIF>

<!---	Obs: Alfa - A senha não deverá conter nenhum "caractér numérico"	--->
<CFELSEIF LCase(Attributes.Type) IS "alpha">

	<CFIF ReFind("[0-9]", Attributes.Password) IS NOT 0>

		<CFSET Password_Status = 0>

		<CFIF Attributes.ReturnMessage IS 1>

			<CFSET Password_Message = "A Senha deve ser composta apenas por Letras.\nPor favor, preencha corretamente o campo Senha.">

		</CFIF>

	</CFIF>

<!---	Obs: Numérico - A senha deverá ser composta apenas por "Números"	--->
<CFELSEIF LCase(Attributes.Type) IS "numeric">

	<CFIF IsNumeric(Attributes.Password) IS "No">

		<CFSET Password_Status = 0>

		<CFIF Attributes.ReturnMessage IS 1>

			<CFSET Password_Message = "A Senha deve ser composta apenas por Números.\nPor favor, preencha corretamente o campo Senha.">

		</CFIF>

	</CFIF>

</CFIF>

<!---	Iremos verificar se a Senha contém o "mínimo de caractér" informado	--->
<CFIF Trim(Attributes.MinLength) IS NOT "" AND IsNumeric(Attributes.MinLength)>

	<CFIF Len(Attributes.Password) LT Attributes.MinLength>

		<CFSET Password_Status = 0>

		<CFIF Attributes.ReturnMessage IS 1>

			<CFSET Password_Message = "A Senha deve conter no mínimo #Attributes.MinLength# caractéres.\nPor favor, preencha corretamente o campo Senha.">

		</CFIF>

	</CFIF>

</CFIF>

<!---	Iremos verificar se a Senha contém o "máximo de caractér" informado	--->
<CFIF Trim(Attributes.MaxLength) IS NOT "" AND IsNumeric(Attributes.MaxLength)>

	<CFIF Len(Attributes.Password) GT Attributes.MaxLength>

		<CFSET Password_Status = 0>

		<CFIF Attributes.ReturnMessage IS 1>

			<CFSET Password_Message = "A Senha deve conter no máximo #Attributes.MaxLength# caractéres.\nPor favor, preencha corretamente o campo Senha.">

		</CFIF>

	</CFIF>

</CFIF>

<!---	Iremos verificar se a senha informada contém "caractéres especiais"	--->
<CFIF Attributes.ContainSpecialChar IS 1>

	<CFIF ReFind("[[:punct:]]", Attributes.Password) IS 0>

		<CFSET Password_Status = 0>

		<CFIF Attributes.ReturnMessage IS 1>

			<CFSET Password_Message = "A Senha deve conter Caractéres Especiais (ex: !, ?, ##, %, etc.).\nPor favor, preencha corretamente o campo Senha.">

		</CFIF>

	</CFIF>

<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
<CFELSE>

	<CFIF ReFind("[[:punct:]]", Attributes.Password) IS NOT 0>

		<CFSET Password_Status = 0>

		<CFIF Attributes.ReturnMessage IS 1>

			<CFSET Password_Message = "A Senha não deve conter Caractéres Especiais (ex: !, ?, ##, %, etc.).\nPor favor, preencha corretamente o campo Senha.">

		</CFIF>

	</CFIF>
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

</CFIF>

<!---	Iremos verificar se a Senha informada contém "caractéres inválidos"	--->
<CFIF Trim(Attributes.InvalidChars) IS NOT "">

	<CFSET Password_ListnvalidChars = "">

	<CFLOOP INDEX="InvalidChars_Index" FROM="1" TO="#Len(Attributes.InvalidChars)#">

		<CFIF InvalidChars_Index IS 1>

			<CFSET Password_ListnvalidChars = Password_ListnvalidChars & Mid(Attributes.InvalidChars, InvalidChars_Index, 1)>

		<CFELSE>

			<CFSET Password_ListnvalidChars = Password_ListnvalidChars & ", " & Mid(Attributes.InvalidChars, InvalidChars_Index, 1)>

		</CFIF>

		<CFSET InvalidChars_IndexChar = Mid(Attributes.InvalidChars, InvalidChars_Index, 1)>

		<CFIF FindNoCase(InvalidChars_IndexChar, Attributes.Password)>

			<CFSET Password_Status = 0>

			<CFIF Attributes.ReturnMessage IS 1>

				<CFSET Password_Message = "A Senha não deve conter os seguintes Caractéres: #Password_ListnvalidChars#.\nPor favor, preencha corretamente o campo Senha.">

			</CFIF>

		</CFIF>

	</CFLOOP>

</CFIF>

<!---	Iremos retornar o "Status" da senha para o Script que nos "invocou"	--->
<CFSET Caller.CheckPassword = Password_Status>

<CFIF Password_Message IS NOT "">

	<CFSET Caller.CheckPasswordMessage = Password_Message>

</CFIF>
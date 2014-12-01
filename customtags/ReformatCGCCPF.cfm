<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
					CUSTOM TAGS

	TEMPLATE: ReformatCGCCPF	NOME:

	Esta CustomTag irá, automaticamente, verificar se o CPF ou o CGC
	recebidos são válidos, e reformatá-los

	ALTERAÇÕES:

		Por: Kléber Kihara (01/03/2000)

		Esta CustomTag sofreu algumas alterações para podermos
	usá-la no Sistema da Mendes Advogados Associados.
		Agora ao invés da mensagem de erro, caso o número informa-
	do não seja nem um CPF nem um CGC válido, irá ser feita como um
	"Alert_Back.cfm" (apenas para que fique dentro dos padrões adota-
	dos para a Intranet da Mendes).

	Por FCR 09/02/2006
	Se recebe o parametro NOALERT, não gera mensagem de erro se for um número
	inválido..retorna apenas o número enviado

	gera variáveis no caller informando se é CGC, CPF:
		IsCGC
		IsCPF


	RECEBE: O número que será verificado
	ENVIA:	CGCNum ou CPFNUM (ou um, ou outro)
			Formatted_Number (sempre)
	MÓDULOS:	ValidCPF.cfm
				ValidCGC.cfm
				Alert_Back.cfm

	EXEMPLO:

	<CF_ReformatCGCCPF NUMBER="Numero_Desejado">
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<!---	1 - Verifica se existe o parâmetro "Number"	--->
<!---	Se não, mostrar uma mensagem de erro	--->
<CFIF IsDefined("Attributes.Number") IS "No">

	Erro - CustomTag: <B>CF_ReformatCGCCPF</B><BR>
	O parâmetro <B>Number</B> não está sendo informado

	<CFABORT>

</CFIF>

<!---	2 - Agora iremos formatar o parâmetro Number, de uma forma que possamos trabalhar	--->
<CFSET Number = Attributes.Number>

<!---	2.1 - Retira os possíveis "espaços" existentes	--->
<CFSET Number = Replace(Number, " ", "", "ALL")>

<!---	2.2 - Retira os possíveis "pontos" existentes	--->
<CFSET Number = Replace(Number, ".", "", "ALL")>

<!---	2.3 - Retira os possíveis "traços" existentes	--->
<CFSET Number = Replace(Number, "-", "", "ALL")>

<!---	2.4 - Retira os possíveis "barras" existentes	--->
<CFSET Number = Replace(Number, "/", "", "ALL")>

<!---	3 - Determina se o número informado é CPF ou CGC	--->
<CF_ValidCPF CPFNum = "#Number#">

<CF_ValidCGC CGCNum = "#Number#">

<!---	4 - Agora iremos reformatar o número de acordo com o seu tipo (CPF/CGC)	--->
<!---	4.1 - Devemos verificar de que forma devemos formatar o número recebido	--->
<CFIF ValidCGC IS "True"><!---	O número recebido é CGC	--->

	<!---	Formatar da seguinte maneira: xx.xxx.xxx/xxxx-xx	--->

	<CFSET CGCNum = MID(NUMBER, 1, 2) & "." & MID(NUMBER, 3, 3) & "." & MID(NUMBER, 6, 3) & "/" & MID(NUMBER, 9, 4) & "-" & MID(NUMBER, 13, 2)>
	<CFSET CALLER.FormattedNumber = #CGCNum#>
	<cfset iscgc = true>

<CFELSEIF ValidCPF IS "True"><!---	O número recebido é CPF	--->

	<!---	Formatar da seguinte maneira: xxx.xxx.xxx-xx	--->

	<CFSET CPFNum = MID(NUMBER, 1, 3) & "." & MID(NUMBER, 4, 3) & "." & MID(NUMBER, 7, 3) & "-" & MID(NUMBER, 10, 2)>
	<CFSET CALLER.FormattedNumber = #CPFNum#>
	<cfset caller.iscpf =true>

<CFELSE><!---	O número recebido não foi validado em nenhum dos tipos	--->
	<cfif NOT isdefined("attributes.noalert")>
		<CFMODULE Template="../CustomTags/Alert_back.cfm"
			TEXTO="O número de documento (C.P.F ou C.G.C.) informado não foi validado.\nPor favor, verifique se ele foi preenchido corretamente e tente novamente.">
		<CFABORT>
	<cfelse>

		<cfset caller.FormattedNumber = Attributes.Number>

	</cfif>
</CFIF>

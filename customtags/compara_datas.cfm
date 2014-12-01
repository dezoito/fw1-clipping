<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: CustomTag

	CustomTAG: Compara_datas

	Verifica se o Parametro de data DATA_INICIO é ANTERIOR
	ao parametro DATA_TERMINO.

	CAso isso não seja verdadeiro, gera um alerta que,ao ser confirmado,
	faz com que o Browser retorne à página anterior

	IMPORTANTE: As datas devem estar eem formato europeu

	RECEBE: DATA_INICIO e DATA_TERMINO (Ambos obrigatórios)
	MESSAGE (opcional): Mensagem de erro


	EXEMPLOS:
	<CF_Compara_Datas
	DATA_INICIO=#Data_Inicio#
	DATA_TERMINO=#DATA_TERMINO#>

	<CFMODULE TEMPLATE="../Algum_Dir/Compara_Datas.cfm"
	DATA_INICIO=#Data_Inicio#
	DATA_TERMINO=#DATA_TERMINO#
	MESSAGE="Mensagem de erro">

 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<CFPARAM NAME="ATTRIBUTES.MESSAGE" DEFAULT="Por favor, digite todas as datas de término, \nde forma que estas sejam posteriores às respectivas datas de início">

<!---		1) verifica se a tag recebeu os parametros		 --->

<CFIF IsDefined("ATTRIBUTES.DATA_INICIO") IS "NO">
<P>Por favor, forneça o parâmetro DATA_INICIO
<CFABORT>
</CFIF>

<CFIF IsDefined("ATTRIBUTES.DATA_TERMINO") IS "NO">
<P>Por favor, forneça o parâmetro DATA_TERMINO
<CFABORT>
</CFIF>


<!---		2) TENTA EXECUTAR O SCRIPT		 --->
<CFTRY>
	<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	3) Verifica se a Data inicial é maior que a Data final
	3.1- Cria vars temporarrias, formatadas corretamente
	3.2 - Compara as novas datas,
	sendo que a primeira deve ser anterior a segunda
	 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
	<CFSET D_Antes = #CreateODBCDate(DateFormat(ATTRIBUTES.Data_Inicio,"dd/mm/yyyy"))#>
	<CFSET D_Depois = #CreateODBCDate(DateFormat(ATTRIBUTES.Data_Termino,"dd/mm/yyyy"))#>

	<CFIF DateCompare("#D_Antes#",  "#D_Depois#") GT 0>
	<!---		Mostra mensagem de erro		 --->
	<!---		Cria um alerta que, ao ser confirmado, volta para a última página.		 --->
	<CFOUTPUT>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		alert('#ATTRIBUTES.MESSAGE#');
		history.back()
	//-->
	</SCRIPT>
	</CFOUTPUT>
	<CFABORT>
	</CFIF><!---	verifica datas	 --->



	<!---		Caso tenha acontecido algum erro (QQ um)	Mostrar uma mensagem mais amigável	 --->
	<CFCATCH TYPE="ANY">
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			alert(" Ocorreu um erro ao tentar processar este script.\n(Processamento de Datas) \n\nPor favor, tente novamente");
			history.back()
		//-->
		</SCRIPT>
		<CFABORT>
	</CFCATCH>

</CFTRY>

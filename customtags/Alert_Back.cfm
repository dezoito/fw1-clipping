<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO:

	TEMPLATE: Módulo: Alert_Back.cfm

	Cria um alerta que, ao ser confirmado, volta para a última página


	RECEBE: ATTRIBUTES.texto
	ENVIA:
	CHAMA: history.back()


	EXEMPLOS:
	<CF_Alert_back
	TEXTO="ERRO! \n Mensagem de Erro Aqui.">

	<CFMODULE Template="../../CustomTags/Alert_back.cfm"
	TEXTO="ERRO! \n Mensagem de Erro Aqui.">

 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->


	<!---		Cria um alerta que, ao ser confirmado, volta para a última página.		 --->
	<CFOUTPUT>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
			alert("#ATTRIBUTES.texto#");
			history.back()
	//-->
	</SCRIPT>
	</CFOUTPUT>
	<cfabort>

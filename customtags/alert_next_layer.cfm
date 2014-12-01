<cfsetting enablecfoutputonly="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --
	PROJETO: CustomTag - Alert Next Layer
	
	TEMPLATE: alert_next_layer.cfm		[21/05/2003]	Filipe Torrano

	Mostra um alerta em uma layer, redireciona para outra página e a layer desaparece.
	
	ALTERAÇÕES:
	05/06/2003 - FCR
	Alterei a apresentação da mensagem
	criei atributo para tempo de espera

	RECEBE: texto,
			url_destino
			tempo_espera (OPCIONALdefault=1s)
	CHAMA:	url_destino (url recebida para redirecionamento)
	

	MODULOS: 	
				
	EXEMPLO:
		<cfmofule template="../../customtags/alert_next_layer.cfm"
			texto="Cadastro efetuado com sucesso !"
			url="index.cfm">
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<!--- verificar se foi definido o texto para o alerta --->
<cfif not isdefined("attributes.texto")>
	<cfoutput><p>O Texto para o Alerta não foi informado !</cfoutput>
	<cfabort>
</cfif>

<!--- verificar se foi definida a url destino para ser redirecionado --->
<cfif not isdefined("attributes.url")>
	<cfoutput><p>A url de destino não foi informada !</cfoutput>
	<cfabort>
</cfif>

<cfparam name="attributes.tempo" default="1">

<!--- --- --- --- --- --- --- --- --- --- --- --- --- 
se o tempo for 0, já faz CFLOCATION !!
 --- --- --- --- --- --- --- --- --- --- --- --- --->
<cfif attributes.tempo IS 0>
	<cflocation url="#attributes.url#" addtoken="No">
</cfif>


<cfoutput>


<meta http-equiv="Refresh" content="#attributes.tempo#;  URL=#attributes.url#">

<style>
	.texto
	{
		COLOR: "Black"; FONT:  10px Verdana,Tahoma,Arial,Helvetica
	}
</style>
	<br>
	<br>
	
<table border="1" cellspacing="0" cellpadding="1" align="center" bgcolor="Black">
<tr>
	<td>
		<table width="300" cellspacing="2" cellpadding="0" align="center" bgcolor="##E9E9E9">
			<tr>
				<td valign="top">
					&nbsp;&nbsp;&nbsp;
				</td>			
			
				<td  valign="top">
					<font face="Verdana" size="2" color="Black">
					<b>Atenção:</b><br>					
					#attributes.texto#
					</font>
					<br>					
					<font face="Verdana" size="1" color="Gray">
					Aguarde redirecionamento para a <a href="#attributes.url#" class="texto">próxima tela</a>
					</font>
				</td>
			</tr>	
		</table>
	</td>
</tr>
</table>

</cfoutput>


<cfsetting enablecfoutputonly="No">



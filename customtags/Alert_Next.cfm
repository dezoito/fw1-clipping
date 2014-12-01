<CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	DATA: 01/08/2001					Rafael de Oliveira Silva
	
	TEMPLATE MODULO: Alert_Next.cfm
	
	Cria um alerta com Javascript para a próxima página.

	ALTERAÇÕES: 
	25/09/2001 - FCR
	coloquei um attributo target

	RECEBE: 
		attributes.Texto,
		attributes.Url
		attributes.Target (opcional)
	ENVIA: 
		
	CHAMA: 
		attributes.Url
		
	EXEMPLOS:
	<CF_Alert_Next
		TEXTO="ERRO! \n Mensagem de Erro Aqui."
		URL="#http_referer#>
	
	<CFMODULE Template="../../CustomTags/Alert_Next.cfm"
		TEXTO="ERRO! \n Mensagem de Erro Aqui."
		URL="#http_referer#">
	
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
	<!---		Checking required attributes		 --->
		<CFIF #IsDefined("attributes.texto")# Is "No">
			<cfoutput><P>You must supply a TEXTO attribute !</cfoutput>
			<CFABORT>
		</CFIF>
		<CFIF #IsDefined("attributes.url")# Is "No">
			<cfoutput><P>You must supply a URL attribute !</cfoutput>
			<CFABORT>
		</CFIF>

	<!---		Cria um alerta que, ao ser confirmado, chama a próxima página.		 --->
	<CFOUTPUT>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			alert("#ATTRIBUTES.texto#"); 
			<cfif isdefined("ATTRIBUTES.target")>
				#ATTRIBUTES.target#.location.href='#attributes.url#';			
			<cfelse>
				self.location.href='#attributes.url#';
			</cfif>			
		//-->
		</SCRIPT>
	</CFOUTPUT>
		
<CFSETTING ENABLECFOUTPUTONLY="No">
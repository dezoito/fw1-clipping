<cfsetting enablecfoutputonly="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: Custom Tag:

	TEMPLATE: contrai_div.cfm	 (02/10/2001)
								Rafael de Oliveira Silva


	Pemite que o conteúdo no interior da tag seja mostrado
	ou ocultado dentro de uma div, através de clique em link ou imagem.

	ATTRIBUTOS:
		ID (obrigatório)= Um identificador único para a div dentro de uma página
		HTML_TITLE (obrigatório): Título da div
		HTML_BT_OFF (obrigatório): Html para o botão ou ícone quando a div estiver contraída
		HTML_BT_ON (obrigatório): Html para o botão ou ícone quando a div estiver Expandida

	ATENÇÃO:
		"Nota importante", ao utilizarmos esta tag mais de uma vez
		em um mesmo código fonte e atribuirmos imagemns diferentes
		a tag utiliza como default a imagem da primeira tag utilizada

	EXEMPLO:
		<cf_contrai_div
			ID = "01"
			HTML_TITLE="Titulo da DIV"
			HTML_BT_OFF="contrair/ic_0.gif"
			HTML_BT_ON="contrair/ic_1.gif">

		Texto da DIV<br>
		<b>Texto da DIV</b> <p> <u>Texto da DIV</u>

		</cf_contrai_div>
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	VALIDAÇÕES
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
	<!---	Verificanod se os atributos obrigatórios foram enviados	--->
	<cfoutput>
	<cfif not isdefined("ATTRIBUTES.ID")>
		<p>
		<font size="2" face="verdana" color="Red">
			A Custom Tag <b>CF_Contrai_Div</b> necessita do atributo "ID" para prosseguir.</font>
		<cfabort>
	</cfif>

	<cfif not isdefined("ATTRIBUTES.HTML_TITLE")>
		<p>
		<font size="2" face="verdana" color="Red">
			A Custom Tag <b>CF_Contrai_Div</b> necessita do atributo "HTML_TITLE" para prosseguir.</font>
		<cfabort>
	</cfif>

	<cfif not isdefined("ATTRIBUTES.HTML_BT_OFF")>
		<p>
		<font size="2" face="verdana" color="Red">
			A Custom Tag <b>CF_Contrai_Div</b> necessita do atributo "ATTRIBUTES.HTML_BT_OFF" para prosseguir.</font><br>
			<font size="1" face="verdana, arial">Caso não queira ícones, utilize uma imagem transparente de um pixel.</font>
		<cfabort>
	</cfif>

	<cfif not isdefined("ATTRIBUTES.HTML_BT_ON")>
		<p>
		<font size="2" face="verdana" color="Red">
			A Custom Tag <b>CF_Contrai_Div</b> necessita do atributo "ATTRIBUTES.HTML_BT_ON" para prosseguir.</font><br>
			<font size="1" face="verdana, arial">Caso não queira ícones, utilize uma imagem transparente de um pixel.</font>
		<cfabort>
	</cfif>
	</cfoutput>

<cfsetting enablecfoutputonly="NO">

<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
verifica se a tag já gerou o javascript necessário à
contração/expansão das divs (gerar apenas uma vez)
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<cfif not isdefined("caller.contrai_div_js_init")>

 	<cfoutput>
		<script>
		<!--

				function tierMenu(objMenu,objImage)
				{
				   if (objMenu.style.display == "none")
				   {
				       objMenu.style.display = "";
				       objImage.src = "#ATTRIBUTES.HTML_BT_ON#";
				   }
				   else
				   {
				       objMenu.style.display = "none";
				       objImage.src = "#ATTRIBUTES.HTML_BT_OFF#";
				   }
				}

		//-->
		</script>
	</cfoutput>

	<!---		seta a var para que não gere mais JS		 --->
 	<cfset caller.contrai_div_js_init = 1>

</cfif>


<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	montando as divs
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<cfoutput>

	<cfif thistag.executionmode is "Start">
		<span  style={cursor:hand;} onClick="tierMenu(menu#attributes.id#,img#attributes.id#)">
			<img src="#ATTRIBUTES.HTML_BT_OFF#" id="img#attributes.id#" />
			<font style={cursor:hand;}>#ATTRIBUTES.HTML_TITLE#</font>
		 </span>

		<span id="menu#attributes.id#" style="display: none">

	<cfelse>

		</span>
	</cfif>

</cfoutput>

<cfsetting enablecfoutputonly="NO">

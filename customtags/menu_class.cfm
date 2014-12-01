<CFSETTING ENABLECFOUTPUTONLY="Yes">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
									MENU_CLASS.cfm
	
	AUTOR: Mário K.
	TEMPLATE: MENU_CLASS.cfm

	»»» Custom Tag que gera um menu, utilizando-se de uma class para
	que possamos obter o efeito desejado.
	
	*** OBSERVAÇÃO ***
	A Customtag MENU_CLASS só funciona quando associada com uma outra
	customtag que gera os itens do menu (MENU_CLASS_ITEM.cfm).
	

	ATRIBUTOS DA CUSTOM TAG
	Gerais
	» NAME - OBRIGATORIO, determina o nome a ser utilizado.
	» PADDING - OPCIONAL, determina o espaço interno de cada item do menu
	» SPACING - OPCIONAL, determina o espaço entre cada item do menu
	Item
	» BGCOLOR - OPCIONAL, cor de fundo do item do menu
	» BORDER - OPCIONAL, tamanho da borda(pixels)
	» BORDER_BOTTOM - OPCIONAL, determina a cor da borda inferior
	» BORDER_LEFT - OPCIONAL, determina a cor da borda esquerda
	» BORDER_TOP - OPCIONAL, determina a cor da borda superior
	» BORDER_RIGHT - OPCIONAL, determina a cor da borda direita
	» FONT_COLOR - OPCIONAL, cor da fonte
	» FONT_FACE - OPCIONAL,	tipo de fonte
	» FONT_SIZE - OPCIONAL, tamanho da fonte (pixels)
	Item (Over)
	» BGCOLOR_ON - OPCIONAL, cor de fundo do item do menu
	» BORDER_ON - OPCIONAL, tamanho da borda(pixels)
	» BORDER_BOTTOM_ON - OPCIONAL, determina a cor da borda inferior
	» BORDER_LEFT_ON - OPCIONAL, determina a cor da borda esquerda
	» BORDER_TOP_ON - OPCIONAL, determina a cor da borda superior
	» BORDER_RIGHT_ON - OPCIONAL, determina a cor da borda direita
	» FONT_COLOR_ON - OPCIONAL, cor da fonte
	» FONT_FACE_ON - OPCIONAL,	tipo de fonte
	» FONT_SIZE_ON - OPCIONAL, tamanho da fonte (pixels)
	
	EXEMPLO:	
	<CF_MENU_CLASS
		NAME="table">
		<CF_MENU_CLASS_ITEM
			ITEM_NAME="teste"
			URL="http://10.0.0.1/mario/intra_mail/"
			TARGET="teste">
	</CF_MENU_CLASS>
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
 
<!---	 Verificando se estamos recebendo os atributos necessários	--->

<!---	NAME	--->
<CFIF NOT IsDefined("ATTRIBUTES.NAME")>	
	<cfoutput>
	<table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="Black">
		<tr bgcolor="Gray">
			<td>
				<font color="Silver">
					<strong><b>ERRO! (Customtag: MENU_CLASS)</b></strong>
				</font>
			</td>			
		</tr>
		<tr bgcolor="Silver">
			<td>

				<font color="Black">					
						A Customtag MENU_CLASS necessita do atributo <b>NAME</b>.					
				</font>								

			</td>
		</tr>
	</table>
	</cfoutput>
	<CFABORT>
</CFIF>	

<!---		Verifica se a tag foi fechada		 --->
<CFIF NOT THISTAG.HASENDTAG>
	<CFSET THISTAG.GENERATEDCONTENT="">
		<table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="Black">
			<tr bgcolor="Gray">
				<td>
					<font color="Silver">
						<strong><b>ERRO! (Customtag: MENU_CLASS)</b></strong>
					</font>
				</td>			
			</tr>
			<tr bgcolor="Silver">
				<td>
	
					<font color="Black">					
							A Customtag MENU_CLASS necessita ser fechada.					
					</font>								
	
				</td>
			</tr>
		</table>
	<CFABORT>
</CFIF>

<!---	WIDTH	--->
<CFPARAM NAME="ATTRIBUTES.WIDTH" DEFAULT="100%">

<!---	PADDING	--->
<CFPARAM NAME="ATTRIBUTES.PADDING" DEFAULT="0">

<!---	SPACING	--->
<CFPARAM NAME="ATTRIBUTES.SPACING" DEFAULT="1">

<!---	BGCOLOR	--->
<CFPARAM NAME="ATTRIBUTES.BGCOLOR" DEFAULT="SILVER">

<!---	BORDA	--->
<CFPARAM NAME="ATTRIBUTES.BORDER" DEFAULT="1">

<!---	BORDER_BOTTOM	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_BOTTOM" DEFAULT="ATTRIBUTES.BGCOLOR">

<!---	BORDER_LEFT	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_LEFT" DEFAULT="ATTRIBUTES.BGCOLOR">

<!---	BORDER_RIGHT	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_RIGHT" DEFAULT="ATTRIBUTES.BGCOLOR">

<!---	BORDER_TOP	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_TOP" DEFAULT="ATTRIBUTES.BGCOLOR">

<!---	FONT_COLOR	--->
<CFPARAM NAME="ATTRIBUTES.FONT_COLOR" DEFAULT="Black">

<!---	FONT_FACE	--->
<CFPARAM NAME="ATTRIBUTES.FONT_FACE" DEFAULT="Verdana">

<!---	FONT_SIZE	--->
<CFPARAM NAME="ATTRIBUTES.FONT_SIZE" DEFAULT="9">

<!---	BGCOLOR_ON	--->
<CFPARAM NAME="ATTRIBUTES.BGCOLOR_ON" DEFAULT="White">

<!---	BORDER_ON	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_ON" DEFAULT="1">

<!---	BORDER_BOTTOM_ON	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_BOTTOM_ON" DEFAULT="ATTRIBUTES.BGCOLOR_ON">

<!---	BORDER_LEFT_ON	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_LEFT_ON" DEFAULT="ATTRIBUTES.BGCOLOR_ON">

<!---	BORDER_RIGHT_ON	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_RIGHT_ON" DEFAULT="ATTRIBUTES.BGCOLOR_ON">

<!---	BORDER_TOP_ON	--->
<CFPARAM NAME="ATTRIBUTES.BORDER_TOP_ON" DEFAULT="ATTRIBUTES.BGCOLOR_ON">

<!---	FONT_COLOR_ON	--->
<CFPARAM NAME="ATTRIBUTES.FONT_COLOR_ON" DEFAULT="Black">

<!---	FONT_FACE_ON	--->
<CFPARAM NAME="ATTRIBUTES.FONT_FACE_ON" DEFAULT="Verdana">

<!---	FONT_SIZE_ON	--->
<CFPARAM NAME="ATTRIBUTES.FONT_SIZE_ON" DEFAULT="9">



<!---	Verificando se a tag está sendo aberta ou fechada	--->
<CFSWITCH EXPRESSION="#thistag.executionmode#">
	
	<!---	iniciando a customtag	--->
	<CFCASE VALUE="start">	
	<cfoutput>
		<!---	Incluiremos aqui o style que dará o efeito nos itens do menu	--->
		<STYLE TYPE="text/css">
			<!--
				.LeftNavOff
				{
				    BACKGROUND-COLOR: #ATTRIBUTES.BGCOLOR#;
				    BORDER-BOTTOM: #ATTRIBUTES.BORDER_BOTTOM# solid #ATTRIBUTES.BORDER#px;
				    BORDER-LEFT: #ATTRIBUTES.BORDER_LEFT# solid #ATTRIBUTES.BORDER#px;
				    BORDER-RIGHT: #ATTRIBUTES.BORDER_RIGHT# solid #ATTRIBUTES.BORDER#px;
				    BORDER-TOP: #ATTRIBUTES.BORDER_TOP# solid #ATTRIBUTES.BORDER#px;
				    COLOR: #ATTRIBUTES.FONT_COLOR#;
				    CURSOR: hand;
				    FONT-FAMILY: #ATTRIBUTES.FONT_FACE#;
				    FONT-SIZE: #ATTRIBUTES.FONT_SIZE#px;
				    FONT-WEIGHT: none;
					MARGIN: 0px 0px;
				    PADDING: 0px 0px;
				    TEXT-DECORATION: none;
		
				}
				.LeftNavUp
				{
				    BACKGROUND-COLOR: #ATTRIBUTES.BGCOLOR_ON#;
				    BORDER-BOTTOM: #ATTRIBUTES.BORDER_BOTTOM_ON# solid #ATTRIBUTES.BORDER_ON#px;
				    BORDER-LEFT: #ATTRIBUTES.BORDER_LEFT_ON# solid #ATTRIBUTES.BORDER_ON#px;
				    BORDER-RIGHT: #ATTRIBUTES.BORDER_RIGHT_ON# solid #ATTRIBUTES.BORDER_ON#px;
				    BORDER-TOP: #ATTRIBUTES.BORDER_TOP_ON# solid #ATTRIBUTES.BORDER_ON#px;
				    COLOR: #ATTRIBUTES.FONT_COLOR_ON#;
				    CURSOR: hand;
				    FONT-FAMILY: #ATTRIBUTES.FONT_FACE_ON#;
				    FONT-SIZE: #ATTRIBUTES.FONT_SIZE_ON#px;
				    FONT-WEIGHT: none;
					HEIGHT: 0pt;
					MARGIN: 0px 0px;
				    PADDING: 0px 0px;
				    TEXT-DECORATION: none;			
				}
				.LeftNavDown
				{
				    BACKGROUND-COLOR: 0099ff;
				    BORDER-BOTTOM: 99ccff solid 2px;
				    BORDER-LEFT: 003399 solid 2px;
				    BORDER-RIGHT: 99ccff solid 2px;
				    BORDER-TOP: 003399 solid 2px;
				    COLOR: white;
				    CURSOR: hand;
				    FONT-FAMILY: verdana;
				    FONT-SIZE: 11px;
				    FONT-WEIGHT: bold;
				    LETTER-SPACING: -0.5pt;
				    LINE-HEIGHT: 10pt;
				    MARGIN: 2px 0px;
				    PADDING: 0px 3px;
				    TEXT-DECORATION: none;
				    WIDTH: 10px
				}
				.LeftNavOn
				{
				    BACKGROUND-COLOR: white;
				    BORDER-BOTTOM: 99ccff solid 2px;
				    BORDER-LEFT: 003399 solid 2px;
				    BORDER-RIGHT: 99ccff solid 2px;
				    BORDER-TOP: 003399 solid 2px;
				    COLOR: 666666;
				    FONT-FAMILY: verdana;
				    FONT-SIZE: 11px;
				    FONT-WEIGHT: bold;
				    LETTER-SPACING: -0.5pt;
				    LINE-HEIGHT: 10pt;
				    MARGIN: 2px 0px;
				    PADDING: 0px 3px;
				    TEXT-DECORATION: none;
				    WIDTH: 10px
				}
				.LeftNavChosen
				{
				    BACKGROUND-COLOR: white;
				    BORDER-BOTTOM: 99ccff solid 2px;
				    BORDER-LEFT: 003399 solid 2px;
				    BORDER-RIGHT: 99ccff solid 2px;
				    BORDER-TOP: 003399 solid 2px;
				    COLOR: 000000;
				    CURSOR: hand;
				    FONT-FAMILY: verdana;
				    FONT-SIZE: 11px;
				    FONT-WEIGHT: bold;
				    LETTER-SPACING: -0.5pt;
				    LINE-HEIGHT: 10pt;
				    MARGIN: 2px 0px;
				    PADDING: 0px 3px;
				    TEXT-DECORATION: none;
				    WIDTH: 10px
				}
			-->
		</STYLE>
		
		<!---	JavaScript que faz a alteração de class	--->
			<script language="JavaScript">
				var bFirstMouse = "True";
				
				function ColorBlock(oRegion,sTitle,sLinkID) 
				{	
					if (document.readyState != "complete") return;
					window.event.cancelBubble = true;
					oRegion.className = "LeftNavUp";	
					oRegion.style.cursor="hand";
					sLinkID.style.color = "black";
					bFirstMouse = "False";
				}
				
				function UncolorBlock(oRegion,sLinkID) 
				{
					if (document.readyState != "complete") return;
					window.event.cancelBubble = true;
					var oToEl = window.event.toElement;
					if ((oToEl && !oRegion.contains(oToEl))||!oToEl) {
					sLinkID.style.color = "black";
					oRegion.className = "LeftNavOff";	
					}		
				}
				
				function TabText(sTitle) {	
					if (document.readyState != "complete") return;
					window.event.cancelBubble = true;
					bFirstMouse = "False";		
				}
				
				var sDefText = "<TABLE CELLPADDING=0 CELLSPACING=0><TR><TD VALIGN=MIDDLE><IMG SRC='/windows/media/arrow.gif' WIDTH=48 HEIGHT=33 ALT=*></TD><TD CLASS=bodytext2>Point to any of the sites listed to the left to find out what services and information they offer.  Click to go there.</TD></TR></TABLE>";
					
				function revertBox() {
					if (document.readyState != "complete") return;
					var oToEl = window.event.toElement;
					var thisItem = document.all("main");
					if ((!thisItem.contains(oToEl)) || (window.event.toElement.id == 'header') || (window.event.toElement.id == 'extraBox')){
					}
				}
			</script>
		
			<!---	criando uma tabela que faz a estrutura do menu	--->
			<table width="#ATTRIBUTES.WIDTH#" border="0" cellspacing="#ATTRIBUTES.SPACING#" cellpadding="#ATTRIBUTES.PADDING#">
			
		
		</cfoutput>
	</CFCASE>
	
	<!---	finalizando a customtag	--->
	<CFCASE VALUE="end">
		<cfoutput>
			</table>
		</cfoutput>
	</CFCASE>
	
</CFSWITCH>
<CFSETTING ENABLECFOUTPUTONLY="Yes">

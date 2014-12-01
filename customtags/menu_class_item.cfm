<CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
									MENU_CLASS_ITEM.cfm
	
	AUTOR: Mário K.
	TEMPLATE: MENU_CLASS_ITEM.cfm

	»»» Custom Tag que gera um item para o menu.
	
	*** OBSERVAÇÃO ***
	A Customtag MENU_CLASS_ITEM está diretamente relacionada com a customtag MENU_CLASS.
	

	ATRIBUTOS DA CUSTOM TAG
	» ITEM_NAME - OBRIGATORIO, determina o nome do item.
	» URL - OBRIGATORIO, determina o url que devemos chamar.
	» TARGET - OBRIGATORIO, determina o target a ser utilizado.
	» CAPTION - OBRIGATORIO, texto que aparecerá no menu
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
 
<!---	associando a customtag MENU_CLASS_ITEM com a customtag MENU_CLASS	--->
<CFASSOCIATE BASETAG="CF_MENU_CLASS">

<!---	Associa os dados da customtag MENU_CLASS a esta	customtag --->
<CFSET Base = GetBaseTagData("CF_MENU_CLASS")>
<CFSET BaseData = Base.ThisTag>
<CFSET Check = "True">

<!---	 Verificando se estamos recebendo os atributos necessários	--->
<CFIF NOT IsDefined("ATTRIBUTES.ITEM_NAME")>	
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
						A Customtag MENU_CLASS necessita do atributo <b>ITEM_NAME</b>.					
				</font>								

			</td>
		</tr>
	</table>
	</cfoutput>
	<CFABORT>
</CFIF>	
<CFIF NOT IsDefined("ATTRIBUTES.URL")>	
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
						A Customtag MENU_CLASS necessita do atributo <b>URL</b>.					
				</font>								

			</td>
		</tr>
	</table>
	</cfoutput>
	<CFABORT>
</CFIF>	
<CFIF NOT IsDefined("ATTRIBUTES.TARGET")>	
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
						A Customtag MENU_CLASS necessita do atributo <b>TARGET</b>.					
				</font>								

			</td>
		</tr>
	</table>
	</cfoutput>
	<CFABORT>
</CFIF>	
<CFIF NOT IsDefined("ATTRIBUTES.CAPTION")>	
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
						A Customtag MENU_CLASS necessita do atributo <b>CAPTION</b>.					
				</font>								

			</td>
		</tr>
	</table>
	</cfoutput>
	<CFABORT>
</CFIF>	
<!---	gerando o item do menu	--->
<cfoutput>
	<tr><td CLASS="LeftNavOff" ButtonType="LeftNav" OnMouseover="ColorBlock(this,'#ATTRIBUTES.ITEM_NAME#',#ATTRIBUTES.ITEM_NAME#);" OnMouseout="UncolorBlock(this,#ATTRIBUTES.ITEM_NAME#);" OnClick="parent.#ATTRIBUTES.TARGET#.location.href='#ATTRIBUTES.URL#'"><a STYLE="color:black" ID="#ATTRIBUTES.ITEM_NAME#" OnMouseover="this.style.textDecorationNone=true;" OnFocus="TabText('#ATTRIBUTES.ITEM_NAME#');"  HREF="#ATTRIBUTES.URL#" target="#ATTRIBUTES.TARGET#">#ATTRIBUTES.CAPTION#</a></td></tr>
</cfoutput>

<CFSETTING ENABLECFOUTPUTONLY="No">



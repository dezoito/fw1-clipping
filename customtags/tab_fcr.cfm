<cfsetting enablecfoutputonly="Yes">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO:

	TEMPLATE: tab_fcr.cfm
	11/04/2006

	Template para a geração de menu por ada
	(depende tb de cf_subtab_fcr para cada tab)

	Exemplo:
	<cf_tab_fcr
		tabs="tab1, tab2, tab3"
		onColor="red"
		offColor="silver"
		width="500"
		>

		<cf_subtab_fcr id=tab1>
			conteúdo da tab aqui
		</cf_subtab_fcr>

		.....
	</cf_tab_fcr>

	Attributos:
	tabs: lista com as tabs utilizadas
	onColor: cor da tab e do item de menu selecionado
	offColor:  cor da tab e do item de menu NAO-selecionados
	width: largura máxima (salvo inserção de conteudos que estourem)

 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<cfparam name="attributes.tabs" default="">
<cfparam name="attributes.qtd_linha" default="1">
<cfparam name="attributes.width" default="100%">
<cfparam name="attributes.onColor" default="white">
<cfparam name="attributes.offColor" default="##E0E0E0">

<!--- Only process in END execution mode --->
<cfswitch expression="#ThisTag.ExecutionMode#">

	<cfcase value="START">

	<!---		gera uma string com um id para cada tab passada		 --->
	<!---		exemplo: "1,2,3,4"		 --->
	<cfset lst_id_tabs =''>
	<cfset count=0>
	<cfloop index="ii" from="1" to="#listlen(attributes.tabs)#">
		<cfset lst_id_tabs = listAppend(lst_id_tabs, ii, ",")>
	</cfloop>

		<cfoutput>

			<script>
			<!--

			// array contendo os ids das abs
			aTabs = [#lst_id_tabs#];
			al = aTabs.length;
			lastDiv=0;
			lastContent='';

			function setTab(tabId){
				if(lastDiv != tabId){
					// "limpa" as seleções anteriores
					reSet();
					// copia o conteúdo para a div visível
					document.getElementById("div_x").innerHTML = document.getElementById("div_" + tabId).innerHTML;

					//seta a cor da tb no menu
					document.getElementById("td_" + tabId).style.backgroundColor='#attributes.onColor#';

					// atualiza conteúdo 'fantasma' e o conteúdo da última div selecionada
					if(lastDiv !=0){
						document.getElementById("div_" + lastDiv).innerHTML=lastContent;
					}
					lastDiv=tabId;
					lastContent=document.getElementById("div_" + tabId).innerHTML;
					document.getElementById("div_" + tabId).innerHTML='';
				}
			}

			//loop por todas as tabs, voltando a cor de fundo original
			function reSet(){
				for( i=0; i<al; i++) {
					document.getElementById("td_" + aTabs[i]).style.backgroundColor='#attributes.offColor#';
				}
			}
			//-->
			</script>

		<table cellspacing="2"
		       cellpadding="3">
			   <tr>
			   <!---		loop pelo indice da lista de tabs		 --->
			   <cfloop index="i" from="1" to="#listlen(attributes.tabs, ",")#">

					<td id="td_#i#" bgcolor="#attributes.offColor#"><a href="javascript:setTab('#i#');">#listgetat(attributes.tabs, i, ",")#</a></td>

				</cfloop>
				</tr>
		</table>

		<!---		div onde será colado o conteúdo		 --->
		<div id="div_x"
		     style="background-color: #attributes.onColor#; width: #attributes.width#px;"></div>
		</cfoutput>
	</cfcase>

	<!---		*** fecha a tag ****		 --->
	<cfcase value="END">
		 <cfoutput>
			<script>
			  //inicia com a primeira tab selecionada
				setTab(aTabs[0]);
			</script>
		</cfoutput>
 	</cfcase>
</cfswitch>

<cfsetting enablecfoutputonly="No">

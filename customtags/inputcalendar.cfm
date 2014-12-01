<cfsetting enablecfoutputonly="No" showdebugoutput="No">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: CF_InputCalendar		DATA: 11/12/00

	TEMPLATE:mostra_inputcalendar.cfm	NOME: karina y

	Customtag que abre uma janela com o calendario, onde a data
	escolhida pelo usuário(Date) é enviada para um formulario
	(URL).

	ALTERAÇÕES:
	
	Atributos:
	
	INATIVO (Obrigatório) -  variável que define qual função deve ser 
	executada.
	LINK (Obrigatório)	- Descrição do Link (EX: 'Abre uma janela')
	PATH (Obrigatório) - path relativo para o script desta tag
	FORM (Obrigatório) - Nome do formulário aonde deverá aparecer
	a data escolhida pelo usuário
	CAMPO (Obrigatório) - Nome do campo aonde deverá aparecer
	a data escolhida pelo usuário.
	
	
	ENVIA: Date(data escolhida pelo usuário)
	
	EXEMPLO:
	
	<CF_InputCalendar
		Inativo="yes"
		Link="Abre uma janela"
		Path="'../customtags/inputcalendar.cfm"
		FORM="Form"
		CAMPO="date">

	
IMPORTANTE: No atributo Link, quaisquer aspas internas ao attributo devem ser duplicadas:
EX LINK = "<FONT SIZE=""2"" FACE=""arial"">Texto do Link</FONT>"
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
 <STYLE TYPE="text/css">			<!--

				A:Hover
			{
				text-decoration: underline;
				color: black;
			}
				A:link
			{
				text-decoration: none;
			}
				A:visited
			{
				text-decoration: none;
			}

			Body
			{
				FONT: 11px Tahoma,Verdana,Arial,Helvetica
			}
			Normal
			{
				FONT: 11px Tahoma,Verdana,Arial,Helvetica
			}
			TD
			{
				FONT: 11px Tahoma,Verdana,Arial,Helvetica
			}
			TH
			{
				FONT: bold 11px Tahoma,Verdana,Arial,Helvetica
			}

			-->
</STYLE>

 <!---	Não permitir que o conteúdo desta página fique armazenado no cache	--->
<cfheader name="Expires" value="#Now()#">

<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
Verificando se foi enviado o parâmetro que identifica qual função deve ser 
realizada
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<!---	Se nenhum parâmetro foi enviado definir como NO	--->
<CFPARAM NAME="ATTRIBUTES.INATIVO" DEFAULT="NO">



<!---	Verificando qual das funções deve ser executada	--->
<!---	LINK	--->
<CFIF ATTRIBUTES.INATIVO IS "yes">
		
	<!---	Verificanod se os atributos obrigatórios foram enviados	--->
	<CFIF NOT IsDefined("ATTRIBUTES.LINK")>
		<P><FONT SIZE="2" FACE="verdana" COLOR="Red">A Custom Tag inputcalendar.cfm necessita do atributo LINK para prosseguir.</FONT>
		<CFABORT>
	</CFIF>
	<CFIF NOT IsDefined("ATTRIBUTES.FORM")>
		<P><FONT SIZE="2" FACE="verdana" COLOR="Red">A Custom Tag inputcalendar.cfm necessita do atributo FORM para prosseguir.</FONT>
		<CFABORT>
	</CFIF>
	<CFIF NOT IsDefined("ATTRIBUTES.CAMPO")>
		<P><FONT SIZE="2" FACE="verdana" COLOR="Red">A Custom Tag inputcalendar.cfm necessita do atributo CAMPO para prosseguir.</FONT>
		<CFABORT>
	</CFIF>
	<CFIF NOT IsDefined("ATTRIBUTES.PATH")>
		<P><FONT SIZE="2" FACE="verdana" COLOR="Red">A Custom Tag inputcalendar.cfm necessita do atributo PATH para prosseguir.</FONT>
		<CFABORT>
	</CFIF>	
	
	<!---		CREATE JAVASCRIPT FOR WINDOW		 --->
	<SCRIPT LANGUAGE="JavaScript">
	
	<!--
	function abre1(janela){
	window.open(janela,"1","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=143,height=170")
	        }
	//-->
	</SCRIPT>
	
	<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	Gera o Link
	 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
	<CFOUTPUT>
		<A HREF="##"  onClick=abre1('#TRIM(ATTRIBUTES.PATH)#?ATTRIBUTES.INATIVO=no&ATTRIBUTES.FORM=#ATTRIBUTES.FORM#&ATTRIBUTES.CAMPO=#ATTRIBUTES.CAMPO#')>#ATTRIBUTES.LINK#</a>
	 </CFOUTPUT>	



<!---	JANELA	--->
<CFELSEIF ATTRIBUTES.INATIVO IS "no">
	
	<!--- Setting variables--->
	<CFSET #DAY_NOW# = DAY(NOW())>
	<CFSET #MONTH_NOW# = MONTH(NOW())>
	<CFSET #YEAR_NOW# = YEAR(NOW())>
	<!--- End setting variables--->
	
	<CFIF #ParameterExists(URL.startdate)# >	
		<!--- Setting today variables--->
		<CFIF #YEAR_NOW# IS YEAR(#URL.startdate#) AND #MONTH_NOW# IS MONTH(#URL.startdate#)>
			<CFSET #CalendarDate# = Now()>
		<CFELSE>
			<CFSET #CalendarDate# = #URL.startdate#>
		</CFIF>
	<CFELSE>
		<CFSET #CalendarDate# = Now()>
	</CFIF>
	
	<CFSET #DAY_NOW# = DAY(NOW())>
	<CFSET #MONTH_NOW# = MONTH(NOW())>
	<CFSET #YEAR_NOW# = YEAR(NOW())>
	<CFSET #PrevYearString# = #Year(#DateAdd("yyyy", -1,"#CalendarDate#")#)#>
	<CFSET #PrevYear# = #DateFormat(#DateAdd("yyyy", -1,"#CalendarDate#")#, "mm/dd/yyyy")#>
	
	<CFSET #NextYearString# = #Year(#DateAdd("yyyy", 1,"#CalendarDate#")#)#>
	<CFSET #NextYear# = #DateFormat(#DateAdd("yyyy", 1,"#CalendarDate#")#, "mm/dd/yyyy")#>
	
	<CFSET #Month# = #MonthAsString(DatePart("m",#CalendarDate#))#>
	<CFSET #MonthNum# = #Month(#CalendarDate#)#>
	<CFSET #Year# =#DatePart("yyyy",#CalendarDate#)#>
	<CFSET #NumOfDays# = #DaysInMonth(#CalendarDate#)#>
	<CFSET #DayOfWeek# = #DayOfWeek(#CalendarDate#)#>
	<CFSET #DayNum# = #Day(#CalendarDate#)#>
	<CFSET #FirstDay# =  #DayOfWeek(#MonthNum# & "/1/" & #Year#)#> 
	<CFIF #FirstDay# IS 1>
		<CFSET #FirstDay# = 7>
	<CFELSE>
		<CFSET #FirstDay# = #FirstDay# - 1>
	</CFIF>
	<CFSET #NumberOfRows# = ((#FirstDay# + #NumOfDays# )/ 7) + 1>
	<CFSET #FirstRowCount# = 1>
	<CFSET #count# = 1>
	<!--- End setting today  variables--->
	

<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
Cria uma consulta Fake, apenas para manter compatibilidade
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<cfset Date=QueryNew("EventoData")>
<cfset x=QueryAddRow( Date, 1)>	
<cfset x=QuerySetCell( Date, "EventoData", "01")>		

	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
	<HTML>
	
	<cfif NOT isdefined("startdate")>	
		<!--faz com que a janela fique mais próxima do centro da tela-->
		<script>
		<!--
		window.moveTo(350,350);
		//-->
		</script>
	</cfif>
	<HEAD>
	
	
	
	<!--- Java script que envia a data escolhida para o formulario, fazendo com que este ganhe o foco --->

	<CFOUTPUT>	
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		function date(thedate)
		
		{
		formated_date = thedate + "/" + #MonthNum# + "/" + #Year#;
		top.opener.document.#attributes.form#.#attributes.campo#.value=formated_date;
		top.opener.focus();
		top.opener.document.#attributes.form#.#attributes.campo#.focus();
		this.close();
		}
		
		//-->
		</SCRIPT>
	</CFOUTPUT>
	
		<TITLE></TITLE>
		
	
		<STYLE TYPE="text/css">		<!--

		A:link {color:"black"; text-decoration : none;}
		A:visited {color:"black";}
		A:hover
		 {
			color:"red";	 text-decoration : underline;		
		}
		BODY {
			color: #000;

			font-family: verdana, helvetica, sans-serif;
			font: 10px;
		}
		TD, TH { font-family: verdana, helvetica, sans-serif;
			font: 10px;
		} /* ns workaround */
		-->
</STYLE>
		
		
	</HEAD>
<BODY BGCOLOR="White" TEXT="Black" LINK="Black" VLINK="Black" ALINK="Black" leftmargin=2 topmargin=1>

 <!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
Início do corpo do calendário
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
 
 <!---	Links para movimentação entre datas --->
 <cfset ThisMonth = MonthNum & "/01/" & Year>
 
<div align="center">
<table border="0" width="140" cellspacing="1" cellpadding="0">
  <tr>
  <!--- não deixo o usuário voltar para antes de um determinado ano --->
  <cfif  #PrevYearString# LT 1999>
<TD valign="top"  align="center"><small><CFOUTPUT>#PrevYearString#</CFOUTPUT></small></TD>
<cfelse>
    <td valign="top" align="center"><small><CFOUTPUT><A HREF="inputcalendar.cfm?startdate=#PrevYear#&ATTRIBUTES.INATIVO=no&ATTRIBUTES.FORM=#ATTRIBUTES.FORM#&ATTRIBUTES.CAMPO=#ATTRIBUTES.CAMPO#">&lt;&lt;</A></CFOUTPUT></small></td>
</CFIF>
    <td valign="top" align="center"><small><CFOUTPUT><A HREF="inputcalendar.cfm?startdate=#DateFormat(DateAdd("m",  -1, ThisMonth),"mm/dd/yyyy" )#&ATTRIBUTES.INATIVO=no&ATTRIBUTES.FORM=#ATTRIBUTES.FORM#&ATTRIBUTES.CAMPO=#ATTRIBUTES.CAMPO#">&lt;</A></CFOUTPUT></small></td>
    <td valign="top" align="center" >&nbsp;&nbsp;&nbsp;</td>
    <td valign="top" align="center"><small><CFOUTPUT><A HREF="inputcalendar.cfm?startdate=#DateFormat(DateAdd("m",  1, ThisMonth),"mm/dd/yyyy" )#&ATTRIBUTES.INATIVO=no&ATTRIBUTES.FORM=#ATTRIBUTES.FORM#&ATTRIBUTES.CAMPO=#ATTRIBUTES.CAMPO#">&gt;</A></CFOUTPUT></small></td>
    <td valign="top" align="center"><small><CFOUTPUT><A HREF="inputcalendar.cfm?startdate=#NextYear#&ATTRIBUTES.INATIVO=no&ATTRIBUTES.FORM=#ATTRIBUTES.FORM#&ATTRIBUTES.CAMPO=#ATTRIBUTES.CAMPO#">&gt;&gt;</A></FONT></CFOUTPUT></small></td>

  </tr>
</table>
</div>
 <!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
//
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
	
<div align="CENTER">
 <TABLE BORDER=0 CELLPADDING=1 CELLSPACING=3 WIDTH=140 BGCOLOR="white"> 

 <!---Linha que apresenta mês e ano selecionados--->
<tr align="center" bgcolor="#88E1FB">
<td colspan="7"><cfoutput><B>#ListGetAt(A_Lst_Mes_Port ,MonthNum)# #Year#</B></cfoutput></td>
</TR> 
 
<TR ALIGN="Right">
<TD ><B><FONT SIZE="1">S</FONT></B></TD>
<TD><B><FONT SIZE="1">T</FONT></B></TD>
<TD><B><FONT SIZE="1" >Q</FONT></B></TD>
<TD><B><FONT SIZE="1">Q</FONT></B></TD>
<TD><B><FONT SIZE="1" >S</FONT></B></TD>
<TD><B><FONT SIZE="1" >S</FONT></B></TD>
<td bgcolor="#C0C0C0"><B><font size="1">D</FONT></B></td>
</TR>
	
<cfset #COL_NUM# = 1>
	<tr>
	<CFLOOP condition="#COL_NUM# LT #FirstDay#">	
		<CFOUTPUT><td align="right" valign="middle"><FONT SIZE="2"> <center>&nbsp;&nbsp;</center></font></td></CFOUTPUT>
		<CFSET #COL_NUM# = #COL_NUM#+1>	
	</CFLOOP>
			
	<cfloop query="DATE" >
		<cfloop condition="#count# LT #Date.EVENTOData#">	
			<cfif #COL_NUM# is 8> 
				<cfset #COL_NUM# = 1>
				</tr><tr>
			</cfif>
			
		<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
		Dias normais
	 	--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->		
			<cfoutput><TD  align="right" VALIGN="middle"  
		<!--- determina a cor da célula --->
			<cfif Day(Now()) IS Count AND Year(Now()) IS Year AND Month(Now()) IS MonthNum>
			BGCOLOR="FDE499"
			<cfelseif DayOfWeek(CreateDate(Year, MonthNum,Count)) IS 1>
			BGCOLOR="Silver"
			<cfelse>
			BGCOLOR="WHITE"
			</cfif>					
			><b><center><A HREF="javascript: date(#count#)">#count#</A></center></b></TD></cfoutput>
			<cfset #COL_NUM#=#COL_NUM#+1>
			<cfset #count# = #count# +1 >
		</cfloop>
	
		<cfif #COL_NUM# is 8> 
			<cfset #COL_NUM# = 1>
			</tr><tr>
		</cfif>
	</cfloop>
	
	<cfloop condition="#count# LTE #NumOfDays#">
		<cfif #COL_NUM# is 8> 
			<cfset #COL_NUM# = 1>
			</tr><tr>
		</cfif>
		
		<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
		Dias normais Após último evento
	 	--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
		<cfoutput><TD  align="right" VALIGN="middle" 
		<!--- determina a cor da célula --->
			<cfif Day(Now()) IS Count AND Year(Now()) IS Year AND Month(Now()) IS MonthNum>
			BGCOLOR="FDE499"
			<cfelseif DayOfWeek(CreateDate(Year, MonthNum,Count)) IS 1>
			BGCOLOR="Silver"
			<cfelse>
			BGCOLOR="WHITE"
			</cfif>				
			><A HREF="javascript: date(#count#)">#count#</A></TD></cfoutput>
		<cfset #COL_NUM#=#COL_NUM#+1>
		<cfset #count# = #count# +1 >
	</cfloop>
	
	<CFLOOP condition="#COL_NUM# LTE 7">	
		<CFOUTPUT><TD VALIGN="middle"><FONT SIZE="1"> &nbsp;&nbsp;</FONT></TD></CFOUTPUT>
		<CFSET #COL_NUM# = #COL_NUM#+1>	
	</CFLOOP>
	</tr>
	
	</table>
	
	<script>window.focus();</script>
	
	<!--- End calendar body --->
	</BODY>
	</HTML>
	
</CFIF><!--- // fim: determina o modo de execução da tag --->
<cfsetting enablecfoutputonly="No" showdebugoutput="Yes">
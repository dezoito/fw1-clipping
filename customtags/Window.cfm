<CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: Custom_Tag: CF_Window

	TEMPLATE: Window.cfm

	Cria um link que, ao ser cklicado, abre uma nova janela.
	A vantagem desta tag é que, ao se clicar novamente sobre o link,
	se a janela já existir, ela passa a receber o foco

	ALT 17/02/2000 FCR
	Antes de ganhar o foco, a janela deve ser recarregada.


	Atributos:
	WName (Obrigatório)  - Nome da Janela
	LINK (Obrigatório) - Descrição do Link (EX: 'Abre uma janela')
	URL (Obrigatório)  - URL
	HEIGHT - Altura da janela (default = 400)
	WIDTH - Largura da janela  (default = 300)

	Outros parametros (default = No para todos)
	(Caso não desejee estes parâmetros, não acrescentar aos atributos da tag)
	toolbar
	menubar
	scrollbars
	resizable
	status
	location
	directories
	copyhistory

	EX:

	<CF_WINDOW
		WNAME="Janela"
		LINK="Abre uma janela"
		URL="teste.cfm"
		HEIGHT=300
		WIDTH=300
		scrollbars="Yes"
		>


IMPORTANTE: No atributo Linkk, quaisquer aspas internas ao attributo devem ser duplicadas:
EX LINK = "<FONT SIZE=""2"" FACE=""arial"">Texto do Link</FONT>"
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->


<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
1) Verifica a entrada de parâmetros obrigatórios
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<CFIF NOT IsDefined("ATTRIBUTES.WName")>
<P><FONT SIZE="2" FACE="arial" COLOR="Red">A Custom Tag Window.cfm necessita do atributo WNAME para prosseguir.</FONT>
<CFABORT>
</CFIF>

<CFIF NOT IsDefined("ATTRIBUTES.LINK")>
<P><FONT SIZE="2" FACE="arial" COLOR="Red">A Custom Tag Window.cfm necessita do atributo LINK para prosseguir.</FONT>
<CFABORT>
</CFIF>

<CFIF NOT IsDefined("ATTRIBUTES.URL")>
<P><FONT SIZE="2" FACE="arial" COLOR="Red">A Custom Tag Window.cfm necessita do atributo URL para prosseguir.</FONT>
<CFABORT>
</CFIF>

<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
2) Cria Defaults
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<CFPARAM NAME="ATTRIBUTES.HEIGHT" DEFAULT="400">
<CFPARAM NAME="ATTRIBUTES.WIDTH" DEFAULT="400">



<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
3) Gera a string com as propriedades da janela
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<CFSET Props = "">
<CFIF IsDefined("ATTRIBUTES.toolbar")><CFSET Props = ListAppend(Props, "toolbar")></CFIF>
<CFIF IsDefined("ATTRIBUTES.menubar")><CFSET Props = ListAppend(Props, "menubar")></CFIF>
<CFIF IsDefined("ATTRIBUTES.scrollbars")><CFSET Props = ListAppend(Props, "scrollbars")></CFIF>
<CFIF IsDefined("ATTRIBUTES.resizable")><CFSET Props = ListAppend(Props, "resizable")></CFIF>
<CFIF IsDefined("ATTRIBUTES.status")><CFSET Props = ListAppend(Props, "status")></CFIF>
<CFIF IsDefined("ATTRIBUTES.location")><CFSET Props = ListAppend(Props, "location")></CFIF>
<CFIF IsDefined("ATTRIBUTES.directories")><CFSET Props = ListAppend(Props, "directories")></CFIF>
<CFIF IsDefined("ATTRIBUTES.copyhistory")><CFSET Props = ListAppend(Props, "copyhistory")></CFIF>


<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
Gera o Javascript que abre a janela,
se ele ainda não foi criado
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<CFIF NOT IsDefined("CALLER.Criou#ATTRIBUTES.WNAME#")>
	<CFOUTPUT>
	<!---		Javascript para a abertura de janelas		 --->
	<script language="Javascript">
	var Doc#ATTRIBUTES.WNAME# = 0;
	function make#ATTRIBUTES.WNAME#(url, nome){

		if(Doc#ATTRIBUTES.WNAME#){
			if(Doc#ATTRIBUTES.WNAME#.closed){
				Doc#ATTRIBUTES.WNAME# = 0;
				make#ATTRIBUTES.WNAME#(url, nome);
			}else{
				// reabre a janela, antes e lhe dar o foco, o que evita problemas em cache
				Doc#ATTRIBUTES.WNAME# = window.open(url, nome, '#Props#,height=#ATTRIBUTES.HEIGHT#,width=#ATTRIBUTES.WIDTH#');

				// colocar um timer aqui, pois se esta função é chamada muito rapidamente, um erro é gerado
				Doc#ATTRIBUTES.WNAME#.focus();
			}
		}else{
			Doc#ATTRIBUTES.WNAME# = window.open(url, nome, '#Props#,height=#ATTRIBUTES.HEIGHT#,width=#ATTRIBUTES.WIDTH#');
	    	}
	}
	</script>
	</CFOUTPUT>

	<!---		gera uma variável no script que invocou esta tag, para que a função de abrir janela seja gerada uma única vez		 --->
	<CFSET X = SetVariable("CALLER.Criou#ATTRIBUTES.WNAME#", "1")>

</CFIF>
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
Gera o Link
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<CFOUTPUT>
<A HREF="javascript: make#ATTRIBUTES.WNAME#('#ATTRIBUTES.URL#', '#ATTRIBUTES.WNAME#')" >#ATTRIBUTES.LINK#</A>
</CFOUTPUT>
<CFSETTING ENABLECFOUTPUTONLY="NO">

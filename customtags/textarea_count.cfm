
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	
	»» CUSTOMTAG: textarea_count

	AUTOR: Mário K.
	TEMPLATE:  textarea_count.cfm
	
	»	Customtag que cria um campo do formulário (textarea) e conta o numero de caracteres 
		que o usuário ainda pode digitar para o campo

	ATRIBUTOS:
	*- ID : permite que a tag possa ser utilizada mais de uma vez no form
	*- FORMNAME : nome do formulário que o campo pertencerá
	*- FIELDNAME : nome do campo 
	*- MAXCHAR : quantidade máxima de caracteres que o campo permite
	- COLS : numero de colunas do textarea
	- ROWS: numero de linhas do textarea
	- FIELDCONTEUDO : Conteudo que será apresentado dentro do textarea
	- STYLE : style a ser utilizado
	- CLASS ; class do campo
	- REQURED (yes/no): determina se o preenchimento do campo é obrigatório ou não	
	
	EXEMPLO DE USO:
	<cfmodule template="../../customtags/textarea_count.cfm"
		formname="form1"
		fieldname="campo_teste"
		id="teste"
		maxchar="2000"
		cols="50"
		rows="5"
		class="inputBox">
		
	OBSERVAÇÕES:
	- 	Caso a Customtag countfield tenha que ser utilizada mais de uma vez no mesmo form,
		o atributo ID terá que ser diferente.
		
	-  Mudando a FONT da mensagem: basta colocar a tag de font por fora da customtag, da
		seguinte maneira:
	<font color="red" size="1">
		<cfmodule template="../../customtags/textarea_count.cfm"
			formname="form1"
			fieldname="campo_teste"
			id="teste"
			maxchar="2000"
			cols="50"
			rows="5"
			class="inputBox">
	</font>
 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
 
 <!---	 *** VERIFICAÇÕES ***	--->
 
<!---	id	--->
<cfif not isdefined("attributes.id")>
	<blockquote>
		<font color="c40000" face="Verdana" size="3">
			<b>ERRO NA CUSTOMTAG : COUNTFIELD !!!</b>			
		</font>
		<br>
		<font color="Black" face="Verdana" size="2">
			O atributo <b>ID</b> não foi expecificado.
		</font>
		<br><br>
		<font color="Black" face="Verdana" size="1">
		Desenvolvimento:
		<a href="mailto: mario@intrasoft.com.br?SUBJECT=[CustomTag : CountField]"><font color="c40000">Intrasoft</font></a>
		
		</font>
	</blockquote>
</cfif>

<!---	formname	--->
<cfif not isdefined("attributes.formname")>
	<blockquote>
		<font color="c40000" face="Verdana" size="3">
			<b>ERRO NA CUSTOMTAG : COUNTFIELD !!!</b>			
		</font>
		<br>
		<font color="Black" face="Verdana" size="2">
			O atributo <b>FORMNAME</b> não foi expecificado.
		</font>
		<br><br>
		<font color="Black" face="Verdana" size="1">
		Desenvolvimento:
		<a href="mailto: mario@intrasoft.com.br?SUBJECT=[CustomTag : CountField]"><font color="c40000">Intrasoft</font></a>
		
		</font>
	</blockquote>
</cfif>

<!---	fieldname	--->
<cfif not isdefined("attributes.fieldname")>
	<blockquote>
		<font color="c40000" face="Verdana" size="3">
			<b>ERRO NA CUSTOMTAG : COUNTFIELD !!!</b>			
		</font>
		<br>
		<font color="Black" face="Verdana" size="2">
			O atributo <b>FIELDNAME</b> não foi expecificado.
		</font>
		<br><br>
		<font color="Black" face="Verdana" size="1">
		Desenvolvimento:
		<a href="mailto: mario@intrasoft.com.br?SUBJECT=[CustomTag : CountField]"><font color="c40000">Intrasoft</font></a>
		
		</font>
	</blockquote>
</cfif>

<!---	maxchar	--->
<cfif not isdefined("attributes.maxchar")>
	<blockquote>
		<font color="c40000" face="Verdana" size="3">
			<b>ERRO NA CUSTOMTAG : COUNTFIELD !!!</b>			
		</font>
		<br>
		<font color="Black" face="Verdana" size="2">
			O atributo <b>MAXCHAR</b> não foi expecificado.
		</font>
		<br><br>
		<font color="Black" face="Verdana" size="1">
		Desenvolvimento:
		<a href="mailto: mario@intrasoft.com.br?SUBJECT=[CustomTag : CountField]"><font color="c40000">Intrasoft</font></a>
		
		</font>
	</blockquote>
</cfif>

<!---	*** INICIALIZANDO VARIAVEIS *** 	--->

<!---	required	--->
<cfparam name="attributes.required" default="no">
<!---	cols	--->
<cfparam name="attributes.cols" default="50">
<!---	rows	--->
<cfparam name="attributes.rows" default="4">


<cfoutput>

<!---	*** JAVASCRIPT: Contagem dos caracteres *** 	--->
<script language="JavaScript">
<!--
	function countchar_#attributes.id#() 
	{
		var text_#attributes.id# = document.#attributes.formname#.#attributes.fieldname#.value;
		chr_#attributes.id#.innerHTML ='<font face="Arial,Verdana" size="2" color="black">Você ainda pode utilizar</font> '+ (#attributes.maxchar# - text_#attributes.id#.length) +' <font face="Arial,Verdana" size="2" color="black">caracteres</font>';
	}
	
	function valid_required_#attributes.id#()
	{
		var text2_#attributes.id# = document.#attributes.formname#.#attributes.fieldname#;
		if (text2_#attributes.id#.value.length == 0)
		{
			alert('Por favor preencha o campo #attributes.fieldname#');
			text2_#attributes.id#.focus();
			return false;
		}
		else 
			return true;
	}
-->
</script>

<!---	*** CRIAÇÃO DO CAMPO ***	--->
<textarea name="#attributes.fieldname#" onkeyup="countchar_#attributes.id#()" <cfif attributes.required IS "yes">onchange="valid_required_#attributes.id#()"</cfif> rows="#attributes.rows#" cols="#attributes.cols#" <cfif isdefined("attributes.style")>STYLE="#attributes.style#"</cfif> <cfif isdefined("attributes.class")>CLASS="#attributes.class#"</cfif> ><cfif isdefined("attributes.fieldconteudo")>#attributes.fieldconteudo#</cfif></textarea>

<!---	DIV: Contegem de caracteres	--->
<DIV ID="chr_#attributes.id#">
	<font face="Arial,Verdana" size="2" color="Black">Você ainda pode utilizar</font> 
	<script language="JavaScript">
	<!--
		document.write(#attributes.maxchar#-document.#attributes.formname#.#attributes.fieldname#.value.length);
	//-->
	</script>											
	<font face="Arial,Verdana" size="2" color="Black">caracteres</font>
</div>

</cfoutput>

<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: FUNÇÃO - formata_telefone()
	DATA: 23/01/2009				FCR
	
	TEMPLATE: formata_telefone.cfm
	
	formata uma label, retirando acentuacao e 
	substituindo espacos em branco por "_"

	RECEBE: 
		TEXTO,

	RETORNA: 
		string
		
	EXEMPLO:
		
	
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<cfscript>
// formata numero de telefone para saída
function formata_telefone(numero_tel)
{
	//Substitui caracteres acentuados pelos mesmos caracteres s/ acentuação, em uma nova variável
	telefone_formatado = trim(left(numero_tel, (len(numero_tel)-4))) &  "-" & right(numero_tel	, 4);

	return telefone_formatado;
}
</cfscript>
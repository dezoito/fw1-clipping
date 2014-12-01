<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO: FUNÇÃO - converte_chars_UTF8()
	DATA: 06/01/2014			FCR

	TEMPLATE: converte_chars_UTF8.cfm

	Esta função apenas retornará uma string com a quantidade de
	caracteres determinado pelo usuário como se estivesse abreviada, mais os últimos 7 caracteres do nom incluindo a extensão.

	RECEBE:
		TEXTO,

	RETORNA:
		string

	EXEMPLO:
		CHAMADA: #converte_chars_UTF8(texto)(texto_com_UTF-8,)# - RETORNO: "texto limpo"

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->

<!--- substitui caracteres formatados incorretamente com charset --->
<cfscript>

// pega uma string que contem caracteres
// e converte em chars portugueses
// quantidade de caracteres determinado pelo usuário

// para testar novos caracteres, é necessário comentar TODAS
// as substituições

function converte_chars_UTF8(texto) {
	texto = replace(texto, "Ãª", "ê", "all");
	texto = replace(texto, "ÃŠ", "Ê", "all");
	texto = replace(texto, "Ã´", "ô", "all");
	texto = replace(texto, "Ã”", "Ô", "all");
	texto = replace(texto, "Âª", "ª", "all");
	texto = replace(texto, "Âº", "º", "all");
	texto = replace(texto, "Â°", "º", "all"); // difere do de cima, mas substitui por ASCII 166
	texto = replace(texto, "Ã£", "ã", "all");
	//texto = replace(texto, "Ãƒ", "Ã", "all"); // sera substituido no final
	texto = replace(texto, "Ã§", "ç", "all");
	texto = replace(texto, "Ã‡", "Ç", "all");
	texto = replace(texto, "Ã€", "À", "all");
	texto = replace(texto, "Ã¡", "á", "all");
	texto = replace(texto, "Ã", "Á", "all");
	texto = replace(texto, "Ã©", "é", "all");
	texto = replace(texto, "Ã‰", "É", "all");
	texto = replace(texto, "Ã³", "ó", "all");
	texto = replace(texto, "Ã“", "Ó", "all");
	texto = replace(texto, "Ãº", "ú", "all");
	texto = replace(texto, "Ãš", "Ú", "all");
	texto = replace(texto, "Ã­", "í", "all");
	texto = replace(texto, "Ã", "Í", "all");
	texto = replace(texto, "Ãº", "ú", "all");
	texto = replace(texto, "Ãš", "Ú", "all");
	texto = replace(texto, "Ãµ", "õ", "all");
	texto = replace(texto, "Ã•", "Õ", "all");
	texto = replace(texto, "Ã", "à", "all"); // tem que ter feito todas as substituições
	// hack para o Ã (que já foi repleaceado antes)
	texto = replace(texto, "àƒ", "Ã", "all");
	return texto;
}
</cfscript>




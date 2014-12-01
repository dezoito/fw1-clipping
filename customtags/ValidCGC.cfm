<!---  ---------------------------------------------------------------------------------------------------------
VALIDCGC.CFM	 10/97

Script para Cold Fusion, valida Números de CGC.

Variáveis:		CGCNum - string - Num. de CPF, contendo ou não
		espaços e hifens

Retorna:		ValidCGC: TRUE se o CPF for válido,
		FALSE em caso negativo
------------------------------------------------------------------------------------------------------------ --->

<CFSET CGCNum = #Attributes.CGCNum#>

<CFSET #ValidCGC# =  "TRUE">


<!--- Take out the spaces from the number. --->
<CFSET #CGCNum# = #Replace(CGCNum, " ", "", "ALL")#>

<!--- Take out the dots from the number. --->
<CFSET #CGCNum# = #Replace(CGCNum, ".", "", "ALL")#>

<!--- Take out the "- " from the number. --->
<CFSET #CGCNum# = #Replace(CGCNum, "-", "", "ALL")#>

<!--- Take out the "/" from the number. --->
<CFSET #CGCNum# = #Replace(CGCNum, "/", "", "ALL")#>

<!---   Verificar se resta algum caractere inválido   --->
<CFIF #IsNumeric(CGCNum)# IS "No">
<CFSET #ValidCGC# =  "FALSE">

<CFELSE>

<!---   Medir Num de caracteres numéricos   --->
          <CFIF #Len(CGCNum)# NEQ 14>
          <CFSET #ValidCGC# =  "FALSE">

          <CFELSE>

           <!---   LOOP1   --->
           <CFLOOP
	INDEX="i"
	FROM ="1"
	TO ="14">

	<!---   INICIA VERIFICACAO DIGITOS 13 E 14   --->

	<CFSET Resto = 0>
	<CFSET Verificador = 13>
	<CFSET Teste = "TRUE">


	<!---   LOOP 2   --->
	<CFLOOP CONDITION="Teste EQ TRUE">


	     <CFSET j=2>
	     <CFSET Soma=0>

		<!---   LOOP3   --->
		<CFLOOP
		     INDEX="i"
		     FROM="#DecrementValue(Verificador)#"
		     TO="1"
		     STEP="-1">


			<CFSET Soma = #Soma# + (#Mid(CGCNum, i, 1)# * j)>
			<CFIF j IS 9>
			   <CFSET j=2>

			<CFELSE>
			   <CFSET j= #j#+1>

			</CFIF>

		</CFLOOP><!---   Fim LOOP3   --->

		<CFSET Resto = #Soma# MOD 11>

		<CFIF (Resto IS 0) OR (Resto IS 1)>
		   <CFSET Num = 0>

		<CFELSE>
		<CFSET Num = 11- #Resto#>

		</CFIF>

		<CFIF #Mid(CGCNum, Verificador, 1)# NEQ #Num#>
		<CFSET #ValidCGC# =  "FALSE">
		<CFSET #Teste# =  "FALSE">

		<CFELSE>
			<CFIF Verificador IS 13>
			<CFSET Verificador = 14>

			<CFELSE>
			<CFSET #ValidCGC# = "TRUE">
			<CFSET #Teste# = "FALSE">

			</CFIF>
		</CFIF>

	</CFLOOP><!---   Fim LOOP 2   --->
          </CFLOOP><!---   Fim LOOP 1   --->
          </CFIF>
</CFIF>

<CFSET CALLER.ValidCGC = #ValidCGC#>

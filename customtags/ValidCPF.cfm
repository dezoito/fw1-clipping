<!---  ---------------------------------------------------------------------------------------------------------
VALIDCPF.CFM		 12/97

Validates CPF Numbers (some sort of Social Security Number we have
 around here

Variables:		CPFNum - string containing the CPF Number

Returns:		ValidCPF: TRUE if CPF is Valid
			FALSE otherwise
------------------------------------------------------------------------------------------------------------ --->
<CFIF #ParameterExists(Attributes.CPFNum)# IS "Yes">
<CFSET CPFNum =  #ATTRIBUTES.CPFNum#>
</CFIF>

<CFSET ValidCPF =  "TRUE">


<!--- Take out the spaces from the number. --->
<CFSET CPFNum = #Replace(CPFNum, " ", "", "ALL")#>

<!--- Take out the dots from the number. --->
<CFSET CPFNum = #Replace(CPFNum, ".", "", "ALL")#>

<!--- Take out the "- " from the number. --->
<CFSET CPFNum = #Replace(CPFNum, "-", "", "ALL")#>

<!---   Verificar se resta algum caractere inválido   --->
<CFIF #IsNumeric(CPFNum)# IS "No">

<CFSET ValidCPF =  "FALSE">

<CFELSE>

     <!---   Verificar quantidade de algarismos   --->
     <CFIF #Len(CPFNum)# IS NOT 11>
     <CFSET ValidCPF =  "FALSE">

     <CFELSE>

        <!---   Inicia LOOPS da verificação   --->
        <!---   LOOP 1   --->
        <CFLOOP
	INDEX="i"
	FROM ="1"
	TO ="11">

	<CFIF (#Mid(CPFNum, i, 1)# LT 0) OR (#Mid(CPFNum, i, 1)# GT 9)>
	     <CFSET ValidCPF =  "FALSE">
	</CFIF>

        </CFLOOP><!---   Fim LOOP 1   --->


	<CFIF ValidCPF IS "TRUE">

	   <CFSET VerDig = 10>

	        <!---   LOOP 2  --->
	        <CFLOOP CONDITION=" #VerDig# LTE 11">

	        <CFSET j = 2>
	        <CFSET Soma = 0>

	        <!---   LOOP 3   --->
        		<CFLOOP
		    INDEX="i"
		    FROM ="#DecrementValue(VerDig)#"
		    TO="1"
		    STEP="-1">

		      <CFSET Soma = #Soma# + (#Mid(CPFNum, i, 1)# * #j#)>
		      <CFSET j = #j# + 1>

	        	</CFLOOP><!---   Fim LOOP 3   --->

		<CFSET Complemento = (11- #Soma# MOD 11)>
		<CFIF Complemento GTE 10>
		   <CFSET Complemento = 0>
		</CFIF>

		<CFIF #Mid(CPFNum, VerDig, 1)# NEQ #Complemento#>
     		   <CFSET #ValidCPF# =  "FALSE">
		</CFIF>

		<CFSET VerDig = #VerDig# + 1>
	        </CFLOOP><!---   Fim LOOP 2   --->

	</CFIF>
     </CFIF>
</CFIF>


<CFSET CALLER.ValidCPF = #ValidCPF#>

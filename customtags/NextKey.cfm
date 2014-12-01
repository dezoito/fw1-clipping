<CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO:	ColdFusion Extension

	TEMPLATE: NextKey.cfm

	Finds the Next Possible Value in a Numbered Primary Key Colum
	Encontra o Próximo valor de uma chave primária Numerada

	Attributes: 	DSN (Datasource)
			Table (TableName)
			Key (Column Name)

	Returns: NextKey: Integer

	EXAMPLE:
	<CF_NextKey
		DSN="Some_DSB"
		Table="My_Table"
		Key="Some_Column">

		Returns: NextKey=56

IMPORTANT:
This Tag AND the insert Statement must be enclosed CFTRANSACTION Tags
Esta Tag E o SQL para Insert devem estar dentro de CFTRANSACTION Tags

 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->


<!---		Check Attributes		 --->
<CFIF NOT IsDefined("ATTRIBUTES.DSN")>
	<CFOUTPUT><P>ERROR: No DSN Attribute Specified</CFOUTPUT>
	<CFABORT>
</CFIF>

<CFIF NOT IsDefined("ATTRIBUTES.TABLE")>
	<CFOUTPUT><P>ERROR: No Table Attribute Specified</CFOUTPUT>
	<CFABORT>
</CFIF>

<CFIF NOT IsDefined("ATTRIBUTES.Key")>
	<CFOUTPUT><P>ERROR: No Key Attribute Specified</CFOUTPUT>
	<CFABORT>
</CFIF>

<!---		Find Next Possible KEY		 --->
	<CFQUERY NAME="GetNextKey" DATASOURCE="#ATTRIBUTES.DSN#">
		SELECT MAX(#ATTRIBUTES.Key#) AS NextKey
		 FROM #ATTRIBUTES.Table#
	</CFQUERY>


<!---		Set Variable in CALLER template		 --->
	<CFIF GetNextKey.NextKey IS "">
	<CFSET CALLER.NextKey = 1>
	<CFELSE>
	<CFSET CALLER.NextKey = GetNextKey.NextKey+1>
	</CFIF>


<CFSETTING ENABLECFOUTPUTONLY="NO">

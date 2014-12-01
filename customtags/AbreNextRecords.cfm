<CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	PROJETO:

	TEMPLATE: AbreNextRecords.cfm

	Custom Tag baseada na Informação abaixo:
	Necessita de AbreNextRecords.cfm

	Permite dividir o resultado de uma consulta em páginas com N registros.
	AbreNextRecords.cfm - Divide os resultados
	FechaNextRecords.cfm - Cria Link ou botão p/ avanço, retrocesso

ATRIBUTOS E OBSERVAÇÕES:
ver abaixo

 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->


<!---
AUTHOR:		Robert A. Weimer (robert@info-access.com)
CREATED:	February 26, 1998
REVISED:	April 21, 1998

Please note this tag is unsupported.  It is not guaranteed to work - EVER!
Use at your own risk, I am NOT responsible for any damage to your equipment
or mental health.  If you absolutely feel the need to email me for help,
please make sure you have tried EVERYTHING possible before contacting me and
don't be offended if I don't answer your email -- I'm just as busy as you.

DESCRIPTION:
CF_NextRecords is a Cold Fusion custom tag that displays the next set
of records in a query.  It allows the user to move forward and backwards
through a set of records using a single CFML template.

REQUIRED ATTRIBUTES:
Records:			The total record count of the current query.  This
					can be set by using the query's name with the
					'RecordCount' property.  For example, assume the
					query is named MyQuery then use
					#MyQuery.RecordCount# for this attribute.  You must
					use the pound signs (#) for it to work.

ThisPageName:		The name of the CFML template. (mytemplate.cfm)

THIS REQUIRED VARIABLE MUST GO IN THE <CFOUTPUT> TAG -
SR:					The starting row for the CFOUTPUT tag.  Within the
					CFOUTPUT tag within your template add the attribute
					StartRow=#SR#

THIS REQUIRED VARIABLE MUST GO IN THE <CFOUTPUT> TAG AND
THE <CF_NextRecord> TAG -
RecordsToDisplay:	The number of records to display in each pass. This
					attribute MUST be used in conjunction with the MaxRows
					attribute of the CFOUTPUT tag displaying the query's
					data. They MUST be set to the same number.  The tag has
					no control over the number of records the template will
					actually display.  Within the CFOUTPUT tag within your
					template add the attribute MaxRows=#RecordsToDisplay#


NON-REQUIRED ATTRIBUTES:
DisplayText:		The displayed before the next/previous record count.
					The default is "Record."  Don't make the word plural,
					let the tag handle that.  The tag traps for the next
					set of records only containing one record.
					For example - Back to RECORDS 1 - 5
					Or Forward to RECORD 31.

DisplayFont:		Font face to use for display.  Default is Arial.

FontSize:			Font size to use in display.  Default is 2.

UseBold:			Yes/No Make font bold.  Default is no.

ExtraURL:			Any extended URL information that needs to be appended
					to the hyperlink and passed to the next CFML template.
					Many queries require specific variables be present to
					allow the query to function.  For example in the 'WHERE'
					clause of the SQL statement.  The ExtraURL attribute
					will be appended to the next templates URL when the
					back/forward hyperlinks are clicked.  This attribute may
					take some playing with, however.  Please try to get the
					tag to display the first set of records before
					attempting to add the ExtraURL attribute.

NOTES:
If the total record count for the query is less than the number of records
set to display (RecordsToDisplay) then the Back/Forward will NOT appear.
 --->


<cfoutput>

<!--- Establish Variables --->
<cfset Caller.RecordsToDisplay = #Attributes.RecordsToDisplay#>

<cfif IsDefined("Attributes.DisplayText") IS "No">
	<cfset Attributes.DisplayText = "Record">
</cfif>
<cfif IsDefined("URL.SR") IS "No">
	<cfset Caller.SR = "1">
</cfif>
<cfif IsDefined("Attributes.DisplayFont") IS "No">
	<cfset Attributes.DisplayFont = "Arial">
</cfif>
<cfif IsDefined("Attributes.FontSize") IS "No">
	<cfset Attributes.FontSize = "2">
</cfif>
<cfif IsDefined("Attributes.UseBold") IS "No">
	<cfset Attributes.UseBold = "No">
</cfif>
<cfif IsDefined("Attributes.ExtraURL") IS "No">
	<cfset Attributes.ExtraURL = "">
</cfif>

<!--- If less than Caller.RecordsToDisplay then don't display--->
<cfif Attributes.Records GT Caller.RecordsToDisplay>
	<CFIF Caller.SR LT Caller.RecordsToDisplay>
		<CFELSE>
			<CFSET BackUp = (Caller.SR - Caller.RecordsToDisplay)>
			<!---		Previous N		 --->
	<!--- This is a separator between Previous/Next --->
	<!---		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;		 --->
	</CFIF>
	<CFIF (Caller.SR + (Caller.RecordsToDisplay - 1)) LT Attributes.Records>
		<CFSET StartRowA = (Caller.SR + Caller.RecordsToDisplay)>
		<CFSET StartRowB = (StartRowA + (Caller.RecordsToDisplay - 1))>
		<CFSET FORWARD = (Caller.SR + Caller.RecordsToDisplay)>
			<CFIF StartRowB GT Attributes.Records>
				<CFSET StartRowB = Attributes.Records>
				<cfset LastRecords = Attributes.Records - (Caller.SR + (Caller.RecordsToDisplay - 1))>
				<CFIF StartRowA IS StartRowB>
					<!---		LAST N RECORD		 --->
				<CFELSE>
					<!---		LAST N RECORD		 --->
				</CFIF>
			<CFELSE>
					<!---		NEXT N TO DISPLAY		 --->
			</CFIF>
	<CFELSE>
	<!---		END OF LIST		 --->
	</CFIF>
</cfif>

</cfoutput>
<CFSETTING ENABLECFOUTPUTONLY="No">

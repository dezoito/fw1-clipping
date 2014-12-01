<cfsetting enablecfoutputonly="Yes">



<!--- Only process in END execution mode --->
<cfswitch expression="#ThisTag.ExecutionMode#">
	<cfcase value="START">
		<cfoutput>
			<div id="div_#attributes.id#" style="display: none; visibility: hidden; position: absolute;">
		</cfoutput>

	</cfcase>
	<cfcase value="END">
		<cfoutput>
			</div>
		</cfoutput>
 	</cfcase>
</cfswitch>

<cfsetting enablecfoutputonly="No">

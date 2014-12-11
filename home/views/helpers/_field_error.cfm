<!-------------------------------------------------------------
Use this to display errors next to a formfield
--------------------------------------------------------------->
<cfif isDefined("rc.stErrors.#local.field#")>
    <cfoutput><p class="alert alert-danger">#rc.stErrors[local.field]#</p></cfoutput>
</cfif>

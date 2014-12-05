<cfset request.layout = false>
<!---
==================================================
Load javascript references
(we have to reload them since this is going to run on an ajax loaded modal)
================================================== --->
<cfinclude template="../../../common/layouts/_inc_javascript.cfm">

<cfsavecontent
    variable = "button_menu">
    <div class="form-group">
        <div class="col-xs-offset-2 col-xs-10">
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="#" data-dismiss="modal" class="btn btn-default">Close</a>

            <cfif val(rc.Clipping.getClipping_id())>
                <button type="button" class="btn btn-danger action-needs-confirm">Delete</button><!---     onClick='document.getElementById("form-delete").submit();'     --->
            </cfif>
        </div>
    </div>
</cfsavecontent>

<cfinclude template="_inc_form.cfm">

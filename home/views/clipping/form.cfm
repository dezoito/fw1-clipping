
<!---    define how the buttom menu will be displayed in the forms     --->
<cfsavecontent
    variable = "button_menu">
    <div class="form-group">
        <div class="col-xs-offset-2 col-xs-10">
            <button type="submit" class="btn btn-primary" id="btn_save">Save</button>
            <button type="button" class="btn go-back" id="btn_cancel">Cancel</button>

            <cfif val(rc.Clipping.getClipping_id())>
                <button type="button" class="btn btn-danger action-needs-confirm" id="btn_delete">Delete</button>
            </cfif>
        </div>
    </div>
</cfsavecontent>


<cfinclude template="_inc_form.cfm">

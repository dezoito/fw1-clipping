<cfset request.layout = false>
<cfsetting showdebugoutput="false">

<!---    since we are not loading the layout, load just the JS!     --->
    <script src="static/js/jquery-2.1.0.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/bootstrap-switch.js"></script>
    <script src="static/js/lightbox-2.6.min.js"></script>
    <script src="static/js/jquery.sticky.js"></script>
    <script src="static/js/jquery-ui-1.10.3.custom.js"></script>
    <script src="static/js/clipping.js"></script>
    <script src="static/js/sweet-alert.js"></script>

<cfsavecontent
    variable = "button_menu">
    <div class="form-group">
        <div class="col-xs-offset-2 col-xs-10">
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="#" data-dismiss="modal" class="btn btn-default">Close</a>
            <button type="button" class="btn btn-danger action-needs-confirm">Delete</button><!---     onClick='document.getElementById("form-delete").submit();'     --->
        </div>
    </div>
</cfsavecontent>

<cfinclude template="_inc_form.cfm">

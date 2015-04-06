<!-------------------------------------------------------------
Include with common form definitions and fields.
Menus are defined at the parent .cfm

--------------------------------------------------------------->

<!---    display alert if there were errors     --->
<cfif structKeyExists(rc, "stErrors") and (structCount(rc.stErrors) gt 0)>
    <div class="alert alert-danger">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
            <b>Your article could not be posted!</b><br/>
            Please fix the errors below:

<!-------------------------------------------------------------
            <ul>
            <cfloop index="e" struct="#rc.stErrors#">
                <cfoutput><li>#rc.stErrors[e]#</li></cfoutput>
            </cfloop>
            </ul>
--------------------------------------------------------------->
    </div>
</cfif>

<!-------------------------------------------------------------
for styling info see:
http://www.tutorialrepublic.com/twitter-bootstrap-tutorial/bootstrap-forms.php
--------------------------------------------------------------->

<cfoutput>
<form action="#buildURL('clipping.save')#" method="post" role="form" class="form-horizontal" id="f_clipping">

    <input name="csrftoken" type="hidden" value="#request.csrfToken#">

    <input type="hidden" name="clipping_id" id="clipping_id"
        value="#HtmlEditFormat(rc.Clipping.getClipping_id())#">

    <div class="form-group">
        <label for="clipping_titulo" class="control-label col-sm-2">Title <span class="required">*</span></label>
        <div class="col-sm-9">
            <input type="text" name="clipping_titulo" id="clipping_titulo"
                value="#HTMLEditFormat(rc.Clipping.getClipping_titulo())#" size="100" class="form-control">
                <!---    display errors?    --->
                #view("helpers/_field_error", {field="clipping_titulo"})#
        </div>
    </div>

    <div class="form-group">
        <label for="clipping_texto"  class="control-label col-sm-2">Text <span class="required">*</span></label>
        <div class="col-sm-9">
            <textarea name="clipping_texto" id="clipping_texto" cols="50" rows="10"
                class="form-control">#HTMLEditFormat(rc.Clipping.getClipping_texto())#</textarea>
                <!---    display errors?    --->
                #view("helpers/_field_error", {field="clipping_texto"})#
        </div>
    </div>

    <div class="form-group">
        <label for="clipping_link" class="control-label col-sm-2">Link</label>
        <div class="col-sm-9">
            <input type="url" name="clipping_link"
                value="#HTMLEditFormat(rc.Clipping.getClipping_link())#" size="100"  class="form-control">
                <!---    display errors?    --->
                #view("helpers/_field_error", {field="clipping_link"})#
        </div>
    </div>

    <div class="form-group">
        <label for="clipping_fonte" class="control-label col-sm-2">Source</label>
        <div class="col-sm-9">
            <input type="text" name="clipping_fonte"
                value="#HTMLEditFormat(rc.Clipping.getClipping_fonte())#" size="100"  class="form-control">
                <!---    display errors?    --->
                #view("helpers/_field_error", {field="clipping_fonte"})#
        </div>
    </div>

    <div class="form-group">
        <label for="published" class="control-label col-sm-2">Published <span class="required">*</span></label>
        <div class="col-sm-3">
            <input type="text" name="published" id="published"
                value="#dateFormat(rc.Clipping.getPublished(), "dd/mm/yyyy")#" size="10"
                class="form-control datepicker">
                <!---    display errors?    --->
                #view("helpers/_field_error", {field="published"})#
        </div>
    </div>

    <!---    display menu (defined in the view that included this file)     --->
    <div class="form-group">
        <div class="col-xs-offset-2 col-xs-10">
            <button type="submit" class="btn btn-primary" id="btn_save">Save</button>
            <button type="button" class="btn go-back" id="btn_cancel">Cancel</button>

            <cfif val(rc.Clipping.getClipping_id())>
                <button type="button" class="btn btn-danger action-needs-confirm" id="btn_delete">Delete</button>
            </cfif>
        </div>
    </div>


</form>
</cfoutput>

<!---    form to delete clipping articles     --->
<cfoutput>
    <form action="#buildURL('clipping.delete')#" method="post" id="form-delete">
        <input name="csrftoken" type="hidden" value="#request.csrfToken#">
        <input type="hidden" name="clipping_id" id="clipping_id" value="#HtmlEditFormat(rc.Clipping.getClipping_id())#">
    </form>
</cfoutput>

<!---    use WYSIWYG editor instead of textarea     --->
<script>
    // Replace the <textarea id="clipping_texto"> with a CKEditor
    // instance, using default configuration.
    // examples in: http://ckeditor.com/latest/samples/plugins/toolbar/toolbar.html
    CKEDITOR.replace( 'clipping_texto', {
            width: 600,
            height: 300,
            resize_dir: 'both',
            resize_minWidth: 200,
            resize_minHeight: 300,
            resize_maxWidth: 800,
            toolbar: [
                    { name: 'document', items: [ 'Source', '-', 'Templates' ] }, // Defines toolbar group with name (used to create voice label) and items in 3 subgroups.
                    [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ],          // Defines toolbar group without name.                                                                               // Line break - next group will be placed in new line.
                    { name: 'basicstyles', items: [ 'Bold', 'Italic'] },
                    { name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
                    { name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule', 'PageBreak'] },

            ]
        });


    // if we have date inputs, make them a datepicker
    // $(document).ready(function(){
    //   $(".datepicker").datepicker({ dateFormat: 'dd/mm/yy' });
    // });
</script>

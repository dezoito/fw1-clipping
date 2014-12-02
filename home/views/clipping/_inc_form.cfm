<!-------------------------------------------------------------
Include with common form definitions and fields.
Menus are defined at the parent .cfm

--------------------------------------------------------------->

<!---    display form error messages     --->
<cfif structKeyExists(rc, "errors") and (arrayLen(rc.errors) gt 0)>
    <div class="alert alert-danger">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
            <b>Your article could not be posted due to the following error(s):</b><br/>
            <ul>
            <cfloop index="e" array="#rc.errors#">
                <cfoutput><li>#e#</li></cfoutput>
            </cfloop>
            </ul>
    </div>
</cfif>

<!-------------------------------------------------------------
for styling info see:
http://www.tutorialrepublic.com/twitter-bootstrap-tutorial/bootstrap-forms.php
--------------------------------------------------------------->

<cfoutput>
<form action="#buildURL('clipping.save')#" method="post" role="form" class="form-horizontal">

    <input type="hidden" name="clipping_id" id="clipping_id" value="#HtmlEditFormat(rc.Clipping.getClipping_id())#">

    <div class="form-group">
        <label for="clipping_titulo" class="control-label col-sm-2">Title <span class="required">*</span></label>
        <div class="col-sm-9">
            <input type="text" name="clipping_titulo" value="#HTMLEditFormat(rc.Clipping.getClipping_titulo())#" size="100"  class="form-control">
        </div>
    </div>

    <div class="form-group">
        <label for="clipping_texto"  class="control-label col-sm-2">Text <span class="required">*</span></label>
        <div class="col-sm-9">
            <textarea name="clipping_texto" id="clipping_texto" cols="50" rows="10" class="form-control">#HTMLEditFormat(rc.Clipping.getClipping_texto())#</textarea>
        </div>
    </div>

    <div class="form-group">
        <label for="clipping_link" class="control-label col-sm-2">Link</label>
        <div class="col-sm-9">
            <input type="url" name="clipping_link" value="#HTMLEditFormat(rc.Clipping.getClipping_link())#" size="100"  class="form-control">
        </div>
    </div>

    <div class="form-group">
        <label for="clipping_fonte" class="control-label col-sm-2">Source</label>
        <div class="col-sm-9">
            <input type="text" name="clipping_fonte" value="#HTMLEditFormat(rc.Clipping.getClipping_fonte())#" size="100"  class="form-control">
        </div>
    </div>

    <div class="form-group">
        <label for="published" class="control-label col-sm-2">Published: <span class="required">*</span></label>
        <div class="col-sm-3">
            <input type="text" name="published" value="#dateFormat(rc.Clipping.getPublished(), "dd/mm/yyyy")#" size="10"
            class="form-control datepicker">
        </div>
    </div>

    <!---    display menu (defined in the view)     --->
    #button_menu#


</form>
</cfoutput>

<!---    form to delete clipping articles     --->
<cfoutput>
    <form action="#buildURL('clipping.delete')#" method="post" id="form-delete">
        <input type="hidden" name="clipping_id" id="clipping_id" value="#HtmlEditFormat(rc.Clipping.getClipping_id())#">
    </form>
</cfoutput>

<!---    use WYSIWYG editor instead of textarea     --->
<script>
    // Replace the <textarea id="editor1"> with a CKEditor
    // instance, using default configuration.
    CKEDITOR.replace( 'clipping_texto', {
            width: 600,
            height: 300,
            resize_dir: 'both',
            resize_minWidth: 200,
            resize_minHeight: 300,
            resize_maxWidth: 800
        });

    // if we have date inputs, make them a datepicker
    $(document).ready(function(){
      $(".datepicker").datepicker({ dateFormat: 'dd/mm/yy' });
    });
</script>

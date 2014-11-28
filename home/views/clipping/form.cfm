<cfset rc.pagetitle = "Post an Article">

<!---    default form values     --->
<cfparam name="rc.Clipping.clipping_id" default="">
<cfparam name="rc.Clipping.clipping_titulo" default="">
<cfparam name="rc.Clipping.clipping_texto" default="">
<cfparam name="rc.Clipping.clipping_fonte" default="">
<cfparam name="rc.Clipping.clipping_link" default="">
<cfparam name="rc.Clipping.published" default="#now()#">


<h3>Save an Article</h3>

<!---    TO DO: bootstrap message classes     --->
<cfif structKeyExists(rc, "errors")>
    <div class="alert alert-danger">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
            <b>Your article coult not be posted due to the following error(s):</b><br/>
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
<form action="#buildURL('clipping.post')#" method="post" role="form" class="form-horizontal">
    <div class="form-group">
        <label for="clipping_titulo" class="control-label col-sm-2">Title <span class="required">*</span></label>
        <div class="col-sm-9">
            <input type="text" name="clipping_titulo" value="#HTMLEditFormat(rc.Clipping.clipping_titulo)#" size="100"  class="form-control" >
        </div>
    </div>


    <div class="form-group">
        <label for="clipping_texto"  class="control-label col-sm-2">Text <span class="required">*</span></label>
        <div class="col-sm-9">
            <textarea name="clipping_texto" id="clipping_texto" cols="50" rows="10" class="form-control" >#HTMLEditFormat(rc.Clipping.clipping_texto)#</textarea>
        </div>
    </div>

    <div class="form-group">
        <label for="clipping_link" class="control-label col-sm-2">Link</label>
        <div class="col-sm-9">
            <input type="url" name="clipping_link" value="#HTMLEditFormat(rc.Clipping.clipping_link)#" size="100"  class="form-control" >
        </div>
    </div>

    <div class="form-group">
        <label for="clipping_fonte" class="control-label col-sm-2">Source</label>
        <div class="col-sm-9">
            <input type="text" name="clipping_fonte" value="#HTMLEditFormat(rc.Clipping.clipping_fonte)#" size="100"  class="form-control" >
        </div>
    </div>

    <div class="form-group">
        <label for="published" class="control-label col-sm-2">Published: <span class="required">*</span></label>
        <div class="col-sm-3">
            <input type="text" name="published" value="#dateFormat(rc.Clipping.published, "dd/mm/yyyy")#" size="10"
            class="form-control datepicker" >
        </div>
    </div>



    <div class="form-group">
        <div class="col-xs-offset-2 col-xs-10">
            <button type="submit" class="btn btn-primary">Save</button>
            <button type="button" class="btn go-back">Cancel</button>
        </div>
    </div>


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

    // published date uses datepicker widget
    // jQuery(function($){
    //     $(".datepicker").datepicker();
    // });
</script>

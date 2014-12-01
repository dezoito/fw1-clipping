<!---
DESCRIPTION:
Cold Fusion custom tag to embed all submitted form fields as hidden
fields in another form. Designed to be used within multi part forms.
To use just call this module between the <FORM> and </FORM> tags.

ATTRIBUTES:
None.

NOTES:
Tag processes the comma delimited list of field names available as
FORM.fieldnames (this variable is automatically available if any
form fields were submitted). Each field is checked to see that
it has not already been processed (if there were multiple fields
with the same name then they'd appear multiple times in the
FORM.fieldnames list), and then it is written out as a hidden
FORM field (INPUT TYPE="hidden").

USAGE:
To use, just include <CF_EmbedFields> anywhere between the <FORM>
and </FORM> tags (or <CFFORM> and </CFFORM>). Any passed form
fields will automatically be embedded. If no form fields are
present then nothing is embedded, and processing continues.

AUTHOR:
Ben Forta (ben@stoneage.com) 7/15/97
--->

<!--- Check that fieldnames exists --->
<CFIF #ParameterExists(FORM.fieldnames)#>

 <!--- Create empty list of processed variables --->
 <CFSET #fieldnames_processed# = "">

 <!--- Loop through fieldnames --->
 <CFLOOP INDEX="form_element" LIST="#FORM.fieldnames#">

  <!--- Try to find current element in list --->
  <CFIF #ListFind(#fieldnames_processed#, #form_element#)# IS 0>

   <!--- Make fully qualified copy of it (to prevent acessing the wrong field type) --->
   <CFSET #form_element_qualified# = "FORM." & #form_element#>

   <!--- Output it as a hidden field --->
   <CFOUTPUT>
   <INPUT TYPE="hidden" NAME="#form_element#" VALUE="#Evaluate(form_element_qualified)#">
   </CFOUTPUT>

   <!--- And add it to the processed list --->
   <CFSET #fieldnames_processed# = #ListAppend(#fieldnames_processed#, #form_element#)#>

  </CFIF>

 </CFLOOP>

</CFIF>

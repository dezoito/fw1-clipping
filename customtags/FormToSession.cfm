<!---
Modified version of CF_Embedfields by Ben Forta (ben@stoneage.com)

DESCRIPTION:

Cold Fusion custom tag to make session variables of all submitted
form fields.
Call this module anywhere in the document recieving form data.


ATTRIBUTES:
None.

(Ben Fortas) NOTES:
Tag processes the comma delimited list of field names available as
FORM.fieldnames (this variable is automatically available if any
form fields were submitted). Each field is checked to see that
it has not already been processed (if there were multiple fields
with the same name then they'd appear multiple times in the
FORM.fieldnames list), and then it is written out as a hidden
FORM field (INPUT TYPE="hidden").


USAGE:
To use, just include <CF_FormToSession> anywhere in the .cfm
recieving form fields. Any passed form fields will automatically
be converted to session variables.
(form.name will be session.name)
If no form fields are present then nothing is converted, and
processing continues.

WHY:
When using multipart forms, having both edit and insert functions,
I find it easier to use session variables containing values of the
specific record being edited/created.
When querying for data, I can put the result in session variables
and use the same form all the time.
(<input name="city" value="#session.city#">)
Make sure to initialize all fieldnames in the database with
CFPARAM in the application.cfm, then it should run smoothly


AUTHOR:
Stefan Vesterlund (stefan.vesterlund@kommun.gellivare.se) 1997-12-11

Original code (CF_Embedfields)
Ben Forta (ben@stoneage.com) 7/15/97

--->


 <CFIF #ParameterExists(FORM.fieldnames)#>

  <!--- Create empty list of processed variables --->
  <CFSET #fieldnames_processed# = "">


  <!--- Loop through fieldnames --->

 <CFLOOP INDEX="form_element" LIST="#FORM.fieldnames#">

  <!--- Try to find current element in list --->
  <CFIF #ListFind(#fieldnames_processed#, #form_element#)# IS 0>

  <!--- Make fully qualified copy of it (to prevent acessing the wrong field type) --->
  <CFSET #form_element_qualified# = "FORM." & #form_element#>

  <!--- Make the name for the session variable --->
  <CFSET #session_element_qualified# = "session." & #form_element#>

  <!--- Set the session variable --->
  <cfset a = #SetVariable(session_element_qualified, "#Evaluate(form_element_qualified)#")#>

  <!--- And add it to the processed list --->
  <CFSET #fieldnames_processed# = #ListAppend(#fieldnames_processed#, #form_element#)#>

  </CFIF>

 </CFLOOP>

</CFIF>

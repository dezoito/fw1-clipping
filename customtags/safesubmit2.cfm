<CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- safesubmit2.cfm  Version 2.0, 19/08/2014

	Adicionei, ao trabalho abaixo, a opçã de criar um botão simples,
	que chama uma funcao javascript, ao invés de um simples botão "submit"

	Contributers: Justin Wall, James Smith, Raymond Camden, Joshua Jacobs, CF Conference '98 Ft. Collins

	Description: Creates a form submit button that disallows multipule submissions of that form through Javascript.
		The text label inside the button will change to another defined value. Default is "Submit" and "Wait!"

	Notes:
		- This is not a complete tag. Several key features (mention below) are not implemented.  I don't have the time
			right now, but I will continue to work on this. ;)
		- This has been tested on Netscape Navigator 3.04, 4.05 and MS Internet Explorer 4.01
		- Image button support is not available.
		- !!Warning!!: If the Client's browser does not support Javascript, It's possible that the button created will
			not submit the form!

	Passed variables:
		buttonText1 -Optional, Text that button will initally have, before click.  Default is "Submit" (w/o quotes)
		buttonText2 -Optional, Text that button will have after click.  Default is "Submit" (w/o quotes)

	Returned:
		Javacript function :  SwitchButtonValue()
			Switches the value of the button from submit to wait.
		HTML : Input Type Button

	Usage:
		<CF_SafeSubmit
			buttonText1 = "Click Here to Submit"
			buttonText2 = "Please Wait"
		>

	Questions? Complaints? Comments? Bugs? 	Email:Justin@wall.org
--->


<CFPARAM NAME="ATTRIBUTES.buttontext1" DEFAULT="Submit">
<CFPARAM NAME="ATTRIBUTES.buttontext2" DEFAULT="Wait!">

<!---This is a unique ID that will be applied to function names and variables.  This allows multipule instances of the same
	function --->
<CFSET ID = RandRange(1,99999999)>
<CFOUTPUT>

<!-------------------------------------------------------------
se houver um attributo onClick,
gera um botão comum que chama o método definido.

Caso contrário, procede exatamente como na versão 1.0
--------------------------------------------------------------->

<cfif isdefined("#attributes.onClick#")>
	<script language="javascript">
		function SafeSubmit#ID#(obj) {
			if(obj.value == "#ATTRIBUTES.ButtonText1#") {#attributes.onClick#};  // If the value of the button is submit, submit the form.
			obj.value = "#ATTRIBUTES.buttonText2#"; // This changes to button Label
		}
	</script>

<cfelse>
	<script language="javascript">
		function SafeSubmit#ID#(obj) {
			if(obj.value == "#ATTRIBUTES.ButtonText1#") obj.form.submit();  // If the value of the button is submit, submit the form.
			obj.value = "#ATTRIBUTES.buttonText2#"; // This changes to button Label
		}
	</script>
</cfif>

	<input type="button"
       name="Submit#ID#"
       value="#ATTRIBUTES.ButtonText1#"
       onClick="SafeSubmit#ID#(this)"
       <cfif isdefined("ATTRIBUTES.class")> class="#ATTRIBUTES.class#"</cfif>
       <cfif isdefined("ATTRIBUTES.disabled")> DISABLED</cfif>
       >




</cFOUTPUT>
<CFSETTING ENABLECFOUTPUTONLY="No">


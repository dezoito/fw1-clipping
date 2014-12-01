<!---

	CUSTOM TAG: CF_NoTags v1.1

		Usage:
		  <CF_NoTags
		  	input="SomeTextVariable">

		Output variable: #stipped_text#

	This strips all tags (HTML and CFML) from whatever text is passed to
	it -- great for an application where visitors post text to your site
	(like a forum or guestbook), but you don't want to risk an
	inappropriate image tag or layout-wrecking table tags.  Simply pass
	the text you would like to strip into the tag via the "input"
	attribute, and the tag will return the #stripped_text# variable.

	Author: Dane Pescaia (dane@ga-sports.com)
	Date: 1/4/2000

	Disclaimer: I, in no way, shape, or form, guarantee this tag.  Use it at
	your own risk.  This tag may be used by anyone for any purpose, all or in
	part, with or without this header.  Have a nice day!

--->

<cfif ParameterExists(attributes.input) IS "No">
	<b>Error! &lt;CF_NoTags&gt; requires the &quot;input&quot; attribute.</b>
	<cfabort>
<cfelseif attributes.input IS "">
	<cfset caller.stripped_text = "">
	<cfexit>
</cfif>

<cfset text = attributes.input>
<cfset otag_pos = Find("<", text)>

<cfloop condition="#otag_pos# IS NOT 0">
	<cfset ctag_pos = Find(">", text)>
	<cfset input_len = Len(text)>

	<cfloop condition="#ctag_pos# LT #otag_pos# AND #ctag_pos# IS NOT 0">
		<cfset text = RemoveChars(text, ctag_pos, 1)>
		<cfset ctag_pos = Find(">", text)>
	</cfloop>

	<cfif otag_pos IS 1>
		<cfset precut = "">
	<cfelse>
		<cfset precut = Left(text, Evaluate(otag_pos - 1))>
	</cfif>

	<cfif ctag_pos IS 0>
		<cfset ctag_pos = otag_pos>
	</cfif>

	<cfset postcut = Mid(text, Evaluate(ctag_pos + 1), Evaluate(input_len - ctag_pos))>
	<cfset text = precut & postcut>
	<cfset otag_pos = Find("<", text)>
</cfloop>

<cfset caller.stripped_text = text>

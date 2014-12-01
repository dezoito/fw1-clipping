<CFPARAM NAME="CALLER.CF_PAGES_COUNT" default="1">
<CFSET CALLER.CF_PAGES_COUNT = CALLER.CF_PAGES_COUNT + 1 >
<CFIF ISDEFINED("CALLER.CURRENTPAGE")>
	<CFSET ATTRIBUTES.CURRENTPAGE = CALLER.CURRENTPAGE>
<CFELSE>
	<CFPARAM NAME="ATTRIBUTES.CURRENTPAGE" DEFAULT="1">
</CFIF>
<CFPARAM NAME="ATTRIBUTES.TOTALRECORDCOUNT" DEFAULT="25">
<CFPARAM NAME="ATTRIBUTES.PAGESTEP" DEFAULT="5">
<CFPARAM NAME="ATTRIBUTES.PAGETORELOAD" DEFAULT="#CALLER.CGI.SCRIPT_NAME#">
<CFPARAM NAME="ATTRIBUTES.URL_PARAMETERS" DEFAULT="#CALLER.CGI.QUERY_STRING#">
<CFPARAM NAME="ATTRIBUTES.IMGDIR" DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.ADDFORMFIELDS" DEFAULT="YES">
<CFPARAM NAME="ATTRIBUTES.ADDURLPARAMS" DEFAULT="YES">
<CFPARAM NAME="ATTRIBUTES.IMAGES" DEFAULT="YES">

<!--- Add form fields if there are any --->
<CFSET FORMFIELDSTOADD = "">
<CFIF ATTRIBUTES.ADDFORMFIELDS IS "yes">
	<CFIF ISDEFINED("caller.form.FIELDNAMES")>
		<CFLOOP LIST="#caller.form.FIELDNAMES#" INDEX="frmField">
			<CFIF NOT FRMFIELD CONTAINS ".x" AND NOT FRMFIELD CONTAINS ".y" AND FRMFIELD IS NOT "currentpage" >
				<CFSET FORMFIELDSTOADD = FORMFIELDSTOADD & "<input type='hidden' name='" & FRMFIELD & "' value='"&EVALUATE("caller.form."&FRMFIELD)&"'>">
			</CFIF>
		</CFLOOP>
	</CFIF>
</CFIF>

<!--- add url parameters if there are any --->
<CFIF ATTRIBUTES.ADDURLPARAMS IS "YES">
	<CFIF LEN(TRIM(ATTRIBUTES.URL_PARAMETERS))>

		<CFSET ATTRIBUTES.PAGETORELOAD = ATTRIBUTES.PAGETORELOAD & '?' & ATTRIBUTES.URL_PARAMETERS >

		<CFSET X =  FINDNOCASE("CurrentPage=",ATTRIBUTES.PAGETORELOAD) - 2>
		<CFIF X GT -2>
			<CFSET ATTRIBUTES.PAGETORELOAD = LEFT(ATTRIBUTES.PAGETORELOAD,X) >
		</CFIF>

	</CFIF>
</CFIF>

<!-- choose what sign to add to the url --->
<CFIF FINDNOCASE("?",ATTRIBUTES.PAGETORELOAD)>
<CFSET SIGN="&">
<CFELSE>
<CFSET SIGN="?">
</CFIF>

<!-------------------------------------------------------->
<!--- calculate the number of pages in the recordcount --->
<!-------------------------------------------------------->
<CFIF ATTRIBUTES.PAGESTEP>
	<CFSET NUMBEROFPAGES = CEILING(ATTRIBUTES.TOTALRECORDCOUNT/ATTRIBUTES.PAGESTEP) >
<CFELSE>
	<CFABORT SHOWERROR="PageStep cannot be 0">
</CFIF>

<CFIF ATTRIBUTES.CURRENTPAGE GT NUMBEROFPAGES>
	<CFSET ATTRIBUTES.CURRENTPAGE = NUMBEROFPAGES>
</CFIF>

<CFIF ATTRIBUTES.CURRENTPAGE LT 1>
	<CFSET ATTRIBUTES.CURRENTPAGE = 1>
</CFIF>

<CFSET PREVIOUSPAGE=IIF((ATTRIBUTES.CURRENTPAGE -1 ),(ATTRIBUTES.CURRENTPAGE-1),1)>
<CFSET NEXTPAGE=IIF((ATTRIBUTES.CURRENTPAGE + 1) GT NUMBEROFPAGES,NUMBEROFPAGES,(ATTRIBUTES.CURRENTPAGE+1))>

<!-------------------------->
<!--- end of calculation --->
<!-------------------------->

<CFSET CENTERINGSTRING = IIF(LEN(ATTRIBUTES.CURRENTPAGE) GT 2,DE("  "),DE("   "))>
<CFOUTPUT>

<script language="javascript">
function GoToPage#CALLER.CF_PAGES_COUNT#(PageNumber){
document.frmCurrentPage#CALLER.CF_PAGES_COUNT#.CurrentPage.value = '  ' +PageNumber + '  ';
document.frmCurrentPage#CALLER.CF_PAGES_COUNT#.submit()
}
</script>


<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0"><TR>
<FORM ACTION="#attributes.pageToReload#" METHOD="post" NAME="frmFirstPage#CALLER.CF_PAGES_COUNT#" >
<CFIF NOT ATTRIBUTES.IMAGES>
<TD><INPUT TYPE="BUTTON" VALUE="&nbsp;&lt;&lt;&nbsp;" onclick="GoToPage#CALLER.CF_PAGES_COUNT#(1)" ></TD>
<CFELSE>
<TD><A HREF="javascript:GoToPage#CALLER.CF_PAGES_COUNT#(1);" onMouseOut="document.imgFirstPage#CALLER.CF_PAGES_COUNT#.src='#attributes.ImgDir#First_off.gif'" onMouseOver="document.imgFirstPage#CALLER.CF_PAGES_COUNT#.src='#attributes.ImgDir#First_on.gif'"><IMG SRC="#attributes.ImgDir#First_off.gif" WIDTH=17 HEIGHT=17 ALT="" BORDER="0" NAME="imgFirstPage#CALLER.CF_PAGES_COUNT#" ></A></TD>
</cfif>
</FORM>

<FORM ACTION="#attributes.pageToReload#" METHOD="post" NAME="frmPreviousPage#CALLER.CF_PAGES_COUNT#">
<CFIF NOT ATTRIBUTES.IMAGES>
<TD><INPUT TYPE="BUTTON" VALUE="&nbsp;&lt;&nbsp;" onclick="GoToPage#CALLER.CF_PAGES_COUNT#(#PreviousPage#)" ></TD>
<CFELSE>
<TD><A HREF="javascript:GoToPage#CALLER.CF_PAGES_COUNT#(#PreviousPage#);" onMouseOut="document.imgPreviousPage#CALLER.CF_PAGES_COUNT#.src='#attributes.ImgDir#Previous_off.gif'" onMouseOver="document.imgPreviousPage#CALLER.CF_PAGES_COUNT#.src='#attributes.ImgDir#Previous_on.gif'"><IMG  SRC="#attributes.ImgDir#Previous_off.gif" WIDTH=17 HEIGHT=17 ALT="" BORDER="0" NAME="imgPreviousPage#CALLER.CF_PAGES_COUNT#"></A></TD>
</CFIF>
</FORM>

<FORM ACTION="#attributes.pageToReload#" METHOD="post" name="frmCurrentPage#CALLER.CF_PAGES_COUNT#">
<TD><INPUT TYPE="text" NAME="CurrentPage" VALUE="#centeringstring##trim(attributes.CurrentPage)##centeringstring#" SIZE="5">#formfieldstoadd#</TD>
</FORM>

<FORM ACTION="#attributes.pageToReload#" METHOD="post" NAME="frmNextPage#CALLER.CF_PAGES_COUNT#">
<CFIF NOT ATTRIBUTES.IMAGES>
<TD><INPUT TYPE="BUTTON" VALUE="&nbsp;&gt;&nbsp;" onclick="GoToPage#CALLER.CF_PAGES_COUNT#(#nextPage#)" ></TD>
<CFELSE>
<TD><A HREF="javascript:GoToPage#CALLER.CF_PAGES_COUNT#(#nextPage#);" onMouseOut="document.imgNextPage#CALLER.CF_PAGES_COUNT#.src='#attributes.ImgDir#Next_off.gif'" onMouseOver="document.imgNextPage#CALLER.CF_PAGES_COUNT#.src='#attributes.ImgDir#Next_on.gif'"><IMG SRC="#attributes.ImgDir#Next_off.gif" WIDTH=17 HEIGHT=17 ALT="" BORDER="0" NAME="imgNextPage#CALLER.CF_PAGES_COUNT#"></A></TD>
</CFIF>
</FORM>

<FORM ACTION="#attributes.pageToReload#" METHOD="post" NAME="frmLastPage#CALLER.CF_PAGES_COUNT#">
<CFIF NOT ATTRIBUTES.IMAGES>
<TD><INPUT TYPE="BUTTON" VALUE="&nbsp;&gt;&gt;&nbsp;" onclick="GoToPage#CALLER.CF_PAGES_COUNT#(#NumberofPages#)" ></TD>
<CFELSE>
<TD><A HREF="javascript:GoToPage#CALLER.CF_PAGES_COUNT#(#NumberofPages#);" onMouseOut="document.imgLastPage#CALLER.CF_PAGES_COUNT#.src='#attributes.ImgDir#Last_off.gif'" onMouseOver="document.imgLastPage#CALLER.CF_PAGES_COUNT#.src='#attributes.ImgDir#Last_on.gif'"><IMG SRC="#attributes.ImgDir#Last_off.gif" WIDTH=17 HEIGHT=17 ALT="" BORDER="0" NAME="imgLastPage#CALLER.CF_PAGES_COUNT#"></A></TD>
</CFIF>
</FORM>

</TR>
</TABLE>

<CFSET CALLER.NUMBEROFPAGES = NUMBEROFPAGES>
<CFSET CALLER.STARTROW = IIF((ATTRIBUTES.CURRENTPAGE - 1) * ATTRIBUTES.PAGESTEP,(ATTRIBUTES.CURRENTPAGE -1) * ATTRIBUTES.PAGESTEP+1,1) >
<CFSET CALLER.LASTROW = IIF((CALLER.STARTROW + ATTRIBUTES.PAGESTEP -1) GT ATTRIBUTES.TOTALRECORDCOUNT,ATTRIBUTES.TOTALRECORDCOUNT, (CALLER.STARTROW + ATTRIBUTES.PAGESTEP -1)) >

</CFOUTPUT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>CF_PAGES</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH="100%"><TR><TD BGCOLOR="dddddd">
<FONT FACE="Arial,Helvetica" SIZE="5"><I><B>&nbsp;&nbsp;&lt;CF_PAGES&gt;</B></I></FONT>
</TD></TR></TABLE>
<FORM NAME="MyForm">
<TABLE><TR><TD>
<CF_PAGES TOTALRECORDCOUNT="25" IMGDIR="images/">  &lt;CF_PAGES TOTALRECORDCOUNT="25"&gt;<br>
<CF_PAGES TOTALRECORDCOUNT="25" IMAGES="NO" IMGDIR="images/">  &lt;CF_PAGES TOTALRECORDCOUNT="25" IMAGES="NO"&gt;
</TD>
<TD>
Divides recordset into pages .<BR>
<b>Autoamtically adding Form and URL variables</b><BR>
The user can either click the arrows or put in a number

</TD></TR></TABLE>
</FORM>

<TABLE WIDTH="100%"><TR><TD BGCOLOR="dddddd">
<FONT FACE="Arial,Helvetica" SIZE="3"><I><B>&nbsp;&nbsp;USAGE</B></I></FONT>
</TD></TR></TABLE>
<FONT FACE="Arial,Helvetica">
&lt;CF_PAGES<BR>
TOTALRECORDCOUNT="25"<BR>
PAGESTEP="5"&gt;</TD></TR></FONT>
<BR><BR>
<TABLE WIDTH="100%"><TR><TD BGCOLOR="dddddd">
<FONT FACE="Arial,Helvetica" SIZE="3"><I><B>&nbsp;&nbsp;ATTRIBUTES</B></I></FONT>
</TD></TR></TABLE>
<BR>
<TABLE BORDER="1" CELLSPACING="1" CELLPADDING="1">
<TR>
	<TD BGCOLOR="cccccc">ATTRIBUTE</TD>
	<TD BGCOLOR="cccccc">DESCRIPTION</TD>
</TR>
<TR>
	<TD>TOTALRECORDCOUNT</TD>
	<TD>[REQUIRED] Number of records in query / recordset</TD>
</TR>
<TR>
	<TD>PAGESTEP</TD>
	<TD>[OPTIONAL] Number of records in each page ( default = 5 )</TD>
</TR>
<TR>
	<TD>IMGDIR</TD>
	<TD>[OPTIONAL] Relative directory including slash to images of forward and backward arrows </TD>
</TR>

<TR>
	<TD>ADDFORMFIELDS</TD>
	<TD>[OPTIONAL] Automatically Add submitted form fields when moving between pages ( default = yes )</TD>
</TR>

<TR>
	<TD>ADDURLPARAMS</TD>
	<TD>[OPTIONAL] Automatically Add url parameters when moving between pages( default = yes )</TD
</TR>
<TR>
	<TD>IMAGES</TD>
	<TD>[OPTIONAL] Use images instead of form buttons ( default = yes )</TD>
</TR>


</TABLE>
<BR>
<TABLE WIDTH="100%"><TR><TD BGCOLOR="dddddd">
<FONT FACE="Arial,Helvetica" SIZE="3"><I><B>&nbsp;&nbsp;RETURN VARIABLES</B></I></FONT>
</TD></TR></TABLE>
NUMBEROFPAGES = Total number of pages <br>
STARTROW = First row on this page <br>
LASTROW = Last row on this page <br>

<TABLE WIDTH="100%"><TR><TD BGCOLOR="dddddd">
<FONT FACE="Arial,Helvetica" SIZE="3"><I><B>&nbsp;&nbsp;COMPATIBILITY</B></I></FONT>
</TD></TR></TABLE>
Netscape 3.* , 4.*<BR>
Explorer 4.* 3.* <BR>

<table width="100%"><tr><td bgcolor="dddddd">
<font face="Arial,Helvetica" size="3"><i><b>&nbsp;&nbsp;INSTALLATION</b></i></font>
</td></tr></table>
Place the file <b>pages.cfm</b> in your CFUSION\CUSTOM TAGS directory<br>

<table width="100%"><tr><td bgcolor="dddddd">
<font face="Arial,Helvetica" size="3"><i><b>&nbsp;&nbsp;VTM INSTALLATION</b></i></font>
</td></tr></table>
Copy <b>cf_pages.vtm</b> to your <i>\Program Files\Allaire\ColdFusion Studio4\Extensions\TagDefs\Custom</i> directory</a>
<BR>
<TABLE WIDTH="100%"><TR><TD BGCOLOR="dddddd">
<FONT FACE="Arial,Helvetica" SIZE="3"><I><B>&nbsp;&nbsp;BUGS / FEATURE REQUESTS</B></I></FONT>
</TD></TR></TABLE>
<A HREF="mailto:shlomyg@icesinc.com">shlomyg@icesinc.com</A>
<BR>
<TABLE WIDTH="100%"><TR><TD BGCOLOR="dddddd">
<FONT FACE="Arial,Helvetica" SIZE="3"><I><B>&nbsp;&nbsp;GRAPHIX</B></I></FONT>
</TD></TR></TABLE>
Nir Gavish (<a href="tantalum@melig.co.il">tantalum</a>)<br>
<TABLE WIDTH="100%"><TR><TD BGCOLOR="dddddd">
<FONT FACE="Arial,Helvetica" SIZE="3"><I><B>&nbsp;&nbsp;SIMILAR TAGS</B></I></FONT>
</TD></TR></TABLE>

<A HREF="http://www1.allaire.com/developer/gallery/index.cfm?ObjectID=7059">&lt;CF_NextRecords&gt;</a>
<A HREF="http://www.allaire.com/developer/gallery/index.cfm?Objectid=11100">&lt;CF_Pagethru&gt;</A>
</BODY>
</HTML>

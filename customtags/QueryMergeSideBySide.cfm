<!--- --- --- --- --- --- --- --- --- --- --- --- --- 
editada por FCR em 03/01/2006
de forma a não utilizar cfx_querycolumns
 --- --- --- --- --- --- --- --- --- --- --- --- --->



<!--- REMOVE FIRST AND LAST LINES IF NOT USING CF3.1 OR LATER --->
<CFSETTING ENABLECFOUTPUTONLY="YES">

<!--- TAG PARAMETERS --->
<CFPARAM NAME="Attributes.Query1">
<CFPARAM NAME="Attributes.Query2">
<CFPARAM NAME="Attributes.Q_Name">

<!--- ESTABLISH LOCAL COPIES OF QUERIES --->
<CFSET Query1 = Evaluate("Caller.#Attributes.Query1#")>
<CFSET Query2 = Evaluate("Caller.#Attributes.Query2#")>

<!--- GET COLUMN NAMES FROM Query1 --->
<!--- --- --- --- --- --- --- --- --- --- --- --- --- 
<CFX_QueryColumns
  ACTION="Get"
	QUERY="Query1"
	VARIABLE="Query1_Columns">
 --- --- --- --- --- --- --- --- --- --- --- --- --->
 <cfset Query1_Columns = Query1.columnlist>

<!--- GET COLUMN NAMES FROM Query2 --->
<!--- --- --- --- --- --- --- --- --- --- --- --- --- 
<CFX_QueryColumns
  ACTION="Get"
	QUERY="Query2"
	VARIABLE="Query2_Columns">
 --- --- --- --- --- --- --- --- --- --- --- --- --->
 <cfset Query2_Columns = Query2.columnlist>
 
<!--- MAKE NEW COLUMN LIST, ELIMINATING ANY COLUMNS IN COMMON --->
<CFSET NewColumns = Query1_Columns>
<CFLOOP LIST="#Query2_Columns#" INDEX="This">
  <CFIF NOT ListFindNoCase(NewColumns, This)>
	  <CFSET NewColumns = ListAppend(NewColumns, This)>
	</CFIF>
</CFLOOP>

<!--- CREATE NEW QUERY --->
<CFSET NewQuery = QueryNew(NewColumns)>


<!--- ADD APPROPRIATE NUMBER OF ROWS TO THE NEW QUERY, THEN START LOOPING --->
<CFIF QueryAddRow(NewQuery, Query1.RecordCount)>

  <!--- ADD DATA FROM THE FIRST QUERY --->	
	<CFLOOP FROM="1" TO="#Query1.RecordCount#" INDEX="RowNo">
	  <CFLOOP FROM="1" TO="#ListLen(Query1_Columns)#" INDEX="ColNo">
		  <CFSET ThisCol = ListGetAt(Query1_Columns, ColNo)>
	    <CFSET Data = Evaluate("Query1.#ThisCol#[#RowNo#]")>
			<CFSET Temp = QuerySetCell(NewQuery, ThisCol, Data, RowNo)>
	  </CFLOOP>
	</CFLOOP>
	
	<!--- ADD DATA FROM THE SECOND QUERY --->
	<CFLOOP FROM="1" TO="#Query2.RecordCount#" INDEX="RowNo">
	  <CFLOOP FROM="1" TO="#ListLen(Query2_Columns)#" INDEX="ColNo">
		  <CFSET ThisCol = ListGetAt(Query2_Columns, ColNo)>
	    <CFSET Data = Evaluate("Query2.#ThisCol#[#RowNo#]")>
			<CFSET Temp = QuerySetCell(NewQuery, ThisCol, Data, RowNo)>
	  </CFLOOP>
	</CFLOOP>

</CFIF>

<!--- TA-DA! PASS COMPLETED QUERY BACK TO CALLING TEMPLATE --->
<CFSET "Caller.#Attributes.Q_Name#" = NewQuery>

<!--- REMOVE FIRST AND LAST LINES IF NOT USING CF3.1 OR LATER --->
<CFSETTING ENABLECFOUTPUTONLY="NO">
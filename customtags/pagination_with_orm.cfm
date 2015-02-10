<cfsetting enablecfoutputonly="yes">
<!--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

	TEMPLATE: pagination_with_orm.cfm

	Based on Gist published @:
	see https://gist.github.com/steinbring/4315198

	Creates a link of "pages", based on a queryset,
	the number of records per page and the number of page links to be shown

	Uses Bootstrap CSS classes to display links.

	IMPORTANT: the actual pagination of records is handled by the ORM
	(MaxResults and Offset arguments)

	ATTRIBUTES:
	intNumberOfTotalItems:	QuerySet's total recordCount

	intPagesToLinkTo:		How many links to pages you want displayed

	intItemsPerPage:		How many records are displayed in each page
							(Make sure this value is consistent with what's used
							in the ORM query)


	EXAMPLE:

	<cf_pagination_with_orm
		intNumberOfTotalItems=someQuery.recordCount
		intPagesToLinkTo="5"
		intItemsPerPage="10">

		..display records here

	</cf_pagination_with_orm>




 --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --->
<!---		We must have an end tag		 --->
<cfif not thistag.hasendtag>
	<cfset thistag.generatedcontent="">
	<cfoutput>You must have an end tag</cfoutput>
	<cfabort>
</cfif>


<!---    init local variables     --->
<cfscript>
	intNumberOfTotalItems = attributes.intNumberOfTotalItems;
	intPagesToLinkTo = attributes.intPagesToLinkTo;
	intItemsPerPage = attributes.intItemsPerPage;
	if( isdefined("caller.rc.page")){
		intCurrentPage = val(caller.rc.page);
	} else {
		intCurrentPage = 1;
	}
	// writeOutput(intCurrentPage);
</cfscript>

<cfswitch expression="#thistag.executionmode#">

	<!---		starting		 --->
	<cfcase value="start">


		<!--- Find the closest numbers to intCurrentPage that is divisible by intPagesToLinkTo --->
		<cfset intMaxLinkToShow = ceiling(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo>
		<cfset intMinLinkToShow = (int(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo)+1>
		<!--- Is intMaxLinkToShow equal to the unadjusted intMinLinkToShow value? If so, reset intMinLinkToShow to be where it should be. --->
		<cfif intMaxLinkToShow eq (int(variables.intCurrentPage/intPagesToLinkTo)*intPagesToLinkTo)>
		  <cfset intMinLinkToShow = intMaxLinkToShow - (intPagesToLinkTo - 1)>
		</cfif>
		<!--- Is intMaxLinkToShow bigger than we need to shouw intNumberOfTotalItems?  If so, reset it. Use ceiling() to round it up. --->
		<cfif intMaxLinkToShow gt intNumberOfTotalItems / intItemsPerPage>
		  <cfset intMaxLinkToShow = ceiling(intNumberOfTotalItems / intItemsPerPage)>
		</cfif>
		<!--- Should I show the back button? --->
		<cfif intMaxLinkToShow - intPagesToLinkTo LTE 0>
		  <cfset boolShowBackButton = 0>
		<cfelse>
		  <cfset boolShowBackButton = 1>
		</cfif>
		<!--- Should I show the forward button? --->
		<cfif ceiling(intNumberOfTotalItems / intItemsPerPage) lte intMaxLinkToShow>
		  <cfset boolShowForwardButton = 0>
		<cfelse>
		  <cfset boolShowForwardButton = 1>
		</cfif>
		<!--- What items should I show on the page? --->
		<cfset intMinItemsToShow = (intItemsPerPage * (intCurrentPage - 1))+ 1>
		<cfset intMaxItemsToShow = intMinItemsToShow + intItemsPerPage - 1>
		<!--- Have you reached the maximum number of items to show? --->
		<cfif intMaxItemsToShow gt intNumberOfTotalItems>
		  <cfset intMaxItemsToShow = intNumberOfTotalItems>
		</cfif>

	</cfcase><!---    /start     --->


	<!---	ending		 --->
	<!---   print page navigation     --->
	<cfcase value="end">
		<cfoutput>
			<!--- Display the pagination buttons using bootstrap CSS classes --->
			<ul class="pagination">

				<!--- Show a "back button" that link to the smallest number page - 1 --->
				<cfif variables.boolShowBackButton>
					<li><a href="?page=<cfoutput>#intMinLinkToShow-1#</cfoutput>">&lt;</a></li>
				</cfif>

			  <!--- Loop through and create links to intPagesToLinkTo pages --->
			  <cfloop from="#variables.intMinLinkToShow#" to="#variables.intMaxLinkToShow#" index="i">

		        <cfif intCurrentPage eq i>
		          <li class="active"><a href="##">#i#</a></li>
		        <cfelse>
		          <li><a href="?page=#i#">#i#</a></li>
		        </cfif>

			  </cfloop>

			  <!--- Show a "forward button" that links to the largest number page + 1 --->
			  <cfif variables.boolShowForwardButton>
			      <li><a href="?page=<cfoutput>#intMaxLinkToShow+1#</cfoutput>">&gt;</a></li>
			  </cfif>

			</ul>

		</cfoutput>
	</cfcase><!---    /end     --->
</cfswitch>


<cfsetting enablecfoutputonly="no">

<!-- home::views/default -->
<cfoutput>
  | <a href="#buildURL('clipping.form')#">Add an Article</a>
  | <a href="javascript: ajaxClippingForm('#buildURL('clipping.ajaxForm')#');">Add an Article (Ajax)</a>
  |
  <br/>
</cfoutput>
<br/>
<cfoutput>
    <cfif rc.qry_clipping.count gt 0>


        <cfloop index="Clipping" array="#rc.qry_clipping.data#">
            <p>
            <b><a href="#buildURL(action = 'clipping.form', queryString = 'clipping_id=' & Clipping.getClipping_Id())#">#Clipping.getClipping_titulo()#</a></b>
              | <a href="javascript: ajaxClippingForm('#buildURL('clipping.ajaxForm')#',#Clipping.getClipping_Id()#);">Edit (Ajax)</a>
              | <a href="javascript: ajaxViewSummary('#buildURL('clipping.summary')#',#Clipping.getClipping_Id()#);">View Summary (Ajax)</a>
              |
            <br/>
            <font class="text-muted small">#dateFormat(Clipping.getCreated(), "mmmm d, yyyy")# at #timeFormat(Clipping.getCreated(), "hh:mm")#</font>
            <br/>

            <!---    shows a short preview of text (HTML tags removed)     --->
            #application.UDFs.abrevia_string(application.UDFs.stripHTML(Clipping.getClipping_texto()), 200)#
            <br/><br/>

            </p>
        </cfloop>

        <!---    pagination stuff     --->
        <!---    see https://gist.github.com/steinbring/4315198     --->
        <!--- How many pages should you link to at any one time? --->
        <cfset intPagesToLinkTo = 5>
        <!--- How many items are you displaying per page? --->
        <cfset intItemsPerPage = application.recordsPerPage>

        <!--- How many items do you need to display, across all pages. --->
        <cfset intNumberOfTotalItems = rc.qry_clipping.count>
        <!--- What is the current page you are on? --->
        <cfif isdefined("url.page")>
          <cfset intCurrentPage = val(url.page)>
        <cfelse>
          <cfset intCurrentPage = 1>
        </cfif>

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



        <!--- Display the pagination buttons using bootstrap CSS classes --->
        <ul class="pagination">
          <!--- Show a "back button" that link to the smallest number page - 1 --->
          <cfif variables.boolShowBackButton>
              <li><a href="?page=<cfoutput>#intMinLinkToShow-1#</cfoutput>">&lt;</a></li>
          </cfif>

          <!--- Loop through and create links to intPagesToLinkTo pages --->
          <cfloop from="#variables.intMinLinkToShow#" to="#variables.intMaxLinkToShow#" index="i">

              <cfoutput>
                <cfif intCurrentPage eq i>
                  <li class="active"><a href="##">#i#</a></li>
                <cfelse>
                  <li><a href="?page=#i#">#i#</a></li>
                </cfif>
              </cfoutput>

          </cfloop>

          <!--- Show a "forward button" that links to the largest number page + 1 --->
          <cfif variables.boolShowForwardButton>
              <li><a href="?page=<cfoutput>#intMaxLinkToShow+1#</cfoutput>">&gt;</a></li>
          </cfif>

        </ul>

    <cfelse><!---    nothing to display     --->

        <p>
            There are no articles currently.
        </p>
    </cfif>
</cfoutput>



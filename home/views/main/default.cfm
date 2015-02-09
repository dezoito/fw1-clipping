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

      <!---    pagination stuff     --->
      <!---    see Ray Camdem's work at: http://www.raymondcamden.com/2012/06/22/ColdFusion-and-Pagination-Six-Years-Later     --->
      <cfparam name="rc.start" default="1">
      <cfif not isNumeric(rc.start)
            or rc.start lt 1
            or rc.start gt rc.qry_clipping.count
            or round(rc.start) neq rc.start>
          <cfset rc.start = 1>
      </cfif>

      <cfset totalPages = ceiling(rc.qry_clipping.count / application.recordsPerPage)>
      <cfset thisPage = ceiling(rc.start / application.recordsPerPage)>

      You are on page #thisPage# of #totalPages# (#rc.qry_clipping.count# records).
      <p>


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

        <!---    end pagination     --->
        <p>
        [
        <cfif rc.start gt 1>
            <cfset link = cgi.script_name & "?start=" & (rc.start - application.recordsPerPage)>
            <cfoutput><a href="#link#">Previous Page</a></cfoutput>
        <cfelse>
            Previous Page
        </cfif>
        /
        <cfif (rc.start + application.recordsPerPage - 1) lt rc.qry_clipping.count>
            <cfset link = cgi.script_name & "?start=" & (rc.start + application.recordsPerPage)>
            <cfoutput><a href="#link#">Next Page</a></cfoutput>
        <cfelse>
            Next Page
        </cfif>
        ]
        </p>

<!-------------------------------------------------------------
        <ul class="pagination">

          <cfif thisPage gt 1>
            <li><a href="#cgi.script_name#">First page</a></li>
            <li><a href="##">&laquo;</a></li>
          </cfif>

          <li><a href="##">1</a></li>
          <li><a href="##">2</a></li>
          <li><a href="##">3</a></li>
          <li><a href="##">4</a></li>
          <li><a href="##">5</a></li>

          <cfif thispage lt totalpages>
            <li><a href="##">&raquo;</a></li>
            <li><a href="##">Last page</a></li>
          </cfif>
        </ul>
--------------------------------------------------------------->

    <cfelse>
        <p>
            There are no articles currently.
        </p>
    </cfif>
</cfoutput>

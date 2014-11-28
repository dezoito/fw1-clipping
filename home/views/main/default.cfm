<!-- home::views/default -->
<cfoutput>
  | <a href="#buildURL('clipping.form')#">Add an Article</a>
  |<br/>
</cfoutput>
<br/>
<cfoutput>
    <cfif rc.qry_clipping.count gt 0>
        <cfloop index="cl" array="#rc.qry_clipping.data#">
            <p>
            <!---    <a href="?#framework.action#=clipping.view&clipping_id=#cl.getClipping_Id()#">#cl.getClipping_titulo()#</a>     --->
            <b><a href="#buildURL(action = 'clipping.form', queryString = 'clipping_id=' & cl.getClipping_Id())#">#cl.getClipping_titulo()#</a></b>
            <br/>
                #application.stripHTML(cl.getClipping_texto())#
            <br/>

                #dateFormat(cl.getCreated(), "mmmm d, yyyy")# at #timeFormat(cl.getCreated(), "h:mm tt")#
            </p>
        </cfloop>
    <cfelse>
        <p>
            There are no articles currently.
        </p>
    </cfif>
</cfoutput>

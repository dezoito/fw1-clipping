<!-- home::views/default -->
<cfoutput>
  | <a href="#buildURL('clipping.form')#">Add an Article</a>
  |<br/>
</cfoutput>
<br/>
<cfoutput>
    <cfif rc.qry_clipping.count gt 0>
        <cfloop index="Clipping" array="#rc.qry_clipping.data#">
            <p>
            <b><a href="#buildURL(action = 'clipping.form', queryString = 'clipping_id=' & Clipping.getClipping_Id())#">#application.prepara_string(Clipping.getClipping_titulo())#</a></b>
            <br/>
            <font class="text-muted">#dateFormat(Clipping.getCreated(), "mmmm d, yyyy")# at #timeFormat(Clipping.getCreated(), "hh:mm")#</font>
            <br/>
            #application.abrevia_string(application.stripHTML(Clipping.getClipping_texto()), 200)#



            </p>
        </cfloop>
    <cfelse>
        <p>
            There are no articles currently.
        </p>
    </cfif>
</cfoutput>

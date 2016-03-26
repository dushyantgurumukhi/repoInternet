<cfcomponent displayname="Application"  output="true"  hint="Handle the application.">
	<!--- <cffunction
        name="OnRequestEnd"
        access="public"
        returntype="void"
        output="true"
        hint="Fires after the page processing is complete.">
		
        <cfif not isDefined("session.userid")>
			<cflocation url="/index.cfm">
		</cfif>
    </cffunction> --->
	
	 <cffunction
        name="onSessionEnd"
        access="public"
        returntype="void"
        output="false"
        hint="I tear down the session.">

        <!--- Define arguments. --->
        <cfargument
            name="sessionScope"
            type="any"
            required="true"
            hint="I am the session scope being torn down."
            />

        <cfargument
            name="applicationScope"
            type="any"
            required="true"
            hint="I am the application scope."
            />

        <!--- Log the session length. --->
        <cflocation url="/index.cfm">
		</cffunction>
        <!--- Return out. --->
        <!--- <cfabort> --->

	
</cfcomponent>
	
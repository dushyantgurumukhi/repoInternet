<cfset loginFlag = "">
<cfif isDefined("form.user_id") and isDefined("form.user_password")>
	<cfobject name="objLogin" component="com.loginUser">
	<cfset loginFlag = objLogin.getValidUser(userID=form.user_id,password=form.user_password)>
	
	<cfif loginFlag eq "valid">
		<cflocation url="welcome.cfm" addtoken="true">
	<cfelse>
		<cflocation url="../index.cfm?loginFlag=invalid" addtoken="false">	
	</cfif>
</cfif>


<cfcomponent>
	<cffunction name="getValidUser" access="remote" returnformat="plain" returntype="any">
		<cfargument name="userID" required="true">
		<cfargument name="password" required="true">
		<cfparam name="validUserFlag" default="invalid">
		<cfif (isDefined("arguments.userID") and isDefined("arguments.password")) and (arguments.userID neq "" and arguments.password neq "")>
			<cfquery name="getValidUserQuery" datasource="repointernet">
				select login_id,password,login_name,login_user_type from login_user where user_active = 'Y' and login_id = '#arguments.userID#' and password = '#arguments.password#'
			</cfquery>
			<cfif getValidUserQuery.recordcount gt 0>
				<cfset session.userid = getValidUserQuery.login_id>
				<cfset session.loginName = getValidUserQuery.login_name>
				<cfset session.loginType = getValidUserQuery.login_user_type>
				<cfset validUserFlag = "valid">
			</cfif>
		</cfif>
		<cfreturn validUserFlag>
	</cffunction>
	<cffunction name="getAdmiMenu" access="public" returntype="any">
		<cfargument name="userType" default="">
		<cfif isDefined("arguments.userType") and arguments.userType neq "">
			<cfquery name="getUserMenu" datasource="repointernet">
				select menu_name,menu_file_location,menu_image_location,menu_user_type,menu_id from admin_menu where menu_user_type like '%#arguments.userType#%' and menu_active = 'Y'
			</cfquery>
			<cfreturn getUserMenu>
		</cfif>
	</cffunction>
	
	<cffunction name="getSubMenu" returntype="any">
		<cfargument name="userType" default="">
		<cfargument name="parentMenuId" default="">
		<cfquery name="getMenu" datasource="repointernet">
			select sub_menu_name,sub_menu_file_location,sub_menu_image_location,sub_menu_user_type,parent_menu_id 
			from sub_menu_config 
			where sub_menu_user_type like '%#arguments.userType#%' and parent_menu_id = '#arguments.parentMenuId#' and menu_active = 'Y'
		</cfquery>
		<cfreturn getMenu>
	</cffunction>
	
	<cffunction name="getMenuBar" returntype="any">
		<cfargument name="foldername" default="">
		<cfset menuBar ="">
		<cfswitch expression="#foldername#">
			<cfcase value="customer">
				<cfset menuBar ="Customer Administration,../admin/customerAdmin.cfm">
			</cfcase>
		</cfswitch>
		<cfswitch expression="#foldername#">
			<cfcase value="collection">
				<cfset menuBar ="Collection Administration,../admin/collectionAdmin.cfm">
			</cfcase>
		</cfswitch>
		<cfreturn menuBar>
	</cffunction>
	
</cfcomponent>
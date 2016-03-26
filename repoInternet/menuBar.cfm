<cfsetting showdebugoutput="false">
<!--- <cfobject name="objFolder" component="com.loginUser">
<cfset folderName = listGetAt(CGI.script_name,1,"/")>
<cfset menuToShow = objFolder.getMenuBar(foldername=folderName)> --->
<cfoutput>
	<div class="panel-body menu-bar">
		<ul class="nav nav-pills pull-right">
		  <li role="presentation"><a href="../homepage/welcome.cfm">Home</a></li>
		  <!--- <cfif menuToShow neq "">
			<cfset menuName = listGetAt(menuToShow,1)>
			<cfset menuSourcePath = listGetAt(menuToShow,2)>
		  	<li role="presentation"><a href="#menuSourcePath#">#menuName#</a></li>		
		  </cfif> --->
		  <li role="presentation"><a href="../index.cfm">Logout</a></li>
		</ul>	
	</div>
	
</cfoutput>
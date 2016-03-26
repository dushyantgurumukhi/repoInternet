hello
<!DOCTYPE HTML>
<html>
<head>
	<title>|| Repo Internet ||</title>
	<meta charset="UTF-8" />
	<script src="../javascript/login.js"></script>
	<script src = "../javascript/jquery-1.12.0.min.js"></script>
	<script src = "../javascript/bootstrap.min.js"></script>
	<link href = "../css/bootstrap.min.css" rel = "stylesheet">
	<link href = "../css/repo.css" rel = "stylesheet">
	<style>
		tr.border_bottom td {
		  border-bottom:1pt solid black;
		}
	</style>
</head>
<body>
	<cfobject name="objLogin" component="com.loginUser">
	<cfoutput>
		<div class="container">
	        <div class="row centered-form">
	        	<cfinclude template="../menuBar.cfm">
	        	<div class="col-xs-12">
	        		<div class="panel panel-default">
	        			<div class="panel-heading">
				    		<h3 class="panel-title">Administration</h3>
			 			</div>
			 			<cfif (isDefined("session.userid") and session.userid neq "") and isDefined("session.logintype") and session.logintype neq "">
							<cfset parentMenuId = '6'>
							<cfset getAllMenu = objLogin.getAdmiMenu(userType=session.logintype)>
							<form  id="home_page">
								<table align="center" style="margin: 0px auto;" border="0" width="40%" cellspacing="100" cellpadding="100">
									<cfloop query="getAllMenu">
										<tr class="border_bottom"><td colspan="4">#getAllMenu.menu_name#</td></tr>
										<cfset getAllSubMenu = objLogin.getSubMenu(userType=session.logintype,parentMenuId=getAllMenu.menu_id)>
										<cfloop query="getAllSubMenu">
											<tr>
												<td width="5%"><img src="#getAllSubMenu.sub_menu_image_location#" alt="#getAllSubMenu.sub_menu_name#" title="#getAllSubMenu.sub_menu_name#" height="35" width="35"></td>
												<td width="35%"><a class="brand" href="#getAllSubMenu.sub_menu_file_location#">#getAllSubMenu.sub_menu_name#</a></td>
											</tr>
										</cfloop>
										<tr><td colspan="4"></td></tr>
									</cfloop>
									
								</table>
				    		</form>	
						<cfelse>
							<cfinclude template="../sessionLogout.cfm">	
						</cfif>
					</div>
				</div>			
			</div>
		</div>	
	</cfoutput>
</body>
<!--- <body>
<form class="form-horizontal" action="../welcome.cfm">
	<cfif (isDefined("session.userid") and session.userid neq "") and isDefined("session.logintype") and session.logintype neq "">
		<cfobject name="objLogin" component="com.loginUser">
		<cfset getAllMenu = objLogin.getAdmiMenu(userType=session.logintype)>
		<div class="bs-example">
			<cfoutput query="getAllMenu">
				<cfif listFindNoCase(getAllMenu.menu_user_type,session.logintype)>
					<div class="panel panel-info">
				        <div class="panel-heading">
				            <h3 class="panel-title"><img src="#getAllMenu.menu_image_location#" title="#getAllMenu.menu_name#" alt="#getAllMenu.menu_name#" height="35" width="35"> <a class="brand" href="#getAllMenu.menu_file_location#">#getAllMenu.menu_name#</a></h3>
				        </div>
				    </div>
			    </cfif>
			</cfoutput>
		</div>
	</cfif>
</form>
</body> --->
</html>
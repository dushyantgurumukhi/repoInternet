<cfsetting showdebugoutput="false">
<!DOCTYPE HTML>
<html>
<head>
	<title>|| Repo Internet - Customer ||</title>
	<meta charset="UTF-8" />
	<script src = "../javascript/jquery-1.12.0.min.js"></script>
	<script src = "../javascript/bootstrap.min.js"></script>
	<link href = "../css/bootstrap.min.css" rel = "stylesheet">
	<link href = "../css/repo.css" rel = "stylesheet">
</head>
<body>
	<cfset parentMenuId = '1'>	
	<cfoutput>
		<div class="container">
	        <div class="row centered-form">
	        	<cfinclude template="../menuBar.cfm">
	        	<div class="col-xs-12">
	        		<div class="panel panel-default">
	        			<div class="panel-heading">
				    		<h3 class="panel-title">Customer Administration</h3>
			 			</div>
			 			<div class="panel-body">
							<form  id="customer_admin">
		    					<cfif (isDefined("session.userid") and session.userid neq "") and isDefined("session.logintype") and session.logintype neq "">
									<cfobject name="objLogin" component="com.loginUser">
									<cfset getAllMenu = objLogin.getSubMenu(userType=session.logintype,parentMenuId=parentMenuId)>
			    					<cfoutput query="getAllMenu">
										<cfif listFindNoCase(getAllMenu.sub_menu_user_type,session.logintype)>
											<div class="panel panel-info">
										        <div class="panel-heading">
										            <h3 class="panel-title"><img src="#getAllMenu.sub_menu_image_location#" alt="#getAllMenu.sub_menu_name#" title="#getAllMenu.sub_menu_name#" height="35" width="35"> <a class="brand" href="#getAllMenu.sub_menu_file_location#">#getAllMenu.sub_menu_name#</a></h3>
										        </div>
										    </div>
									    </cfif>
									</cfoutput>
								<cfelse>
									<cfinclude template="../sessionLogout.cfm">	
								</cfif>
				    		</form>	
						</div>
					</div>
				</div>			
			</div>
		</div>	
	</cfoutput>
</body>


</html>
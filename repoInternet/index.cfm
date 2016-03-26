<!DOCTYPE html>
<html lang = "en">
   <head>
      <meta charset = "utf-8">
      <meta http-equiv = "X-UA-Compatible" content = "IE = edge">
      <meta name = "viewport" content = "width = device-width, initial-scale = 1">
      <title>|| Repo Internet ||</title>
	  <script src="../javascript/login.js"></script>
	  <script src = "../javascript/jquery-1.12.0.min.js"></script>
      <script src = "../javascript/bootstrap.min.js"></script>
      <link href = "../css/bootstrap.min.css" rel = "stylesheet">
	  <link href = "../css/repo.css" rel = "stylesheet">
   </head>
	
	<cfif structKeyExists(session,"userid")>
		<cfset temp = structDelete(session,"userid")>
	</cfif>
   <body>
		<form id="loginForm" name="loginForm" method="POST" action="homepage/authorize.cfm" onSubmit="return chk();">
			<div id="loginModal" class="modal show" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="text-center">Login</h1>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<input id="user_id" name="user_id" type="text" class="form-control input-lg" placeholder="User Id">
							</div>
							<div class="form-group">
								<input id = "user_password" name = "user_password" type="password" class="form-control input-lg" placeholder="Password">
							</div>
							<div class="form-group">
								<button id="btn_login" class="btn btn-warning btn-lg btn-block">
									Login In
								</button>
							</div>
						</div>
						<div class="modal-body">
							<cfif isDefined("url.loginFlag") and url.loginFlag eq "invalid">
								<div id="divstatus" class="alert alert-danger">
									Invalid login details entered, please enter valid user id and password !!
								</div>
							</cfif>	
						</div>
					</div>
				</div>
			</div>
		</form>
   </body>
</html>

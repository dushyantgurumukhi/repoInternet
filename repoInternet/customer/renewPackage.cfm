<cfsetting showdebugoutput="false">
<!DOCTYPE HTML>
<html>
<head>
	<title>|| Repo Internet - Renew Package ||</title>
	<meta charset="UTF-8" />
	<script src = "../javascript/jquery-1.12.0.min.js"></script>
	<script src="../javascript/jquery-ui.js"></script>
	<script src = "../javascript/bootstrap.min.js"></script>
	<link href = "../css/bootstrap.min.css" rel = "stylesheet">
	<link href="../css/jquery-ui.css" rel="stylesheet">
	<script src = "../javascript/renewPackage.js"></script>
	<link href = "../css/repo.css" rel = "stylesheet">
</head>
<cfobject name="objPackage" component="com.customer">
<cfset getPackage = objPackage.getPackage()>
<body>
	<cfoutput>
		<div class="container">
	        <div class="row centered-form">
	        	<cfinclude template="../menuBar.cfm">
	        	<div class="col-xs-12">
	        		<div class="panel panel-default">
	        			<div class="panel-heading">
				    		<h3 class="panel-title">Renew Package</h3>
			 			</div>
			 			<div class="panel-body">
							<cfif (isDefined("session.userid") and session.userid neq "") and isDefined("session.logintype") and session.logintype neq "">
								<form id="renew_package_form">
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" name="userid" id="userid" class="form-control input-sm" placeholder="Customer User ID">
					                			<input name="hiddenUID" id="hiddenUID" type="hidden"> 
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="button" id="btn_chk_renew" class="btn btn-primary form-control" onClick="checkRenew()" value="Check Renew ?">
					    					</div>
					    				</div>
					    			</div>
					    			
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" id="package_assigned" class="form-control input-sm" placeholder="Package assigned - " disabled>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="text" id="package_cost" class="form-control input-sm" placeholder="Package cost - " disabled>
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" id="package_exp_date" class="form-control input-sm" placeholder="Package expired date - " disabled>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="text" id="package_renew_date" class="form-control input-sm" placeholder="Select Package renew date">
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" id="next_renew_date" class="form-control input-sm" placeholder="Next renew date - " disabled>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<span class="label label-success" id="success_span" style="visibility:hidden"><label id="id_label_msg" value=""></label></span>
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="button" id="btn_renew_package" class="btn btn-primary form-control" onClick="renewPackage()" value="Renew Package">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="button" id="btn_clear_all" class="btn btn-primary form-control" onClick="resetAllFields()" value="Clear All">
					    					</div>
					    				</div>
					    			</div>
					    		</form>
							<cfelse>
								<cfinclude template="../sessionLogout.cfm">	
							</cfif>
								
						</div>
					</div>
				</div>			
			</div>
		</div>	
	</cfoutput>
</body>
</html>
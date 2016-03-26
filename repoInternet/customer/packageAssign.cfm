<cfsetting showdebugoutput="false">
<!DOCTYPE HTML>
<html>
<head>
	<title>|| Repo Internet - Package ||</title>
	<meta charset="UTF-8" />
	<script src = "../javascript/jquery-1.12.0.min.js"></script>
	<script src="../javascript/jquery-ui.js"></script>
	<script src = "../javascript/bootstrap.min.js"></script>
	<link href = "../css/bootstrap.min.css" rel = "stylesheet">
	<link href="../css/jquery-ui.css" rel="stylesheet">
	<script src = "../javascript/assignPackage.js"></script>
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
				    		<h3 class="panel-title">Assign Customer Package</h3>
			 			</div>
			 			<div class="panel-body">
							<cfif (isDefined("session.userid") and session.userid neq "") and isDefined("session.logintype") and session.logintype neq "">
								<form id="assign_package_form">
						    		<input type="hidden" name="customer_age" id="customer_age" value="">
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" name="userid" id="userid" class="form-control input-sm" placeholder="Customer User ID">
					                			<input name="hiddenUID" id="hiddenUID" type="hidden"> 
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<!--- <input type="text" id="date_of_install" class="form-control input-sm" placeholder="Date of Installation"> --->
					    					</div>
					    				</div>
					    			</div>
					    			
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<select id="assign_package" class="form-control input-sm">
													<option value="">Select Package</option>
													<cfloop query="getPackage">
														<option value="#getPackage.package_id#">#getPackage.package_name# - #getPackage.speed# - #getPackage.data_type# - #getPackage.package_price#</option>
													</cfloop>
													
												</select>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="text" id="package_cost" class="form-control input-sm" placeholder="Package Cost" disabled>
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" id="package_start_date" class="form-control input-sm" placeholder="Package Start Date">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="text" id="package_end_date" class="form-control input-sm" placeholder="Package End Date" disabled>
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" id="package_duration" class="form-control input-sm" placeholder="Package duration-30 days" disabled>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<!--- <input type="text" id="installation_charges" class="form-control input-sm" placeholder="Installation Charges"> --->
					    					</div>
					    				</div>
					    			</div>
					    			<div class="form-group">
			    						<span class="label label-success" id="success_span" style="visibility:hidden"><label id="id_label_msg" value=""></label></span>
			    					</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="button" id="btn_add_customer" class="btn btn-primary form-control" onClick="assignPackage()" value="Assign Package">
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
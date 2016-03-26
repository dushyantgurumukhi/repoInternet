<cfsetting showdebugoutput="false">
<!DOCTYPE HTML>
<html>
<head>
	<title>|| Repo Internet - Daily Collection ||</title>
	<meta charset="UTF-8" />
	<script src = "../javascript/jquery-1.12.0.min.js"></script>
	<script src="../javascript/jquery-ui.js"></script>
	<script src = "../javascript/bootstrap.min.js"></script>
	<link href = "../css/bootstrap.min.css" rel = "stylesheet">
	<link href="../css/jquery-ui.css" rel="stylesheet">
	<script src = "../javascript/dailyCollection.js"></script>
	<link href = "../css/repo.css" rel = "stylesheet">
</head>
<cfobject name="objEngineer" component="com.collection">
<cfset getEngineer = objEngineer.getAllEngineer()>
<body>
	<cfoutput>
		<div class="container">
	        <div class="row centered-form">
	        	<cfinclude template="../menuBar.cfm">
	        	<div class="col-xs-12">
	        		<div class="panel panel-default">
	        			<div class="panel-heading">
				    		<h3 class="panel-title">Daily Collection</h3>
			 			</div>
			 			<div class="panel-body">
			 				<cfif (isDefined("session.userid") and session.userid neq "") and isDefined("session.logintype") and session.logintype neq "">
								<form id="daily_collection_form">
						    		<input type="hidden" name="hid_total_amount" id="hid_total_amount" value="">
						    		<input type="hidden" name="hid_package_id" id="hid_package_id" value="">
						    		<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" name="userid" id="userid" class="form-control input-sm" placeholder="Customer User ID">
					                			<input name="hiddenUID" id="hiddenUID" type="hidden"> 
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="button" id="btn_check_package" class="btn btn-primary" onClick="checkPackage()" value="Check Package">
					    						<span class="label label-success" id="success_span" style="visibility:hidden"><label id="id_label_msg" value=""></label></span>
					    					</div>
					    				</div>
					    			</div>
					    			<div id="payment_div" style="visibility:hidden">
										<div class="row">
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						                			<input type="text" id="package_assigned" class="form-control input-sm" placeholder="Package Assigned" disabled>
						    					</div>
						    				</div>
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						    						<input type="text" id="amount_paid" class="form-control input-sm" placeholder="Amount Paid" disabled>
						    					</div>
						    				</div>
						    			</div>
						    			<div class="row">
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						                			<input type="text" id="payment_month" class="form-control input-sm" placeholder="Payment Month">
						    					</div>
						    				</div>
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						    						<input type="text" id="payment_date" class="form-control input-sm" placeholder="Payment Date">
						    					</div>
						    				</div>
						    			</div>
						    			
						    			<div class="row">
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						                			<input type="text" id="discount_amount" class="form-control input-sm" placeholder="Discount" disabled>
						    					</div>
						    				</div>
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						    						<input type="text" id="total_amount" class="form-control input-sm" placeholder="Total Amount" disabled>
						    					</div>
						    				</div>
						    			</div>
	
						    			<div class="row">
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						                			<select id="collected_at" class="form-control input-sm">
														<option value="">Select Payment collected at</option>
														<option value="home">Customer's residence</option>
														<option value="office">Office</option>
													</select>
						    					</div>
						    				</div>
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						    						<select id="collected_by" class="form-control input-sm">
														<option value="">Select Payment collected by</option>
														<cfloop query="getEngineer">
															<option value="#getEngineer.engineer_id#">#getEngineer.engineer_name# - #getEngineer.engineer_id#</option>
														</cfloop>
													</select>
						    					</div>
						    				</div>
						    			</div>
						    			<div class="row">
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						                			<input type="button" id="btn_collection" class="btn btn-primary form-control" onClick="insertCollectionRecord()" value="Insert Record">
						    					</div>
						    				</div>
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						    						<input type="button" id="btn_clear_all" class="btn btn-primary form-control" onClick="resetAllFields()" value="Clear All">
						    					</div>
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
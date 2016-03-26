<cfsetting showdebugoutput="false">
<!DOCTYPE HTML>
<html>
<head>
	<title>|| Repo Internet - Customer ||</title>
	<meta charset="UTF-8" />
	<script src = "../javascript/jquery-1.12.0.min.js"></script>
	<script src="../javascript/jquery.js"></script>
	<script src="../javascript/jquery-ui.js"></script>
	<script src = "../javascript/bootstrap.min.js"></script>
	<link href = "../css/bootstrap.min.css" rel = "stylesheet">
	<link href="../css/jquery-ui.css" rel="stylesheet">
	<script src = "../javascript/addCustomer.js"></script>
	<link href = "../css/repo.css" rel = "stylesheet">
</head>
<cfobject name="objCustomer" component="com.customer">
<cfset getZoneId = objCustomer.getZoneId()>
<body>
<cfoutput>
	<div class="container">
        <div class="row centered-form">
			<cfinclude template="../menuBar.cfm">
        	<div class="col-xs-12">
        		<div class="panel panel-default">
        			<div class="panel-heading">
			    		<h3 class="panel-title">Add New Customer</h3>
		 			</div>
			 			<div class="panel-body">
				    		<cfif (isDefined("session.userid") and session.userid neq "") and isDefined("session.logintype") and session.logintype neq "">
								<form id="add_cust_form">
						    		<input type="hidden" name="customer_age" id="customer_age" value="">
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" name="userid" id="userid" class="form-control input-sm" placeholder="Customer User ID">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group" id="div_avail">
					    						<input type="button" id="btn_avail" class="btn btn-primary" onClick="checkUserIdAvailable()" value="Check Availability">
					    						<span class="label label-success" id="success_span" style="visibility:hidden"><label id="id_label_msg" value=""></label></span>
					    					</div>
					    				</div>
					    			</div>
									<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="text" name="userfirstname" id="userfirstname" class="form-control input-sm" placeholder="Customer First Name">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="text" name="userlastname" id="userlastname" class="form-control input-sm" placeholder="Customer Last Name">
					    					</div>
					    				</div>
					    			</div>
					    			
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
												 <input type="text" id="customer_dob" name="customer_dob" class="form-control" placeholder="Customer Date of Birth">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="text" name="customer_email" id="customer_email" class="form-control input-sm" placeholder="Customer Email Address">
					    					</div>
					    				</div>
					    			</div>
					    			
		
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<select name="customer_status" id="customer_status" class="form-control input-sm" >
													<option value="">Select Customer Status</option>
													<option value="Y">Active</option>
													<option value="N">In-active</option>
												</select>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
							                    <input type="text" id="activeDate_text" name="activeDate_text" class="form-control" placeholder="Active Date">
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<select name="customer_type" id="customer_type" class="form-control input-sm" placeholder="Customer Type">
													<option value="">Select Customer Type</option>
													<option value="paid">Paid</option>
													<option value="free">Free</option>
												</select>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
							                    <input type="text" id="contact_number" name="contact_number" class="form-control" placeholder="Customer Mobile Number">
					    					</div>
					    				</div>
					    			</div>
					    			
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<select name="zone_id" id="zone_id" class="form-control input-sm" placeholder=" Customer Zone ID">
													<option value="">Select Zone</option>
													<cfloop query="getZoneId">
														<option value="#getZoneId.zone_id#">#getZoneId.zone_name#</option>
													</cfloop>
												</select>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
							                    <input type="text" id="building_flat_number" name="building_flat_number" class="form-control" placeholder="Building / Flat Number">
					    					</div>
					    				</div>
					    			</div>
			    					<div class="form-group">
					                    <textarea class="form-control" rows="2" id="customer_address" placeholder="Address"></textarea>
			    					</div>
			    					<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="text" id="date_of_install" class="form-control input-sm" placeholder="Date of Installation">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
							                    <input type="text" id="installation_charges" class="form-control input-sm" placeholder="Installation Charges">
					    					</div>
					    				</div>
					    			</div>
			    					<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<select id="switch_power" class="form-control input-sm">
													<option value="">Select Switch Power Applied</option>
													<option value="Y">Yes</option>
													<option value="N">No</option>
												</select>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="text" id="discount_amount" class="form-control input-sm" placeholder="Discount Amount - For switch power" disabled>
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<select name="identity_proof" id="identity_proof" class="form-control input-sm" placeholder="Identity Proof">
													<option value="">Select Identity Proof</option>
													<option value="aadhar">Aadhar Card</option>
													<option value="pancard">Pan Card</option>
													<option value="passport">Passport</option>
												</select>
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
							                    <input type="text" id="identity_number" name="identity_number" class="form-control" placeholder="Identity Number">
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			Attach Identity Proof file(.jpeg,.png,.bmp only.) <input type="file" class="file" id="identity_proof_file" accept="image/x-png, image/gif, image/jpeg">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group" id="div_avail">
					    						<input type="button" id="btn_upload" class="btn btn-primary" disabled onClick="uploadIDProof()" value="Upload">
					    					</div>
					    				</div>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					                			<input type="button" id="btn_add_customer" class="btn btn-primary form-control" onClick="addCustomer()" value="Insert Record">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group" id="div_avail">
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
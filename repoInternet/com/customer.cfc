<cfcomponent output="true">
	<cffunction name="getCustomerAvailability" access="remote" returntype="string" returnformat="plain">
		<cfargument name="passedUserId" default="">
		<cfset custAvail = "notavail">
		<cfif isDefined("arguments.passedUserId") and arguments.passedUserId neq "">
			<cfquery name="getAvailUserId" datasource="repointernet">
				select user_id from customer_master where lower(user_id) = '#lcase(arguments.passedUserId)#'
			</cfquery>
			<cfif getAvailUserId.recordcount gt 0>
				<cfset custAvail = "Not Available">
			<cfelse>
				<cfset custAvail = "Available">	
			</cfif>
		</cfif>
		<cfreturn custAvail>
	</cffunction>
	
	<cffunction name="addUpdateCustomerData" access="remote">
		<cfargument name="form" default="" type="any">
		<cfset formValues = deserializeJSON(arguments.form)>
		<cfif isDefined("session.userid")>
			<cfset updated_by = session.userid>
		<cfelse>
			<cfset updated_by = "admin">
		</cfif>
		<cfquery name="getExistingCustomer" datasource="repointernet">
			select user_id from customer_master where lower(user_id) = '#lcase(formValues.userid)#'  and status = 'Y'
		</cfquery>
		<cftransaction>
			<cfif getExistingCustomer.recordcount gt 0>
				<cfquery name="deleteCustomerAddressRecord" datasource="repointernet">
					delete from customer_address_detail where lower(user_id) = '#lcase(formValues.userid)#'
				</cfquery>
				<cfquery name="deleteCustomerRecord" datasource="repointernet">
					delete from customer_master where lower(user_id) = '#lcase(formValues.userid)#'
				</cfquery>	
			</cfif>
			<cfquery name="getExistingCustomerInstallation" datasource="repointernet">
				select user_id from customer_installation_detail where lower(user_id) = '#lcase(formValues.userid)#'
			</cfquery>
			
			<cfquery name="addCustomerRecordMaster" datasource="repointernet">
				insert into customer_master(user_id,first_name, last_name, age, status, active_date, contact_number, customer_type, updated_by, updated_date, email_id, customer_dob)
							values ('#formValues.userid#',
							        '#formValues.userfirstname#',
							        '#formValues.userlastname#',
							        '#formValues.customer_age#',
							        '#formValues.customer_status#',
							         str_to_date('#formValues.activeDate_text#', '%m/%d/%Y'),
							        '#formValues.contact_number#',
							        '#formValues.customer_type#',
							        '#updated_by#',
							        sysdate(),
							        '#formValues.customer_email#',
							        str_to_date('#formValues.customer_dob#', '%m/%d/%Y')
							        )
			</cfquery>
			<cfquery name="addCustomerRecordAddress" datasource="repointernet">
				insert into customer_address_detail (user_id,building_flat_number,zone_id,address) 
							values ('#formValues.userid#',
									'#formValues.building_flat_number#',
									'#formValues.zone_id#',
									'#formValues.customer_address#'
							)
			</cfquery>
			
			<cfif (isDefined("formValues.identity_proof") and isDefined("formValues.identity_proof_file") and isDefined("formValues.identity_number")) and (formValues.identity_proof neq "" and formValues.identity_proof_file neq "" and formValues.identity_number neq "")>
				<cfquery name="addCustomerRecordAddress" datasource="repointernet">
					insert into customer_identity_detail (user_id,identity_proof,identity_number,identity_proof_path,updated_by,updated_date)
					values ('#formValues.userid#','#formValues.identity_proof#','#formValues.identity_proof_file#','#formValues.identity_number#','#updated_by#',sysdate())
				</cfquery>
			</cfif>
			
			<cfif getExistingCustomerInstallation.recordcount lte 0>
				<cfquery name="insertCustomerPackageDetail" datasource="repointernet">
					insert into customer_installation_detail (user_id,switch_power,discount_amount,installation_charge,date_install)
					values
					('#formValues.userid#','#formValues.switch_power#','#formValues.discount_amount#','#formValues.installation_charges#',str_to_date('#formValues.date_of_install#','%m/%d/%Y'))
				</cfquery>
			</cfif>
			
			<cfdirectory directory="#expandpath('\tempIDFiles')#" action="list" filter="#formValues.userid#.*" name="getTempFile" sort="datelastmodified DESC, name ASC">
			<cfif getTempFile.recordcount gt 0>
				<cfset returnFlag = "1">
				<cffile action="copy" source="#expandpath('\tempIDFiles\#getTempFile.name#')#" destination="#expandpath('\images\CustomerIDProof\#getTempFile.name#')#">
				<cffile action="delete" file="#expandpath('\tempIDFiles\#getTempFile.name#')#">
			</cfif>
			
		</cftransaction>
	</cffunction>
	
	<cffunction name="checkTempIDAttachment" access="remote" returntype="any" returnformat="plain">
		<cfargument name="userid">
		<cfset returnFlag = "0">
		<cfoutput>
			<cfdirectory directory="#expandpath('\tempIDFiles')#" action="list" filter="#arguments.userid#.*" name="getTempFile" sort="datelastmodified DESC, name ASC">
			<cfif getTempFile.recordcount gt 0>
				<cfset returnFlag = "1">
			<cfelse>
				<cfset returnFlag = "0">
			</cfif>
		</cfoutput>
		<cfreturn returnFlag>
	</cffunction>
	
	<cffunction name="getZoneId" access="public">
		<cfquery name="getZoneIdQuery" datasource="repointernet">
			select zone_id,zone_name from zone_admin order by zone_name asc
		</cfquery>
		<cfreturn getZoneIdQuery>
	</cffunction>
	
	<cffunction name="getAllCustomerUserID" access="remote">
		<cfargument name="term" default="">
		<cfquery name="getAllUserID" datasource="repointernet">
			select user_id from customer_master where user_id like '%#trim(arguments.term)#%' and status = 'Y'
		</cfquery>
		<cfset myArray = queryToArray(passedQuery=getAllUserID)>
		<cfreturn myArray>
	</cffunction>
	
	<cffunction name="queryToArray" returntype="any" access="public" output="yes">
		<cfargument name="passedQuery" type="query" required="yes" />
		<cfset var o=ArrayNew(1)>
		<cfset var i=1>
		<cfset var r=0>
		<cfloop query="arguments.passedQuery">
			<cfset r=Currentrow>
			<cfset o[r]=arguments.passedQuery.user_id>
		</cfloop>
		<cfreturn o>
	</cffunction>
	
	<cffunction name="getPackage" access="public">
		<cfquery name="getAllPackage" datasource="repointernet">
			select  package_id, package_name, speed, data_type, package_price from package_admin where package_active = 'Y' order by speed asc
		</cfquery>
		<cfreturn getAllPackage>
	</cffunction>
	
	<cffunction name="getPackagePrice" access="remote" returnformat="plain">
		<cfargument name="packageId" default="">
		<cfquery name="getAllPackage" datasource="repointernet">
			select package_price from package_admin where package_active = 'Y' 
			<cfif isDefined("arguments.packageId") and arguments.packageId neq "">
				and package_id = '#arguments.packageId#'
			</cfif>
		</cfquery>
		<cfreturn getAllPackage.package_price>
	</cffunction>
	
	<cffunction name="updateCustomerPackage" access="remote">
		<cfargument name="form" required="true">
		<cfset formValues = deserializeJSON(arguments.form)>
		<cfif isDefined("session.userid")>
			<cfset updated_by = session.userid>
		<cfelse>
			<cfset updated_by = "admin">
		</cfif>
		<cfquery name="getExistingCustomer" datasource="repointernet">
			select user_id from customer_package_detail where lower(user_id) = '#lcase(formValues.userid)#' and package_id = '#formValues.assign_package#'
		</cfquery>
		<cftransaction>
			<cfif getExistingCustomer.recordcount gt 0>
				<cfquery name="deleteCustomerAddressRecord" datasource="repointernet">
					update customer_package_detail set package_start_date = str_to_date('#formValues.package_start_date#','%m/%d/%Y'), current_pack_active = 'Y', updated_by='#updated_by#', updated_date=sysdate() 
					where lower(user_id) = '#lcase(formValues.userid)#' and package_id = '#formValues.assign_package#'
				</cfquery>
				
				<cfquery name="deleteCustomerAddressRecord2" datasource="repointernet">
					update customer_package_detail set current_pack_active = 'N', updated_by='#updated_by#', updated_date=sysdate() 
					where lower(user_id) = '#lcase(formValues.userid)#' and package_id <> '#formValues.assign_package#'
				</cfquery>
				
				<!--- <cfquery name="getExistingCustomer" datasource="repointernet">
					select user_id from customer_installation_detail where lower(user_id) = '#lcase(formValues.userid)#'
				</cfquery>
				<cfif getExistingCustomer.recordcount lte 0>
					<cfquery name="insertCustomerPackageDetail" datasource="repointernet">
						insert into customer_installation_detail (user_id,switch_power,discount_amount,installation_charge,date_install)
						values
						('#formValues.userid#','#formValues.switch_power#','#formValues.discount_amount#','#formValues.installation_charges#',str_to_date('#formValues.date_of_install#','%m/%d/%Y'))
					</cfquery>
				</cfif> --->
				
			<cfelse>
				<cfquery name="deleteCustomerAddressRecord" datasource="repointernet">
					update customer_package_detail set current_pack_active = 'N', updated_by='#updated_by#', updated_date=sysdate() where lower(user_id) = '#lcase(formValues.userid)#'
				</cfquery>	
				<cfquery name="updateCustomerPackageQry" datasource="repointernet">
					insert into customer_package_detail (user_id, package_id, package_start_date, current_pack_active, package_duration, updated_by, updated_date)
					values
					('#formValues.userid#','#formValues.assign_package#',str_to_date('#formValues.package_start_date#','%m/%d/%Y'),'Y','30','#updated_by#',sysdate())
				</cfquery>
				
				<!--- <cfquery name="getExistingCustomer" datasource="repointernet">
					select user_id from customer_installation_detail where lower(user_id) = '#lcase(formValues.userid)#'
				</cfquery>
				<cfif getExistingCustomer.recordcount lte 0>
					<cfquery name="insertCustomerPackageDetail" datasource="repointernet">
						insert into customer_installation_detail (user_id,switch_power,discount_amount,installation_charge,date_install)
						values
						('#formValues.userid#','#formValues.switch_power#','#formValues.discount_amount#','#formValues.installation_charges#',str_to_date('#formValues.date_of_install#','%m/%d/%Y'))
					</cfquery>
				</cfif> --->	
			</cfif>
		</cftransaction>
	</cffunction>
	
	<cffunction name="getCustomerActivePackage" access="remote" returntype="any" returnformat="plain" output="yes">
		<cfargument name="userid" default="" required="yes">
		<cfset assignPackage="notassign">
		<cfquery name="getAssignQuery" datasource="repointernet">
			select 'assign' as user_id,pa.package_name,pa.package_price,pa.package_id,pa.package_duration from customer_package_detail cpd, package_admin pa
  			where pa.package_id = cpd.package_id
  			and cpd.user_id = '#arguments.userid#'
	        and current_pack_active = 'Y'
		</cfquery>
		
		<cfif getAssignQuery.recordcount gt 0>
			<cfquery name="getPackageRenewDetail" datasource="repointernet">
				 select last_pack_exp_date,user_id from customer_package_renew where user_id = '#arguments.userid#' and entry_active = 'Y'
			</cfquery>
			<cfset lastPackExpDate = ArrayNew(1)>
			<cfset lastPackExpDate[1] = getPackageRenewDetail.last_pack_exp_date>
			<cfset queryAddColumn(getAssignQuery,"last_pack_exp_date","string",lastPackExpDate)>
		<cfelse>
			<cfquery name="getAssignQuery" datasource="repointernet">
				select 'notassign' as user_id, '' as package_name,'' as package_price, '' as last_pack_exp_date,'' as package_id,'' as package_duration from dual
			</cfquery>	
		</cfif>
		<cfset assignPackage = serializeJSON(getAssignQuery)>
		<cfreturn assignPackage>
	</cffunction>
	
	<cffunction name="insertRenewPackage" access="remote" returntype="any" returnformat="plain" output="yes">
		<cfargument name="form" default="">
		<cfset formValues = deserializeJSON(arguments.form)>
		<cfif isDefined("session.userid")>
			<cfset updated_by = session.userid>
		<cfelse>
			<cfset updated_by = "admin">
		</cfif>
		
			<!--- "userid":$('#userid').val(),
			"package_id":$('#hid_total_amount').val(),
			"last_pack_exp_date":$('#hidden_packageLastExpiredDate').val(),
			"pack_renew_date":$('#package_renew_date').val(),
			"curr_pack_exp_date":$('#hidden_packageCurrExpiredDate').val() 
			concat('',curr_pack_exp_date)
			
			--->


		<cftransaction>
			<cfquery name="getActivePackage" datasource="repointernet">
				select curr_pack_exp_date as curr_pack_exp_date from customer_package_renew where user_id = '#formValues.userid#' and entry_active = 'Y'
			</cfquery>
			
			<cfset lastExpDate = "">
			<cfif getActivePackage.recordcount gt 0>
				<cfset lastExpDate = dateformat(getActivePackage.curr_pack_exp_date,"mm/dd/yyyy") >
			</cfif>
			
			<cfquery name="inactivePackageEntry" datasource="repointernet">
				update customer_package_renew set entry_active = 'N' where user_id = '#formValues.userid#'
			</cfquery>
			<cfquery name="insertCollectionRecord" datasource="repointernet">
				insert into customer_package_renew (user_id,package_id,last_pack_exp_date,pack_renew_date,curr_pack_exp_date,entry_active,updated_by,updated_date)
				values
				('#formValues.userid#','#formValues.package_id#',<cfif lastExpDate neq "">str_to_date('#lastExpDate#', '%m/%d/%Y')<cfelse>null</cfif>,str_to_date('#formValues.pack_renew_date#', '%m/%d/%Y'),str_to_date('#formValues.curr_pack_exp_date#', '%m/%d/%Y'),'Y','#updated_by#',sysdate())
			</cfquery>
		</cftransaction>
		
	</cffunction>
	
</cfcomponent>


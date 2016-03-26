<cfcomponent output="false">
	<cffunction name="getAllEngineer" access="public">
		<cfquery name="getAllEngineerQry" datasource="repointernet">
			select engineer_id,engineer_name from engineer_admin order by engineer_name asc
		</cfquery>
		<cfreturn getAllEngineerQry>
	</cffunction>
	<cffunction name="getAssignedPackage" access="remote" returnformat="plain">
		<cfargument name="userid" default="">
		<cfquery name="getPackageDetail" datasource="repointernet">
			select cpd.user_id,
			       pa.package_id,
			       pa.package_name,
			       pa.package_price,
			       current_pack_active,
			       cid.discount_amount
			  from customer_package_detail cpd, package_admin pa, customer_installation_detail cid
			 where     1 = 1
			       and cpd.package_id = pa.package_id
			       and cpd.current_pack_active = 'Y'
			       and cpd.user_id = cid.user_id
			       and cpd.user_id = '#arguments.userid#'
		</cfquery>
		<cfset returnJson = serializeJSON(getPackageDetail)>
		<cfreturn returnJson>
	</cffunction>
	
	<cffunction name="insertCollectionMaster" access="remote" returnformat="plain" returntype="string">
		<cfargument name="form" default="">
		<cfset formValues = deserializeJSON(arguments.form)>
		<cfif isDefined("session.userid")>
			<cfset updated_by = session.userid>
		<cfelse>
			<cfset updated_by = "admin">
		</cfif>
		<cfset collectId =  getUniqueID(passedID=formValues.userid)>
		<cftransaction>
			<cfquery name="insertCollectionRecord" datasource="repointernet">
				insert into collection_master (collect_id,user_id,amount_paid,package_id,paid_date_month,paid_date,collected_by,collected_at,updated_by,updated_date)
				values
				('#collectId#','#formValues.userid#','#formValues.amount_paid#','#formValues.package_id#','#formValues.paid_date_month#',str_to_date('#formValues.paid_date#', '%m/%d/%Y'),'#formValues.collected_by#','#formValues.collected_at#','#updated_by#',sysdate())
			</cfquery>
		</cftransaction>
		<cfreturn collectId>
	</cffunction>
	
	<cffunction name="getExistingCollectionEntry" access="remote" returntype="string" returnformat="plain">
		<cfargument name="paidMonth" default="">
		<cfset returnFlag = "noexists">
		<cfif isDefined("arguments.paidMonth") and arguments.paidMonth neq "">
			<cfquery name="getExistingPayment" datasource="repointernet">
				select collect_id from collection_master where paid_date_month = '#arguments.paidMonth#'
			</cfquery>
			<cfif getExistingPayment.recordcount gt 0>
				<cfset returnFlag = "exists">
			<cfelse>
				<cfset returnFlag = "noexists">
			</cfif>
			<cfreturn returnFlag>
		</cfif>
	</cffunction>
	
	<cffunction name="getUniqueID" access="public">
		<cfargument name="passedID" default="" required="true">
		<cfset uniqueID = "">
		<cfset nowDate = now()>
		<cfset getYear = DatePart('yyyy', nowDate)>
		<cfset getmonth = DatePart('m', nowDate)>
		<cfset getday = DatePart('d', nowDate)>
		<cfset getHour = DatePart('h', nowDate)>
		<cfset getmin = DatePart('n', nowDate)>
		<cfset getsec = DatePart('s', nowDate)>
		
		<cfquery name="getRandomNumber" datasource="repointernet">
			SELECT ROUND(RAND()*(200) + 10) as randomNumber FROM dual
		</cfquery>
		
		<cfset randomNumber = getRandomNumber.randomNumber>
		<cfset uniqueID = arguments.passedID & getYear & getmonth & getday & getHour & getmin & getsec &randomNumber>
		<cfreturn uniqueID>
	</cffunction>
	
	<cffunction name="getZonedAssigned" access="remote" returnformat="plain">
		<cfargument name="engineer_id" default="">
		<cfquery name="getZone" datasource="repointernet">
			select zone_assigned from engineer_admin where engineer_id = '#arguments.engineer_id#'
		</cfquery>
		<cfset zoneId = getZone.zone_assigned>
		<cfreturn zoneId>
	</cffunction>
	
	<cffunction name="insertEngineerCollectionDaily" access="remote" returnformat="plain" returntype="string">
		<cfargument name="form" default="">
		<cfset formValues = deserializeJSON(arguments.form)>
		<cfif isDefined("session.userid")>
			<cfset updated_by = session.userid>
		<cfelse>
			<cfset updated_by = "admin">
		</cfif>
		<cfset collectId =  getUniqueID(passedID=formValues.collected_by)>
		<cftransaction>
			<cfquery name="insertCollectionRecord" datasource="repointernet">
				insert into engineer_daily_collection (collect_id,engineer_id,amount_collected,collection_date,updated_by,updated_date)
				values
				('#collectId#','#formValues.collected_by#','#formValues.amount_collected#',str_to_date('#formValues.collection_date#', '%m/%d/%Y'),'#updated_by#',sysdate())
			</cfquery>
		</cftransaction>
		<cfreturn collectId>
	</cffunction>
	
	
</cfcomponent>
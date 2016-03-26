<cfoutput>
	<cftry>
		<cffile action="upload" filefield="file" destination='#expandpath("\tempIDFiles")#' nameConflict="overwrite">
		<cfcatch>
			#cfcatch.Message#
		</cfcatch>
	</cftry>
    <cfcontent reset="true" />Uploaded #cffile.serverFile#
</cfoutput>
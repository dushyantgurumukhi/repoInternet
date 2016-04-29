$(document).ready(function () {
		  $('#package_renew_date').datepicker({
			inline: true,
			onSelect: function(dateText, inst) { 
			
			var passedNextDate = new Date($("#package_renew_date").val());
			var packageDuration = parseInt($("#hidden_packageDuration").val());
			var nextDate = new Date (passedNextDate.setDate(passedNextDate.getDate() + packageDuration));
			var yr      = nextDate.getFullYear(),
			    month   = nextDate.getMonth() + 1,
			    day     = nextDate.getDate(),
			    newDate = month + '/' + day + '/' + yr;
            $("#next_renew_date").val("Next renew date - " + newDate);
            $("#hidden_packageCurrExpiredDate").val("" + newDate);
            
			}
		});
		  $("#userid").autocomplete({ source: "../com/customer.cfc?method=getAllCustomerUserID", select:function(event,ui) { $("#hiddenUID").val(ui.item.hiddenUID); } });
});

function checkRenew()
{
	if($('#userid').val().trim() == "")
	{
		alert("Please select correct Customer User ID.");
		$('#userid').val('');
		$('#userid').focus();
	}
	else
	{
		var userid = $('#userid').val().trim();
		userid = userid.toLowerCase();
		
		$.ajax({url: "../com/customer.cfc?method=getCustomerActivePackage&userid=" + userid, type: "POST",  
						           success: function(response){
						                      response = JSON.parse(response)
						                      if((response.DATA.length > 0))
						                      {
												
												var assignFlag = "";
						                      	var package_name = "";
						                      	var package_price = "";
						                      	var package_id = "";
						                      	var last_pack_exp_date = "";
						                      	var nowDateToJS = "";
						                      	var renewPackage = "";
						                      	var package_duration = "";
						                      	var packageRenewDate = "";
						                      							                      	
						                      	assignFlag = response.DATA[0][0];
												package_name = response.DATA[0][1];
												package_price = response.DATA[0][2];
												package_id = response.DATA[0][3];
												last_pack_exp_date = response.DATA[0][5];
												nowDateToJS = response.DATA[0][6];
												renewPackage = response.DATA[0][7];
												package_duration = response.DATA[0][4];
												packageRenewDate = $('#package_renew_date').val();
						                      	
						                      	if(assignFlag == 'notassign')
						                      	{
						                      		$("#renew_div").css('visibility', 'hidden');
													$("#success_span").css('visibility', 'visible');
													$("#success_span").attr('class', 'label label-danger');
													$("#id_label_msg").empty();
													$("#id_label_msg").append("Package not assign to customer.");
						                      	}
						                      	else
						                      	{
						                      		
						                      		if(last_pack_exp_date=="")
						                      		{
						                      			$("#success_span").css('visibility', 'hidden');
														$("#renew_div").css('visibility', 'visible');
														$('#package_assigned').val('Package assigned - ' + package_name);
														$('#package_cost').val('Package cost - Rs. ' + package_price);
														$('#package_exp_date').val('Package expired date - ' + last_pack_exp_date);
														$('#hidden_packageId').val(""+ package_id);
														$('#hidden_packageRenewDate').val("" + packageRenewDate);
														$('#hidden_packageLastExpiredDate').val("" + last_pack_exp_date);
														$('#btn_renew_package').prop('disabled',false);
														$("#package_renew_date").removeAttr("disabled");
						                      		}
						                      		else if(renewPackage == "renew")
						                      		{
						                      			$("#success_span").css('visibility', 'hidden');
														$("#renew_div").css('visibility', 'visible');
														$('#package_assigned').val('Package assigned - ' + package_name);
														$('#package_cost').val('Package cost - Rs. ' + package_price);
														$('#package_exp_date').val('Package expired date - ' + last_pack_exp_date);
														$('#hidden_packageId').val(""+ package_id);
														$('#hidden_packageRenewDate').val("" + packageRenewDate);
														$('#hidden_packageLastExpiredDate').val("" + last_pack_exp_date);
						                      		}
						                      		else
						                      		{
						                      			//$("#renew_div").css('visibility', 'hidden');
														$("#success_span").css('visibility', 'visible');
														$("#success_span").attr('class', 'label label-danger');
														$("#id_label_msg").empty();
														$("#id_label_msg").append("Package still Active.");
														
														$("#renew_div").css('visibility', 'visible');
														$('#package_assigned').val('Package assigned - ' + package_name);
														$('#package_cost').val('Package cost - Rs. ' + package_price);
														$('#package_exp_date').val('Package expired date - ' + last_pack_exp_date);
														$('#hidden_packageId').val(""+ package_id);
														$('#hidden_packageRenewDate').val("" + packageRenewDate);
														$('#hidden_packageLastExpiredDate').val("" + last_pack_exp_date);
														
														$('#btn_renew_package').prop('disabled',true);
														$("#package_renew_date").attr("disabled", "disabled"); 
						                      		}
						                      		
						                      		/*
						                      		if(last_pack_exp_date == nowDateToJS)
						                      		{
						                      			$("#success_span").css('visibility', 'hidden');
														$("#renew_div").css('visibility', 'visible');
														$('#package_assigned').val('Package assigned - ' + package_name);
														$('#package_cost').val('Package cost - Rs. ' + package_price);
														$('#package_exp_date').val('Package expired date - ' + last_pack_exp_date);
														$('#hidden_packageId').val(""+ package_id);
														$('#hidden_packageRenewDate').val("" + packageRenewDate);
														$('#hidden_packageLastExpiredDate').val("" + last_pack_exp_date);
						                      		}
						                      		else if(last_pack_exp_date=="")
						                      		{
						                      			$("#success_span").css('visibility', 'hidden');
														$("#renew_div").css('visibility', 'visible');
														$('#package_assigned').val('Package assigned - ' + package_name);
														$('#package_cost').val('Package cost - Rs. ' + package_price);
														$('#package_exp_date').val('Package expired date - ' + last_pack_exp_date);
														$('#hidden_packageId').val(""+ package_id);
														$('#hidden_packageRenewDate').val("" + packageRenewDate);
														$('#hidden_packageLastExpiredDate').val("" + last_pack_exp_date);
														$('#btn_renew_package').prop('disabled',false);
														$("#package_renew_date").removeAttr("disabled");
						                      		}
						                      		*/
						                      		

													if(package_duration == "")
													{
														package_duration = 30;
													}
													$('#hidden_packageDuration').val("" + package_duration);
													
						                      	}
						                      	
						                      }
						                      else
						                      {
													alert("No data available.");			                  				    
						                      }
						                       
						  }
						  });
	}	
}


function checkDate(chkDate) 
{
    
    
    var EnteredDate = chkDate; //for javascript

    //var EnteredDate = $("#txtdate").val(); // For JQuery

    var date = EnteredDate.substring(0, 2);
    var month = EnteredDate.substring(3, 5);
    var year = EnteredDate.substring(6, 10);

    var myDate = new Date(year, month - 1, date);

    var today = new Date();
	alert(" myDate " + myDate + "\n" + " today : " + today);
	
	
    if (myDate == today) {
        alert("Entered date is greater than today's date ");
    }
    else {
        alert("Entered date is less than today's date ");
    }
}

function renewPackage()
{
	var validateFields = validation();
	
	if(validateFields)
	{
		var JSONObj = { "userid":$('#userid').val(),
						"package_id":$('#hidden_packageId').val(),
						"last_pack_exp_date":$('#hidden_packageLastExpiredDate').val(),
						"pack_renew_date":$('#package_renew_date').val(),
						"curr_pack_exp_date":$('#hidden_packageCurrExpiredDate').val()
           			  };
           			  
           			  //document.getElementById("success_span").innerHTML = '<img src="../images/loader.gif" />';
					  $.get('../com/customer.cfc?linkid='+Math.random()+'&method=insertRenewPackage&form=' + JSON.stringify(JSONObj),
					  function(data){
						if($.trim(data) != '')
									{
										document.getElementById("success_span").innerHTML = '';
										$("#success_span").css('visibility', 'visible');
										$("#success_span").attr('class', 'label label-success');
										var $label = $("<label id='id_label_msg'>").text('Success - Collection ID: ' + $.trim(data));
										$("#success_span").append($label);
									}
					  });
           			  
           			  
           			  
           			  
	}
}

function validation()
{
	if($('#userid').val().trim() == "")
	{
		alert("Please select correct Customer User ID.");
		$('#userid').val('');
		$('#userid').focus();
		return false;
	}
	if($('#package_renew_date').val().trim()=="")
	{
		alert("Please select renew date.");
		$('#package_renew_date').val('');
		$('#package_renew_date').focus();
		return false;
	}
	return true;
}
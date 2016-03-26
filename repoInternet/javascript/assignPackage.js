 $(document).ready(function () {
		  //$('#date_of_install').datepicker();
		  $('#package_start_date').datepicker();
		  $("#userid").autocomplete({ source: "../com/customer.cfc?method=getAllCustomerUserID", select:function(event,ui) { $("#hiddenUID").val(ui.item.hiddenUID); } });
		  $("#package_cost").keypress(function (e) {
         	if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	               return false;
		    }
		   });
		  $("#assign_package").change(function(){
		  if($('#assign_package').val().trim() != "")
		   	{
		   		$.get('../com/customer.cfc?linkid='+Math.random()+'&method=getPackagePrice&packageId=' + $("#assign_package").val(),
				function(data)
				{
					if($.trim(data) != '')
					{
						$("#package_cost").val(''+ $.trim(data));
					}
					else
					{
						$("#package_cost").val('0');
					}
				});	
		   	}
		   	else
		   	{
		   		$("#package_cost").val('');
		   	}
		  });
});

function assignPackage()
{
	var validateAllFields = validatefields();
	if(validateAllFields)
	{
		if($('#userid').val() != "")
		{
			var passedUserId = $('#userid').val();
			$.get('../com/customer.cfc?linkid='+Math.random()+'&method=getCustomerAvailability&passedUserId=' + passedUserId,
			function(data)
			{
				if($.trim(data) == 'Available')
				{
					$("#success_span").css('visibility', 'visible');
					$("#success_span").attr('class', 'label label-danger');
					$("#id_label_msg").empty();
					$("#id_label_msg").append("Customer User Id not available.");
				}
				else
				{
					$("#success_span").css('visibility', 'hidden');
					sendDataToInsert();
				}
			});
		}
	}
}

function sendDataToInsert()
{
	var discountAmount = 0;
	if($('#discount_amount').val() == "" || $('#discount_amount').val() == 0)
	{
		discountAmount = 0;
	}
	else
	{
		discountAmount = $('#discount_amount').val();
	}
	
	var JSONObj = { "userid":$('#userid').val(),
					"assign_package":$('#assign_package').val(),
					"package_cost":$('#package_cost').val(),
					"package_start_date":$('#package_start_date').val()
           };
	document.getElementById("success_span").innerHTML = '<img src="../images/loader.gif" />';
	$.get('../com/customer.cfc?linkid='+Math.random()+'&method=updateCustomerPackage&form=' + JSON.stringify(JSONObj),
	function(data){});
	document.getElementById("success_span").innerHTML = '';
	$("#success_span").css('visibility', 'visible');
	$("#success_span").attr('class', 'label label-success');
	var $label = $("<label id='id_label_msg'>").text('Customer package updated successfully.');
	$("#success_span").append($label);
}


function validatefields()
{
	if($('#userid').val().trim() == "")
	{
		alert("Please select correct Customer User ID.");
		$('#userid').focus();
		return false;
	}

	if($('#assign_package').val().trim() == "")
	{
		alert("Please select package.");
		$('#assign_package').focus();
		return false;
	}
	if($('#package_start_date').val().trim() == "")
	{
		alert("Please select package start date.");
		$('#package_start_date').focus();
		return false;
	}
	return true;
}

function resetAllFields()
{
	$('#userid').val('');
	$('#assign_package').val('');
	$('#package_cost').val('');
	$('#package_start_date').val('');
	$("#success_span").css('visibility', 'hidden');
	$('#userid').focus();
	
}
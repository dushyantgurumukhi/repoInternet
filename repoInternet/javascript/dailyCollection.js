 $(document).ready(function () {
		  $("#payment_month").datepicker({ 
		        dateFormat: 'MM-yy',
		        changeMonth: true,
		        changeYear: true,
		        showButtonPanel: true,
		
		        onClose: function(dateText, inst) {  
		            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val(); 
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); 
		            $(this).val($.datepicker.formatDate('yy-MM', new Date(year, month, 1)));
		        }
		    });
		
		    $("#payment_month").focus(function () {
		        $(".ui-datepicker-calendar").hide();
		        $("#ui-datepicker-div").position({
		            my: "center top",
		            at: "center bottom",
		            of: $(this)
		        });    
		    });
		  $('#payment_date').datepicker();
		  $("#userid").autocomplete({ source: "../com/customer.cfc?method=getAllCustomerUserID", select:function(event,ui) { $("#hiddenUID").val(ui.item.hiddenUID); } });
});


function checkPackage()
{
	if($('#userid').val().trim() == "")
	{
		alert("Please select correct Customer User ID.");
		$('#userid').focus();
		return false;
	}
	else
	{
		var passedUserId = $('#userid').val();
		$.get('../com/customer.cfc?linkid='+Math.random()+'&method=getCustomerAvailability&passedUserId=' + passedUserId,
		function(data)
		{
			if($.trim(data) == 'Available')
			{
				$("#payment_div").css('visibility', 'hidden');
				$("#success_span").css('visibility', 'visible');
				$("#success_span").attr('class', 'label label-danger');
				$("#id_label_msg").empty();
				$("#id_label_msg").append("Customer User Id not available.");
				$('#package_assigned').val('');
			  	$('#amount_paid').val('');
			}
			else
			{
				$.get('../com/collection.cfc?linkid='+Math.random()+'&method=getAssignedPackage&passedUserId=' + passedUserId,
				function(data)
				{
					if($.trim(data) == 'Available')
					{
						$("#payment_div").css('visibility', 'hidden');
						$("#success_span").css('visibility', 'visible');
						$("#success_span").attr('class', 'label label-danger');
						$("#id_label_msg").empty();
						$("#id_label_msg").append("Customer User Id not available.");
						$('#package_assigned').val('');
      				  	$('#amount_paid').val('');
						 
					}
					else
					{
						var passedUId = $('#userid').val();
						$.ajax({  
						        url: "../com/collection.cfc?method=getAssignedPackage&userid="+passedUId, type: "POST",  
						           success: function(response){
						                      response = JSON.parse(response)
						                      if((response.DATA.length == 0))
						                      {
						                      	$("#payment_div").css('visibility', 'hidden');
												$("#success_span").css('visibility', 'visible');
												$("#success_span").attr('class', 'label label-danger');
												$("#id_label_msg").empty();
												$("#id_label_msg").append("Package not assigned.");
												$('#package_assigned').val('');
						      				  	$('#amount_paid').val('');
						                      }
						                      else
						                      {
						                      	var discountAmount = 0;
						                      	var totalAmount = 0;
						                      	var packagePrice = response.DATA[0][3];
						                      	
						                      	if(response.DATA[0][5] != "")
						                      	{
						                      		discountAmount = response.DATA[0][5];
						                      	}
						                      	totalAmount =  packagePrice - discountAmount;
						                      	$("#success_span").css('visibility', 'hidden');
						                      	$("#payment_div").css('visibility', 'visible');
						                        $('#package_assigned').val('Assigned Package : ' + response.DATA[0][2]);
						                        $('#discount_amount').val('Discount Amount : Rs. ' + discountAmount);
			                  				    $('#amount_paid').val('Package Price : Rs. ' + packagePrice);
			                  				    $('#total_amount').val('Total Amount Paid : Rs. ' + totalAmount);
			                  				    $('#hid_total_amount').val(totalAmount);
			                  				    $('#hid_package_id').val(response.DATA[0][1]);
			                  				    
						                      }
						                       
						  }
						});
					}
				});
			}
		});
	}
}

function insertCollectionRecord()
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
					$.get('../com/collection.cfc?linkid='+Math.random()+'&method=getExistingCollectionEntry&paidMonth=' + $('#payment_month').val(),
					function(data)
					{
						if($.trim(data) == 'exists')
						{
							$("#success_span").css('visibility', 'visible');
							$("#success_span").attr('class', 'label label-danger');
							$("#id_label_msg").empty();
							$("#id_label_msg").append("Collection record already available for " + $('#payment_month').val());
						}
						else
						{
							$("#success_span").css('visibility', 'hidden');
							sendDataToInsert();
						}
					});
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
					"amount_paid":$('#hid_total_amount').val(),
					"package_id":$('#hid_package_id').val(),
					"paid_date_month":$('#payment_month').val(),
					"paid_date":$('#payment_date').val(),
					"collected_by":$('#collected_by').val(),
					"collected_at":$('#collected_at').val()
           };
	
	document.getElementById("success_span").innerHTML = '<img src="../images/loader.gif" />';
	$.get('../com/collection.cfc?linkid='+Math.random()+'&method=insertCollectionMaster&form=' + JSON.stringify(JSONObj),
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

function validatefields()
{
	if($('#userid').val().trim() == "")
	{
		alert("Please select correct Customer User ID.");
		$('#userid').focus();
		return false;
	}
	if($('#payment_month').val().trim() == "")
	{
		alert("Please select month of payment.");
		$('#payment_month').focus();
		return false;
	}
	if($('#payment_date').val().trim() == "")
	{
		alert("Please select date of payment.");
		$('#payment_date').focus();
		return false;
	}
	if($('#collected_at').val().trim() == "")
	{
		alert("Please select payment collected at.");
		$('#collected_at').focus();
		return false;
	}
	if($('#collected_by').val().trim() == "")
	{
		alert("Please select collected by.");
		$('#collected_by').focus();
		return false;
	}
	return true;
}

function resetAllFields()
{
	$('#userid').val('');
	$('#payment_month').val('');
	$('#payment_date').val('');
	$('#collected_at').val('');
	$('#collected_by').val('');
	$('#hid_total_amount').val('');
	$('#hid_package_id').val('');
	$("#success_span").css('visibility', 'hidden');
	$("#payment_div").css('visibility', 'hidden');
	$('#userid').focus();
	
}
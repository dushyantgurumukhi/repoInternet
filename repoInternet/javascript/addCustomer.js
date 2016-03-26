 $(document).ready(function () {
		  $('#activeDate_text').datepicker();
		  $('#date_of_install').datepicker();
		  $('#switch_power').change(function(){
		  
		  if($("#switch_power").val() == "Y")
		  {
		  	$('#discount_amount').val('');
		  	$('#discount_amount').prop('disabled',false);
		  }
		  else 
		  {
		  	$('#discount_amount').val('');
		  	$('#discount_amount').prop('disabled',true);
		  }
		  });
		  $("#discount_amount").keypress(function (e) {
         	if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	               return false;
		    }
		   });
		  $('#customer_dob').datepicker(
		  {
		  	changeMonth: true,
        	changeYear: true,
        	yearRange: '1920:' + new Date().getFullYear()
		  });
		  
		  
		  $( "#identity_proof_file" ).change(function() {
		  	
		  	if($("#identity_number").val() && $("#identity_proof").val() && $("#identity_proof_file").val())
		  	{
		  		$('#btn_upload').prop('disabled',false);
		  	}
		  	else
		  	{
		  		$('#btn_upload').prop('disabled',true);
		  	}
		  	
			});
			
			$( "#identity_number" ).change(function() {
				
				if($("#identity_proof_file").val() && $("#identity_proof").val() && $("#identity_number").val())
			  	{
			  		$('#btn_upload').prop('disabled',false);
			  	}
			  	else
			  	{
			  		$('#btn_upload').prop('disabled',true);
			  	}
			
			});
			
			$("#installation_charges").keypress(function (e) {
         	if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	               return false;
		    }
		   });
			
			$( "#identity_proof" ).change(function() {
				
				if($("#identity_proof_file").val() && $("#identity_number").val() && $("#identity_proof").val())
			  	{
			  		$('#btn_upload').prop('disabled',false);
			  	}
			  	else
			  	{
			  		$('#btn_upload').prop('disabled',true);
			  	}
			
			});
		});

function checkUserIdAvailable()
{
	if(document.getElementById('userid').value.trim() == "")
	{
		alert("Please enter User Id.");
		$('#userid').val('');
		document.getElementById('userid').focus();
		return false;
	}
	else if(document.getElementById('userid').value.trim() != "")
	{
		var passedUserId = document.getElementById("userid").value;
		$.get('../com/customer.cfc?linkid='+Math.random()+'&method=getCustomerAvailability&passedUserId=' + passedUserId,
		function(data)
		{
			if($.trim(data) == 'Available')
			{
				$("#success_span").css('visibility', 'visible');
				$("#success_span").attr('class', 'label label-success');
				$("#id_label_msg").empty();
				$("#id_label_msg").append("Customer User Id available.");
			}
			else if($.trim(data) == 'Not Available')
			{
				$("#success_span").css('visibility', 'visible');
				$("#success_span").attr('class', 'label label-danger');
				$("#id_label_msg").empty();
				$("#id_label_msg").append("Customer User Id not available.");
			}
		});
	}
	
}
function resetAllFields()
{
	document.getElementById("success_span").style.visibility = "hidden";
	document.getElementById('userid').value = "";
	document.getElementById('userfirstname').value = "";
	document.getElementById('userlastname').value = "";
	document.getElementById('customer_dob').value = "";
	document.getElementById('customer_email').value = "";
	document.getElementById('customer_status').value = "";
	document.getElementById('activeDate_text').value = "";
	document.getElementById('customer_type').value = "";
	document.getElementById('contact_number').value = "";
	document.getElementById('zone_id').value = "";
	document.getElementById('building_flat_number').value = "";
	document.getElementById('customer_address').value = "";
	document.getElementById('identity_proof').value = "";
	document.getElementById('identity_proof_file').value = "";
	document.getElementById('identity_number').value = "";
	$('#btn_upload').prop('disabled',true);
	$('#date_of_install').val("");
	$('#installation_charges').val('');
	$('#switch_power').val('');
	$('#discount_amount').val('');
	$('#discount_amount').prop('disabled',true);
	document.getElementById('userid').focus();
}

function addCustomer()
{
	
	var validateAllFields = validatefields();
	if (validateAllFields)
	{
		var passedUserId = document.getElementById("userid").value;
		var validUploadFlag = "";
		$.get('../com/customer.cfc?linkid='+Math.random()+'&method=getCustomerAvailability&passedUserId=' + passedUserId,
		function(data)
		{
			if($.trim(data) == 'Not Available')
			{
				alert('Customer User Id already exist.') ;
				document.getElementById('userid').focus();
			}
			else
			{
				if($("#identity_number").val() && $("#identity_proof").val() && $("#identity_proof_file").val())
				{
					$.get('../com/customer.cfc?linkid='+Math.random()+'&method=checkTempIDAttachment&userid=' + passedUserId,
					function(data)
					{
						if($.trim(data) == '0')
						{
							alert("Please upload the attached document.");
							document.getElementById('btn_upload').focus();
							return false;
						}
						else if($.trim(data) == '1')
						{
							sendDataToInsert();
						}
					});
				}
				else
				{
					sendDataToInsert();
				}
			}
		});
	}
	
}

function sendDataToInsert()
{
	var custDob = new Date(document.getElementById('customer_dob').value);
	var dobYear = custDob.getFullYear();
	var nowDate = new Date()
	var nowYear = nowDate.getFullYear();
	var custAge = nowYear - dobYear;
	document.getElementById('customer_age').value =  custAge;
	
	var discountAmount = 0;
	if($('#discount_amount').val() == "" || $('#discount_amount').val() == 0)
	{
		discountAmount = 0;
	}
	else
	{
		discountAmount = $('#discount_amount').val();
	}
	
	var JSONObj = { "userid":document.getElementById("userid").value.trim(),
					"userfirstname":document.getElementById("userfirstname").value.trim(),
					"userlastname":document.getElementById("userlastname").value.trim(),
					"customer_dob":document.getElementById("customer_dob").value.trim(),
					"customer_age":document.getElementById("customer_age").value.trim(),
					"customer_email":document.getElementById("customer_email").value.trim(),
					"customer_status":document.getElementById("customer_status").value.trim(),
					"activeDate_text":document.getElementById("activeDate_text").value.trim(),
					"customer_type":document.getElementById("customer_type").value.trim(),
					"contact_number":document.getElementById("contact_number").value.trim(),
					"zone_id":document.getElementById("zone_id").value.trim(),
					"building_flat_number":document.getElementById("building_flat_number").value.trim(),
					"customer_address":document.getElementById("customer_address").value.trim(),
					"identity_proof":document.getElementById("identity_proof").value.trim(),
					"identity_proof_file":document.getElementById("identity_proof_file").value.trim(),
					"identity_number":document.getElementById("identity_number").value.trim(),
					"date_of_install":$('#date_of_install').val().trim(),
					"switch_power":$('#switch_power').val(),
					"discount_amount":discountAmount,
					"installation_charges":$('#installation_charges').val().trim()
           };
	
	document.getElementById("success_span").innerHTML = '<img src="../images/loader.gif" />';
	$.get('../com/customer.cfc?linkid='+Math.random()+'&method=addUpdateCustomerData&form=' + JSON.stringify(JSONObj),
	function(data){});
	document.getElementById("success_span").innerHTML = '';
	$("#success_span").css('visibility', 'visible');
	$("#success_span").attr('class', 'label label-success');
	var $label = $("<label id='id_label_msg'>").text('Customer data added successfully.');
	$("#success_span").append($label);
}

function validatefields()
{
	if(document.getElementById('userid').value.trim() == "")
	{
		alert("Please enter User Id.");
		document.getElementById('userid').focus();
		document.getElementById('userid').value = "";
		return false;
	}
	
	if(document.getElementById('userid').value.trim() != "")
	{
		var nameRegex = /^[a-zA-Z0-9\_]+$/;
	    var validUserId = document.getElementById('userid').value.match(nameRegex);
	    if(validUserId == null)
	    {
	        alert("User ID is not valid. Only characters A-Z, a-z, 0-9 and '_' are  acceptable.");
	        document.getElementById('userid').focus();
	        return false;
	    }
	}
	
	if (document.getElementById('userfirstname').value.trim() == "")
	{
		alert("Please enter User first name.");
		$('#userfirstname').val('');
		document.getElementById('userfirstname').focus();
		return false;
	}
	
	if (document.getElementById('userlastname').value.trim() == "")
	{
		alert("Please enter User last name.");
		$('#userlastname').val('');
		document.getElementById('userlastname').focus();
		return false;
	}
	
	if (document.getElementById('customer_dob').value.trim() == "")
	{
		alert("Please enter Customer date of birth.");
		document.getElementById('customer_dob').focus();
		return false;
	}
	
	if (document.getElementById('customer_email').value.trim() == "")
	{
		alert("Please enter Email.");
		$('#customer_email').val('');
		document.getElementById('customer_email').focus();
		return false;
	}
	
	if (document.getElementById('customer_email').value.trim() != "")
	{
		
		var nameRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	    var validEmailId = document.getElementById('customer_email').value.match(nameRegex);
	    if(validEmailId == null)
	    {
	        alert("Please enter valid emial id format.");
	        document.getElementById('customer_email').focus();
	        return false;
	    }
	}
	if (document.getElementById('customer_status').value.trim() == "")
	{
		alert("Please enter Customer Status.");
		document.getElementById('customer_status').focus();
		return false;
	}
	if (document.getElementById('activeDate_text').value.trim() == "")
	{
		alert("Please enter Customer Active Date.");
		document.getElementById('activeDate_text').focus();
		return false;
	}
	if (document.getElementById('customer_type').value.trim() == "")
	{
		alert("Please enter Customer Type.");
		document.getElementById('customer_type').focus();
		return false;
	}
	if (document.getElementById('contact_number').value.trim() == "")
	{
		alert("Please enter Mobile number.");
		$('#contact_number').val('');
		document.getElementById('contact_number').focus();
		return false;
	}
	if (document.getElementById('contact_number').value.trim() != "")
	{
		
		if(isNaN(document.getElementById('contact_number').value))
	    {
	        alert("Please enter only numbers.");
	        document.getElementById('contact_number').value = "";
	        document.getElementById('contact_number').focus();
	        return false;
	    }
	    else if(document.getElementById('contact_number').value.length > 10 || document.getElementById('contact_number').value.length < 10)
	    {
	    	alert("Length of mobile number should be 10 only.");
	        document.getElementById('contact_number').focus();
	        return false;
	    }
	}
	if (document.getElementById('zone_id').value.trim() == "")
	{
		alert("Please enter Zone Id.");
		document.getElementById('zone_id').focus();
		return false;
	}
	if (document.getElementById('building_flat_number').value.trim() == "")
	{
		alert("Please enter Building / Flat Number.");
		$('#building_flat_number').val('');
		document.getElementById('building_flat_number').focus();
		return false;
	}
	
	
	if (document.getElementById('customer_address').value.trim() == "")
	{
		alert("Please enter Address.");
		$('#customer_address').val('');
		document.getElementById('customer_address').focus();
		return false;
	}
	
	if($('#date_of_install').val().trim() == "")
	{
		alert("Please select date of installation.");
		$('#date_of_install').focus();
		return false;
	}
	if($('#installation_charges').val().trim() == "")
	{
		alert("Please enter installation charges.");
		$('#installation_charges').focus();
		return false;
	}
	
	if($('#switch_power').val().trim() == "")
	{
		alert("Please select Switch Power Applied.");
		$('#switch_power').focus();
		return false;
	}
	if($('#discount_amount').val().trim() == "" && $('#switch_power').val().trim() == "Y")
	{
		alert("Please enter discount amount.");
		$('#discount_amount').focus();
		return false;
	}
	
	if (document.getElementById('identity_proof').value.trim() != "")
	{
		if (document.getElementById('identity_number').value == "")
		{
			alert("Please enter Identity Number.");
			$('#identity_number').val('');
			document.getElementById('identity_number').focus();
			return false;
		}
		if (document.getElementById('identity_proof_file').value.trim() == "")
		{
			alert("Please attach Identity Proof file.");
			document.getElementById('identity_proof_file').focus();
			return false;
		}
	}
	
	if (document.getElementById('identity_number').value.trim() != "")
	{
		if (document.getElementById('identity_proof').value.trim() == "")
		{
			alert("Please enter Identity Proof.");
			document.getElementById('identity_proof').focus();
			return false;
		}
		if (document.getElementById('identity_proof_file').value.trim() == "")
		{
			alert("Please attach Identity Proof file.");
			document.getElementById('identity_proof_file').focus();
			return false;
		}
	}
	
	if (document.getElementById('identity_proof_file').value.trim() != "")
	{
		
		var fname = document.getElementById('identity_proof_file').value; 
		var re = /(\.jpg|\.jpeg|\.bmp|\.gif|\.png)$/i;
		if(!re.exec(fname))
		{
			alert("File extension not supported, only .jpeg,.png,.bmp accepted!");
			document.getElementById('identity_proof_file').focus();
			return false;
		}
				
		if (document.getElementById('identity_number').value.trim() == "")
		{
			alert("Please enter Identity Number.");
			document.getElementById('identity_number').focus();
			return false;
		}
		if (document.getElementById('identity_proof').value.trim() == "")
		{
			alert("Please enter Identity Proof.");
			document.getElementById('identity_proof').focus();
			return false;
		}		
	}
	return true;
}

function uploadIDProof()
{
   var validateAllFields = validatefields();
	if (validateAllFields)
	{
	   var validatUploadFields = validateUploadIDProof();
	   if(validatUploadFields)
	   {
	   	   var formData = new FormData();
		   formData.append('file', $('input[type=file]')[0].files[0]);
		   
		   var fullFileName = document.getElementById('identity_proof_file').value;
		   var fileName = fullFileName.substr(0, fullFileName.lastIndexOf('.'));
		   if(document.getElementById('userid').value.trim() != fileName)
		   {
		   		alert("Name of identity proof file should be same as customer user id.");
		   		return false;
		   }
		   else
		   {
		   		$.ajax({
			     url: '../admin/uploadAttachment.cfm',
			     type: 'POST',
			     data: formData,
			     async: false,
			     cache: false,
			     contentType: false,
			     enctype: 'multipart/form-data',
			     processData: false,
			     success: function (response) {
			     alert(response);
			     }
			   });
			   return false;
		   }
		   
	   }
	}
}

function validateUploadIDProof()
{
	if (document.getElementById('identity_proof').value.trim() == "")
	{
		alert("Please enter Identity Proof.");
		document.getElementById('identity_proof').focus();
		return false;
	}
	
	if (document.getElementById('identity_number').value.trim() == "")
	{
		alert("Please enter Identity Number.");
		document.getElementById('identity_number').focus();
		return false;
	}
	
	if (document.getElementById('identity_proof_file').value.trim() == "")
	{
		alert("Please attach Identity Proof file.");
		document.getElementById('identity_proof_file').focus();
		return false;
	}
	
	
	if (document.getElementById('identity_proof').value.trim() != "")
	{
		if (document.getElementById('identity_number').value.trim() == "")
		{
			alert("Please enter Identity Number.");
			document.getElementById('identity_number').focus();
			return false;
		}
		if (document.getElementById('identity_proof_file').value.trim() == "")
		{
			alert("Please attach Identity Proof file.");
			document.getElementById('identity_proof_file').focus();
			return false;
		}
	}
	
	if (document.getElementById('identity_number').value.trim() != "")
	{
		if (document.getElementById('identity_proof').value.trim() == "")
		{
			alert("Please enter Identity Proof.");
			document.getElementById('identity_proof').focus();
			return false;
		}
		if (document.getElementById('identity_proof_file').value.trim() == "")
		{
			alert("Please attach Identity Proof file.");
			document.getElementById('identity_proof_file').focus();
			return false;
		}
	}
	
	if (document.getElementById('identity_proof_file').value.trim() != "")
	{
		
		var fname = document.getElementById('identity_proof_file').value.trim(); 
		var re = /(\.jpg|\.jpeg|\.bmp|\.gif|\.png)$/i;
		if(!re.exec(fname))
		{
			alert("File extension not supported, only .jpeg,.png,.bmp accepted!");
			document.getElementById('identity_proof_file').focus();
			return false;
		}
				
		if (document.getElementById('identity_number').value.trim() == "")
		{
			alert("Please enter Identity Number.");
			document.getElementById('identity_number').focus();
			return false;
		}
		if (document.getElementById('identity_proof').value.trim() == "")
		{
			alert("Please enter Identity Proof.");
			document.getElementById('identity_proof').focus();
			return false;
		}		
	}
	return true;
}


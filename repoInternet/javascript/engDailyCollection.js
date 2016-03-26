 $(document).ready(function () {
		  $('#collection_date').datepicker();
		  $("#amount_collected").keypress(function (e) {
         	if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	               return false;
		    }
		   });
		   $('#collected_by').change(function(){
		   	if($('#collected_by').val().trim() != "")
		   	{
		   		$.get('../com/collection.cfc?linkid='+Math.random()+'&method=getZonedAssigned&engineer_id=' + $("#collected_by").val(),
				function(data)
				{
					if($.trim(data) != '')
					{
						$("#assigned_zone").val('Assigned Zone - '+ $.trim(data));
					}
					else
					{
						$("#assigned_zone").val('');
					}
				});	
		   	}
		   	else
		   	{
		   		$('#assigned_zone').val('');
		   	}
		   });
});

function insertCollectionRecord()
{
	var validateFields = validatefields();
	if(validateFields)
	{
		var JSONObj = { "collected_by":$('#collected_by').val(),
						"collection_date":$('#collection_date').val(),
						"amount_collected":$('#amount_collected').val()
	           };
		document.getElementById("success_span").innerHTML = '<img src="../images/loader.gif" />';
		$.get('../com/collection.cfc?linkid='+Math.random()+'&method=insertEngineerCollectionDaily&form=' + JSON.stringify(JSONObj),
		function(data){
		document.getElementById("success_span").innerHTML = '';
		$("#success_span").css('visibility', 'visible');
		$("#success_span").attr('class', 'label label-success');
		var $label = $("<label id='id_label_msg'>").text('Success - Engineer Collection ID: ' + $.trim(data));
		$("#success_span").append($label);
		
		});
		
	}
}
function validatefields()
{
	if($('#collected_by').val().trim() == "")
	{
		alert('Please select Payment Collected by.');
		$('#collected_by').focus();
		return false;
	}
	if($('#collection_date').val().trim() == "")
	{
		alert('Please select collection date.');
		$('#collection_date').focus();
		return false;
	}
	if($('#amount_collected').val().trim() == "")
	{
		alert('Please enter Amount.');
		$('#amount_collected').focus();
		return false;
	}
	return true;
	
}

function resetAllFields()
{
	$('#collected_by').val('');
	$('#collection_date').val('');
	$('#amount_collected').val('');
	$('#assigned_zone').val('');
	$("#success_span").css('visibility', 'hidden');
	$('#collected_by').focus();
}
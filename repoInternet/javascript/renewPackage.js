$(document).ready(function () {
		  $('#package_renew_date').datepicker();
		  $("#userid").autocomplete({ source: "../com/customer.cfc?method=getAllCustomerUserID", select:function(event,ui) { $("#hiddenUID").val(ui.item.hiddenUID); } });
});
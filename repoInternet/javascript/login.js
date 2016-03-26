function submitForm()
{
	if(chk())
	{
		document.getElementById("loginForm").submit();
	}
}

function chk()
{
	var user_id ="";
	var user_password="";
	if (document.getElementById("user_id").value == "")
	{
		alert("Please enter User Id.");
		document.getElementById("user_id").focus();
		return false;
	}
	else if(document.getElementById("user_password").value == "")
	{
		alert("Please enter Password.");
		document.getElementById("user_password").focus();
		return false;
	}
	else if (document.getElementById("user_id").value != "" && document.getElementById("user_password").value != "")
	{
		document.getElementById("loginForm").submit();
		return true;
	}
}
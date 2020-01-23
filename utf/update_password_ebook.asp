<!--#include file="connectdb.asp"-->

<script src="../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">

	var email = "<% response.Write request.Form("email") %>";
	var password = "<% response.Write request.Form("password") %>";
	var new_password = "<% response.Write request.Form("new_password") %>";
	var cnew_password = "<% response.Write request.Form("cnew_password") %>";

	// Step 1 : Call MEB API "userLoginStart"
	//========================================================================
	var jqxhr = $.post("../secure/e-book-onweb/userLoginStart.php?"+Math.random(), { tb_user: email, tb_password: password  } , function(response) {
		
		//========= ฟังชั่นตัดสตริง "}*"
		/*var string_to_search = "}*";
		var found_string_position = response.indexOf(string_to_search);
		response = 	response.substring(0,found_string_position+1);*/
		//========================
	
		var obj = jQuery.parseJSON(response);
		var response_msg = obj.status.message;
		var token = obj.data.token;	
										 
		// Get Response from MEP API	
		switch (response_msg)
		{					
		case 'USERUserLoginStartTokenIsValid!': Change_Pass(token,password,new_password,cnew_password,email); break;
		case 'USERUserLoginStartTokenIsNotValid':  alert("สร้างTokenไม่สำเร็จ");	 break;
		case 'USERUserLoginStartInvalidAppId':  alert("AppId ID ไม่ถูกต้อง");  break;
		case 'USERUserLoginStartDataError':  alert("ข้อมูลผิดพลาด");  break;
		case 'USERUserLoginStartInvalidDeviceName':  alert("Device ID ไม่ถูกต้อง");  break;
		case 'USERUserLoginStartErrorDeviceLimit':  alert("device limit เกิดความผิดพลาด");  break;
		case 'USERUserLoginStartErrorCreateToken':  alert("เกิดความผิดพลากในการสร้างโทเค็น");  break;
		case 'USERUserLoginStartDataPasswordError':  alert("ข้อมูลรหัสผ่านเกิดความผิดพลาด");  break;
		case 'USERUserLoginIncorrectUsernameOrPassword':  alert("User,Pass ไม่ถูกต้อง"); /*history.back();*/ break;
		case 'USERUserLoginStartTokenIsNotValid':  alert("สร้างTokenไม่สำเร็จ");  break;
		case 'USERUserLoginStartUnknownError':  alert("Error อื่นๆ");  break;		
		}

	})				 
	//========================================================================
	//========================================================================
	
	
	function Change_Pass(token,password,new_password,cnew_password,email)
	{

	// Step 1 : Call MEB API "Change Password"
	//========================================================================
	var jqxhr = $.post("../secure/e-book-onweb/changePassword.php?"+Math.random(), {token:token, password:password, new_password:new_password, cnew_password:cnew_password } , function(response) {

		//========= ฟังชั่นตัดสตริง "}*"
		/*var string_to_search = "}*";
		var found_string_position = response.indexOf(string_to_search);
		response = 	response.substring(0,found_string_position+1);*/
		//============================
		
		var obj = jQuery.parseJSON(response);
		var response_msg = obj.status.message;	
							 
		// Get Response from MEP API	
		switch (response_msg)
		{					
			case 'USERChangePassChangePasswordSuccess': update_cubook(token,password,new_password,cnew_password,email); break;
			case 'USERChangePassDataError': alert("ข้อมูลผิดพลาด"); break;
			case 'USERChangePassWrongConfirmPass':  alert("Conferm Password ไม่ตรงกับ Pass");  break;
			case 'USERChangePassIncorrectOldPassword':  alert("Password เก่าไม่ถูกต้อง"); break;
			case 'USERChangePassInvalidToken':   alert("โทเค็นไม่ถูกต้อง"); break;
			case 'USERChangePassUnknownError':  alert("Change Password Error"); break;
		}
						
	})	
	
	}
	
	
	function update_cubook(token,tb_Opassword,tb_Npassword,tb_Cpassword,email)
	{
		//alert(email);
		// Step 2 : send data to chulabook
		var jqxhr = $.post("../secure/e-book-onweb/Update_Password.php?"+Math.random(), { token:token ,tb_Opassword:tb_Opassword,tb_Npassword:tb_Npassword,tb_Cpassword:tb_Cpassword,tb_email:email  } , function(response) {				
			 	
			//alert(response);												
			if(response == 1)
			{
				//alert("update_cubook สำเร็จ");	
				window.location = '../final_password.asp';
			}else
			{
				alert("update_cubook ไม่สำเร็จ");	
				history.back();
			}
				
	
		})
		
	}	
	
	
</script>

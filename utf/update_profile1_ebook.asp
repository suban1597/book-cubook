
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!--#include file="connectdb.asp"-->
<%
Sql = "SELECT Pword FROM account WHERE (UserID ='" & Session("UserID") & "')"
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3
%>

<script src="../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">

	<%
	Function ChkFmt(vars)
		'Dim newvars as char
		If len(vars) < 2 then
			newvars = "0" & vars
		else
			newvars = vars
		end if
		ChkFmt = newvars
	End function

	bd1= trim(request.Form("bd1"))
	bd2= trim(request.Form("bd2"))
	bd3= trim(request.Form("bd3"))
	birthday = bd1 & ChkFmt(bd2) & bd3	
	%>
	
	var password = "<%=trim(RS("Pword"))%>";
	var email = "<% response.Write request.Form("tb_email") %>";	
	var birthday = "<% response.Write(birthday) %>";
	var bname = "<% response.Write request.Form("tb_bname") %>";
	var gender = "<% response.Write request.Form("sl_gender") %>";
		
	// Step 1 : Call MEB API "userLoginStart"
	//========================================================================
	var jqxhr = $.post("../secure/e-book-onweb/userLoginStart.php?"+Math.random(), { tb_user: email, tb_password: password  } , function(response) {
		
		//========= ฟังชั่นตัดสตริง "}*"
		/*var string_to_search = "}*";
		var found_string_position = response.indexOf(string_to_search);
		response = 	response.substring(0,found_string_position+1);*/
		//==========================


		var obj = jQuery.parseJSON(response);
		var response_msg = obj.status.message;
		var token = obj.data.token;	
										 
		// Get Response from MEP API	
		switch (response_msg)
		{					
			case 'USERUserLoginStartTokenIsValid!': getUserInfo(token); break;
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


	function getUserInfo(token)
	{

		// Step 2 : Call MEB API "getUserInfo"
		//========================================================================		
		var jqxhr = $.post("../secure/e-book-onweb/getUserInfo.php?"+Math.random(), { token: token } , function(response) {
		
			//alert(response);
			
			//========= ฟังชั่นตัดสตริง "}*"		
			/*var string_to_search = "}*";
			var found_string_position = response.indexOf(string_to_search);
			response = 	response.substring(0,found_string_position+1);*/
			//=====================
	
			var obj = jQuery.parseJSON(response);
			var response_msg = obj.status.message;
//			var response_username = obj.data.username;		 
//			var response_firstname = obj.data.firstname;	
//			var response_lastname = obj.data.lastname;	
//			var response_gender = obj.data.gender;	
//			var response_birthday = obj.data.birthday;	
						 
			//alert(response_msg);	
								 
			// Get Response from MEP API	
			switch (response_msg)
			{
				case 'USERGetUserInfoDataError': alert("ข้อมูลเกิดความผิดพลาด");  break;
				case 'USERGetUserInfoTokenError':  alert("โทเค็นไม่ถูกต้อง");  break;
				case 'USERGetUserInfoSuccess':  update_profile(token); break;
				case 'USERGetUserInfoUnknownError': alert("เกิดข้อผิดพลาดบางประการ"); break;			  						  
			}
		})
		//========================================================================
		//========================================================================
	}
	
	
	function update_profile(token)
	{

		var tb_bname = "<% response.Write request.Form("tb_bname") %>";		
		var bd1 = "<% response.Write trim(request.Form("bd1")) %>";		
		var bd2 = "<% response.Write trim(request.Form("bd2")) %>";	
		var bd3 = "<% response.Write trim(request.Form("bd3")) %>";		
		var bplace = "<% response.Write request.Form("bplace") %>";		
		var bnum = "<% response.Write request.Form("bnum") %>";
		var bmoo = "<% response.Write request.Form("bmoo") %>";
		var bbuilding = "<% response.Write request.Form("bbuilding") %>";
		var bsoi = "<% response.Write request.Form("bsoi") %>";
		var broad = "<% response.Write request.Form("broad") %>";
		var btumbon = "<% response.Write request.Form("btumbon") %>";
		var bcity = "<% response.Write request.Form("bcity") %>";
		var binter = "<% response.Write request.Form("binterprovince") %>";
		var bprovince = "<% response.Write request.Form("bprovinceth") %>";
		var bcountry = "<% response.Write request.Form("bcountry") %>";
		var bzip = "<% response.Write request.Form("bzip") %>";	
		var bphone = "<% response.Write request.Form("bphone") %>";		
		
		var tb_sname = "<% response.Write request.Form("tb_sname") %>";
		var splace = "<% response.Write request.Form("splace") %>";
		var snum = "<% response.Write request.Form("snum") %>";
		var smoo = "<% response.Write request.Form("smoo") %>";
		
		var sbuilding = "<% response.Write request.Form("sbuilding") %>";
		var ssoi = "<% response.Write request.Form("ssoi") %>";
		var sroad = "<% response.Write request.Form("sroad") %>";
		var stumbon = "<% response.Write request.Form("stumbon") %>";
		
		var scity = "<% response.Write request.Form("scity") %>";
		var sinter = "<% response.Write request.Form("sinterprovince") %>";	
		var sprovince = "<% response.Write request.Form("sprovinceth") %>";		
		
		var scountry = "<% response.Write request.Form("scountry") %>";
		var szip = "<% response.Write request.Form("szip") %>";	
		var sphone = "<% response.Write request.Form("sphone") %>";		
		
		tb_bdcumeb =  bd3+"-"+bd1+"-"+bd2;    //1985-03-17
		
		//alert(tb_bdcumeb);
		
		var search_string = " ";
		var found_string_position = tb_bname.indexOf(search_string);
		tb_firstname = 	tb_bname.substring(0,found_string_position);
		tb_lastname = tb_bname.substring(found_string_position+1,tb_bname.length );
		
//				alert(token);
//				alert(email);
//				alert(tb_firstname);
//				alert(tb_lastname);
//				alert(gender);
//				alert(tb_bdcumeb);		
		
	
		// Step 3 : edit profile to chulabook
		//========================================================================
	    var jqxhr = $.post("update_profile_ebook.asp?"+Math.random(), {tb_bname:tb_bname, bd1:bd1, bd2:bd2, bd3:bd3, sl_gender:gender, bplace:bplace, bnum:bnum, bmoo:bmoo, bbuilding:bbuilding, bsoi:bsoi, broad:broad, btumbon:btumbon, bcity:bcity, binter:binter, bprovince:bprovince, bcountry:bcountry, bzip:bzip, bphone:bphone, tb_sname:tb_sname, splace:splace, snum:snum, smoo:smoo, sbuilding:sbuilding, ssoi:ssoi, sroad:sroad, stumbon:stumbon, scity:scity, sinter:sinter, sprovince:sprovince, scountry:scountry, szip:szip, sphone:sphone} , function(response){	
		
		//alert(response);
											 											 							
			if(response == 1)
			{

			
				setUserInfo(token,email,tb_firstname,tb_lastname,gender,tb_bdcumeb);	
				//alert("สำเร็จ");							
			}else
			{
				//$("#response").html("Password ไม่ถูกต้อง");
				alert("ไม่สำเร็จ");
			}

		})
		//========================================================================		
		//========================================================================
	}
	
	
	function setUserInfo(token,email,tb_firstname,tb_lastname,gender,tb_bdcumeb)
	{
	
		var jqxhr = $.post("../secure/e-book-onweb/setUserInfo.php?"+Math.random(), { token:token, tb_email:email, tb_firstname:tb_firstname, tb_lastname:tb_lastname, tb_gender:gender, tb_bdcumeb:tb_bdcumeb} , function(response) {	
		
			//alert(response);				 
			
			//========= ฟังชั่นตัดสตริง "}*"
			/*var string_to_search = "}*";
			var found_string_position = response.indexOf(string_to_search);
			response = 	response.substring(0,found_string_position+1);*/
			//==========================

			var obj = jQuery.parseJSON(response);
			var response_msg = obj.status.message;		
			
			//alert(response);	
			//alert(response_msg);							
										 					
			// Get Response from MEP API	
			switch (response_msg)
			{
				case 'USERSetUserInfoSuccessfulToSetUser': alert("ลงข้อมูลสำเร็จ"); /*$("#response").html("ลงข้อมูลสำเร็จ");*/ Successful(); break;
				case 'USERSetUserInfoDataError':  $("#response").html("ข้อมูลผิดพลาด"); submit_show(); break;
				case 'USERSetUserInfoDataErrorEmail':  $("#response").html("Email ผิดพลาด"); submit_show(); break;
				case 'USERSetUserInfoDataErrorFirstname':  $("#response").html("Firstname ผิดพลาด"); submit_show(); break;
				case 'USERSetUserInfoDataErrorLastname':  $("#response").html("Lastname ผิดพลาด"); submit_show(); break;
				case 'USERSetUserInfoDataErrorGender':  $("#response").html("Gender ผิดพลาด"); submit_show(); break;
				case 'USERSetUserInfoDataErrorBirthday':  $("#response").html("Birthday ผิดพลาด"); submit_show(); break;
				case 'USERSetUserInfoDataErrorToken':  $("#response").html("ข้อมูลโทเค็นผิดพลาด"); submit_show(); break;
				case 'USERSetUserInfoTokenError':  $("#response").html("โทเค็นผิดพลาด"); submit_show(); break;
				case 'USERCreUserAlreadyHaveUser':  $("#response").html("มีชื่อผู้ใช้นี่แล้ว"); submit_show(); break;
				case 'USERSetUserInfoUnknownError':  $("#response").html("อื่นๆ"); submit_show(); break;		  						  
			}

		})	
	
	}
	
	
	function Successful()
	{
		window.location = '../profile.asp';	
	}
	
	
	
</script>


<title>Untitled Document</title>
</head>

<body>
กรุณารอสักครู่ระบบกำลังทำการประมวลผล 
</body>
</html>

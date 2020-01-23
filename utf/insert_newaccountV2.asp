<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<!--#include file="connectdb.asp"-->
<!--#include file="../includes/sqlinjection.asp"-->
<%
			email=trim(request.form("tb_email"))	
			password=trim(request.form("tb_password"))
			cpassword=trim(request.form("tb_confirmpassword"))
			
			bname= request.Form("tb_bname")
			bd1 = request.Form("bd1")
			bd2 = request.Form("bd2")
			bd3 = request.Form("bd3")			
			birthday = bd1 & bd2 & bd3			
			gender = request.Form("sl_gender")

			registerdate = now()
				
			bplace=request.form("bplace")
			bnum=request.form("bnum")
			bmoo=request.form("bmoo")
			bzip= request.Form("bzip")
			bbuilding= request.Form("bbuilding")
			bsoi= request.Form("bsoi")
			broad= request.Form("broad")
			btumbon= request.Form("btumbon")
			bcity= request.Form("bcity")
			bprovinceth= request.Form("bprovinceth")
			bcountry= request.Form("bcountry")
			bzip= request.Form("bzip")
			bphone= request.Form("bphone")
			
			baddress=bplace & " เลขที่ " & bnum & " " & "หมู่" & " " & bmoo & " " & bbuilding & " " & "ซอย"  & " " & bsoi & " " & "ถนน" & " " & broad & " " & "ต./เขต" & btumbon 

			sname=request.Form("tb_Sname")
			splace=request.form("splace")
			snum=request.form("snum")
			smoo=request.form("smoo")
			szip= request.Form("szip")
			sbuilding= request.Form("sbuilding")
			ssoi= request.Form("ssoi")
			sroad= request.Form("sroad")
			stumbon= request.Form("stumbon")
			scity= request.Form("scity")
			sprovinceth= request.Form("sprovinceth")
			scountry= request.Form("scountry")
			szip= request.Form("szip")
			sphone= request.Form("sphone")
			
			saddress=splace & " เลขที่ " & snum & " " & "หมู่" & " " & smoo & " " & sbuilding & " " & "ซอย"  & " " & ssoi & " " & "ถนน" & " " & sroad & " " & "ต./เขต" & stumbon 
			
			information = request.Form("information")
			statusupdate = 1
			
			 'step1 ) Check Email
				
			sql_account="select Email from account where email = '"&email&"'"
			set rs=Server.CreateObject("ADODB.Recordset")
			rs.open sql_account ,conn,1,3
		
			If Not RS.EOF then

						Response.Redirect ("../register.asp?Return=อีเมล์นี้เคยลงทะเบียนแล้ว")

       		 Else		 
				 'step2 ) Check Password
				 		If Not  password=cpassword then							
						Response.Redirect("../register.asp?Returnpassword=การยืนยันรหัสผ่านของคุณไม่ถูกต้องค่ะ")
		   	Else
		
				'step3 )  Find MaxUserid				
				    sql_max="SELECT max(Userid) as MaxUserID FROM Account " 
					Set RS=Server.CreateObject("ADODB.RecordSet")
					RS.Open sql_max, Conn, 1, 3
			
					if not rs.eof then
						userid= (Rs("MaxuserID"))+1
					End if	
				 
					response.write  "<input type=hidden  name=""Userid"" value=" & MaxUserID  & ">"

				    'step4 ) Insert "Account" Table
				 	    Set RSadd=Server.CreateObject("ADODB.RecordSet")
				    	RSadd.Open " SELECT * From Account " , Conn, 1, 3
						RSadd.AddNew
						RSadd("Userid")= UserId
						RSadd("Bname")= bname
						RSadd("Baddress")= baddress
						RSadd("bplace")= bplace
						RSadd("Bnum")= bnum
						RSadd("Bmoo")= bmoo
						RSadd("Bbuilding")= bbuilding
						RSadd("Bsoi")= bsoi
						RSadd("Broad")= broad
						RSadd("Btumbon")= btumbon
						RSadd("BCity")= bcity
						RSadd("Bprovince")= bprovinceth
						RSadd("Bzip")= bzip
						RSadd("Bcountry")= bcountry
						RSadd("Bphone")= bphone
						RSadd("Email")= email 
						RSadd("Birthday")= birthday
						RSadd("AddressIndex")= " "
						RSadd("Pword")= password
						RSadd("PwordHint")= pwordhint
						RSadd("Sname")= sname
						RSadd("Saddress")= saddress
						RSadd("splace")= splace
						RSadd("Snum")= Snum
						RSadd("Smoo")= Smoo
						RSadd("Sbuilding")= sbuilding
						RSadd("Ssoi")= ssoi
						RSadd("Sroad")= sroad
						RSadd("Stumbon")= stumbon
						RSadd("Scity")= scity
						RSadd("Sprovince")= sprovinceth
						RSadd("Szip")= szip
						RSadd("SCountry")= scountry
						RSadd("Sphone")= sphone
						RSadd("SInterprovince")= sinterprovince
						RSadd("SEmail")= " "
						RSadd("MemberID")= " "
						RSadd("Registerdate")= registerdate
						RSadd("Accountstatus")= " "
						RSadd("Currency")= " "
						RSadd("Library")= " "
						RSadd("Gender")= gender
						RSadd("Information")=  information
						RSadd("statusupdate")=  statusupdate
						
						RSadd.Update
				  
				  ' Send Mail   
				  Subject = "Welcome To Chulabook.com"
				  Tomail = request.Form("tb_email")
				  FromMail= "webmaster@cubook.chula.ac.th"
				  
				  Body = Body & "ยินดีต้อนรับยินดีต้อนรับสู่ www.chulabook.com" + VBCrlf
				  Body = Body & "email ของท่านที่ใช้ใน login คือ" & email + VBCrlf
				  Body = Body & "password ของท่านที่ใช้ใน login คือ" & password + VBCrlf
				  Body = Body & "From Webmaster@cubook.chula.ac.th"				
				  
				  'Set   MyCDONTSMail = CreateObject("CDONTS.NewMail")
				   Set ObjMail=Server.CreateObject("CDO.Message")
				   			ObjMail.From = FromMail
							ObjMail.To =Tomail
							ObjMail.Subject = Subject
							ObjMail.TextBody = Body
								objMail.Configuration.Fields.Item _
								("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
								'Name or IP of remote SMTP server
								objMail.Configuration.Fields.Item _
								("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
								'Server port
								objMail.Configuration.Fields.Item _
								("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
								objMail.Configuration.Fields.Update
							ObjMail.Send
					Set	ObjMail = nothing 
				  
				   	Session("LOGON_Status") = Userid
				    Session("Userid")=Userid
					Session("Email")=Email
                    Session("Password")=Password
					Session("Bname")=Bname
					'response.Redirect("../shopping.asp")						
					
%>					 
					 
<script src="../js/jquery-1.7.2.min.js"></script>
<script src="../js/validate/jquery.validate.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
		// $.ajaxSetup({ cache: false });	
		
		var tb_user;
		var tb_password;
		var tb_password_c;
		var tb_firstname;
		var tb_lastname;	
		var tb_gender;	
		var tb_birthday;	
		var tb_name;	
		
		tb_user = "<% response.Write(email)%>";
		tb_password = "<% response.Write(password)%>";
		tb_password_c = "<% response.Write(cpassword)%>";
		tb_name = "<% response.Write(bname)%>";		
		tb_gender = "<% response.Write(gender)%>";		
		tb_birthday = "<% 'response.Write(bd3&"-"&bd1&"-"&bd1)%>";
		//tb_birthday = "<% response.Write(bd2&"-"&bd1&"-"&bd3)%>";
		
		var string_to_search = " ";	
		var found_string_position = tb_name.indexOf(string_to_search);	
		tb_firstname =  tb_name.substring(0,found_string_position);		
		tb_lastname = 	tb_name.substring(found_string_position+1);		
					
//		alert(tb_user);		
//		alert(tb_password);	
//		alert(tb_password_c);	
//		alert(tb_firstname);	
//		alert(tb_lastname);		
//		alert(tb_gender);	
//		alert(tb_birthday);		
		$("#response").html("ระบบกำลังทำการบันทึกข้อมูล กรุณารอซักครู่");	

		// Step 1 : Call MEB API "Create User"
		var jqxhr = $.post("../secure/e-book/CallAPI_CreateUser.php?"+Math.random(), { tb_user: tb_user, tb_password: tb_password ,tb_firstname:tb_firstname, tb_lastname:tb_lastname, tb_gender:tb_gender, tb_bd:tb_birthday} , function(response) {
						
			//========= ฟังชั่นตัดสตริง "}*"
			/*var string_to_search = "}*";
			var found_string_position = response.indexOf(string_to_search);
			response = 	response.substring(0,found_string_position+1);*/
			//========================
	
			var obj = jQuery.parseJSON(response);
			var response_msg = obj.status.message;
			// Get Response from MEP API
			
			$("#response").html("ระบบกำลังทำการบันทึกข้อมูล กรุณารอซักครู่");	
			
			switch (response_msg)
			{				
				case 'USERCreUserSuccessfulToCreateUser':  create_user(); break;
				case 'USERCreUserAlreadyHaveUser': alert("มี User นี้แล้ว"); callBack(); break;
				case 'USERCreUserAlreadyHaveEmail': alert("มี email นี้แล้ว"); callBack(); break;
				case 'USERCreUserInvalidEmail': alert("อีเมล์ไม่ถูกต้อง"); callBack(); break;
				case 'USERCreUserUnknownError': alert("สร้าง User ไม่สำเร็จ"); callBack(); break;
				case 'USERCreUserInvalidUsername': alert("ข้อมูลอินพุท username รูปแบบไม่ถูกต้อง"); callBack(); break;
				case 'USERCreUserInvalidPassword': alert("ข้อมูลอินพุท password รูปแบบไม่ถูกต้อง"); callBack(); break;
				case 'USERCreUserInvalidFacebookId': alert("FacebookId ไม่ถูกต้อง"); callBack(); break;
				case 'USERCreUserInvalidFirstname': alert("ข้อมูลอินพุท firstname รูปแบบไม่ถูกต้อง"); callBack(); break;
				case 'USERCreUserInvalidGender': alert("ข้อมูลอินพุท gender รูปแบบไม่ถูกต้อง"); callBack(); break;
				case 'USERCreUserInvalidEmail': alert("ข้อมูลอินพุท email รูปแบบไม่ถูกต้อง"); callBack(); break;
				case 'USERCreUserInvalidLastname': alert("ข้อมูลอินพุท lastname รูปแบบไม่ถูกต้อง"); callBack(); break;						   
				case 'USERCreUserInvalidBirthday': alert("ข้อมูลอินพุท birthday รูปแบบไม่ถูกต้อง"); callBack(); break; 							  
			}			
																		
		});	
		
		
		function callBack()
		{
			window.history.back();
		}
		
		function create_user()
		{
			window.location = '../shopping.asp';
		}		
		
	});
</script>					 

<table width="320" align="center" border="0" >
   <tr>
      <td height="25" colspan="2"></td>
  </tr>  
   <tr>
      <td colspan="2"><div class="controls">
         <div id="loading_area" style="display:none" align="center">Loading... <img src="../secure/e-book/loading.gif" > </div>
      </div></td>
   </tr>             
   <tr>
      <td><!--p align="center">Chulabook Cyber Team 2012</p-->
          <div id="response" align="center">ระบบกำลังทำการบันทึกข้อมูล กรุณารอซักครู่</div>
          <p align="center"><img src="http://www.chulabook.com/images/loading_chebook.gif" ></p>
      </td>
    </tr>
</table>
	
<%				
		End if	
	End if
%>
</body>
</html>

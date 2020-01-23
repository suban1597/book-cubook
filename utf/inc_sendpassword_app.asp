<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/main.css" rel="stylesheet" type="text/css" />
<!--#include file="connect_db.asp"-->
</head>

<body>
<%
	
	If not request.form("email") <> "" Then
			email =   request.QueryString("email") 
	Else
			email =   request.Form("email") 		
	End If 

	'response.Write email&"<br>"

	'step1 ) Selecy Account Information
	 		
				sql = "SELECT Email, Pword, Bname FROM Account  WHERE Email like '" & email & "'  "
				Set RS = Server.CreateObject("ADODB.RecordSet")
				Rs.Open Sql,Conn,1,3

				If Rs.EOF = true Then 
				response.Write Email
				Else

				password = Rs("Pword")			
				'response.Write Email

Cfrom="webmaster@cubook.chula.ac.th"
Cto=Email
'Cto="jane_113_@hotmail.com"

Csubject="รหัสผ่านของคุณในการเข้าสู่ระบบของ www.chulabook.com"

Cbody = Cbody  + "เรียน   คุณ "&Rs("Bname")&""+Chr(13)+Chr(10)
Cbody = Cbody  + "รหัสผ่านของท่านที่ใช้ในการเข้าสู่ระบบ คือ "&Rs("Pword")&""+Chr(13)+Chr(10)
Cbody = Cbody  + "หากท่านต้องการเปลี่ยนแปลงรหัสผ่าน ท่านสามารถเปลี่ยนรหัสได้ โดยคลิกที่ เข้าสู่ระบบ แล้วคลิกเลือก เปลี่ยนรหัสผ่าน ได้เลยค่ะ"+Chr(13)+Chr(10)
Cbody = Cbody  + "หากท่านมีข้อสงสัยประการใดหรือต้องการสอบถามข้อมูลเพิ่มเติม กรุณาติดต่อฝ่ายบริการลูกค้า"+Chr(13)+Chr(10)
Cbody = Cbody  + "อีเมล์ : webmaster@cubook.chula.ac.th"+Chr(13)+Chr(10)
Cbody = Cbody  + "โทรศัพท์ : 0-2218-9891 "+Chr(13)+Chr(10)
Cbody = Cbody  + "โทรสาร : 0-2255-4441"+Chr(13)+Chr(10)
Cbody = Cbody  + "วันทำการ : จันทร์ – ศุกร์   เวลา 9.00 - 17.00 น. "+Chr(13)+Chr(10)

Cbody = Cbody  + "ขอแสดงความนับถือ"+Chr(13)+Chr(10)
Cbody = Cbody  + "แผนกบริการลูกค้า "+Chr(13)+Chr(10)
Cbody = Cbody  + "ศูนย์หนังสือแห่งจุฬาลงกรณ์มหาวิทยาลัย"+Chr(13)+Chr(10)
Cbody = Cbody  + "วันทำการ : จันทร์ – ศุกร์   เวลา 9.00 - 18.00 น. "+Chr(13)+Chr(10)

Set myMail=Server.CreateObject("CDO.Message")
	myMail.From = Cfrom
	myMail.To = Cto
	myMail.BCC = Cbcc
	myMail.Subject = Csubject
	myMail.TextBody = Cbody
		 objMail.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
		'Name or IP of remote SMTP server
		objMail.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
		'Server port
		objMail.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
		objMail.Configuration.Fields.Update
	myMail.Send
Set myMail= Nothing

response.Redirect("https://secure.chulabook.com/e-book/inc_sendpassword_app.asp?success=true")
   
%>

</body>
</html>
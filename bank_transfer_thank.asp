<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="../utf/connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<head> 
	<title>Chulabook.com mobile ยืนยันการแจ้งผลการโอนเงิน</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body>
<!--#include file="inc_tabbar.asp"--> 

<% 
Fname = request.Form("name")
Lname = request.Form("lastname")
email = request.Form("email")
phone = request.Form("phone")
TrackNo = request.Form("TrackingNumber")
amount = request.Form("amount")
frombank = request.Form("frombank")
branch = request.Form("branch")
tobank = request.Form("rd_bank")
TransferDate = request.form("finaldatetime")
remarks = request.Form("remark")
postdate = now()
method = request.Form("R_transfer_method")
UpdateTime = now()
OrderOK = " "
AmountUsed = 0
Deposit = 0
PrintNo = " "
Status_see = 0
Enable = " "
delete_status = 0
%>
<%
Dim RS
Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Open " select TrackNo from banktransfer where TrackNo = '"&TrackNo&"' ", Conn, 1, 3
If Rs.eof Then
%>

<% 'Insert to Banktransfer

'for each item in request.form
	'response.write item & " : " & request.form(item) & "<br>"	
'next
'response.end

sql= "INSERT into banktransfer Values ('"&Fname&"','"&Lname&"','"&email&"','"&phone&"','"&TrackNo&"','"&amount&"','"&frombank&"','"&branch&"','"&tobank&"','"&TransferDate&"','"&remarks&"','"&OrderOK&"','"&UpdateTime&"','"&AmountUsed&"','"&Deposit&"','"&PrintNo&"','"&Status_see&"','"&Enable&"','"&postdate&"','"&method&"','"&delete_status&"')"

Conn.execute(sql)	
%>
<% 
Cfrom="info@cubook.chula.ac.th"
Cto=email
Csubject="ยืนยันการแจ้งผลการโอนเงิน จาก www.chulabook.com ค่ะ"

Cbody = Cbody  + "เรียน   คุณ "&Fname&""+Chr(13)+Chr(10)
Cbody = Cbody  + "ท่านได้ทำการแจ้งผลการโอนเงินกับทางเราเรียบร้อยแล้วนะคะ"+Chr(13)+Chr(10)
Cbody = Cbody  + "หมายเลขอ้างอิงการสั่งซื้อ คือ "& TrackNo &""+Chr(13)+Chr(10)
Cbody = Cbody  + "ยอดเงินที่ท่านโอน คือ "& amount &""+Chr(13)+Chr(10)
Cbody = Cbody  + "วิธีการโอนเงินคือ  "& method &""+Chr(13)+Chr(10)
Cbody = Cbody  + "โอนจากธนาคาร  "& frombank &""+Chr(13)+Chr(10)
Cbody = Cbody  + "โอนเข้าธนาคาร  "& tobank &""+Chr(13)+Chr(10)
Cbody = Cbody  + "ขอขอบพระคุณที่ใช้บริการกับศูนย์หนังสือจุฬาฯ นะคะ หากท่านมีข้อสงสัยประการใดหรือต้องการสอบถามข้อมูลเพิ่มเติม กรุณาติดต่อฝ่ายบริการลูกค้า"+Chr(13)+Chr(10)
Cbody = Cbody  + "แผนกบริการลูกค้า "+Chr(13)+Chr(10)
Cbody = Cbody  + "อีเมล์ : info@cubook.chula.ac.th"+Chr(13)+Chr(10)
Cbody = Cbody  + "โทรศัพท์ : 0-2218-9891 , 0-2255-4433 "+Chr(13)+Chr(10)
Cbody = Cbody  + "โทรสาร : 0-2255-4441"+Chr(13)+Chr(10)
Cbody = Cbody  + "วันจันทร์ - วันศุกร์   9.00 - 18.00 น. และ วันเสาร์ 9.00 - 14.00 น. หยุดวันอาทิตย์และวันหยุดนักขัตฤกษ์"+Chr(13)+Chr(10)


Set myMail=Server.CreateObject("CDO.Message")
	myMail.BodyPart.Charset = "UTF-8"
	myMail.From = Cfrom
	myMail.To = Cto
	myMail.Subject = Csubject
	myMail.TextBody = Cbody
	myMail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	'Name or IP of remote SMTP server
	myMail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
	'Server port
	myMail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
	myMail.Configuration.Fields.Update
	myMail.Send
Set myMail= Nothing

response.Redirect("banktransfer-complete.asp")

Else
response.Redirect("banktransfer-noncomplete.asp")
End If
%>

	<!--#include file="inc_footer.asp"-->
</body>
</html>
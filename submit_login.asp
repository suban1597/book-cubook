<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!--#include file="../utf/connectdb.asp"-->
	<title>เข้าสู่ระบบ</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 

<!-- header -->
		<h1>Chulabook.com</h1>
<!-- /header -->

<!-- content --> 
<%
username = request("username")
password = request("password")

response.write "username: " & username & "<br>"
response.write "password: " & password & "<br>"
Response.Buffer=True
Session.Timeout=20

	    username = request.form("username")
		password = request.form("password")
		
If username = "" Then
response.Redirect("loginfall.asp")
End If

If password = "" Then
response.Redirect("loginfall.asp")
End If



	'---------- Gen ID_Admin ------------

	Day_now = Day(Now())
	 'Response.write Day_now&"<br>"
	 Month_now = Month(Now())
	 'Response.write Month_now&"<br>"
	 Year_now = Year(Now())
	 'Response.write Year_now&"<br>"

	around1_now = Day(Now()-1)
	 'Response.write around1_now&"<br>"


	if Day_now="1" then
      con_Day_now = "01"
    else if Day_now="2" then
      con_Day_now = "02"
    else if Day_now="3" then
      con_Day_now = "03"
    else if Day_now="4" then
      con_Day_now = "04"
    else if Day_now="5" then
      con_Day_now = "05"
    else if Day_now="6" then
      con_Day_now = "06"
    else if Day_now="7" then
      con_Day_now = "07"
    else if Day_now="8" then
      con_Day_now = "08"
    else if Day_now="9" then
      con_Day_now = "09"
    else con_Day_now = Day_now
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if

    if Month_now="1" then
      con_Month_now = "01"
    else if Month_now="2" then
      con_Month_now = "02"
    else if Month_now="3" then
      con_Month_now = "03"
    else if Month_now="4" then
      con_Month_now = "04"
    else if Month_now="5" then
      con_Month_now = "05"
    else if Month_now="6" then
      con_Month_now = "06"
    else if Month_now="7" then
      con_Month_now = "07"
    else if Month_now="8" then
      con_Month_now = "08"
    else if Month_now="9" then
      con_Month_now = "09"
    else con_Month_now = Month_now
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    end if
    
   	date_now = Year_now&""&con_Month_now&""&con_Day_now

  Set RS1 = Server.CreateObject("ADODB.RecordSet")
	Sql1 = "SELECT TOP (1) EmployeeID FROM Admin_Service_job WHERE (Status = 1) AND (End_date >= '" & date_now & "' ) ORDER BY End_date"
	RS1.Open Sql1,conn,1,3

    If RS1.EOF then
      Response.Redirect ("loginfall.asp")
    Else 
    	Set RS2 = Server.CreateObject("ADODB.RecordSet")
    	Sql2 = "SELECT TOP (1) EmployeeID FROM Admin_Service_job WHERE (EmployeeID <> '" & RS1("EmployeeID") & "' ) AND (Status = 1) ORDER BY NEWID()"
    	RS2.Open Sql2,conn,1,3
    	'---------- END GenID_Admin ------------

      Set RS = Server.CreateObject("ADODB.RecordSet")
      Sql = "SELECT  * FROM account WHERE (Email like '" & username & "')"
      RS.Open Sql,conn,1,3
      If RS.EOF then
      Response.Redirect ("loginfall.asp")
      Else 
      	If NOT (lcase(password) = trim(lcase(RS("pword")))) then
      	Response.Redirect ("loginfall.asp")
      	Else
      	Session("LOGON_Status") = RS("Userid")
      	Session("UserID") = RS("Userid")
      	Session("Bname") = RS("Bname")
      	Session("Email") = RS("Email")
      	Session("SProvince") =  RS("SProvince")
      	Session("webboardadmin") =  RS("webboardadmin")
      	Session("EmployeeID") =  RS2("EmployeeID") 'GenID_Admin
      '	
      '	
      '	if session("returnurl")  <> "" then
      '	returnurl = session("returnurl")
      '	session("returnurl") = ""
      '	Response.Redirect returnurl 		
      	'		else
      						Response.Redirect "index.asp"
      		'	end if

      	End If
      End If
    End If
Conn.Close
Set RS=Nothing

%>
<!-- /content -->

<!-- /footer --> 
<!--#include file="inc_footer.asp"-->
<!-- /footer -->
</body>
</html>
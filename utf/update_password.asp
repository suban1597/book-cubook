<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<!--#include file="connectdb.asp"-->
<%
	email = request.Form("email")
	password = request.Form("password")
	new_password = request.Form("new_password")
	cnew_password = request.Form("cnew_password")
	 'step1 ) Select Account Information				
				
				sql = "SELECT Userid, Bname, Pword, Email FROM Account  WHERE email like '" & email & "'  "
				Set RS = Server.CreateObject("ADODB.RecordSet")
				Rs.Open Sql,Conn,1,3
				
				
				Session("userid") = Rs("userid")
				bname = Rs("bname")
				password = Rs("pword")
				If Rs.eof Then
				err_text =  "ไม่มีข้อมูลค่ะ"
				Else 
				 sql_add = "Update account set "				 				
			     sql_add = sql_add &  " pword=  '" & new_password & "'  " 					 
				 sql_add = sql_add &  " where userid= "& Session("userid")  	
				  				  
				  Set rs_add=Server.CreateObject("ADODB.Recordset")
				  Conn.execute (sql_add)		
				  End If
				  response.Redirect "../final_password.asp"
   
%>
</body>
</html>

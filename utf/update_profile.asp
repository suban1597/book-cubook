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
Function ChkFmt(vars)
	'Dim newvars as char
	If len(vars) < 2 then
		newvars = "0" & vars
	else
		newvars = vars
	end if
	ChkFmt = newvars
End function


	bname= request.Form("tb_bname")
	bd1= trim(request.Form("bd1"))
	bd2= trim(request.Form("bd2"))
	bd3= trim(request.Form("bd3"))
	birthday = bd1 & ChkFmt(bd2) & bd3
	gender= request.Form("sl_gender")
	information= request.Form("information")
	
	bplace = request.Form("bplace")
	bnum = request.Form("bnum")
	bmoo = request.Form("bmoo")
	bbuilding = request.Form("bbuilding")
	bsoi = request.Form("bsoi")
	broad = request.Form("broad")
	btumbon = request.Form("btumbon")
	baddress=bplace & " เลขที่ " & bnum & " " & "หมู่" & " " & bmoo & " " & bbuilding & " " & "ซอย"  & " " & bsoi & " " & "ถนน" & " " & broad & " " & "ตำบล" & btumbon 
	bcity = request.Form("bcity")
	binter = request.Form("binterprovince")
	bprovince = request.Form("bprovinceth")
	bcountry = request.Form("bcountry")
	bzip = request.Form("bzip")
	bphone = request.Form("bphone")
	
	sname= request.Form("tb_sname")
	'saddress = request.Form("saddress")
	splace = request.Form("splace")
	snum = request.Form("snum")
	smoo = request.Form("smoo")
	sbuilding = request.Form("sbuilding")
	ssoi = request.Form("ssoi")
	sroad = request.Form("sroad")
	stumbon = request.Form("stumbon")
	saddress=splace & " เลขที่ " & snum & " " & "หมู่" & " " & smoo & " " & sbuilding & " " & "ซอย"  & " " & ssoi & " " & "ถนน" & " " & sroad & " " & "ตำบล" & stumbon 
	scity = request.Form("scity")
	sinter = request.Form("sinterprovince")
	sprovince = request.Form("sprovinceth")
	scountry = request.Form("scountry")
	szip = request.Form("szip")
	sphone = request.Form("sphone")
	 'step1 ) Update "Account" Table
	                 sql_add = "Update account set "
				     sql_add = sql_add &  " bname=  '" & bname & "' , "
					sql_add = sql_add &  " baddress=  '" & baddress & "' , "
					 sql_add = sql_add &  " bplace=  '" & bplace & "' , "
					 sql_add = sql_add &  " bnum=  '" & bnum & "' , "
					 sql_add = sql_add &  " bmoo=  '" & bmoo & "' , "
					 sql_add = sql_add &  "bbuilding=  '" &bbuilding & "' , "
					 sql_add = sql_add &  " bsoi=  '" & bsoi & "' , "
					 sql_add = sql_add &  " broad=  '" & broad & "' , "
					 sql_add = sql_add &  " btumbon=  '" & btumbon & "' , "
					 sql_add = sql_add &  " bcity=  '" & bcity & "' , "
					  sql_add = sql_add &  " bprovince=  '" & bprovince & "' , "
					  sql_add = sql_add &  " binterprovince=  '" & binter & "' ,"
					  sql_add = sql_add &  " bcountry=  '" & bcountry & "' ,"
					  sql_add = sql_add &  " bzip=  '" & bzip & "'  ," 
					  sql_add = sql_add &  " bphone=  '" & bphone & "' , " 
					  
					  sql_add = sql_add &  " gender =  '" & gender & "' , "
					  sql_add = sql_add &  " information =  '" & information & "' , "
					  sql_add = sql_add & " birthday = '"& birthday &"', "
					 
					   sql_add = sql_add &  " sname=  '" & sname & "' , "
					 sql_add = sql_add &  " saddress=  '" & saddress & "' , "
					 sql_add = sql_add &  " splace=  '" & splace & "' , "
					 sql_add = sql_add &  " snum=  '" & snum & "' , "
					 sql_add = sql_add &  "smoo=  '" &smoo & "' , "
					  sql_add = sql_add &  "sbuilding=  '" &sbuilding & "' , "
					 sql_add = sql_add &  " ssoi=  '" & ssoi & "' , "
					 sql_add = sql_add &  " sroad=  '" & sroad & "' , "
					 sql_add = sql_add &  " stumbon=  '" & stumbon & "' , "
					  sql_add = sql_add &  " scity=  '" & scity & "' , "
					   sql_add = sql_add &  " sprovince=  '" & sprovince & "' , "
					   sql_add = sql_add &  " sinterprovince=  '" & sinter & "' ,"
					   sql_add = sql_add &  " scountry=  '" & scountry & "' ,"
					  sql_add = sql_add &  " szip=  '" & szip & "'  ," 
					  sql_add = sql_add &  " statusupdate=  1  ," 
					   sql_add = sql_add &  " sphone=  '" & sphone & "'  " 
					  
					 
					 sql_add = sql_add &  " where userid= "& Session("userid")  	
				  				  
				  Set rs_add=Server.CreateObject("ADODB.Recordset")
				  Conn.execute (sql_add)		
								  
		
					response.Redirect("../profile.asp")
%>


</body>
</html>

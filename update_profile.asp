<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="../utf/connect_db.asp"--> 
	<title>แก้ไขข้อมูลส่วนตัว</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 

<body> 

<!-- header -->
		<h1>แก้ไขข้อมูลส่วนตัว</h1>
<!-- /header -->

<!-- Content -->
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
	if bname = "" then 
	response.Redirect("index.asp")
	end if
	bd1= trim(request.Form("bd1"))
    bd2= trim(request.Form("bd2"))
	bd3= trim(request.Form("bd3"))
	birthday = bd1 & ChkFmt(bd2) & bd3
	gender= request.Form("sl_gender")

	
	bplace = request.Form("bplace")
	bnum = request.Form("bnum")
	bmoo = request.Form("bmoo")
	bbuilding = request.Form("bbuilding")
	bsoi = request.Form("bsoi")
	broad = request.Form("broad")
	btumbon = request.Form("btumbon")
	baddress=bplace & " " & bnum & " " & "หมู่" & " " & bmoo & " " & bbuilding & " " & "ซอย"  & " " & bsoi & " " & "ถนน" & " " & broad & " " & "ตำบล" & btumbon 
	bcity = request.Form("bcity")
	binter = request.Form("binterprovince")
	bprovince = request.Form("bprovinceth")
	bzip = request.Form("bzip")
	bphone = request.Form("bphone")
	
	sname= bname
	splace = request.Form("splace")
	snum = request.Form("snum")
	smoo = request.Form("smoo")
	sbuilding = request.Form("sbuilding")
	ssoi = request.Form("ssoi")
	sroad = request.Form("sroad")
	stumbon = request.Form("stumbon")
	saddress=splace & " " & snum & " " & "หมู่" & " " & smoo & " " & sbuilding & " " & "ซอย"  & " " & ssoi & " " & "ถนน" & " " & sroad & " " & "ตำบล" & stumbon 
	scity = request.Form("scity")
	sprovince = request.Form("sprovinceth")
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
					  sql_add = sql_add &  " bzip=  '" & bzip & "'  ," 
					  sql_add = sql_add &  " bphone=  '" & bphone & "' , " 
					  
					  sql_add = sql_add &  " gender =  '" & gender & "' , "
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
					  sql_add = sql_add &  " szip=  '" & szip & "'  ," 
					  sql_add = sql_add &  " statusupdate=  1  ," 
					   sql_add = sql_add &  " sphone=  '" & sphone & "'  " 
					  
					 
					 sql_add = sql_add &  " where userid= "& Session("userid")  	
					 response.Write sql_add
					' response.End()
				  				  
				  Set rs_add=Server.CreateObject("ADODB.Recordset")
				  Conn.execute (sql_add)	
					response.Redirect("index.asp")

					%>

<!-- /Content -->

<!-- /footer --> 
<!--#include file="inc_footer.asp"-->
<!-- /footer -->


</body>
</html>
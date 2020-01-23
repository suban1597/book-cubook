<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><!DOCTYPE html> 
<!--#include file="../utf/connectdb.asp"-->
<html> 
	<head> 
	<title>Chulabook.com mobile</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.css" />
	<script src="http://code.jquery.com/jquery-1.4.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.js"></script>
</head> 
<body> 


<%
theme_id = "c"
theme_list_id = "d"
td_width = 130

		
	email = request("email")
	password = request("password")
	
	bymobile = 1
	statusupdate = 1
	
	bname = request("bname")
	bphone = request("bphone")
	gender = request("sl_gender")
	
	
	bd1 = request.Form("bd1")
	bd2 = request.Form("bd2")
	bd3 = request.Form("bd3")			
	birthday = bd1 & bd2 & bd3	
	
	registerdate = now()	
	
	sname = bname
	spohone  = bphone
	
	splace = request("splace")
	snum = request("snum")
	smoo = request("smoo")
	sbuilding = request("sbuilding")
	ssoi = request("ssoi")
	sroad = request("sroad")
	stumbon = request("stumbon")
	scity = request("scity")
	sprovince = request("sprovince")
	szip = request("szip")
	bcountry = "Thailand"
	
	saddress= splace & " " & snum & " " & "หมู่" & " " & smoo & " " & sbuilding & " " & "ซอย"  & " " & ssoi & " " & "ถนน" & " " & sroad & " " & "ต./เขต" & stumbon 
	
	bplace = splace
	bnum = snum
	bmoo = smoo
	bbuilding = sbuilding
	bsoi = ssoi
	broad = sroad
	btumbon = stumbon
	bcity = scity
	bprovince = sprovince
	bzip = szip
	
	baddress= bplace & " " & bnum & " " & "หมู่" & " " & bmoo & " " & bbuilding & " " & "ซอย"  & " " & bsoi & " " & "ถนน" & " " & broad & " " & "ต./เขต" & btumbon 

%>


<div data-role="page">

	<div data-role="header" data-theme="<%=theme_id%>">
		<h1>สมัครสมาชิก</h1>
	</div><!-- /header -->

	<div data-role="content">	
  <%
  if email = "" Then
  response.Redirect "index.asp"
  end if
  %>
  
  
   <div data-role="fieldcontain">     
<%
'step3 )  Find MaxUserid				
				    sql_max="SELECT max(Userid) as MaxUserID FROM Account " 
					Set RS=Server.CreateObject("ADODB.RecordSet")
					RS.Open sql_max, Conn, 1, 3
					
					
		
			     	if not rs.eof then
					userid= (Rs("MaxuserID"))+1
			    	End if	
					 
					response.Write userid & "<br>" & bname & "<br>" & email & "<br>" & password
					
    	    	
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
						RSadd("Bprovince")= bprovince
						RSadd("Bzip")= bzip
						RSadd("Bcountry")= bcountry
						RSadd("Bphone")= bphone
						RSadd("Email")= email 
						RSadd("Birthday")= birthday
						RSadd("AddressIndex")= " "
						RSadd("Pword")= password
						'RSadd("PwordHint")= pwordhint
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
						RSadd("Sprovince")= sprovince
						RSadd("Szip")= szip
						RSadd("SCountry")= scountry
						RSadd("Sphone")= sphone
						'RSadd("SInterprovince")= sinterprovince
						'RSadd("SEmail")= " "
						'RSadd("MemberID")= " "
						RSadd("Registerdate")= registerdate
						'RSadd("Accountstatus")= " "
						'RSadd("Currency")= " "
						'RSadd("Library")= " "
						RSadd("Gender")= gender
						'RSadd("Information")=  information
						RSadd("statusupdate")=  statusupdate
					'	RSadd("webboardadmin")=  webboardadmin
						RSadd("bymobile")=  bymobile
						RSadd.Update
'				  
'				  ' Send Mail   
				  Subject = "Welcome To Chulabook.com"
				  Tomail = email
				  FromMail= "webmaster@cubook.chula.ac.th"
'				  
				  Body = Body & "ยินดีต้อนรับยินดีต้อนรับสู่ www.chulabook.com" + VBCrlf
				  Body = Body & "email ของท่านที่ใช้ใน login คือ" & email + VBCrlf
				  Body = Body & "password ของท่านที่ใช้ใน login คือ" & password + VBCrlf
				  Body = Body & "From Webmaster@cubook.chula.ac.th"				
'				  
				  'Set   MyCDONTSMail = CreateObject("CDONTS.NewMail")
				   Set ObjMail=Server.CreateObject("CDO.Message")
				  		 	ObjMail.BodyPart.Charset = "UTF-8"
				   			ObjMail.From = FromMail
							ObjMail.To =Tomail
							ObjMail.Subject = Subject
							ObjMail.TextBody = Body
							ObjMail.Send
					Set	ObjMail = nothing 
				  
				   	Session("LOGON_Status") = Userid
				    Session("Userid")=Userid
					Session("Email")=email
                    Session("Password")=password
					Session("Bname")=bname
					'response.Redirect("shopping.asp")	

response.Write "บันทึกข้อมูล"
response.Redirect "index.asp"
%>
   </div>   
     
     

	
	</div><!-- /content -->

</div><!-- /page -->




</body>
</html>
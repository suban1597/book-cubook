<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><!DOCTYPE html> 
<!--#include file="../utf/connectdb.asp"-->
<html> 
	<head> 
	<title>Chulabook.com mobile</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.css" />
	<script src="http://code.jquery.com/jquery-1.4.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.js"></script>
    <%
	email = request("email")
	password = request("password")	
	
	'Check Email	
			Set RS_Checkemail = Server.CreateObject("ADODB.RecordSet")
			Sql_Checkemail = "SELECT email  FROM account WHERE email like '"&email&"' "
			RS_Checkemail.Open Sql_Checkemail,conn,1,3
   			
			if RS_Checkemail.EOF Then
			session("email") = email
			session("password") = password
			else
			response.Redirect("register.asp?message=Email นี้เคยลงทะเบียนแล้ว")
			end if
 	%>
</head> 
<body> 


<%
theme_id = "c"
theme_list_id = "d"
td_width = 130

%>


<div data-role="page">

	<div data-role="header" data-theme="<%=theme_id%>">
		<h1>สมัครสมาชิก</h1>
	</div><!-- /header -->

	<div data-role="content">	
  
   <div data-role="fieldcontain">
   
<form action="register_step3.asp" method="post">

<b>ขั้นตอนที่ 2/3</b>
<br>รายละเอียดส่วนตัวของคุณ<br><br><%response.Write session("email") & "   "  & session("password" )%>
<p> 
<fieldset class="ui-grid-a">
	<div class="ui-block-a" style="width:<%=td_width%>px">ชื่อ-นามสกุล</div>
	<div class="ui-block-b">
	  <input name="bname" type="text" id="bname" value="" width="200px"/>
	</div>	   

	<div class="ui-block-a" style="width:<%=td_width%>px">เบอร์โทรศัพท์</div>
	<div class="ui-block-b">    <input name="bphone" type="text" id="bphone" value="" width="200px"/></div>	 
    
    <div class="ui-block-a" style="width:<%=td_width%>px">วันเกิด</div>
	<div class="ui-block-b" style="width:200px"><select name="bd1" id="bd1">
                                <option value="01">Jan</option>
                                <option value="02">Feb</option>
                                <option value="03">Mar</option>
                                <option value="04">Apr</option>
                                <option value="05">May</option>
                                <option value="06">June</option>
                                <option value="07">July</option>
                                <option value="08">Aug</option>
                                <option value="09">Sep</option>
                                <option value="10">Oct</option>
                                <option value="11">Nov</option>
                                <option value="12">Dec</option>
                            </select>

    </div>
	<div class="ui-block-c" style="width:150px"><select name="bd2" id="bd2">
                                <%For i = 1 To 31%>
                                <%IF Mid(Birthday, 3, 2) = cStr(i) Then%>
                                <option value="<%=i%>" selected="selected"><%=i%>
                                <%Else%>
                                </option>
                                <option value="<%=i%>"><%=i%>
                                <%End IF%>
                                <%Next%>
                                </option>
                            </select></div>	 
                            
                            	<div class="ui-block-d" style="width:240px"><select name="bd3" id="bd3" class="form">
                                <%For i = 1930 To year(date())%>
                                <%IF right(rtrim(Birthday), 4) = cStr(i) Then%>
                                <option value="<%=i%>" selected="selected"><%="" & i + 543 & ""%>
                                <%Else%>
                                </option>
                                <option value="<%=i%>"><%="" & i + 543 & ""%>
                                <%End IF%>
                                <%Next%>
                                </option>
                            </select></div>	 
</fieldset>

  
 <input name="action" type="submit" id="action" value="ขั้นตอนถัดไป" data-icon="arrow-r" data-iconpos="right"/>
 
  </p>

  </form>
     </div>   
     
     

	
	</div><!-- /content -->

</div><!-- /page -->




</body>
</html>
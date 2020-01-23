<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><!DOCTYPE html> 
<html> 
	<head> 
	<title>Chulabook.com mobile</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
	<!--<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.css" />-->
	<link rel="stylesheet"  href="http://code.jquery.com/mobile/1.0a3/jquery.mobile-1.0a3.min.css" />
	<script src="http://code.jquery.com/jquery-1.4.3.min.js"></script>
	<!--<script src="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.js"></script>-->
		<script type="text/javascript" src="http://code.jquery.com/mobile/1.0a3/jquery.mobile-1.0a3.min.js"></script>
</head> 
<body> 


<%
' Jquery Mobile config
' =======================
theme_id = "c"
theme_list_id = "d"
' =======================
%>

<div data-role="page">

<!--	<div data-role="header" data-theme="<%'=theme_id%>">
		<h1>Chulabook.com</h1>
	</div>--><!-- /header -->

	<div data-role="content">	
		<p align="center"><img src="images/logo_chulabook.png" width="237" height="62" border="0" /></p>	
        
        <%
		if Session("Bname") <> "" then
			response.write "สวัสดีค่ะ คุณ" & Session("Bname")
		end if
		%>
     <form action="search.asp" method="post">   
   <div data-role="fieldcontain">     

    <label for="search" >ค้นหา</label>
    <input type="search" name="password" id="search" value="" />
    <select name="select-choice-1" id="select-choice-1" >
		<option value="title">ชื่อหนังสือ</option>
		<option value="author">ชื่อผู้แต่ง</option>
		<option value="barcode">Barcode</option>
		<option value="isbn">ISBN</option>
	</select>
    <input type="submit" value="Search" />
    </form>
     </div>   
<!-- Main Menu -->       
<ul data-role="listview" data-theme="<%=theme_list_id%>" data-inset="true">
	<li><a href="bestseller.asp">10 อันดับขายดี</a></li>
	<li><a href="newarrival.asp">หนังสือใหม่</a></li>
	<li><a href="recommend.asp">หนังสือแนะนำ</a></li>
    <li><a href="promotion.asp">โปรโมชั่น</a></li>
	<li><a href="login.asp"  >ข่าวประชาสัมพันธ์</a></li>
    <li><a href="aboutus.asp" >เกี่ยวกับเรา</a></li>
    <li><a href="howtobuy.asp" >วิธีการสั่งซื้อ</a></li>
	<li><a href="register.asp" >สมัครสมาชิก</a></li>
   	<%if session("userid") = "" Then%>
    <li><a href="login.asp" data-transition="slideup">เข้าสู่ระบบ</a></li>
    <%else%>
     <li><a href="profile.asp" data-transition="slideup">แก้ไขข้อมูลส่วนตัว</a></li>
    <li><a href="logout.asp" data-transition="slideup">ออกจากระบบ</a></li>
    <%end if%>
</ul>
<!-- Main Menu --> 
	
	</div><!-- /content -->

	<div data-role="footer" data-theme="<%=theme_id%>">
		
	</div><!-- /header --><!-- /page -->




</body>
</html>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><!DOCTYPE html> 
<html> 
	<head> 
	<title>Chulabook.com mobile</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<!--#include file="inc_jquery.asp"--> 
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
		if Session("userid") <> "" then
			response.write "สวัสดีค่ะ คุณ" & Session("Bname")
		end if
		%>
     <form action="search.asp" method="post">   
   <div data-role="fieldcontain">     

    <label for="search" >ค้นหา</label>
    <input type="search" name="keyword" id="search" value="" />
    <select name="option1" id="select-choice-1" >
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
	<li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/award.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="bestseller.asp">10 อันดับขายดี</a></td>
	</tr>
	</table>
	</li>
	
	<li>
	<table border=0 width="100%">
	<tr>
	<td width="30" height="30" style="background-image:url(images/new.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="newarrival.asp">หนังสือใหม่</a></td>
	</tr>
	</table>
	</li>
	
	
	
	<li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/book-open.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="recommend.asp">หนังสือแนะนำ</a></td>
	</tr>
	</table>
	</li>
	
	
    <li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/book.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="promotion.asp">โปรโมชั่น</a></td>
	</tr>
	</table>
	</li>
		
	
    <li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/news.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="news.asp" >ข่าวประชาสัมพันธ์</a></td>
	</tr>
	</table>
	</li>
	
	
	<li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/about.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="aboutus.asp" >เกี่ยวกับเรา</a></td>
	</tr>
	</table>
	</li>


    <%if session("userid") = "" Then%>
    <li>
	<table border=0 width="100%">
	<tr>
	<td width="30" height="30" style="background-image:url(images/user.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="register.asp" >สมัครสมาชิก</a></td>
	</tr>
	</table>
	</li>
    <%end if%>
	
	
    <%if session("userid") <> "" Then%>
    <li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/key.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="shopping.asp" data-transition="slideup">ตระกร้าสินค้า</a></td>
	</tr>
	</table>
	</li>
    <li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/key.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="orderstatus.asp" data-transition="slideup">ประวัติการสั้งซื้อ</a></td>
	</tr>
	</table>
	</li>
    <li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/key.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="profile.asp" data-transition="slideup">แก้ไขข้อมูลส่วนตัว</a></td>
	</tr>
	</table>
	</li>
    <%end if%>
   	<%if session("userid") = "" Then%>
     <li>
	<table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/key.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="login.asp" data-transition="slideup">เข้าสู่ระบบ</a></td>
	</tr>
	</table>
	</li>
    <%else%>     
    <li>
    <table border=0 width="100%">
	<tr>
	<td width="32" height="30" style="background-image:url(images/key.png); background-repeat:none; margin-left:0px;"></td>
	<td><a href="logout.asp" data-transition="slideup">ออกจากระบบ</a></td>
	</tr>
	</table>
    </li>
    <%end if%>
</ul>

<!--#include file="inc_footer.asp"--> 	

</div>
</body>
</html>
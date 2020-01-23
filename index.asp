<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Chulabook.com mobile</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  
    </head> 
<body> 

<!--#include file="inc_tabbar.asp"-->
	<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_bestseller.png" width="29" height="29" /></td>
	<td height="20"><a href="bestseller.asp" class="text_header">10 อันดับขายดี</a></td>
    <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
    <tr>
    <td><font class="text_subtitle">Top 10 Best Seller</font></td>
    </tr>
	</table>
    	
<table border=0 width="100%">
	<tr>
	<td style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
	</td>
	</tr>
	</table>

<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_new.png" width="29" height="29" /></td>
	<td height="20"><a href="newarrival.asp" class="text_header">หนังสือใหม่</a></td>
    <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
        <tr>
    <td><font class="text_subtitle">New Books</font></td>
    </tr>
	</table>
    
<table border=0 width="100%">
<tr>
<td higth="1" style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
</td>
</tr>
</table>

	<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_recommend.png" /></td>
	<td height="20"><a href="recommend.asp" class="text_header">หนังสือแนะนำ</a></td>
    <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
     <tr>
    <td><font class="text_subtitle">Recommended Book</font></td>
    </tr>
	</table>
    
<table border=0 width="100%">
<tr>
<td higth="1" style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
</td>
</tr>
</table>
    
    <table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_news.png" /></td>
	<td height="20"><a href="news.asp" class="text_header">ข่าวประชาสัมพันธ์</a></td>
    <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
    <tr>
    <td><font class="text_subtitle">News</font></td>
    </tr>
	</table>
    
<table border=0 width="100%">
<tr>
<td higth="1" style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
</td>
</tr>
</table>

	<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_about.png" /></td>
	<td height="20"><a href="map.asp" class="text_header">เกี่ยวกับเรา</a></td>
    <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
    <tr>
    <td><font class="text_subtitle">About Us</font></td>
    </tr>
	</table>
    
<table border=0 width="100%">
<tr>
<td higth="1" style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
</td>
</tr>
</table>

    <%if session("userid") = "" Then%>
    
<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_register.png" /></td>
	<td height="20"><a href="register.asp" class="text_header">สมัครสมาชิก</a></td>
    <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
    <tr>
    <td><font class="text_subtitle">Register</font></td>
    </tr>
	</table>
    
<table border=0 width="100%">
<tr>
<td higth="1" style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
</td>
</tr>
</table>

    <%else%>

	<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_cart.png" /></td>
	<td height="20"><a href="shopping.asp?Action=shopping"  class="text_header">ตะกร้าสินค้า</a></td>
     <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
        <tr>
    <td><font class="text_subtitle">Shopping cart</font></td>
    </tr>
	</table>
    
<table border=0 width="100%">
	<tr>
	<td style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
	</td>
	</tr>
	</table>

	<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_history.png" /></td>
	<td height="20"><a href="yourorderstatus.asp" class="text_header">ประวัติการสั่งซื้อ</a></td>
     <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
        <tr>
    <td><font class="text_subtitle">Order history</font></td>
    </tr>
	</table>
    
<table border=0 width="100%">
	<tr>
	<td style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
	</td>
	</tr>
	</table>

	<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_edit.png" /></td>
	<td height="20"><a href="profile.asp" class="text_header">แก้ไขข้อมูลส่วนตัว</a></td>
     <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
        <tr>
    <td><font class="text_subtitle">Edit Profile</font></td>
    </tr>
	</table>
    	
<table border=0 width="100%">
	<tr>
	<td style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
	</td>
	</tr>
	</table>

    <%end if%>
   	<%if session("userid") = "" Then%>

	<table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_login.png" /></td>
	<td><a href="login.asp" class="text_header">เข้าสู่ระบบ</a></td>
    <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
    <tr>
	<td><font class="text_subtitle">Login</font></td>
    </tr>
	</table>

<%else%>     

    <table border=0 width="100%">
	<tr>
	<td width="29" rowspan="2"><img src="images/i_logout.png" /></td>
	<td height="20"><a href="logout.asp"class="text_header">ออกจากระบบ</a></td>
     <td width="20" rowspan="2"><img src="images/arrow_right3.png" /></td>
	</tr>
        <tr>
    <td><font class="text_subtitle">Logout</font></td>
    </tr>
	</table>

    <%end if%>

	<table border=0 width="100%">
	<tr>
	<td style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
	</td>
	</tr>
	</table>
    
    <br />
  <table border=0 width="100%">
        <tr>
    <td><font class="text_subtitle">Follow us on </font></td>
    </tr>
    <tr>
    <td><a href="http://www.facebook.com/cubook"><img src="images/facebook_icon.png" width="100" height="32" border=0 /></a>
    <a href="http://www.twitter.com/Chulabook"> <img src="images/twitter_icon.png" width="100" height="32" border=0 /></a>    </td>
    </tr>
	</table>    

</body>
</html>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>เข้าสู่ระบบ</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<%
cart = request("cart")
%>
<font class="text_header">เข้าสู่ระบบ</font>
<form action="submit_login.asp" method="post">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td colspan="2">ใส่อีเมล์แอดแดรสและรหัสผ่านที่ลงทะเบียนไว้แล้ว</td>
  </tr>
  <tr>
    <td width="6%"><div align="right"><font class="text_normal">อีเมล์</font></div></td>
    <td width="94%"><input type="text" name="username" id="username" value=""  /></td>
  </tr>
  <tr>
    <td><div align="right"><font class="text_normal">รหัสผ่าน</font></div></td>
    <td><input type="password" name="password" id="password" value="" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" value="เข้าสู่ระบบ" id="myButton" data-icon="arrow-r"  data-iconpos="right"/>
    <input name="cart" type="hidden" id="hiddenField" value="<%=cart%>" /></td>
  </tr>
</table>
</form>
<!--#include file="inc_footer.asp"-->
</body>
</html>
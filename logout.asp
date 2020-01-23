<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="../utf/connectdb.asp"-->
	<title>ออกจากระบบ</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
     <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
		<h1>Chulabook.com</h1>        
<%
	Session.Abandon()
	Response.Redirect "index.asp"
%>
	
<!-- /footer --> 
<!--#include file="inc_footer.asp"-->
<!-- /footer -->
</body>
</html>
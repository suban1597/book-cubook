<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="connect_db.asp"--> 
	<title>เกี่ยวกับเรา</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<%
' Page Data 
' =======================
Sql = "SELECT * FROM webmobile  WHERE id = 1 "
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3

content = RS("aboutus")
%>

<!-- header -->
		<h1>เกี่ยวกับเรา</h1>
<!-- /header -->

<!-- Content -->
<%=content%>
<!-- /Content -->

<!-- /footer --> 
	<!--#include file="inc_footer.asp"-->
<!-- /footer -->

</body>
</html>
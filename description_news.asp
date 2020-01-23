<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<!--#include file="../utf/inc_checkprice.asp"--> 
	<title>Description</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<%
' Page Data 
' =======================
newsid = request("newsid")
Sql = "SELECT *  "
	Sql = Sql & "from news  where newsid = "&newsid&""
	
	Set RsRBook=Server.CreateObject("ADODB.RecordSet")
	RsRBook.Open  Sql, Conn, 1, 3
' =======================	
%>

<table width=300 border=0>
		<tr>
            <td height="43"><div align="left"><font class="text_normal"><b><%=RsRBook("topic")%></b></font></div></td>
          </tr>
          <tr>
            <td><font class="text_normal"><%=RsRBook("text_summary")%></font></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table> 

<!-- /footer --> 
	<!--#include file="inc_footer.asp"-->
<!-- /footer -->



</body>
</html>
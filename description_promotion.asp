<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="../connect_db.asp"--> 
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
promotionid = request.QueryString("promotionid")
Sql = "SELECT *  "
	Sql = Sql & "from promotion  where promotionid = "&promotionid&""
	Set RsRBook=Server.CreateObject("ADODB.RecordSet")
	RsRBook.Open  Sql, Conn, 1, 3


' =======================	
%>
<table width=300 border=0>
		<tr>
            <td height="43"><div align="left"><span class="big-text"><%=RsRBook("topic")%></span></div></td>
          </tr>
          <tr>
            <td><span class="blacktext"><%=RsRBook("text_summary")%></span></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>     

	<!--#include file="inc_footer.asp"-->


</body>
</html>
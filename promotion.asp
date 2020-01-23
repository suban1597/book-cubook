<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="../utf/connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
	<title>Chulabook.com mobile Promotion</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<%
Sql = "SELECT *  "
Sql = Sql & "from promotion  where item_status = 1 order by promotionid desc"
Set RsRBook=Server.CreateObject("ADODB.RecordSet")
RsRBook.Open  Sql, Conn, 1, 3
%>
    <font class="text_header">โปรโมชั่น</font>
    <%Do while not RsRBook.eof%>
    <table width="100%" border="0" cellspacing="2" cellpadding="2" class="text_normal">
      <tr>
        <td width="4%"><img src="../admin/promotion/UploadFolder/<%=RsRBook("promotionid")%>.jpg"  border="0"/></td>
        <td width="96%"><%response.write "<a class=""text_normal"" href=""description_promotion.asp?promotionid="&RsRBook("promotionid")&""">"&RsRBook("topic")&"</a>" %></td>
      </tr>
	  </table>
	   <table border=0 width="100%">
<tr>
<td higth="1" style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
</td>
</tr>
</table>  
	  
	  
	  <%
RsRBook.movenext
Loop
%>
    

	<!--#include file="inc_footer.asp"-->
</body>
</html>
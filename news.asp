<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="../utf/connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
	<title>Chulabook.com mobile Bestseller</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<font class="text_header">ข่าวประชาสัมพันธ์</font>
<%
Sql = "SELECT top 10 *  "
Sql = Sql & "from news  where item_status = 1 order by newsid desc"
Set RsRBook=Server.CreateObject("ADODB.RecordSet")
RsRBook.Open  Sql, Conn, 1, 3
%>
   
      <%Do While not RsRBook.EOF%>
       <table width="100%" border="0" cellspacing="2" cellpadding="2" class="text_normal">
      <tr>
        <td width="5%"><div align="center"><img src="../admin/news/UploadFolder/<%=RsRBook("newsid")%>.jpg"  border="0" /></div></td>
        <td width="95%" valign="top"><a href="description_news.asp?newsid=<%=RsRBook("newsid")%>" class="text_normal"><b><%=RsRBook("topic")%></b></a></td>
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
	loop
	%>
   
	<!--#include file="inc_footer.asp"-->
</body>
</html>
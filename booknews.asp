<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="connect_db.asp"--> 
<!--#include file="../inc_allfunction.asp"--> 
	<title>Chulabook.com mobile Bestseller</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 

<body> 
<%
Sql = "SELECT * FROM booklist as bl , bestseller as bs WHERE bs.barcode=bl.barcode"
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3
%>

<h1>Recommend</h1>


<%On Error Resume Next%>
        <%ReadBinFile( RS("barcode") & ".gif")%>
        <%If Err Then%>
        <img src="/images/books/apology.gif" alt="Book" height="115"/>
        <%Else%>
        <img src="/images/books/<%=RS("barcode")%>.gif"  alt="Book" border="0" height="115" width="115"/>
        <%End If%><%=RS("title")%><%=RS("title1")%><br />
barcode
<a href="audi.html">Audi</a>
	<a href="bmw.html">BMW</a>

	<!--#include file="inc_footer.asp"-->

</body>
</html>
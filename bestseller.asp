<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<title>10 อันดับ หนังสือขายดี</title> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<%
' Page Data 
' =======================
'Sql = "SELECT * FROM booklist as bl , bestseller as bs WHERE bs.barcode=bl.barcode"
'Set RS = Server.CreateObject("ADODB.RecordSet")

Sql = "SELECT * FROM booklist as bl , bestseller as bs WHERE bs.barcode=bl.barcode"
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3
' =======================
%>
<font class="text_header">10 อันดับขายดี</font>
<%Do While not rs.EOF%>
	<table width="100%" border="0" cellspacing="2" cellpadding="2">      
      <tr>
        <td width="7%" valign="top">
		  <div align="center">
		    <%On Error Resume Next%>
	        <%		     
	    ' Find Book Cover
		' ===================================================================
		bookimgpt = "C:\Chulabook\images\book-400\" & RS("barcode") &  ".jpg"			
		'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("barcode") &  ".jpg"	
		if   ChkFile(bookimgpt) = true then
				bookimg = "http://www.chulabook.com/images/book-400/" & RS("barcode") &  ".jpg"				
		'elseif ChkFilebook2(bookimgpt2) = true then
		''		bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".jpg"
		else	
				bookimg = "http://www.chulabook.com/images/book-400/apology.jpg"
		end if
		' =================================================================
	  %>
	    <a href="description.asp?barcode=<%=RS("barcode")%>"><img src="<%=bookimg%>" height="60" border="0" /></a></div></td>
        <td width="93%" valign="top">
		  <div align="left"><a href="description.asp?barcode=<%=RS("barcode")%>" class="text_normal"><b><%=RS("title")%><%=RS("title1")%></b></a><br />
            <%=RS("barcode")%><br />
        ราคา : <%=Formatnumber(RS("price"),2)%> บาท<br />        
          </div></td>
      </tr>     
    </table>
    <table border=0 width="100%">
<tr>
<td higth="1" style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
</td>
</tr>
</table>  <%
		rs.movenext
		loop
		%>
    
<!--#include file="inc_footer.asp"-->
</body>
</html>
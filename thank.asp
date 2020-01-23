<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="../utf/connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<!--#include file="../utf/inc_checkprice.asp"--> 
	<title>Final</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<font class="text_header">การสั่งซื้อเสร็จเรียบร้อย</font>
<%
OrderID = Request.Form("OrderID")
If OrderID ="" then
OrderID = Request.QueryString("OrderID")
End If
Session("OrderID")=OrderID
Set RS = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT * FROM orders WHERE (orderid ='" & Session("orderid") & "')"
RS.Open Sql,conn,1,3
%>
<table width="100%" cellspacing="2" cellpadding="2">
  <tr> 
    <td width="35%"><div align="left"><span class="text_normal"><b>หมายเลขอ้างอิง (Tracking number)</b></span></div></td>
    <td width="65%"><div align="left"><span class="text_normal"><b><%=Session("OrderID")%></b></span></div></td>
  </tr>
  <tr>
    <td><div align="left"><span class="text_normal"><b>วันที่ / เวลา ที่สั่งซื้อ</b></span></div></td>
    <td><div align="left"><span class="text_normal"><%=RS("orderdate")%> / <%=RS("ordertime")%></span></div></td>
  </tr>
  <tr>
    <td><div align="left"><span class="text_normal"><b>ยอดการสั่งซื้อ</b></span></div></td>
    <td><div align="left"><span class="text_normal"><%=Formatnumber(RS("amount"),2)%> บาท</span> </div></td>
  </tr>
  <tr>
    <td><div align="left"><span class="text_normal"><b>ค่าขนส่ง</b></span></div></td>
    <td><div align="left">
	<%
	If RS("SAHC") = 0 Then 
	response.Write "ซื้อครบ 700 บาท ฟรีค่าจัดส่ง" 
	else
	response.Write Formatnumber(RS("SAHC"),2) & "บาท"
	End If
	%>  </div></td>
  </tr>
  <tr>
    <td><div align="left"><span class="text_normal"><b>รวมยอดเงิน</b></span></div></td>
    <td><div align="left"><span class="text_normal"><%=Formatnumber(RS("amount")+RS("SAHC"),2)%> บาท </span></div></td>
  </tr>
  <tr>
    <td><div align="left"><span class="text_normal"><b>ชื่อ - ที่อยู่ สำหรับรับสินค้า</b></span></div></td>
    <td><div align="left"><span class="text_normal"><%=RS("name")%></span></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="left"><span class="text_normal"><%=RS("address")%> <%=RS("city")%></span></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="left"><span class="text_normal"><%
				Sql_province2 = "SELECT * FROM province2 WHERE PROVINCE_CODE like "&RS("province")&" "
				Set RS_province2 = Server.CreateObject("ADODB.RecordSet")
				RS_province2.Open Sql_province2,conn,1,3
				response.Write RS_province2("TH_NAME")
				%>
        &nbsp; <%=RS("zip")%></span></div></td>
  </tr>
</table>


<!--#include file="inc_footer.asp"--> 	


</body>
</html>
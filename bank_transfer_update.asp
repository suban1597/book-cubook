<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<head> 
	<title>Chulabook.com mobile ยืนยันการแจ้งผลการโอนเงิน</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body>
<!--#include file="inc_tabbar.asp"--> 

<form id="submit" name="submit" method="POST" action="bank_transfer_thank.asp">
<%
 R_tb_name = request.Form("tb_name")
 R_tb_lastname = request.Form("tb_lastname")
 R_tb_email = request.Form("tb_email")
 Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Open " select * from account where email= '" &R_tb_email&"' ", Conn, 1, 3
if not rs.eof then
userid=rs("userid")
%>
        <input name="email" type="hidden" value="<%=R_tb_email%>" >
<%
else 
response.Redirect("Banktransfer.asp?error3= อีเมล์นี้ยังไม่ได้ลงทะเบียน   โปรดกรอกข้อมูลที่ถูกต้อง")
end if
%>
<%
 R_tb_trackno = request.Form("tb_trackno")
Set RST=Server.CreateObject("ADODB.RecordSet")
RST.Open " select * from orders where orderid= '" &R_tb_trackno&"' and userid= '" &userid&"'", Conn, 1, 3
if not rst.eof then
%>
        <input name="TrackingNumber" type="hidden" value="<%=R_tb_trackno%>" >
        <%
else 
response.Redirect("Banktransfer.asp?error5= ไม่มีหมายเลขการสั่งซื้อนี้  โปรดกรอกข้อมูลที่ถูกต้อง")
end if
%>
<%
 R_tb_phone = request.Form("tb_phone")
 R_tb_amount = request.Form("tb_amount")
 R_tb_frombank = request.Form("tb_frombank")
 R_tb_branch = request.Form("tb_branch")
 R_rd_bank = request.Form("rd_bank")
 R_new_day = request.Form("new_day")
 R_lb_mount = request.Form("lb_mount")
 R_lb_year = request.Form("lb_year")
 R_transfer_method = request.Form("transfer_method")
 if R_transfer_method = 1 then
 R_transfer_method = "โอนจากธนาคาร"
 elseif R_transfer_method = 2 then
 R_transfer_method = "โอนผ่านตู้ ATM"
 elseif R_transfer_method = 3 then
 R_transfer_method = "โอนผ่านทางออนไลน์"
 End If 
 R_new_hr = request.Form("new_hr")
 R_new_min = request.Form("new_min")
 R_date = request.form("lb_day")+"-" + request.form("lb_month")  +"-" +request.form("lb_year") 
 R_time = request.form("lb_hr") +":" + request.form("lb_min")
 R_remark = request.Form("remark")
 final_datetime=R_date +" " + R_time
%>
<!-- แปลงตัวแปรธนาคาร -->
<%if R_rd_bank = "BBL" then
R_rd_bank2 = "ธ.กรุงเทพ"

elseif  R_rd_bank = "KB" then
R_rd_bank2 = "ธ.กสิกรไทย"

elseif  R_rd_bank = "KTB" then
R_rd_bank2 = "ธ.กรุงไทย"

elseif  R_rd_bank = "SCB" then
R_rd_bank2 = "ธ.ไทยพาณิชย์"
end  if


%>
<table width="98%" border="0" align="center" cellpadding="1" cellspacing="1" class="text_normal">
  <tr>
    <td width="295" height="27" valign="middle"><div align="right">&nbsp;&nbsp;ชื่อ-นามสกุล :&nbsp; </div></td>
    <td height="27" colspan="2" valign="middle">
      <div align="left">&nbsp;<%=R_tb_name%>&nbsp;&nbsp;<%=R_tb_lastname%>
        <input name="lastname" type="hidden" value="<%=R_tb_lastname%>" />
        <input name="name" type="hidden" value="<%=R_tb_name%>" />
      </div></td>
  </tr>
  <tr>
    <td height="27" valign="middle"><div align="right">&nbsp;&nbsp;อีเมล (Email เดียวกับที่ใช้ลงทะเบียน) :&nbsp; </div></td>
    <td height="27" colspan="2" valign="middle">
      <div align="left">&nbsp;<%=R_tb_email%></div></td>
  </tr>
  <tr>
    <td height="27"  valign="middle"><div align="right">&nbsp;&nbsp;โทรศัพท์ :&nbsp; </div></td>
    <td height="27" colspan="2" valign="middle">
      <div align="left">&nbsp;<%=R_tb_phone%>
        <input name="phone" type="hidden" value="<%=R_tb_phone%>" />
      </div></td>
  </tr>
  <tr>
    <td height="27"  valign="middle"><div align="right">หมายเลขอ้างอิงการสั่งซื้อ :&nbsp;</div></td>
    <td height="27" colspan="2"  valign="middle">
      <div align="left">&nbsp;<%=R_tb_trackno%></div></td>
  </tr>
  <tr>
    <td height="27"  valign="middle"><div align="right">จำนวนเงินที่โอน :&nbsp;</div></td>
    <td colspan="2"  valign="middle">
      <div align="left">&nbsp;<%=formatnumber(R_tb_amount,2)%>
        <input name="amount" type="hidden" value="<%=R_tb_amount%>" />
      บาท</div></td>
  </tr>
  <tr>
    <td height="27"  valign="middle"><div align="right">วิธีการโอนเงิน :&nbsp; </div></td>
    <td height="27" colspan="2" valign="middle">
      <div align="left">&nbsp;<%=R_transfer_method%>
        <input name="R_transfer_method" type="hidden" id="R_transfer_method" value="<%=R_transfer_method%>" />
      </div></td>
  </tr>
  <tr>
    <td height="27"  valign="middle"><div align="right">โอนจากธนาคาร / สาขา :&nbsp;</div></td>
    <td width="624" height="27"  valign="middle">
      <div align="left">&nbsp;<%=R_tb_frombank%>&nbsp;&nbsp;/&nbsp;&nbsp;<%=R_tb_branch%>
        <input name="branch" type="hidden" value="<%= R_tb_branch%>" />
        <input name="frombank" type="hidden" value="<%=R_tb_frombank%>" />
      </div></td>
  </tr>
  <tr>
    <td height="27"  valign="middle"><div align="right">&nbsp;&nbsp;โอนเข้าบัญชีศูนย์หนังสือจุฬาฯ :&nbsp;</div></td>
    <td height="27" colspan="2"  valign="middle">
      <div align="left">&nbsp;<%=R_rd_bank2%>
        <input name="rd_bank" type="hidden" value="<%=R_rd_bank%>" />
      </div></td>
  </tr>
  <tr>
    <td height="27" valign="middle"><div align="right">&nbsp;&nbsp;วันที่ทำการโอนเงิน :&nbsp;</div></td>
    <td colspan="2"  valign="middle">
      <div align="left">&nbsp;<%=R_date%></div></td>
  </tr>
  <tr>
    <td height="27" valign="middle"><div align="right">&nbsp;&nbsp;เวลาที่ทำการโอนเงิน :&nbsp;</div></td>
    <td height="27" colspan="2" valign="middle">
      <div align="left">&nbsp;<%=R_time%>
        <input name="finaldatetime" type="hidden" value="<%=final_datetime%>" />
  &#3609;.</div></td>
  </tr>
  <tr>
    <td height="27" valign="middle"><div align="right">&nbsp;วัน / &nbsp;เวลาที่แจ้งผลการโอนเงิน :&nbsp;</div></td>
    <td height="27" colspan="2" valign="middle">
        <div align="left">&nbsp;
          <%response.Write now()%>
          <input name="transferdatetime" type="hidden" value="<%=now()%>" />
  &#3609;.</div></td>
  </tr>
  <tr>
    <td height="27" valign="middle"><div align="right">&nbsp;&nbsp;หมายเหตุ :&nbsp;</div></td>
    <td colspan="2" valign="middle">
        <div align="left">&nbsp;
          <%
		  If  R_remark = "" Then
		  response.Write "ไม่มีหมายเหตุ"
		  Else 
		  response.Write R_remark
		  End If
		  %>
          <input name="remark" type="hidden" value="<%=R_remark%>" />
      </div></td>
  </tr>
  <tr>
    <td valign="top" bordercolor="#FFFFFF">&nbsp;</td>
    <td colspan="2" valign="top" bordercolor="#FFFFFF"><div align="left">
      <input type="submit" name="Submit" value="ข้อมูลถูกต้องยืนยันการแจ้งผลการโอนเงิน" />
      <a href="http://www.chulabook.com/m/index.asp"><input type="button" name="Submit2" value="ยกเลิก" /></a >
    </div>
</td>
  </tr>
</table>
</form>

	<!--#include file="inc_footer.asp"-->
</body>
</html>
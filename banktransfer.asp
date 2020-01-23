<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<head> 
	<title>Chulabook.com mobile แจ้งผลการโอนเงิน</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body>
<!--#include file="inc_tabbar.asp"--> 

<%if session("userid") = "" Then
response.Redirect "login.asp"
%>

<%else%>
<font class="text_header">ข้อมูลผู้สมัครสมาชิก</font>
<%
Set RS = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT  * FROM account WHERE userid like "&Session("UserID")&""
RS.Open Sql,conn,1,3

bname = RS("bname")
strSplit = Split(bname," ")
firstname = strSplit(0)
On Error Resume Next
lastname = strSplit(1)
%>
<script type = "text/javascript" src="../foul.js" ></script>
<!-- Validate Email -->
<script type="text/javascript">
							foul.when('~tb_email~ is not email','Please verified your email address : รุปแบบอีเมล์ไม่ถูกต้อง');
</script>
<script type="text/javascript">
							foul.when('~tb_name~ is null','กรุณาใส่ชื่อด้วยค่ะ');
							foul.when('~tb_lastname~ is null','กรุณาใส่นามสกุลด้วยค่ะ');
							foul.when('~tb_email~ is null','กรุณาใส่ Email ด้วยค่ะ');
							foul.when('~tb_phone~ is null','กรุณาใส่เบอร์โทรศัพท์ด้วยค่ะ');
							foul.when('~tb_trackno~ is null','กรุณาใส่หมายเลขอ้างอิงการสั่งซื้อด้วยค่ะ');
							foul.when('~tb_amount~ is null','กรุณาใส่ยอดเงินที่โอนด้วยค่ะ');
							foul.when('~tb_frombank~ is null','กรุณาใส่ธนาคารที่โอนด้วยค่ะ');
							foul.when('~tb_branch~ is null','กรุณาใส่สาขาที่โอนด้วยค่ะ');
							foul.when('~rd_bank~ is null','กรุณาเลือกธนาคารด้วยค่ะ');
							foul.when('~transfer_method~ is null','กรุณาเลือกวิธีการโอนเงินด้วยค่ะ');
						
</script>
<form id="form1" name="form1" method="post" onsubmit="return(foul.validate(this))" action="bank_transfer_update.asp">
  <table width="98%" border="0" align="center" cellpadding="2" cellspacing="2">
    <tr>
      <td  height="27"><font class="text_normal">ชื่อ</font></td>
	  <td height="27" colspan="5"><div align="left">
	    <input name="tb_name" type="text" id="ชื่อ" value="<%=firstname%>"  width="100px" />
      </div></td>
    </tr>
    <tr>
      <td height="27"><font class="text_normal">นามสกุล</font></td>
      <td height="27" colspan="5"><div align="left">
        <input name="tb_lastname" type="text" id="นามสกุล2" value="<%=lastname%>" width="100px"  />
      </div></td>
    </tr>
    <tr>
      <td height="27"><font class="text_normal">อีเมล</font></td>
      <td height="27" colspan="5">
        <div align="left">
          <input name="tb_email" type="text" id="eMail" value="<%=RS("email")%>" width="100px"  />
          <%If request.QueryString("error3") = "" Then
			response.Write "" 
			Else
			response.Write "<br>&nbsp;<span class=text_normal>" &request.QueryString("error3") & "</font>"
			End If
			%>
          </div></td>
    </tr>
    <tr>
      <td height="27"><font class="text_normal">โทรศัพท์</font></td>
      <td colspan="5"><div align="left">
        <input name="tb_phone" type="text" id="โทรศัพท์" value="<%=trim(RS("bphone"))%>" width="100px"  />
      </div></td>
    </tr>
    <tr>
      <td height="27" ><font class="text_normal">หมายเลขการสั่งซื้อ</font></td>
      <td colspan="5" ><div align="left">
        <input name="tb_trackno" type="text" id="หมายเลขอ้างอิงการสั่งซื้อ" maxlength="13" width="50px" />
        <%=request.QueryString("error5")%><br />
        <font class="text_normal">**หากโอนเงินรวมกันหลายใบสั่งซื้อ กรุณาใส่หมายเลขสั่งซื้อเพิ่มเติมในช่องหมายเหตุด้านล่างด้วยค่ะ</font></div></td>
    </tr>
    <tr>
      <td height="27" ><font class="text_normal">จำนวนเงินที่โอน</font></td>
      <td height="27" colspan="5" ><div align="left"><font class="text_normal">
        <input name="tb_amount" type="text" id="จำนวนเงินโอน" size="5" maxlength="5" />
        บาท <%=request.QueryString("error6")%></font></div></td>
    </tr>
    <tr>
      <td height="27" ><font class="text_normal">วิธีการโอนเงิน</font></td>
      <td height="27" colspan="5"><div align="left"><font class="text_normal">
        <input name="transfer_method" type="radio" id="radio" value="1" />
      โอนผ่านธนาคาร</font></div></td>
    </tr>
    <tr>
      <td height="27" ></td>
      <td height="27" colspan="4" ><div align="left"><font class="text_normal">
        <input name="transfer_method" type="radio" id="radio2" value="2" checked="checked" />
      โอนจากตู้ ATM</font></div></td>
    </tr>
    <tr>
      <td height="27" ></td>
      <td height="27" colspan="4" ><div align="left"><font class="text_normal">
        <input type="radio" name="transfer_method" id="radio3" value="3" />
      โอนผ่านออน์ไลน์</font></div></td>
    </tr>
    <tr>
      <td height="27" ><font class="text_normal">โอนจากธนาคาร / ตู้ ATM ของธนาคาร</font></td>
      <td height="27" colspan="4" ><div align="left"><font class="text_normal">
        <input name="tb_frombank" type="text" id="โอนจากธนาคาร" maxlength="50" />
      </font></div></td>
    </tr>
    <tr>
      <td height="27" ><font class="text_normal">สาขา </font></td>
      <td colspan="4" ><div align="left">
        <input name="tb_branch" type="text" id="สาขา2" maxlength="50" />
      </div></td>
    </tr>
    <tr>
      <td height="27" ><font class="text_normal">โอนเข้าบัญชีศูนย์หนังสือจุฬาฯ</font></td>
      <td width="183" >
        <div align="left"><font class="text_normal">
          <input name="rd_bank" type="radio"  id="โอนเข้าบัญชี2" value="BBL" />
      ธนาคาร กรุงเทพ </font></div></td>
      <td width="129" >
        <div align="left"><font class="text_normal">
          <input name="rd_bank" type="radio" value="KTB"  id="โอนเข้าบัญชี" />
      ธนาคาร กรุงไทย </font></div></td>
      <td width="134" >
        <div align="left"><font class="text_normal">
          <input name="rd_bank" type="radio" value="KB"  id="โอนเข้าบัญชี3" />
      ธนาคาร กสิกรไทย </font></div></td>
      <td width="284" >
        <div align="left"><font class="text_normal">
          <input name="rd_bank" type="radio" value="SCB"  id="โอนเข้าบัญชี4" />
      ธนาคาร ไทยพานิชย์ </font></div></td>
    </tr>
    <tr>
      <td height="27"><font class="text_normal">วันที่ทำการโอน</font></td>
      <td height="27" colspan="5" >
          <div align="left"><font class="text_normal">
            <select name="lb_day" id="lb_day">
              <%for i_day = 1 to 31%>
              <%if len(i_day) = 1 then		
		  new_day = "0" +Cstr(i_day) 
		  else 
		  new_day = i_day
		  end if
		  %>
              <option value="<%=new_day%>"><%=new_day%></option>
              <%next%>
            </select>
            <select name="lb_month" id="lb_month">
              <option value="01">มกราคม</option>
              <option value="02">กุมภาพันธ์</option>
              <option value="03">มีนาคม</option>
              <option value="04">เมษายน</option>
              <option value="05">พฤษภาคม</option>
              <option value="06">มิถุนายน</option>
              <option value="07">กรกฎาคม</option>
              <option value="08">สิงหาคม</option>
              <option value="09">กันยายน</option>
              <option value="10">ตุลาคม</option>
              <option value="11">พฤศจิกายน</option>
              <option value="12">ธันวาคม</option>
            </select>
            <%cyear=right(formatdatetime(now(),2),4)%>
            <select name="lb_year" id="lb_year">
              <option value="<%=(cyear-1)-543%>"><%=cyear-1%></option>
              <option value="<%=cyear-543%>" selected="selected"><%=cyear%></option>
            </select>
          </font></div></td>
    </tr>
    <tr>
      <td height="27"><font class="text_normal">เวลาที่ทำการโอน</font></td>
      <td height="27" colspan="5">
          <div align="left"><font class="text_normal">
            <select name="lb_hr" id="lb_hr">
              <%for i_hr= 00 to 23%>
              <%if len(i_hr) = 1 then
		
		  new_date = "0" +Cstr(i_hr) 
		  else 
		  new_date = i_hr
		  end if
		  %>
              <option value="<%=new_date%>"><%=new_date%></option>
              <%next%>
            </select>
            :
            <select name="lb_min" id="la_min">
              <%for i_min= 00 to 59%>
              <%if len(i_min) = 1 then
		
		  new_time= "0" +Cstr(i_min) 
		  else 
		  new_time = i_min
		  end if
		  %>
              <option value="<%=new_time%>"><%=new_time%></option>
              <%next%>
            </select>
        น. </font></div></td>
    </tr>
    <tr>
      <td height="35" valign="top"><font class="text_normal">หมายเหตุ </font></td>
      <td colspan="5" valign="top"><div align="left">
        <textarea name="remark" cols="30" rows="5" id="remark"></textarea>
      </div></td>
    </tr>
    <tr>
      <td valign="top" bordercolor="#FFFFFF">&nbsp;</td>
      <td colspan="5" valign="top"> <div align="left">
        <input type="submit" name="Submit" value="ขั้นตอนถัดไป" />
    </div></td></tr>
    <tr>
      <td colspan="6" valign="top"></td>
    </tr>
  </table>
</form>
<%end if%>

	<!--#include file="inc_footer.asp"-->
</body>
</html>
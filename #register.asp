<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="connect_db.asp"--> 
<head> 
	<title>Chulabook.com mobile</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body>
<%
action=Request("Action")
response.Write action
'If {{Levle 2}}
If Action="ขั้นตอนถัดไป" Then
	level = "2"
End if
%>
<!--#include file="inc_tabbar.asp"-->
<!-- header -->
<font class="text_header">สมัครสมาชิก</font>
<form action="insert-register.asp" method="post">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td colspan="2"><font class="text_normal"><b>ใส่อีเมล์แอดแดรสและรหัสผ่าน</b></font></td>
  </tr>
  <tr>
    <td width="14%">Email</td>
    <td width="86%"><input name="email" type="text" id="email" value="" width="200px"/></td>
  </tr>
  <tr>
    <td>รหัสผ่าน</td>
    <td><input name="password" type="password" id="password" value="" width="200px"/></td>
  </tr>
  <tr>
    <td colspan="2"><font class="text_normal"><b>รายละเอียดส่วนตัว</b></font></td>
    </tr>
  <tr>
    <td>ชื่อ-นามสกุล</td>
    <td><input name="bname" type="text" id="bname" value="" width="200px"/></td>
  </tr>
  <tr>
    <td>เบอร์โทรศัพท์</td>
    <td><input name="bphone" type="text" id="bphone" value="" width="200px"/></td>
  </tr>
  <tr>
    <td> วันเกิด</td>
    <td><select name="bd1" id="bd1">
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
      <select name="bd2" id="bd2">
        <%For i = 1 To 31%>
        <%IF Mid(Birthday, 3, 2) = cStr(i) Then%>
        <option value="<%=i%>" selected="selected"><%=i%>
        <%Else%>
        </option>
        <option value="<%=i%>"><%=i%>
        <%End IF%>
        <%Next%>
        </option>
      </select>
      <select name="bd3" id="bd3" class="form">
        <%For i = 1930 To year(date())%>
        <%IF right(rtrim(Birthday), 4) = cStr(i) Then%>
        <option value="<%=i%>" selected="selected"><%="" & i + 543 & ""%>
        <%Else%>
        </option>
        <option value="<%=i%>"><%="" & i + 543 & ""%>
        <%End IF%>
        <%Next%>
        </option>
      </select></td>
  </tr>
  <tr>
    <td>เพศ</td>
    <td><select name="sl_gender" id = "select3">
      <option value="0">ไม่ระบุ</option>
      <%
		Gender0 = ""
		Gender1 = ""
		Gender2 = ""
	
		SELECT Case (Gender)
		CASE "0"
			Gender0 = "selected"
		CASE "1"
			Gender1 = "selected"
		CASE "2"
			Gender2 = "selected"
		END SELECT
		%>
      <option value="2" <%=Gender2%>>หญิง</option>
      <option value="1" <%=Gender1%>>ชาย</option>
    </select></td>
  </tr>
  <tr>
    <td colspan="2"><font class="text_normal"><b>ที่อยู่สำหรับจัดส่ง</b></font></td>
    </tr>
  <tr>
    <td>ชื่อสถานที่</td>
    <td><input name="splace" type="text" id="splace" value="" size="2" width="200px"/></td>
  </tr>
  <tr>
    <td>เลขที่</td>
    <td><input name="snum" type="text" id="snum" value="" width="200px"/></td>
  </tr>
  <tr>
    <td>หมู่</td>
    <td><input name="smoo" type="text" id="smoo" value="" size="2" width="200px"/></td>
  </tr>
  <tr>
    <td>ตึก/อาคาร/หมู่บ้าน</td>
    <td><input name="sbuilding" type="text" id="sbuilding" value="" width="200px"/></td>
  </tr>
  <tr>
    <td>ตรอก/ซอย</td>
    <td><input name="ssoi" type="text" id="ssoi" value="" size="2" width="200px"/></td>
  </tr>
  <tr>
    <td>ถนน</td>
    <td><input name="sroad" type="text" id="sroad" value="" width="200px"/></td>
  </tr>
  <tr>
    <td>ตำบล/แขวง</td>
    <td><input name="stumbon" type="text" id="stumbon" value="" size="2" width="200px"/></td>
  </tr>
  <tr>
    <td>อำเภอ/เขต</td>
    <td><input name="scity" type="text" id="btumbon" value="" size="2" width="200px"/></td>
  </tr>
  <tr>
    <td><%
	Set RS_Province = Server.CreateObject("ADODB.RecordSet")
	Sql_Province = "SELECT  * FROM province2 WHERE country_code like 'TH' order by province_code"
	RS_Province.Open Sql_Province,conn,1,3
	%>จังหวัด</td>
    <td><select name="sprovince" id="sprovince">
        <%Do While not RS_Province.EOF%>
        <option value="<%=RS_Province("PROVINCE_CODE")%>"><%=RS_Province("TH_NAME")%></option>
        <%
	RS_Province.movenext
	Loop
	%>
      </select></td>
  </tr>
  <tr>
    <td>รหัสไปรษณีย์</td>
    <td><input name="szip" type="text" id="szip" value="" width="200px"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input name="action" type="submit" id="action" value="ยืนยันการสมัคร" data-icon="arrow-r" data-iconpos="right"/></td>
  </tr>
</table>
</form>   
<!--#include file="inc_footer.asp"-->
</body>
</html>
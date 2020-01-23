<%
OrderID = Request.Form("OrderID")
If OrderID ="" then
OrderID = Request.QueryString("OrderID")
End If
Session("OrderID")=OrderID
Set RS = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT OrderID, OrderDate, OrderTime, Amount, SAHC, Name, Address, City, Province, Zip FROM orders WHERE (orderid ='" & Session("orderid") & "')"
RS.Open Sql,conn,1,3
%>
<style type="text/css">
<!--
.style1 {color: #CC00FF}
.style4 {color: #FF0000}
.style5 {color: #CC0066}
-->
</style>

<table width="100%" border="0" cellspacing="2" cellpadding="2" class="text">
<tr>
<td>

  <table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
    <tr>
      <td><div align="left" > <br />
        - กรุณาจดหมายเลขอ้างอิงของท่านไว้ ในกรณีที่ติดต่อกับเจ้าหน้าที่ค่ะ <br />
        - ในกรณี ที่เลือกวิธีชำระเงินเป็นแบบ เก็บเงินสดปลายทาง จะมีเจ้าหน้าที่โทรไปนัดวันเวลาจัดส่งนะคะ <br />
        - หากเลือกวิธีชำระเงินเป็นแบบ โอนเงิน เมื่อทำการโอนเงินเสร็จแล้ว กรุณากรอกแจ้งผลการโอนเงินที่หน้า<br />
&nbsp;        เว็บไซต์ด้วยนะคะ </div></td>
    </tr>
  </table>
  <br>
  
  <!--table width="93%" border="0" align="center" cellpadding="2" cellspacing="2">
    <tr-->
      <!--td bordercolor="#FFFFFF" bgcolor="#F3F3EB"><div align="center" > <br />
          <span class="style1"><span class="style4">เนื่องในโอกาสเทศกาลสงกรานต์ </strong>chulabook.com <br> หยุดทำการตั้งแต่วันที่ 12-16 เมษายน 2562 <br>
สำหรับท่านที่สั่งซื้อและแจ้งผลการชำระเงินระหว่างวันที่ 10-17 เมษายน 2562<br>
ทางเราจะดำเนินการจัดส่งสินค้า ในวันอังคารที่ 17 เมษายน 2562 ค่ะ <br>
จึงขออภัยมา ณ โอกาศนี้ด้วยค่ะ</div>
        <br /></td-->
         <!--td bordercolor="#FFFFFF" bgcolor="#F3F3EB"><div align="center" > <br />
          <span class="style1"><span class="style4">สำหรับท่านที่สั่งซื้อและแจ้งผลการชำระเงินระหว่างวันที่ 30 กรกฎาคม 2558 - 2 สิงหาคม 2558 ทางเราจะดำเนินการจัดส่งสินค้า ในวันจันทร์ที่ 3 สิงหาคม 2558 
จึงขออภัยมา ณ โอกาศนี้ด้วยค่ะ</span></span></div>
        <br /></td-->
         <!--td bordercolor="#FFFFFF" bgcolor="#F3F3EB"><div align="center" > <br />
          <span class="style1"><span class="style4">เนื่องในวันหยุดยาว Chulabook.com หยุดทำการตั้งแต่วันที่ 27-29 กรกฎาคม 2561 (หน้าร้าน สาขาสยามสแควร์ สาขาจัตุรัสจามจุรี สาขาหัวหมาก เปิดทำการปกติ)สำหรับท่านที่สั่งซื้อและแจ้งผลการชำระเงินในช่วงเวลานี้ ลูกค้าจะได้รับสินค้าล่าช้ากว่าปกติ จึงขออภัยมา ณ โอกาสนี้ด้วยค่ะ</span></span></div>
        <br /></td-->
        
          <!--td height="35" class="style5"><strong>เนื่องในโอกาสเทศกาลปีใหม่ Chulabook.com </strong>หยุดทำการตั้งแต่วันที่ 28 ธันวาคม 2562 ถึง 1 มกราคม 2563 (หน้าร้าน สาขาสยามสแควร์ สาขาจัตุรัสจามจุรี เปิดทำการปกติ)สำหรับท่านที่สั่งซื้อและแจ้งผลการชำระเงินในวันที่ 27 ธันวาคม 2562 ถึง 2 มกราคม 2563 ลูกค้าจะได้รับสินค้าล่าช้ากว่าปกติ จึงขออภัยมา ณ โอกาสนี้ด้วยค่ะ</td-->

          <!--td bordercolor="#FFFFFF" bgcolor="#F3F3EB"><div align="center" > <br />
          <span class="style1"><span class="style4">เนื่องจากมีสัมมนาประจำปี Chulabook.com หยุดทำการตั้งแต่วันที่ 20 - 21 ธันวาคม 2562 
 (หน้าร้าน สาขาสยามสแควร์ สาขาจัตุรัสจามจุรี เปิดทำการปกติ)สำหรับลูกค้าที่สั่งซื้อสินค้าผ่านช่องทางออนไลน์วันที่ 19 ธันวาคม 62 เป็นต้นไป ทำการจัดส่งตั้งแต่วันที่ 23 ธันวาคม 62 จึงขออภัยมา ณ โอกาสนี้ด้วยค่ะ</span></span></div>
        <br /></td>
    </tr>
  </table-->  
  
  <br>

<div style="margin: 0pt auto; width: 500px; background-color: rgb(196, 253, 199);  text-align: center" class="rounded">
<table width="100%" cellspacing="2" cellpadding="2" style="border 1px; solid ; color:#000000" class="text">
  <tr> 
    <td width="52%"><div align="right"><b>หมายเลขอ้างอิง (Tracking number)</b></div></td>
    <td width="48%"><div align="left"><b><span style="color:#FF3300"><%=Session("OrderID")%></span></b></div></td>
  </tr>
  <tr>
    <td><div align="right"><b>วันที่ / เวลา ที่สั่งซื้อ</b></div></td>
    <td><div align="left"><%=RS("orderdate")%> / <%=RS("ordertime")%></div></td>
  </tr>
  <tr>
    <td><div align="right"><b>ยอดการสั่งซื้อ</b></div></td>
    <td><div align="left"><%=Formatnumber(RS("amount"),2)%> บาท </div></td>
  </tr>
  <tr>
    <td><div align="right"><b>ค่าขนส่ง</b></div></td>
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
    <td><div align="right"><b>รวมยอดเงิน</b></div></td>
    <td><div align="left"><%=Formatnumber(RS("amount")+RS("SAHC"),2)%> บาท </div></td>
  </tr>
  <tr>
    <td><div align="right"><b>ชื่อ - ที่อยู่ สำหรับรับสินค้า</b></div></td>
    <td><div align="left"><%=RS("name")%></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="left"><%=RS("address")%> <%=RS("city")%></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="left"><%
				Sql_province2 = "SELECT * FROM province2 WHERE PROVINCE_CODE like "&RS("province")&" "
				Set RS_province2 = Server.CreateObject("ADODB.RecordSet")
				RS_province2.Open Sql_province2,conn,1,3
				response.Write RS_province2("TH_NAME")
				%>
        &nbsp; <%=RS("zip")%></div></td>
  </tr>
</table>
<b>


</div>
</td>
</tr>
</table></div>


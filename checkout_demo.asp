<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<%
If  Session("userid") = "" Then
response.Redirect("login.asp") 
End If
%>
<!--#include file="connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<!--#include file="../utf/inc_checkprice.asp"--> 
<!--#include file="../utf/inc_booksale.asp"-->   
<title>Shopping</title> 
<meta http-equiv="Content-Type" content="/html; charset=UTF-8" />
    <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<%
taken = request("taken")
barcode = request("barcode")
price = request("price")


Set RS_Account = Server.CreateObject("ADODB.RecordSet")
Sql_Account = "SELECT * FROM account WHERE (UserID ='" & Session("UserID") & "')"
RS_Account.Open Sql_Account,conn,1,3

' Function Freight Rate
'============================== 

Function ChulabookRate(SubTotal)
		chulabookRate=50

If SubTotal>=700  Then
		chulabookRate=0			
End If
			
End Function
'==============================

'============================== 
Function GetPrice20(Barcode)				
				Set RS3=Server.CreateObject("ADODB.RecordSet")
				sql3=" Select  price - (price*20/100) as price from booklist where barcode='" & barcode & "' "			
				RS3.Open Sql3, Conn, 1, 3
GetPrice20 = Rs3("price")				
End Function
'==============================
%>

<!-- Content -->

<form name="final" method="post" action="final_demo.asp">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td width="2%" bgcolor="#CCCCCC">&nbsp;</td>
    <td width="44%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ชื่อรายการ</font></strong></div></td>
    <td width="8%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ราคา</font></strong></div></td>
    <td width="8%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">จำนวน</font></strong></div></td>
    <td width="9%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ส่วนลด</font></strong></div></td>
    <td width="12%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ราคารวม</font></strong></div></td>
    <td width="12%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">หมายเหตุ</font></strong></div></td>
    </tr>
<%
'Read Loop Items  
'================================================================= 
For p=1 to Session("NOAI")	
				Set RS=Server.CreateObject("ADODB.RecordSet")
				sql=" Select booklist.* from booklist where barcode='" & Session("barcode" & p) & "' "			
				RS.Open Sql, Conn, 1, 3
	Totalprice =  RS("Price") *  Session("taken" & p)
	If Totalprice >= 3000 and Lcase(Rs("disctype"))="c" and RS("disctype1")="1" and RS("language")="1" and Rs("distribute")="2" Then
			special_discount = Totalprice * booksale 'ไปแก้ที่ไฟล์ utf/inc_booksale.asp
	Else
			special_discount = ""
	End if
				  On Error Resume Next 
                  rno=rno+1 
				  If special_discount = "" Then 
				  SubTotal=SubTotal+Session("taken" & p)*Session("Price" & p) 
				  subdiscount = subdiscount + (RS("Price")-Session("price" & p))*Session("taken" & p)
				  Else 
				  SubTotal=SubTotal+FormatNumber(special_discount,2)
				  subdiscount = subdiscount + Formatnumber(((RS("Price"))*Session("taken" & p))-special_discount,2)
				  End if
'IF ERROR 
                  If Err Then
                  	Session.Abandon 
                  	Response.Clear 
                  	Response.Redirect "http://www.chulabook.com" 
                  	Response.End 
                  End If 
' IF ERROR 
%>
   <tr bgcolor="#EFEFEF">
    <td valign="top"><div align="center"><font class="text_normal"><%= rno %></font></div></td>
    <td valign="top" bgcolor="#EFEFEF"><div align="left"><font class="text_normal"><%=RS("title") %><%=RS("title1") %></font>
        <input type="hidden" name="barcode" value="<%= Session("barcode" & p) %>" /></div></td>
    <td valign="top"><div align="center"><font class="text_normal"><%= FormatNumber(RS("Price"),2) %></font></div></td>    
    <td valign="top"><div align="center"><font class="text_normal"><%=Session("taken" & p) %></font></div></td>
    <td valign="top"><div align="center">
	<font class="text_normal">
        <%
	  If special_discount <> "" Then
	  response.Write Formatnumber(((RS("Price"))*Session("taken" & p))-special_discount,2)
	  Else
	  disprice = (RS("Price")-Session("price" & p))*Session("taken" & p)
	  if disprice = 0 Then
	  response.Write "-" 
	  else
	  response.Write Formatnumber((RS("Price")-Session("price" & p))*Session("taken" & p),2)
	  end if
       End if
	  %>
     </font></div></td>
    <td valign="top">
      
      <div align="center"><font class="">
        <%
	  If special_discount <> "" Then
	  price =  FormatNumber(special_discount,2)
	  response.Write price
	  %>
        <input name="price" type="hidden" value="<%=price%>" />
        <%
	  Else
	  response.Write FormatNumber(Session("price" & p) *Session("taken" & p),2)
	  %>
        <input type="hidden" name="price" value="<%=FormatNumber(Session("price" & p),2) %>" />
      <%
	  End if
	  %></font></div></td>
      <td valign="top">
	  <div align="center"><font class="">
	    <%
	If special_discount  <> "" Then
	response.Write text_sale 'ไปแก้ที่ไฟล์ utf/inc_booksale.asp
	End If
	%>
       </font></div></td>
    </tr>
  <%
RS.movenext
Next  
'================================================================= 
%>
   <tr>
     <td>&nbsp;</td>
     <td colspan="6"><div align="right"><font class="text_normal">รวมราคาสินค้า :
     <%=FormatNumber(Subtotal,2)%>
     <%Session("Amount")= FormatNumber(Subtotal,2)%> บาท
   	 [ราคาลดแล้ว]</font></div></td>
     </tr>
   <tr>
     <td>&nbsp;</td>
     <td colspan="6"><div align="right"><font class="text_normal">ส่วนลด :
        <%=Formatnumber(subdiscount,2)%> บาท
      </font></div></td>
     </tr>
   <%If FormatNumber(Subtotal,2) < 700 Then%>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="5"><div align="right"><font class="text_normal">*** เลือกสินค้าเพิ่มอีก <%=(700-FormatNumber(Subtotal,2))%> บาท ฟรีค่าจัดส่ง</font></div></td>
     </tr>
   <%End If%>
 <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="5"><div align="right"><font class="text_normal">ค่าจัดส่ง :
         <%
		 FreightRate = chulabookRate(Subtotal)
		 IF FreightRate <> 0 Then
		 response.Write FormatNumber(chulabookRate(Subtotal),2) &"&nbsp;"& "บาท"
		 Else
		 response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
		 End If
		 %>
        <%Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> 
      </font></div></td>
     </tr>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="5"><div align="right"><font class="text_normal">รวมยอดเงินทั้งสิ้น :
	 <%=FormatNumber(SubTotal+chulabookRate(Subtotal),2)%>
     <%Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> บาท
     </font></div></td>
     </tr>
</table>
<font class="text_normal">เลือกวิธีการชำระเงิน<br>
<input name="PaymentMethod" type="radio" id="radio-choice-1" value="1" checked="checked" />
เก็บเงินสดปลายทาง มีเจ้าหน้าที่จัดส่งถึงบ้าน (เฉพาะกรุงเทพฯ) * เขตที่สามารถจัดส่งได้ <a href="howtosend.asp">คลิกที่นี่</a><br>

<!--input name="PaymentMethod" type="radio" value="2" /> บัตรเครดิต<br /-->

<input type="radio" name="PaymentMethod" id="radio-choice-2" value="4"  />
โอนเงินผ่านธนาคาร<br>

<input type="radio" name="PaymentMethod" id="radio-choice-3" value="6"  />
ธนาณัติ- ตั๋วแลกเงิน</font><br>
<br>
  
              <!-- ขอใบเสร็จลดหย่อนภาษี -->
                <table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
                  <tr>
                    <td class="big-text"><div align="left"><strong><!--img src="images/icons/money.png" width="16" height="16" /-->ขอใบเสร็จลดหย่อนภาษี ตั้งแต่วันที่ 15 ธ.ค. 61 - 16 ม.ค. 62 </strong></div></td>
                    </tr>
                    <tr>
                      <td>
                        <div id="clickme4">
                          <input type="radio" name="status_tax" id="status_tax" value="0" checked/>
                          <font class="text">ไม่ขอใบเสร็จลดหย่อนภาษี<br />
                        </div>
                        <div id="clickme5">
                          <input type="radio" name="status_tax" id="status_tax" value="1" />
                          <font class="text">ขอใบเสร็จลดหย่อนภาษี<br />
                        </div>
                      </td>
                    </tr>
                  
                      <tr>
                        <td>
                          <div id="div2">
                            <table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
                                <tr>
                                  <td><div align="right">ชื่อ-นามสกุล </div></td>
                                  <td><div align="left"><input name="contact_name" id="contact_name" size="20" maxlength="100"/></div></td>
                                </tr>
                                <tr>
                                  <td><div align="right">เลขที่บัตรประชาชนผู้เสียภาษี </div></td>
                                  <td><div align="left"><input name="cardid" id="cardid" size="20" maxlength="13" /></div></td>
                                </tr>
                                <tr>
                                  <td width="40%"><div align="right">ชื่อสถานที่&nbsp; </div></td>
                                  <td width="60%"><div align="left"><input name="add_placename"  id="add_placename" size="20" maxlength="100"/></td>
                              </tr>
                                <tr>
                                  <td><div align="right">เลขที่&nbsp;</div></td>
                                  <td><div align="left"><input name="add_number"  id="add_number" size="5" maxlength="10"/>&nbsp;หมู่ที่ <input name="add_moo"  id="add_moo" size="3" maxlength="5"/></div></td>
                              </tr>
                                <tr>
                                  <td><div align="right">ตึก/อาคาร/หมู่บ้าน </div></td>
                                  <td><div align="left"><input name="add_place" id="add_place"  size="20" /></div></td>
                              </tr>
                                <tr>
                                  <td><div align="right">ตรอก/ซอย  </div></td>
                                  <td><div align="left"><input name="add_soi"  id="add_soi" size="20" />&nbsp;</div></td>
                              </tr>
                                <tr>
                                  <td><div align="right">ถนน </div></td>
                                  <td><div align="left"><input name="add_street"  id="add_street" size="20" /></div></td>
                              </tr>
                                <tr>
                                  <td><div align="right">ตำบล/แขวง </div></td> 
                                  <td><div align="left"><input name="add_district"  id="add_district" size="20" /></div></td>
                              </tr>
                                <tr>
                                  <td><div align="right">อำเภอ/เขต </div></td>
                                  <td><div align="left"><input name="amphur_name"  id="amphur_name" size="20" /></div></td>
                                </tr>
                                <tr>
                                  <td><div align="right">จังหวัด&nbsp;</div></td>
                                  <td class="text_blk1">
                                    <div align="left">
                                      <select name="province" id="province">
                                        <option value="210">กรุงเทพมหานคร</option>
                              <option value="498">กระบี่</option>
                            <option value="271">กาญจนบุรี</option>
                            <option value="343">กาฬสินธุ์</option>
                            <option value="162">กำแพงเพชร</option>
                            <option value="340">ขอนแก่น</option>
                            <option value="522">จันทบุรี</option>
                            <option value="224">ฉะเชิงเทรา</option>
                            <option value="520">ชลบุรี</option>
                            <option value="218">ชัยนาท</option>
                            <option value="336">ชัยภูมิ</option>
                            <option value="503">ชุมพร</option>
                            <option value="157">เชียงราย</option>
                            <option value="150">เชียงใหม่</option>
                            <option value="492">ตรัง</option>
                            <option value="523">ตราด</option>
                            <option value="164">ตาก</option>
                            <option value="226">นครนายก</option>
                            <option value="273">นครปฐม</option>
                            <option value="344">นครพนม</option>
                            <option value="330">นครราชสีมา</option>
                            <option value="497">นครศรีธรรมราช</option>
                            <option value="160">นครสวรรค์</option>
                            <option value="211">นนทบุรี</option>
                            <option value="496">นราธิวาส</option>
                            <option value="155">น่าน</option>
                            <option value="349">บึงกาฬ</option>
                            <option value="331">บุรีรัมย์</option>
                            <option value="213">ปทุมธานี</option>
                            <option value="277">ประจวบคีรีขันธ์</option>
                            <option value="225">ปราจีนบุรี</option>
                            <option value="494">ปัตตานี</option>
                            <option value="212">พระนครศรีอยุธยา</option>
                            <option value="156">พะเยา</option>
                            <option value="500">พังงา</option>
                            <option value="493">พัทลุง</option>
                            <option value="166">พิจิตร</option>
                            <option value="159">พิษณุโลก</option>
                            <option value="276">เพชรบุรี</option>
                            <option value="161">เพชรบูรณ์</option>
                            <option value="154">แพร่</option>
                            <option value="499">ภูเก็ต</option>
                            <option value="345">มหาสารคาม</option>
                            <option value="346">มุกดาหาร</option>
                            <option value="158">แม่ฮ่องสอน</option>
                            <option value="335">ยโสธร</option>
                            <option value="495">ยะลา</option>
                            <option value="338">ร้อยเอ็ด</option>
                            <option value="502">ระนอง</option>
                            <option value="521">ระยอง</option>
                            <option value="270">ราชบุรี</option>
                            <option value="216">ลพบุรี</option>
                            <option value="152">ลำปาง</option>
                            <option value="151">ลำพูน</option>
                            <option value="342">เลย</option>
                            <option value="333">ศรีสะเกษ</option>
                            <option value="347">สกลนคร</option>
                            <option value="490">สงขลา</option>
                            <option value="491">สตูล</option>
                            <option value="278">สมุทรปราการ</option>
                            <option value="275">สมุทรสงคราม</option>
                            <option value="274">สมุทรสาคร</option>
                            <option value="227">สระแก้ว</option>
                            <option value="215">สระบุรี</option>
                            <option value="217">สิงห์บุรี</option>
                            <option value="165">สุโขทัย</option>
                            <option value="272">สุพรรณบุรี</option>
                            <option value="501">สุราษฎร์ธานี</option>
                            <option value="332">สุรินทร์</option>
                            <option value="348">หนองคาย</option>
                            <option value="339">หนองบัวลำภู</option>
                            <option value="214">อ่างทอง</option>
                            <option value="337">อำนาจเจริญ</option>
                            <option value="341">อุดรธานี</option>
                            <option value="153">อุตรดิตถ์</option>
                            <option value="163">อุทัยธานี</option>
                            <option value="334">อุบลราชธานี</option>
                            </select>
                                      </div>
                                    </td>
                                </tr>
                                <tr>
                                  <td ><div align="right">รหัสไปรษณีย์ </div></td>
                                  <td ><div align="left"><input name="zipcode" id="zipcode" size="20" /></div></td>
                                </tr>
                                <tr>
                                  <td ><div align="right">เบอร์บ้าน (02-xxxxxx)</div></td>
                                  <td ><div align="left"><input name="phone_nbr" id="phone_nbr" size="20" maxlength="30"/></div></td>
                                </tr>
                                <tr>
                                  <td ><div align="right">เบอร์มือถือ (08x-xxxxxxx)</div></td>
                                  <td ><div align="left"><input name="mobile_nbr" id="mobile_nbr" size="20" maxlength="30"/></div></td>
                                </tr>
                                <tr>
                                  <td ><div align="right">หมายเหตุ </div></td>
                                  <td ><div align="left"><textarea rows="4" cols="20" name="note"></textarea></div></td>
                                </tr>
                            </table>
                          </div>
                        </td>
                      </tr>
                </table> 
              <!-- end ขอใบเสร็จลดหย่อนภาษี --> 

<input type="submit" name="button" id="button" data-icon="arrow-r" data-iconpos="right" value="ยืนยันการชำระเงิน" />
</form>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="black">
  <tr>
    <td><div align="left"><font class="text_normal"><b>สำหรับท่านที่เลือกชำระเงินเป็นแบบ ธนาณัติ- ตั๋วแลกเงิน</b>
<br />
- โดยสั่งจ่าย ปท.จุฬาลงกรณ์มหาวิทยาลัย ในนาม &quot;ศูนย์หนังสือจุฬาลงกรณ์มหาวิทยาลัย&quot; ถนนพญาไท ปทุมวัน กรุงเทพฯ 10332<br />
- และจ่าหน้าซองถึง ศูนย์หนังสือจุฬาลงกรณ์มหาวิทยาลัย ถนน พญาไท เขต ปทุมวัน กทม.10330(วงเล็บมุมซองว่า สั่งซื้อทางอินเตอร์เนต + หมายเลขอ้างอิงการสั่งซื้อ) <br />
      <br />
      <b>สำหรับท่านที่เลือกชำระเงินเป็นแบบ โอนเงินผ่านธนาคาร</b></font><br />
      <table width="95%" border="0" cellspacing="2" cellpadding="2" class="black">
        <tr>
          <td colspan="3"><font class="text_normal">โอนเข้าบัญชี  ชื่อบัญชี &quot;ศูนย์หนังสือจุฬาลงกรณ์มหาวิทยาลัย&quot; 
      มี 4 ธนาคารให้เลือก</font></td>
          </tr>
        <tr>
          <td width="24%"><font class="text_normal">ธนาคารไทยพาณิชย์</font></td>
          <td width="21%"><font class="text_normal">สาขาสุรวงษ์</font></td>
          <td width="55%"><font class="text_normal">บัญชีเลขที่ 002-2-08292-3</font> </td>
        </tr>
        <tr>
          <td><font class="text_normal">ธนาคารกสิกรไทย</font></td>
          <td><font class="text_normal">สาขาสยามสแควร์</font></td>
          <td><font class="text_normal">บัญชีเลขที่ 026-2-42844-3</font></td>
        </tr>
        <tr>
          <td><font class="text_normal">ธนาคารกรุงเทพ</font></td>
          <td><font class="text_normal">สาขาสยามสแควร์</font></td>
          <td><font class="text_normal">บัญชีเลขที่ 152-0-91525-5</font></td>
        </tr>
        <tr>
          <td><font class="text_normal">ธนาคารกรุงไทย</font></td>
          <td><font class="text_normal">สาขาสยามสแควร์</font></td>
          <td><font class="text_normal">บัญชีเลขที่ 052-1-25100-1</font></td>
        </tr>
      </table>
      </div></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td width="100%" colspan="2"  ><div align="left"><font class="text_normal"><b>ชื่อและที่อยู่ของลูกค้า</b></font></div></td>
  </tr>
  <tr>
    <td colspan="2"><table width="85%" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td width="27%"><div align="right"><font class="text_normal">ชื่อลูกค้า :</font></div></td>
        <td width="73%"><div align="left"><font class="text_normal"><%=RS_Account("BName")%></font></div></td>
        </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ที่อยู่ (เดิม) : </font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("BAddress")%></font></div></td>
        </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ชื่อสถานที่  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("Bplace")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">เลขที่  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("bnum")%>&nbsp;หมู่ที่&nbsp;<%=RS("bmoo")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ตึก/อาคาร/หมู่บ้าน  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("bbuilding")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ตรอก/ซอย  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("bsoi")%>&nbsp;&nbsp;</font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ถนน  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("broad")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ตำบล/แขวง  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("Btumbon")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">อำเภอ/เขต  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("BCity")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">จังหวัด :</font></div></td>
        <td><div align="left"><font class="text_normal">
          <%
				Sql_province2 = "SELECT * FROM province2 WHERE PROVINCE_CODE like "&RS_Account("BProvince")&" "
				Set RS_province2 = Server.CreateObject("ADODB.RecordSet")
				RS_province2.Open Sql_province2,conn,1,3
				response.Write RS_province2("TH_NAME")
				%>
        </font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">รหัสไปรษณีย์ :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("BZip")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ประเทศ :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("BCountry")%></font></div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><div align="right"><a href="profile.asp" class="" class="_narmal">แก้ไขข้อมูลส่วนตัว ที่นี่</a></div></td>
      </tr>
      
      
    </table></td>
  </tr>
  <%If RS("statusupdate") <> 1 then%>
  <%End if%>
</table>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td width="100%"><div align="left"><font class="text_normal"><b>ชื่อและที่อยู่ที่จัดส่งสินค้า</b></font></div></td>
  </tr>
  <tr>
    <td><table width="85%" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td width="27%"><div align="right"><font class="text_normal">ชื่อลูกค้า :</font></div></td>
        <td width="73%"><div align="left"><font class="text_normal"><%=RS_Account("SName")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ที่อยู่ (เดิม): </font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("SAddress")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ชื่อสถานที่  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("splace")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">เลขที่  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("snum")%>&nbsp;หมู่ที่&nbsp;<%=RS_Account("smoo")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ตึก/อาคาร/หมู่บ้าน  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("sbuilding")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ตรอก/ซอย  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("ssoi")%>&nbsp;&nbsp;</font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ถนน  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("sroad")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ตำบล/แขวง  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("Stumbon")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">อำเภอ/เขต  :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("SCity")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">จังหวัด :</font></div></td>
        <td><div align="left"><font class="text_normal">
          <%
				Sql_sprovince2 = "SELECT * FROM province2 WHERE PROVINCE_CODE like "&RS_Account("SProvince")&" "
				Set RS_sprovince2 = Server.CreateObject("ADODB.RecordSet")
				RS_sprovince2.Open Sql_sprovince2,conn,1,3
				response.Write RS_sprovince2("TH_NAME")
				%>
       </font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">รหัสไปรษณีย์ :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("SZip")%></font></div></td>
      </tr>
      <tr>
        <td><div align="right"><font class="text_normal">ประเทศ :</font></div></td>
        <td><div align="left"><font class="text_normal"><%=RS_Account("SCountry")%></font></div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><div align="right"><a href="profile.asp" class="" class="text_normal">แก้ไขข้อมูลการจัดส่ง ที่นี่</a></div></td>
      </tr>
    </table></td>
  </tr>
  <%If RS("statusupdate") <> 1 then%>
  <%End If%>
</table>
  <script src="../assets/jquery-1.4.3.min.js" type="text/javascript"></script>
    
       <script type="text/javascript">
      jQuery(document).ready(function() {
        Layout.init();
        Layout.initUniform();
        Layout.initTwitter();
      });

      $( "#div1" ).hide();
      $( "#div2" ).hide();

      $( "#clickme" ).click(function() {
        $( "#div1" ).show( "slow" );
      });

      $( "#clickme2" ).click(function() {
        $( "#div1" ).hide( "slow" );
      });
    $( "#clickme3" ).click(function() {
        $( "#div1" ).hide( "slow" );
      });
       $( "#clickme4" ).click(function() {
        $( "#div2" ).hide( "slow" );
      });
       $( "#clickme5" ).click(function() {
        $( "#div2" ).show( "slow" );
      });

    </script>
<!-- /Content -->

<!-- /footer --> 
<!--#include file="inc_footer.asp"--> 	
<!-- /footer -->



</body>
</html>
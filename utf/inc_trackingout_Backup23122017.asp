<%
Function PrintMethod(PM)
If PM="1" Then
PrintMethod="เก็บเงินสดปลายทาง (เฉพาะกรุงเทพและเขตพื้นที่การจัดส่ง)"
ElseIf PM="2" Then
PrintMethod="บัตรเครดิต"
ElseIf PM="3" Then
PrintMethod="แฟกซ์แบบฟอร์มตัดบัตรเครดิต"
ElseIf PM="4" Then
PrintMethod="โอนเงินผ่านธนาคาร หรือ ตู้ ATM"
ElseIf PM="5" Then
PrintMethod="ธนาณัติ"
Else
PrintMethod="&nbsp;"
End If
End Function
%>
<%
Sql = "SELECT UserID FROM account WHERE (UserID ='" & Session("UserID") & "')"
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3

OrderID=Request.QueryString("Orderid")

Set RSOrders=Server.CreateObject("ADODB.RecordSet")
RSOrders.Open " SELECT OrderID,name,address,Province,zip,phone,Orderdate,Ordertime,PaymentMethod,Amount,SAHC,orderstatus,remark_cancel,UserID FROM orders Where OrderID='"&OrderID&"'", Conn, 1, 3

If RSOrders.eof then
response.Redirect("no-tracking_out.asp")
End If

Set RSCust=Server.CreateObject("ADODB.RecordSet")
RSCust.Open " SELECT Bname,Baddress,Bcity,Bzip,BProvince,Bphone,Scity,UserID FROM account Where UserID='" & RSOrders("UserID") & "' ", Conn, 1, 3

Set RSPost=Server.CreateObject("ADODB.RecordSet")
RSPost.Open " SELECT orderid,Post_No,Postdate FROM postinformation Where orderid='" & orderid & "' ", Conn, 1, 3
			
					If RSPost.eof Then
					comment = "ไม่มีข้อมูล"
					postdate = "ไม่มีข้อมูล"
					else
					comment = RSPost("Post_No") 
					postdate =  RSPost("Postdate")
					End If
Set RS1=Server.CreateObject("ADODB.RecordSet")
RS1.Open " SELECT OrderID,barcode,Price,Quantity FROM orderdetails Where OrderID='" & OrderID & "'", Conn, 1, 3

Set RS_ChkKerryExpress=Server.CreateObject("ADODB.RecordSet")
RS_ChkKerryExpress.Open " SELECT consignment_no,order_no FROM KerryExpress Where order_no='" & OrderID & "'", Conn, 1, 3

					If RS_ChkKerryExpress.eof Then
						Set RS_ChkMessenger=Server.CreateObject("ADODB.RecordSet")
						RS_ChkMessenger.Open " SELECT qrcode,OrderID FROM post_messenger Where OrderID='" & OrderID & "'", Conn, 1, 3
						
							If RS_ChkMessenger.eof Then
								Set RS_ChkPostInformation=Server.CreateObject("ADODB.RecordSet")
								RS_ChkPostInformation.Open " SELECT Post_no,OrderID FROM PostInformation Where OrderID='" & OrderID & "'", Conn, 1, 3
									
									if RS_ChkPostInformation.eof Then
										Set RS_ChkEbook=Server.CreateObject("ADODB.RecordSet")
										RS_ChkEbook.Open " SELECT OrderID FROM orderdetails Where OrderID='" & OrderID & "' and barcode like '%e'", Conn, 1, 3
										
											if RS_ChkEbook.eof Then
												send_item = "ขนส่งโดยเอกชน"
											else
												send_item = "-"
											end if
									else
										send_item = "จัดส่งโดยไปรษณีย์ไทย เลขที่พัสดุ: "& Replace(RS_ChkPostInformation("Post_no")," ","")&"TH<br>&nbsp;&nbsp;สามารถติดตามสถานะของสินค้าคุณได้ที่ <a href='http://track.thailandpost.co.th/tracking/default.aspx' target='_blank'>Tracking.</a>"
									end if
									
							else
								send_item = "จัดส่งโดยแมสเซนเจอร์ เลขที่พัสดุ: "&RS_ChkMessenger("qrcode")&"<br>&nbsp;&nbsp;สามารถติดตามสถานะของสินค้าคุณได้ที่ <a href='http://www.alphafast.com/track' target='_blank'>Tracking.</a>"
								
							end if
										
					else
						send_item = "จัดส่งโดย Kerry เลขที่พัสดุ: "&RS_ChkKerryExpress("consignment_no")&"<br>&nbsp;&nbsp;สามารถติดตามสถานะของสินค้าคุณได้ที่ <a href='http://th.rnd.kerryexpress.com/shipmenttracking/?pid=CHULA&con="&RS_ChkKerryExpress("consignment_no")&"' target='_blank'>Kerry Tracking.</a>"
					End If


%>

<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#CCCCCC"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" class="blacktext">
      <tr>
        <td height="25" colspan="2" bgcolor="#FF9999"><b>หมายเลขอ้างอิงการสั่งซื้อ  <%= Orderid %></b></td>
      </tr>
      <tr>
        <td width="23%" bgcolor="#FFF2CC"><div align="right">ชื่อผู้สั่งซื้อ : </div></td>
        <td width="77%" height="25" bgcolor="#FFF2CC"><div align="left">&nbsp;&nbsp;คุณ <%= RSCust("Bname") %></div></td>
      </tr>
      <tr>
        <td bgcolor="#FFF2CC"><div align="right">ที่อยู่ : </div></td>
        <td height="25" bgcolor="#FFF2CC"><div align="left">&nbsp; <%=RSCust("Baddress") %>&nbsp;<br>
          &nbsp;&nbsp;อ.<%= RSCust("Bcity") %>&nbsp;<%= RSCust("Bzip") %>&nbsp;&nbsp;จ.<%
						  Set RS33=Server.CreateObject("ADODB.RecordSet")
						 RS33.Open " SELECT PROVINCE_CODE,TH_NAME FROM province2 WHERE PROVINCE_CODE like "&RSCust("BProvince")&" ", Conn, 1, 3
					
						 RESPONSE.Write RS33("TH_NAME")
						 'response.Write RSCust("BProvince")
						 %>&nbsp;&nbsp;เบอร์โทรศัพท์&nbsp;<%=RSCust("Bphone")%></div></td>
      </tr>
      <tr>
        <td bgcolor="#E2F5EC"><div align="right">ชื่อผุ้รับ : </div></td>
        <td height="25" bgcolor="#E2F5EC"><div align="left">&nbsp;&nbsp;คุณ <%= RSOrders("name") %></div></td>
      </tr>
      <tr>
        <td bgcolor="#E2F5EC"><div align="right">ที่อยู่ : </div></td>
        <td height="25" bgcolor="#E2F5EC"><div align="left">&nbsp; <%= RSOrders("address") %>&nbsp;<br>
          &nbsp;&nbsp;อ.<%= RSCust("Scity") %>
        &nbsp;&nbsp;จ.<%
				
						  Set RS34=Server.CreateObject("ADODB.RecordSet")
						 RS34.Open " SELECT PROVINCE_CODE,TH_NAME FROM province2 WHERE PROVINCE_CODE like "&RSOrders("Province")&" ", Conn, 1, 3
					
						 RESPONSE.Write RS34("TH_NAME")
						 'response.Write RSCust("BProvince")
						%>&nbsp;<%= RSOrders("zip") %>&nbsp;เบอร์โทรศัพท์&nbsp;<%=RSOrders("phone")%></div></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF"><div align="right">วันที่ / เวลาที่ทำรายการ : </div></td>
        <td height="25" bgcolor="#FFFFFF"><div align="left">&nbsp;&nbsp;วันที่ <%= Mid(RSOrders("Orderdate"),7,2) %>/<%= Mid(RSOrders("Orderdate"),5,2) %>/<%= Left(RSOrders("Orderdate"),4) %> 
เวลา <%= Mid(RSOrders("Ordertime"),1,2) %>:<%= Mid(RSOrders("Ordertime"),3,2) %>:<%= Mid(RSOrders("Ordertime"),5,2) %> </div></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF"><div align="right">วิธีการชำระเงิน : </div></td>
        <td height="25" bgcolor="#FFFFFF"><div align="left">&nbsp;&nbsp; <%= PrintMethod(RSOrders("PaymentMethod"))%></div></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF"><div align="right">ยอดการสั่งซื้อ : </div></td>
        <td height="25" bgcolor="#FFFFFF"><div align="left">&nbsp;&nbsp; <%= FormatNumber(RSOrders("Amount"),2) %> บาท </div></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF"><div align="right">ค่าจัดส่งสินค้า : </div></td>
        <td height="25" bgcolor="#FFFFFF"><div align="left">&nbsp;&nbsp; 
		<%
		If RSOrders("SAHC") = "" or RSOrders("SAHC") = 0 Then
		response.Write "ซื้อครบ 700 บาท บริการจัดส่งฟรี"
		Else 
		response.Write FormatNumber(RSOrders("SAHC"),2) & "บาท" 
        End If 
        %>
        </div></td>
      </tr>
       <tr>
        <td bgcolor="#FF6347"><div align="right">ยอดเงินที่ต้องชำระ : </div></td>
        <td height="25" bgcolor="#FF6347"><div align="left">&nbsp;&nbsp; 
        <%= FormatNumber(RSOrders("Amount")+RSOrders("SAHC"),2) %> บาท </div></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF"><div align="right">สถานะ : </div></td>
        <td height="25" bgcolor="#FFFFFF"><div align="left">&nbsp;&nbsp;
<% If RSOrders("orderstatus")="0" Then %>
ได้รับข้อมูลสั่งซื้อแล้ว
<% ElseIf RSOrders("orderstatus")="1" Then 
If RSOrders("PaymentMethod") = 4 Then
Set RS_Banktransfer=Server.CreateObject("ADODB.RecordSet")
RS_Banktransfer.Open "SELECT trackno FROM Banktransfer WHERE trackno = '"&RSOrders("orderid")&"' ", Conn, 1, 3
	If RS_Banktransfer.EOF then
	response.Write "ยังไม่ได้รับการแจ้งผลการโอนเงิน"
	Else
	response.Write "กำลังจัดเตรียมสินค้า"
	End If
Else
response.Write "กำลังจัดเตรียมสินค้า"
End If
%>
<% ElseIf RSOrders("orderstatus")="2" Then %>
กำลังจัดเตรียมสินค้า
<% ElseIf RSOrders("orderstatus")="3" Then 
If RSOrders("PaymentMethod") = 4 Then
Set RS_Banktransfer=Server.CreateObject("ADODB.RecordSet")
RS_Banktransfer.Open " SELECT trackno FROM Banktransfer WHERE trackno = '"&RSOrders("orderid")&"' ", Conn, 1, 3
	If RS_Banktransfer.EOF then
	response.Write "ยังไม่ได้รับการแจ้งผลการโอนเงิน"
	Else
	Set RS_Post=Server.CreateObject("ADODB.RecordSet")
	RS_Post.Open " SELECT orderid FROM PostInformation WHERE orderid = '"&RSOrders("orderid")&"' ", Conn, 1, 3
		If Not RS_Post.EOF Then
	response.Write "ส่งสินค้าเรียบร้อยแล้ว"
		Else
	response.Write "กำลังเตรียมจัดส่ง"
		End If
	End If
Else
response.Write "ส่งสินค้าเรียบร้อยแล้ว"
End If
%>
<% ElseIf RSOrders("orderstatus")="4" Then %>
ยกเลิก <%response.Write "เนื่องจาก" & RSOrders("remark_cancel")%>
<% End If %>

        </div>        </td>
      </tr>
      <!--tr>
        <td bgcolor="#FFFFFF"><div align="right">เลขที่พัสดุ : </div></td>
        <td height="25" bgcolor="#FFFFFF"><div align="left">&nbsp;&nbsp;<%=comment%></div></td>
      </tr-->
      <tr>
        <td bgcolor="#FFFFFF"><div align="right">จัดส่งโดย : </div></td>
        <td height="25" bgcolor="#FFFFFF"><div align="left">&nbsp;&nbsp;
			<% if RSOrders("orderstatus")="3" Then 
					response.Write send_item
				else 
					response.Write "-"
				end if
					
			%>
                    
        </div></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF"><div align="right">วันที่ทำการจัดส่งสินค้า :</div></td>
        <td height="25" bgcolor="#FFFFFF">&nbsp;&nbsp;<%=postdate%></td>
      </tr>
    </table></td>
  </tr>
</table>
<br />
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#CCCCCC"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" class="blacktext">
      <tr>
        <td height="25" colspan="6" bgcolor="#66CC66"><div align="center"><b>รายการหนังสือ</b></div></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF"><div align="center"><b>ลำดับ</b> </div></td>
        <td height="25" bgcolor="#FFFFFF"><div align="center"><b>Barcode </b></div></td>
        <td bgcolor="#FFFFFF"><div align="center"><b>รายการสินค้า </b></div></td>
        <td bgcolor="#FFFFFF"><div align="center"><b>ราคา </b></div></td>
        <td bgcolor="#FFFFFF"><div align="center"><b>จำนวน</b></div></td>
        <td bgcolor="#FFFFFF"><div align="center"><b>รวม</b></div></td>
      </tr>          
	  <% CountIndex= 0 %>
          <% Subtotal=0 %>
          <%Do while not  rs1.eof%>
          <% CountIndex=CountIndex+1%>
      <tr>
        <td width="7%" bgcolor="#FFFFFF"><div align="center"><%= CountIndex %></div></td>
        <td width="15%" height="25" bgcolor="#FFFFFF"><div align="center"><%=rs1("barcode")%></div></td>
        <td width="45%" height="25" bgcolor="#FFFFFF">
<div align="left">
&nbsp;&nbsp;
<% 
Set RS2=Server.CreateObject("ADODB.RecordSet")
RS2.Open " SELECT title, title1, barcode FROM booklist Where barcode='" & RS1("barcode") & "'", Conn, 1, 3

If NOT RS2.EOF Then
If RS2("Title") = "" Then response.Write "" else response.Write RS2("Title")&RS2("Title1") end if 
End IF
%>
<%rs2.close%>
<% 

Set RS2=Nothing 

	'sale = (RS1("Price")*RS1("Quantity")*10)/100
	'response.Write sale

%>
</div></td>
        <td width="16%" height="25" bgcolor="#FFFFFF"><div align="center"><%= FormatNumber(RS1("Price"),2) %></div></td>
        <td width="17%" height="25" bgcolor="#FFFFFF"><div align="center"><%=RS1("Quantity") %></div></td>
        <td width="16%" height="25" bgcolor="#FFFFFF"><div align="center"><%= FormatNumber((RS1("Price")*RS1("Quantity")),2) %></div></td>
      </tr>
      <%rs1.movenext
      loop
      rs1.close
      %>
      <tr>
        <td height="25" colspan="6" bgcolor="#FFFFFF"><div align="center">หมายเหตุ : หลังจากวันที่เจ้าหน้าที่ทำการจัดส่งแล้ว ท่านจะได้รับสินค้าประมาณ 3-7 วันทำการนะคะ</div><% Set RSCust=Nothing %></td>
        </tr>
    </table></td>
  </tr>
</table>


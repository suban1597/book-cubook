
<%
cname=Session("Bname")
userid=Session("UserID")


Set RS = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT  * FROM orders WHERE UserID like "&userid&" ORDER BY OrderID DESC "
RS.Open Sql,conn,1,3

If RS.EOF Then
Response.write "ขณะนี้ยังไม่มีประวัติการสั่งซื้อค่ะ"

Else
%>
<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" class="text_normal">
  <tr>
    <td bgcolor="#FFFFFF"><div align="center"><strong>หมายเลขการสั่งซื้อ</strong></div></td>
    <td bgcolor="#FFFFFF"><div align="center"><strong>วันที่สั่งซื้อ</strong></div></td>
    <td bgcolor="#FFFFFF"><div align="center"><strong>จำนวนเงิน</strong></div></td>
    <td bgcolor="#FFFFFF"><div align="center"><strong>สถานะสินค้า</strong></div></td>
    <td bgcolor="#FFFFFF"><div align="center"><strong>เลขที่ไปรษณีย์</strong></div></td>
    <td bgcolor="#FFFFFF"><div align="center"><strong>รายละเอียด</strong></div></td>
  </tr>
  <%Do while not RS.EOF%>
  
  
  <%
  select case  RS("orderstatus")
  case 0
  	row_color = "white"
  case 1
  	row_color = "#FCFF6F"
	
   case 2
  	row_color = "#E4F8E7"	

   case 3
  	row_color = "#FAFCB6"

   case 4
  	row_color = "#FEBEAB"
  end select  
  %>
  
  
  
  <tr>
    <td bgcolor=<%=row_color%>><div align="center"><a href="tracking_out.asp?orderid=<%=RS("orderid")%>" class="text_normal"><%=RS("orderid")%></a></div></td>
    <td bgcolor=<%=row_color%>><div align="center"><%= Mid(RS("Orderdate"),7,2) %>/<%= Mid(RS("Orderdate"),5,2) %>/<%= Left(RS("Orderdate"),4) %> (<%= Mid(RS("Ordertime"),1,2) %>:<%= Mid(RS("Ordertime"),3,2) %>)</div></td>
    <td bgcolor=<%=row_color%>><div align="center">
      <%
		total_amount = RS("amount") + RS("SAHC")
		response.Write Formatnumber(total_amount,2)
		
		Sql_post =  "SELECT* FROM PostInformation Where OrderID like " &RS("Orderid") &" "
		Set RS_post = Server.CreateObject("ADODB.RecordSet")
		RS_post.Open Sql_post,conn,1,3
		%>
    </div></td>
    <td bgcolor=<%=row_color%>><div align="center">
<% 
If RS("orderstatus")=0 Then 
%>
ได้รับข้อมูลสั่งซื้อแล้ว

<% 
ElseIf RS("orderstatus")=1 Then 

If RS("PaymentMethod") = 4 Then
Set RS_Banktransfer=Server.CreateObject("ADODB.RecordSet")
RS_Banktransfer.Open " SELECT * FROM Banktransfer WHERE trackno = "&Rs("orderid")&" ", Conn, 1, 3

	If RS_Banktransfer.EOF then
	response.Write "ยังไม่ได้รับการแจ้งผลการโอนเงิน"
	Else
	response.Write "กำลังจัดเตรียมสินค้า"
	End If
Else
	
response.Write "กำลังจัดเตรียมสินค้า"
End If
%>

<% ElseIf RS("orderstatus")=2 Then %>
กำลังจัดเตรียมสินค้า

<% 
ElseIf RS("orderstatus")=3 Then 

If RS("PaymentMethod") = 4 Then

	Set RS_Post=Server.CreateObject("ADODB.RecordSet")
	RS_Post.Open " SELECT * FROM PostInformation WHERE orderid = '"&RS("orderid")&"' ", Conn, 1, 3
		
		If Not RS.EOF Then
	response.Write "ส่งสินค้าเรียบร้อยแล้ว"
		Else
	response.Write "กำลังเตรียมจัดส่ง"
		End If
	
End If
	
'Else
'response.Write "ส่งสินค้าเรียบร้อยแล้ว"
'End If
%>


<% ElseIf RS("orderstatus")=4 Then %>
ยกเลิก <%response.Write "เนื่องจาก" & RS("remark_cancel")%>

<% End If %>
        </div></td>
  <td bgcolor=<%=row_color%>><div align="center">
		  <%
		If RS_post.eof Then
		response.Write "-"
		else
		response.Write RS_post("Post_no") & "TH"
		end if
		%> </div></td>
    <td bgcolor=<%=row_color%>><div align="center"><a href="tracking_out.asp?orderid=<%=RS("orderid")%>"><img src="images/doc.png" alt="ดูรายละเอียดรายการนี้" border="0" /></a></div></td>
  </tr>
  <%
  RS.movenext
  Loop
  %>
</table>
<%
End If
%>
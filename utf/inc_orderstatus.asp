<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
'Option Explicit
'declare variables
'Dim Currpage, pageLen, lastNumber, PageRem, PageTen
'Dim connection, recordset, sSQL, sConnString, next10, prev10, P
'Dim RSPrevPage, RSNextPage, start 
'Get the current page the user is on, if it's the first time they
'visit and the variable 'PageNo' is empty, then 'CurrPage' gets set to 1
'Else the current page variable 'CurrPage' is set to the page number requested
If IsEmpty(Request.Querystring("PageNo")) then
CurrPage = 1
Else
CurrPage = Cint(Request.Querystring("PageNo"))
End If 



'create an instance of the ADO connection and recordset object
'Set Connection = Server.CreateObject("ADODB.Connection")
Set Recordset = Server.CreateObject("ADODB.Recordset")

'define the connection string
'sConnString = "PROVIDER=SQLOLEDB; DATA SOURCE=Chulabook;INITIAL CATALOG=Chulabook;User ID=sa;Password=;"


'define our SQL variable
cname=Session("Bname")
userid=Session("userid")

sSQL="SELECT  OrderID, OrderDate, OrderTime, Amount, SAHC, orderstatus, PaymentMethod, Credit_approve, remark_cancel FROM orders Where UserID like " &userid &"  and orderstatus<>'9' ORDER BY OrderDate DESC" 

'open an active connection
'Connection.Open sConnString

'Next set the location of the recordset to the client side  
Recordset.CursorLocation = 3

'Execute the SQL and return our recordset
Recordset.open sSQL, Conn
' pagesize is used to set the number of records that will be
' displayed on each page. For our purposes 10 records is what we want.
Recordset.PageSize = 15


'get the next 10 and prev 10 page number
next10 = getNext10(CurrPage)
prev10 = getPrev10(CurrPage)




'If there are no records
If Recordset.EOF Then
Response.write "ขณะนี้ยังไม่มีประวัติการสั่งซื้อค่ะ"

Else
'this moves the record pointer to the first record of the current page
Recordset.AbsolutePage = CurrPage

'the below loop will loop until all the records of the current page have been
'displayed or it has reached the end of the recordset
''Do Until Recordset.AbsolutePage <> CurrPage OR Recordset.Eof

'for our purposes our database has just 3 fields:
'an 'ID' (autonumber field), 'SiteName' (textfield) and 'URL' (memofield)
'you can change these according to your database and table fields
''response.write "Title: " & Recordset ("title") & "<br>"
''response.write "Aothor: " & Recordset ("author") & "<br>"
''response.write "Price: " & Recordset ("price") & "<br><br>" 
''Recordset.MoveNext
''Loop

%>
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" class="blacktext"><tr><td ><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2"  ><tr bgcolor="#92BDFE"><td width="18%" height="20" colspan="6" bgcolor="#FFFFCC"><div align="center">
  <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" class="blacktext">
    <tr>
      <td ><table width="98%" border="0" align="center" cellpadding="2" cellspacing="2"  >
          <tr bgcolor="#92BDFE">
            <td width="14%" height="20" bgcolor="#CABAC0"><div align="center">Order No. </div></td>
            <td width="18%" height="20" bgcolor="#CABAC0"><div align="center">วันที่ทำการสั่งซื้อ</div></td>
            <td width="14%" height="20" bgcolor="#CABAC0"><div align="center">จำนวนเงิน </div>
                <div align="center"></div></td>
            <td width="23%" bgcolor="#CABAC0"><div align="center">สถานะสินค้า</div></td>
            <td width="18%" height="20" bgcolor="#CABAC0"><div align="center">วิธีการชำระเงิน</div></td>
            <td width="13%" height="20" bgcolor="#CABAC0"><div align="center">แจ้งผลโอนเงิน/บัตรเครดิต</div></td>
          </tr>
          <%
Do Until Recordset.AbsolutePage <> CurrPage OR Recordset.Eof
%>

          <tr valign="top" class="artfont">
            <td height="20" bgcolor=#F3F3F3><div align="center"><a href="tracking_out.asp?orderid=<%=Recordset("orderid")%>" class="blacktext"><u><%=Recordset("orderid")%></u></a></div></td>
            <td width="18%" height="20" bgcolor=F3F3F3><div align="center"><%= Mid(Recordset("Orderdate"),7,2) %>/<%= Mid(Recordset("Orderdate"),5,2) %>/<%= Left(Recordset("Orderdate"),4) %> (<%= Mid(Recordset("Ordertime"),1,2) %>:<%= Mid(Recordset("Ordertime"),3,2) %>)</div>
                <div align="left"></div></td>
            <td height="20" bgcolor=F3F3F3>
            	<%
					total_amount = Recordset("amount") + Recordset("SAHC")
					response.Write Formatnumber(total_amount,2)

					
					Sql_post =  "SELECT OrderID FROM PostInformation Where OrderID like '"&Recordset("Orderid")&"' "
					Set RS_post = Server.CreateObject("ADODB.RecordSet")
					RS_post.Open Sql_post,conn,1,3
				%>            
			</td>
		    <td width="23%" height="20" bgcolor=F3F3F3><div align="center">
		        <% 
					If Recordset("orderstatus")="0" Then

					    response.write "ได้รับข้อมูลสั่งซื้อแล้ว"

					ElseIf Recordset("orderstatus")="1" Then 

						If Recordset("PaymentMethod") = 4 Then
						Set RS_Banktransfer=Server.CreateObject("ADODB.RecordSet")
						RS_Banktransfer.Open " SELECT trackno FROM Banktransfer WHERE trackno = '"&Recordset("orderid")&"' ", Conn, 1, 3

							If RS_Banktransfer.EOF then
							response.Write "ยังไม่ได้รับการแจ้งผลการโอนเงิน"
							Else
							response.Write "กำลังจัดเตรียมสินค้า"
							End If

						End If

					ElseIf Recordset("orderstatus")="2" Then 

              			response.write "กำลังจัดเตรียมสินค้า"

					ElseIf Recordset("orderstatus")="3" Then 

						If Recordset("PaymentMethod") = 4 Then
				            Set RS_Banktransfer=Server.CreateObject("ADODB.RecordSet")
				            RS_Banktransfer.Open " SELECT trackno FROM Banktransfer WHERE trackno = '"&Recordset("orderid")&"' ", Conn, 1, 3
				          	   If RS_Banktransfer.EOF then
				          	     response.Write "ยังไม่ได้รับการแจ้งผลการโอนเงิน"
				          	   Else
				          	     Set RS_Post=Server.CreateObject("ADODB.RecordSet")
				          	     RS_Post.Open " SELECT orderid FROM PostInformation WHERE orderid = '"&Recordset("orderid")&"' ", Conn, 1, 3
				            	     If Not RS_Post.EOF Then
				            	       response.Write "ส่งสินค้าเรียบร้อยแล้ว"
				            		    Else
				            	         Set RS_Kerry=Server.CreateObject("ADODB.RecordSet")
				                        RS_Kerry.Open " SELECT order_no FROM KerryExpress WHERE order_no = '"&Recordset("orderid")&"' ", Conn, 1, 3
				                        If Not RS_Kerry.EOF Then
				                        response.Write "ส่งสินค้าเรียบร้อยแล้ว"
				                        else 
				                        response.Write "กำลังเตรียมจัดส่ง"
				                        End If
				            		    End If
				          	   End If
				        Else
				        	response.Write "กำลังเตรียมจัดส่ง"
				        End If

					ElseIf Recordset("orderstatus")="4" Then
						response.Write "ยกเลิก เนื่องจาก" & Recordset("remark_cancel")
					End If 
				%>
            </div></td>
            <%'on error resume next%>
            <td width="18%" height="20" bgcolor=F3F3F3><div align="center">
			<%
				If Recordset("PaymentMethod") = 1 Then
					response.Write "เก็บเงินสดปลายทาง"
				elseif Recordset("PaymentMethod") = 2 Then
					response.Write "บัตรเครดิต"
				elseif Recordset("PaymentMethod") = 4 Then
					response.Write "โอนเงิน"
				elseif Recordset("PaymentMethod") = 6 Then
					response.Write "ธนาณัติ"
				elseif Recordset("PaymentMethod") = 7 Then
					response.Write "QR Code"
				else
					response.Write "-"
				end if
			%>
            </div></td>
            <td width="13%" height="20" bgcolor="F3F3F3"><div align="center">                
				<%
					
					'sql_checkstatus = "SELECT banktransfer.TrackNo AS TrackNo, orders.OrderID AS Orderid FROM orders INNER JOIN banktransfer ON orders.OrderID = banktransfer.TrackNo WHERE (orders.UserID LIKE '"& userid &"') AND (orders.orderstatus <> '9') ORDER BY orders.OrderID DESC"
					sql_checkstatus = "SELECT orders.OrderID AS OrderIDchk , banktransfer.TrackNo AS TrackNochk FROM banktransfer INNER JOIN orders ON banktransfer.TrackNo = orders.OrderID WHERE (banktransfer.TrackNo = '"&Recordset("orderid")&"')"
					Set RS_checkstatus = Server.CreateObject("ADODB.RecordSet")
					RS_checkstatus.Open Sql_checkstatus,conn,1,3
					
					
					If Recordset("PaymentMethod") = 2 Then
					
						If  Recordset("Credit_approve")=1 Then
							response.Write "สำเร็จ"
						'else isNull(Recordset("Credit_approve"))
						else 
							response.Write "ไม่สำเร็จ"
						end if
					elseif Recordset("PaymentMethod") = 7 Then
						If  Recordset("Credit_approve")=1 Then
							response.Write "สำเร็จ"
						else 
							response.Write "ไม่สำเร็จ"
						end if
					elseif Recordset("PaymentMethod") = 1 Then
						response.Write "เก็บเงินสดปลายทาง"
					elseif Not RS_checkstatus.EOF Then
						response.Write "แจ้งโอนแล้ว"
					elseif RS_checkstatus.EOF Then
						response.Write "ยังไม่แจ้งโอน"
					else 
						response.Write "-"
					end if
					'response.Write RS_checkstatus("TrackNochk")
				%>
        </div></td>
          </tr>
          <%
Recordset.MoveNext
Loop

  %>
      </table></td>
    </tr>
  </table>
</div></td>
      </tr>
</table></td>
  </tr>
</table>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
'Paging...................................
'Count All pages
RSPageCount=Recordset.PageCount
response.Write "จำนวนหน้าทั้งหมด  " & RSPageCount & "  ขณะนี้อยู่หน้าที่  " & CurrPage & "<br>"

'the next 2 lines setup the page number for the "previous" and "next" links
RSPrevPage = CurrPage -1
RSNextPage = CurrPage + 1

'find out the number of pages returned in the recordset
'if the Next10 page number is greater than the recordset page count
'then set Next10 to the recordset pagecount
If Next10 > Recordset.PageCount Then
Next10 = Recordset.PageCount
End If

'the variable start determines where to start the page number navigation
' i.e. 1, 10, 20, 30 and so on. 
If prev10 = 1 AND next10 - 1 < 10 Then
start = 1
Else
start = Next10 - 10
If right(start, 1) > 0 Then
start = replace(start, right(start, 1), "0")
start = start + 10
End If
End If
%>

<div class="pagerDRUPAL">
<div class="pager-list">
  <div align="left">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
'This checks to make sure that there is more than one page of results
If Recordset.PageCount > 1 Then
'Work out whether to show the Previous 10 '<<' 
If currpage > 1 Then
response.write("<a href=""orderstatus.asp?PageNo=" & Prev10 & """><<</a> ")
End If
'Work out whether to show the Previous link '<' 
If NOT RSPrevPage = 0 then
response.write("<a href=""orderstatus.asp?PageNo=" & RSPrevPage & """><</a> ")
End If

'Loop through the page number navigation using P as our loopcounter variable 
For P = start to Next10

If NOT P = CurrPage then
response.write("<a href=""orderstatus.asp?PageNo=" & P & """>" & P & "</a> ")
Else
'Don't hyperlink the current page number 
response.write(" <b>" & P & " </b>")
End If
Next
'this does the same as the "previous" link, but for the "next" link
If NOT RSNextPage > Recordset.PageCount Then
response.write("<a href=""orderstatus.asp?PageNo=" & RSNextPage & """>></a> ")
End If

'Work out whether to show the Next 10 '>>' 
If NOT Next10 = Recordset.PageCount Then
response.write(" <a href=""orderstatus.asp?PageNo=" & Next10 & """>>></a>")
End If
End If

'Close the recordset and connection object
Recordset.Close 
Set Recordset = Nothing
Conn.Close
Set Recordset =Nothing 
%>
<%End If%>
  </div>
</div>
</div>
<%
' Remove Item
'========================================
RemoveItem = Request.QueryString("RemoveItem")
if RemoveItem  <> 0  Then
 	Session("barcode" & RemoveItem) = ""
	Session("taken" & RemoveItem)= ""
	Session("Price" & RemoveItem)= ""
	Session("Dis" &  RemoveItem)= ""
End If
'========================================
%>
<%
'Page Description
'========================================
'NOAI  = Number Of Available Item
'========================================



' Set Buffer
'==============================
Response.Buffer=True
Session.Timeout=30 
'==============================


'Global Variable
'==============================
TableWidth = "100%"
'==============================

'Debug Value
'==============================
'
'For Each Item in Request.form
'	Response.write item & " : " & request.form(item) & "<br>"
'Next

	If  not request.form("RemItem") <> "" Then
			RemItem =   request.QueryString("RemItem") 
	Else
			RemItem =   request.Form("RemItem") 		
		
	End If 	
	Response.write  RemItem
'Response.end
'==============================


	'Check Action
'========================================
'Session("harry_flag")  = 0
                     

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


' Add Item To Cart
'========================================
Sub Vectorized(barcode)
If Session("NOAI")="" Then
	NOPI=0
Else
	On Error Resume Next
	NOPI=Session("NOAI")+0
	If Err Then 
		NOPI=0
	End If
End If


NONI=Request.Form(barcode).Count
i=0
j=NOPI

' Harry
'======================
'Session("harry_flag")= 0
'======================


For k=1 to NONI
	If Not (Request.Form("taken")(k)=0)  Then
	i=i+1
	j=j+1
	Session(barcode & j)=Request.Form(barcode)(k)
	Session("taken" & j)=Request.Form("taken")(k)
	Session("Price" & j)=Request.Form("Price")(k)



' Harry
' =====================
'if	Session(barcode & j) = "9789990965605"  or Session(barcode & j) = "9789990965599"  or Session(barcode & j) = "9789999988292"  then
	'Session("harry_flag") = Session("harry_flag")+ 1 
'response.write Session("harry_flag")
'else
	'Session("harry_flag") = 	Session("harry_flag")
'end if
'=====================

	'Session("Dis" & j)=Request.Form("Dis")(k)
	
'	If  Session("Dis" & j)= 2 and (Cint(Session("taken" & j)) * Cint(Session("Dis" & j)) > 3000)then
'		GetPrice20("barcode")
'	End if
	'Session("DiscountRate" & j)=Request.Form("DiscountRate")(k)
	End If
Next	
Session("NOAI")=NOPI+i
End Sub
'========================================



'Recalculate Items
'========================================
Sub Revectorized(barcode)
NCompressed=0
Session("harry_flag")  = 0
For m=1 to Session("NOAI")
	For n=m to Session("NOAI")
		If (Session(barcode & m)=Session(barcode & n)) AND (Not(n=m)) Then
			Session(barcode & n)=Null
			Session("taken" & m)=CInt(Session("taken" & n))			
		End If
	Next
Next
For m=1 to Session("NOAI")
	If Len(Session(barcode & m))>0 Then
	NCompressed=NCompressed+1
	Session(barcode & NCompressed)=Session(barcode & m)
	Session("taken" & NCompressed)=Session("taken" & m)
	Session("Price" & NCompressed)=Session("Price" & m)
	Session("Dis" & NCompressed)=Session("Dis" & m)
	End If
Next
Session("NOAI")=NCompressed
End Sub
'========================================
'Set Variable 
'================================================================= 
                  rno=0 
                  SubTotal=0 
                  'TotalPage=0 
'================================================================= 
%>

<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
  <tr  bgcolor="#92BDFE">
    <td width="4%" height="25" bgcolor="#CABAC0"><div align="center">ลำดับ</div></td>
    <td width="39%" bgcolor="#CABAC0"><div align="center">ชื่อรายการ</div></td>
    <td width="7%" bgcolor="#CABAC0"><div align="center">ราคาปกติ</div></td>
    <td width="7%" bgcolor="#CABAC0"><div align="center">จำนวน</div></td>
    <td width="8%" bgcolor="#CABAC0" ><div align="center">ส่วนลด</div></td>
    <td width="11%" bgcolor="#CABAC0" ><div align="center">ราคารวม [บาท]</div></td>
    <td width="11%" bgcolor="#CABAC0"><div align="center">หมายเหตุ</div></td>
    <td width="4%" bgcolor="#CABAC0"><div align="center">ลบ</div></td>
  </tr>
  <%
'Read Loop Items  
'================================================================= 
For p=1 to Session("NOAI")	
				Set RS=Server.CreateObject("ADODB.RecordSet")
				sql=" Select booklist.* from booklist where barcode='" & Session("barcode" & p) & "' "			
				RS.Open Sql, Conn, 1, 3
	'20% for Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute")="2" 
	Totalprice =  RS("Price")*Session("taken" & p)
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
   <tr bgcolor="#F3F3F3">
    <td><div align="center"><%= rno %></div></td>
    <td bgcolor="#F3F3F3"><div align="left"><%=RS("title") %><%=RS("title1") %>
      <%'response.Write Rs("disctype") & RS("disctype1") & RS("language") & Rs("distribute")%>
        <input type="hidden" name="barcode" value="<%= Session("barcode" & p) %>" />
    </div></td>
    <td><div align="center">
	<%'= FormatNumber(Session("price" & p) ,2) %>
   
    <%= FormatNumber(RS("Price"),2) %>

    </div></td>
    <td><div align="center">
     <%=Session("taken" & p) %>
    </div></td>
    <td>
      
      <div align="center">

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
     </div></td>
    <td>
      
      <div align="center">
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
	  %>
      </div></td><td>
	  <div align="center">
	    <%
	If special_discount  <> "" Then
		response.Write text_sale 'ไปแก้ที่ไฟล์ utf/inc_booksale.asp
	End If
	%>
       </div></td>
    <td><div align="center"><a href="shopping.asp?RemoveItem=<%=p%>"  onclick="return confirm('Delete selected item from your shopping cart? ')"><img src="images/skins/bin.jpg" border="0" /></a></div></td>
  </tr>
  <%
RS.movenext
Next  
'================================================================= 
%>
   <tr>
     <td>&nbsp;</td>
       <td colspan="3"><div align="right">รวมราคาสินค้า :</div></td>
     <td colspan="3">
	   
       <div align="left">&nbsp;&nbsp;&nbsp;<%=FormatNumber(Subtotal,2)%>
        <%Session("Amount")= FormatNumber(Subtotal,2)%> บาท
       <font color="#FF0000">[ราคาลดแล้ว]</font></div></td>
  </tr>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="3"><div align="right">ส่วนลด</div></td>
     <td colspan="3"><div align="left">&nbsp;&nbsp;&nbsp;
       <%
	   response.Write Formatnumber(subdiscount,2)
	   %> บาท
      </div></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="3"><div align="right">ค่าจัดส่ง :</div></td>
     <td colspan="3">
       <div align="left">&nbsp;&nbsp;&nbsp;
         <%
		 FreightRate = chulabookRate(Subtotal)
		 IF FreightRate <> 0 Then
		 response.Write FormatNumber(chulabookRate(Subtotal),2) &"&nbsp;"& "บาท"
		 Else
		 response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
		 End If
		 %>
        <%Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> 
      </div></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="3"><div align="right"><img src="images/icons/cart.png" alt="ร้านหนังสือ"> รวมยอดเงินทั้งสิ้น :</div></td>
     <td colspan="3">
	   <div align="left">&nbsp;&nbsp;&nbsp;<font color="#FF0000"><%=FormatNumber(SubTotal+chulabookRate(Subtotal),2)%>
        <%Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> บาท
     </font></div></td>
   </tr>
</table>

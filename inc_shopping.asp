<%
' Remove Item
'========================================
RemoveItem = Request.QueryString("RemoveItem")

if RemoveItem  <> 0  Then
 	Session("barcode" & RemoveItem) = ""
	Session("taken" & RemoveItem)= ""
	Session("Price" & RemoveItem)= ""
	Session("Dis" &  RemoveItem)= ""
	Response.Redirect("shopping.asp?Action=shopping")
End If
'========================================
%>
<%
'Page Description
'========================================
'NOAI  = Number Of Available Item
'========================================

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
	'Response.write  RemItem
'Response.end
'==============================

'Check Action
'========================================
'If {{  ADD }}
If request("action")="Add" Then

Call Vectorized("barcode")
	Call Revectorized("barcode")
	
	'Call Cumulative("barcode")	
End IF 
'========================================

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

%><body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
  <tr>
    <td width="2%" bgcolor="#CCCCCC">&nbsp;</td>
    <td width="44%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ชื่อรายการ</font></strong></div></td>
    <td width="8%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ราคา</font></strong></div></td>
    <td width="8%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">จำนวน</font></strong></div></td>
    <td width="9%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ส่วนลด</font></strong></div></td>
    <td width="12%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ราคารวม</font></strong></div></td>
    <td width="5%" bgcolor="#CCCCCC"><div align="center"><strong><font class="text_normal">ลบ</font></strong></div></td>
  </tr>
  <%
'Read Loop Items  
'================================================================= 
For p=1 to Session("NOAI")	
				Set RS=Server.CreateObject("ADODB.RecordSet")
				sql=" Select booklist.* from booklist where barcode='" & Session("barcode" & p) & "' "			
				RS.Open Sql, Conn, 1, 3
	'20% for Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute")="2" 
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
                  	Response.Redirect "http://www.chulabook.com/m/index.asp" 
                  '	Response.End 
                  End If 
' IF ERROR 
%>
   <tr bgcolor="#EFEFEF">
    <td valign="top"><div align="center"><%= rno %></div></td>
    <td valign="top" bgcolor="#EFEFEF"><div align="left"><font class="text_normal"><%=RS("title") %><%=RS("title1") %></font>
        <input type="hidden" name="barcode" value="<%= Session("barcode" & p) %>" /></div></td>
    <td valign="top"><div align="center"><font class="text_normal">
    <%= FormatNumber(RS("Price"),2) %></font></div></td>
    <td valign="top"><div align="center">
      <input type="text_blk" size="2" name="taken" value="<%=Session("taken" & p) %>" />
    </div></td>
    <td valign="top">
      
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
    <td valign="top">
      
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
	  %><%
	If special_discount  <> "" Then
	response.Write text_sale 'ไปแก้ที่ไฟล์ utf/inc_booksale.asp
	End If
	%>
       </div>       </td><td><div align="center">
       
       
       <a href="shopping.asp?Action=RemItem&RemoveItem=<%=p%>"  onclick="return confirm('Delete selected item from your shopping cart? ')">
       <img src="images/delete2.png" border="0" /></a></div></td>
  </tr>
  <%
RS.movenext
Next  
'================================================================= 
%>
   <tr>
     <td>&nbsp;</td>
     <td colspan="6"><div align="right"><font class="text_normal">รวมราคาสินค้า : <%=FormatNumber(Subtotal,2)%>
        <%Session("Amount")= FormatNumber(Subtotal,2)%> บาท
    [ราคาลดแล้ว]</font></div></td>
  </tr>
   <tr>
     <td>&nbsp;</td>
     <td colspan="6"><div align="right">ส่วนลด : <%
	  if Formatnumber(subdiscount,2) = 0 then
	  response.Write "ไม่มี"
	  else
	  response.Write Formatnumber(subdiscount,2) & " บาท"
	  end if
	  %>
      </div></td>
  </tr>
   <%If FormatNumber(Subtotal,2) < 700 Then%>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="5"><div align="right"><font color="#FF0033" class="text_normal">*** เลือกสินค้าเพิ่มอีก <%=(700-FormatNumber(Subtotal,2))%> บาท ฟรีค่าจัดส่ง</font></div></td>
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
     <td colspan="5"><div align="right"><font color="#FF0033">รวมยอดเงินทั้งสิ้น :<font class="text_normal"><%=FormatNumber(SubTotal+chulabookRate(Subtotal),2)%>
        <%Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> 
        บาท
</font></font></div></td>
  </tr>
</table>

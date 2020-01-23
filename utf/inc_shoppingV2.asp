<%
' Set Buffer
'==============================
Response.Buffer=True
Session.Timeout=30 
'==============================

' If Remove Item clear all session
'========================================
RemoveItem = Request.QueryString("RemoveItem")
if RemoveItem  <> 0  Then
 	Session("barcode" & RemoveItem) = ""
	Session("taken" & RemoveItem)= ""
	Session("Price" & RemoveItem)= ""
	Session("Dis" &  RemoveItem)= ""
	Session("Ebook" &  RemoveItem)= ""
	Session("book_id" &  RemoveItem)= ""
	Session("un" &  RemoveItem)= ""
End If
'========================================

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
For Each Item in Request.form
	'Response.write item & " : " & request.form(item) & "<br>"
Next

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


Action=Request.QueryString("Action")

If Action="" Then
	Action=Request.Form("Action")
End If

ToRem=Request.QueryString("ToRem")
If ToRem="" Then
	ToRem=Request.Form("ToRem")
End If

'If {{  CheckOut }}
If Action="ขั้นตอนถัดไป>>" Then
	Response.Redirect("delivery.asp")
End if


'If {{  Buy More}}
If Action="<<เลือกสินค้าเพิ่มเติม" Then
	Response.Redirect("home.asp")
End if



'If {{  ADD }}
If Action="add" Then
	Call Vectorized("barcode")
	Call Revectorized("barcode")
	'Call Cumulative("barcode")	

'If {{  UPDATE }}
ElseIf Action="update" Then
	Session("NOAI")=""
	Call Vectorized("barcode")
	'Call Cumulative("barcode")
	If (Session("NOAI")="") OR (Session("NOAI")=0) Then
	Session.Abandon
	End If
Else
	Call Vectorized("barcode")
	Call Revectorized("barcode")
End If

If Session("NOAI")=0 Then
'Session.Abandon
Response.Redirect "EmptyCart.asp"
Response.End
End If
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

' count number of books
NONI=Request.Form(barcode).Count
i=0
j=NOPI


' Create Book Items session
For k=1 to NONI
	If Not (Request.Form("taken")(k)<=0)  Then
	i=i+1
	j=j+1
	Session("barcode" & j)=Request.Form("barcode")(k)
	Session("taken" & j)=Request.Form("taken")(k)
	Session("Price" & j)=Request.Form("Price")(k)
	'Session("Ebook" & j)=Request.Form("ebook")(k)
	
	if (Request.Form("book_id")(k) <> "") then
		Session("book_id" & j)=Request.Form("book_id")(k)
	end if
	
	if (Request.Form("Ebook")(k) <> "") then
		Session("Ebook" & j)=Request.Form("Ebook")(k)
	end if
		
	'response.write Session(barcode & j) & ":" & Session("Ebook" & j) & "<br>"
	'response.write Session(barcode & j) & ":" & Session("Price" & j) & "<br>"
	End If
	
	
Next	

Session("NOAI")=NOPI+i
End Sub
'========================================





Function check_available_item(barcode)
					Set RS10=Server.CreateObject("ADODB.RecordSet")
					sql10=" Select language,sb14_oh+stock_oh+jj_oh+cb_oh as onhand,* from booklist where barcode='" & barcode & "'  "			
					RS10.Open Sql10, Conn, 1, 3
					
					IF NOT RS10.EOF Then
  					Rsbooktype = Rs10("booktype")
					End IF
					
					
					if Rsbooktype = "1" then
					
						if RS10("language")= 1 then
							if  Rs10("onhand") < 3 then
								check_available_item = 0
							else
								check_available_item = 1
							end if
							
						else 
						if RS10("language")= 2 then
							if  Rs10("onhand") < 2 then
								check_available_item = 0
							else
								check_available_item = 1
							end if
						else 
						if RS10("language")= 3 then
							if  Rs10("onhand") < 6 then
								check_available_item = 0
							else
								check_available_item = 1
							end if
						end if
						end if
						end if
						
					if  Rs10("disctype") = "C" and Rs10("distribute") = "2" and Rs10("disctype1") = "1" and Rs10("stock_oh")+Rs10("cb_oh")+Rs10("sb14_oh")+Rs10("jj_oh") >= 2   then				
						check_available_item = 1
							end if
						else
							check_available_item = 1
						end if	

'check_available_item = 1	
					
End Function





'Recalculate Items
'========================================
Sub Revectorized(barcode)
NCompressed=0
For m=1 to Session("NOAI")
	For n=m to Session("NOAI")
		If (Session(barcode & m)=Session(barcode & n)) AND (Not(n=m)) Then
			Session(barcode & n)=Null
			Session("taken" & m)=CInt(Session("taken" & n))			
		End If
	Next
Next



' Create Book Items session
For m=1 to Session("NOAI")
	If Len(Session(barcode & m))>0 Then
	NCompressed=NCompressed+1
	Session(barcode & NCompressed)=Session(barcode & m)
	Session("taken" & NCompressed)=Session("taken" & m)
	Session("Price" & NCompressed)=Session("Price" & m)
	Session("Dis" & NCompressed)=Session("Dis" & m)
	Session("Ebook" & NCompressed)=Session("Ebook" & m)
	Session("book_id" & NCompressed)=Session("book_id" & m)

	' check_available_item
	' ========================================================================
	If check_available_item(Session("barcode" & m)) = 0 Then
		Session("un" & NCompressed) = "0"
	Else
		Session("un" & NCompressed) = "1"
	End If
	' ========================================================================	 
	
	End If
Next
Session("NOAI")=NCompressed
End Sub
'========================================

' Check book list 
'======================================================
ar_count = 0
		
For p=1 to Session("NOAI")
            
    if Len(Session("barcode"&p)) = 13 then 
			
	ar_count = ar_count+1

    end if
Next
'======================================================
'======================================================


'Set Variable 
'================================================================= 
                  rno=0 
                  SubTotal=0 
                  'TotalPage=0 
'================================================================= 

%>

<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
  <tr>
    <td width="2%" bgcolor="#CABAC0">&nbsp;</td>
    <td width="44%" bgcolor="#CABAC0"><div align="center">ชื่อรายการ</div></td>
    <td width="8%" bgcolor="#CABAC0"><div align="center">ราคา</div></td>
    <td width="8%" bgcolor="#CABAC0"><div align="center">จำนวน</div></td>
    <td width="9%" bgcolor="#CABAC0"><div align="center">ส่วนลด</div></td>
    <td width="12%" bgcolor="#CABAC0"><div align="center">ราคารวม</div></td>
    <td width="12%" bgcolor="#CABAC0"><div align="center">หมายเหตุ</div></td>
    <td width="5%" bgcolor="#CABAC0"><div align="center">ลบ</div></td>
  </tr>
  <%
  
'Read Loop Items  
'================================================================= 

For p=1 to Session("NOAI")	
is_ebook = 0

				Set RS=Server.CreateObject("ADODB.RecordSet")
if (instr(Session("barcode" & p),"e")) <> 0 then			
				sql=" Select barcode, isbn, price, disctype, disctype1, [language], distribute, title, title1 from booklist where barcode='" & left(trim(Session("barcode" & p)),13) & "' "		
						
else
				sql=" Select barcode, isbn, price, disctype, disctype1, [language], distribute, title, title1 from booklist where barcode='" & Session("barcode" & p) & "' "	
end if


'response.write sql
				
				RS.Open Sql, Conn, 1, 3
				
				
				
				
				
				
				' check available record set
				' ====================================================
				if not rs.eof then
					cur_isbn = RS("isbn")
					
					
					
					
					
					
				
	' check_available_item
	' ========================================================================
	 cur_check_available_item = check_available_item(Session("barcode" & p))

	' ========================================================================

					
			
				if (instr(Session("barcode" & p),"e")) <> 0 then
								Set RS2=Server.CreateObject("ADODB.RecordSet")
								sql2=" Select book_bath_price from Ebooklist where isbn='" & cur_isbn & "' "			
							'response.write Sql2
								RS2.Open Sql2, Conn, 1, 3
									
								If NOT RS2.EOF Then									
									e_price = RS2("book_bath_price")
								End If
									e_price = 0
									is_ebook = 1
									
								
				end if			


if is_ebook = 0 then
		sql_chkbook ="SELECT booksprice.price AS b_price, booklist.distribute AS distribute, booklist.stock_oh, booklist.cb_oh, booklist.sb_oh, booklist.crma_oh, booklist.nu_oh, booklist.sb14_oh, booklist.jj_oh FROM booklist INNER JOIN booksprice ON booklist.barcode = booksprice.barcode where booklist.barcode='" & Session("barcode"&p) & "' "			
		Set RS_chkbook=Server.CreateObject("ADODB.RecordSet")
		RS_chkbook.Open sql_chkbook,conn,1,3
		
		chk_stock = RS_chkbook("sb14_oh")+RS_chkbook("stock_oh")+RS_chkbook("cb_oh")+RS_chkbook("jj_oh")
		'distribute = RS_chkbook("distribute")
		'Session("taken" & p) = 1
		
		'if chk_stock < Session("taken" & p) then
			
			'if RS_chkbook("distribute")=1 or RS_chkbook("distribute")=3 then
				'Session("taken" & p) = chk_stock
				'response.Write "<font color=red>มีสินค้าไม่เพียงพอ กรุณาติดต่อเจ้าหน้าที่ <br> CallCenter โทร. 02-2554433,08-6323-3704</font>"
				'Session("taken" & p) = 1
				'if Session("taken" & p) = 1 then
					'response.Write ""
				'else
				'response.Write "<font color=red>ใน Stock มี "&chk_stock&" เล่ม</font>"
				'response.Write "<font color=red>มีสินค้าไม่เพียงพอ กรุณาติดต่อเจ้าหน้าที่ <br> CallCenter โทร. 02-2554433,08-6323-3704</font>"
				'alert("มีสินค้าไม่เพียงพอ กรุณาติดต่อเจ้าหน้าที่ 02-2554433")
				'end if
			'end if
			'response.Redirect "http://www.chulabook.com/shopping_nut.asp"	
			'Session("price" & p) = RS_chkbook("b_price")
		'end if
end if

' calculate "Totalprice"
if is_ebook = 1 then
	Totalprice =  e_price *  Session("taken" & p)
else
	Totalprice =  RS("Price") *  Session("taken" & p)	
end if	
	
' calculate "Totalprice with discount (more than 3,000 bath)"	
	If Totalprice >= 3000 and Lcase(Rs("disctype"))="c" and RS("disctype1")="1" and RS("language")="1" and Rs("distribute")="2" Then
			special_discount = Totalprice * booksale 'ไปแก้ที่ไฟล์ utf/inc_booksale.asp
	Else
			special_discount = ""
	End if
	
	On Error Resume Next 
                  rno=rno+1 
				  
				
			
			
	
if cur_check_available_item = 1  then  
	  
				  If special_discount = "" Then 
					  SubTotal=SubTotal+Session("taken" & p)*Session("Price" & p) 
					  
					  if is_ebook = 1 then
					  subdiscount =  subdiscount + 0
					  else
					  subdiscount = subdiscount + (RS("Price")-Session("price" & p))*Session("taken" & p)
					  end if
					  
				  Else 
					  SubTotal=SubTotal+FormatNumber(special_discount,2)
					  
					  if is_ebook = 1 then
					  subdiscount =  subdiscount + 0
					  else					  
					  subdiscount = subdiscount + Formatnumber(((RS("Price"))*Session("taken" & p))-special_discount,2)
					  end if
					  
				  End if
end if				  
				  
				  
'IF ERROR 
                  If Err Then
                  	Session.Abandon 
                  	Response.Clear 
                  	Response.Redirect "http://www.chulabook.com" 
                  	Response.End 
                  End If 
' IF ERROR 
%>






<!-- Begin Render Data -->

<% 

'full_title = RS("title")+RS("title1")
'
'
'if is_ebook = 0 then
''	
'	table_book = table_book + "<tr>"	
'	table_book = table_book + "<td>"
'	table_book = table_book  + full_title 
'	table_book = table_book + "<td>"
'	table_book = table_book + "<td>"
'	table_book = table_book  + full_title 
'	table_book = table_book + "<td>"	
'	table_book = table_book + "</tr>"
'	
'else
'	table_book = table_book + "<tr>"	
'	table_book = table_book + "<td>"
'	table_book = table_book  + full_title 
'	table_book = table_book + "<td>"
'	table_book = table_book + "<td>"
'	table_book = table_book  + full_title 
'	table_book = table_book + "<td>"	
'	table_book = table_book + "</tr>"
'end if

%>

<% col="#FFEEDD" %>

   <tr bgcolor="#EFEFEF">
    <td valign="top" <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%> ><div align="center"><%= rno %></div></td>
    <td valign="top" <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%> ><div align="left">
    
    
    <%
	 if cur_check_available_item = 0  then  
		response.write "<s>"
	 end if 
	%>
    
	<%=RS("title") %><%=RS("title1") %>
	<% if is_ebook = 1  then 
			response.write "<div class='ebook'>(Ebook อ่านบน Application CU-eBook Store เท่านั้น อ่านได้ทั้งในระบบ IOS และ Android)(ไม่สามารถพิมพ์ออกมาอ่านได้)</div>"  
		end if
		'response.Write "("&chk_stock&")"
		if Session("taken" & p) < chk_stock or Session("taken" & p) = 1 then
			response.Write ""
			'Session("taken" & p) = 1
		else
			response.Write "<font color=red>**สินค้าในสต๊อกไม่เพียงพอ กรุณาติดต่อเจ้าหน้าที่ก่อนชำระเงิน CallCenter 02-2554433,08-6323-3704</font>"
			'Session("taken" & p) = 0
		end if

		if Session("barcode" & p) = "9786161821845" OR Session("barcode" & p) = "9789990126938" OR Session("barcode" & p) = "9786167997452" OR Session("barcode" & p) = "9789990126891" OR Session("barcode" & p) = "9786162137082" OR Session("barcode" & p) = "9786168045077" OR Session("barcode" & p) = "9789990126914" OR Session("barcode" & p) = "9789990126877" OR Session("barcode" & p) = "9789990126709" OR Session("barcode" & p) = "9789990126396" OR Session("barcode" & p) = "9770125685956 " Then
				response.Write "<font color=red>***สินค้าสั่งจอง</font>"
		'else if Session("barcode" & p) = "9786163626790" Then
				'response.Write "<font color=red>***สินค้ารอพิมพ์ใหม่ จะเข้าปลายเดือนพฤษภาคมนี้</font>"
		'end if
		end if

		'if Session("barcode" & p) = "9786167441610" Then
		''	response.Write "<font color=red>***จะได้สินค้าประมาณสิ้นเดือนมีนาคม 2561</font>"
		'end if
	%>
    <%
	 if cur_check_available_item = 0  then  
		response.write "</s> <font color='red'>* ขออภัย สินค้าหมดค่ะ</font>"
	 end if 
	%>
       
    <%'response.Write ( Rs10("onhand"))&":"&cur_check_available_item %>
    <%'response.Write Rs("disctype") & RS("disctype1") & RS("language") & Rs("distribute")%>
      
    <%
	 if cur_check_available_item = 1  then  	
	%>      
        <input type="hidden" name="barcode" value="<%= Session("barcode" & p) %>" />  
    <%    
	 end if  
	%>
    </div></td>
    <td valign="top" <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%> ><div align="center">
	<%'= FormatNumber(Session("price" & p) ,2) %>
   
    <%
	if is_ebook = 1 then
		response.write FormatNumber(Session("price" & p) ,2)
	else 	
		if cur_check_available_item = 0 then  
			response.write "<s>"
		end if	
			response.write FormatNumber(RS("Price"),2) 
		if cur_check_available_item = 0 then  
			response.write "</s>"			
		end if			
	end if
	%>

    </div></td>
    
    <td valign="top" <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%> ><div align="center">
    
    <% 
	IF is_ebook = 1 then
	%>
    <input type="text_blk" size="2" name="taken" value="1"  readonly="readonly"/>
<%
	ELSE
	
        if cur_check_available_item = 0 then  
    %>
    		<input type="text_blk" size="2" name="taken" value="0" disabled="disabled"/>    
    <%
        else   
    %>
    		<input type="text_blk" size="2" name="taken" value="<%=Session("taken" & p) %>" maxlength="3"/>
    <%
    	end if
		
	END IF
	%>
    
    </div></td>
    
    <td valign="top" <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%> >
      
      <div align="center">
      
      <% if is_ebook = 0 then %>
      <%
		  If special_discount <> "" Then
	
		  	if cur_check_available_item = 0 then  
				response.write "<s>"
			end if	    
			response.Write Formatnumber(((RS("Price"))*Session("taken" & p))-special_discount,2)
			if cur_check_available_item = 0 then  
				response.write "</s>"
			end if
		  
		  Else
				disprice = (RS("Price")-Session("price" & p))*Session("taken" & p)
				
			  	if disprice = 0 Then
			  		response.Write "-" 
			  	else
			  
					if cur_check_available_item = 0 then  
						response.write "<s>"
					end if	  
				  	response.Write Formatnumber((RS("Price")-Session("price" & p))*Session("taken" & p),2)
					if cur_check_available_item = 0 then  
						response.write "</s>"
					end if	  
			  
			  	end if
		  End if
	  %>
      <% 
	  else 
		  response.Write("-")
	  end if
	  %>
      
     </div></td>
     
    <td valign="top" <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%> >
      
      <div align="center">
      
      <%
	  If special_discount <> "" Then
	  price =  FormatNumber(special_discount,2)
		  if cur_check_available_item = 0 then  		  
		  	response.write "0"		  
		  else	 		  
	  	  	response.Write price
	  	  end if	  
	  %>
      <input name="price" type="hidden" value="<%=price%>" />
      <%
	  Else
	
		  if cur_check_available_item = 0 then  		  
		  	response.write "0"		  
		  else	  		  
		  	response.Write FormatNumber(Session("price" & p) *Session("taken" & p),2)
		  end if			   
	  %>
      <input type="hidden" name="price" value="<%=FormatNumber(Session("price" & p),2) %>" />
      <%
	  End if
	  %>
      
      
       </div>
	   </td><td valign="top" <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%>>
	  <div align="center">
	    <%
		If special_discount  <> "" Then
		response.Write text_sale 'ไปแก้ที่ไฟล์ utf/inc_booksale.asp
		End If
		
'		If  cur_check_available_item = 0  Then
'		Session("barcode" & RemoveItem) = ""
'		Session("taken" & RemoveItem)= ""
'		Session("Price" & RemoveItem)= ""
'		Session("Dis" &  RemoveItem)= ""
'		Session("Ebook" &  RemoveItem)= ""
'		Session("book_id" &  RemoveItem)= ""
'		End If
		
		%>
       </div></td>


    <td <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%>> <div align="center"><a href="shopping.asp?RemoveItem=<%=p%>"  onclick="return confirm('Delete selected item from your shopping cart? ')"><img src="images/skins/bin.jpg" border="0" /></a></div></td>
  </tr>
  <!-- Begin Render Data -->
  
  
  
  
  <%
RS.movenext





' check available record set
' ====================================================	
	 end if

Next  

'
'	table_book = table_book + "</table>"
'	table_ebook = table_ebook + "</table>"
'
'response.write "Book" +  table_book
'response.write "<br><br>EBook" +  table_ebook

'================================================================= 
%>
 <tr>
     <td>&nbsp;</td>
     <td colspan="6"><div align="right">ส่วนลด&nbsp;&nbsp;
        <%=Formatnumber(subdiscount,2)%> บาท
      </div></td>
     <td>&nbsp;</td>
 </tr>
 <tr>
     <td>&nbsp;</td>
     <td colspan="6"><div align="right">รวมราคาสินค้า :
	   
       <font color="red"><b>&nbsp;&nbsp;&nbsp;<%=FormatNumber(Subtotal,2)%>
        <%Session("Amount")= FormatNumber(Subtotal,2)%> บาท </b></font>
     <!--font color="#FF0000">[ราคาลดแล้ว]</font--></div></td>
     <td>&nbsp;</td>
 </tr>
   <%'If FormatNumber(Subtotal,2) < 700 Then%>
   <!--tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="5"><div align="right"><font color="#FF0000">*** เลือกสินค้าเพิ่มอีก <%'=(700-FormatNumber(Subtotal,2))%> บาท ฟรีค่าจัดส่ง</font></div></td>
     <td>&nbsp;</td>
   </tr>
   <%'End If%>
 <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="5"><div align="right">ค่าจัดส่ง&nbsp;&nbsp;
         <%
		 
		 'if ar_count = "0" then
		 
		 'response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
		 
		 'else
		 
		 'FreightRate = chulabookRate(Subtotal)
		 'IF FreightRate <> 0 Then
		 'response.Write FormatNumber(chulabookRate(Subtotal),2) &"&nbsp;"& "บาท"
		 'Else
		 'response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
		 'End If
		 
		 'end if
		 
		 %>
        <%'Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> 
      </div></td>
     <td>&nbsp;</td>
 </tr-->
   <!--tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="5"><div align="right">รวมยอดเงินทั้งสิ้น :
	  &nbsp;&nbsp;&nbsp;<font color="#FF0000">
      
      <% 'if ar_count = "0" then %>
      
	  <%'=FormatNumber(SubTotal,2)%>
      <%'Session("SAHC")=FormatNumber("0",2)%> บาท
      
      <% 'else %>
      
	  <%'=FormatNumber(SubTotal+chulabookRate(Subtotal),2)%>
      <%'Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> บาท      
      
      <% 'end if %>
      
     </font></div></td>
     <td>&nbsp;</td>
  </tr-->
</table>

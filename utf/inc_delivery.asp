<!--Check Form Value  -->
<script type = "text/javascript" src="http://www.chulabook.com/utf/foul.js"></script>
<script type="text/javascript">
		foul.when('~delivery~ is null','กรุณาเลือกวิธีการชำระเงิน');
</script>
<!--End Check Form Value  -->
<!--#include file="..\includes\sqlinjection.asp"-->
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
If Action="Next>>" Then
	Response.Redirect("CheckOutV2.asp")
End if


'If {{  Buy More}}
If Action="<< Buy more books" Then
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
	If Not (Request.Form("taken")(k)=0)  Then
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
					sql10=" Select language,sb_oh+sb14_oh+stock_oh+jj_oh as onhand,* from booklist where barcode='" & barcode & "'  "			
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
							if  Rs10("onhand") < 1 then
								check_available_item = 0
							else
								check_available_item = 1
							end if
						else 
						if RS10("language")= 3 then
							if  Rs10("onhand") < 3 then
								check_available_item = 0
							else
								check_available_item = 1
							end if
						end if
						end if
						end if
						
					if  Rs10("disctype") = "C" and Rs10("distribute") = "2" and Rs10("disctype1") = "1" and Rs10("stock_oh")+Rs10("sb_oh")+Rs10("cb_oh")+Rs10("stock_oh") > 3   then				
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
  </tr>
  <%
'Read Loop Items  
'================================================================= 

For p=1 to Session("NOAI")	
is_ebook = 0

				Set RS=Server.CreateObject("ADODB.RecordSet")
if (instr(Session("barcode" & p),"e")) <> 0 then			
				sql=" Select booklist.* from booklist where barcode='" & left(trim(Session("barcode" & p)),13) & "' "		
						
else
				sql=" Select booklist.* from booklist where barcode='" & Session("barcode" & p) & "' "	
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
						sql_chkbook ="SELECT *, booksprice.price AS b_price , booklist.distribute AS distribute FROM booklist INNER JOIN booksprice ON booklist.barcode = booksprice.barcode where booklist.barcode='" & Session("barcode"&p) & "' "			
						Set RS_chkbook=Server.CreateObject("ADODB.RecordSet")
						RS_chkbook.Open sql_chkbook,conn,1,3
						
						chk_stock = RS_chkbook("sb_oh")+RS_chkbook("sb14_oh")+RS_chkbook("stock_oh")+RS_chkbook("cb_oh")
						'distribute = RS_chkbook("distribute")
						'Session("taken" & p) = 1
						
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
	<% 
		if is_ebook = 1  then 
			response.write "<div class='ebook'>(Ebook อ่านบน Application CU-eBook Store เท่านั้น อ่านได้ทั้งในระบบ IOS และ Android)(ไม่สามารถพิมพ์ออกมาอ่านได้)</div>"  
		end if

		if Session("taken" & p) < chk_stock or Session("taken" & p) = 1 then
			response.Write ""
			'Session("taken" & p) = 1
		else
			response.Write "<font color=red>**สินค้าในสต๊อกไม่เพียงพอ กรุณาติดต่อเจ้าหน้าที่ก่อนชำระเงิน CallCenter 02-2554433,08-6323-3704</font>"
			'Session("taken" & p) = 0
		end if

		if Session("barcode" & p) = "9786161821845" OR Session("barcode" & p) = "9789990126938" OR Session("barcode" & p) = "9786167997452" OR Session("barcode" & p) = "9789990126891" OR Session("barcode" & p) = "9786162137082" OR Session("barcode" & p) = "9786168045077" OR Session("barcode" & p) = "9789990126914" OR Session("barcode" & p) = "9789990126877" OR Session("barcode" & p) = "9789990126709" OR Session("barcode" & p) = "9789990126396" OR Session("barcode" & p) = "9770125685956 " OR Session("barcode" & p) = "9786161822545" Then
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
    		<input type="text_blk" size="2" name="taken" value="<%=Session("taken" & p) %>" readonly="readonly" />
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
       </div>	   </td><td valign="top" <%if is_ebook = 1 then%>bgcolor="<%=col%>"<% end if%>> 
	  <div align="center">
	    <%
		'response.Write "w1:" & (RS("weight"))
		'response.Write "s:" & Session("taken" & p)

		weight2 = RS("weight")


		if RS("weight") = 0 and RS("page") = 0 Then
					
			if RS("language") = 1 and RS("cover") = 1 Then
				weight2	 = 708	
			else if RS("language") = 1 and RS("cover") = 2 Then
				weight2	 = 1200
			else if RS("language") = 2 and RS("cover") = 1 Then
				weight2	 = 1016
			else if RS("language") = 2 and RS("cover") = 2 Then
				weight2	 = 1672

			end if
			end if
			end if
			end if


		else if RS("weight") = 0 Then
		
			if RS("language") = 1 and RS("cover") = 1 Then
				weight2 = RS("page")*1.7
			else if RS("language") = 1 and RS("cover") = 2 Then			
				weight2 = RS("page")*2.5
			else if RS("language") = 2 and RS("cover") = 1 Then
				weight2 = RS("page")*2.0
			else if RS("language") = 2 and RS("cover") = 2 Then
				weight2 = RS("page")*2.8
			end if
			end if
			end if
			end if

		end if
		end if

		'response.write "w2:" & weight2
		
		weight = weight + weight2 * Session("taken" & p)
		
		if weight<=5000 then
			total_weight = weight+300
		else 
			total_weight = weight+1020
		end if
		
		
		
		
		If special_discount  <> "" Then
		response.Write text_sale
		'response.Write "ซื้อครบ 3,000 ลด 20%"
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
  </tr>
  <!-- Begin Render Data -->
  
  
  
  
  <%

	if Session("barcode" & p) = "9786161821845" OR Session("barcode" & p) = "9789990126938" OR Session("barcode" & p) = "9786167997452" OR Session("barcode" & p) = "9789990126891" OR Session("barcode" & p) = "9786162137082" OR Session("barcode" & p) = "9786168045077" OR Session("barcode" & p) = "9789990126914" OR Session("barcode" & p) = "9789990126877" OR Session("barcode" & p) = "9789990126709" OR Session("barcode" & p) = "9789990126396" OR Session("barcode" & p) = "9770125685956 " OR Session("barcode" & p) = "9786161822545" Then
  		chk_bar1 = 1
  	else 
  		chk_bar2 = 1
  	end if

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
     <td colspan="6"><div align="right">ส่วนลด&nbsp;&nbsp; <%=Formatnumber(subdiscount,2)%> บาท </div></td>
 </tr>
   <tr>
     <td>&nbsp;</td>
     <td colspan="6"><div align="right">รวมราคาสินค้า :
	   
       <font color="red"><b>&nbsp;&nbsp;&nbsp;<%=FormatNumber(Subtotal,2)%>
       <%Session("Amount")= FormatNumber(Subtotal,2)%>
บาท</b></font></div></td>
 </tr>
   <%If FormatNumber(Subtotal,2) < 700 Then%>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td colspan="5">&nbsp;</td>
  </tr>
   <%End If%>
</table>

<%
	if is_ebook = 0 then
	Session("PaymentMethod") = Request.Form("PaymentMethod")
	Set RS = Server.CreateObject("ADODB.RecordSet")
	'Sql = "SELECT * FROM account WHERE (UserID ='" & Session("UserID") & "')"
	Sql = "SELECT Userid, SZip, SPhone, Sname FROM Account WHERE (Userid = '" & Session("UserID") & "')"
	RS.Open Sql,conn,1,3
%>
	<form id="form1" name="form1" method="post" onsubmit="return(foul.validate(this))" action="checkoutV2.asp">
		<input name="chk_bar1" type="hidden" value="<%=chk_bar1%>" />
		<input name="chk_bar2" type="hidden" value="<%=chk_bar2%>" />
	    <!--form id="form1" name="form1" method="post" onsubmit="return(foul.validate(this))" action="../final_ebook.asp"-->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
	          <tr>
	            <td colspan="2" >&nbsp;</td>
	          </tr>
	          <tr>
	            <td class="big-text"><div align="left"><strong><img src="images/icons/money.png" width="16" height="16" /> เลือกวิธีการจัดส่งสินค้า [
	              Choose the method of delivery]</strong></div></td>
	          </tr>
	          <% 'response.write "total" & total_weight %>
	          <tr>
	            <td class="blacktext"><div align="left">
	               
	        <% if total_weight<=5000 then %>
	          		<div id="clickme2">
	           		<input name="delivery" type="radio" id="delivery" value="1" />
	                <font class="text">จัดส่งโดยแมสเซนเจอร์ เฉพาะกรุงเทพฯและปริมณฑล พื้นที่สามารถจัดส่งได้<a href="howtosend.asp" target="_blank">คลิกที่นี่</a>   </font><font color="red"><br />
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ค่าจัดส่ง :
					<%
					 if ar_count = "0" then
					 response.Write "<input name='SAHC0' type='hidden' value='0' />"
					 response.Write "<font color=red>ฟรีค่าจัดส่ง</font><br>"
					 
					 else
					 
					 FreightRate = chulabookRate(Subtotal)
					 if FreightRate <> 0 Then
					 response.Write FormatNumber(chulabookRate(Subtotal),2) &"&nbsp;"& "บาท"
					 response.Write "<input name='SAHC0' type='hidden' value='50' />"
					 else
					 response.Write "<font color=red>ฟรีค่าจัดส่ง</font><br>"
					 response.Write "<input name='SAHC0' type='hidden' value='0' />"
					 end if
					 end if
					 
					 %></font>
	                <% If FormatNumber(Subtotal,2) < 700 Then %> 
	                		<font color="#FF0000">บาท เลือกสินค้าอีก <%=(700-FormatNumber(Subtotal,2))%></font><font color="red"> บาท จัดส่งฟรี</font>
					<% End If %>
	                </div>

	                <div id="clickme3">
	                <input name="delivery" type="radio" id="delivery" value="2" />
	                <font class="text">พัสดุลงทะเบียน </font><font color="red">ค่าจัดส่ง :</font>
	                <%
			 
					 if ar_count = "0" then
					 response.Write "<input name='SAHC1' type='hidden' value='0' />"
					 response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
					 
					 else
					 
					 FreightRate = chulabookRate(Subtotal)
					 IF FreightRate <> 0 Then
					 response.Write "<font color=red>"& FormatNumber(chulabookRate(Subtotal),2) &"&nbsp;"& "บาท</font>"
					 response.Write "<input name='SAHC1' type='hidden' value='50' />"
					 Else
					 response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
					 response.Write "<input name='SAHC1' type='hidden' value='0' />"
					 End If
					 
					 end if
					 
					 %>
	                <% If FormatNumber(Subtotal,2) < 700 Then %>
	                <font color="#FF0000">บาท เลือกสินค้าอีก <%=(700-FormatNumber(Subtotal,2))%></font><font color="red"> บาท จัดส่งฟรี</font>
	                <% End If %>
	                </div>
	                <!--input name="delivery" type="radio" value="3" />
	                <font class="text">พัสดุไปรษณีย์(EMS)</font> <font color="red">ค่าจัดส่ง : 
					< %
					
						if total_weight<=20 then
							SAHC2 = 32
							'response.Write "case 1"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='32' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>20 and total_weight<=100 then
							SAHC2 = 37
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='37' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>100 and total_weight<=250 then
							SAHC2 = 42
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='42' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>250 and total_weight<=500 then
							SAHC2 = 52
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='52' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>500 and total_weight<=1000 then
							SAHC2 = 67
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='67' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>1000 and total_weight<=1500 then
							SAHC2 = 82
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='82' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>1500 and total_weight<=2000 then
							SAHC2 = 97
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='97' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>2000 and total_weight<=2500 then
							SAHC2 = 122
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='122' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>2500 and total_weight<=3000 then
							SAHC2 = 137
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='137' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>3000 and total_weight<=3500 then
							SAHC2 = 157
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='157' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>3500 and total_weight<=4000 then
							SAHC2 = 177
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='177' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>4000 and total_weight<=4500 then
							SAHC2 = 197
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='197' />"
							response.write SAHC &"&nbsp;"& "บาท"
						else if total_weight>4500 and total_weight<=5000 then
							SAHC2 = 217
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='217' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>5000 and total_weight<=5500 then
							SAHC2 = 242
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='242' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>5500 and total_weight<=6000 then
							SAHC2 = 267
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='267' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>6000 and total_weight<=6500 then
							SAHC2 = 292
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='292' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>6500 and total_weight<=7000 then
							SAHC2 = 317
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='317' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>7000 and total_weight<=7500 then
							SAHC2 = 342
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='342' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>7500 and total_weight<=8000 then
							SAHC2 = 367
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='367' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>8000 and total_weight<=8500 then
							SAHC2 = 397
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='397' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>8500 and total_weight<=9000 then
							SAHC2 = 427
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='427' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>9000 and total_weight<=9500 then
							SAHC2 = 357
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='357' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else if total_weight>9500 and total_weight<=10000 then
							SAHC2 = 387
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC2' type='hidden' value='387' />"
							response.write SAHC2 &"&nbsp;"& "บาท"
						else
							SAHC2 = 0
							response.Write "น้ำหนักเกิน"
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						end if
						
					response.Write total_weight
					%></font>
	                <br /-->
	                <% if RS("Szip")=23170 or RS("Szip")=58130 or RS("Szip")=58140 or RS("Szip")=71180 or RS("Szip")=71240 or RS("Szip")=81150 or RS("Szip")=84280 Then
							kerry = 200
						else if RS("Szip")=84360 or RS("Szip")=95000 or RS("Szip")=95110 or RS("Szip")=95120 or RS("Szip")=95130 or RS("Szip")=95140 or RS("Szip")=95150 Then
							kerry = 200
						else if RS("Szip")=95160 or RS("Szip")=95170 or RS("Szip")=96000 or RS("Szip")=96110 or RS("Szip")=96120 or RS("Szip")=96130 or RS("Szip")=96140 Then
							kerry = 200
						else if RS("Szip")=96150 or RS("Szip")=96160 or RS("Szip")=96170 or RS("Szip")=96180 or RS("Szip")=96190 or RS("Szip")=96210 or RS("Szip")=96220 Then
							kerry = 200
						else 
							kerry = 0
						end if
						end if
						end if
						end if
						
						'response.Write RS("Szip")
					%>
	           		<div id="clickme">
	                <input name="delivery" type="radio" id="delivery" value="4" />
	                <font class="text">พัสดุไปรษณีย์ด่วนพิเศษ(kerry Express)</font> <font color="red">ค่าจัดส่ง :
	                <% if total_weight<=1000 then 
							SAHC3 = 70+kerry
							'response.Write "case 1"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=3000 then
							SAHC3 = 80+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=5000 then
							SAHC3 = 110+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=10000 then
							SAHC3 = 150+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=15000 then
							SAHC3 = 220+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=20000 then
							SAHC3 = 260+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else
							SAHC3 = 0
							'response.Write "น้ำหนักเกิน"
						end if
						end if
						end if
						end if
						end if
						end if
						'response.Write total_weight
					 %>
	                </font> <br />
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">(ภายใน 3 วันทำการ หลังจากได้รับหลักฐานการชำระเงินเรียบร้อย)</font><font color="red"><br>
	                 </font>                
	                </div>
	                <div id="div1">               
	                  <font color="red">*หมายเหตุ : เจ้าหน้าที่จะโทรนัดก่อนจัดส่งสินค้า กรุณาให้เบอร์ที่สามารถติดต่อได้ค่ะ </font>
	                  <br />
	                  <!--input type="text" name="textfield" id="textfield" /-->เบอร์โทรของคุณ คือ <% response.Write RS("sphone") %> (<% response.Write RS("sname") %>) <a href="http://www.chulabook.com/profile_kerry.asp">แก้ไขข้อมูลส่วนตัว</a>
	                </div>      
	        <% end if %>  
	         
	        <% if total_weight>5000 and total_weight<=20000 then %>
	        		<div id="clickme2">
	         		<input name="delivery" id="delivery" type="radio" value="1" />
	         		<font class="text">จัดส่งโดยแมสเซนเจอร์ เฉพาะกรุงเทพฯและปริมณฑล พื้นที่สามารถจัดส่งได้<a href="howtosend.asp" target="_blank">คลิกที่นี่</a>   </font><font color="red"><br />
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ค่าจัดส่ง :
	            	<%
					 if ar_count = "0" then
					 response.Write "<input name='SAHC0' type='hidden' value='0' />"
					 response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
					 
					 else
					 
					 FreightRate = chulabookRate(Subtotal)
					 IF FreightRate <> 0 Then
					 response.Write FormatNumber(chulabookRate(Subtotal),2) &"&nbsp;"& "บาท"
					 response.Write "<input name='SAHC0' type='hidden' value='50' />"
					 Else
					 response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
					 response.Write "<input name='SAHC0' type='hidden' value='0' />"
					 End If
					 
					 end if
					 
					 %></font>
	                 </div>
	                 <div id="clickme3">
	                <input name="delivery" type="radio" id="delivery" value="5" />
	                <font class="text">ขนส่งเอกชน</font> <font color="red">ค่าจัดส่ง : ฟรีค่าจัดส่ง</font>
	                </div>
	                <div id="clickme">
	                <input name="delivery" type="radio" id="delivery" value="4" />
	                <font class="text">พัสดุไปรษณีย์ด่วนพิเศษ(kerry Express)</font> <font color="red">ค่าจัดส่ง : 
					<% if total_weight<=1000 then 
							SAHC3 = 70+kerry
							'response.Write "case 1"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=3000 then
							SAHC3 = 80+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=5000 then
							SAHC3 = 110+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=10000 then
							SAHC3 = 150+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=15000 then
							SAHC3 = 220+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else if total_weight<=20000 then
							SAHC3 = 260+kerry
							'response.Write "case 2"
							'Session("SAHC")=FormatNumber((SAHC),2)
							response.Write "<input name='SAHC3' type='hidden' value='"&SAHC3&"' />"
							response.write SAHC3 &"&nbsp;"& "บาท"
						else
							SAHC3 = 0
							'response.Write "น้ำหนักเกิน"
						end if
						end if
						end if
						end if
						end if
						end if
						'response.Write total_weight
					 %></font> 
	                 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">(ภายใน 3 วันทำการ หลังจากได้รับหลักฐานการชำระเงินเรียบร้อย)<br></font>
	                 </div>
	                 <div id="div1">               
	                  <font color="red">*หมายเหตุ : เจ้าหน้าที่จะโทรนัดก่อนจัดส่งสินค้า กรุณาให้เบอร์ที่สามารถติดต่อได้ค่ะ </font>
	                  <br />
	                  <!--input type="text" name="textfield" id="textfield" /-->เบอร์โทรของคุณ คือ <% response.Write RS("sphone") %> (<% response.Write RS("sname") %>) <a href="http://www.chulabook.com/profile_kerry.asp">แก้ไขข้อมูลส่วนตัว</a>
	                </div>
	        <% end if %>
	   
	        <% if total_weight>20000 then %>
	                
	                <input name="delivery" type="radio" id="delivery" value="1" />
	                <font class="text">จัดส่งโดยแมสเซนเจอร์ เฉพาะกรุงเทพฯและปริมณฑล พื้นที่สามารถจัดส่งได้<a href="howtosend.asp" target="_blank">คลิกที่นี่</a>   </font><font color="red"><br />
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ค่าจัดส่ง :
					<%
					 if ar_count = "0" then
					 response.Write "<input name='SAHC0' type='hidden' value='0' />"
					 response.Write "<font color=red>ฟรีค่าจัดส่ง</font><br>"
					 
					 else
					 
					 FreightRate = chulabookRate(Subtotal)
					 if FreightRate <> 0 Then
					 response.Write FormatNumber(chulabookRate(Subtotal),2) &"&nbsp;"& "บาท"
					 response.Write "<input name='SAHC0' type='hidden' value='50' />"
					 else
					 response.Write "<font color=red>ฟรีค่าจัดส่ง</font><br>"
					 response.Write "<input name='SAHC0' type='hidden' value='0' />"
					 end if
					 end if
					 
					 %></font>
	                <input name="delivery" type="radio" id="delivery" value="5" />
	                <font class="text">ขนส่งเอกชน</font> <font color="red">ค่าจัดส่ง : ฟรีค่าจัดส่ง
					</font>
	        <% end if %>
	         
	                 
	              <br />
	                    <% 'if is_ebook = 1 then %>
	                    <!--table cellpadding="2" cellspacing="2" bgcolor="#c56182" >
	                    <tr>
	                      <td colspan="2" bgcolor="#ECE9D8" ><div align="center"><span class="style1">*** กรณีที่ลูกค้า มีรายการสั่งซื้อ E-book จะสามารถชำระเงินผ่านช่่องทางบัตรเครดิตได้เท่านั้น
						  </span></div></td>
	                    </tr>
					</table><br-->
	                    <!--img src="../images/news/songkran2014.jpg" /-->
	                    <%'end if %>
	            
	            
		            <!-- ขอใบเสร็จลดหย่อนภาษี -->
		            <!--table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
		                  <tr>
		            		<td class="big-text"><div align="left"><strong>ขอใบเสร็จลดหย่อนภาษี ตั้งแต่วันนี้ - 31 ธ.ค. 62 <br>(สำหรับบุคลลธรรมดา)</strong></div></td>
		          		  </tr>
		          		  <tr>
		          		  	<td>
		          		  		<div id="clickme4">
			          		  		<input type="radio" name="status_tax" id="status_tax" value="0" checked/>
			                		<font class="text">ไม่ขอใบเสร็จลดหย่อนภาษี<br />
		                		</div>
		                		<div id="clickme5">
			                		<input type="radio" name="status_tax" id="status_tax" value="1" />
			                		<font class="text">ขอใบเสร็จลดหย่อนภาษี <font color="red">(กรุณากรอกที่อยู่ตามบัตรประชาชน จึงจะสามารถนำไปลดหย่อนภาษีได้)</font><br />
		                		</div>
		          		  	</td>
		          		  </tr>
		          		
		                  <tr>
		                    <td>
		                    	<div id="div2">
			                    	<table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
		                      			<tr>
			                       			<td><div align="right">ชื่อ-นามสกุล <font color="red">*</font></div></td>
			                        		<td><div align="left"><input name="contact_name" id="contact_name" size="25" maxlength="100"/></div></td>
		                      			</tr>
		                      			<tr>
			                       			<td><div align="right">เลขที่บัตรประชาชนผู้เสียภาษี <font color="red">*</font></div></td>
			                        		<td><div align="left"><input name="cardid" id="cardid" size="25" maxlength="13" /></div></td>
		                      			</tr>
		                      			<tr>
		                        			<td width="40%"><div align="right">ชื่อสถานที่&nbsp; </div></td>
		                        			<td width="60%"><div align="left"><input name="add_placename"  id="add_placename" size="25" maxlength="100"/></td>
		                  				</tr>
		                      			<tr>
		                        			<td><div align="right">เลขที่&nbsp;</div></td>
		                        			<td><div align="left"><input name="add_number"  id="add_number" size="10" maxlength="10"/>&nbsp;หมู่ที่ <input name="add_moo"  id="add_moo" size="5" maxlength="5"/></div></td>
		                  				</tr>
		                      			<tr>
		                        			<td><div align="right">ตึก/อาคาร/หมู่บ้าน </div></td>
		                        			<td><div align="left"><input name="add_place" id="add_place"  size="25" /></div></td>
		                  				</tr>
		                      			<tr>
		                        			<td><div align="right">ตรอก/ซอย  </div></td>
		                        			<td><div align="left"><input name="add_soi"  id="add_soi" size="25" />&nbsp;</div></td>
		                  				</tr>
		                      			<tr>
		                        			<td><div align="right">ถนน </div></td>
		                        			<td><div align="left"><input name="add_street"  id="add_street" size="25" /></div></td>
		                  				</tr>
		                      			<tr>
		                        			<td><div align="right">ตำบล/แขวง <font color="red">*</font></div></td> 
		                        			<td><div align="left"><input name="add_district"  id="add_district" size="25" /></div></td>
		                  				</tr>
		                      			<tr>
		                        			<td><div align="right">อำเภอ/เขต <font color="red">*</font></div></td>
		                        			<td><div align="left"><input name="amphur_name"  id="amphur_name" size="25" /></div></td>
		                      			</tr>
		                      			<tr>
		                        			<td><div align="right">จังหวัด <font color="red">*</font></div></td>
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
		                        			<td ><div align="right">รหัสไปรษณีย์ <font color="red">*</font></div></td>
		                        			<td ><div align="left"><input name="zipcode" id="zipcode" size="25" /></div></td>
		                        		</tr>
		                        		<tr>
		                        			<td ><div align="right">เบอร์บ้าน (02-xxxxxx)</div></td>
		                        			<td ><div align="left"><input name="phone_nbr" id="phone_nbr" size="25" maxlength="30"/></div></td>
		                      			</tr>
		                      			<tr>
		                        			<td ><div align="right">เบอร์มือถือ (08x-xxxxxxx)<font color="red">*</font></div></td>
		                        			<td ><div align="left"><input name="mobile_nbr" id="mobile_nbr" size="25" maxlength="30"/></div></td>
		                      			</tr>
		                      			<tr>
		                        			<td ><div align="right">หมายเหตุ </div></td>
		                        			<td ><div align="left"><textarea rows="4" cols="30" name="note"></textarea></div></td>
		                      			</tr>
		                  			</table>
		                  		</div>
		                  	</td>
	                	  </tr>
		            </table--> 
		            <!-- end ขอใบเสร็จลดหย่อนภาษี --> 
	                            
	                <p align="center">
	                  <%  'if RS("BAddress") <> "" then %>
	                  <!--input type="image" name="Submit" value="confirm" src="images/button/confirmorder.gif"  border="0" /-->
	                  <!--input name="action" type="button" id="action" value="&lt;&lt; ย้อนกลับ" onClick="http://www.chulabook.com/shopping.asp" /-->
	                  <a href="http://www.chulabook.com/shopping.asp"><input name="action" type="button" id="action" value="&lt;&lt; ย้อนกลับ" onClick="http://www.chulabook.com/shopping.asp" /></a>
	                  <input name="action" type="submit" id="action" value="ขั้นตอนถัดไป &gt;&gt;" />
	                  <% 'else %>
	                  <!--input type="text" value="กรุณาแก้ไขข้อมูลส่วนตัวก่อนทำการสั่งซื้อด้วยค่ะ" /-->
	                </p>
	                <!--table align="center" cellpadding="2" cellspacing="2" bgcolor="#c56182" >
	                  <tr>
	                    <td colspan="2" bgcolor="#ECE9D8" ><div align="center"><span class="style1">*** เนื่องจากข้อมูลของลูกค้า ไม่ครบตามที่ระบบต้องการ <br />
	                      ดังนั้น จึงขอรบกวนลูกค้าทำการแก้ไข ที่อยู่ปัจจุบัน และที่อยู่ที่จัดส่งให้ตรงตามแบบฟอร์มด้านล่าง ก่อนทำการสั่งซื้อสินค้าด้วยนะคะ </span></div></td>
	                  </tr>
	                </table-->
	        		<% 'end if%>
	              <p>&nbsp;</p></td>
	          </tr>
	        </table></td>
	      </tr>
	    </table>
	</form>
	<p align="left">
    </form>
<% else %>
	<form id="form1" name="form1" method="post" onsubmit="return(foul.validate(this))" action="checkoutV2.asp">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      	<td>
           <p align="center">
             <a href="http://www.chulabook.com/shopping.asp"><input name="action" type="button" id="action" value="&lt;&lt; ย้อนกลับ" onClick="http://www.chulabook.com/shopping.asp" /></a>
              <input name="action" type="submit" id="action" value="ขั้นตอนถัดไป &gt;&gt;" />
              <input name="delivery" type="hidden" id="delivery" value="0" />
               </p>
            </td>
      </tr>
    </table>
    </form>

<% end if %>


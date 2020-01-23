
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b><%=Rs_booksetname("topic")%></font></div></td>
  </tr>
</table>
	<%
		if Rs_booksetname("promotionid") = "1197" OR Rs_booksetname("promotionid") = "1202" OR Rs_booksetname("promotionid") = "1203" OR Rs_booksetname("promotionid") = "1204" OR Rs_booksetname("promotionid") = "1205" OR Rs_booksetname("promotionid") = "1206" then
			sql=" SELECT  bl.title,bl.title1,bl.barcode,bb.barcode,bl.price,bl.author,bl.stock_oh,bl.sb14_oh,bl.jj_oh,bl.cb_oh,bl.Language FROM  booklist  as bl , promotion_books as bb WHERE bb.barcode = bl.barcode and (sb14_oh+stock_oh+jj_oh+cb_oh) >= 20 and promotion_id = "&Rs_booksetname("promotionid")&"  "
		else
			sql=" SELECT  bl.title,bl.title1,bl.barcode,bb.barcode,bl.price,bl.author,bl.stock_oh,bl.sb14_oh,bl.jj_oh,bl.cb_oh,bl.Language FROM  booklist as bl , promotion_books as bb WHERE bb.barcode = bl.barcode and (sb14_oh+stock_oh+jj_oh+cb_oh) >= 2 and promotion_id = "&Rs_booksetname("promotionid")&"  "
		end if
		Set RS=Server.CreateObject("ADODB.RecordSet")
		RS.Cursorlocation=3
		RS.open sql, Conn,  3,3,1
		RS.PageSize=20
		PageCount = Request.QueryString("PageCount")
		If PageCount <>"" Then
			PageNumber=PageCount
			If PageNumber < 1 Then PageNumber = 1 End If
		Else
			PageNumber = 1
		End If

		If Not RS.EOF Then 
			RS.AbsolutePage=PageNumber 
	%>
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
		<tr>
		  <td colspan="2"><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b>ข้อมูลหน้าที่</b> <%=PageNumber%></font></div></td>
		</tr>
		<tr>  
			<%
				RSPageCount=RS.PageCount
				Do While Not (RS Is Nothing) 
				CountDown=RS.PageSize
				i = 1
				Do While (Not RS.EOF) and (CountDown>0)

			%>
		    <td width="124" valign="top"><div align="center">
		                  <%On Error Resume Next%>
			<%
				'bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & RS("barcode") &  ".gif"	
				'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("barcode") &  ".gif"		
						'if   ChkFile(bookimgpt) = true then
						''		bookimg = "http://www.chulabook.com/images/books/" & RS("barcode") &  ".gif"				
						'elseif ChkFilebook2(bookimgpt2) = true then
						''		bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".gif"
						'else	
						''		bookimg = "http://www.chulabook.com/images/books/apology.gif"
						'end if


			    bookimgpt = "C:\Chulabook\images\book-400\" & RS("barcode") &  ".jpg" 
				    'bookimgpt2 = "C:\Chulabook\images\book2\" & RS("barcode") &  ".jpg"    
				    if   ChkFile(bookimgpt) = true then
				        bookimg = "images/book-400/" & RS("barcode") &  ".jpg"        
				    'elseif ChkFilebook2(bookimgpt2) = true then
				        'bookimg = "http://203.154.162.41/images/book2/" & RS("barcode") &  ".jpg"
				    else  
				        bookimg = "images/book-400/apology.jpg"
				    end if
		                  
		    %>  
		    <img src="<%=bookimg%>" height="100px" />          
		    </div></td>
		    <td width="809" valign="top">
		    <form id="addtocart" name="addtocart" method="post" action="shopping.asp">
		      <div align="left">
				<a href="description.asp?barcode=<%=RS("barcode")%>" class="blacktext"><b><%=RS("Title")%><%=RS("Title1")%></b></a><br>
				<span class="text">
				ผู้แต่ง : <%=RS("Author")%><br>
				Barcode : <%=RS("Barcode")%><br>
				ราคา : <%=FormatNumber(RS("price"),0)%> บาท<br>  
				ราคาพิเศษ : 
				<% 
				Barcode = RS("Barcode")
				'Dim SpecialPrice
				SpecialPrice = Calculate_Price(Barcode)
				response.Write FormatNumber(SpecialPrice,0)
				%>บาท</span>
				<br>
				<% 
				onhand = RS("stock_oh")+RS("sb14_oh")+RS("jj_oh")+RS("cb_oh")

				if  RS("Language") = 1 Then	
						if onhand >= 2 Then
							oh_type = 1
						else 
							oh_type = 0
						end if	
				else if RS("Language") = 2 Then
						if onhand >= 2 Then
							oh_type = 1
						else 
							oh_type = 0
						end if
				else if RS("Language") = 3 Then
						if onhand >= 6 Then
							oh_type = 1
						else 
							oh_type = 0
						end if
				end if
				end if
				end if

				%>
				      <input name="taken" type="hidden" id="taken" value="1"  />
				      <input type="hidden" name="barcode"  value="<%=barcode%>" />
				      <input type="hidden" name="ebook" value="1" />
				      <input type="hidden" name="book_id" value="null" />
				      <% If SpecialPrice<>"" Then %>
				      <input type="hidden" name="price" value="<%=SpecialPrice %>" />
				      <% Else %>
				      <input type="hidden" name="price" value="<%=price%>" />
				      <% End If %>
				<% if onhand >= 2 Then %>
				      <input type="hidden" name="action" value="Add" />
				      <input type="hidden" name="oh_type" value="<%=oh_type%>" />
				      <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" />
				      <a href="insert_wishlist.asp?barcode=<%=RS("barcode")%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border=0/></a>      
				<% else %>
					  <img src="images/icons/non-cart.png" border="0" name="image2">
				<% end if %>
			  </div>
		    </form></td>
		  <%
			i= i+1
				if i > 2 Then 
				response.Write "</tr>"
				i = 1
				end if
				CountDown=CountDown-1
				RS.MoveNext
				Loop
			Set RS=RS.NextRecordSet
			Loop
		  %>
		  </tr>
		</table>
		<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
		    <td><div align="left">
		      
		      <div align="left">
		        <% itsallpage = rspagecount %> 
		      <span class="text">จำนวนหน้า <%=itsallpage%> หน้า</span><br />
		        <br />
		        <!--<A href="promotion.asp"><< ͹˹</A> -->
		        <%for itscount = 1 to itsallpage %>
		        <%'for itscount = 1 to 13 %>
		        <a href="promotion-detail.asp?pagecount=<%=itscount%>&promotionid=<%=Rs_booksetname("promotionid")%>" class="text"> <%=itscount%></a>
		        <%next%>
		        <!--<A href="#">Ѵ >></A>  -->
		        <br />
		        <br />
		        </div>
		    </div></td>
		  </tr>
		</table>
	<% 
		RS.close 

	else
		response.Write "<p align=center>ไม่มีสินค้าที่ร่วมรายการ</p>"
	End If
	%>


<%
sql=" SELECT  bl.title,bl.title1,bl.barcode,bb.barcode,bl.price,bl.author FROM  booklist  as bl , Bookset_book as bb WHERE bb.barcode = bl.barcode and (sb14_oh+stock_oh+jj_oh+cb_oh) >= 2 and Bookset_Id = 20 "
Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Open  sql, Conn, 1, 3

If RS.EOF Then
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext">ไม่พบข้อมูลหนังสือ</font></div></td>
  </tr>
</table>
<%else%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
<tr>  
<%
i = 1
Do While Not RS.EOF 

%>
    <td width="124" valign="top"><div align="center">
                  <%On Error Resume Next%>
              <%
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
                  
                  <img src="<%=bookimg%>" height="100px"/>
                  
                  
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
      <input name="taken" type="hidden" id="taken" value="1"  />
      <input type="hidden" name="barcode"  value="<%=barcode%>" />
      <% If SpecialPrice<>"" Then %>
      <input type="hidden" name="price" value="<%= SpecialPrice %>" />
      <% Else %>
      <input type="hidden" name="price" value="<%=price%>" />
      <% End If %>
      <input type="hidden" name="action" value="Add" />
      <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" />  
      <a href="insert_wishlist.asp?barcode=<%=RS("barcode")%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border=0/></a>      </div>
    </form></td>
  <%
	i= i+1
		if i > 2 Then 
		response.Write "</tr>"
		i = 1
		end if
		RS.MoveNext
		Loop
  %>
  </tr>
</table>
<%end if%>

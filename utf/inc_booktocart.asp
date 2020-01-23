<form id="addtocart" name="addtocart" method="post" action="shopping.asp">
<%
onhand = CheckOnhand(Barcode)
%>
<div align="left">
<a href="description.asp?barcode=<%=Barcode%>" class="blacktext"><b><%=Title%></b></a><br>
<span class="text">ผู้แต่ง/ผู้แปล : <%=Author%> <%if Translator <> ""  then response.Write Translator end if %><br>
Barcode : <%=Barcode%><br>
ราคา : <%=FormatNumber(Price,0)%> บาท<br>
</span>  
<span class="redtext">
ราคาพิเศษ : 
<% 
SpecialPrice = Calculate_Price(Barcode)
response.Write FormatNumber(SpecialPrice,0)
%> บาท</span><br>

<% 
		if sb_sb14_oh <= 4 Then
			oh_type = 1
		else 
			oh_type = 0
		end if	
%>
    <input name="taken" type="hidden" id="taken" value="1"  />
    <input type="hidden" name="barcode"  value="<%=Barcode%>" />
	<input type="hidden" name="book_id" value="<%=book_id%>" /> 
    <input type="hidden" name="ebook" value="1" />    
    <% If SpecialPrice<>"" Then %>
    <input type="hidden" name="price" value="<%= SpecialPrice %>" />
    <% Else %>
    <input type="hidden" name="price" value="<%=Price%>" />
    <% End If %>
    <input type="hidden" name="action" value="Add" />
    <input type="hidden" name="oh_type" value="<%=oh_type%>" />
    <%if onhand = 1 then%>
    <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" />  
    <%else%>
    <img src="images/icons/cart.png"  border=0 alt="ไม่มีสินค้า"/>
    <%end if%>
    <a href="insert_wishlist.asp?barcode=<%=Barcode%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border=0/></a></div>
    </form>
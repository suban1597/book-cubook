<%
'================Query Top 10 Distributtion Books=======================
	sql="SELECT top 8 * FROM kidhome_book as bs,booklist as bl WHERE bs.barcode=bl.barcode order by bookid desc" 
	Set RS=Server.CreateObject("ADODB.RecordSet")
	RS.Open sql,conn,1,3	
	If not RS.eof Then
%>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
<%
	ic = 0
	Do  while not RS.eof
	
		' Find Book Cover
		' ===================================================================
		'bookimgpt = "D:\Chulabook\images\books\" & RS("barcode") &  ".gif"			
		'if   ChkFile(bookimgpt) = true then
				'bookimg = "http://www.chulabook.com/images/books/" & RS("barcode") &  ".gif"				
		'else
				'bookimg = "http://www.chulabook.com/images/books/apology.gif"
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
		' =================================================================
	
		' Write Data
	   ' =================================================================

		if  ic = 0 then
%>
  <tr>
  <%end if%>
    <td width="70"><img src="<%=bookimg%>" class="reflect rheight33" height="100px" /></td>
    <td valign="top" width="50%">
     <form id="addtocart" name="addtocart" method="post" action="shopping.asp">
	   <div align="left"><a href="description.asp?barcode=<%=RS("barcode")%>" class="blacktext"><b><%=RS("title")+RS("title1")%></b></a><br>
   <span class="blacktext"> Barcode : <%=RS("barcode")%><br>
    ผู้แต่ง : <%=RS("author")%><br>
    ราคาปก : <s><%=Formatnumber(RS("price"),2)%></s> บาท</span><br>
  <span class="redtext">
    <% 
		   Barcode = RS("barcode")
           SpecialPrice = Calculate_Price(Barcode)
		   response.Write "ราคาพิเศษ :&nbsp;" & SpecialPrice & "&nbsp;บาท"
%>
  </span><br>
                     <input name="taken" type="hidden" id="taken" value="1"  />
                    <input type="hidden" name="barcode"  value="<%=barcode%>" />
                    <% If SpecialPrice<>"" Then %>
                    <input type="hidden" name="price" value="<%= SpecialPrice %>" />
                    <% Else %>
                    <input type="hidden" name="price" value="<%=price%>" />
                    <% End If %>
               <input type="hidden" name="action" value="Add" />
	          <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" />  
                     <a href="insert_wishlist.asp?barcode=<%=RS("barcode")%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border=0/></a> 
        </div>
     </form>
     
      
     
    </td>
  <% if  ic = 1 then%>
  </tr>
  <%
  ic = 0
			else
			ic = ic+1
		end if
	
		RS.movenext
		  ' =================================================================
		
	Loop
	End If
	RS.close
	%>
</table>

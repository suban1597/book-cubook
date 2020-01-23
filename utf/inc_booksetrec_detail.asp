
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b><%=Rs_name("Bookset_name")%></font></div></td>
  </tr>
</table>

<%

sql_subcate=" select * from bookset_type where bookset_id = "&booksetid&""   
Set Rs_subcate=Server.CreateObject("ADODB.RecordSet")
Rs_subcate.Open  sql_subcate, Conn, 1, 3

if Rs_subcate.EOF then

sql=" SELECT  bl.title,bl.title1,bl.barcode,bb.barcode,bl.price,bl.author FROM  booklist  as bl , Bookset_book as bb WHERE bb.barcode = bl.barcode and (sb14_oh+stock_oh+cb_oh+jj_oh)>=2 and bookset_id = "&booksetid&"  ORDER BY Bookid DESC "
Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Open  sql, Conn, 1, 3

If RS.EOF Then
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;<font class="blacktext">ไม่พบข้อมูลหนังสือ</font></div></td>
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

    'bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & RS("barcode") &  ".gif"	
    'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("barcode") &  ".gif"		
  	''	if   ChkFile(bookimgpt) = true then
  	''			bookimg = "http://www.chulabook.com/images/books/" & RS("barcode") &  ".gif"				
  	''	elseif ChkFilebook2(bookimgpt2) = true then
  	''			bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".gif"
  	''	else	
  	''			bookimg = "http://www.chulabook.com/images/books/apology.gif"
  	''	end if

    ' Find Book Cover
    ' ===================================================================
    bookimgpt_chk = "C:\Chulabook\images\book-400\" & Barcode &  ".jpg" 
    'bookimgpt2_chk = "D:\Chulabook\cgi-bin\main\2010\images\books\" & Barcode &  ".gif"  
    'bookimgpt3_chk = "D:\Chulabook\cgi-bin\main\2010\images\book-400-2\" & Barcode &  ".gif"   
    if   ChkFile(bookimgpt_chk) = true then
        bookimg = "images/book-400/" & Barcode &  ".jpg"       
    'elseif ChkFilebook2(bookimgpt2_chk) = true then
        'bookimg = "http://www.chulabook.com/images/books/" & Barcode &  ".gif"
    'elseif ChkFilebook3(bookimgpt3_chk) = true then
        'bookimg = "http://www.chulabook.com/images/book-400-2/" & Barcode &  ".gif"
    else  
        bookimg = "images/book-400/apology.jpg"
    end if
    ' =================================================================
                    
  %>           
    <img src="<%=bookimg%>" width="100px"/>        
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
	  <input type="hidden" name="book_id" value="<%=book_id%>" /> 
      <input type="hidden" name="ebook" value="1" />       
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
<%
else

Do while not Rs_subcate.EOF
%>

  <table width="100%" border="0">
    <tr>
      <td>&nbsp;&nbsp;&nbsp;&nbsp;<font class="text"><b><%=Rs_subcate("typename")%></b></font></td>
    </tr>
  </table>
</div>

<%
sql=" SELECT  * FROM  booklist  as bl , Bookset_book as bb WHERE bb.barcode = bl.barcode and (stock_oh+sb_oh+cb_oh) > 5 and bb.typeid = "&Rs_subcate("typeid")&"   "   


Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Open  sql, Conn, 1, 3

If RS.EOF Then
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;<font class="blacktext">ไม่พบข้อมูลหนังสือ</font></div></td>
  </tr>
</table>
<%else%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
<tr>  
<%
i = 1
Do While Not RS.EOF 

%>
    <td width="162" valign="top"><div align="center">
                  <%On Error Resume Next%>
                  <%
bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & RS("barcode") &  ".gif"	
bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("barcode") &  ".gif"		
		if   ChkFile(bookimgpt) = true then
				bookimg = "http://www.chulabook.com/images/books/" & RS("barcode") &  ".gif"				
		elseif ChkFilebook2(bookimgpt2) = true then
				bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".gif"
		else	
				bookimg = "http://www.chulabook.com/images/books/apology.gif"
		end if
                  
                %>  
                  
                  <img src="<%=bookimg%>"/>
                  
                  
    </div></td>
    <td width="837" valign="top">
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
<%
Rs_subcate.movenext
loop
Rs_subcate.close
%>
<%end if%>
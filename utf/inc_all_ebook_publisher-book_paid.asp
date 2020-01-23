<%
user_id_publisher = request("id")
'================Query Top 10 Distributtion Books=======================
	'sql="SELECT * FROM  Ebooklist , booklist   WHERE user_id_publisher = "&user_id_publisher&" and book_bath_price > 0 and Ebooklist.isbn = booklist.barcode order by create_date desc" 
	
	sql="	SELECT Ebook_sale.barcode, COUNT(Ebook_sale.barcode) AS C_barcode, Ebooklist.book_name, Ebooklist.book_author, Ebooklist.publisher, Ebooklist.book_cover_price, Ebooklist.book_bath_price, Ebooklist.book_thumbnail_path, Ebooklist.book_id, booklist.title, booklist.title1 FROM Ebook_sale INNER JOIN booklist ON booklist.barcode = Ebook_sale.barcode INNER JOIN Ebooklist ON booklist.barcode = Ebooklist.isbn WHERE (Ebook_sale.user_id_publisher LIKE '"&user_id_publisher&"') GROUP BY Ebook_sale.barcode, Ebook_sale.user_id_publisher, Ebook_sale.publisher_writer, Ebooklist.book_name, Ebooklist.book_author, Ebooklist.publisher,Ebooklist.book_cover_price, Ebooklist.book_bath_price, Ebooklist.book_thumbnail_path, Ebooklist.book_id , booklist.title, booklist.title1 ORDER BY COUNT(Ebook_sale.barcode) DESC"
	
	Set RScate=Server.CreateObject("ADODB.RecordSet")
	RScate.Open sql,conn,1,3	
	
	'RScate.PageSize=14
'PageCount = Request.QueryString("PageCount")
'If PageCount <>"" Then
	'PageNumber=PageCount
	'If PageNumber < 1 Then PageNumber = 1 End If
'Else
'	PageNumber = 1
'End If
	
	If not RScate.eof Then 'RScate.AbsolutePage=PageNumber End If
%>
<font class="blacktext"><b><%=RScate("publisher")%></b></font><br />
<br />
<table width="95%" border="0" align="center" cellpadding="3" cellspacing="3">
<%
	ic = 0
	Do  while not RScate.eof
	
		' Find Book Cover
		' ===================================================================
bookimg =  RScate("book_thumbnail_path") & "tiny.gif"
		' =================================================================


	
		' Write Data
	   ' =================================================================

		if  ic = 0 then
%>
                <tr>
                  <%end if%>
                  
<!--%
RSPageCount=RScate.PageCount
Do While Not (RScate Is Nothing) 
CountDown=RScate.PageSize
i = 1
Do While (Not RScate.EOF) and (CountDown>0)

%-->
                  <td width="124" height="109" align="center" valign="top"><img src="<%=bookimg%>" /></td>
<td valign="top" width="1176" align="left"><form id="addtocart" name="addtocart" method="post" action="shopping.asp">
        <a href="description_ebook.asp?barcode=<%=RScate("barcode")%>" class="blacktext"><b><%=RScate("book_name")%></b></a><br>
<span class="blacktext">ผู้แต่ง : <%=RScate("book_author")%><br>
ราคาปก : <s><%=Formatnumber(RScate("book_cover_price"),2)%> บาท</s></span><br>
<span class="redtext">ราคา E-book : 
<%if (RScate("book_bath_price")) = "0" then Response.Write ("Free") else Response.Write Formatnumber(RScate("book_bath_price"),2) end if%></span>

      	<input type="hidden" name="barcode"  value="<%=RScate("barcode")%>e" />
		<input type="hidden" name="book_id" value="<%=RScate("book_id")%>" />
        <input type="hidden" name="ebook" value="1" />
        <input type="hidden" name="action" value="Add" />
        <input type="hidden" name="price" value="<%=RScate("book_bath_price")%>" />        
        <input type="hidden" name="taken" id="taken" value="1"  /></br>
        <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="ซื้อ <%=RScate("title")+RScate("title1")%>" border="0" name="ebook" />
      </form></td>
                  <% if  ic = 1 then%>
                </tr>
                <%
  ic = 0
			else
			ic = ic+1
		end if
	
		RScate.movenext
		  ' =================================================================
		
	Loop
	RScate.close
	
%>
</table>
<%
	else 
		response.Write "<div align = center>----ไม่มีรายการหนังสือค่ะ----</div>"
	End If

%>	







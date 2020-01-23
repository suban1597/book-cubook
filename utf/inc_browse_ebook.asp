<%
'================Query Top 10 Distributtion Books=======================
	'sql="select * from Ebooklist,booklist WHERE booklist.category = '"&category_id&"' and Ebooklist.isbn = booklist.barcode"
	sql="SELECT Ebooklist.book_thumbnail_path, booklist.barcode, Ebooklist.book_name, Ebooklist.book_author, Ebooklist.book_bath_price, Ebooklist.book_cover_price, Ebooklist.book_id, Ebooklist.category_id FROM Ebooklist INNER JOIN booklist ON Ebooklist.isbn = booklist.barcode WHERE (booklist.category = '"&category_id&"')"
	Set RScate=Server.CreateObject("ADODB.RecordSet")
	RScate.Open sql,conn,1,3
	'response.Write sql	
	If not RScate.eof Then
%>
<table width="95%" border="0" cellpadding="3" cellspacing="3">
<%
	ic = 0
	Do  while not RScate.eof
	
		' Find Book Cover
		' ===================================================================
bookimg = RScate("book_thumbnail_path") & "tiny.gif"
		' =================================================================


	
		' Write Data
	   ' =================================================================

		if  ic = 0 then
%>
                <tr>
                  <%end if%>
                  <td width="54" height="109" align="center" valign="top"><img src="<%=bookimg%>" /></td>
<td valign="top" width="1115" align="left"><form id="addtocart" name="addtocart" method="post" onsubmit="return(foul.validate(this))" action="shopping_ebook.asp">
                      <a href="description_ebook.asp?barcode=<%=RScate("barcode")%>" class="blacktext"><b><%=RScate("book_name")%></b></a><br />
                      <span class="blacktext"><%=RScate("book_author")%><br />
                        ราคาปก : <s><%=Formatnumber(RScate("book_cover_price"),2)%> บาท</s></span><br />
                    <span class="redtext">ราคา E-book :
                      <%if (RScate("book_bath_price")) = "0" then Response.Write ("Free") else Response.Write Formatnumber(RScate("book_bath_price"),2) end if%>
                    </span>
                    <input type="hidden" name="barcode"  value="<%=RScate("barcode")%>e" />
                    <input type="hidden" name="book_id" value="<%=RScate("book_id")%>" />
                    <input type="hidden" name="ebook" value="1" />
                    <input type="hidden" name="action" value="Add" />
                    <input name="taken" type="hidden" id="taken" value="1"  />
                    </br>
                    <% If book_bath_price <>"" Then %>
                    <input type="hidden" name="price" value="<%=RScate("book_bath_price")%>" />
                    <% Else %>
                    <input type="hidden" name="price" value="<%=RScate("book_bath_price")%>" />
<% End If %>
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
		response.Write "----ไม่มีรายการหนังสือค่ะ----"
	End If

%>	







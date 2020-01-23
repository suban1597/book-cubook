<%
sql="SELECT Ebooklist.book_id, Ebooklist.isbn, Ebooklist.book_name, booklist.author, booklist.price, Ebooklist.book_bath_price, Ebooklist.book_thumbnail_path,booklist.barcode,booklist.title,booklist.title1 FROM Ebooklist INNER JOIN booklist ON Ebooklist.isbn = booklist.barcode WHERE (Ebooklist.enable = '1') AND (Ebooklist.book_bath_price > 0) ORDER BY Ebooklist.create_date DESC"
%>
<%
Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Cursorlocation=3
RS.open sql, Conn,  3,3,1
RS.PageSize=14
PageCount = Request.QueryString("PageCount")
If PageCount <>"" Then
	PageNumber=PageCount
	If PageNumber < 1 Then PageNumber = 1 End If
Else
	PageNumber = 1
End If
If Not RS.EOF Then RS.AbsolutePage=PageNumber End If
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
  <td colspan="2"><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b>ข้อมูลหน้าที่</b> <%=PageNumber%></font></div><br></td>
    </tr>
    <tr>  
<%
RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)

%>
    <td width="174" align="center" valign="top">
                  <%		
				bookimg = RS("book_thumbnail_path")&"tiny.gif"
		%>
    <img src="<%=bookimg%>" /></td>
    <td width="1043" valign="top">
    <form id="addtocart" name="addtocart" method="post" action="shopping.asp">
        <a href="description_ebook.asp?barcode=<%=RS("barcode")%>" class="blacktext"><b><%=RS("title")+RS("title1")%></b></a><br>
<span class="blacktext">ผู้แต่ง : <%=RS("author")%><br>
ราคาปก : <s><%=Formatnumber(RS("price"),2)%> บาท</s></span><br>
<span class="redtext">ราคา E-book : 
<%if (RS("book_bath_price")) = "0" then Response.Write ("Free") else Response.Write Formatnumber(RS("book_bath_price"),2) end if%></span>

      	<input type="hidden" name="barcode"  value="<%=RS("barcode")%>e" />
		<input type="hidden" name="book_id" value="<%=RS("book_id")%>" />
        <input type="hidden" name="ebook" value="1" />
        <input type="hidden" name="action" value="Add" />
        <input type="hidden" name="price" value="<%=RS("book_bath_price")%>" />        
        <input type="hidden" name="taken" id="taken" value="1"  /></br>
        <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="ซื้อ <%=RS("title")+RS("title1")%>" border="0" name="ebook" />
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
<br />
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><div align="left">
      
      <div align="left">
        <% itsallpage = rspagecount %> 
        &nbsp;&nbsp;&nbsp;&nbsp;<span class="text">จำนวนหน้า <%=itsallpage%> หน้า</span><br />
        <br />
        <!--<A href="promotion.asp"><< ¡èÍ¹Ë¹éÒ</A> -->
        &nbsp;&nbsp;&nbsp;&nbsp;<%for itscount = 1 to itsallpage %>
        <%'for itscount = 1 to 13 %>
        <a href="all_ebook_newbook.asp?pagecount=<%=itscount%>"> <%=itscount%></a>
        <%next%>
        <!--<A href="#">¶Ñ´ä» >></A>  -->
        <br />
        <br />
        </div>
    </div></td>
  </tr>
</table>

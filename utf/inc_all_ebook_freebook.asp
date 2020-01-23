<%
sql="SELECT book_name, book_author, book_cover_price, book_id, book_bath_price,book_thumbnail_path FROM Ebooklist WHERE (enable = '1') AND (book_bath_price = 0) ORDER BY create_date DESC"
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
%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
    <td width="162" align="center" valign="top">
	<%		
		if RS("book_thumbnail_path") = "" then
		bookimg = "http://www.chulabook.com/images/books/apology.gif"
		else
		bookimg = RS("book_thumbnail_path") & "tiny.gif"
		end if
	%>
    <img src="<%=bookimg%>" /></td>
    <td width="837" valign="top">
    <form id="addtocart" name="addtocart" method="post" action="free_download_api.asp">
     <a href="description_freebook.asp?book_id=<%=RS("book_id")%>" class="blacktext"><b><%=RS("book_name")%></b></a><br>
		<span class="blacktext">ผู้แต่ง : <%=RS("book_author")%><br>
		ราคาปก : <s><%=Formatnumber(RS("book_cover_price"),2)%> บาท</s></span><br>
		<span class="redtext">ราคา E-book : 
   	<%if (RS("book_bath_price")) = "0" then Response.Write ("Free") else Response.Write Formatnumber(RS("book_bath_price"),2) end if%></span>
		<input type="hidden" name="book_id" value="<%=RS("book_id")%>" /><br>
        <input type="image" src="images/icons/download2.png" id="bt_download" name="bt_download" border="0" />                  
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><div align="left">
      
      <div align="left">
        <% itsallpage = rspagecount %> 
        &nbsp;&nbsp;&nbsp;&nbsp;<span class="text">จำนวนหน้า <%=itsallpage%> หน้า</span><br />
        <br />
        <!--<A href="promotion.asp"><< ¡èÍ¹Ë¹éÒ</A> -->
        &nbsp;&nbsp;&nbsp;&nbsp;<%for itscount = 1 to itsallpage %>
        <%'for itscount = 1 to 13 %>
        <a href="all_ebook_freebook.asp?pagecount=<%=itscount%>"> <%=itscount%></a>
        <%next%>
        <!--<A href="#">¶Ñ´ä» >></A>  -->
        <br />
        <br />
        </div>
    </div></td>
  </tr>
</table>

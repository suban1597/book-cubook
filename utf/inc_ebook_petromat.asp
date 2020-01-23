<%
	'sql="SELECT * FROM  Ebooklist WHERE user_id_publisher = '162955' order by create_date desc "
	 sql="SELECT book_thumbnail_path, book_name, book_author, book_file_size, category, book_cover_price, book_id, book_bath_price FROM  Ebooklist WHERE user_id_publisher = '162955' order by create_date desc"
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
<table width="100%" border="0" cellspacing="3" cellpadding="3">
<%
RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)

%>
    <td width="173" align="center" valign="top">
	<%		
		if RS("book_thumbnail_path") = "" then
		bookimg = "http://www.chulabook.com/images/books/apology.gif"
		else
		bookimg = "http://161.200.139.239/books/" & RS("book_id") &  "/Thumbnail/tiny.gif"
		end if
	%>
    <img src="<%=bookimg%>" /></td>
    <td width="1037" valign="top">
    <form id="addtocart" name="addtocart" method="post" action="free_download_api.asp">
        <b><%=RS("book_name")%></b><br>
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

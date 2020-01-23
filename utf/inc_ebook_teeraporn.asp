<%
  'sql="SELECT * FROM  Ebooklist WHERE book_id in ('1613') order by create_date desc "
  sql="SELECT book_thumbnail_path, book_name, book_author, book_file_size, category, book_cover_price, book_id, book_bath_price FROM  Ebooklist WHERE book_id = '1613' OR book_id = '4702' order by create_date desc"
  Set RS=Server.CreateObject("ADODB.RecordSet")
  RS.open sql, Conn,  3,3,1

%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
<%
Do While Not (RS Is Nothing) 
i = 1
Do While (Not RS.EOF)

%>
    <td width="195" align="center" valign="baseline">
	<%		
		if RS("book_thumbnail_path") = "" then
		bookimg = "http://www.chulabook.com/images/books/apology.gif"
		else
		bookimg = RS("book_thumbnail_path") & "small.gif"
		end if
	%>
    <img src="<%=bookimg%>" /></td>
    <td width="1022" valign="top">
    <form id="addtocart" name="addtocart" method="post" action="free_download_api.asp">
        <b><a href="http://www.chulabook.com/description_freebook.asp?book_id=<%=RS("book_id")%>"><%=RS("book_name")%></a></b><br>
              <span class="blacktext">ผู้แต่ง : <%=RS("book_author")%><br />
          ขนาด :
          <%=RS("book_file_size")%>
kb</span><span class="blacktext"><br />
หมวดหนังสือ :
<%=RS("category")%>
<br>
          ราคาปก : <s><%=Formatnumber(RS("book_cover_price"),2)%> บาท</s></span><br>
          <span class="redtext">ราคา E-book : 
          <%if (RS("book_bath_price")) = "0" then Response.Write ("Free") else Response.Write Formatnumber(RS("book_bath_price"),2) end if%>
          </span>
          <input type="hidden" name="book_id" value="<%=RS("book_id")%>" />
          <br>
      <span class="blacktext"><b><u>Apple IOS , Android :</u></b> <input type="image" src="images/icons/download2.png" id="bt_download" name="bt_download" border="0" /><br />
      <div style="border-bottom:medium"><b><u>PDF On Computer :</u></b> <img src="http://www.chulabook.com/images/down.jpg" width="20" height="20" align="absbottom" /> <a href="http://www.chulabook.com/word/<%=RS("book_id")%>.pdf" target="_blank">ดาวน์โหลด</a></div>
      </span>
    </form>
        </td>
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

<%
barcode = request("barcode")
sql_reviewcontent = "select  * from book_review where status = 1 and barcode like "&barcode&""
Set RS=Server.CreateObject("ADODB.RecordSet")
RS.open sql_reviewcontent, Conn, 1,1
%>

<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td class="big-text">ความคิดเห็นเกี่ยวกับหนังสือ <%=BookTitle%></td>
  </tr>
</table>
<br>

<%
icount = 1
Do while not  RS.eof
%>

<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="#FFFFFF" class="text">
  <tr>
    <td bgcolor="#F3F3F3"><div align="left"><b>ความคิดเห็นที่ <%=icount%></b></div></td>
  </tr>
  <tr>
    <td><div align="left"><%=RS("reviewcontent")%><br>
        <%=RS("reviewname")%>&nbsp;
        <%If RS("userid") <> 0 Then
	response.Write "เป็นสมาชิก"
	End if%>
    &nbsp;<%=RS("reviewdate")%> / ip : <%=RS("ip")%></div></td>
  </tr>
</table>

<%
icount = icount + 1

RS.movenext
Loop
%>
<%RS.close%>
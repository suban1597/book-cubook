<%
		sql=" select * from bookset_name where book_status = 1 and categorytype = 0 and maincate = 1 order by bookset_id desc"   
		Set Rs=Server.CreateObject("ADODB.RecordSet")
		Rs.Open  sql, Conn, 1, 3
%>
<table width="93%" border="0" align="right" cellpadding="2" cellspacing="2" >
  <%
  Do While Not RS.eof
  %>
  <tr>
    <td width="1%" valign="top"><img src="images/skins/bullet_arrow_right.jpg" width="16" height="16" /></td>
    <td width="99%"><div align="left"><a href="<%=Rs("link")%>.asp?bookset_id=<%=Rs("bookset_id")%>" class="blacktext"><%=Rs("bookset_name")%></a></div></td>
  </tr>
  
<%  
  Rs.movenext
  Loop
  Rs.close
%>
</table>
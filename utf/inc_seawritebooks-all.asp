
<%
Sql = "SELECT * FROM  seawritebook Order by bookyear desc"
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3
%>

<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
  <tr>
    <td width="8%" bgcolor="#999999"><div align="center"><b>ปี พ.ศ.</b></div></td>
    <td width="54%" bgcolor="#999999"><div align="center"><b>ชื่อหนังสือ</b></div></td>
    <td width="22%" bgcolor="#999999"><div align="center"><b>ผู้แต่ง</b></div></td>
    <td width="16%" bgcolor="#999999"><div align="center"><b>ประเภท</b></div></td>
  </tr>
  <%
  i = 1
  Do while not RS.eof
  if i = 1 then
  bgcolor = "#EAF9FF"
  else
  bgcolor = "#FFFFFF"
  end if
  %>
  <tr bgcolor="<%=bgcolor%>">
    <td><div align="center"><%=RS("bookyear")%></div></td>
    <td><div align="left"><%=RS("title")%></div></td>
    <td><div align="left">&nbsp;&nbsp;<%=RS("author")%></div></td>
    <td><div align="center"><%=RS("booktype")%></div></td>
  </tr>
  <%
  if i = 1 then
  i = 0
  else
  i = i + 1
  end if
  RS.movenext
  Loop
  
  %>
</table>

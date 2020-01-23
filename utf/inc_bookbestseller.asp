<%
		sql=" select rank,bs.barcode,title+title1 as titleall,author  from bestseller bs, booklist as bl  where bs.barcode = bl.barcode ORDER BY rank  ASC  "     
		
		Set Rs=Server.CreateObject("ADODB.RecordSet")
		Rs.Open  sql, Conn, 1, 3
%>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" >
  <%
  Do While Not RS.eof
  			
		
		Barcode = Rs("barcode")

  %>
  <tr>
    <td width="4%" height="46" valign="top"><div align="center">
          <%
		  On Error Resume Next
          ReadBinFile(CoverFile)
          %>
          <img src="images/number-bestseller/<%=Rs("rank")%>.jpg" width="20" height="20" />    </div></td>
    <td width="96%"><div align="left"><a href="description.asp?barcode=<%=Rs("barcode")%>" class="blacktext"><%=Rs("titleall")%></a><br />  
      : <span class="text"><%=Rs("author")%></span></div></td>
  </tr>
  
  <%  
  Rs.movenext
  Loop
  Rs.close
%>
</table>

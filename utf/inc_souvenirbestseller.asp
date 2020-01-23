<%
		sql=" select bs.barcode,title+title1 as titleall,price from bestseller_souvenir bs, booklist as bl  where bs.barcode = bl.barcode ORDER BY rank  ASC  "     
		
		Set Rs=Server.CreateObject("ADODB.RecordSet")
		Rs.Open  sql, Conn, 1, 3
%>
<table width="93%" border="0" align="right" cellpadding="2" cellspacing="2" >
  <%
  Do While Not RS.eof
  			
		
		Barcode = Rs("barcode")

  %>
  <tr>
    <td width="6%" valign="top"><div align="center">
          <%
		  On Error Resume Next
          ReadBinFile(CoverFile)
          %>
          <img src="images/skins/award_star_gold_3.png" width="16" height="16" border="0" />    </div></td>
    <td width="94%"><div align="left"><%=Rs("rank")%>&nbsp;<a href="description.asp?barcode=<%=Rs("barcode")%>" class="text"><%=Rs("titleall")%></a><br />  
      : <span class="text">ราคา : <%=FormatNumber(RS("price"),0)%> บาท</span></div></td>
  </tr>
  
  <%  
  Rs.movenext
  Loop
  Rs.close
%>
</table>

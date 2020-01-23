<style type="text/css">
<!--
.style1 {	font-size: 13px
}
-->
</style>
<%
Sql = "SELECT top 3 * FROM booknews where booknews_status = 1 order by booknew_id desc"
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3
%>
<table width="197" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="images/skins/standard/table_booknews_header.jpg" width="197" height="43" border="0" /></td>
  </tr>
  
  
  <tr>
    <td background="images/skins/standard/table_booknews_body.jpg"><table width="95%" border="0" align="center" cellpadding="1" cellspacing="1">
      <%do while not rs.eof %>
      <tr>
        <td width="31%" valign="top"><img src="../Admin/booknews/UploadFolder/<%=RS("filepicture")%>.jpg" width="60px" height="60px" /></td>
        <td valign="top"><a href="booknews_new.asp?booknew_id=<%=RS("booknew_id")%>" class="newstext style1"><%=RS("topic")%></a></td>
      </tr>
      
      
    <tr>
        <td colspan="2" valign="top"><div align="center"><img src="images/skins/dot-line.jpg" alt="" width="160" height="7" border="0" /></div></td>
      </tr>
       <%rs.movenext
	  loop%>
     
    </table></td>
  </tr>
  
  <tr>
    <td background="images/skins/standard/table_booknews_body.jpg"><table width="95%" border="0" align="center" cellpadding="1" cellspacing="1">
        <tr>
          <td width="31%" valign="top"><div align="right"><a href="allbooknews.asp"><img src="images/skins/see-all.png" border="0"/></a></div></td>
        </tr>
      </table></td>
  </tr>
  
  <tr>
    <td><img src="images/skins/standard/table_booknews_footer.jpg" width="197" height="12" border="0" /></td>
  </tr>
</table>
<!--<table width="170" border="0" align="center">
<tr>
        <td><div align="right"><a href="../book_browse.asp"><img src="images/skins/see-bookmenu.jpg" width="127" height="21" border="0" /></a></div></td>
      </tr>
    </table>-->
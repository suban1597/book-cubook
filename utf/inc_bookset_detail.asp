<%

Set  Rs_Bookset_type= Server.CreateObject("ADODB.Recordset")
sql_Bookset_type = "select  *  from Bookset_type  WHERE bookset_id = "&booksetid&"  "
RS_Bookset_type.Open sql_Bookset_type,conn,1,3

 %>
 <table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" >
  <tr>
    <td valign="top" class="blacktext"><div align="left"><b>ชุดหนังสือ<%=Rs_set("bookset_name")%></b></div></td>
   </tr>
</table>
 
 <% Do while not RS_Bookset_type.eof %>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
<tr>
  <td class="blacktext"><div align="left"><b><%=RS_Bookset_type("typename")%></b></div></td>
</tr>
<%
 Set  Rs_booklist= Server.CreateObject("ADODB.Recordset")
 sql_booklist = "select  *  from Bookset_book  WHERE typeid = "&RS_Bookset_type("typeid")&""
 RS_booklist.Open sql_booklist,conn,1,3
 
 If RS_booklist.EOF Then
 %>
 
 <tr>  
    <td class="blacktext"><div align="left">ไม่มีข้อมูล</div></td>
  </tr>
<%
Else
Do While Not RS_booklist.EOF
%>  
<tr>  
    <td class="blacktext"><div align="left"><%=RS_booklist("title")%></div></td>
  </tr>
  <%
RS_booklist.MoveNext
Loop	
End IF
 %>
</table>
<% 
 RS_Bookset_type.movenext
 loop
 
 RS_Bookset_type.close
 RS_booklist.close
 Rs_set.close
 %>

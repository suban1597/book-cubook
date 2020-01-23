<%
'sql="SELECT DISTINCT Ebooklist.publisher, Ebook_pub_logo.logo_path, Ebook_pub_logo.user_id_publisher AS publisherid FROM    Ebooklist INNER JOIN  Ebook_pub_logo ON Ebooklist.user_id_publisher = Ebook_pub_logo.user_id_publisher"

sql="SELECT user_id, writer FROM Ebook_publisher WHERE (username NOT LIKE '%test%') ORDER BY user_id DESC"
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
%>
<font class="blacktext"><b>&nbsp;&nbsp;&nbsp;รายชื่อสำนักพิมพ์ </b></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
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
    <td width="181" align="center" valign="middle">
	<%		
		'
		bookimg = "http://www.chulabook.com/images/LogoPub20181120.gif"
	%>
    <img src="<%=bookimg%>"  width="100" height="100"/><br /></td>
    <td width="1196" valign="middle"><span class="blacktext"><a href="all_ebook_publisher-book.asp?id=<%=RS("user_id")%>" ><%=RS("writer")%></a><br></span></td>
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
        <a href="all_ebook_publisher.asp?pagecount=<%=itscount%>"> <%=itscount%></a>
        <%next%>
        <!--<A href="#">¶Ñ´ä» >></A>  -->
        <br />
        <br />
        </div>
    </div></td>
  </tr>
</table>

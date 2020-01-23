
<!--#include file="connectdb.asp"-->
<!--#include file="inc_articles2.asp"-->
<!--#include file="inc_generate.asp"-->

<%
'Sql = "SELECT newsid, topic, date_start, date_end, text_description, text_short, item_status, text_summary, show_date_start, show_date_end, showtime, place, status_manage FROM news WHERE (topic LIKE '%ประกวดราคา%') and (item_status = 1) AND ({ fn NOW() } < date_end) OR (topic LIKE '%จ้าง%') and (item_status = 1) AND ({ fn NOW() } < date_end)ORDER BY newsid DESC" '20180901
Sql = "SELECT newsid, topic, date_start, date_end, text_description, text_short, item_status, text_summary, show_date_start, show_date_end, showtime, place, status_manage FROM news WHERE (topic LIKE '%ประกวดราคา%') and (item_status = 1) OR (topic LIKE '%จ้าง%') and (item_status = 1) ORDER BY newsid DESC"
Set RsRBook=Server.CreateObject("ADODB.RecordSet")
RsRBook.Open  Sql, Conn, 1, 3
%>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
<%
icount = 0
Do while not RsRBook.eof
'FileName = GenArticleFileName(RsRBook("Name") ,RsRBook("articleID") , 0)

if icount = 0 then
	'response.write "ไม่มีรายการประกวดราคา จัดซื้อจัดจ้าง" '20180901
%>
<tr>
<% end if%>
              <td width="11%" valign="top"><div align="center"><img src="admin/news/UploadFolder/<%=RsRBook("newsid")%>.jpg"  border="0" width="60px" height="60px"/></div></td>
              <td width="39%" valign="top"><div align="left">
                <%response.write "<a class=""newstext"" href=""news.asp?newsid="&RsRBook("newsid")&""" target=blank>"&RsRBook("topic")&"</a>" %>
                <br><span class="newstext">วันที่ <%=RsRBook("date_start")%></span>
                <%'=Formatdatetime(RsRBook("createdate"),2)%>
                <br>
                <%'=RsRBook("description")%>
              </div><br></td>
<% if  icount = 1 then%>
</tr>

<%
icount = 0
else
icount = icount+1
end if

RsRBook.movenext
Loop
RsRBook.close
%>
          </table>
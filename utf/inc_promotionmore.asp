
<!--#include file="connectdb.asp"-->
<!--#include file="inc_articles2.asp"-->
<!--#include file="inc_generate.asp"-->

<%
Sql = "SELECT *  "
Sql = Sql & "from promotion  where item_status = 1 order by promotionid desc"
Set RsRBook=Server.CreateObject("ADODB.RecordSet")
RsRBook.Open  Sql, Conn, 1, 3
%>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
<%
icount = 0
Do while not RsRBook.eof
'FileName = GenArticleFileName(RsRBook("Name") ,RsRBook("articleID") , 0)

if icount = 0 then
%>
<tr>
<%end if%>
              <td width="11%" valign="top"><div align="center"><img src="admin/promotion/UploadFolder/<%=RsRBook("promotionid")%>.jpg"  border="0" width="60px" height="60px"/></div></td>
              <td width="39%" valign="top"><div align="left">
                <%response.write "<a class=""newstext"" href=""promotion-detail.asp?promotionid="&RsRBook("promotionid")&""">"&RsRBook("topic")&"</a>" %>
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
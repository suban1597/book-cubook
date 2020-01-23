<!--#include file="connectdb.asp"-->
<!--#include file="inc_articles2.asp"-->
<!--#include file="inc_generate.asp"-->

<%
Sql = "SELECT *  "
Sql = Sql & "from Article_category where cate_status like 1 "
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
              <td width="11%" valign="top"><div align="center"><img src="http://www.chulabook.com/admin/article/icon/<%=RsRBook("CategoryID")%>.jpg"  border="0" /></div></td>
              <td width="39%" valign="top"><div align="left">
            <br />
            <%response.write "<a class=""newstext"" href=""articles-more.asp?CategoryID="&RsRBook("CategoryID")&""">"& RsRBook("Category_name")&"</a>" %>
            <br />
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

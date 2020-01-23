<!--#include file="connectdb.asp"-->
<!--#include file="inc_articles2.asp"-->
<!--#include file="inc_generate.asp"-->

<%
Sql = "SELECT *  "
Sql = Sql & "from booknews  where booknews_status = 1 order by booknew_id desc"
Set Rs_Booknews=Server.CreateObject("ADODB.RecordSet")
Rs_Booknews.Open  Sql, Conn, 1, 3
%>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
<%
icount = 0
Do while not Rs_Booknews.eof
'FileName = GenArticleFileName(RsRBook("Name") ,RsRBook("articleID") , 0)

if icount = 0 then
%>
<tr>
<%end if%>
              <td width="11%" valign="top"><div align="center"><img src="http://www.chulabook.com/Admin/booknews/UploadFolder/<%=Rs_Booknews("filepicture")%>.jpg"  border="0" width="60px" height="60px" /></div></td>
              <td width="39%" valign="top"><div align="left">
                <%response.write "<a class=""newstext"" href=""booknews_new.asp?booknew_id="&Rs_Booknews("booknew_id")&""" >"&Rs_Booknews("topic")&"</a>" %>
                <br>
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

Rs_Booknews.movenext
Loop
Rs_Booknews.close
%>
          </table>

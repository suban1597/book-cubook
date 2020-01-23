<%
sql="SELECT * FROM  bestseller,booklist  WHERE  bestseller.barcode = booklist.barcode"
%>
<%
Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Cursorlocation=3
RS.open sql, Conn,  3,3,1
RS.PageSize=10
PageCount = Request.QueryString("PageCount")
If PageCount <>"" Then
	PageNumber=PageCount
	If PageNumber < 1 Then PageNumber = 1 End If
Else
	PageNumber = 1
End If
If Not RS.EOF Then RS.AbsolutePage=PageNumber End If
%>
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2">
    <tr>
      <td>&nbsp;</td>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr>  
<%
RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)
Barcode = RS("barcode")
Title = RS("title") + RS("title1")
Author = RS("author")
Price = RS("price")
Translator = RS("Translator")
sb_sb14_oh = RS("sb_oh") + RS("sb14_oh")
%>
    <td width="156" valign="top">
    <div align="center">
    <%On Error Resume Next%>
    <%Filename = RS("barcode") & ".jpg" %>
	<%Call GetBookCover(Filename)%>
    </div>
    </td>
    <td width="1036" valign="top"><!--#include file="inc_booktocart.asp"--></td>
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
<%RS.close%>
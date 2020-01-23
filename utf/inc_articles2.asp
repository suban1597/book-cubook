
<%
' Function Show Article([CategoeyID],[Number of Display articles])
Sub ShowArticleCat2(Category,Numb)
	
	Sql = "SELECT TOP "  &  Numb & "  articleid,article_name,publishdate, [name],DATEPART(yyyy, article.CreateDate) AS strYear, DATEPART(mm, article.CreateDate) AS strMONTH  "
	Sql = Sql & "from article where status = 1 and visible = 1 and categoryid = " & category &  "order by publishdate desc"
	
	Set RsRBook=Server.CreateObject("ADODB.RecordSet")
	RsRBook.Open  Sql, Conn, 1, 3
	
	i = 1
	Do while not RsRBook.eof
	
		FileName = GenArticleFileName(RsRBook("Name") ,RsRBook("articleID") , 0)
		response.write "<img src=""http://www.chulabook.com/images/bullet_news.gif""> <a class=""stext"" href=" & "articles/" & RsRBook("strYear") & "/" & RsRBook("strMONTH")  & "/" & FileName & " target=""_blank"">" & RsRBook("article_name") & "</a>"
		
		if i <= 2 then
			response.write " <img src=""images/icons/new.png"">"
		end if
		
		response.write "<BR>"
	i = i+1	
	RsRBook.MoveNext	
	Loop
	
	RsRBook.Close
	body_table = "<table width=98% border=0 align=center cellpadding=2 cellspacing=2 class=text>"
	body_table = "<tr><td><div align=right><a href=articles_more.asp class=stext><b>й >></b></a></div></td></tr></table>"
	response.Write body_table
	
end sub

'============================================================================================================================================================

Sub ShowArticle2(Numb)

	Sql = "SELECT TOP "  &  Numb & "  articleid,article_name,publishdate, [name],DATEPART(yyyy, article.CreateDate) AS strYear, DATEPART(mm, article.CreateDate) AS strMONTH  "
	Sql = Sql & "from article where status = 1 order by publishdate desc"
	
	Set RsRBook=Server.CreateObject("ADODB.RecordSet")
	RsRBook.Open  Sql, Conn, 1, 3
	
	i = 1
	Do while not RsRBook.eof
	
		FileName = GenArticleFileName(RsRBook("Name") ,RsRBook("articleID") , 0)
		response.write "<a class=stext href=" & "articles/" & RsRBook("strYear") & "/" & RsRBook("strMONTH")  & "/" & FileName & ">" & RsRBook("article_name") & "</a><BR>"
	i = i+1	
	RsRBook.MoveNext	
	Loop
	
	RsRBook.Close
	
end sub

'============================================================================================================================================================


' Function ShowArticle([CategoeyID],[Number of Display articles])
Sub ShowArticleCatImage(Category,Numb)
	
	Sql = "SELECT TOP "  &  Numb & "  *  "
	Sql = Sql & "from news  where convert(nvarchar(8),show_date_start,112) <=  convert(nvarchar(8),getdate(),112)  and convert(nvarchar(8),getdate(),112)  <= convert(nvarchar(8),show_date_end,112)   and item_status = 1 order by newsid desc"
	
	
	
	Set RsRBook=Server.CreateObject("ADODB.RecordSet")
	RsRBook.Open  Sql, Conn, 1, 3
%>

<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td width="16%" valign="top"><img src="admin/news/UploadFolder/<%=RsRBook("newsid")%>.jpg" width="60" height="60" /></td>
    <td width="84%" valign="top"><div align="left">
	
	<%
	Do While not RsRBook.eof
	'FileName = GenArticleFileName(RsRBook("topic") ,RsRBook("newsid") , 0)
	'response.Write "dfdfdsfsfd" & "<br>"
	
	'response.Write "<a class=""newstext"" href=""sb_branch.asp?newsid="&RsRBook("newsid")&""" target=blank>"&RsRBook("topic")&"</a>"
	response.Write "<a class=""newstext"" href=""news.asp?newsid="&RsRBook("newsid")&""" target=blank>"&RsRBook("topic")&"</a><br><img src=images/newshilight/dot-line.jpg border=0/><br>"
	'response.Write "<a class=""newstext"" href=""newsdetail?newsid="" & " RsRBook("newsid") & " & " target=""_blank"">" & RsRBook("topic") & "</a><br><img src=images/newshilight/dot-line.jpg border=0/><br>"
	RsRBook.movenext
	Loop	
	%>
    
    </div></td>
  </tr>
</table>

<%
    RsRBook.close
end sub

'============================================================================================================================================================


' Function ShowArticle([CategoeyID],[Number of Display articles])
Sub ShowPhotoGallery(Numb)	
	Sql = "SELECT TOP 2 * from Photo_Gallery order by gallery_id desc"
	Set RsRBook=Server.CreateObject("ADODB.RecordSet")
	RsRBook.Open  Sql, Conn, 1, 3	
	i = 1
	startitem = 1
	itemperrow = 2
	response.write "<table border=0 width='100%'>"	
		    response.write "<tr>"	
	Do while not RsRBook.eof
	    response.write  "<td valign='top'>" 
		response.write "<img src=""images/photoimg/" & RsRBook("gallery_id")  & ".jpg""></td>"
		response.write "<td valign='top' align='left'> <a class=""stext"" href="& RsRBook("url")&" target=""_blank"">" & RsRBook("title") & "</a>"
'					if i <= 2 then
'			response.write " <img src=""images/icons/new.png"">"
'		end if
		response.write  "</td>"
			if startitem = 1 then
			response.write "<td style='width:2px;'><img src='images/dot-ver.png' width='5' height='75' /></td>"
		end if
		 response.write  "</td>"
	i = i+1	
	if startitem = itemperrow then
		response.write "</tr><tr>"
		response.write  "<tr><td colspan='5' align='center'  style='height:4px'><img src='images/dot-left.png' width='517' height='4' /></td></tr>"
               
		startitem = 1
	else
	startitem = startitem + 1	
	end if

	RsRBook.MoveNext	
	Loop

	 response.write  "</tr></table>"
	
	RsRBook.Close
	
	body_table = "<table width=98% border=0 align=center cellpadding=2 cellspacing=2 class=text>"
	body_table = "<tr><td><div align=right><a href=pr_more.asp class=stext><b>٢ǡԨ >></b></a></div></td></tr></table>"
	response.Write body_table
end sub


'============================================================================================================================================================


Function getusername(uid)
	Sql = "SELECT top 1 Bname from account where userid = " & uid
	Set RsRBook=Server.CreateObject("ADODB.RecordSet")
	RsRBook.Open  Sql, Conn, 1, 3	
	If not RsRBook.eof Then
	getusername = RsRBook("Bname")
	End if
End Function


'============================================================================================================================================================


' Function ShowArticle([CategoeyID],[Number of Display articles])
Sub show_forums_list()	
	result_list = "<table border=0>"
	theindex = 1
	Sql = "select * from forum_room where status = 1 "
	Set RsRBook=Server.CreateObject("ADODB.RecordSet")
	RsRBook.Open  Sql, Conn, 1, 3	
	Do while not RsRBook.eof
		
		
		if theindex = 1 then
				result_list = result_list & "<tr>"
		end if
			
		result_list = result_list & "<td width='100' align='center' valign='top'>"
		result_list = result_list &  "<img src='images/skins/forums/" & RsRBook("roomid")  & ".jpg'>" & "</td>"
		result_list = result_list & "<td width='130' align='left' valign='top'><a href='forum.asp?room=" & RsRBook("roomid")   & "' class='text'>" & RsRBook("roomname") & "</a><br>"
		result_list = result_list & "<font class='text'>" & RsRBook("roomdesc") & "</font></td>"
		'result_list = result_list & "</td>"
		
		
		if theindex = 2 then		
			result_list = result_list & "</tr>"
		end if
		
		if theindex = 2 then
			theindex = 1
		else
			theindex = theindex + 1
		end if
	RsRBook.movenext
	Loop
	result_list = result_list &"</table>"
	response.write result_list
	
End sub
'============================================================================================================================================================

%>
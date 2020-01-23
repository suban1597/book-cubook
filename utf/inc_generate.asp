<%
'Dim Testing
'Testing = True

'strHost = strGenPath
strHost = "D:\Chulabook\cgi-bin\main\2007\articles\" 



Sub DeleteArticlePage(ArticleID,PageIndex)
	Dim sql,oRsPage,ckfs,strPageIndex

	If PageIndex <> "" Then
		strPageIndex = " AND articlepage.PageIndex=" & PageIndex
	Else
		strPageIndex = ""
	End If

	sql = "SELECT  article.name,DATEPART(yyyy, articlepage.CreateDate) AS strYear, DATEPART(mm, articlepage.CreateDate) AS strMONTH,articlepage.PageIndex FROM article,articlepage WHERE articlepage.ArticleID = article.ArticleID AND articlepage.ArticleID = " &   ArticleID & strPageIndex

	Set oRsPage = Server.CreateObject("ADODB.Recordset")
	Set oRsPage = QueryData(sql)

	Set ckfs=Server.CreateObject("Scripting.FileSystemObject") 

	Do While not oRsPage.EOF 

		strFileName =  strHost&oRsPage("strYear") & "\" & CMonthToString(oRsPage("strMONTH")) & "\"  & GenArticleFileName(oRsPage("name"),ArticleID,oRsPage("PageIndex"))
		
		'Check exist File
		if ckfs.FileExists(strFileName)=true then
				dim f
				Set f = ckfs.GetFile(strFileName)
				f.Delete
				set f=nothing
		end if
		oRsPage.MoveNext
	Loop
	set ckfs=nothing
	oRsPage.Close
End Sub

Sub GenerateArticlePage(prmArticleID ,prmPageIndex, prmTemplateFileName)


	If (prmArticleID = Empty)  or  (prmTemplateFileName = empty) Then Exit Sub

'Query Data
	sql = "select DATEPART(yyyy, A1.CreateDate) AS strYear, DATEPART(mm, A1.CreateDate) AS strMONTH,title,content,a1.author,a1.name,a1.categoryid,a2.pageindex,a1.Name,a1.userid,a1.article_name"
	sql = sql & " FROM Article A1,ArticlePage A2 "
	sql = sql & " WHERE A1.ArticleID = A2.ArticleID "
	sql = sql & " AND A2.ArticleID = " & prmArticleID
	sql = sql & " AND A2.PageIndex = " & prmPageIndex

	Set oRsArticle = Server.CreateObject("ADODB.Recordset")
	Set oRsArticle = QueryData(sql)


'EOF = Exit Sub
	if oRsArticle.Eof then 
		set oRsArticle = nothing
		Exit Sub
	end if

article_name = oRsArticle("article_name") 

	CategoryID = oRsArticle("CategoryID") 
	ArticleName = oRsArticle("Name")

	If oRsArticle("Title") & "" = "" Then
		ArticleTitle = oRsArticle("Article_Name")
	Else
		ArticleTitle = oRsArticle("Title") & ""
	End If
	ArticleTitlePage = oRsArticle("Title") & ""
	ArticleContent = oRsArticle("Content")

	if oRsArticle("Author") <> "" then
		If oRsArticle("UserID") <> "" Then
			AuthorName = "By " & oRsArticle("Author")
		Else
			AuthorName = "By " & oRsArticle("Author") 
		End If
	else
		AuthorName = ""
	end if
	strYear = oRsArticle("strYear")
	strMONTH = oRsArticle("strMONTH")
	PageIndex = oRsArticle("PageIndex")
	ArticleID = prmArticleID

'Response.write PageIndex & " - " & ArticleID  & "<hr><br>"
'Response.write "CategoryID :" & CategoryID & "<Br>"
'Response.write "ArticleName :" & ArticleName & "<Br>"
'Response.write "ArticleTitle :" & ArticleTitle & "<Br>"
'Response.write "ArticleContent :" & ArticleContent & "<Br>"
'Response.write "ArticleTitle :" & ArticleTitle & "<Br>"
'Response.write "ArticleTitle :" & ArticleTitle & "<Br>"
'Response.write "PageIndex :" & ArticleTitle & "<Br>"

'Open File template
		Set fs=Server.CreateObject("Scripting.FileSystemObject") 
		Set fo = fs.GetFile(Server.Mappath(prmTemplateFileName))
		Set fileObj=fo.OpenAsTextStream(1)
		
		newsTemplate = fileObj.ReadAll
		
		fileObj.Close
		Set fileObj = Nothing
		Set fo = Nothing
		Set fs = nothing

'Replace Text
		newsTemplate = Replace(newsTemplate, "{{ArticleTitle}}", ArticleTitle)
		newsTemplate = Replace(newsTemplate, "{{ArticleTitlePage}}", ArticleTitlePage)
		newsTemplate = Replace(newsTemplate, "{{ArticleName}}", article_name)
		newsTemplate = Replace(newsTemplate, "{{AuthorName}}", AuthorName)
		newsTemplate = Replace(newsTemplate, "{{Content}}", ArticleContent)
		newsTemplate = Replace(newsTemplate, "{{ArticleID}}", ArticleID)
		newsTemplate = Replace(newsTemplate, "{{PageIndex}}", PageIndex)
		newsTemplate = Replace(newsTemplate, "{{Keywords}}", article_name)
		newsTemplate = Replace(newsTemplate, "{{Description}}", article_name)

'Save File
		saveAsName = GenArticleFileName(ArticleName,prmArticleID,PageIndex)
		Set fs=Server.CreateObject("Scripting.FileSystemObject")
response.write "<br>"&strHost&strYear
'response.end
'Create folder if not found
		if fs.FolderExists(strHost&strYear)=false then
			set fileObj=fs.CreateFolder(strHost&strYear)

		end if

'Create folder if not found
		if fs.FolderExists(strHost&strYear & "\" & strMONTH)=false then
			set fileObj=fs.CreateFolder(strHost&strYear & "\" & strMONTH)
		end if


response.write "<br>"  & strHost & strYear  & "/" & strMONTH & "/" & saveAsName

		set fileObj=fs.CreateTextFile((strHost & strYear  & "/" & strMONTH & "/" & saveAsName),true)

		fileObj.WriteLine(newsTemplate)
		fileObj.Close
		set fileObj=nothing
		set fs = Nothing

		set oRsArticle = nothing

		Response.Write("\articles\" & strYear & "\" & strMONTH & "\" & saveAsName & "<br>")

End Sub

Function CMonthToString(ByRef iMonth)
	CMonthToString = iMonth
End Function

'==================================================================
'Function GenArticleFileName ()
'==================================================================
' Description : ไว้สำหรับ Generate file name ของ ArticlePage นั้น 
'
'Code exam :
'	GenArticleFileName("Test Article","389","0")
'
'Result : 
'   Test_Article_389_0.asp
'==================================================================
Function GenArticleFileName(prmArticleName,prmArticelID,prmPageIndex)
	prmArticleName = Replace(prmArticleName, " ", "_")	
	prmArticleName = Left(prmArticleName,30)& "_" & prmArticelID & "_" & prmPageIndex
	
	tmpStr = Replace(prmArticleName, ",", "")
	tmpStr = Replace(tmpStr, ".", "")
	tmpStr = Replace(tmpStr, "/", "_")
	tmpStr = Replace(tmpStr, "\", "_")
	tmpStr = Replace(tmpStr, ":", "_")
	tmpStr = Replace(tmpStr, "*", "_")
	tmpStr = Replace(tmpStr, "?", "_")
	tmpStr = Replace(tmpStr, "<", "_")
	tmpStr = Replace(tmpStr, ">", "_")
	tmpStr = Replace(tmpStr, "|", "_")
	tmpStr = Replace(tmpStr, """", "_")
	tmpStr = Replace(tmpStr, "#", "_")
	tmpStr = Replace(tmpStr, "'", "_")
'	tmpStr = Replace(tmpStr, ":", "")
	tmpStr = LCase(tmpStr)
	GenArticleFileName = tmpStr & ".asp"
End Function


Function DisplayDate(PublishDate)
	

	PublishDay = Right(PublishDate,2)  
	PublishMonth = Mid(PublishDate,5,2) 
	PublishYear =  Left(PublishDate,4)

DisplayDate = Cint(PublishDay)  & " "  & MonthName(Cint(PublishMonth )) & " " &  PublishYear 

End Function
%>
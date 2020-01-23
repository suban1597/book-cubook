<%
'Book Cover Part 1
'==============================================================

Function ChkFile(FileStr)
	Set fs=Server.CreateObject("Scripting.FileSystemObject")
	If (fs.FileExists(FileStr))=true Then
		  ChkFile = True
	Else
		  ChkFile = False
	End If
	set fs=nothing
End Function

'End Book Cover Part 1
'==============================================================

'Book Cover Part 2
'==============================================================

Function ChkFilebook2(FileStr)
	Set fs=Server.CreateObject("Scripting.FileSystemObject")
	If (fs.FileExists(FileStr))=true Then
		  ChkFilebook2 = True
	Else
		  ChkFilebook2 = False
	End If
	set fs=nothing
End Function

'End Book Cover Part 2
'==============================================================

'Book Cover Part 3
'==============================================================

Function ChkFilebook3(FileStr)
	Set fs=Server.CreateObject("Scripting.FileSystemObject")
	If (fs.FileExists(FileStr))=true Then
		  ChkFilebook3 = True
	Else
		  ChkFilebook3 = False
	End If
	set fs=nothing
End Function

'End Book Cover Part 3
'==============================================================

'GetBookCover
'==============================================================

Sub GetBookCover(FileName)
	books = false
	book2 = false
	Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
	
	if FileObject.FileExists ( Server.MapPath ("/") & "\images\book-400\" &FileName) then
		books = true
		response.write"<img src=""/images/book-400/" & FileName & """  alt=""Book"" border=""0"" height=""100px""/>"
	end if
	
	if books = false then
		if FileObject.FileExists ( Server.MapPath ("/") & "\images\book-400\" &FileName) then
			response.write "<img src=""/images/book-400/" & FileName & """  alt=""Book"" border=""0"" height=""100px""/>"
		else
			 response.write "<img src=""/images/book-400/apology.jpg"" alt=""Book"" border=""0"" height=""100px""/>"
		end if
	end if
End Sub

'End GetBookCover
'==============================================================


'CheckOnhand
'==============================================================

Function CheckOnhand(Barcode)

sql_check=" SELECT sb_oh,sb14_oh,language FROM booklist WHERE barcode = '"&Barcode&"' " 
Set Rs_check=Server.CreateObject("ADODB.RecordSet")
Rs_check.Open  sql_check, Conn, 1, 3

if language = 1 then
if Rs_check("sb_oh")+Rs_check("sb14_oh") >= 3 then
CheckOnhand = 1
else
CheckOnhand = 0
end if
else
if Rs_check("sb_oh")+Rs_check("sb14_oh") >= 5 then
CheckOnhand = 1
else
CheckOnhand = 0
end if
end if

End Function

'End CheckOnhand
'==============================================================
%>


<%
Sub GetCoverImage(FileName)
	bigcover = false
	smallcover = false
	Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
	
	if FileObject.FileExists ( Server.MapPath ("/") & "\images\book-400\" &FileName) then
		bigcover = true
		response.write"<img src=""/images/book-400/" & FileName & """  alt=""Book"" border=""0"" width=""200"" />"
	end if
	
	if bigcover = false then
		'if FileObject.FileExists ( Server.MapPath ("/") & "\images\books\" &FileName) then
			'response.write "<img src=""/images/books/" & FileName & """  alt=""Book"" border=""0""/>"
		'else
		
			 response.write "<img src=""/images/book-400/apology.jpg"" alt=""Book"" border=""0"" width=""200""/>"
		'end if
	end if

End Sub



Sub ReadBinFile(FileName)
	Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
	Set InStream= FileObject.OpenTextFile ( Server.MapPath ("/") & "\images\book-400\" &FileName,1,0,0)
	InStream.close
	Set InStream=Nothing
End Sub

Sub ReadBinFile2(FileName)
	Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
	Set InStream= FileObject.OpenTextFile ( Server.MapPath ("/") & "\images\book-400\" &FileName,1,0,0)
	InStream.close
	Set InStream=Nothing
End Sub

Function ReadTextFile(FileName)
	Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
	Set InStream= FileObject.OpenTextFile ( Server.MapPath ("/") & "\text\" &FileName,1,0,0)
	While not InStream.AtEndOfStream
		ReadTextFile = Instream.ReadAll
	Wend
	InStream.close
	Set InStream=Nothing
End Function

Sub ReadCheck(FileName)
On Error Resume Next
Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
	Set InStream= FileObject.OpenTextFile ( Server.MapPath ("/") & "\text\" &FileName,1,0,0)
	InStream.close
	Set InStream=Nothing
End Sub

Function TopicType(Language)
If language=1 Then
	TopicType = "รายละเอียดสินค้า"
Elseif language=2 Then
	TopicType = "Description"
Else
	TopicType = "รายละเอียดสินค้า"
End If
End Function

Function BookCover(CoverNumber)
If Cint(CoverNumber) = "1" Then
	BookCover="ปกอ่อน"
	adjust=0
Else
	BookCover="ปกแข็ง"
	adjust=0.065
End If
End Function

'the two functions below return the next 10 and prev 10 page number
Function getNext10(num)
pageLen = len(num)
If pageLen = 1 Then
next10 = 10
Else If pageLen>1 Then
pageRem = 10
pageTen = right(num, 1)
next10 = num + pageRem - pageTen
End If
End If
getNext10 = next10
End Function

Function getPrev10(num)
pageLen = len(num)
If pageLen = 1 then
prev10 = 1
Else If pageLen>1 then
lastNumber = right(num, 1)
prev10 = num - lastNumber - 10
End If
End If
If prev10 = 0 then
prev10 = 1
End If
getPrev10 = prev10
End Function
%>

<%
Function ChkAdmin(ordertime)
If ordertime = "235407" then
ChkAdmin = "006661"
End If

End Function

Function PrintMethod(PM)
If PM="1" Then
PrintMethod="Cash"
ElseIf PM="2" Then
PrintMethod="Credit Card"
ElseIf PM="3" Then
PrintMethod="Faxed Credit Card"
ElseIf PM="4" Then
PrintMethod="Bank Transfer"
ElseIf PM="5" Then
PrintMethod="Bank Draft"
ElseIf PM="6" Then
PrintMethod="Money Order"
Else
PrintMethod="&nbsp;"
End If
End Function

Function ReplaceString(Stringname)

ReplaceString = replace(Stringname,"'","")

End Function
%>
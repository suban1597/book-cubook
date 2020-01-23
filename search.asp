<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
	<title>ค้นหา</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<%
username = request("username")
password = request("password")
Wholeword = trim(request("keyword"))
Option1 = request("option1")
%>

<font class="text_header">ผลการค้นหา</font>
<%
' multikeyword generator (in/out:keyword/wholeword)	
Dim pKeyword, Wholeword
ReDim pKeyword(10)
'general check
Wholeword=trim(Request.QueryString("keyword"))


	If Wholeword="" Then 
			Wholeword=Request.Form("keyword")
	End If

	If InStr(Wholeword, "%") > 0 Then 
			Wholeword="" 
	End If

	If Wholeword="*" Then 
			Wholeword="" 
	End If

	If Wholeword="" Then 
			'Response.Redirect "advancesearch.asp"
			response.end
	End If

' analysis
		WordLen= Int(len(WholeWord))
		j=0
		K=0
			For  i = 1 to WordLen 
				Check= Mid(WholeWord,i,1)
					If (Check=" ") or (Check="+")Then
						k=k+1
						pKeyword(k)= Mid(WholeWord,j+1,i-1-j)
						If Len(pKeyword(k))=0 Then
							k=k-1
						End If
							j=i
					End If
			Next 
				pKeyword(k+1)= Mid(WholeWord,j+1)
				nkeyword=k+1
'-------------------------------------------------------------------------------------------------
%>
<%
eDate = (year(date())) - 2
eDate2 = (year(date())) + 2

tDate = (year(date())) - 2 + 543
tDate2 = (year(date())) + 543


'  Search "Author"  
' ============================================
If Option1="author" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE "
		For k = 1 to nkeyword
				If Not (k = nkeyword) Then
						sql=sql &" (author like '%"& pKeyword(k) & "%') AND "
				Else
						sql=sql &" (author like '%"& pKeyword(k) & "%')  "
				End If
		Next
		sql = sql & "  and ((language=1 and (sb_oh+sb14_oh)>=0 and([year] BETWEEN '"&tDate&"' and  '"&tDate2&"')) or ((language=1 and (sb_oh+sb14_oh)>=4 )) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and([year] BETWEEN '"&eDate&"' and  '"&eDate2&"')))  "
'sql = sql&"ORDER BY booklist.year desc ,booklist.title"
sql=sql&"order by sb_oh+sb14_oh+stock_oh+jj_oh DESC, [year] DESC"
End If
' ============================================
%>
<%
'  Search "ISBN"  
' ============================================
If Option1="isbn" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE "
			For k = 1 to nkeyword
					If Not (k = nkeyword) Then
							sql=sql &" (isbn like '%"& pKeyword(k) & "%') AND "
					Else
							sql=sql &" (isbn like '%"& pKeyword(k) & "%')  "
					End If
			Next
sql = sql & "  and ((language=1 and (sb_oh+sb14_oh)>=0 and([year] BETWEEN '"&tDate&"' and  '"&tDate2&"')) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and([year] BETWEEN '"&eDate&"' and  '"&eDate2&"')))  "
End If
' ============================================
%>
<%
'  Search "Barcode"  
' ============================================
If Option1="barcode" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM booklist WHERE "
For k = 1 to nkeyword
					If Not (k = nkeyword) Then
							sql=sql &" (barcode like '%"& pKeyword(k) & "%') AND "
					Else
							sql=sql &" (barcode like '%"& pKeyword(k) & "%')  "
					End If
			Next
sql = sql & " and ((language=1 and (sb_oh+sb14_oh+stock_oh)>=0 and([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )) or ((language=1 and (sb_oh+sb14_oh)>=4 )) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=2 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or ((language=2 and (sb_oh+sb14_oh)>=2 ))or (language=3 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=5 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )))"
		


End If
' ============================================
%>
<%
'  Search "All Title"  
' ============================================
If Option1="title" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE  "

For k = 1 to nkeyword
							If Not (k = nkeyword) Then							
									sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
							Else						
									sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
							End If
Next

sql = sql & " and ((language=1 and (sb_oh+sb14_oh)>=0 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"')) or ((language=1 and (sb_oh+sb14_oh)>=4 )) or (language=2 and (sb_oh+sb14_oh)>=2 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"'))  or ((language=2 and (sb_oh+sb14_oh)>=2 )) or (language=3 and(sb_oh+sb14_oh+stock_oh)>=4 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"'))) "
'sql = sql&"ORDER BY booklist.year desc ,booklist.title"
sql=sql&"order by sb_oh+sb14_oh+stock_oh+jj_oh DESC, [year] DESC"
End If
' ============================================
%>
<%
'response.write "sql =  " & sql
'response.end

Set RS=Server.CreateObject("ADODB.RecordSet")
RS.open sql, Conn, 1,3


TotalRec=rs.recordcount
 RS.PageSize=25
PageCount=Request.QueryString("PageCount")

If PageCount <>"" Then
	PageNumber=PageCount
	If PageNumber < 1 Then PageNumber = 1 End If
Else
	PageNumber = 1
End If

'response.write "recordcount = " & TotalRec & "<br>"

'response.write "PageNumber = " & PageNumber & "<br>"

If Not RS.EOF Then RS.AbsolutePage=PageNumber End If
rspagecount=rs.pagecount
'response.write "PageCount = " & rspagecount & "<br>"


RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)
%>
<%On Error Resume Next%>
        
 
 
 <%
   ' Find Book Cover
		' ===================================================================
		bookimgpt = "C:\Chulabook\images\book-400\" & RS("barcode") &  ".jpg"			
		'bookimgpt2 = "C:\Chulabook\images\book2\" & RS("barcode") &  ".jpg"	
		if   ChkFile(bookimgpt) = true then
				bookimg = "http://www.chulabook.com/images/book-400/" & RS("barcode") &".jpg"				
		'elseif ChkFilebook2(bookimgpt2) = true then
		''		bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".jpg"
		else	
				bookimg = "http://www.chulabook.com/images/book-400/apology.jpg"
		end if
		' =================================================================

%>




	<table width="100%" border="0" cellspacing="2" cellpadding="2">      
      <tr>
        <td width="7%" valign="top">
		  <div align="center">

<img src="<%=bookimg%>" border="0" height="100"/>
 
 
 </div></td>
        <td width="93%" valign="top">
		  <div align="left">
 <a class="text_normal" href="description.asp?barcode=<%=RS("barcode")%>"><%=RS("title")%><%=RS("title1")%></a><br />
	  <%=RS("barcode")%><br />
      ผู้แต่ง : <%=RS("author")%> บาท<br />
      ราคา : <%=Formatnumber(RS("price"),2)%> บาท<br />
      
      </td>
      </tr>     
    </table>
    <table border=0 width="100%">
<tr>
<td higth="1" style="background-image:url(images/line4.png); background-repeat:x; margin-left:0px;">
</td>
</tr>
</table>

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
	
	
	
	
	  <% itsallpage = rspagecount %>
                    <span class="text">&nbsp;พบข้อมูลจำนวน <%=itsallpage%> หน้า</span><br />
                    <%for itscount = 1 to itsallpage %>
              &nbsp;<a href="search.asp?keyword=<%=wholeword%>&amp;option1=<%=option1%>&amp;pagecount=<%=itscount%>" class="text"><%=itscount%></a>
              <%next%>
              
              <!--#include file="inc_footer.asp"-->
</body>
</html>
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
.style2 {
	color: #990000;
}
-->
</style>
<%
' multikeyword generator (in/out:keyword/wholeword)	
Dim pKeyword, Wholeword
ReDim pKeyword(10)
' general check

If len(Request.QueryString("keyword")) > 300 Then
	response.Redirect "http://www.chulabook.com/Home.asp"
End If

Wholeword=trim(Request.QueryString("keyword"))

	If Wholeword="" Then 
			Wholeword=Request.Form("keyword")
	End If



	If Wholeword="*" Then 
			Wholeword="" 
	End If

	If Wholeword="" Then 
			Response.Redirect "http://www.chulabook.com"
		
	End If
'-------------------------------------------------------------------------------------------------

'Insert Keyword Statistics	
	'	sql = "Insert into Keyword_Search values ('"&Wholeword&"',Convert(Nvarchar(8),GetDate(),112),'" & request.ServerVariables("REMOTE_ADDR") & "') "
 	'	Set rs=Server.CreateObject("ADODB.Recordset")
	'	Conn.execute(sql)		
'-------------------------------------------------------------------------------------------------

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
' multikeyword generator
Option1=Request.QueryString("option1")

If Option1="" Then 
	Option1=Request.Form("option1") 
End If

Option2=Request.QueryString("option2")
If Option2="" Then 
	Option2=Request.Form("option2") 
End If
%>
<%
eDate = (year(date())) - 2
eDate2 = (year(date())) + 2

tDate = (year(date())) - 5 + 543
tDate2 = (year(date())) + 543


'  Search "Thai Title"  
' ============================================
If Option1="thai" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE  "

For k = 1 to nkeyword
							If Not (k = nkeyword) Then							
									sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
							Else						
									sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
							End If
Next

sql = sql & " and language=1 and (sb_oh+sb14_oh)>=0 and([year] BETWEEN '"&tDate&"' and  '"&tDate2&"') or (language=1 and (sb_oh+sb14_oh+jj_oh)>=2)"		
sql=sql&"order by CONVERT(datetime,recvdate,5) DESC"
End If
' ============================================
%>
        <%
'  Search "English Title"  
' ============================================
If Option1="eng" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE  "

For k = 1 to nkeyword
							If Not (k = nkeyword) Then							
									sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
							Else						
									sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
							End If
Next

sql = sql & " and language=2 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=0 and([year] BETWEEN '"&eDate&"' and  '"&eDate2&"') or (language=2 and (sb_oh+sb14_oh+jj_oh)>=2)"		
sql=sql&"order by CONVERT(datetime,recvdate,5) DESC"
End If
' ============================================
%>
        <%
 '  Search "VDO"  
' ============================================
If Option1="VDO" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE booklist.category between '8100' and '8174' and (sb_oh+sb14_oh+stock_oh+jj_oh)>=4 and "
		For k = 1 to nkeyword
			If Not (k = nkeyword) Then	
				sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
			Else	
				sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
			End If
		next
sql=sql&"order by CONVERT(datetime,recvdate,5) DESC"
End If
' ===========================================
%>
        <%
'  Search "Software"  
' ===========================================
If Option1="SOFT" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE booklist.category between '8300' and '8374' and (sb_oh+sb14_oh+stock_oh+jj_oh)>=4 and "
		For k = 1 to nkeyword
				If Not (k = nkeyword) Then		
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
				Else	
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') "
				End If
		Next
sql=sql&"order by CONVERT(datetime,recvdate,5) DESC"
End If
' ===========================================
%>
        <%
'  Search "Media"  
' ===========================================
If Option1="MEDIA" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE booklist.category between '8400' and '8474' and (sb_oh+sb14_oh+stock_oh+jj_oh)>=4 and "
		For k = 1 to nkeyword
				If Not (k = nkeyword) Then				
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
				Else		
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
				End If
		Next
sql=sql&"order by CONVERT(datetime,recvdate,5) DESC"
End If
' ===========================================
%>
        <%
'  Search "CD"  
' ===========================================
If Option1="CD" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE booklist.category between '8500' and '8574' and (sb_oh+sb14_oh+stock_oh+jj_oh)>=4 and "
		For k = 1 to nkeyword
				If Not (k = nkeyword) Then
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
				Else
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
				End If
		Next
sql=sql&"order by CONVERT(datetime,recvdate,5) DESC"
End If
' ===========================================
%>
        <%
'  Search "VCD"  
' ===========================================
If Option1="VCD" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh FROM  booklist  WHERE booklist.category between '8600' and '8674' and (sb_oh+sb14_oh+stock_oh+jj_oh)>=4 and "
		For k = 1 to nkeyword
				If Not (k = nkeyword) Then
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
				Else  
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
				End If
		Next
sql=sql&"order by CONVERT(datetime,recvdate,5) DESC"
End If
' ===========================================
%>
        <%
'  Search "DVD"  
' ============================================
If Option1="DVD" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh FROM  booklist WHERE booklist.category between '8800' and '8874' and (sb_oh+sb14_oh+stock_oh+jj_oh)>=4 and "
		For k = 1 to nkeyword
				If Not (k = nkeyword) Then
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
				Else
						sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
				End If
		Next
sql=sql&"order by CONVERT(datetime,recvdate,5) DESC"
End If
' ============================================
%>
        <%
'  Search "Author"  
' ============================================
If Option1="Author" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE "
		For k = 1 to nkeyword
				If Not (k = nkeyword) Then
						sql=sql &" (author like '%"& pKeyword(k) & "%') AND "
				Else
						sql=sql &" (author like '%"& pKeyword(k) & "%')  "
				End If
		Next
sql=sql & " and ((language=1 and (sb_oh+sb14_oh+jj_oh)>=0) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=2) or (language=3 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=5 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )))" '08-07-2016
		'sql = sql & "  and ((language=1 and (sb_oh+sb14_oh)>=0 and([year] BETWEEN '"&tDate&"' and  '"&tDate2&"')) or ((language=1 and (sb_oh+sb14_oh)>=4 )) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and([year] BETWEEN '"&eDate&"' and  '"&eDate2&"')))  "
'sql = sql&"ORDER BY booklist.year desc ,booklist.title"
sql=sql&"order by sb_oh+sb14_oh+stock_oh+jj_oh DESC, [year] DESC"
End If
' ============================================
%>

        <%
'  Search "Ebook"
' ============================================
If Option1="Ebook" Then
sql="SELECT book_name ,isbn ,book_author ,book_bath_price,book_id,book_file_size,book_thumbnail_path FROM  Ebooklist WHERE "
'sql="SELECT book_name ,isbn ,book_author ,book_bath_price,book_id,book_file_size FROM Ebooklist WHERE"

For k = 1 to nkeyword
							If Not (k = nkeyword) Then							
									sql=sql &" (book_name like '%"& replace(pKeyword(k),"'","''") & "%') AND "
							Else						
									sql=sql &" (book_name like '%"& replace(pKeyword(k),"'","''") & "%') AND " 
							End If
Next
sql=sql&"(isbn <> '')"

End If
' ============================================
%>

        <%
'  Search "ISBN"  
' ============================================
If Option1="ISBN" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE "
			For k = 1 to nkeyword
					If Not (k = nkeyword) Then
							sql=sql &" (isbn like '%"& pKeyword(k) & "%') AND "
					Else
							sql=sql &" (isbn like '%"& pKeyword(k) & "%')  "
					End If
			Next
sql=sql & " and ((language=1 and (sb_oh+sb14_oh+jj_oh)>=0) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=2) or (language=3 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=5 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )))" '08-07-2016
'sql = sql & "  and ((language=1 and (sb_oh+sb14_oh)>=0 and([year] BETWEEN '"&tDate&"' and  '"&tDate2&"')) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and([year] BETWEEN '"&eDate&"' and  '"&eDate2&"')))  "
End If
' ============================================
%>
<%
'  Search "Barcode"  
' ============================================
If Option1="Barcode" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM booklist WHERE " 
For k = 1 to nkeyword
					If Not (k = nkeyword) Then
							sql=sql &" (barcode like '%"& pKeyword(k) & "%') AND "
					Else
							sql=sql &" (barcode like '%"& pKeyword(k) & "%')  "
					End If
			Next
sql=sql & " and ((language=1 and (sb_oh+sb14_oh+jj_oh)>=0) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or (language=3 and (sb_oh+sb14_oh+jj_oh)>=5))" '28-09-2016
'sql=sql & " and ((language=1 and (sb_oh+sb14_oh+jj_oh)>=0) or (language=2 and (sb_oh+sb14_oh+jj_oh)=0 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=2) or (language=3 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=5 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )))" '08-07-2016
'sql=sql & " and ((language=1 and (sb_oh+sb14_oh+stock_oh)>=0 and([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' ))or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or (language=3 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=5 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )))" '29-07-2016
'sql=sql & " and ((language=1 and (sb_oh+sb14_oh+stock_oh)>=0 and([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )) or ((language=1 and (sb_oh+sb14_oh+stock_oh)>=4 )) or ((sb_oh+sb14_oh+jj_oh)>=2 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or (language=3 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=5 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )))"




End If
' ============================================
%>
<%
'  Search "All Title"  
' ============================================
If Option1="alltitle" Then
sql="Select  barcode,title+title1 as title,author,edition,[year],isbn,price,disctype,disctype1,language,distribute,translator,sb_oh,sb14_oh,stock_oh,jj_oh  FROM  booklist WHERE  "

For k = 1 to nkeyword
							If Not (k = nkeyword) Then							
									sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') AND "
							Else						
									sql=sql &" (title+title1 like '%"& replace(pKeyword(k),"'","''") & "%') " 
							End If
Next

sql=sql & " and ((language=1 and (sb_oh+sb14_oh+jj_oh)>=0) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=0) or (language=3 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=5 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )))" '28-09-2016
'sql=sql & " and ((language=1 and (sb_oh+sb14_oh+jj_oh)>=0) or (language=2 and (sb_oh+sb14_oh+jj_oh)=0 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"' )) or (language=2 and (sb_oh+sb14_oh+jj_oh)>=2) or (language=3 and (sb_oh+sb14_oh+stock_oh+jj_oh)>=5 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"' )))" '08-07-2016
'sql = sql & " and ((language=1 and (sb_oh+sb14_oh)>=0 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"')) or ((language=1 and (sb_oh+sb14_oh+stock_oh)>=4 )) or (language=2 and (sb_oh+sb14_oh)>=2 and ([year] BETWEEN '"&eDate&"' and  '"&eDate2&"'))  or ((language=2 and (sb_oh+sb14_oh)>=2 )) or (language=3 and(sb_oh+sb14_oh+stock_oh+jj_oh)>=4 and ([year] BETWEEN '"&tDate&"' and  '"&tDate2&"'))) "
'sql = sql&"ORDER BY booklist.year desc ,booklist.title"
sql=sql&"order by sb_oh+sb14_oh+stock_oh+jj_oh DESC, [year] DESC"
End If
' ============================================
%>
        <%
'response.write sql
'response.End()
Set RS=Server.CreateObject("ADODB.RecordSet")
set comm=Server.CreateObject("ADODB.Command")
'RS.Cursorlocation=3
RS.open sql, Conn, 1,1

TotalRec=rs.recordcount
 RS.PageSize=10
PageCount=Request.QueryString("PageCount")

If PageCount <>"" Then
	PageNumber=PageCount
	If PageNumber < 1 Then PageNumber = 1 End If
Else
	PageNumber = 1
End If
If Not RS.EOF Then RS.AbsolutePage=PageNumber End If
rspagecount=rs.pagecount
%>
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
  <tr>
    <td height="32" align="left"><b>ค้นหาจาก <b><%=wholeword%></b> จากประเภท
      <%if option1="thai" then%>
      หนังสือไทย
      <%elseif option1="eng" then%>
      หนังสือเทศ
      <%elseif option1="TAPE" then%>
      คาสเซ็ทเทป
      <%elseif option1="SOFT" then%>
      ซอฟต์แวร์
      <%elseif option1="alltitle" then%>
      รายชื่อสินค้า
      <%elseif option1="MEDIA" then%>
      สื่อสร้างสรรค์
      <%elseif option1="Author" then%>
      ผู้แต่ง / ผู้แปล
      <%elseif option1="CD" then%>
      CD-ROM
      <%else%>
      <%=option1%>
      <%end if%>
      พบ <%=totalrec%> รายการ
      <%if PageCount <> "" Then%>
      ข้อมูลหน้าที่ <%=PageCount%>
      <%end if%>
      </b>
        </div></td>
  </tr>
</table>

<%
If Option1="Ebook" Then
%>

<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <%
RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)

%>
    <td width="204" valign="top"><div align="center">
      <%On Error Resume Next%>           
      <%		     
	    ' Find Book Cover
		' ===================================================================
		'if RS("book_thumbnail_path") = "" then
		'bookimg = "http://www.chulabook.com/images/books/apology.gif"
		'else
		'bookimg = RS("book_thumbnail_path") & "tiny.gif"
		'end if
		' =================================================================
		
		' Find Book Cover
		' ===================================================================
		'bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & RS("isbn") &  ".gif"			
		'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("isbn") &  ".gif"	
		'if   ChkFile(bookimgpt) = true then
				'bookimg = "http://www.chulabook.com/images/books/" & RS("isbn") &  ".gif"				
		'elseif ChkFilebook2(bookimgpt2) = true then
				'bookimg = "http://www.chulabook.com/images/book2/" & RS("isbn") &  ".gif"
		'else	
				'bookimg = "http://www.chulabook.com/images/books/apology.gif"
		'end if
		' =================================================================
		if RS("book_thumbnail_path") = "" then
		bookimg = "images/book-400/apology.jpg"
		else
		bookimg = RS("book_thumbnail_path") & "tiny.gif"
		end if
	  %><img src="<%=bookimg%>" height="100px" />
    </div></td>
    <td width="736" valign="top"><form id="addtocart" name="addtocart" method="post" action="shopping.asp">
    	<% if CDbl(RS("book_bath_price")) < CDbl(1) then %>
        <div align="left"><a href="description_freebook.asp?book_id=<%=RS("book_id")%>" class="text"><b><%=RS("book_name")%></b></a><br>
        <% else %>
      	<div align="left"><a href="description_ebook.asp?barcode=<%=RS("isbn")%>" class="text"><b><%=RS("book_name")%><%response.Write(" (Ebook)")%></b></a><br />
        <% end if %>
            <span class="text">ผู้แต่ง/ผู้แปล : <%=RS("book_author")%><br />
              isbn : <%=RS("isbn")%><br />
			  ขนาด : <%response.Write RS("book_file_size")&" kb"%><br/>              
              ราคา : <%response.Write (FormatNumber(RS("book_bath_price"),0)&" บาท")%><br/>  
              อ่านได้บน : iPad, iPhone, iPod Touch (iOS 4 ขึ้นไป)<br/>
        <input name="taken" type="hidden" id="taken" value="1"  />
        <input type="hidden" name="barcode"  value="<%=RS("isbn")&"e"%>" />
        <input type="hidden" name="price" value="<%=RS("book_bath_price")%>" />
        <input type="hidden" name="book_id" value="<%=RS("book_id")%>" />
        <input type="hidden" name="ebook" value="1" />   
        <input type="hidden" name="action" value="Add" />    
         <% 
		 if CDbl(RS("book_bath_price")) < CDbl(1) then     
      	 else
		 %>
         <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" />  		        
        <%end if%>
        
        <!--a href="insert_wishlist.asp?barcode=<%=RS("isbn")%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border="0"/></a--></div>
    </form>
         <% if CDbl(RS("book_bath_price")) < CDbl(1) then %>    
		    <form id="free-load" name="free-load" method="post" action="free_download_api.asp">
		        <input type="hidden" id="book_id" name="book_id" value="<%=RS("book_id")%>" />       
		        <input type="image" src="images/icons/download2.png" id="bt_download" name="bt_download" border="0" />
			</form>
			<% if RS("book_id") = "1613" OR RS("book_id") = "4702" then %>
                <div style="border-bottom:medium"><b><u>PDF On Computer :</u></b> <img src="http://www.chulabook.com/images/down.jpg" width="20" height="20" align="absbottom" /> <a href="http://www.chulabook.com/word/<%=RS("book_id")%>.pdf" target="_blank">ดาวน์โหลด</a></div>
            <% end if %>
    	<%end if%>
    </td>
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
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2">
          <tr>
            <td><div align="left"> <br />
                  <% itsallpage = rspagecount %>
                    <span class="text">&nbsp;พบข้อมูลจำนวน <%=itsallpage%> หน้า</span><br />
                    <%for itscount = 1 to itsallpage %>
                    <%'for itscount = 1 to 13 %>
              &nbsp;<a href="speedsearch_ebook.asp?keyword=<%=wholeword%>&amp;option1=<%=option1%>&amp;pagecount=<%=itscount%>" class="text"><%=itscount%></a>
              <%next%>
            </div></td>
          </tr>
</table>

<%else%>

<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <%
RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)

%>
    <td width="204" valign="top"><div align="center">
      <%On Error Resume Next%>           
      <%		     
	    ' Find Book Cover
		' ===================================================================
		'if RS("book_thumbnail_path") = "" then
		'bookimg = "http://www.chulabook.com/images/books/apology.gif"
		'else
		'bookimg = RS("book_thumbnail_path") & "tiny.gif"
		'end if
		' =================================================================
		
				' Find Book Cover
		' ===================================================================
		'bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & RS("barcode") &  ".gif"			
		'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("barcode") &  ".gif"	
		'if   ChkFile(bookimgpt) = true then
		''		bookimg = "http://www.chulabook.com/images/books/" & RS("barcode") &  ".gif"				
		'elseif ChkFilebook2(bookimgpt2) = true then
		''		bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".gif"
		'else	
		''		bookimg = "http://www.chulabook.com/images/books/apology.gif"
		'end if

		bookimgpt = "C:\Chulabook\images\book-400\" & RS("barcode") &  ".jpg" 
	    'bookimgpt2 = "C:\Chulabook\images\book2\" & RS("barcode") &  ".jpg"    
	    if   ChkFile(bookimgpt) = true then
	        bookimg = "images/book-400/" & RS("barcode") &  ".jpg"        
	    'elseif ChkFilebook2(bookimgpt2) = true then
	        'bookimg = "http://203.154.162.41/images/book2/" & RS("barcode") &  ".jpg"
	    else  
	        bookimg = "images/book-400/apology.jpg"
	    end if
		' =================================================================
	  %><img src="<%=bookimg%>" height="100px" />
    </div></td>
    <td width="736" valign="top"><form id="addtocart" name="addtocart" method="post" action="shopping.asp">
      <div align="left"><a href="description.asp?barcode=<%=RS("barcode")%>" class="text"><b><%=RS("Title")%><%=RS("Title1")%></b></a><br />
            <span class="text">ผู้แต่ง/ผู้แปล : <%=RS("Author")%><%if RS("translator") <> "" then response.Write "/" & RS("translator") end if %><br />
              Barcode : <%=RS("Barcode")%><br />
              ราคาปก : <%=FormatNumber(RS("price"),0)%> บาท<br />
              <!--ราคาพิเศษ:-->
              <% 
Barcode = RS("Barcode")
Dim SpecialPrice
SpecialPrice = Calculate_Price(Barcode)
'response.Write FormatNumber(SpecialPrice,0)
response.Write "ราคาพิเศษ :&nbsp;" & FormatNumber(SpecialPrice,0) & "&nbsp;บาท &nbsp;<font color=red>(เฉพาะสั่งซื้อออนไลน์)</font>"
%>
              <!--บาท--></span><br />
<!-- sb_sb14_oh = RS("sb_oh") + RS("sb14_oh") 

if  RS("Language") = 1 Then	
		if sb_sb14_oh < 4 Then
			oh_type = 1
		else 
			oh_type = 0
		end if	
else if RS("Language") = 2 Then
		if sb_sb14_oh < 2 Then
			oh_type = 1
		else 
			oh_type = 0
		end if
else if RS("Language") = 3 Then
		if sb_sb14_oh < 4 Then
			oh_type = 1
		else 
			oh_type = 0
		end if
end if
end if
end if


%-->
        <input name="taken" type="hidden" id="taken" value="1"  />
        <input type="hidden" name="barcode"  value="<%=barcode%>" />
        <input type="hidden" name="book_id" value="null" />
        <input type="hidden" name="ebook" value="1" />  
        <input type="hidden" name="taken" id="taken"  value="1" />
        <% If SpecialPrice<>"" Then %>
        <input type="hidden" name="price" value="<%= SpecialPrice %>" />
        <% Else %>
        <input type="hidden" name="price" value="<%=price%>" />
        <% End If %>
        <input type="hidden" name="action" value="Add" />
        <input type="hidden" name="oh_type" value="<%=oh_type%>" />
<%
'Check Onhand ตะกร้าสินค้า
If RS("booktype") = 1 Then
	If RS("Language") = 1 Then
		total_oh = RS("sb_oh")+RS("sb14_oh")
		If total_oh >= 4 Then
			response.write "<input type=image src=images/icons/cart.png alt=Add to cart  title=หยิบใส่ตระกร้า border=0 name=image />"
			'response.write total_oh
		else if RS("stock_oh") >= 20 Then
			response.write "<input type=image src=images/icons/cart.png alt=Add to cart  title=หยิบใส่ตระกร้า border=0 name=image />"
		else
			response.write "<img src=images/icons/non-cart.png   border=0 name=image2 />"
		end if
		end if
	else 
	If RS("Language") = 2 Then
		total_oh2 = RS("sb_oh")+RS("sb14_oh")+RS("jj_oh")
		If total_oh2 >= 2 Then
			response.write "<input type=image src=images/icons/cart.png alt=Add to cart  title=หยิบใส่ตระกร้า border=0 name=image />"
			'response.write total_oh2
		else if RS("stock_oh") >= 20 Then
			response.write "<input type=image src=images/icons/cart.png alt=Add to cart  title=หยิบใส่ตระกร้า border=0 name=image />"
			'response.write total_oh2
		else
			response.write "<img src=images/icons/non-cart.png   border=0 name=image2 />"
			'response.write total_oh2
		end if
		end if
	else 
	If RS("Language") = 3 Then
		total_oh3 = RS("sb_oh")+RS("sb14_oh")+RS("jj_oh")
		If total_oh3 >= 5 Then
			response.write "<input type=image src=images/icons/cart.png alt=Add to cart  title=หยิบใส่ตระกร้า border=0 name=image />"
			'response.write total_oh2
		else if RS("stock_oh") >= 20 Then
			response.write "<input type=image src=images/icons/cart.png alt=Add to cart  title=หยิบใส่ตระกร้า border=0 name=image />"
			'response.write total_oh2
		else
			response.write "<img src=images/icons/non-cart.png   border=0 name=image2 />"
			'response.write total_oh2
		end if
		end if
	end if
	end if
	end if
end if
	

%>
        <!--input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" /-->
        
        
        <a href="insert_wishlist.asp?barcode=<%=RS("barcode")%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border="0"/></a></div>
    </form></td>
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
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2">
          <tr>
            <td><div align="left"> <br />
                  <% itsallpage = rspagecount %>
                    <span class="text">&nbsp;พบข้อมูลจำนวน <%=itsallpage%> หน้า</span><br />
                    <%for itscount = 1 to itsallpage %>
                    <%'for itscount = 1 to 13 %>
              &nbsp;<a href="speedsearch.asp?keyword=<%=wholeword%>&amp;option1=<%=option1%>&amp;pagecount=<%=itscount%>" class="text"><%=itscount%></a>
              <%next%>
            </div></td>
          </tr>
</table>
        
<%end if%>   
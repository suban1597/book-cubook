<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
lower= Request("lower")
upper= Request("upper")


'Select Sub'name Category
Set RSC=Server.CreateObject("ADODB.RecordSet")
RSC.Open  "SELECT sub_category.* FROM sub_category  WHERE category ='" &lower&"' ", Conn, 1, 3

%>

<table width="98%" border="0" cellpadding="2" cellspacing="2">
  <tr>
    <td><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b>ขณะนี้คุณเลือก</b> :&nbsp;<b>หมวด</b> <%=RSC("subname")%> <b>จากประเภท</b> สินค้าทั้งหมด <b>ข้อมูลหน้าที่</b> <%=PageNumber%></font></div></td>
  </tr>
  <tr>
    <td>
      <div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext">เลือกตามประเภท :</font>&nbsp;
<a href="browse.asp?lower=<%=lower%><%If upper <> "" Then%>&amp;upper=<%=upper%><%end if%>" class="text">สินค้าทั้งหมด</a> 
| <a href="browse-eng.asp?lower=<%=lower%><%If upper <> "" Then%>&amp;upper=<%=upper%><%end if%>" class="text">ต่างประเทศ</a>
| <a href="browse-thai.asp?lower=<%=lower%><%If upper <> "" Then%>&amp;upper=<%=upper%><%end if%>" class="text">ภาษาไทย</a></div></td>
  </tr>
  
  <tr>
    <td align="left" valign="center"><!--#include file="inc_subcategory.asp"--></td></tr></table>

<%
'Option Explicit
'declare variables
'Dim Currpage, pageLen, lastNumber, PageRem, PageTen
'Dim connection, recordset, sSQL, sConnString, next10, prev10, P
'Dim RSPrevPage, RSNextPage, start 
'Get the current page the user is on, if it's the first time they
'visit and the variable 'PageNo' is empty, then 'CurrPage' gets set to 1
'Else the current page variable 'CurrPage' is set to the page number requested
If IsEmpty(Request.Querystring("PageNo")) then
CurrPage = 1
Elseif request("PageNo") = 0 Then
CurrPage = 1
Else
CurrPage = Cint(Request.Querystring("PageNo"))
End If 



'create an instance of the ADO connection and recordset object
'Set Connection = Server.CreateObject("ADODB.Connection")
Set Recordset = Server.CreateObject("ADODB.Recordset")

'define the connection string
'sConnString = "PROVIDER=SQLOLEDB; DATA SOURCE=Chulabook;INITIAL CATALOG=Chulabook;User ID=sa;Password=;"

'define our SQL variable
sSQL="Select *  FROM booklist"
sSQL=sSQL&" WHERE (category ='"&lower& "') and language=2 and (sb14_oh+sb_oh)>1"
sSQL=sSQL&" order by CONVERT(datetime,recvdate,5) DESC"


'open an active connection
'Connection.Open sConnString

'Next set the location of the recordset to the client side
Recordset.CursorLocation = 3

'Execute the SQL and return our recordset
Recordset.open sSQL, Conn
' pagesize is used to set the number of records that will be
' displayed on each page. For our purposes 10 records is what we want.
Recordset.PageSize = 8
%>

<%


'get the next 10 and prev 10 page number
next10 = getNext10(CurrPage)
prev10 = getPrev10(CurrPage)

'If there are no records
If Recordset.EOF Then
Response.write "No records to display"

Else
'this moves the record pointer to the first record of the current page
Recordset.AbsolutePage = CurrPage

'the below loop will loop until all the records of the current page have been
'displayed or it has reached the end of the recordset
''Do Until Recordset.AbsolutePage <> CurrPage OR Recordset.Eof

'for our purposes our database has just 3 fields:
'an 'ID' (autonumber field), 'SiteName' (textfield) and 'URL' (memofield)
'you can change these according to your database and table fields
''response.write "Title: " & Recordset ("title") & "<br>"
''response.write "Aothor: " & Recordset ("author") & "<br>"
''response.write "Price: " & Recordset ("price") & "<br><br>" 
''Recordset.MoveNext
''Loop

End If 
%>

<table width="100%" border="0" cellspacing="2" cellpadding="2">
<tr>  
<%
i = 1
Do Until Recordset.AbsolutePage <> CurrPage OR Recordset.Eof

%>
    <td width="162"><div align="center">
                  <%On Error Resume Next%>
                <%		     
	    ' Find Book Cover
		' ===================================================================
		'bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & Recordset("barcode") &  ".gif"			
		'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & Recordset("barcode") &  ".gif"	
		'if   ChkFile(bookimgpt) = true then
				'bookimg = "http://www.chulabook.com/images/books/" & Recordset("barcode") &  ".gif"				
		'elseif ChkFilebook2(bookimgpt2) = true then
				'bookimg = "http://www.chulabook.com/images/book2/" & Recordset("barcode") &  ".gif"
		'else	
				'bookimg = "http://www.chulabook.com/images/books/apology.gif"
		'end if
    bookimgpt = "C:\Chulabook\images\book-400\" & Recordset("barcode") &  ".jpg" 
    'bookimgpt2 = "C:\Chulabook\images\book2\" & Recordset("barcode") &  ".jpg"    
    if   ChkFile(bookimgpt) = true then
        bookimg = "images/book-400/" & Recordset("barcode") &  ".jpg"        
    'elseif ChkFilebook2(bookimgpt2) = true then
        'bookimg = "http://203.154.162.41/images/book2/" & Recordset("barcode") &  ".jpg"
    else  
        bookimg = "images/book-400/apology.jpg"
    end if
		' =================================================================

    
	  %><img src="<%=bookimg%>" height="100px" /> 
    </div></td>
    <td width="837" valign="top">
   <form id="addtocart" name="addtocart" method="post" action="shopping.asp">
     <div align="left">
       <a href="description.asp?barcode=<%=Recordset("barcode")%>" class="blacktext"><b><%=Recordset("Title")%><%=Recordset("Title1")%></b></a><br>
<span class="text">ผู้แต่ง: <%=Recordset("Author")%><br>
Barcode : <%=Recordset("Barcode")%><br>
ราคา : <%=FormatNumber(Recordset("price"),0)%> บาท<br>  
ราคาพิเศษ : 
       <% 
Barcode = Recordset("Barcode")
Dim SpecialPrice
SpecialPrice = Calculate_Price(Barcode)
response.Write FormatNumber(SpecialPrice,0)
%> บาท</span><br>
      <input name="taken" type="hidden" id="taken" value="1"  />
      <input type="hidden" name="barcode"  value="<%=barcode%>" />
      <% If SpecialPrice<>"" Then %>
      <input type="hidden" name="price" value="<%= SpecialPrice %>" />
      <% Else %>
      <input type="hidden" name="price" value="<%=price%>" />
      <% End If %>
      <input type="hidden" name="action" value="Add" />
      <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" />  
      <a href="insert_wishlist.asp?barcode=<%=barcode%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border=0/></a>     </div>
   </form></td>
  <%
	i= i+1
		if i > 2 Then 
		response.Write "</tr>"
		i = 1
		end if
Recordset.MoveNext
Loop
  %>

</table>

<%
'Paging...................................
'Count All pages
RSPageCount=Recordset.PageCount
response.Write "<div align=left><span class=blacktext>&nbsp;&nbsp;จำนวนหน้าทั้งหมด  " & RSPageCount & "  ขณะนี้อยู่หน้าที่  " & CurrPage & "</span><br>"

'the next 2 lines setup the page number for the "previous" and "next" links
RSPrevPage = CurrPage -1
RSNextPage = CurrPage + 1

'find out the number of pages returned in the recordset
'if the Next10 page number is greater than the recordset page count
'then set Next10 to the recordset pagecount
If Next10 > Recordset.PageCount Then
Next10 = Recordset.PageCount
End If

'the variable start determines where to start the page number navigation
' i.e. 1, 10, 20, 30 and so on. 
If prev10 = 1 AND next10 - 1 < 10 Then
start = 1
Else
start = Next10 - 10
If right(start, 1) > 0 Then
start = replace(start, right(start, 1), "0")
start = start + 10
End If
End If
%>

<div class="pagerDRUPAL">
<div class="pager-list">
<%
'This checks to make sure that there is more than one page of results
If Recordset.PageCount > 1 Then
'Work out whether to show the Previous 10 '<<' 
If currpage > 1 Then
response.write("&nbsp;&nbsp;<a href=""browse-eng.asp?upper="&upper&"&amp;lower="&lower&"&amp;PageNo=" & Prev10 & """ class=pager-next active><<</a> ")
End If
'Work out whether to show the Previous link '<' 
If NOT RSPrevPage = 0 then
response.write("&nbsp;&nbsp;<a href=""browse-eng.asp?upper="&upper&"&amp;lower="&lower&"&amp;PageNo=" & RSPrevPage & """class=pager-next active><</a> ")
End If

'Loop through the page number navigation using P as our loopcounter variable 
For P = start to Next10

If NOT P = CurrPage then
response.write("<a href=""browse-eng.asp?upper="&upper&"&amp;lower="&lower&"&amp;PageNo=" & P & """class=pager-next active>" & P & "</a> ")
Else
'Don't hyperlink the current page number 
response.write("&nbsp;&nbsp; <strong>" & P & " </strong>")
End If
Next
'this does the same as the "previous" link, but for the "next" link
If NOT RSNextPage > Recordset.PageCount Then
response.write("<a href=""browse-eng.asp?upper="&upper&"&amp;lower="&lower&"&amp;PageNo=" & RSNextPage & """class=pager-next active>></a> ")
End If

'Work out whether to show the Next 10 '>>' 
If NOT Next10 = Recordset.PageCount Then
response.write(" <a href=""browse-eng.asp?upper="&upper&"&amp;lower="&lower&"&amp;PageNo=" & Next10 & """class=pager-next active>>></a></div>")
End If
End If

'Close the recordset and connection object
Recordset.Close 
Set Recordset = Nothing
Conn.Close
Set Recordset =Nothing 
%>
</div>
</div>



<%
'sql="Select * FROM  booklist  WHERE category LIKE '8000' AND sb_oh > 3 AND title LIKE '%"& dic_type & "%' and title like '%dic%' order by CONVERT(datetime,recvdate,5) DESC"

'Set RS=Server.CreateObject("ADODB.RecordSet")
'RS.Cursorlocation=3
'RS.open sql, Conn,  3,3,1
'RS.PageSize=10
'PageCount=Request.QueryString("PageCount")
'If PageCount <>"" Then
'	PageNumber=PageCount
'	If PageNumber < 1 Then PageNumber = 1 End If
'Else
'	PageNumber = 1
'End If
'If Not RS.EOF Then RS.AbsolutePage=PageNumber End If
%>
<!--table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b>ข้อมูลหน้าที่</b> <'%=PageNumber%></font></div></td>
  </tr>
</table-->
<!--table width="100%" border="0" cellspacing="2" cellpadding="2">
    
    <tr>  
<'%
RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)

%>
    <td width="162"><div align="center">
                  <'%On Error Resume Next%>
<'%
' Find Book Cover
		' ===================================================================
		bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & RS("barcode") &  ".gif"	
		bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("barcode") &  ".gif"		
		if   ChkFile(bookimgpt) = true then
				bookimg = "http://www.chulabook.com/images/books/" & RS("barcode") &  ".gif"				
		elseif ChkFilebook2(bookimgpt2) = true then
				bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".gif"
		else	
				bookimg = "http://www.chulabook.com/images/books/apology.gif"
		end if
		' =================================================================

%><img src="<'%=bookimg%>"/>
    </div></td>
    <td width="837" valign="top">
    <form id="addtocart" name="addtocart" method="post" action="shopping.asp">

      <div align="left"><a href="description.asp?barcode=<'%=RS("barcode")%>" class="blacktext"><b><'%=RS("Title")%><'%=RS("Title1")%></b></a><br>
              <span class="text">ผู้แต่ง : <'%=RS("Author")%><br>
              Barcode : <'%=RS("Barcode")%><br>
              ราคา : <'%=FormatNumber(RS("price"),0)%> บาท<br>  
              ราคาพิเศษ : 
<'% 
Barcode = RS("Barcode")
Dim SpecialPrice
SpecialPrice = Calculate_Price(Barcode)
response.Write FormatNumber(SpecialPrice,0)
%> 
              บาท </span><br>
  <input name="taken" type="hidden" id="taken" value="1"  />
  <input type="hidden" name="barcode"  value="<'%=barcode%>" />
  <input type="hidden" name="ebook" value="1" />
  <input type="hidden" name="book_id" value="null" />     
  <'% If SpecialPrice<>"" Then %>
  <input type="hidden" name="price" value="<'%= SpecialPrice %>" />
  <'% Else %>
  <input type="hidden" name="price" value="<'%=price%>" />
  <'% End If %>
  <input type="hidden" name="action" value="Add" />
  <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" />  
  <a href="insert_wishlist.asp?barcode=<'%=RS("barcode")%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border=0/></a>      </div>
    </form></td>
  <'%
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
</table-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="center"><strong>LEARNING LAB  Series แต่ละชุด มาพร้อมกับคู่มือการเรียนการสอน</strong></p>
      <p align="center"><a href="http://www.chulabook.com/word/LEARNING_LAB_Series.pdf" target="_blank">ดาวน์โหลดไฟล์ PDF</a></p>
      <p align="center"><img src="http://www.chulabook.com/images/news/20160630learning001.jpg" width="530" /></p>
      <p align="center"><img src="http://www.chulabook.com/images/news/20160630learning002.jpg" width="530" /></p></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="center"><strong>LEARNING LAB ชุดปฏิบัติการพัฒนาต้นแบบสิ่งประดิษฐ์จากพลังงานสะอาด</strong></p>
      <p align="center"><a href="http://www.chulabook.com/word/invention.pdf" target="_blank">ดาวน์โหลดไฟล์ PDF</a></p>
      <p align="center"><img src="http://www.chulabook.com/images/promotion/invention-000.jpg" width="530" /></p>
      <p align="center"><img src="http://www.chulabook.com/images/promotion/invention-001.jpg" width="530" /></p>
      <p align="center"><img src="http://www.chulabook.com/images/promotion/invention-002.jpg" width="530" /></p>
      <p align="center"><img src="http://www.chulabook.com/images/promotion/invention-003.jpg" width="530" /></p>
      <p align="center"><img src="http://www.chulabook.com/images/promotion/invention-004.jpg" width="530" /></p></td>
  </tr>
</table>
<!--p><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div align="left">
      
      <div align="left">
        <'% itsallpage = rspagecount %> 
        <span class="text">จำนวนหน้า <'%=itsallpage%> หน้า</span><br />
        <br />
        <'% for itscount = 1 to itsallpage %>
        <'% 'for itscount = 1 to 13 %>
        <a href="dictionary.asp?pagecount=<'%=itscount%>" class="text"> <'%=itscount%></a>
        <'%next%>
        <br />
        <br />
        </div>
    </div></td>
  </tr>
</table>
</p-->

<%
sql=" SELECT  bl.title,bl.title1,bl.barcode,bb.barcode,bl.price,bl.author FROM  booklist  as bl , Article_book as bb WHERE bb.barcode = bl.barcode and ArticleID = "&Rs_booksetname("ArticleID")&" order by bookid DESC"
%>
<%
Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Cursorlocation=3
RS.open sql, Conn,  3,3,1
RS.PageSize=100
PageCount = Request.QueryString("PageCount")
If PageCount <>"" Then
	PageNumber=PageCount
	If PageNumber < 1 Then PageNumber = 1 End If
Else
	PageNumber = 1
End If
If Not RS.EOF Then RS.AbsolutePage=PageNumber End If
%>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>

<table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
  <td colspan="2"><!--div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b>ข้อมูลหน้าที่</b> < % '=PageNumber%></font></div--><br></td>
    </tr>
    <tr>  
<%
RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)

%>
    <td width="174" align="center" valign="top">
<div align="center">
  <%
    bookimgpt = "C:\Chulabook\images\book-400\" & RS("barcode") &  ".jpg" 
    'bookimgpt2 = "C:\Chulabook\images\book2\" & RS("barcode") &  ".jpg"    
    if   ChkFile(bookimgpt) = true then
        bookimg = "images/book-400/" & RS("barcode") &  ".jpg"        
    'elseif ChkFilebook2(bookimgpt2) = true then
        'bookimg = "http://203.154.162.41/images/book2/" & RS("barcode") &  ".jpg"
    else  
        bookimg = "images/book-400/apology.jpg"
    end if
                  
   %>  
                  
    <img src="<%=bookimg%>" height="100px" />
                           
    </div></td>
    <td width="809" valign="top">
      <form id="addtocart" name="addtocart" method="post" action="shopping.asp">
      <div align="left">
<a href="description.asp?barcode=<%=RS("barcode")%>" class="blacktext" target="_blank"><b><%=RS("Title")%><%=RS("Title1")%></b></a><br>
<span class="text" >
ผู้แต่ง : <%=RS("Author")%><br>
Barcode : <%=RS("Barcode")%><br>
ราคา : <%=FormatNumber(RS("price"),0)%> บาท<br>  
<span class="style1">ราคาพิเศษ : 
<% 
Barcode = RS("Barcode")
Dim SpecialPrice
SpecialPrice = Calculate_Price(Barcode)
response.Write FormatNumber(SpecialPrice,0)
%> 
บาท</span></span>
<br>
      <input name="taken" type="hidden" id="taken" value="1"  />
      <input type="hidden" name="barcode"  value="<%=barcode%>" />
      <% If SpecialPrice<>"" Then %>
      <input type="hidden" name="price" value="<%= SpecialPrice %>" />
      <% Else %>
      <input type="hidden" name="price" value="<%=price%>" />
      <% End If %>
      <!--input type="hidden" name="action" value="Add" />
      <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" />  
      <a href="insert_wishlist.asp?barcode=<!%=RS("barcode")%>" title="เก็บไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border=0/></a-->      </div>
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
<br />
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><div align="left">
      
      <!--div align="left">
        <% 'itsallpage = rspagecount %> 
        &nbsp;&nbsp;&nbsp;&nbsp;<span class="text">จำนวนหน้า <%'=itsallpage%> หน้า</span><br />
        <br />
        <!--<A href="promotion.asp"><< ¡èÍ¹Ë¹éÒ</A> -->
        &nbsp;&nbsp;&nbsp;&nbsp;<%'for itscount = 1 to itsallpage %>
        <%'for itscount = 1 to 13 %>
        <!--a href="article-detail.asp?articleid=<%'=oRs_book("ArticleID")%>&pagecount=<%'=itscount%>"> <%'=itscount%></a>
        <%'next%>
        <!--<A href="#">¶Ñ´ä» >></A>  -->
        <br />
        <br />
        </div-->
    </div></td>
  </tr>
</table>

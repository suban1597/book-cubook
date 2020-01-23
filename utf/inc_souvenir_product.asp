<%
'Select book
  typeid = abs(request("typeid"))
  if typeid ="" Then
    response.Write "ข้อมูลไม่ถูกต้องค่ะ"
  Else

  if len(typeid)<=5 then
    Sql = "SELECT  * FROM  booklist  as bl , souvenir_product as bb WHERE   bb.barcode = bl.barcode  and souvenir_type = "&typeid&" and (stock_oh+sb_oh+cb_oh) >= 1  "
    Set RS = Server.CreateObject("ADODB.RecordSet")
    RS.Open Sql,conn,1,3

    if RS.EOF Then
      response.Redirect("home.asp")
    end if

  else 
    Response.redirect "home.asp"
  end if

Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Cursorlocation=3
RS.open sql, Conn,  3,3,1
RS.PageSize=10
PageCount=Request.QueryString("PageCount")
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
    <td><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b>สินค้าประเภท</b> เครื่องเบญจรงค์ <b>ข้อมูลหน้าที่</b> <%=PageNumber%></font></div></td>
  </tr>
</table>
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="2">
  
  <tr>  
<%
RSPageCount=RS.PageCount
Do While Not (RS Is Nothing) 
CountDown=RS.PageSize
i = 1
Do While (Not RS.EOF) and (CountDown>0)

%>
    <td width="162"><div align="center">
                  <%On Error Resume Next%>
                  <%ReadBinFile( RS("barcode") & ".gif")%>
        <%
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
				  %>
        <img src="<%=bookimg%>" height="100px" /></div></td>
    <td width="837" valign="top">
   <form id="addtocart" name="addtocart" method="post" action="shopping.asp">
     <div align="left">
  <a href="description.asp?barcode=<%=RS("barcode")%>" class="text"><%=RS("Title")%><%=RS("Title1")%></a><br>
<font class="text">Barcode : <%=RS("Barcode")%><br>
ราคา : <%=FormatNumber(RS("price"),0)%> บาท</font><br>
  <% 
Barcode = RS("Barcode")
Dim SpecialPrice
SpecialPrice = Calculate_Price(Barcode)
'response.Write FormatNumber(SpecialPrice,0)
%>
       
  <input name="taken" type="hidden" id="taken" value="1"  />
  <input type="hidden" name="barcode"  value="<%=barcode%>" />
  <input type="hidden" name="ebook" value="1" />
  <input type="hidden" name="book_id" value="null" />  
  <% If SpecialPrice<>"" Then %>
  <input type="hidden" name="price" value="<%= SpecialPrice %>" />
  <% Else %>
  <input type="hidden" name="price" value="<%=price%>" />
  <% End If %>
  <input type="hidden" name="action" value="Add" />
  <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="ԺС" border="0" name="image" />  
  <a href="insert_wishlist.asp?barcode=<%=RS("barcode")%>" title="ô"><img src="images/icons/star.png"  border=0/></a>     </div>
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
        <td><div align="left"><span class="text">
            <% itsallpage = rspagecount %>
          พบข้อมูลจำนวน <%=itsallpage%> หน้า</span><br />
          <!--  <a href="browse.asp">&lt;&lt; ͹˹</a>-->
          <%for itscount = 1 to itsallpage %>
          <%'for itscount = 1 to 13 %>
            <a href="souvenir_product.asp?pagecount=<%=itscount%>&amp;typeid=<%=typeid%>" class="text"> <%=itscount%></a>
          <%next%>
        <!--<a href="#">Ѵ &gt;&gt;</a> --></div></td>
      </tr>
    </table>
    <%RS.close%>
<map name="Map" id="Map"><area shape="rect" coords="180,457,329,492" href="../images/front-cicc.jpg" target="_blank" />
<area shape="rect" coords="347,457,505,492" href="../images/back-cicc.jpg" target="_blank" />
</map>
<%end if%>
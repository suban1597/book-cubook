
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td><div align="left">&nbsp;&nbsp;&nbsp;<font class="blacktext"><b>สถาบันส่งเสริมการสอนวิทยาศาสตร์และเทคโนโลยี (สสวท.)</font></div> <div align="center"><img src="word/ipst/minibanner_ipstbook2.jpg" width="530"><br/><a href="word/ipst/ipstbook.pdf" target="_bank" border="0"><img src="word/ipst/002-18052018.png" width="265"></a><a href="http://ipst.me/csdt" target="_bank" border="0"><img src="word/ipst/003-18052018.png" width="265"></a></div></td>
  </tr>
</table>

    <%
    sql="SELECT  barcode, Title, Title1, Author, price, stock_oh, cb_oh, sb_oh, sb14_oh, language, disctype, distribute, disctype1 FROM booklist WHERE (disctype = 'c') AND (distribute = '2') AND (disctype1 = '5') AND (language = '1') "
    Set RS=Server.CreateObject("ADODB.RecordSet")
    RS.Open  sql, Conn, 1, 3
    %>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
<tr>  
    <%
    i = 1
    Do While Not RS.EOF 

    %>
  <td width="124" valign="top"><div align="center">
    <%On Error Resume Next%>
    <%

    'bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & RS("barcode") &  ".gif"	
    'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("barcode") &  ".gif"		
  	''	if   ChkFile(bookimgpt) = true then
  	''			bookimg = "http://www.chulabook.com/images/books/" & RS("barcode") &  ".gif"				
  	''	elseif ChkFilebook2(bookimgpt2) = true then
  	''			bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".gif"
  	''	else	
  	''			bookimg = "http://www.chulabook.com/images/books/apology.gif"
  	''	end if

    ' Find Book Cover
    ' ===================================================================
    bookimgpt_chk = "C:\Chulabook\images\book-400\"&RS("barcode")&".jpg" 
    'bookimgpt2_chk = "D:\Chulabook\cgi-bin\main\2010\images\books\" & Barcode &  ".gif"  
    'bookimgpt3_chk = "D:\Chulabook\cgi-bin\main\2010\images\book-400-2\" & Barcode &  ".gif"   
    if   ChkFile(bookimgpt_chk) = true then
        bookimg = "images/book-400/"&RS("barcode")&".jpg"       
    'elseif ChkFilebook2(bookimgpt2_chk) = true then
        'bookimg = "http://www.chulabook.com/images/books/" & Barcode &  ".gif"
    'elseif ChkFilebook3(bookimgpt3_chk) = true then
        'bookimg = "http://www.chulabook.com/images/book-400-2/" & Barcode &  ".gif"
    else  
        bookimg = "images/book-400/apology.jpg"
    end if
    ' =================================================================
                    
  %>           
    <img src="<%=bookimg%>" width="100px"/>        
    </div></td>
    <td width="809" valign="top">

      <% If RS("stock_oh") >= 4 OR RS("sb_oh") >= 4 Then %>
        <form id="addtocart" name="addtocart" method="post" action="shopping.asp">
          <div align="left">
            <a href="description.asp?barcode=<%=RS("barcode")%>" class="blacktext"><b><%=RS("Title")%><%=RS("Title1")%></b></a><br>
            <span class="text">
              ผู้แต่ง : <%=RS("Author")%><br>
              Barcode : <%=RS("Barcode")%><br>
              ราคา : <%=FormatNumber(RS("price"),0)%> บาท<br>  
              ราคาพิเศษ : 
              <% 
              Barcode = RS("Barcode")
              'Dim SpecialPrice
              SpecialPrice = Calculate_Price(Barcode)
              response.Write FormatNumber(SpecialPrice,0)
              %>บาท</span>
                  <input name="taken" type="hidden" id="taken" value="1"  />
                    <input type="hidden" name="barcode"  value="<%=Barcode%>" />
                    <input type="hidden" name="ebook" value="1" />
                    <input type="hidden" name="book_id" value="null" />
                    <% If SpecialPrice<>"" Then %>
                    <input type="hidden" name="price" value="<%= SpecialPrice %>" />
                    <% Else %>
                    <input type="hidden" name="price" value="<%=price%>" />
                    <% End If %>
                    <input type="hidden" name="action" value="Add" /><br>

                    <% IF RS("stock_oh") >= 4 OR RS("sb_oh") >= 4 Then %>
                      <input type="image" src="images/icons/cart.png" alt="Add to cart"  title="ซื้อ <%=RS("title")+RS("title1")%>" border="0" name="image" />  
                      <a href="insert_wishlist.asp?barcode=<%=RS("Barcode")%>" title="เก็บ  <%=RS("title")+RS("title1")%> ไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border="0"/></a>
                      <a href="word/ipst/<%=RS("Barcode")%>.pdf" target="_bank" border="0"><img src="word/ipst/ipst_button.png"></a>
                      </div>
                      </form>
                    <% Else %>
                      </div>
                      </form>
                      <input type="image" src="images/icons/non-cart.png" border="0" />
                      <a href="insert_wishlist.asp?barcode=<%=RS("Barcode")%>" title="เก็บ  <%=RS("title")+RS("title1")%> ไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border="0"/></a>
                      <a href="word/ipst/<%=RS("Barcode")%>.pdf" target="_bank" border="0"><img src="word/ipst/ipst_button.png"></a>
                    <% End If%>  

                    

      <% Else %>
        <div align="left">
          <a href="description.asp?barcode=<%=RS("barcode")%>" class="blacktext"><b><%=RS("Title")%><%=RS("Title1")%></b></a><br>
          <span class="text">
            ผู้แต่ง : <%=RS("Author")%><br>
            Barcode : <%=RS("Barcode")%><br>
            ราคา : <%=FormatNumber(RS("price"),0)%> บาท<br>  
            ราคาพิเศษ : 
            <% 
            Barcode = RS("Barcode")
            'Dim SpecialPrice
            SpecialPrice = Calculate_Price(Barcode)
            response.Write FormatNumber(SpecialPrice,0)
            %>บาท</span><br>
                  <a href="https://docs.google.com/forms/d/e/1FAIpQLScR3j5oYTIPg6Z64zfZfSmZhd4w_RyRjpmyjdZ_TDnR2zxmFQ/viewform"><img src="http://www.chulabook.com/word/ipst/ipst_button_pre-order.png"></a>
                  <!--input type="image" src="images/icons/non-cart.png" border="0" /-->
                  <a href="insert_wishlist.asp?barcode=<%=RS("Barcode")%>" title="เก็บ  <%=RS("title")+RS("title1")%> ไว้เป็นเล่มโปรด"><img src="images/icons/star.png"  border="0"/></a>      
                  <a href="word/ipst/<%=RS("Barcode")%>.pdf" target="_bank" border="0"><img src="word/ipst/ipst_button.png"></a>
        </div>
      <% End If%>

    </td>


  <%
	i= i+1
		if i > 2 Then 
		response.Write "</tr>"
		i = 1
		end if
		RS.MoveNext
		Loop
  %>
  <br>
  </tr>
</table>
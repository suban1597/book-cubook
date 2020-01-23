<script type="text/javascript"> 
 $(document).ready(function() {
 
 
     $("#authorlink").click(function() {
	 var myval = "speedsearch.asp?keyword="+$("#authorlink").attr("value")+"&Option1=Author";
	// alert(escape(myval));
 window.location = encodeURI(myval);
   });
  
 });
 </script>
 <script language="javascript" type="text/javascript">
<!--
function popitup(url) {
	newwindow=window.open(url,'name','scrollbars=1,height=550,width=650');
	if (window.focus) {newwindow.focus()}
	return false;
}

// -->
</script>
 
 <%
' If having a Book 
'===========================
If Not RsBook.Eof Then


Set RS_Ebookdis=Server.CreateObject("ADODB.RecordSet")
RS_Ebookdis.Open  "SELECT book_id,isbn,book_name,category,book_file_size,description,book_cover_price,book_bath_price FROM Ebooklist WHERE  isbn ='" &Barcode&"' ", Conn, 1, 3

If NOT RS_Ebookdis.EOF Then
	book_id = RS_Ebookdis("book_id")
	isbn = RS_Ebookdis("isbn")
	book_name = RS_Ebookdis("book_name")
	'book_author = RS_Ebookdis("author")
	category_ebook = RS_Ebookdis("category")
	book_file_size = RS_Ebookdis("book_file_size")
	description_ebook = RS_Ebookdis("description")
	book_cover_price = RS_Ebookdis("book_cover_price")
	bart_price = RS_Ebookdis("book_bath_price")
	
	
	
	
End If

'Check Onhand
	If RsBook("Language") = 1 Then
		'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
		stock_oh = RsBook("stock_oh")
		total_oh = RsBook("stock_oh")+RsBook("sb14_oh")+RsBook("cb_oh")+RsBook("jj_oh")
		if stock_oh < 20 Then
		
				If total_oh >= 2 Then 
					cart_img = "../images/button/cart_new.png"			
				Else 
					cart_img = "สินค้าหมด"
				End If
			
		Else If stock_oh >=20 then
			cart_img = "../images/button/bt_add2cart.png"
		Else
			cart_img = "สินค้าหมด"
		End If
		End If
		
	Else if RsBook("Language") = 2 Then	
			'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
			total_oh = RsBook("stock_oh")+RsBook("sb14_oh")+RsBook("cb_oh")+RsBook("jj_oh")
			If total_oh >= 1 Then 
		cart_img = "../images/button/bt_add2cart.png"
		Else 
		cart_img = "สินค้าหมด"
		End If
	Else if RsBook("Language") = 3 Then	
			'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
			total_oh = RsBook("stock_oh")+RsBook("sb14_oh")+RsBook("cb_oh")+RsBook("jj_oh")
		If total_oh >= 5 and RsBook("barcode") <> "8850000248269" and RsBook("barcode") <> "8850000107863" and RsBook("barcode") <> "8850000249815" and RsBook("barcode") <> "8850000135873" and RsBook("barcode") <> "8850000085482" and RsBook("barcode") <> "8850000233524" and RsBook("barcode") <> "8850000209758" and RsBook("barcode") <> "8850000179471" and RsBook("barcode") <> "8850000207822" and RsBook("barcode") <> "8850000128141" and RsBook("barcode") <> "8850000248221" and RsBook("barcode") <> "8850000107856" and RsBook("barcode") <> "8850000203510" and RsBook("barcode") <> "8850000244155" and RsBook("barcode") <> "8850000268946" and RsBook("barcode") <> "8850000046933" and RsBook("barcode") <> "8850000223822" and RsBook("barcode") <> "8850000236891" and RsBook("barcode") <> "8850000108488" and RsBook("barcode") <> "8850000035531" and RsBook("barcode") <> "8850000035524" and RsBook("barcode") <> "8850000024931" and RsBook("barcode") <> "8850000024924" Then
			cart_img = "../images/button/bt_add2cart.png"
		Else if RsBook("barcode") <> "8850000248269" and RsBook("barcode") <> "8850000107863" and RsBook("barcode") <> "8850000249815" and RsBook("barcode") <> "8850000135873" and RsBook("barcode") <> "8850000085482" and RsBook("barcode") <> "8850000233524" and RsBook("barcode") <> "8850000209758" and RsBook("barcode") <> "8850000179471" and RsBook("barcode") <> "8850000207822" and RsBook("barcode") <> "8850000128141" and RsBook("barcode") <> "8850000248221" and RsBook("barcode") <> "8850000107856" and RsBook("barcode") <> "8850000203510" and RsBook("barcode") <> "8850000244155" and RsBook("barcode") <> "8850000268946" and RsBook("barcode") <> "8850000046933" and RsBook("barcode") <> "8850000223822" and RsBook("barcode") <> "8850000236891" and RsBook("barcode") <> "8850000108488" and RsBook("barcode") <> "8850000035531" and RsBook("barcode") <> "8850000035524" and RsBook("barcode") <> "8850000024931" and RsBook("barcode") <> "8850000024924" Then
			cart_img = "สินค้าหมด"
			
		Else
			cart_img = "สินค้าหมด"
		End If
		End If
	End iF
	End If
	End If
	
	CoverType = BookCover(RsBook("Cover"))
	Title = RsBook("title")
	Title1 = RsBook("title1")
	Author = Trim(RsBook("author"))
	Isbn = RsBook("isbn")
	Barcode = RsBook("barcode")
	Edition = Cint(RsBook("edition"))
	EditYear = RsBook("year")
	Page = Cint(RsBook("page"))
	Width = Cint(RsBook("width"))
	Length = Cint(RsBook("length"))
	Price = Formatnumber(RsBook("price"),2)
	Dis = Cint(RsBook("Distribute"))
	Category = RsBook("Category")
	Language= RsBook("Language")
	Stflg = RsBook("stflg")
	translator = RsBook("translator")
  disctype1 = RsBook("disctype1")


	
Set RSC=Server.CreateObject("ADODB.RecordSet")
RSC.Open  "SELECT sub_category.* FROM sub_category  WHERE category ='" &Category&"' ", Conn, 1, 3
'================================
	ReadCheck( RSBook("barcode") & ".txt")
	if Err Then
			If Language = 1 Then
			Content = "- - - - - ไม่มีรายละเอียดสินค้า - - - - - "
			Elseif Language = 2 Then
			Content = "- - - - - No Description - - - - - "
			Else
			Content = "- - - - - ไม่มีรายละเอียดสินค้า - - - - - "
			End If
	else
		   Content = ReadTextFile( RSBook("barcode") & ".txt")
	end if			
'================================

Else
' Not Found Book
'===========================
End if
RsBook.Close

    ' Find Book Cover
    ' ===================================================================
    bookimgpt_chk = "C:\Chulabook\images\book-400\" & Barcode &  ".jpg" 
    'bookimgpt2_chk = "D:\Chulabook\cgi-bin\main\2010\images\books\" & Barcode &  ".gif"  
    'bookimgpt3_chk = "D:\Chulabook\cgi-bin\main\2010\images\book-400-2\" & Barcode &  ".gif"   
    if   ChkFile(bookimgpt_chk) = true then
        bookimg = "images/book-400/" & Barcode &  ".jpg"       
    'elseif ChkFilebook2(bookimgpt2_chk) = true then
        'bookimg = "http://www.chulabook.com/images/books/" & Barcode &  ".gif"
    'elseif ChkFilebook3(bookimgpt3_chk) = true then
        'bookimg = "http://www.chulabook.com/images/book-400-2/" & Barcode &  ".gif"
    else  
        bookimg = "images/book-400/apology.jpg"
    end if
    ' =================================================================

%>
<table width="100%" border="0" cellpadding="5" cellspacing="5">
  <tr>
    <td width="26%" rowspan="2" valign="top" ><table border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top">
          <%
        		 'Dim CoverFile
        		 'CoverFile = Barcode & ".jpg" 			
                 'Call GetCoverImage(CoverFile)


      		 %>
           <img src="<% response.write bookimg %>" width="200px">
     </td>
      </tr>
	  
	
    </table>
  
  
       <br /> <br />
<fb:like href="http://www.chulabook.com/description.asp?barcode=<%=barcode%>" send="false" layout="button_count" width="200" show_faces="true"></fb:like>
    <br /> <br />  </td>
    <td width="74%" valign="top" >      <table width="95%" border="0" cellspacing="2" cellpadding="2">
      <tr>
        <td><div align="left"><span class="big-text">
          <%BookTitle = Title & Title1%>
          <% Response.Write BookTitle %>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ผู้แต่ง : <%Response.Write Author%>
        </span></div></td>
      </tr>
       <tr>
        <td><div align="left"><span class="blacktext">ผู้แปล :
          <% 
		  	'if RsBook("translator").eof then 
			'if RsBook("translator") = "" then 
		  	'	Response.Write "-"
		  	'else
				Response.Write translator
			'end if
		  %>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">Barcode :
              <%Response.Write Barcode%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ISBN :
              <%Response.Write ISBN%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ปีพิมพ์ :
              <%Response.Write Edition%>
/
<%Response.Write Edityear%>
        </span></div></td>
      </tr>
            <tr>
        <td><div align="left"><span class="blacktext">ขนาด (w x h) :
              <%Response.write Width %>
x
<%Response.Write Length%>
mm. </span></div></td>
      </tr>
            <tr>
        <td><div align="left"><span class="blacktext">ปก / จำนวนหน้า :
              <%Response.Write Covertype%>
/
<%Response.write Page %>
หน้า </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">หมวดหนังสือ :
              <%If Stflg <> 1 Then%>
              <a href="browse.asp?upper=<%=Category%>&amp;lower=<%=Category%>" class="text"><%=RSC("subname")%></a>
              <%else
	response.Write "-"
	end if
	%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ราคาปก :
              <s><%Response.Write Price%>
          บาท</s></span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">
          <%
Dim DiscountPercent
DiscountPercent= Cal_DiscountPercent(Barcode)
If DiscountPercent <> "" Then
'response.Write  "(Ŵ&nbsp;" & DiscountPercent & "%)"
Elseif DiscountPercent = "" Then
'response.Write "(Ŵ)"
End If
%>
          <% 
			Dim SpecialPrice
           SpecialPrice = Calculate_Price(Barcode)
		   'response.Write "ราคาพิเศษ :&nbsp;" & SpecialPrice & "&nbsp;บาท "
		   response.Write "ราคาพิเศษ :&nbsp;" & SpecialPrice & "&nbsp;บาท &nbsp;<font color=red>(เฉพาะสั่งซื้อออนไลน์)</font>"
		   'eDate = (date())
		   'eDate = CONVERT(varchar(10), date(), 112)
		  	'response.Write eDate
			'if eDate>"30/9/2559" then
				'response.Write "ok"
			'else
				'response.Write "no"
			'end if
%>
  &nbsp; <%=extranote%> </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">
          <%If Stflg <> 1 Then%>
          ประหยัด :
  <%Call Cal_DiscountRate(Barcode)%>
  <%end if%>
        </span></div></td>
      </tr>

      <!--tr>
        <td><div align="left"><span class="blacktext">bookid :
          < %Response.Write book_id%>
        </span></div></td>
      </tr-->


      <tr>
        <td>
          <div align="left">
            <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0" >
                <tr>
                  <td><div align="left">
                      
      
                 
                      <!--  Action  [[ ADD]]  -->
                  
                    
                      <!-- All Input  -->
                      <!-- <input type=hidden name="taken" value="1">-->
                      <!-- All Input  -->
                      <!-- =========================================== ش Form ======================================== -->
                  </div></td>
                </tr>
                
<%
Set RS_bookdis=Server.CreateObject("ADODB.RecordSet")
RS_bookdis.Open  "SELECT barcode FROM Distribute_booklist  WHERE barcode ='" &barcode&"' ", Conn, 1, 3
'================================
if Not RS_bookdis.EOF Then

'if Not RS_Ebookdis.EOF Then
'response.Write RS_Ebookdis("isbn")
%>    
<tr>
<td valign="top"><a href="branchdistribute.asp?barcode=<%=barcode%>" onclick="return popitup('branchdistribute.asp?barcode=<%=barcode%>')"><img src="../images/button/bt_branchdistribute_new.png" width="128" height="27" border="0" /></a></td>
</tr>
<%End If%>
                
                <tr>
                  <td valign="top"><!--<a href="insert_wishlist.asp?barcode=<%=barcode%>"><img src="images/button/fav_book.png" border="0" /></a>-->
                      <div align="left">
					 <%If cart_img <> "สินค้าหมด" Then%>
                     <form id="addtocart" name="addtocart" method="post" onsubmit="return(foul.validate(this))" action="shopping.asp">
                     <input type="hidden" name="barcode"  value="<%=barcode%>" />
					           <input type="hidden" name="book_id" value="null" />
                     <input type="hidden" name="ebook" value="1" />                     
                     <input type="hidden" name="taken" id="taken"  value="1" />
                      <% If barcode = "9786164554429" Then 
                           Response.Write "<a href='http://www.chulabook.com/promotion-detail.asp?promotionid=2381'><img src=../images/button/promotion_button-2.png width=128 height=27 border=0 /></a></br>"
                        else
                      %>
					             <input type="image" src="../images/button/cart_new.png"  border="0" name="ebook" /></br>
                      <% End If %>
	                     <% If SpecialPrice<>"" Then %>
	                       <input type="hidden" name="Price" value="<%= SpecialPrice %>" />
	                     <% Else %>
	                       <input type="hidden" name="Price" value="<%=price%>" />
	                     <% End If %>
	                       <input type="hidden" name="action" value="Add" />
                     </form>
                
                    <%
					Else
            if disctype1 = "5" then
                  'response.Write "<img src=../images/button/ipst_button.png width=128 height=60 border=0 />"
                  response.Write "<a href='https://docs.google.com/forms/d/e/1FAIpQLScR3j5oYTIPg6Z64zfZfSmZhd4w_RyRjpmyjdZ_TDnR2zxmFQ/viewform'><img src=../images/button/ipst_button-2.png border=0 /></a>"
            'else if barcode = "9786164454507" Then
              'Response.Write "<a href='http://www.chulabook.com/king/login.php'><img src=../images/button/cart_order.png width=128 height=27 border=0 /></a>"
            else if barcode = "9786164454491" Then
              	Response.Write "<a href='http://www.chulabook.com/king/login.php'><img src=../images/button/cart_order.png width=128 height=27 border=0 /></a>"
            else if barcode = "8850000248269" or barcode = "8850000107863" or barcode = "8850000249815" or barcode = "8850000135873" or barcode = "8850000085482" or barcode = "8850000233524" or barcode = "8850000209758" or barcode = "8850000179471" or barcode = "8850000207822" or barcode = "8850000128141" or barcode = "8850000248221" or barcode = "8850000107856" or barcode = "8850000203510" or barcode = "8850000244155" or barcode = "8850000268946" or barcode = "8850000046933" or barcode = "8850000223822" or barcode = "8850000236891" or barcode = "8850000108488" or barcode = "8850000035531" or barcode = "8850000035524" or barcode = "8850000024931" or barcode = "8850000024924" Then
    			response.Write "<br><font color='red'> *สินค้านี้ ขายเฉพาะหน้าร้านสาขาสาขาสยามสแควร์เท่านั้น <br><br> สาขาสยามสแควร์ : 0-2218-9881-2 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0-2218-9875-6 <br>Call Center : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0-2255-4433</font>"
    		    else
    			     response.Write "<img src=../images/button/outofstock.png width=128 height=27 border=0 />"
          'response.write "<br><div class='text'><font color=red>*ขออภัยสินค้าหมด</font></div>"
            'end if
            end if
            end if
            end if
    					'response.Write bart_price
					End If
					%> <br>
                    
                    </div></td>
                </tr> 
                <% If barcode = "9789740321118" Then %>
                 <tr>
                	<td height="60">
                    <a href="http://staff.cs.psu.ac.th/iew" target="_blank"><img src="../images/dowload_cd.png" width="128" height="49" border="0" /></a>
                    </td>
                  </tr> 
                <% Else If barcode = "9786163612519" Then%>
                 <tr>
                	<td height="60">
                    <div align="left"><span class="blacktext">Dowload PDF: <br> <a href="http://www.chulabook.com/word/CorrectionsAHPIIPROTECTED.pdf" target="_blank"> อัพเดทหน้งสือ AHP การตัดสินใจขั้นสูง</a></span></div>
                    </td>
                  </tr> 
                <% 
                 End If 
                 End If 
                %>
                
              </table>
          </div>
        </td>
      </tr>
      
    </table>
      <br /></td>
  </tr>
</table>
<%
'================Query  Distributtion Books=======================
	sql="SELECT isbn FROM  Ebooklist   WHERE isbn = '"&barcode&"'" 
	Set RS=Server.CreateObject("ADODB.RecordSet")
	RS.Open sql,conn,1,3	
	If RS.eof Then	
	else
%>
<table width="94%" border="0" cellpadding="1" cellspacing="1" bgcolor="#EEEEEE" align="center">
  <tr>
    <td width="12%" rowspan="2" valign="top" ><%
	
		'sql2="SELECT * FROM  Ebooklist,booklist   WHERE barcode = '"&barcode&"'" 
    sql2="SELECT booklist.barcode, booklist.title, booklist.title1 FROM Ebooklist INNER JOIN booklist ON Ebooklist.isbn = booklist.barcode WHERE barcode = '"&barcode&"'" 
		Set RS2=Server.CreateObject("ADODB.RecordSet")
		RS2.Open sql2,conn,1,3	
	
	
		' Find Book Cover
		' ===================================================================
		bookimgpt = "D:\Chulabook\images\book-400\" & RS2("barcode") &  ".jpg"	
		'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS2("barcode") &  ".jpg"		
		if   ChkFile(bookimgpt) = true then
				bookimg = "http://www.chulabook.com/images/book-400/" & RS2("barcode") &  ".jpg"				
		'elseif ChkFilebook2(bookimgpt2) = true then
		''		bookimg = "http://www.chulabook.com/images/book2/" & RS2("barcode") &  ".jpg"
		else	
				bookimg = "http://www.chulabook.com/images/book-400/apology.jpg"
		end if
		' =================================================================


	
		' Write Data
	   ' =================================================================
%><div align="center"><img src="<%=bookimg%>" height="100px"/></div>
    </td><td width="88%" valign="top" ><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td><div align="left"><span>
          <a href="description_ebook.asp?barcode=<%=RS2("barcode")%>" class="blacktext"><b><%=RS2("Title")%><%=RS2("Title1")%></b></a><br>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ผู้แต่ง :
          <%Response.Write book_author%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ผู้แปล :
          <% 
		  	if translator = "" then 
		  		Response.Write "-"
		  	else
				Response.Write translator
			end if
		  %>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">

          <span class="redtext">
            <% response.Write "ราคา E-Book :&nbsp;" & bart_price & "&nbsp;บาท"%>
          </span> &nbsp; <%=extranote%> </span></div></td>
      </tr>
      <!--tr>
        <td><div align="left"><span class="blacktext">bookid :
          <%Response.Write book_id%>
        </span></div></td>
      </tr-->
      <tr>
        <td><div align="left">
          <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0" >
            <tr>
              <td><div align="left">
                <!--  Action  [[ ADD]]  -->
                <!-- All Input  -->
                <!-- <input type=hidden name="taken" value="1">-->
                <!-- All Input  -->
                <!-- =========================================== ش Form ======================================== -->
              </div></td>
            </tr>
            <%
Set RS_bookdis=Server.CreateObject("ADODB.RecordSet")
RS_bookdis.Open  "SELECT barcode FROM Distribute_booklist  WHERE barcode ='" &barcode&"' ", Conn, 1, 3
'================================
if Not RS_bookdis.EOF Then

'================================
'if Not RS_Ebookdis.EOF Then
'response.Write RS_Ebookdis("isbn")
%>
            <!--tr>
<td valign="top"><a href="branchdistribute.asp?barcode=<%=barcode%>" onclick="return popitup('branchdistribute.asp?barcode=<%=barcode%>')"><img src="../images/button/bt_branchdistribute_new.png" width="128" height="27" border="0" /></a></td>
</tr-->
            <%End If%>
            <tr>
              <td valign="top"><!--<a href="insert_wishlist.asp?barcode=<%=barcode%>"><img src="images/button/fav_book.png" border="0" /></a>-->
                      <div align="left">
                        <% If not RS_Ebookdis.EOF Then %>
                        <% If bart_price <> "0" Then %>
                        <form id="addtocart" name="addtocart" method="post" onsubmit="return(foul.validate(this))" action="shopping.asp">
                          <input type="hidden" name="barcode"  value="<%=barcode%>e" />
                          <input type="hidden" name="book_id" value="<%=book_id%>" />
                          <input type="hidden" name="ebook" value="1" />
                          <input type="hidden" name="action" value="Add" />
                          <input name="taken" type="hidden" id="taken"  value="1" />
                          <input type="image" src="../images/button/cart_ebook.png" alt="Ebook to cart"  border="0" name="ebook" />
                          </br>
                          <% If bart_price<>"" Then %>
                          <!--input type="hidden" name="price" value="< %'= SpecialPrice %>" /-->
                          <input type="hidden" name="Price" value="<%=bart_price%>" />
                          <% Else %>
                          <input type="hidden" name="Price" value="<%=bart_price%>" />
                          <% End If %>
                          <% End If %>
                        </form>
                        <%
					'response.Write bart_price
					End If
					%>
                    </div></td>
            </tr>
          </table>
        </div></td>
      </tr>
    </table>
      <br /></td>
  </tr>
</table>
<%end if%>

<p>&nbsp;</p>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td><div align="left"><span class="big-text">
      <%Response.Write TopicType(Language)%>
      </span> <br />
      <span class="text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
			  'Content = Replace(Content,chr(13),"<br>")
			  'Content = Replace(Content,chr(10),"<br>")
			  response.Write Content %>
    </span></div></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td><!--#include file="inc_bookrelate.asp"--></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td valign="top"><!--#include file="inc_reviewbook_content.asp"--></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td><!--#include file="inc_reviewbook.asp"--></td>
  </tr>
</table>
<br />
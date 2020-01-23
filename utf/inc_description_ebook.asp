<script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
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

'sql_Ebookdis = "SELECT * FROM Ebooklist WHERE  isbn ='" &Barcode&"' "
sql_Ebookdis = "SELECT book_id, isbn, book_name, book_author, category, book_file_size, description, book_cover_price, book_bath_price, book_thumbnail_path FROM Ebooklist WHERE (isbn ='"&Barcode&"')"

Set RS_Ebookdis=Server.CreateObject("ADODB.RecordSet")
RS_Ebookdis.Open sql_Ebookdis, Conn, 1, 3

If NOT RS_Ebookdis.EOF Then
	book_id = RS_Ebookdis("book_id")
	isbn = RS_Ebookdis("isbn")
	book_name = RS_Ebookdis("book_name")
	book_author = RS_Ebookdis("book_author")
	category_ebook = RS_Ebookdis("category")
	book_file_size = RS_Ebookdis("book_file_size")
	description_ebook = RS_Ebookdis("description")
	book_cover_price = RS_Ebookdis("book_cover_price")
	bart_price = RS_Ebookdis("book_bath_price")
	book_thumbnail_path = RS_Ebookdis("book_thumbnail_path")
	
End If

'''Check Onhand
''	If RsBook("Language") = 1 Then
''		'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
''		total_oh = RsBook("sb_oh")+RsBook("sb14_oh")
''		If total_oh > 3 Then 
''		cart_img = "../images/button/cart_new.png"
''		Else 
''		cart_img = "สินค้าหมด"
''		End If
''	Else if RsBook("Language") = 2 Then	
''			'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
''			total_oh = RsBook("sb_oh")+RsBook("sb14_oh")
''			If total_oh > 3 Then 
''		cart_img = "../images/button/bt_add2cart.png"
''		Else 
''		cart_img = "สินค้าหมด"
''		End If
''	Else if RsBook("Language") = 3 Then	
''			'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
''			total_oh = RsBook("sb_oh")+RsBook("sb14_oh")
''	If total_oh > 1 Then 
''		cart_img = "../images/button/bt_add2cart.png"
''		Else 
''		cart_img = "สินค้าหมด"
''		End If
''	End iF
''	End If
''	End If
	
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
	'Dis = Cint(RsBook("Distribute"))
	Category = RsBook("Category")
	Language= RsBook("Language")
	Stflg = RsBook("stflg")
	translator = RsBook("translator")


	
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

%>
<table width="100%" border="0" cellpadding="5" cellspacing="5">
  <tr>
    <td width="26%" rowspan="2" valign="top" > 
    	<div align="right"><% bookimg = book_thumbnail_path & "middle.gif"%><img src="<%=bookimg%>" /></div><br /><br />
	  	<div align="center">
        	<a name="fb_share" type="button_count" href="http://www.facebook.com/sharer.php">แบ่งปันสู่ Facebook</a>			
        </div><br /><br />  
    </td>
    <td width="74%" valign="top" >
    <table width="95%" border="0" cellspacing="2" cellpadding="2">
      <tr>
        <td><div align="left"><span class="big-text">
          <%BookTitle = Title & Title1%>
          <% Response.Write BookTitle %>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ผู้แต่ง/ผู้แปล : <%Response.Write book_author%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">Barcode :
          <%Response.Write barcode%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ขนาด :
         <%Response.Write book_file_size%> kb</span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">หมวดหนังสือ : <%response.Write category_ebook%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ราคาปก :
              <s><%Response.Write book_cover_price %>
          บาท</s></span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">
<%
''Dim DiscountPercent
''DiscountPercent= Cal_DiscountPercent(Barcode)
''If DiscountPercent <> "" Then
'''response.Write  "(Ŵ&nbsp;" & DiscountPercent & "%)"
''Elseif DiscountPercent = "" Then
'''response.Write "(Ŵ)"
''End If
%>
<span class="redtext">
<% 
			''Dim SpecialPrice
      ''     SpecialPrice = Calculate_Price(Barcode)
		   response.Write "ราคา E-Book :&nbsp;" & bart_price & "&nbsp;บาท"
%>
</span>
  &nbsp; <%=extranote%> </span></div></td>
      </tr>
      <!--tr>
        <td><div align="left"><span class="blacktext">
          < %If Stflg <> 1 Then%>
          ส่วนลด :
  < %Call Cal_DiscountRate(Barcode)%>
  < %end if%>
        </span></div></td>
      </tr-->
      <tr>
      	<td height="10%"></td>
      </tr>      



      <!--tr>
        <td><div align="left"><span class="blacktext">bookid :
          < %Response.Write book_id%>
        </span></div></td>
      </tr-->


      <tr>
        <td>
          <div align="left">
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" >
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
RS_bookdis.Open  "SELECT barcode FROM Distribute_booklist  WHERE barcode ='"&barcode&"' ", Conn, 1, 3
'================================
if Not RS_bookdis.EOF Then

'================================
'if Not RS_Ebookdis.EOF Then
'response.Write RS_Ebookdis("isbn")
%>    
<!--tr>
<td valign="top"><a href="branchdistribute.asp?barcode=< %=barcode%>" onclick="return popitup('branchdistribute.asp?barcode=< %=barcode%>')"><img src="../images/button/bt_branchdistribute_new.png" width="128" height="27" border="0" /></a></td>
</tr-->
<%End If%>
                <tr>
                  <td valign="top"><!--<a href="insert_wishlist.asp?barcode=<%=barcode%>"><img src="images/button/fav_book.png" border="0" /></a>-->
                    <div align="center">
					  <% If not RS_Ebookdis.EOF Then %>
					  <% If bart_price <> "0" Then %>
                     <form id="addtocart" name="addtocart" method="post" onsubmit="return(foul.validate(this))" action="shopping.asp">
                     <input type="hidden" name="barcode"  value="<%=barcode%>e" />
					 <input type="hidden" name="book_id" value="<%=book_id%>" />
                     <input type="hidden" name="ebook" value="1" />
                     <input type="hidden" name="action" value="Add" />
                     <input name="taken" type="hidden" id="taken"  value="1" />
					 <input type="image" src="../images/button/cart_ebook.png" alt="Ebook to cart"  border="0" name="ebook" />
                     <%else%>
                    <form id="free-load" name="free-load" method="post" action="free_download_api.asp">
                    <input type="hidden" id="book_id" name="book_id" value="<%=book_id%>" />       
        			<input type="image" src="images/icons/download2.png" id="bt_download" name="bt_download" border="0"/>
					</form>
					<% End If %></br>
                    <% If bart_price<>"" Then %>
                     <!--input type="hidden" name="price" value="< %'= SpecialPrice %>" /-->
                     <input type="hidden" name="price" value="<%=bart_price%>" />
                    <% Else %>
                     <input type="hidden" name="price" value="<%=bart_price%>" />
                    <% End If %>
                    
                     </form>
                
                    <%
					'response.Write bart_price
					End If
					%>
                    </div></td>
                </tr>
              </table>
          </div>        </td>
      </tr>
      
      <tr>
        <td><div align="left"><span class="blacktext"><strong>อ่านได้บน : </strong>iPad, iPhone, iPod Touch (iOS 4 ขึ้นไป)</span> และ Android</div></td>
      </tr>
      <tr>
        <td align="center">
        	<img src="images/ios_logo.jpg"/><img src="images/android_logo.jpg"/>
        </td>
      </tr>      
      
    </table>
    <br /></td>
  </tr>
</table>

<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td><div align="left"><span class="big-text">
      <%Response.Write TopicType(Language)%>
      </span> <br />
      <span class="text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <% if description_ebook = "" then
	  response.Write "No Description"
	  else
			  'Content = Replace(Content,chr(13),"<br>")
			  'Content = Replace(Content,chr(10),"<br>")
			  response.Write description_ebook
		end if %>
    </span></div></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td valign="top"><!-- include file="inc_reviewbook_content.asp" --></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td><!-- include file="inc_reviewbook.asp"--></td>
  </tr>
</table>
<br />

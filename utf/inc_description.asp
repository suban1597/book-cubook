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
'Check Onhand
	If RsBook("Language") = 1 Then
		'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
		total_oh = RsBook("sb_oh")+RsBook("sb14_oh")+RsBook("stock_oh")
		If total_oh > 3 Then 
		  cart_img = "../images/button/cart_new.png"
		Else 
		  cart_img = "สินค้าหมด"
		End If
	Else if RsBook("Language") = 2 Then	
			'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
			total_oh = RsBook("sb_oh")+RsBook("sb14_oh")+RsBook("stock_oh")
			If total_oh > 3 Then 
		cart_img = "../images/button/bt_add2cart.png"
		Else 
		cart_img = "สินค้าหมด"
		End If
	Else if RsBook("Language") = 3 Then	
			'total_oh = RsBook("stock_oh")+RsBook("sb_oh")+RsBook("cb_oh")
			total_oh = RsBook("sb_oh")+RsBook("sb14_oh")+RsBook("stock_oh")
	If total_oh > 1 Then 
		cart_img = "../images/button/bt_add2cart.png"
		Else 
		cart_img = "สินค้าหมด"
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
	'response.Write Stflg
	
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
    <td width="26%" rowspan="2" valign="top" ><table border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top">
          <%
		 Dim CoverFile
		 CoverFile = Barcode & ".jpg" 			
         Call GetCoverImage(CoverFile)
		 %></td>
      </tr>
	  
	
    </table>
  
  
       <br /> <br />

<iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.chulabook.com&amp;send=false&amp;layout=button_count&amp;width=200&amp;show_faces=true&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21&amp;appId=231060397020865" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:200px; height:21px;" allowTransparency="true"></iframe>



    <br /> <br />  </td>
    <td width="74%" valign="top" >      <table width="95%" border="0" cellspacing="2" cellpadding="2">
      <tr>
        <td><div align="left"><span class="big-text">
          <%BookTitle = Title & Title1%>
          <% Response.Write BookTitle %>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ผู้แต่ง/ผู้แปล :
          <a class="text" href="JavaScript:void(0);" id="authorlink" value="<%Response.Write Author %>" alt="<%Response.Write Author %>">
		  <%=Author %> <%if translator <> "" then response.Write "/" & translator end if %></a>
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
        <td><div align="left"><span class="blacktext">ราคาปกติ :
          <%Response.Write Price%>
          บาท</span></div></td>
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
		   response.Write "ราคาพิเศษ :&nbsp;" & SpecialPrice & "&nbsp;บาท"
%>
  &nbsp; <%=extranote%> </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">
          <%If Stflg <> 1 Then%>
          ส่วนลด :
  <%Call Cal_DiscountRate(Barcode)%>
  <%end if%>
        </span></div></td>
      </tr>
      <tr>
        <td><form id="addtocart" name="addtocart" method="post" onsubmit="return(foul.validate(this))" action="shopping.asp">
          <div align="left">
            <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0" >
                <tr>
                  <td><div align="left">
                      <input name="taken" type="hidden" id="taken"  value="1" />
                      <input type="hidden" name="barcode"  value="<%=barcode%>" />
                      <!-- ҤŴҤŴ -->
                      <% If SpecialPrice<>"" Then %>
                    <input type="hidden" name="price" value="<%= SpecialPrice %>" />
                    <% Else %>
                    <input type="hidden" name="price" value="<%=price%>" />
                    <% End If %>
                      <!--  Action  [[ ADD]]  -->
                      <input type="hidden" name="action" value="Add" />
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
%>      
<tr>
<td valign="top"><a href="branchdistribute.asp?barcode=<%=barcode%>" onclick="return popitup('branchdistribute.asp?barcode=<%=barcode%>')"><img src="../images/button/bt_branchdistribute_new.png" width="128" height="27" border="0" /></a></td>
</tr>
<%End If%>
                <tr>
                  <td valign="top"><!--<a href="insert_wishlist.asp?barcode=<%=barcode%>"><img src="images/button/fav_book.png" border="0" /></a>-->
                      <div align="left">
                        <%If cart_img <> "สินค้าหมด" Then%>
                        <input type="image" src="<%=cart_img%>" alt="Add to cart"  border="0" name="image" />
                        <%
					Else
              if disctype1 = 5 then
                'response.Write "<img src=../images/button/ipst_button.png width=128 height=27 border=0 />"
                  response.Write "<img src=../images/button/ipst_button-2.png border=0 />"
              else
					       'response.Write "<img src=../images/button/ipst_button.png width=128 height=27 border=0 />"
                 response.Write "<img src=../images/button/ipst_button-2.png border=0 />"
                 
              end if
					End If
					%>
                    </div></td>
                </tr>
                      </table>
          </div>
        </form></td>
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
      <%
			  'Content = Replace(Content,chr(13),"<br>")
			  'Content = Replace(Content,chr(10),"<br>")
			  response.Write Content
			  %>
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

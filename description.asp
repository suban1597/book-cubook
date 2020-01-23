<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="../utf/connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<!--#include file="../utf/inc_checkprice.asp"--> 
<%
' Page Data 
' =======================
barcode = request.QueryString("barcode")
Sql = "SELECT * FROM booklist  WHERE barcode = '"&barcode&"' "
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3
%>
	<title><%=RS("title") & RS("title1")%></title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<%

' If having a Book 
'===========================
If Not RS.Eof Then
'Check Onhand
	If RS("Language") = 1 Then
		total_oh = RS("sb_oh")+RS("sb14_oh")
		If total_oh >= 4 Then 
		cart_img = "../images/button/cart_new.png"
		Else 
		cart_img = "สินค้าหมด"
		End If
	Else if RS("Language") = 2 Then	
			total_oh = RS("sb_oh")+RS("sb14_oh")+RS("jj_oh")
			If total_oh >= 2 Then 
		cart_img = "../images/button/cart_new.png"
		Else 
		cart_img = "สินค้าหมด"
		End If
	Else if RS("Language") = 3 Then	
			total_oh = RS("sb_oh")+RS("sb14_oh")
	If total_oh > 1 Then 
		cart_img = "../images/button/cart_new.png"
		Else 
		cart_img = "สินค้าหมด"
		End If
	End iF
	End If
	End If
End if

ReadCheck( barcode & ".txt")
	if Err Then
			If RS("Language") = 1 Then
			Content = "- - - - - ไม่มีรายละเอียดสินค้า - - - - - "
			Elseif RS("Language") = 2 Then
			Content = "- - - - - No Description - - - - - "
			Else
			Content = "- - - - - ไม่มีรายละเอียดสินค้า - - - - - "
			End If
	else
		   Content = ReadTextFile( barcode & ".txt")
	end if
' =======================	
%>
<!-- Content -->
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td width="7%" valign="top"><div align="center">
      <%On Error Resume Next%>
      <%		     
	    ' Find Book Cover
		' ===================================================================
		bookimgpt = "C:\Chulabook\images\book-400\" & RS("barcode") &  ".jpg"			
		'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & RS("barcode") &  ".jpg"	
		if   ChkFile(bookimgpt) = true then
				bookimg = "http://www.chulabook.com/images/book-400/" & RS("barcode") &  ".jpg"				
		'elseif ChkFilebook2(bookimgpt2) = true then
		''		bookimg = "http://www.chulabook.com/images/book2/" & RS("barcode") &  ".jpg"
		else	
				bookimg = "http://www.chulabook.com/images/book-400/apology.jpg"
		end if
		' =================================================================
	  %>
    <img src="<%=bookimg%>" border="0" height="400px"/> </div></td>
    <td width="93%" valign="top"><font class="text_header"><b><%=RS("Title")%><%=RS("Title1")%></b></font><br>
	<font class="text_normal"><%=RS("Barcode")%></font><br>
    <font class="text_normal">ผู้แต่ง : <%=RS("author")%></font><br>
    <font class="text_normal">ราคา : <%=Formatnumber(RS("Price"),2)%> บาท</font><br>
    <font class="text_normal">
	<%
	Barcode = RS("Barcode")
	Dim SpecialPrice
    SpecialPrice = Calculate_Price(Barcode)
	%>
    <b style="color:red">ราคาพิเศษ :<%=Formatnumber(SpecialPrice,2)%> บาท</b></font><br></td>
  </tr>
</table>
<form id="addtocart" name="addtocart" method="post" action="shopping.asp">
    <table width="100%" border="0" cellspacing="2" cellpadding="2">
     <tr>
        <td width="7%" height="15"><!--   <input type="image" src="images/icons-addtocart.png" alt="Add to cart"  title="หยิบใส่ตระกร้า" border="0" name="image" /> -->         </td>
        <td width="93%"><input name="taken" type="hidden" id="taken" value="1"  />
          <input type="hidden" name="barcode"  value="<%=barcode%>" />
          <%If SpecialPrice = "" Then%>
          <input type="hidden" name="price" value="<%=RS("Price")%>" />
          <%Else%>
          <input type="hidden" name="price" value="<%=SpecialPrice%>" />
          <%End If%>
          <input type="hidden" name="action" value="Add" /></td>
     </tr>
      
<%
Set RS_bookdis=Server.CreateObject("ADODB.RecordSet")
RS_bookdis.Open  "SELECT barcode FROM Distribute_booklist  WHERE barcode ='" &barcode&"' ", Conn, 1, 3
'================================
if Not RS_bookdis.EOF Then
%>
<%End If%>
                <tr>
                  <td valign="top"><!--<a href="insert_wishlist.asp?barcode=<%=barcode%>"><img src="images/button/fav_book.png" border="0" /></a>--></td>
                  <td valign="top"><div align="left">
                    <%If cart_img <> "สินค้าหมด" Then%>
                    <input type="image" src="<%=cart_img%>" alt="Add to cart"  border="0" name="image" />
                    <%
					Else
					response.Write "<img src=../images/button/outofstock.png width=128 height=27 border=0 />"
					End If
					%>
                  </div></td>
                </tr>
                      </table>
    <br />
</form>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td><font class="text_normal"><%=Content%></font></td>
  </tr>
  </table>
<%
sql_reviewcontent = "select  * from book_review where status = 1 and barcode like "&barcode&""
Set RS=Server.CreateObject("ADODB.RecordSet")
RS.open sql_reviewcontent, Conn, 1,1

icount = 1
Do while not  RS.eof
	%>
    
    
    <br /><br />
    
    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="#FFFFFF" class="text_normal">
  <tr>
    <td bgcolor="#F3F3F3"><div align="left"><img src="images/comment-ico.png"  border=0/><b>ความคิดเห็นที่ <%=icount%></b></div></td>
  </tr>
  <tr>
    <td>
<div align="left">
<font class="text_normal">
<%=RS("reviewcontent")%>

<br>
<span class="text_subtitle">
<%=RS("reviewname")%>&nbsp;
<%If RS("userid") <> 0 Then
	response.Write "เป็นสมาชิก"
	End if%>
    &nbsp;<%=RS("reviewdate")%>
</span>
</font>
</div></td>
  </tr>
</table>
<%
icount = icount + 1

RS.movenext
Loop
%>
<%RS.close%>

<!-- /Content -->

<!-- /footer --> 
<!--#include file="inc_footer.asp"--> 
<!-- /footer -->
</body>
</html>
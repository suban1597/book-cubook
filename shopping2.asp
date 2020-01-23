<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head> 
<!--#include file="connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<!--#include file="../utf/inc_checkprice.asp"--> 
<%
taken = request("taken")
barcode = request("barcode")
price = request("price")


buymore_title = "เพิ่ม"
update_title =  "คำนวนใหม่"
checkout_title = "ชำระเงิน"

' Remove Item
'========================================
RemoveItem = Request("RemoveItem")
if RemoveItem  <> 0  Then
 	Session("barcode" & RemoveItem) = ""
	Session("taken" & RemoveItem)= ""
	Session("Price" & RemoveItem)= ""
	Session("Dis" &  RemoveItem)= ""
End If
'========================================

RemItem=request("RemItem") 
Action=Request("Action")
ToRem=Request("ToRem")

'If {{  CheckOut }}
If Action=checkout_title Then
	Response.Redirect("checkout.asp")
End if

'If {{  Buy More}}
If Action=buymore_title Then
	Response.Redirect("index.asp")
End if


'If {{  ADD }}
If Action="add" Then
	Call Vectorized("barcode")
	Call Revectorized("barcode")
	'Call Cumulative("barcode")	

'If {{  UPDATE }}
ElseIf Action=update_title Then
	Session("NOAI")=""
	Call Vectorized("barcode")
	'Call Cumulative("barcode")
	If (Session("NOAI")="") OR (Session("NOAI")=0) Then
	Session.Abandon
	End If
Else
	Call Vectorized("barcode")
	Call Revectorized("barcode")
End If

If Session("NOAI")=0 Then
'Session.Abandon
Response.Redirect "EmptyCart.asp"
Response.End
End If
'========================================
%>
	<title>Shopping</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.css" />
	<script src="http://code.jquery.com/jquery-1.4.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.js"></script> 
</head> 
<body> 


<%
' Jquery Mobile config
' =======================
theme_id = "c"
theme_list_id = "d"
' =======================

' Function Freight Rate
'============================== 

Function ChulabookRate(SubTotal)
		chulabookRate=50

If SubTotal>=700  Then
		chulabookRate=0			
End If
			
End Function
'==============================

'============================== 
Function GetPrice20(Barcode)				
				Set RS3=Server.CreateObject("ADODB.RecordSet")
				sql3=" Select  price - (price*20/100) as price from booklist where barcode='" & barcode & "' "			
				RS3.Open Sql3, Conn, 1, 3
GetPrice20 = Rs3("price")				
End Function
'==============================


' Add Item To Cart
'========================================
Sub Vectorized(barcode)
If Session("NOAI")="" Then
	NOPI=0
Else
	On Error Resume Next
	NOPI=Session("NOAI")+0
	If Err Then 
		NOPI=0
	End If
End If


NONI=Request.Form(barcode).Count
i=0
j=NOPI

For k=1 to NONI
	If Not (Request.Form("taken")(k)=0)  Then
	i=i+1
	j=j+1
	Session(barcode & j)=Request.Form(barcode)(k)
	Session("taken" & j)=Request.Form("taken")(k)
	Session("Price" & j)=Request.Form("Price")(k)

	End If
Next	
Session("NOAI")=NOPI+i
End Sub
'========================================



'Recalculate Items
'========================================
Sub Revectorized(barcode)
NCompressed=0
Session("harry_flag")  = 0
For m=1 to Session("NOAI")
	For n=m to Session("NOAI")
		If (Session(barcode & m)=Session(barcode & n)) AND (Not(n=m)) Then
			Session(barcode & n)=Null
			Session("taken" & m)=CInt(Session("taken" & n))			
		End If
	Next
Next
For m=1 to Session("NOAI")
	If Len(Session(barcode & m))>0 Then
	NCompressed=NCompressed+1
	Session(barcode & NCompressed)=Session(barcode & m)
	Session("taken" & NCompressed)=Session("taken" & m)
	Session("Price" & NCompressed)=Session("Price" & m)
	Session("Dis" & NCompressed)=Session("Dis" & m)
	End If
Next
Session("NOAI")=NCompressed
End Sub
                  rno=0 
                  SubTotal=0 
%>

<!-- page -->
<div data-role="page">
<!-- header -->
	<div data-role="header" data-theme="<%=theme_id%>">
		<h1>ตะกร้าสินค้า</h1>
	</div>
<!-- /header -->

<!-- Content -->
	<div data-role="content">
<form name="addtocart" method="post" action="shopping.asp">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
  <tr>
    <td width="55%" bgcolor="#CCCCCC"><div align="center">ชื่อรายการ</div></td>
    <td width="11%" bgcolor="#CCCCCC"><div align="center">ราคา</div></td>
    <td width="11%" bgcolor="#CCCCCC"><div align="center">ส่วนลด</div></td>
    <td width="11%" bgcolor="#CCCCCC"><div align="center">ราคารวม</div></td>
    <td width="12%" bgcolor="#CCCCCC"><div align="center">จำนวน</div></td>
    </tr>
  <%
'Read Loop Items  
'================================================================= 
For p=1 to Session("NOAI")	
				Set RS=Server.CreateObject("ADODB.RecordSet")
				sql=" Select booklist.* from booklist where barcode='" & Session("barcode" & p) & "' "			
				RS.Open Sql, Conn, 1, 3
	'20% for Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute")="2" 
	Totalprice =  RS("Price") *  Session("taken" & p)
	If Totalprice >= 3000 and Lcase(Rs("disctype"))="c" and RS("disctype1")="1" and RS("language")="1" and Rs("distribute")="2" Then
			special_discount = Totalprice * 0.8
	Else
			special_discount = ""
	End if
				  On Error Resume Next 
                  rno=rno+1 
				  If special_discount = "" Then 
				  SubTotal=SubTotal+Session("taken" & p)*Session("Price" & p) 
				  subdiscount = subdiscount + (RS("Price")-Session("price" & p))*Session("taken" & p)
				  Else 
				  SubTotal=SubTotal+FormatNumber(special_discount,2)
				  subdiscount = subdiscount + Formatnumber(((RS("Price"))*Session("taken" & p))-special_discount,2)
				  End if
'IF ERROR 
                '  If Err Then
                '  	Session.Abandon 
               '   	Response.Clear 
               '   	Response.Redirect "http://www.chulabook.com/m/index.asp" 
               '   	Response.End 
               '   End If 
' IF ERROR 
%>
   <tr bgcolor="#EFEFEF">
     <td valign="top" bgcolor="#EFEFEF"><div align="left"> <%=RS("title") %><%=RS("title1") %> <br />
     </div></td>
   
   
   
     <td valign="top" bgcolor="#EFEFEF"><div align="center"><%= FormatNumber(RS("Price"),2) %></div></td>
     <td valign="top" bgcolor="#EFEFEF">
	  <div align="center">
	  <%
	  If special_discount <> "" Then
	  response.Write Formatnumber(((RS("Price"))*Session("taken" & p))-special_discount,2)
	  Else
	  disprice = (RS("Price")-Session("price" & p))*Session("taken" & p)
	  
	  if disprice = 0 Then
	  response.Write "-" 
	  else
	  response.Write Formatnumber((RS("Price")-Session("price" & p))*Session("taken" & p),2)
	  end if
	  
      End if
	  %>
	        </div></td>
     <td valign="top" bgcolor="#EFEFEF">
       <div align="center">
         <%
	  If special_discount <> "" Then
	  price =  FormatNumber(special_discount,2)
	  response.Write "ปกติ " & price & "<br>"
	  %>
           <input name="price2" type="hidden" value="<%=price%>" />
           <%
	  Else
	  response.Write  FormatNumber(Session("price" & p) *Session("taken" & p),2)
	  %>
           <input type="hidden" name="price" value="<%=FormatNumber(Session("price" & p),2) %>" />
            <%End if%>
              <%
	If special_discount  <> "" Then
	response.Write "ซื้อครบ 3,000 ลด 20%"
	End If
	%>
           <input type="hidden" name="barcode" value="<%= Session("barcode" & p) %>" />
       </div></td>
     <!-- Table Row 1 -->
    <td valign="top" bgcolor="#EFEFEF"><div align="center">
      <%'= FormatNumber(Session("price" & p) ,2) %>
      <input style="width:25px" type="text_blk" size="2" name="taken" value="<%=Session("taken" & p) %>" />
    <a href="shopping.asp?RemoveItem=<%=p%>"  onclick="return confirm('Delete selected item from your shopping cart? ')"><img src="images/delete2.png" border="0" /></a> </div></td>
  <!-- Table Row 1 -->
    
    
    
   <!-- Table Row 2 -->   
   <!-- Table Row 2 -->     
 </tr>
  <%
RS.movenext
Next  
'================================================================= 
%>
   
<tr>
  <td>  </tr>
</table>   
   
   
<table width="100%" border=0>   
<tr>
<td colspan="2">
<div align="right">รวมราคาสินค้า :&nbsp;&nbsp;&nbsp;<%=FormatNumber(Subtotal,2)%>
<%Session("Amount")= FormatNumber(Subtotal,2)%> บาท<font color="#FF0000">[ราคาลดแล้ว]</font></div>
</td>
</tr>


<tr>
<td colspan="2">
<div align="right">ส่วนลด&nbsp;&nbsp;<%=Formatnumber(subdiscount,2)%> บาท</div>
</td>
</tr>


<%If FormatNumber(Subtotal,2) < 700 Then%>
 <tr>
 <td colspan="2"><div align="right"><font color="#FF0000">*** เลือกสินค้าเพิ่มอีก <%=(700-FormatNumber(Subtotal,2))%> บาท ฟรีค่าจัดส่ง</font></div></td> 
 </tr>
<%End If%>


 <tr>
<td colspan="2">
<div align="right">ค่าจัดส่ง&nbsp;&nbsp;
         <%
		 FreightRate = chulabookRate(Subtotal)
		 IF FreightRate <> 0 Then
		 response.Write FormatNumber(chulabookRate(Subtotal),2) &"&nbsp;"& "บาท"
		 Else
		 response.Write "<font color=red>ฟรีค่าจัดส่ง</font>"
		 End If
		 %>
        <%Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> 
      </div></td>
 </tr> 
   <tr>
     <td colspan="2"><div align="right">รวมยอดเงินทั้งสิ้น :
	  &nbsp;&nbsp;&nbsp;<font color="#FF0000"><%=FormatNumber(SubTotal+chulabookRate(Subtotal),2)%>
        <%Session("SAHC")=FormatNumber(chulabookRate(Subtotal),2)%> บาท
     </font></div>
    </td>
 
  </tr>
</table>

<div data-role="controlgroup"  data-type="horizontal">
<input type="button" name="button" id="button" value="กลับ" onClick="history.back()"  data-icon="back" data-iconpos="right">
          <input name="action" type="submit" id="action" value="<%=buymore_title%>" data-icon="search" data-iconpos="right"/>
          <input name="action" type="submit" id="action" value="<%=update_title%>" data-icon="refresh" data-iconpos="right"/>
</div>          
          <input name="action" type="submit" id="action" value="<%=checkout_title%>" data-icon="check" data-iconpos="right"/>
       <!--   -->

          
 </form>
	</div>
<!-- /Content -->

<!-- /footer --> 
	<div data-role="footer" data-theme="<%=theme_id%>">
	</div>
<!-- /footer -->
</div>
<!-- /page -->


</body>
</html>
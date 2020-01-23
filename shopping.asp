<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="connect_db.asp"--> 
<!--#include file="../utf/inc_allfunction.asp"--> 
<!--#include file="../utf/inc_checkprice.asp"--> 
<!--#include file="../utf/inc_booksale.asp"-->   
<title>Shopping</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
<%
Action=Request("Action")
RemItem=request("RemItem") 
ToRem=Request("ToRem")

dim buymore_title
dim update_title
dim checkout_title

buymore_title = "เพิ่ม"
update_title =  "คำนวนใหม่"
checkout_title = "ชำระเงิน"


If Action=shopping Then
	Response.Redirect("shopping.asp")	
End if

If Action="" Then
	'Response.Redirect("shopping.asp")
End if

If Action=checkout_title Then
	Response.Redirect("checkout.asp")
End if

If Action=buymore_title Then
	Response.Redirect("index.asp")
End if


'If {{  UPDATE }}
If Action=update_title Then

'response.write "current NOAI = " & Session("NOAI")

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
'Response.End
End If
%>
	
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<!-- Content -->
    <form name="addtocart" method="post" action="shopping.asp">
    <!--#include file="inc_shopping.asp"-->
  <div align="center">
    <input type="button" name="button" id="button" value="กลับ" onClick="history.back()"  data-icon="back" data-iconpos="right">
    <input name="action" type="submit" id="action" value="<%=buymore_title%>" data-icon="search" data-iconpos="right"/>
    <input name="action" type="submit" id="action" value="<%=update_title%>" data-icon="refresh" data-iconpos="right"/>
    <input name="action" type="submit" id="action" value="<%=checkout_title%>" data-icon="check" data-iconpos="right"/>
   </div> 
   </form>
	
<!-- /Content -->

<!-- /footer --> 
<!--#include file="inc_footer.asp"--> 
<!-- /footer -->

</body>
</html>
<!--tyle>
img {
-webkit-filter: grayscale(100%); 
filter: grayscale(100%);
filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
}
html {
filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
-webkit-filter: grayscale(100%);
}
body { 
filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
-webkit-filter: grayscale(100%);
-moz-filter: grayscale(100%);
-ms-filter: grayscale(100%);
-o-filter: grayscale(100%);
filter: gray;
filter: grayscale(100%);
}
</style-->

    <meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" CONTENT="no-cache">
	<meta http-equiv="Pragma" CONTENT="no-cache"> 
 	<meta content="yes" name="apple-mobile-web-app-capable" />	
	<meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no" name="viewport" />


<link rel="stylesheet" type="text/css" href="ddtabmenufiles/solidblocksmenu.css" />
<table border=0 width="100%">



<%
if session("NOAI") > 0 then
	show_item =session("NOAI")
else
	show_item =0
end if
%>

<tr>
<td width="142"><a href="index.asp"><img src="chula-logo.gif" border=0></a></td>
<td ></td>
<td width="200" align="right" class="text_subtitle" valign="top">

<table border=0>
<tr> 
<td valign="middle"> 
<%if show_item>0 then%>
<a href="checkout.asp" class="text_subtitle"> สินค้าในตะกร้า  <%=show_item%>   รายการ </a>
<%else%>
ไม่มีสินค้าในตะกร้า
<%end if%>
</td>

<td valign="bottom"><img src="cart-right.gif"></td>
</tr>
</table>


 </td>
</tr>
</table>


<%
select_tap1 = 0
select_tap2 = 0
select_tap3 = 0
select_tap4 = 0

current_url = Request.ServerVariables ("URL")
'response.write current_url


if  InStr(current_url,"bestseller.asp") > 0  then
	select_tap2 =  1
elseif InStr(current_url,"index.asp") > 0  then
	select_tap1 =  1
elseif InStr(current_url,"promotion.asp") > 0  then
	select_tap3 =  1	
elseif InStr(current_url,"login.asp") > 0  then
	select_tap4 =  1	
end if


function choose_tab(tap_val)
if tap_val = 0 then
	class_name = ""
else
	class_name = "tab_clicked"
end if
	choose_tab = class_name
end function

%>



<div id="ddtabs3" class="solidblockmenu">
<ul>
<li><a href="index.asp" class="<%=choose_tab(select_tap1)%>">หน้าหลัก</a></li>
<li><a href="bestseller.asp" class="<%=choose_tab(select_tap2)%>">สินค้า</a></li>
<li><a href="promotion.asp" class="<%=choose_tab(select_tap3)%>">โปรโมชั่น</a></li>

<%'If Session("UserID") = "" Then%>
<!--<li><a href="login.asp" class="< %'=choose_tab(select_tap4)%>">เข้าสู่ระบบ</a></li>-->
<%'Else%>
<!--<li><a href="profile.asp" class="< %'=choose_tab(select_tap4)%>">ข้อมูลส่วนตัว</a></li>-->
<%'End If%>

<li><a href="banktransfer.asp" class="<%=choose_tab(select_tap4)%>">แจ้งผลการโอนเงิน</a></li>
</ul>
</div>




<form action="search.asp" method="post">  
<table width="100%" border="0" class="searchboxtap">
<tr>
<td> 
<input type="search" name="keyword" id="search" value=""  style="width:100px; height:25px" />
<select name="option1" id="select-choice-1" class="text_normal">
<option value="title">ชื่อหนังสือ</option>
<option value="author">ชื่อผู้แต่ง</option>
<option value="barcode">Barcode</option>
<option value="isbn">ISBN</option>
</select>
<input type="submit" value="ค้นหา" class="text_narmal"/>

</td>
</tr>
</table>
</form>


 <% if Session("userid") <> "" then %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr style="background-image:url(images/bg_login.jpg); background-repeat:repeat-x; height:60px">
  <td style="width:50px" align="right"><img src="images/photo.jpg" /></td>
  <td style="width:20px"></td>
    <td ><font class="text_header"> <% response.write "สวัสดีค่ะ คุณ" & Session("Bname") %><font></td>
  </tr>
</table>
<%end if%>

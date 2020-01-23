
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
book_id = request.QueryString("book_id")
'response.Write book_id
 
	sql = "select * from Ebooklist where book_id = '"&book_id&"' "
	'response.Write sql
	Set RS_Ebookdis=Server.CreateObject("ADODB.RecordSet")
	RS_Ebookdis.Open sql,conn,1,3	
	
	If not RS_Ebookdis.eof Then
	book_thumbnail_path = RS_Ebookdis("book_thumbnail_path")
%>
<table width="100%" border="0" cellpadding="5" cellspacing="5">
  <tr>
    <td width="26%" rowspan="2" valign="top" ><div align="right"><% bookimg = book_thumbnail_path & "middle.gif"%><img src="<%=bookimg%>" /></div>
       <br /> <br />
	  <div align="center"><a name="fb_share" type="button_count" href="http://www.facebook.com/sharer.php">แบ่งปันสู่ Facebook</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script></div>
    <br /> <br />  </td>
    <td width="74%" valign="top" >      <table width="95%" border="0" cellspacing="2" cellpadding="2">
      <tr>
        <td><div align="left"><span class="big-text">
          <%=RS_Ebookdis("book_name")%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ผู้แต่ง/ผู้แปล : <%=RS_Ebookdis("book_author")%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ขนาด :
         <%=RS_Ebookdis("book_file_size")%> kb</span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">หมวดหนังสือ : <%=RS_Ebookdis("category")%>
        </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">ราคาปก :
              <s>0.00 บาท</s></span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">
<span class="redtext">
<% 
		   response.Write "ราคา E-Book :&nbsp;" &RS_Ebookdis("book_bath_price")& "&nbsp;บาท"
%>
</span>
  &nbsp; <%=extranote%> </span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span class="blacktext">อ่านได้บน : iPad, iPhone, iPod Touch (iOS 4 ขึ้นไป)</span></div></td>
      </tr>
      <tr>
        <td>
          <div align="left">
            <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0" >
                <tr>
                  <td></td>
                </tr>
                <tr>
                  <td valign="top">
                      <div align="left">
					  <% If not RS_Ebookdis.EOF Then %>
                     <form id="free-load" name="free-load" method="post" action="free_download_api.asp">
					 <input type="hidden" name="book_id" value="<%=book_id%>" />
					 <input type="image" src="images/icons/download2.png" id="bt_download" name="bt_download" border="0" /></br>
                     </form>
                     <%
					'response.Write bart_price
					 End If
					 %>
                    </div></td>
                </tr>
              </table>
          </div>
        </td>
      </tr>
      
    </table>
      <br /></td>
  </tr>
</table>

<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td><div align="left"><span class="big-text">
      </span> <br />
      <span class="text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <% if RS_Ebookdis("description") = "" then
	  response.Write "No Description"
	  else
			  'Content = Replace(Content,chr(13),"<br>")
			  'Content = Replace(Content,chr(10),"<br>")
			  response.Write RS_Ebookdis("description")
		end if %>
    </span></div></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td valign="top"><!--include file="inc_reviewbook_content.asp"--></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr>
    <td><!--include file="inc_reviewbook.asp"--></td>
  </tr>
</table>
<br />
<%end if%>

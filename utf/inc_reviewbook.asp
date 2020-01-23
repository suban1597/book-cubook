<table width="530" height="23" border="0" align="left" cellpadding="1" cellspacing="1">
<tr>
          <td width="553" height="21" valign="top" bgcolor="#EEEEEE"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
            <tr>
              <td valign="top">
              
    <div align="left"><span class="big-text"><b>
      <br />
      &nbsp;&nbsp;แสดงความคิดเห็นเกี่ยวกับหนังสือ <%=booktitle%></b></span></div>
<%if session("bname") = "" Then%>
<div align="left" class="detailstext">กรุณาเข้าสู่ระบบเพื่อแสดงความคิดเห็นค่ะ <a href="../login.asp?barcode=<%=barcode%>">คลิกที่นี่</a> เพื่อเข้าสู่ระบบ</div>
<%else%>
<form id="form2" name="form2" method="post" action="insert_reviewbook.asp">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
                  <tr>
                    <td width="20%" valign="top" class="detailstext"><div align="right"><b>ความคิดเห็น : </b></div></td>
                    <td width="80%"><div align="left"><textarea name="content" id="content" cols="20" rows="5"  style="width:300px"></textarea></div></td>
                </tr>
                  <tr>
                    <td class="detailstext"><div align="right"><b>ให้คะแนน : </b></div></td>
                    <td><input type="radio" name="rating" id="radio" value="1" />
                      <img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" />
                      <input type="radio" name="rating" id="radio2" value="2" />
                      <img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" />
                      <input type="radio" name="rating" id="radio3" value="3" />
                      <img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /> 
                      <input type="radio" name="rating" id="radio4" value="4" />
                      <img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /> 
                      <input type="radio" name="rating" id="radio5" value="5" />
                      <img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /><img src="images/skins/highlight_icon.gif" width="16" height="16" border="0" /></td>
                  </tr>
                  <tr>
                    <td class="detailstext"><div align="right"><b>จากคุณ : </b></div></td>
                    <td><div align="left">
                      <input name="post_name" type="text" id="post_name" size="30" maxlength="50" />
                      <input name="barcode" type="hidden" id="placeid" value="<%=request("barcode")%>" />
                      <input name="placeid2" type="hidden" id="placeid2" value="<%=Session("Userid")%>" />
                    </div></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>
                    <div align="left"><input type="submit" name="button" id="button" value="แสดงความคิดเห็น" /></div>
                    </td>
                  </tr>
                </table> </form><%end if%>
              </td>
            </tr>
          </table></td>
</tr>
      </table>
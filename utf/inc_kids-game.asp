<%
				sql=" SELECT * FROM Kid_Question"
				sql=sql&" WHERE Game_Status = 1 " 
				Set Rs=Server.CreateObject("ADODB.RecordSet")
				Rs.Open  sql, Conn, 1, 3
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><div align="center"><br />
                <img src="images/kid/<%=Rs("Question_ID")%>.gif" width="530" height="400" />              </div></td>
            </tr>
          </table>
          <br />
<form id="form1" name="form1" method="post" action="insert_kidgame.asp">
            <table width="80%" border="0" align="center" cellpadding="1" cellspacing="1">
              <tr>
                <td bgcolor="#333366"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                      <tr> 
                        <td colspan="2" bgcolor="#E6FAFF" ><span class="big-text">น้องๆ สามารถส่งคำตอบได้ที่นี่เลยนะคะ</span></td>
                      </tr>
                      <tr> 
                        <td width="22%" valign="top" bgcolor="#FFFFFF"><div align="right"><span class="blacktext"><b>คำตอบ : </b></span></div></td>
          <td width="78%" bgcolor="#FFFFFF"> <div align="left"><span class="blacktext"> 
                          <input name="answer" type="radio" value="<%=Rs("Choice1")%>" checked="checked" />
                          <%=Rs("Choice1")%><br />
                  <input name="answer" type="radio" value="<%=Rs("Choice2")%>" />
                          <%=Rs("Choice2")%><br />
                  <input name="answer" type="radio" value="<%=Rs("Choice3")%>" />
                          <%=Rs("Choice3")%></span></div></td>
                  </tr>
                      <tr> 
                        <td bgcolor="#FFFFFF"><div align="right"><span class="blacktext"><b>เพศ : </b></span></div></td>
                        <td bgcolor="#FFFFFF"> <div align="left"><span class="blacktext"> 
                          <select name="gender" id="gender">
                            <option value="0">ด.ช.</option>
                            <option value="1">ด.ญ.</option>
                          </select>
                        </span></div></td>
                  </tr>
                      <tr> 
                        <td bgcolor="#FFFFFF"><div align="right"><span class="blacktext"><b>ชื่อ-นามสกุล : </b></span></div></td>
                        <td bgcolor="#FFFFFF"> <div align="left"><span class="blacktext">
                          <input name="bname" type="text" id="bname" size="25" />
                      </span></div></td>
                  </tr>
                      <tr> 
                        <td bgcolor="#FFFFFF"><div align="right"><span class="blacktext"><b>โทรศัพท์ : </b></span></div></td>
                        <td bgcolor="#FFFFFF"> <div align="left"><span class="blacktext"> 
                          <input name="phone" type="text" id="phone" size="25" />
                        </span></div></td>
                  </tr>
                      <tr> 
                        <td bgcolor="#FFFFFF"><div align="right"><span class="blacktext"><b>Email : </b></span></div></td>
                        <td bgcolor="#FFFFFF"> <div align="left"><span class="blacktext"> 
                          <input name="email" type="text" id="email" size="25" />
                        </span></div></td>
                  </tr>
                      <tr> 
                        <td valign="top" bgcolor="#FFFFFF"><div align="right"><span class="blacktext"><b>ที่อยู่ : </b></span></div></td>
                      <td bgcolor="#FFFFFF"> <div align="left"><span class="blacktext"> 
                          <textarea name="address" cols="25" rows="3" id="address"></textarea>
                        </span></div></td>
                  </tr>
                      <tr> 
                        <td bgcolor="#FFFFFF"><strong><font size="4" face="AngsanaUPC">&nbsp;</font></strong></td>
                        <td bgcolor="#FFFFFF"> <div align="left">
                          <input type="submit" name="Submit" value="ส่งคำตอบ" />
                          <input name="Game" type="hidden" id="Game" value="<%=Rs("Question_ID")%>" />
                    </div></td>
                  </tr>
                    </table></td>
              </tr>
            </table>
          </form>
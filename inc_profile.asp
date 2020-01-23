 
<table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
    <td valign="top"><form id="register" name="register" method="post" action="update_profile.asp" >
<%
Sql = "SELECT * FROM account WHERE (UserID ='" & Session("UserID") & "')"
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3
%>	
<%Session("Bname") = RS("Bname")%>
<%Session("UserID") = RS("UserID")%>
        <table width="100%" border="0" align="center" cellpadding="2" cellspacing="2" >
<%
		birthday = Rs("birthday")
		gender = Rs("gender")
%>
                <tr>
                  <td height="17" bgcolor="#F8F8F8">
<font class="text_header">ข้อมูลผู้สมัครสมาชิก</font></td>
          </tr>
                <tr>
                <td><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
              <tr>
                        <td width="21%" ><div align="right">ชื่อ - นามสกุล </div></td>
                        <td width="79%" ><div align="left">
                          <input name="tb_Bname"    id="tb_Bname2" value="<%=trim(RS("bname"))%>" size="30" />
                        </div></td>
                  </tr>
                      <tr>
                        <td><div align="right">
                          <div align="right">วันเกิด  </div>
                        </div></td>
                        <td>
                          <div align="left">
                            <%'response.write   "trim(left(Birthday, 4)) : " & trim(left(Birthday, 4))%>
                              <select name="bd1" id="bd1">
                                <%
		MM1 = ""
		MM2 = ""
		MM3 = ""
		MM4 = ""
		MM5 = ""
		MM6 = ""
		MM7 = ""
		MM8 = ""
		MM9 = ""
		MM10 = ""
		MM11 = ""
		MM12 = ""
		
		
		SELECT Case trim(left(Birthday, 2))
			CASE "01"
			MM1 = "selected"
		CASE "02"
			MM2 = "selected"
		CASE "03"
			MM3 = "selected"
		CASE "04"
			MM4 = "selected"
		CASE "05"
			MM5 = "selected"
		CASE "06"
			MM6 = "selected"
		CASE "07"
			MM7 = "selected"
		CASE "08"
			MM8 = "selected"
		CASE "09"
			MM9 = "selected"
		CASE "10"
			MM10 = "selected"
		CASE "11"
			MM11 = "selected"
		CASE "12"
			MM12 = "selected"
		END SELECT
		%>
                                <option value="01"    <%=MM1%>>Jan </option>
                                <option value="02"   <%=MM2%>>Feb </option>
                                <option value="03"   <%=MM3%>>Mar </option>
                                <option value="04"    <%=MM4%>>Apr </option>
                                <option value="05"  <%=MM5%>>May </option>
                                <option value="06"  <%=MM6%>>June </option>
                                <option value="07"  <%=MM7%>>July </option>
                                <option value="08"   <%=MM8%>>Aug </option>
                                <option value="09"  <%=MM9%>>Sep </option>
                                <option value="10"   <%=MM10%>>Oct </option>
                                <option value="11"  <%=MM11%>>Nov </option>
                                <option value="12"  <%=MM12%>>Dec </option>
                            </select>
                              <%'response.write "Birthday = " & Birthday%>
                              <select name="bd2" id="bd2">
                                <%For i = 1 To 31%>
                                <%IF Mid(Birthday, 3, 2) = cStr(i) Then%>
                                <option value="<%=i%>" selected="selected"><%=i%>
                                <%Else%>
                                </option>
                                <option value="<%=i%>"><%=i%>
                                <%End IF%>
                                <%Next%>
                                </option>
                            </select>

                                   <select name="bd3" id="bd3" class="form">
                                <%For i = 1900 To year(date())%>
                                <%IF right(rtrim(Birthday), 4) = cStr(i) Then%>
                                <option value="<%=i%>" selected="selected"><%=i%><%=" "%><%="(พ.ศ. " & i + 543 & ")"%>
                                <%Else%>
                                </option>
                                <option value="<%=i%>"><%=i%><%=" "%><%="(พ.ศ. " & i + 543 & ")"%>
                                <%End IF%>
                                <%Next%>
                                </option>
                            </select>
                          </div>
                        </label></td>
                      </tr>
                      <tr>
                        <td><div align="right">เพศ &nbsp; </div></td>
                        <td>
                          <div align="left">
                            <select name="sl_gender" id = "select3">
                              <option value="0">ไม่ระบุ</option>
                              <%
		Gender0 = ""
		Gender1 = ""
		Gender2 = ""
	
		SELECT Case (Gender)
		CASE "0"
			Gender0 = "selected"
		CASE "1"
			Gender1 = "selected"
		CASE "2"
			Gender2 = "selected"
		END SELECT
		%>
                              <option value="2" <%=Gender2%>>หญิง</option>
                              <option value="1" <%=Gender1%>>ชาย</option>
                            </select>
                          </div>              </td>
                      </tr>
                  </table></td>
                </tr>
                <%If RS("statusupdate") <> 1 Then%>
                <tr>
                  <td bgcolor="#F8F8F8"><div align="left"><b>ข้อมูลที่อยู่ปัจจุบัน [สามารถติดต่อได้]</b></div></td>
                </tr>
                <tr>
                  <td><br />
                  <table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="#FFFFCC">
                    <tr>
                      <td colspan="2" bgcolor="#ECE9D8" ><div align="center"><span class="style1">*** เนื่องจากทาง Chulabook.com ได้ทำการปรับฐานข้อมูลลูกค้าใหม่ <br>
ดังนั้น จึงขอรบกวนสมาชิกทุกท่านที่ Login เข้ามาใช้งานทำการแก้ไข ที่อยู่ปัจจุบัน และที่อยู่ที่จัดส่งให้ตรงตามแบบฟอร์มด้วยนะคะ</span></div></td>
                    </tr>
                    <tr>
                      <td width="35%" valign="top" ><div align="right"><b>(ที่อยุ่ปัจจุบัน)&nbsp;</b></div></td>
                      <td width="65%" valign="top" ><div align="left"><%=trim(RS("baddress"))%>&nbsp;<%=trim(RS("bcity"))%>&nbsp;<%=trim(RS("binterprovince"))%>&nbsp;<%=trim(RS("bzip"))%>&nbsp;<%=trim(RS("bphone"))%></div></td>
                    </tr>
                    <tr>
                      <td colspan="2"> <div align="center" class="style2">- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - -</div></td>
                    </tr>
                    <tr>
                      <td valign="top"><div align="right"><b>(ที่อยู่ในการจัดส่ง)</b></div></td>
                      <td valign="top"><div align="left"><%=trim(RS("sname"))%>&nbsp;<%=trim(RS("saddress"))%>&nbsp;<%=trim(RS("scity"))%>&nbsp;<%=trim(RS("scity"))%><%=trim(RS("szip"))%></div>
                          </label></td>
                    </tr>
                  </table>
                  <br /></td>
          </tr><%End If%>
                <tr>
                  <td bgcolor="#F8F8F8"><div align="left"><b>ข้อมูลที่อยู่ปัจจุบัน [สามารถติดต่อได้]</b></div></td>
                </tr>
                <tr>
                <td><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
                      <tr>
                        <td><div align="right">ชื่อสถานที่ </div></td>
                        <td>
                          <div align="left">
                            <input name="bplace"  id="bplace" value="<%=trim(RS("bplace"))%>" size="40" />
                        </div></td>
                  </tr>
                      <tr>
                        <td width="21%"><div align="right">
                          <div align="right">เลขที่ </div>
                        </div></td>
                        <td width="79%">
                          <div align="left">
                            <input name="bnum"  id="bnum" value="<%=trim(RS("bnum"))%>" size="10" />
หมู่ที่ 
<input name="bmoo"  id="bmoo" value="<%=trim(RS("bmoo"))%>" size="5" />
                          </div>                        </td>
                  </tr>
                      <tr>
                        <td><div align="right">
                          <div align="right">ตึก/อาคาร/หมู่บ้าน </div>
                        </div></td>
                        <td>
                          <div align="left">
                   
                            <input name="bbuilding"  id="bbuilding" value="<%=trim(RS("bbuilding"))%>" size="40" />
                          </div>                      </td>
                      </tr>
                      <tr>
                        <td><div align="right">                          <div align="right">ตรอก/ซอย  </div>
</div></td>
                        <td>
                          <div align="left">
                            <input name="bsoi"  id="bsoi" value="<%=trim(RS("bsoi"))%>" size="30" />
                          </div></td>
                  </tr>
                      <tr>
                        <td><div align="right">ถนน </div></td>
                        <td>
                          <div align="left">
                            <input name="broad"  id="broad" value="<%=trim(RS("broad"))%>" size="30" />
                        </div></td>
                  </tr>
                      <tr>
                        <td>
                          <div align="right">ตำบล/แขวง</div></td>
                        <td>
                          <div align="left">
                            <input name="btumbon"  id="btumbon" value="<%=trim(RS("btumbon"))%>" size="25" />
                        </div></td>
                  </tr>
                      <tr>
                        <td><div align="right">อำเภอ/เขต</div></td>
                        <td>
                          <div align="left">
                            <input name="bcity"  id="bcity" value="<%=trim(RS("bcity"))%>" size="25" />
                        </div></td>
                  </tr>
                      <tr>
                        <td><div align="right">จังหวัด</div></td>
                        <td>
                          <div align="left">
               
                            <select name="bprovinceth" id="bprovinceth">
    <%
Sql_province = "SELECT * FROM province2 WHERE COUNTRY_CODE like 'TH' order by TH_NAME"
Set RS_province = Server.CreateObject("ADODB.RecordSet")
RS_province.Open Sql_province,conn,1,3
Do While Not RS_province.eof
%>

    <option value="<%=RS_province("PROVINCE_CODE")%>" <%If (Not isNull(Rs("BProvince"))) and RS("BProvince")=RS_province("PROVINCE_CODE") Then Response.Write("selected=""selected""") : Response.Write("")%>><%=RS_province("TH_NAME")%></option>
                        <%
RS_province.movenext
Loop
%>
  </select>
                          </div>       </td>
                      </tr>
                      <tr>
                        <td><div align="right">
                          <div align="right">รหัสไปรษณีย์ </div>
                        </div></td>
                        <td>
                          <div align="left">
             
                            <input name="bzip"  id="bzip" value="<%=trim(RS("bzip"))%>" size="15" />
                          </div> </td>
                      </tr>
                      <tr>
                        <td><div align="right">โทรศัพท์&nbsp; </div></td>
                        <td><div align="left">
                           <input name="bphone"  id="bphone" value="<%=trim(RS("bphone"))%>" size="20" />
                            </div></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td bgcolor="#F8F8F8"><div align="left"><b>ข้อมูลที่อยู่สำหรับจัดส่งสินค้า</b></div></td>
                </tr>
                <tr>
                <td><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
                      
                      <tr>
                        <td ><div align="right">ชื่อ-นามสกุล </div></td>
                        <td ><div align="left">
                
                          <input name="tb_Sname"    id="tb_Sname" value="<%=trim(RS("sname"))%>" size="30" />
                        </div></td>
                      </tr>
                      <tr>
                        <td width="21%"><div align="right">ชื่อสถานที่&nbsp; </div></td>
                        <td width="79%">
                          <div align="left">
                            <input name="splace"  id="splace" value="<%=trim(RS("splace"))%>" size="40" />
                          </div>                 </td>
                  </tr>
                      <tr>
                        <td><div align="right">เลขที่&nbsp;</div></td>
                        <td><div align="left">
  <input name="snum"  id="snum" value="<%=trim(RS("snum"))%>" size="10" />
  &nbsp;หมู่ที่
  <input name="smoo"  id="smoo" value="<%=trim(RS("smoo"))%>" size="5" />
                        </div></td>
                  </tr>
                      <tr>
                        <td><div align="right">
                          <div align="right">ตึก/อาคาร/หมู่บ้าน </div>
                        </div></td>
                        <td>
                          <div align="left">
                            <input name="sbuilding"  id="sbuilding" value="<%=trim(RS("sbuilding"))%>" size="40" />
                        </div></td>
                  </tr>
                      <tr>
                        <td><div align="right">
                          <div align="right">ตรอก/ซอย  </div>
                        </div></td>
                        <td><div align="left">
                        <input name="ssoi"  id="ssoi" value="<%=trim(RS("ssoi"))%>" size="30" />
                        &nbsp;</div></td>
                  </tr>
                      <tr>
                        <td><div align="right">ถนน</div></td>
                        <td>
                          <div align="left">
                            <input name="sroad"  id="sroad" value="<%=trim(RS("sroad"))%>" size="30" />
                        </div></td>
                  </tr>
                      <tr>
                        <td><div align="right">ตำบล/แขวง</div></td>                        
                        <td>
                          <div align="left">
                            <input name="stumbon"  id="stumbon" value="<%=trim(RS("stumbon"))%>" size="25" />
                        </div></td>
                  </tr>
                      
                      <tr>
                        <td><div align="right">อำเภอ/เขต </div></td>
                        <td>
                          <div align="left">                          
                            <input name="scity"  id="scity" value="<%=trim(RS("scity"))%>" size="25" />
                          </div></td>
                      </tr>
                      <tr>
                        <td><div align="right">จังหวัด&nbsp;</div></td>
                        <td class="text_blk1">
                          <div align="left">
                            <select name="sprovinceth" id="sprovinceth">
    <%
Sql_province = "SELECT * FROM province2 WHERE COUNTRY_CODE like 'TH' order by TH_NAME"
Set RS_province = Server.CreateObject("ADODB.RecordSet")
RS_province.Open Sql_province,conn,1,3
Do While Not RS_province.eof
%>

    <option value="<%=RS_province("PROVINCE_CODE")%>" <%If (Not isNull(Rs("SProvince"))) and RS("SProvince")=RS_province("PROVINCE_CODE") Then Response.Write("selected=""selected""") : Response.Write("")%>><%=RS_province("TH_NAME")%></option>
                        <%
RS_province.movenext
Loop
%>
  </select>
                          </div></td>
                      </tr>
                      
                      
                      <tr>
                        <td ><div align="right">รหัสไปรษณีย์ </div></td>
                        <td >
                          <div align="left">
                       
                            <input name="szip"  id="szip" value="<%=trim(RS("szip"))%>" size="15" />
                          </div>         </td>
                      </tr>
                      <tr>
                        <td ><div align="right">โทรศัพท์ </div></td>
                        <td >
                          <div align="left">
            
                             <input name="sphone"  id="sphone" value="<%=trim(RS("sphone"))%>" size="20" />
                          </div></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="34"><div align="center">
                      <input name="Submit" type="submit" id="Submit" value="แก้ไขข้อมูลส่วนตัว" />
                  </div></td>
                </tr>
        </table>
    </form></td>
  </tr>
</table>
<%
RS.close
RS_province.close
%>
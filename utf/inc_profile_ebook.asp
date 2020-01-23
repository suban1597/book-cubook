<!--#include file="connectdb.asp"-->
<%
Sql = "SELECT * FROM account WHERE (UserID ='" & Session("UserID") & "')"
Set RS = Server.CreateObject("ADODB.RecordSet")
RS.Open Sql,conn,1,3
%>
<%Session("Bname") = RS("Bname")%>
<%Session("UserID") = RS("UserID")%>
<script language="javascript">
function textcopy(o)
{
 
//o = value of check box
            if (o) {
									register.tb_Sname.value = register.tb_Bname.value;
									register.snum.value = register.bnum.value;
									register.splace.value = register.bplace.value;									
                                    register.smoo.value = register.bmoo.value;
                                    register.sbuilding.value = register.bbuilding.value;
									register.ssoi.value = register.bsoi.value;
									register.sroad.value = register.broad.value;
                                    register.stumbon.value = register.btumbon.value;
									register.scity.value = register.bcity.value;
									register.sprovinceth.value = register.bprovinceth.value;						    
									register.scountry.value = register.bcountry.value;
									register.szip.value = register.bzip.value;
									register.sphone.value = register.bphone.value;
									
                                    }
            else {
						register.tb_Sname.value = ''; 
						register.snum.value = '';
			 			register.splace.value = '';						 
                        register.smoo.value = '';
                        register.sbuilding.value = '';
						register.ssoi.value = '';
						register.sroad.value = '';
                        register.stumbon.value = '';
					   	register.scity.value = '';
						register.sprovinceth.value = '';
						register.scountry.value = '';
						register.szip.value = '';
						register.sphone.value = '';
                        }
}
 
</script>
<script type = "text/javascript" src="../foul.js"></script>
  					<script type="text/javascript">
						foul.when('~tb_email~ is not email','รูปแบบ email  ไม่ถูกต้อง');
							foul.when('~tb_Bname~ is null','กรุณาใส่ชื่อด้วยค่ะ');
							foul.when('~bcity~ is null','กรุณาใส่อำเภอด้วยค่ะ');
							foul.when('~bprovinceth~ is null','กรุณาเลือกจังหวัดด้วยค่ะ');
							foul.when('~bcountry~ is null','กรุณาเลือกประเทศด้วยค่ะ');
							foul.when('~bzip~ is null','กรุณาใส่รหัสไปรษณีย์ด้วยค่ะ');
							foul.when('~bphone~ is null','กรุราใส่เบอร์โทรศัพท์ด้วยค่ะ');
							foul.when('~tb_Sname~ is null','กรุณาใส่ชื่อด้วยค่ะ');
							foul.when('~scity~ is null','กรุณาใส่อำเภอด้วยค่ะ');
							foul.when('~sprovinceth~ is null','กรุณาเลือกจังหวัดด้วยค่ะ');
							foul.when('~scountry~ is null','กรุณาเลือกประเทศด้วยค่ะ');
							foul.when('~szip~ is null','กรุณาใส่รหัสไปรษณีย์ด้วยค่ะ');
							foul.when('~sphone~ is null','กรุณาใส่เบอร์โทรศัพท์ด้วยค่ะ');
						
		</script>
<style type="text/css">
<!--
.style1 {color: #FF6600}
.style2 {color: #999999}
-->
</style>



<table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
    <td valign="top"><form id="register" name="register" method="post" onsubmit="return(foul.validate(this))" action="main_profile_ebook.asp" >
        <table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" >
<%
		birthday = Rs("birthday")
		gender = Rs("gender")
%>
                <tr>
                  <td height="17" bgcolor="#F8F8F8">
                  <div align="left"><strong><img src="images/skins/user.png" width="16" height="16" />ข้อมูลผู้สมัครสมาชิก</strong></div></td>
          </tr>
                <tr>
                <td><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
              <tr>
                        <td width="21%" ><div align="right">ชื่อ - นามสกุล </div></td>
                        <td width="79%" ><div align="left">
                          <input name="tb_Bname"    id="tb_Bname2" value="<%=trim(RS("bname"))%>" size="30" />
                          <input name="tb_email" type="hidden"  id="tb_email" value="<%=trim(RS("Email"))%>" size="30" />
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
                                <option value="01"  <%=MM1%>>Jan </option>
                                <option value="02"  <%=MM2%>>Feb </option>
                                <option value="03"  <%=MM3%>>Mar </option>
                                <option value="04"  <%=MM4%>>Apr </option>
                                <option value="05"  <%=MM5%>>May </option>
                                <option value="06"  <%=MM6%>>June </option>
                                <option value="07"  <%=MM7%>>July </option>
                                <option value="08"  <%=MM8%>>Aug </option>
                                <option value="09"  <%=MM9%>>Sep </option>
                                <option value="10"  <%=MM10%>>Oct </option>
                                <option value="11"  <%=MM11%>>Nov </option>
                                <option value="12"  <%=MM12%>>Dec </option>
                            </select>
                              <%'response.write "Birthday = " & Birthday%>
                              <select name="bd2" id="bd2">
                                <%For i = 1 To 31%>
                                <%
								numday = Mid(Birthday, 3, 1)
								if  numday =  0 then
								numday = Mid(Birthday, 4, 1)
								else numday = Mid(Birthday, 3, 2)
								end if
								
								IF  numday = cStr(i) Then
								%>
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
                  <td bgcolor="#F8F8F8"><div align="left"><b><img src="images/skins/building_error.png" width="16" height="16" border="0" />ข้อมูลที่อยู่ปัจจุบัน [สามารถติดต่อได้]</b></div></td>
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
                  <td bgcolor="#F8F8F8"><div align="left"><b><img src="images/skins/building_edit.png" width="16" height="16" />ข้อมูลที่อยู่ปัจจุบัน [สามารถติดต่อได้]</b></div></td>
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
                        <td>&nbsp;</td>
                        <td><div align="left">
                        
                          <input name="binterprovince"  id="binterprovince" value="<%=trim(RS("binterprovince"))%>" size="15" />
                          International customer please fill in the box. </div></td>
                      </tr>
                      <tr>
                        <td><div align="right">ประเทศ</div></td>
                        <td>
                          <div align="left">
                                  <select name="bcountry" id="select5">
                                  <option value="Afghanistan" selected="selected" <%If (Not isNull(Rs("BProvince"))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Afghanistan</option>
                                  <option value="Albania">Albania</option>
                                  <option value="Algeria">Algeria</option>
                                  <option value="American Samoa">American Samoa</option>
                                  <option value="Andorra">Andorra</option>
                                  <option value="Argentina">Argentina</option>
                                  <option value="Armenia">Armenia</option>
                                  <option value="Angola">Angola</option>
                                  <option value="Anguilla">Anguilla</option>
                                  <option value="Antarctic">Antarctica</option>
                                  <option value="Antiguq And Barbuda">Antigua And Barbuda</option>
                                  <option value="Aruba">Aruba</option>
                                  <option value="Australia">Australia</option>
                                  <option value="Austria">Austria</option>
                                  <option value="Azerbaijan">Azerbaijan</option>
                                  <option value="Bahamas">Bahamas</option>
                                  <option value="Bahrain">Bahrain</option>
                                  <option value="Bangladesh">Bangladesh</option>
                                  <option value="Barbados">Barbados</option>
                                  <option value="Belarus">Belarus</option>
                                  <option value="Belgium">Belgium</option>
                                  <option value="Belize">Belize</option>
                                  <option value="Benin">Benin</option>
                                  <option value="Bermuda">Bermuda</option>
                                  <option value="Bhutan">Bhutan</option>
                                  <option value="Bolivia">Bolivia</option>
                                  <option value="Bosnia And Herzegovina">Bosnia And Herzegovina</option>
                                  <option value="Botswana">Botswana</option>
                                  <option value="Bouvet Island">Bouvet Island</option>
                                  <option value="Brazil">Brazil</option>
                                  <option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
                                  <option value="Brunei Darussalam">Brunei Darussalam</option>
                                  <option value="Bulgaria">Bulgaria</option>
                                  <option value="Burkina Faso">Burkina Faso</option>
                                  <option value="Burundi">Burundi</option>
                                  <option value="Cambodia">Cambodia</option>
                                  <option value="Cameroon">Cameroon</option>
                                  <option value="Canada">Canada</option>
                                  <option value="Cape Verde">Cape Verde</option>
                                  <option value="Cayman Islands">Cayman Islands</option>
                                  <option value="Central African Republic">Central African Republic</option>
                                  <option value="Chad">Chad</option>
                                  <option value="Chile">Chile</option>
                                  <option value="China">China</option>
                                  <option value="Christmas Island">Christmas Island</option>
                                  <option value="Cocos (keeling Islands)">Cocos (keeling Islands)</option>
                                  <option value="Colombia">Colombia</option>
                                  <option value="Comoros">Comoros</option>
                                  <option value="Congo">Congo</option>
                                  <option value="Cook Islands">Cook Islands</option>
                                  <option value="Costa Rica">Costa Rica</option>
                                  <option value="Cote D'ivorie (ivory Coast)">Cote D'ivoire (ivory Coast)</option>
                                  <option value="Croatia (hrvatska)">Croatia (hrvatska)</option>
                                  <option value="Cuba">Cuba</option>
                                  <option value="Cyprus">Cyprus</option>
                                  <option value="Czech Republic">Czech Republic</option>
                                  <option value="Denmark">Denmark</option>
                                  <option value="Djibouti">Djibouti</option>
                                  <option value="Dominican Republic">Dominican Republic</option>
                                  <option value="East Timor">East Timor</option>
                                  <option value="Ecuador">Ecuador</option>
                                  <option value="Egypt">Egypt</option>
                                  <option value="El Salvador">El Salvador</option>
                                  <option value="Equatorial Guinea">Equatorial Guinea</option>
                                  <option value="Eritrea">Eritrea</option>
                                  <option value="Estonia">Estonia</option>
                                  <option value="Ethiopia">Ethiopia</option>
                                  <option value="Falkland Islands (malvinas)">Falkland Islands (malvinas)</option>
                                  <option value="Faroe Islands">Faroe Islands</option>
                                  <option value="Fiji">Fiji</option>
                                  <option value="Finland">Finland</option>
                                  <option value="France">France</option>
                                  <option value="France, Metropolitan">France, Metropolitan</option>
                                  <option value="French Guiana">French Guiana</option>
                                  <option value="French Polynesia">French Polynesia</option>
                                  <option value="French Southern Territories">French Southern Territories</option>
                                  <option value="Gabon">Gabon</option>
                                  <option value="Gambia">Gambia</option>
                                  <option value="Georgia">Georgia</option>
                                  <option value="Germany">Germany</option>
                                  <option value="Ghana">Ghana</option>
                                  <option value="Gibraltar">Gibraltar</option>
                                  <option value="Greece">Greece</option>
                                  <option value="Greenland">Greenland</option>
                                  <option value="Grenada">Grenada</option>
                                  <option value="Guadeloupe">Guadeloupe</option>
                                  <option value="Guam">Guam</option>
                                  <option value="Guatemala">Guatemala</option>
                                  <option value="Guinea">Guinea</option>
                                  <option value="Guinea-bissau">Guinea-bissau</option>
                                  <option value="Guyana">Guyana</option>
                                  <option value="Haiti">Haiti</option>
                                  <option value="Heard And Mcdonald Islands">Heard And Mcdonald Islands</option>
                                  <option value="Honduras">Honduras</option>
                                  <option value="Hong Kong">Hong Kong</option>
                                  <option value="Hungary">Hungary</option>
                                  <option value="Iceland">Iceland</option>
                                  <option value="India">India</option>
                                  <option value="Indonesia">Indonesia</option>
                                  <option value="Iran">Iran</option>
                                  <option value="Iraq">Iraq</option>
                                  <option value="Ireland">Ireland</option>
                                  <option value="Israel">Israel</option>
                                  <option value="Italy">Italy</option>
                                  <option value="Jamaica">Jamaica</option>
                                  <option value="Japan">Japan</option>
                                  <option value="Jordan">Jordan</option>
                                  <option value="Kazakhstan">Kazakhstan</option>
                                  <option value="Kenya">Kenya</option>
                                  <option value="Kiribati">Kiribati</option>
                                  <option value="Korea (north)">Korea (north)</option>
                                  <option value="Korea (south)">Korea (south)</option>
                                  <option value="Kuwait">Kuwait</option>
                                  <option value="Kyrgyzstan">Kyrgyzstan</option>
                                  <option value="Laos">Laos</option>
                                  <option value="Latvia">Latvia</option>
                                  <option value="Lebanon">Lebanon</option>
                                  <option value="Lesotho">Lesotho</option>
                                  <option value="Liberia">Liberia</option>
                                  <option value="Libya">Libya</option>
                                  <option value="Liechtenstein">Liechtenstein</option>
                                  <option value="Lithuania">Lithuania</option>
                                  <option value="Luxembourg">Luxembourg</option>
                                  <option value="Macau">Macau</option>
                                  <option value="Macedonia">Macedonia</option>
                                  <option value="Madagascar">Madagascar</option>
                                  <option value="Malawi">Malawi</option>
                                  <option value="Malaysia">Malaysia</option>
                                  <option value="Maldives">Maldives</option>
                                  <option value="Mali">Mali</option>
                                  <option value="Malta">Malta</option>
                                  <option value="Marshall Islands">Marshall Islands</option>
                                  <option value="Martinique">Martinique</option>
                                  <option value="Mauritania">Mauritania</option>
                                  <option value="Mauritius">Mauritius</option>
                                  <option value="Mayotte">Mayotte</option>
                                  <option value="Mexico">Mexico</option>
                                  <option value="Micronesia">Micronesia</option>
                                  <option value="Moldova">Moldova</option>
                                  <option value="Monaco">Monaco</option>
                                  <option value="Mongolia">Mongolia</option>
                                  <option value="Montserrat">Montserrat</option>
                                  <option value="Morrocco">Morocco</option>
                                  <option value="Mozambique">Mozambique</option>
                                  <option value="Myanmar">Myanmar</option>
                                  <option value="Namibia">Namibia</option>
                                  <option value="Nauru">Nauru</option>
                                  <option value="Nepal">Nepal</option>
                                  <option value="Netherlands">Netherlands</option>
                                  <option value="Netherlands Antilles">Netherlands Antilles</option>
                                  <option value="New Caledonia">New Caledonia</option>
                                  <option value="New Zealand">New Zealand</option>
                                  <option value="Nicaragua">Nicaragua</option>
                                  <option value="Niger">Niger</option>
                                  <option value="Nigeria">Nigeria</option>
                                  <option value="Niue">Niue</option>
                                  <option value="Norfolk Islands">Norfolk Island</option>
                                  <option value="Northern Mariana Islands">Northern Mariana Islands</option>
                                  <option value="Norway">Norway</option>
                                  <option value="Oman">Oman</option>
                                  <option value="Pakistan">Pakistan</option>
                                  <option value="Palau">Palau</option>
                                  <option value="Panama">Panama</option>
                                  <option value="Papua New Guinea">Papua New Guinea</option>
                                  <option value="Paraguay">Paraguay</option>
                                  <option value="Peru">Peru</option>
                                  <option value="Philippines">Philippines</option>
                                  <option value="Pitcairn">Pitcairn</option>
                                  <option value="Poland">Poland</option>
                                  <option value="Portugal">Portugal</option>
                                  <option value="Puerto Rico">Puerto Rico</option>
                                  <option value="Qatar">Qatar</option>
                                  <option value="Reunion">Reunion</option>
                                  <option value="Romania">Romania</option>
                                  <option value="Russian Federation">Russian Federation</option>
                                  <option value="Rwanda">Rwanda</option>
                                  <option value="Saint Kitts And Nevis">Saint Kitts And Nevis</option>
                                  <option value="Saint Lucia">Saint Lucia</option>
                                  <option value="Saint Vincent And The Grenadines">Saint Vincent And The Grenadines</option>
                                  <option value="Samoa">Samoa</option>
                                  <option value="San Marino">San Marino</option>
                                  <option value="Sao Tome And Principe">Sao Tome And Principe</option>
                                  <option value="Saudi Arabia">Saudi Arabia</option>
                                  <option value="Scotland">Scotland</option>
                                  <option value="Senegal">Senegal</option>
                                  <option value="Seychelles">Seychelles</option>
                                  <option value="Sierra Leone">Sierra Leone</option>
                                  <option value="Singapore">Singapore</option>
                                  <option value="Slavak Republic">Slovak Republic</option>
                                  <option value="Slovenia">Slovenia</option>
                                  <option value="Solomon Islands">Solomon Islands</option>
                                  <option value="Somalia">Somalia</option>
                                  <option value="South Africa">South Africa</option>
                                  <option value="S. Georgia And S. Sandwich Isls.">S. Georgia And S. Sandwich Isls.</option>
                                  <option value="Spain">Spain</option>
                                  <option value="Sri Lanka">Sri Lanka</option>
                                  <option value="St. Helena">St. Helena</option>
                                  <option value="St. Pierre And Miquelon">St. Pierre And Miquelon</option>
                                  <option value="Sudan">Sudan</option>
                                  <option value="Suriname">Suriname</option>
                                  <option value="Svalbard And Jan Mayen Islands">Svalbard And Jan Mayen Islands</option>
                                  <option value="Swaziland">Swaziland</option>
                                  <option value="Sweden">Sweden</option>
                                  <option value="Switzerland">Switzerland</option>
                                  <option value="Syria">Syria</option>
                                  <option value="Taiwan">Taiwan</option>
                                  <option value="Tajikistan">Tajikistan</option>
                                  <option value="Tanzania">Tanzania</option>
                                  <option selected="selected" value="Thailand">Thailand</option>
                                  <option value="Togo">Togo</option>
                                  <option value="Tokelau">Tokelau</option>
                                  <option value="Tonga">Tonga</option>
                                  <option value="Trinidad And Tobago">Trinidad And Tobago</option>
                                  <option value="Tunisia">Tunisia</option>
                                  <option value="Turkey">Turkey</option>
                                  <option value="Turkmenistan">Turkmenistan</option>
                                  <option value="Turks And Caicos Islands">Turks And Caicos Islands</option>
                                  <option value="Tuvalu">Tuvalu</option>
                                  <option value="Uganda">Uganda</option>
                                  <option value="Ukraine">Ukraine</option>
                                  <option value="United Arab Emirates">United Arab Emirates</option>
                                  <option value="United Kingdom">United Kingdom</option>
                                  <option value="United States">United States</option>
                                  <option value="Us Minor Outlying Islands">Us Minor Outlying Islands</option>
                                  <option value="Uruguay">Uruguay</option>
                                  <option value="Uzbekistan">Uzbekistan</option>
                                  <option value="Vanuatu">Vanuatu</option>
                                  <option value="Vatican City State (holy See)">Vatican City State (holy See)</option>
                                  <option value="Venezuela">Venezuela</option>
                                  <option value="Vietnam">Vietnam</option>
                                  <option value="Virgin Islands (British)">Virgin Islands (British)</option>
                                  <option value="Virgin Islands (US)">Virgin Islands (US)</option>
                                  <option value="Wallis And Futuna Islands">Wallis And Futuna Islands</option>
                                  <option value="Western Sahara">Western Sahara</option>
                                  <option value="Yemen">Yemen</option>
                                  <option value="Yugoslavia">Yugoslavia</option>
                                  <option value="Zaire">Zaire</option>
                                  <option value="Zambia">Zambia</option>
                                  <option value="Zimbabwe">Zimbabwe</option>
                                </select>
                  </div></td></tr>
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
                  <td bgcolor="#F8F8F8"><div align="left"><b><img src="images/skins/building.png" width="16" height="16" border="0" />ข้อมูลที่อยู่สำหรับจัดส่งสินค้า</b></div></td>
                </tr>
                <tr>
                <td><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
                      <tr>
                        <td colspan="2"><div align="left">
                          <input type="checkbox" name="chkCopy2" onclick="textcopy(this.checked)" />
                          ใช้ที่อยู่เดียวกับที่อยู่ปัจจุบัน</div></td>
                      </tr>
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
                        <td >&nbsp;</td>
                        <td ><div align="left">
       
                          <input name="sinterprovince"  id="sinterprovince" value="<%=trim(RS("sinterprovince"))%>" size="15" />
                           International customer please fill in the box. </div></td>
                      </tr>
                      <tr>
                        <td ><div align="right">ประเทศ</div></td>
                        <td >
                          <div align="left">
                            <select name="scountry"  id="select6">
                              <option value="Afghanistan">Afghanistan</option>
                              <option value="Albania">Albania</option>
                              <option value="Algeria">Algeria</option>
                              <option value="American Samoa">American Samoa</option>
                              <option value="Andorra">Andorra</option>
                              <option value="Argentina">Argentina</option>
                              <option value="Armenia">Armenia</option>
                              <option value="Angola">Angola</option>
                              <option value="Anguilla">Anguilla</option>
                              <option value="Antarctic">Antarctica</option>
                              <option value="Antiguq And Barbuda">Antigua And Barbuda</option>
                              <option value="Aruba">Aruba</option>
                              <option value="Australia">Australia</option>
                              <option value="Austria">Austria</option>
                              <option value="Azerbaijan">Azerbaijan</option>
                              <option value="Bahamas">Bahamas</option>
                              <option value="Bahrain">Bahrain</option>
                              <option value="Bangladesh">Bangladesh</option>
                              <option value="Barbados">Barbados</option>
                              <option value="Belarus">Belarus</option>
                              <option value="Belgium">Belgium</option>
                              <option value="Belize">Belize</option>
                              <option value="Benin">Benin</option>
                              <option value="Bermuda">Bermuda</option>
                              <option value="Bhutan">Bhutan</option>
                              <option value="Bolivia">Bolivia</option>
                              <option value="Bosnia And Herzegovina">Bosnia And Herzegovina</option>
                              <option value="Botswana">Botswana</option>
                              <option value="Bouvet Island">Bouvet Island</option>
                              <option value="Brazil">Brazil</option>
                              <option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
                              <option value="Brunei Darussalam">Brunei Darussalam</option>
                              <option value="Bulgaria">Bulgaria</option>
                              <option value="Burkina Faso">Burkina Faso</option>
                              <option value="Burundi">Burundi</option>
                              <option value="Cambodia">Cambodia</option>
                              <option value="Cameroon">Cameroon</option>
                              <option value="Canada">Canada</option>
                              <option value="Cape Verde">Cape Verde</option>
                              <option value="Cayman Islands">Cayman Islands</option>
                              <option value="Central African Republic">Central African Republic</option>
                              <option value="Chad">Chad</option>
                              <option value="Chile">Chile</option>
                              <option value="China">China</option>
                              <option value="Christmas Island">Christmas Island</option>
                              <option value="Cocos (keeling Islands)">Cocos (keeling Islands)</option>
                              <option value="Colombia">Colombia</option>
                              <option value="Comoros">Comoros</option>
                              <option value="Congo">Congo</option>
                              <option value="Cook Islands">Cook Islands</option>
                              <option value="Costa Rica">Costa Rica</option>
                              <option value="Cote D'ivorie (ivory Coast)">Cote D'ivoire (ivory Coast)</option>
                              <option value="Croatia (hrvatska)">Croatia (hrvatska)</option>
                              <option value="Cuba">Cuba</option>
                              <option value="Cyprus">Cyprus</option>
                              <option value="Czech Republic">Czech Republic</option>
                              <option value="Denmark">Denmark</option>
                              <option value="Djibouti">Djibouti</option>
                              <option value="Dominican Republic">Dominican Republic</option>
                              <option value="East Timor">East Timor</option>
                              <option value="Ecuador">Ecuador</option>
                              <option value="Egypt">Egypt</option>
                              <option value="El Salvador">El Salvador</option>
                              <option value="Equatorial Guinea">Equatorial Guinea</option>
                              <option value="Eritrea">Eritrea</option>
                              <option value="Estonia">Estonia</option>
                              <option value="Ethiopia">Ethiopia</option>
                              <option value="Falkland Islands (malvinas)">Falkland Islands (malvinas)</option>
                              <option value="Faroe Islands">Faroe Islands</option>
                              <option value="Fiji">Fiji</option>
                              <option value="Finland">Finland</option>
                              <option value="France">France</option>
                              <option value="France, Metropolitan">France, Metropolitan</option>
                              <option value="French Guiana">French Guiana</option>
                              <option value="French Polynesia">French Polynesia</option>
                              <option value="French Southern Territories">French Southern Territories</option>
                              <option value="Gabon">Gabon</option>
                              <option value="Gambia">Gambia</option>
                              <option value="Georgia">Georgia</option>
                              <option value="Germany">Germany</option>
                              <option value="Ghana">Ghana</option>
                              <option value="Gibraltar">Gibraltar</option>
                              <option value="Greece">Greece</option>
                              <option value="Greenland">Greenland</option>
                              <option value="Grenada">Grenada</option>
                              <option value="Guadeloupe">Guadeloupe</option>
                              <option value="Guam">Guam</option>
                              <option value="Guatemala">Guatemala</option>
                              <option value="Guinea">Guinea</option>
                              <option value="Guinea-bissau">Guinea-bissau</option>
                              <option value="Guyana">Guyana</option>
                              <option value="Haiti">Haiti</option>
                              <option value="Heard And Mcdonald Islands">Heard And Mcdonald Islands</option>
                              <option value="Honduras">Honduras</option>
                              <option value="Hong Kong">Hong Kong</option>
                              <option value="Hungary">Hungary</option>
                              <option value="Iceland">Iceland</option>
                              <option value="India">India</option>
                              <option value="Indonesia">Indonesia</option>
                              <option value="Iran">Iran</option>
                              <option value="Iraq">Iraq</option>
                              <option value="Ireland">Ireland</option>
                              <option value="Israel">Israel</option>
                              <option value="Italy">Italy</option>
                              <option value="Jamaica">Jamaica</option>
                              <option value="Japan">Japan</option>
                              <option value="Jordan">Jordan</option>
                              <option value="Kazakhstan">Kazakhstan</option>
                              <option value="Kenya">Kenya</option>
                              <option value="Kiribati">Kiribati</option>
                              <option value="Korea (north)">Korea (north)</option>
                              <option value="Korea (south)">Korea (south)</option>
                              <option value="Kuwait">Kuwait</option>
                              <option value="Kyrgyzstan">Kyrgyzstan</option>
                              <option value="Laos">Laos</option>
                              <option value="Latvia">Latvia</option>
                              <option value="Lebanon">Lebanon</option>
                              <option value="Lesotho">Lesotho</option>
                              <option value="Liberia">Liberia</option>
                              <option value="Libya">Libya</option>
                              <option value="Liechtenstein">Liechtenstein</option>
                              <option value="Lithuania">Lithuania</option>
                              <option value="Luxembourg">Luxembourg</option>
                              <option value="Macau">Macau</option>
                              <option value="Macedonia">Macedonia</option>
                              <option value="Madagascar">Madagascar</option>
                              <option value="Malawi">Malawi</option>
                              <option value="Malaysia">Malaysia</option>
                              <option value="Maldives">Maldives</option>
                              <option value="Mali">Mali</option>
                              <option value="Malta">Malta</option>
                              <option value="Marshall Islands">Marshall Islands</option>
                              <option value="Martinique">Martinique</option>
                              <option value="Mauritania">Mauritania</option>
                              <option value="Mauritius">Mauritius</option>
                              <option value="Mayotte">Mayotte</option>
                              <option value="Mexico">Mexico</option>
                              <option value="Micronesia">Micronesia</option>
                              <option value="Moldova">Moldova</option>
                              <option value="Monaco">Monaco</option>
                              <option value="Mongolia">Mongolia</option>
                              <option value="Montserrat">Montserrat</option>
                              <option value="Morrocco">Morocco</option>
                              <option value="Mozambique">Mozambique</option>
                              <option value="Myanmar">Myanmar</option>
                              <option value="Namibia">Namibia</option>
                              <option value="Nauru">Nauru</option>
                              <option value="Nepal">Nepal</option>
                              <option value="Netherlands">Netherlands</option>
                              <option value="Netherlands Antilles">Netherlands Antilles</option>
                              <option value="New Caledonia">New Caledonia</option>
                              <option value="New Zealand">New Zealand</option>
                              <option value="Nicaragua">Nicaragua</option>
                              <option value="Niger">Niger</option>
                              <option value="Nigeria">Nigeria</option>
                              <option value="Niue">Niue</option>
                              <option value="Norfolk Islands">Norfolk Island</option>
                              <option value="Northern Mariana Islands">Northern Mariana Islands</option>
                              <option value="Norway">Norway</option>
                              <option value="Oman">Oman</option>
                              <option value="Pakistan">Pakistan</option>
                              <option value="Palau">Palau</option>
                              <option value="Panama">Panama</option>
                              <option value="Papua New Guinea">Papua New Guinea</option>
                              <option value="Paraguay">Paraguay</option>
                              <option value="Peru">Peru</option>
                              <option value="Philippines">Philippines</option>
                              <option value="Pitcairn">Pitcairn</option>
                              <option value="Poland">Poland</option>
                              <option value="Portugal">Portugal</option>
                              <option value="Puerto Rico">Puerto Rico</option>
                              <option value="Qatar">Qatar</option>
                              <option value="Reunion">Reunion</option>
                              <option value="Romania">Romania</option>
                              <option value="Russian Federation">Russian Federation</option>
                              <option value="Rwanda">Rwanda</option>
                              <option value="Saint Kitts And Nevis">Saint Kitts And Nevis</option>
                              <option value="Saint Lucia">Saint Lucia</option>
                              <option value="Saint Vincent And The Grenadines">Saint Vincent And The Grenadines</option>
                              <option value="Samoa">Samoa</option>
                              <option value="San Marino">San Marino</option>
                              <option value="Sao Tome And Principe">Sao Tome And Principe</option>
                              <option value="Saudi Arabia">Saudi Arabia</option>
                              <option value="Scotland">Scotland</option>
                              <option value="Senegal">Senegal</option>
                              <option value="Seychelles">Seychelles</option>
                              <option value="Sierra Leone">Sierra Leone</option>
                              <option value="Singapore">Singapore</option>
                              <option value="Slavak Republic">Slovak Republic</option>
                              <option value="Slovenia">Slovenia</option>
                              <option value="Solomon Islands">Solomon Islands</option>
                              <option value="Somalia">Somalia</option>
                              <option value="South Africa">South Africa</option>
                              <option value="S. Georgia And S. Sandwich Isls.">S. Georgia And S. Sandwich Isls.</option>
                              <option value="Spain">Spain</option>
                              <option value="Sri Lanka">Sri Lanka</option>
                              <option value="St. Helena">St. Helena</option>
                              <option value="St. Pierre And Miquelon">St. Pierre And Miquelon</option>
                              <option value="Sudan">Sudan</option>
                              <option value="Suriname">Suriname</option>
                              <option value="Svalbard And Jan Mayen Islands">Svalbard And Jan Mayen Islands</option>
                              <option value="Swaziland">Swaziland</option>
                              <option value="Sweden">Sweden</option>
                              <option value="Switzerland">Switzerland</option>
                              <option value="Syria">Syria</option>
                              <option value="Taiwan">Taiwan</option>
                              <option value="Tajikistan">Tajikistan</option>
                              <option value="Tanzania">Tanzania</option>
                              <option selected="selected" value="Thailand">Thailand</option>
                              <option value="Togo">Togo</option>
                              <option value="Tokelau">Tokelau</option>
                              <option value="Tonga">Tonga</option>
                              <option value="Trinidad And Tobago">Trinidad And Tobago</option>
                              <option value="Tunisia">Tunisia</option>
                              <option value="Turkey">Turkey</option>
                              <option value="Turkmenistan">Turkmenistan</option>
                              <option value="Turks And Caicos Islands">Turks And Caicos Islands</option>
                              <option value="Tuvalu">Tuvalu</option>
                              <option value="Uganda">Uganda</option>
                              <option value="Ukraine">Ukraine</option>
                              <option value="United Arab Emirates">United Arab Emirates</option>
                              <option value="United Kingdom">United Kingdom</option>
                              <option value="United States">United States</option>
                              <option value="Us Minor Outlying Islands">Us Minor Outlying Islands</option>
                              <option value="Uruguay">Uruguay</option>
                              <option value="Uzbekistan">Uzbekistan</option>
                              <option value="Vanuatu">Vanuatu</option>
                              <option value="Vatican City State (holy See)">Vatican City State (holy See)</option>
                              <option value="Venezuela">Venezuela</option>
                              <option value="Vietnam">Vietnam</option>
                              <option value="Virgin Islands (British)">Virgin Islands (British)</option>
                              <option value="Virgin Islands (US)">Virgin Islands (US)</option>
                              <option value="Wallis And Futuna Islands">Wallis And Futuna Islands</option>
                              <option value="Western Sahara">Western Sahara</option>
                              <option value="Yemen">Yemen</option>
                              <option value="Yugoslavia">Yugoslavia</option>
                              <option value="Zaire">Zaire</option>
                              <option value="Zambia">Zambia</option>
                              <option value="Zimbabwe">Zimbabwe</option>
                            </select>
                          </div>                       </td>
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
                  <td height="29" bgcolor="#F8F8F8">
                  <div align="left"><b><img src="images/skins/email.png" width="16" height="16" border="0" />&nbsp;Enewsletter</b></div></td>
          </tr>
                <tr>
                  <td height="34"><table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
                    <tr>
                      <td width="39%" height="26" ><div align="right">ต้องการรับข่าวสารทาง Email หรือไม่ </div></td>
<td width="61%" ><div align="left">&nbsp;
                          <input name="information" type="radio" value="0" checked="checked" />
ต้องการ &nbsp;
<input name="information" type="radio" value="1" />
ไม่ต้องการ</div></td>
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
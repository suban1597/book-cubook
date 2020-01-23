
<form id="form1" name="form1" method="post" action="insert_kidaccount.asp">
  <table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
    <tr>
      <td colspan="5"><div align="left">น้องๆที่มีความประสงค์จะสมัครเป็นสมาชิกเมืองเด็กกับศูนย์หนังสือจุฬาฯ กรุณากรอกรายละเอียดให้ครบถ้วน<br />
        แล้วกดปุ่ม <span class="bluetext"><b>&quot;ยืนยันการสมัคร&quot;</b></span> หากยังไม่ประสงค์ที่จะสมัครตอนนี้ <a href="kids.asp" class="orangetext"><b>คลิกที่นี่ค่ะ</b></a><br />
        <br />
      </div></td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td height="32" colspan="5"><div align="left"><b>ข้อมูลส่วนตัว</b>(โปรดกรอกข้อมูลจริงเพื่อประโยชน์ของตัวน้องๆเองนะคะ) </div></td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td height="32" colspan="5"><div align="left">ชื่อ/นามสกุล(ภาษาไทย) *&nbsp;&nbsp;
              <input name="bname" type="text" id="bname" tabindex="1" size="20" maxlength="50" />
        ชื่อเล่น
        <label>
          <input name="nicname" type="text" id="nicname" size="8" />
          </label>
        <br />
      </div></td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td height="23" colspan="5"><div align="left">วัน/เดือน/ปีเกิด
        <input name="birthdate" type="text" tabindex="2" value="<%=date()%>" size="8" maxlength="15" />
        เพศ
        <label>
          <input name="gender" type="radio" value="0" checked="checked" />
          ชาย </label>
        <label>
          <input name="gender" type="radio" value="1" />
          หญิง </label>
      </div></td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td height="23" colspan="5"><div align="left"> สถานศึกษา
        <input name="school" type="text" id="school" tabindex="11" size="8" maxlength="50" />
        ชั้นปีที่
        <input name="grade" type="text" id="grade" tabindex="9" size="2" />
        <br />
      </div></td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td colspan="5"><div align="left">ชื่อผู้ปกครอง
        <input name="parent" type="text" id="parent" tabindex="4" size="10" />
        &nbsp;เบอร์โทรศัพท์&nbsp;
        <label>
          <input name="par_phone" type="text" id="par_phone" size="12" />
          </label>
      </div></td>
    </tr>
    <tr>
      <td colspan="5">&nbsp;</td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td colspan="5"><div align="left"><b>สถานที่ติดต่อ</b>(โปรดกรอกข้อมูลโดยละเอียดเพื่อประโยชน์ของตัวน้องๆเองนะคะ) </div></td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td colspan="5"><div align="left">ตึก/อาคาร/หมู่บ้าน
        <input name="building" type="text" tabindex="15" size="20" maxlength="50" />
              <br />
        บ้านเลขที่ <big>*</big>&nbsp;&nbsp;&nbsp;
        <input name="mem_addr1" type="text" tabindex="16" size="5" maxlength="10" />
        หมู่ที่
        <input name="moo" type="text" id="moo" tabindex="17" size="3"maxlength="2" />
        ตรอก/ซอย
        <input name="soi" type="text" id="soi" tabindex="18" size="10" maxlength="40" />
        ถนน <big>*</big>&nbsp;&nbsp;
        <input name="road" type="text" id="road" tabindex="19" size="10" maxlength="50" />
        <br />
        แขวง/ตำบล&nbsp;&nbsp;
        <input name="tum" type="text" id="tum" tabindex="20" size="10" maxlength="50" />
        เขต/อำเภอ<big>*</big>&nbsp;&nbsp;
        <input name="aum" type="text" id="aum" tabindex="21" size="10" maxlength="50" />
        <br />
        จังหวัด <big>*</big>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="province" type="text" id="province" tabindex="22" size="10" maxlength="50" />
        รหัสไปรษณีย ์ <big>*</big>&nbsp;&nbsp;
        <input name="zip" type="text" id="zip" tabindex="23" size="6" maxlength="5" />
      </div></td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td colspan="5"><div align="left">โทรศัพท์ <big>*</big>&nbsp;&nbsp;
              <input name="mem_phone" type="text" tabindex="24" size="10" maxlength="15" />
        โทรสาร
        <input name="fax" type="text" tabindex="25" size="10" maxlength="15" />
      </div></td>
    </tr>
    <tr bgcolor="#F4F4F4">
      <td colspan="5"><div align="left">e-mail <big>*</big>&nbsp;&nbsp;
              <input name="email" type="text" tabindex="26" size="20" maxlength="40" />
        มือถือ
        <input name="mobie" type="text" id="mobie" tabindex="27" size="10" maxlength="15" />
      </div></td>
    </tr>
    <tr bgcolor="#F4F4F4" color="#F6C188">
      <td width="30%"><div align="left">กิจกรรมที่น้องๆต้องการให้เราจัด </div></td>
      <td width="70%" colspan="4"><div align="left">
        <input name="activity" type="text" tabindex="41" size="25" />
      </div></td>
    </tr>
    <tr bgcolor="#F4F4F4" color="#F6C188">
      <td width="30%" align="left" valign="top"><div align="left">ข้อเสนอแนะสำหรับ บ้านเด็ก </div></td>
      <td colspan="4" bgcolor="#F4F4F4"><div align="left">
        <textarea rows="2" name="comment" cols="40"></textarea>
      </div></td>
    </tr>
    <tr>
      <td colspan="5"><div align="center"><br />
            <span class="orangetext">ข้าพเจ้าขอรับรองว่าข้อความในใบสมัครนี้เป็นความจริงทุกประการ <br />
                และยินดีปฏิบัติตามเงื่อนไขการเป็นสมาชิกบ้านเด็กของศูนย์หนังสือจุฬาฯ <br /></span>
        <br />
      </div></td>
    </tr>
    <tr>
      <td colspan="5" align="center"><input type="submit" value="ยืนยันการสมัคร" name="Submit" />
          <%mypostdate =now()%>
          <input name="regisdate" type="hidden" id="regisdate" value="<%=mypostdate%>" />
          <input name="kidstatus" type="hidden" id="kidstatus" value="0" /></td>
    </tr>
  </table>
</form>

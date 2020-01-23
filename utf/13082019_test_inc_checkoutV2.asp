<!--Check Form Value  -->
<script type = "text/javascript" src="http://www.chulabook.com/utf/foul.js"></script>
<script type="text/javascript">
		foul.when('~PaymentMethod~ is null','กรุณาเลือกวิธีการชำระเงิน');
</script>
<!--End Check Form Value  -->
<!--#include file="..\includes\sqlinjection.asp"-->
<%
Session("PaymentMethod") = Request.Form("PaymentMethod")

'response.Write Session("UserID")

Set RS = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT UserID,BName,BAddress,Bplace,SName,bnum,bmoo,bbuilding,bsoi,broad,Btumbon,BCity,BAddress,BZip,BProvince,BCountry,SName,SAddress,splace,SName,snum,sbuilding,ssoi,sroad,Stumbon,SCity,SAddress,SZip,SProvince,SCountry,statusupdate FROM account WHERE (UserID ='" & Session("UserID") & "')"
RS.Open Sql,conn,1,3

Set RS_province2 = Server.CreateObject("ADODB.RecordSet")
Sql_province2 = "SELECT TH_NAME, PROVINCE_CODE FROM province2 WHERE (PROVINCE_CODE='" &province& "') "
RS_province2.Open Sql_province2,conn,1,3
%>
    <form>
    <!--form id="form1" name="form1" method="post" onsubmit="return(foul.validate(this))" action="../final1V2.asp"-->
    <!--form id="form1" name="form1" method="post" onsubmit="return(foul.validate(this))" action="../final_ebook.asp"-->
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
        <p align="center"><!--img src="http://www.chulabook.com/images/tax_banner04052562.jpg" width="530" border="0" /--></p>
  </tr>
  <!-- Tax Break -->
  <% if status_tax = 1 Then %>
  <tr>
    <td>
      <table cellpadding="2" cellspacing="2" width="90%" valign="top">
        <tr>
          <td colspan="2" bgcolor="#EFEFEF" >
          <div align="left" class="big-text"><strong> ข้อมูลการออกใบเสร็จลดหย่อนภาษี</strong></div>
            <div align="left">
              <span class="style1">
                <div class="text"><% response.Write " ชื่อ - นามสกุล: "&contact_name %></div>
                <div class="text"><% response.Write " เลขที่บัตรประชาชน: "&cardid %></div>
                <div class="text"><% response.Write " เบอร์โทร: "&phone_nbr&" ,"&mobile_nbr %></div>
                <div class="text"><% response.Write " ชื่อสถานที่: "&add_placename %></div>
                <div class="text"><% response.Write " ที่อยู่: เลขที่ "&add_number&" หมู่ที่ "&add_moo&" ตึก/อาคาร/หมู่บ้าน "&add_place&" ซอย"&add_soi&" ถนน"&add_street&" แขวง"&add_district&" เขต"&amphur_name&" จังหวัด"& RS_province2("TH_NAME")&" รหัสไปรษณีย์"&zipcode %></div>
                <div class="text"><% response.Write " หมายเหตุ: "&note %></div>
                <input type="hidden" name="cardid" value="<% response.Write cardid %>" />
                <input type="hidden" name="add_number" value="<% response.Write add_number %>" />
                <input type="hidden" name="add_placename" value="<% response.Write add_placename %>" />
                <input type="hidden" name="add_place" value="<% response.Write add_place %>" />
                <input type="hidden" name="add_moo" value="<% response.Write add_moo %>" />
                <input type="hidden" name="add_soi" value="<% response.Write add_soi %>" />
                <input type="hidden" name="add_street" value="<% response.Write add_street %>" />
                <input type="hidden" name="add_district" value="<% response.Write add_district %>" />
                <input type="hidden" name="amphur_name" value="<% response.Write amphur_name %>" />
                <input type="hidden" name="province" value="<% response.Write province %>" />
                <input type="hidden" name="zipcode" value="<% response.Write zipcode %>" />
                <input type="hidden" name="phone_nbr" value="<% response.Write phone_nbr %>" />
                <input type="hidden" name="mobile_nbr" value="<% response.Write mobile_nbr %>" />
                <input type="hidden" name="contact_name" value="<% response.Write contact_name %>" />
                <input type="hidden" name="status_tax" value="<% response.Write status_tax %>" />
                <input type="hidden" name="note" value="<% response.Write note %>" />
              </span>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <% end if %>
  <!-- Tax Break -->
  <tr>
    <td class="big-text">
    <div align="left"><strong><img src="images/icons/money.png" width="16" height="16" /> เลือกวิธีการชำระเงิน [Select Your Payment]</strong></div></td>
  </tr>
  <tr>
    <td class="blacktext">
      <div align="left">
  <% if Session("delivery")=1 and chk_bar1 ="" Then %>
        <input name="PaymentMethod" type="radio" value="1" />
        <font class="text">เก็บเงินสดปลายทาง มีเจ้าหน้าที่จัดส่งถึงบ้าน (เฉพาะกรุงเทพฯ) เขตที่สามารถจัดส่งได้<a href="howtosend.asp" target="_blank">คลิกที่นี่</a><br />
          </font>
        <input name="PaymentMethod" type="radio" value="2" />
        <font class="text">บัตรเครดิต<br />
          </font>
        <input name="PaymentMethod" type="radio" value="3" />
        <font class="text">แฟกซ์-บัตรเครดิต<br />
          </font>
        <input name="PaymentMethod" type="radio" value="4" />
        <font class="text">โอนเงินผ่านธนาคาร</font><font class="text"><br />
        </font>
        <input name="PaymentMethod" type="radio" value="7"/>
        <font class="text">QR Code</font><font class="text"><br />
        </font>
        <!--input name="PaymentMethod" type="radio" value="6" />
        <font class="text">ธนาณัติ- ตั๋วแลกเงิน</font> </div--><br>
  <% else %>
        <input name="PaymentMethod" type="radio" value="2" />
        <font class="text">บัตรเครดิต<br />
          </font>
        <input name="PaymentMethod" type="radio" value="3" />
        <font class="text">แฟกซ์-บัตรเครดิต<br />
          </font>
        <input name="PaymentMethod" type="radio" value="4" />
        <font class="text">โอนเงินผ่านธนาคาร</font><font class="text"><br />
        </font>
        <input name="PaymentMethod" type="radio" value="7"/>
        <font class="text">QR Code</font><font class="text"><br />
        </font>
        <!--input name="PaymentMethod" type="radio" value="6" />
        <font class="text">ธนาณัติ- ตั๋วแลกเงิน</font> </div--><br>
    <% end if%>
          <!--div align="left"><strong>หมายเหตุ: </strong></div>
          <div id="clickme2">
            <input name="first_remark_radio" type="radio" value="0" checked="checked"> ไม่มี 
          </div>
          <div id="clickme">
            <input name="first_remark_radio" type="radio" value="1"> ที่อยู่ในการออกใบเสร็จ / อื่นๆ 
          </div>
          <div id="div1">
            <textarea rows="4" cols="50" name="first_remark"></textarea>
          </div>
          <br-->
        
        <% 'if is_ebook = 1 then %>
        <table cellpadding="2" cellspacing="2" bgcolor="#c56182" >
                    <tr>
                      <td colspan="2" bgcolor="#ECE9D8" ><div align="center"><span class="style1">*** สำหรับสินค้าจอง กรุณาชำระเงินตามเวลาที่กำหนด
            </span></div></td>
                    </tr>
        </table><br>       
        <table cellpadding="2" cellspacing="2" bgcolor="#c56182" >
                    <tr>
                      <td colspan="2" bgcolor="#ECE9D8" ><div align="center"><span class="style1">*** กรณีที่ลูกค้า มีรายการสั่งซื้อ E-book จะสามารถชำระเงินผ่านช่่องทางบัตรเครดิตได้เท่านั้น
					  </span></div></td>
                    </tr>
		    </table><br>  
        <!--img src="../images/news/songkran2014.jpg" /--> 
        <%'end if %>
        
      <p align="left">
     <%  if RS("BAddress") <> "" then %>
        <input type="image" name="Submit" value="confirm" src="images/button/confirmorder.gif"  border="0" />
     <% else %>
     	<!--input type="text" value="กรุณาแก้ไขข้อมูลส่วนตัวก่อนทำการสั่งซื้อด้วยค่ะ" /-->
        <table cellpadding="2" cellspacing="2" bgcolor="#c56182" >
                    <tr>
                      <td colspan="2" bgcolor="#ECE9D8" ><div align="center"><span class="style1">*** เนื่องจากข้อมูลของลูกค้า ไม่ครบตามที่ระบบต้องการ  <br>
ดังนั้น จึงขอรบกวนลูกค้าทำการแก้ไข ที่อยู่ปัจจุบัน และที่อยู่ที่จัดส่งให้ตรงตามแบบฟอร์มด้านล่าง ก่อนทำการสั่งซื้อสินค้าด้วยนะคะ
					  </span></div></td>
                    </tr>                    
		</table>                           
     <% end if%>
      </p>
    </form></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
  <tr>
    <td><div align="left">
    <p align="center"><img src="http://www.chulabook.com/images/bannerQR CODE19032018.jpg" width="530" border="0" /></p>
      <!--p align="center"><a href="http://www.ktc.co.th/shoponline" target="_blank"><img src="http://www.chulabook.com/images/002_ktc19062017.jpg" width="530" border="0" /></a></p-->
      <p><b><img src="images/icons/money.png" width="16" height="16" />สำหรับท่านที่เลือกชำระเงินเป็นแบบ ธนาณัติ- ตั๋วแลกเงิน</b>
          <br />
          - โดยสั่งจ่าย ปท.จุฬาลงกรณ์มหาวิทยาลัย ในนาม &quot;ศูนย์หนังสือจุฬาลงกรณ์มหาวิทยาลัย&quot; ถนนพญาไท ปทุมวัน กรุงเทพฯ 10332<br />
        - และจ่าหน้าซองถึง ศูนย์หนังสือจุฬาลงกรณ์มหาวิทยาลัย ถนน พญาไท เขต ปทุมวัน กทม.10330(วงเล็บมุมซองว่า สั่งซื้อทางอินเตอร์เนต + หมายเลขอ้างอิงการสั่งซื้อ) <br />
        <br />
        <b><img src="images/icons/money.png" width="16" height="16" />สำหรับท่านที่เลือกชำระเงินเป็นแบบ โอนเงินผ่านธนาคาร</b><br />
      </p>
      <table width="95%" border="0" cellspacing="2" cellpadding="2" class="blacktext">
        <tr>
          <td colspan="3">โอนเข้าบัญชี  ชื่อบัญชี &quot;ศูนย์หนังสือจุฬาลงกรณ์มหาวิทยาลัย&quot; 
      มี 4 ธนาคารให้เลือก</td>
          </tr>
        <tr>
          <td width="24%">ธนาคารไทยพาณิชย์ </td>
          <td width="21%">สาขาสุรวงษ์</td>
          <td width="55%">บัญชีเลขที่ 002-2-08292-3 </td>
        </tr>
        <tr>
          <td>ธนาคารกสิกรไทย</td>
          <td>สาขาสยามสแควร์</td>
          <td>บัญชีเลขที่ 026-2-42844-3 </td>
        </tr>
        <tr>
          <td>ธนาคารกรุงเทพ</td>
          <td>สาขาสยามสแควร์ </td>
          <td>บัญชีเลขที่ 152-0-91525-5 </td>
        </tr>
        <tr>
          <td>ธนาคารกรุงไทย</td>
          <td>สาขาสยามสแควร์</td>
          <td>บัญชีเลขที่ 052-1-25100-1</td>
        </tr>
      </table>
      </div></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="text">
  <tr>
    <td width="100%" colspan="2"  ><div align="left"><b><img src="images/icons/45.png" width="16" height="16" />ชื่อและที่อยู่ของลูกค้า</b></div></td>
  </tr>
  <tr>
    <td colspan="2"><table width="85%" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td width="27%"><div align="right">ชื่อลูกค้า :</div></td>
        <td width="73%"><div align="left"><%=RS("BName")%></div></td>
        </tr>
      <tr>
        <td><div align="right">ที่อยู่ (เดิม): </div></td>
        <td><div align="left"><%=RS("BAddress")%></div></td>
        </tr>
      <tr>
        <td><div align="right">&#3594;&#3639;&#3656;&#3629;&#3626;&#3606;&#3634;&#3609;&#3607;&#3637;&#3656;  :</div></td>
        <td><div align="left"><%=RS("Bplace")%>
              <% Session("SName")=RS("SName")%>
        </div></td>
      </tr>
      <tr>
        <td><div align="right">เลขที่  :</div></td>
        <td><div align="left"><%=RS("bnum")%>&nbsp;หมู่ที่&nbsp;<%=RS("bmoo")%></div></td>
      </tr>
      <tr>
        <td><div align="right">ตึก/อาคาร/หมู่บ้าน  :</div></td>
        <td><div align="left"><%=RS("bbuilding")%></div></td>
      </tr>
      <tr>
        <td><div align="right">ตรอก/ซอย  :</div></td>
        <td><div align="left"><%=RS("bsoi")%>&nbsp;&nbsp;</div></td>
      </tr>
      <tr>
        <td><div align="right">ถนน  :</div></td>
        <td><div align="left"><%=RS("broad")%></div></td>
      </tr>
      <tr>
        <td><div align="right">ตำบล/แขวง  :</div></td>
        <td><div align="left"><%=RS("Btumbon")%></div></td>
      </tr>
      <tr>
        <td><div align="right">อำเภอ/เขต  :</div></td>
        <td><div align="left"><%=RS("BCity")%></div></td>
      </tr>
      <tr>
        <td><div align="right">จังหวัด :</div></td>
        <td><div align="left">
          <%
				Sql_province2 = "SELECT * FROM province2 WHERE PROVINCE_CODE like "&RS("BProvince")&" "
				Set RS_province2 = Server.CreateObject("ADODB.RecordSet")
				RS_province2.Open Sql_province2,conn,1,3
				response.Write RS_province2("TH_NAME")
		%>
          <% Session("BAddress")=RS("BAddress")%>
        </div></td>
      </tr>
      <tr>
        <td><div align="right">รหัสไปรษณีย์ :</div></td>
        <td><div align="left"><%=RS("BZip")%>
            <% Session("BProvince")=RS("BProvince")%>
        </div></td>
      </tr>
      <tr>
        <td><div align="right">ประเทศ :</div></td>
        <td><div align="left"><%=RS("BCountry")%>
              <% Session("BZip")=RS("BZip")%>
</div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><div align="right"><a href="profile.asp" class="text"><img src="images/skins/building_edit.png" width="16" height="16" border="0" />แก้ไขข้อมูลส่วนตัว ที่นี่</a></div></td>
      </tr>
      
      
    </table></td>
  </tr>
  <%If RS("statusupdate") <> 1 then%>
  <%End if%>
</table>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2" class="blacktext">
  <tr>
    <td width="100%"><div align="left"><b><img src="images/icons/lorry.png" width="16" height="16" />ชื่อและที่อยู่ที่จัดส่งสินค้า</b></div></td>
  </tr>
  <tr>
    <td><table width="85%" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td width="27%"><div align="right">ชื่อลูกค้า :</div></td>
        <td width="73%"><div align="left"><%=RS("SName")%></div></td>
      </tr>
      <tr>
        <td><div align="right">ที่อยู่ (เดิม): </div></td>
        <td><div align="left"><%=RS("SAddress")%></div></td>
      </tr>
      <tr>
        <td><div align="right">&#3594;&#3639;&#3656;&#3629;&#3626;&#3606;&#3634;&#3609;&#3607;&#3637;&#3656;  :</div></td>
        <td><div align="left"><%=RS("splace")%>
              <% Session("SName")=RS("SName")%>
        </div></td>
      </tr>
      <tr>
        <td><div align="right">เลขที่  :</div></td>
        <td><div align="left"><%=RS("snum")%>&nbsp;หมู่ที่&nbsp;<%=RS("smoo")%></div></td>
      </tr>
      <tr>
        <td><div align="right">ตึก/อาคาร/หมู่บ้าน  :</div></td>
        <td><div align="left"><%=RS("sbuilding")%></div></td>
      </tr>
      <tr>
        <td><div align="right">ตรอก/ซอย  :</div></td>
        <td><div align="left"><%=RS("ssoi")%>&nbsp;&nbsp;</div></td>
      </tr>
      <tr>
        <td><div align="right">ถนน  :</div></td>
        <td><div align="left"><%=RS("sroad")%></div></td>
      </tr>
      <tr>
        <td><div align="right">ตำบล/แขวง  :</div></td>
        <td><div align="left"><%=RS("Stumbon")%></div></td>
      </tr>
      <tr>
        <td><div align="right">อำเภอ/เขต  :</div></td>
        <td><div align="left"><%=RS("SCity")%></div></td>
      </tr>
      <tr>
        <td><div align="right">จังหวัด :</div></td>
        <td><div align="left">
          <%
				Sql_sprovince2 = "SELECT * FROM province2 WHERE PROVINCE_CODE like "&RS("SProvince")&" "
				Set RS_sprovince2 = Server.CreateObject("ADODB.RecordSet")
				RS_sprovince2.Open Sql_sprovince2,conn,1,3
				response.Write RS_sprovince2("TH_NAME")
				%>
          <% Session("SAddress")=RS("SAddress")%>
        </div></td>
      </tr>
      <tr>
        <td><div align="right">รหัสไปรษณีย์ :</div></td>
        <td><div align="left"><%=RS("SZip")%>
              <% Session("SProvince")=RS("SProvince")%>
        </div></td>
      </tr>
      <tr>
        <td><div align="right">ประเทศ :</div></td>
        <td><div align="left"><%=RS("SCountry")%>
              <% Session("SZip")=RS("SZip")%>
        </div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><div align="right"><a href="profile.asp" class="text"><img src="images/skins/building_edit.png" width="16" height="16" border="0" />แก้ไขข้อมูลการจัดส่ง ที่นี่</a></div></td>
      </tr>
    </table></td>
  </tr>
  <%If RS("statusupdate") <> 1 then%>
  <%End If%>
</table>

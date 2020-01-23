<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><!DOCTYPE html> 
<!--#include file="../utf/connectdb.asp"-->
<html> 
	<head> 
	<title>Chulabook.com mobile</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.css" />
	<script src="http://code.jquery.com/jquery-1.4.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.js"></script>
    <%
	session("bname") = request("bname")
	session("bphone") = request("bphone")
	session("bplace") = request("bplace")
	session("bnum") = request("bnum")
	session("bmoo") = request("bmoo")
	session("bbuilding") = request("bbuilding")
	session("bsoi") = request("bsoi")
	session("broad") = request("broad")
	session("btumbon") = request("btumbon")
	session("bamphur") = request("bamphur")
	session("bprovince") = request("bprovince")
	session("bzip") = request("bzip")
 	%>
</head> 
<body> 


<%
theme_id = "c"
theme_list_id = "d"
td_width = 130

%>


<div data-role="page">

	<div data-role="header" data-theme="<%=theme_id%>">
		<h1>สมัครสมาชิก</h1>
	</div><!-- /header -->

	<div data-role="content">	
  
   <div data-role="fieldcontain">     
<form action="insert-register.asp" method="post">

<b>ขั้นตอนที่ 3/3</b>
<br>ที่อยู่สำหรับจัดส่ง<br><br>
<p> 
<fieldset class="ui-grid-a">
	<div class="ui-block-a" style="width:<%=td_width%>px">ชื่อ-นามสกุล</div>
	<div class="ui-block-b">
	  <input name="sname" type="text" id="sname" value="" width="200px"/>
	</div>	   

	<div class="ui-block-a" style="width:<%=td_width%>px">เบอร์โทรศัพท์</div>
	<div class="ui-block-b">    <input name="sphone" type="text" id="sphone" value="" width="200px"/>
	</div>	 
	  	
	<div class="ui-block-a" style="width:<%=td_width%>px">ชื่อสถานที่</div>
	<div class="ui-block-b">  <input name="splace" type="text" id="splace" value="" size="2" width="200px"/>
	</div>	   

	<div class="ui-block-a" style="width:<%=td_width%>px">เลขที่</div>
	<div class="ui-block-b">    <input name="snum" type="text" id="snum" value="" width="200px"/>
	</div>	
	
	<div class="ui-block-a" style="width:<%=td_width%>px">หมู่</div>
	<div class="ui-block-b">  <input name="smoo" type="text" id="smoo" value="" size="2" width="200px"/>
	</div>	   

	<div class="ui-block-a" style="width:<%=td_width%>px">ตึก/อาคาร/หมู่บ้าน</div>
	<div class="ui-block-b">    <input name="sbuilding" type="text" id="sbuilding" value="" width="200px"/>
	</div>	   	
	   	
	<div class="ui-block-a" style="width:<%=td_width%>px">ตรอก/ซอย</div>
	<div class="ui-block-b">  <input name="ssoi" type="text" id="ssoi" value="" size="2" width="200px"/>
	</div>	   

	<div class="ui-block-a" style="width:<%=td_width%>px">ถนน</div>
	<div class="ui-block-b">    <input name="sroad" type="text" id="sroad" value="" width="200px"/>
	</div>	
	
	<div class="ui-block-a" style="width:<%=td_width%>px">ตำบล/แขวง</div>
	<div class="ui-block-b">  <input name="stumbon" type="text" id="stumbon" value="" size="2" width="200px"/>
	</div>	
    
    <div class="ui-block-a" style="width:<%=td_width%>px">อำเภอ/เขต</div>
	<div class="ui-block-b">  <input name="samphur" type="text" id="btumbon" value="" size="2" width="200px"/>
	</div>	 
    
    <%
	Set RS_Province = Server.CreateObject("ADODB.RecordSet")
	Sql_Province = "SELECT  * FROM province2 WHERE country_code like 'TH' order by province_code"
	RS_Province.Open Sql_Province,conn,1,3
	%>
    <div class="ui-block-a" style="width:<%=td_width%>px">จังหวัด</div>
	<div class="ui-block-b"><select name="sprovince" id="sprovince">
     <%Do While not RS_Province.EOF%>
      <option value="v"><%=RS_Province("TH_NAME")%></option>        
	<%
	RS_Province.movenext
	Loop
	%>
    </select>  
    </div>

	<div class="ui-block-a" style="width:<%=td_width%>px">รหัสไปรษณีย์</div>
	<div class="ui-block-b">    <input name="szip" type="text" id="szip" value="" width="200px"/>
	</div>	   			
	
</fieldset>

  
 <input name="action" type="submit" id="action" value="ขั้นตอนถัดไป" data-icon="arrow-r" data-iconpos="right"/>
 
  </p>

  </form>
     </div>   
     
     

	
	</div><!-- /content -->

</div><!-- /page -->




</body>
</html>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="../utf/connect_db.asp"--> 
	<title>เกี่ยวกับเรา</title> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--#include file="googleanalytics.asp"-->
    <style type="text/css">
<!--
.style1 {font-size: 14px}
-->
    </style>
</head> 
<body> 
<!--#include file="inc_tabbar.asp"-->
<table width="300" border="0">
    <tr>
      <td><img alt="" src="http://www.chulabook.com/m/images/bu.jpg" /><br />
          <br />
          <span class="style1"><strong>สาขามหาวิทยาลัยบูรพา</strong><br />
อาคารศูนย์กิจการนิสิต มหาวิทยาลัย ต.แสนสุข อ.เมือง จ.ชลบุรี 20131<br />
โทร.0-3839-4855-9 แฟกซ์ 0-3839-3239<br /> 
เวลาเปิดบริการ  : จันทร์-ศุกร์ เวลา 08.30-19.00 น.<br />
เสาร์ - อาทิตย์ เวลา 09.00 - 15.00 น. หยุดวันนักขัตฤกษ์<br />
<br />
      </span></td>
 </tr>
  </table>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript">
function initialize() {
  var mapDiv = document.getElementById('map-canvas');
  var latLng = new google.maps.LatLng(13.286042, 100.925093);
  var map = new google.maps.Map(mapDiv, {
    center: latLng,
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var image = 'http://code.google.com/apis/maps/documentation/javascript/examples/images/beachflag.png';
  var myLatLng = new google.maps.LatLng(13.286042, 100.925093);
  var beachMarker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: image
  });
  
  var infoWindow = new google.maps.InfoWindow({
    position: map.getCenter(),
    content: 'ศูนย์หนังสือจุฬาฯ สาขามหาวิทยาลัยบูรพา'
  });
  infoWindow.open(map);
}
   

      google.maps.event.addDomListener(window, 'load', initialize);
    </script>
  
<div id="map-canvas" style="width: 290px; height: 290px"></div>
	<!--#include file="inc_footer.asp"-->

</body>
</html>
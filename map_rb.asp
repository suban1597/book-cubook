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
      <td><img alt="" src="http://www.chulabook.com/m/images/open_rt.jpg" /><br />
          <br />
          <span class="style1"><strong>สาขารัตนาธิเบศร์</strong><br />
อาคาร Hobby Lobby 49/157 ถ.รัตนาธิเบศร์ ต.บางกระสอ อ.เมือง จ. นนทบุรี 11000<br />
โทร.0-2950-5408-9 แฟ็กซ์ 0-2950-5405<br />
เปิดบริการทุกวัน ตั้งแต่เวลา 10.00 น. - 18.30 น.<br />
<br />
      </span></td>
 </tr>
  </table>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript">
function initialize() {
  var mapDiv = document.getElementById('map-canvas');
  var latLng = new google.maps.LatLng(13.858455, 100.51854);
  var map = new google.maps.Map(mapDiv, {
    center: latLng,
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var image = 'http://code.google.com/apis/maps/documentation/javascript/examples/images/beachflag.png';
  var myLatLng = new google.maps.LatLng(13.858455, 100.51854);
  var beachMarker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: image
  });
  
  var infoWindow = new google.maps.InfoWindow({
    position: map.getCenter(),
    content: 'ศูนย์หนังสือจุฬาฯ สาขารัตนาธิเบศร์'
  });
  infoWindow.open(map);
}
   

      google.maps.event.addDomListener(window, 'load', initialize);
    </script>
  
<div id="map-canvas" style="width: 290px; height: 290px"></div>
	<!--#include file="inc_footer.asp"-->

</body>
</html>
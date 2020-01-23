<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<!--#include file="connect_db.asp"--> 
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
      <td><img alt="" src="http://www.chulabook.com/m/images/open_jpl.jpg" /><br />
          <br />
          <span class="style1"><strong>สาขาโรงเรียนนายร้อยพระจุลจอมเกล้า (รร.จปร.)</strong><br />
อาคารสาระสโมสร โรงเรียนนายร้อยพระจุลจอมเกล้า ต.พรหมมณี อ.เมือง จ.นครนายก 26001<br />
โทร.037-393-023, 037-393-036 <br />
แฟกซ์ 037-393-036<br /> 
เวลาเปิดบริการ  : จันทร์ - ศุกร์ เวลา08.30-17.00 น.<br />
เสาร์ เวลา 09.00 - 15.00 น. <br />
หยุดวันอาทิตย์-วันนักขัตฤกษ์<br />
<br />
      </span></td>
 </tr>
  </table>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript">
function initialize() {
  var mapDiv = document.getElementById('map-canvas');
  var latLng = new google.maps.LatLng(14.298419, 101.17404);
  var map = new google.maps.Map(mapDiv, {
    center: latLng,
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var image = 'http://code.google.com/apis/maps/documentation/javascript/examples/images/beachflag.png';
  var myLatLng = new google.maps.LatLng(14.298419, 101.17404);
  var beachMarker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: image
  });
  
  var infoWindow = new google.maps.InfoWindow({
    position: map.getCenter(),
    content: 'ศูนย์หนังสือจุฬาฯ สาขาโรงเรียนนายร้อยพระจุลจอมเกล้า (รร.จปร.)'
  });
  infoWindow.open(map);
}
   

      google.maps.event.addDomListener(window, 'load', initialize);
    </script>
  
<div id="map-canvas" style="width: 290px; height: 290px"></div>
	<!--#include file="inc_footer.asp"-->

</body>
</html>
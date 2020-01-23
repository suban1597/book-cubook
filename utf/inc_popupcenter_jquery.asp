<html>
<body>
<script type="text/javascript">
jQuery(function(){
    var screenHeight=jQuery(window).height();  //ดึงค่าความสูงของ browser
    jQuery('.adv').each(function(){ // จะ loop ที่ tag ที่ใช้ class="adv" จนครบ
        var adv_height=jQuery(this).outerHeight(); // ดึงความสูงของโฆษณารวมทั้ง margin ,padding
        var align=(screenHeight-adv_height)/2; //คำนวนให้โฆษณาอยู่กลางหน้าจอ
        jQuery(this).css({marginTop:align+'px'}); //เซตค่า margin-top ให้อยู่ตรงกลางหน้าจอ
    });
    jQuery(window).scroll(function(){ // เมื่อเกิด event scroll จะเข้า function นี้
        var scrollTop=jQuery(this).scrollTop(); //ดึงค่าตำแหน่ง scrollbar บนหน้าจอถ้าอยู่บนสุดจะเป็น 0
        jQuery('.adv').each(function(){
            var adv_height=jQuery(this).outerHeight();
            var align=(screenHeight-adv_height)/2;
            jQuery(this).stop(); //ถ้ายังแสดง animate อยู่จะหยุด animate นั้นๆ
            jQuery(this).animate({
                marginTop: scrollTop+align //จัดให้อยู่ตรงกลางหน้าจอ
              }, 500, function() { //จะเข้าทำงานก็ต่อเมือ animate นั้นแสดงเสร็จ
 
                            });
        });
    });
    jQuery('.adv_close').click(function(){ // กดปุ่ม close แล้วจะเข้าเงือนไข
            jQuery(window).unbind('scroll'); //ป้องกัน click แล้วเลื่อน scrollbar จะได้ไม่แสดงผิดพลาด
            jQuery('.adv').hide(500, //ซ่อนโฆษณาภายในเวลา 500
                                 function(){
                jQuery(this).remove(); //เมือซ่อนเสร็จให้ลบ element โฆษณาทิ้ง
            });
    });
});
</script>
<style type="text/css">
body{ height:100%; width:100%;}
.adv_close{ position:absolute;margin-top:-10px;line-height:18px;width:100%;text-align:right}
#adv2{ position:absolute;right:0;z-index:999;width:600px;height:329px; background-image:url(http://www.chulabook.com/images/popup/popup02042019.jpg) ;margin-top:10px; margin-right:22%;margin-left:5%;}
</style>
</head>

<body>
<div id="adv2" class="adv"><a href="#" class="adv_close"><img src="http://www.chulabook.com/images/popup/delete.png" border="0"></a><!--a href="http://www.chulabook.com/hr2007/job_detail.asp?job_id=8" style="width:100%;height:100%;display:block;"></a--><a href="#" style="width:100%;height:100%;display:block;"></a></div>
</body>
</html>
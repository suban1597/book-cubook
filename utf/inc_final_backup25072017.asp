<%

Session("PaymentMethod") = request.Form("PaymentMethod")


'Generate Tracking
'==================================
firstnum = "9"  + Cstr(year(now))
m=left(month(date),2)
y=right(FormatDateTime(date,1),2)

if len(m)=2 then
numberm = ""
else 
numberm = "0"
end if

Set Conns=Server.CreateObject("ADODB.Connection")
'Conns.Open "DSN=chulabook;server=chulabook;UID=sa;PWD=Adminchul@book1;DATABASE=ordercounter"
Conns.Open "Driver={SQL Server};Server=localhost;Database=ordercounter;UID=sa;PWD=Adminchul@book1;"
Set RSC= Server.CreateObject("ADODB.RecordSet")
Sqlc = "SELECT * FROM  counter_table"
RSC.Open Sqlc,conns,1,3
id =rsc("counter")

if id>9999 then
id = 1
end if
xid = Cstr(id)
newid = id+1
RSC("counter") = newid
RSC.update
RSC.close
Conns.close

if len(xid)=1 then
tnumber="000"

elseif len(xid)=2 then
tnumber="00"

elseif len(xid)=3 then
tnumber="0"

else 
tnumber=""

end if


gencode = Cstr(firstnum)+Cstr(numberm)+ Cstr(m)+Cstr(y)+Cstr(tnumber)+Cstr(xid)
Session("OrderID")=gencode
'response.Write "tracking number" & gencode & "<br>"
'response.Write "tracking number" &Session("OrderID") & "<br>"



'Function  Insert to DB
'=============================================
Set RSA= Server.CreateObject("ADODB.RecordSet")
SqlA = "SELECT * FROM account WHERE (UserID ='" & Session("UserID") & "')"
RSA.Open SqlA,conn,1,3
SName=RSA("SName")
SAddress=RSA("SAddress")
Splace=RSA("Splace")
Snum=RSA("Snum")
Smoo=RSA("Smoo")
Sbuilding=RSA("Sbuilding")
Ssoi=RSA("Ssoi")
Sroad=RSA("Sroad")
Stumbon=RSA("Stumbon")
SCity=RSA("SCity")
SProvince=RSA("SProvince")
SZip=RSA("SZip")
SCountry=RSA("SCountry")
SPhone=RSA("SPhone")
Set RSA=Nothing
ymdt=Right("0"& CStr(Year(Now)),4)&Right("0"& CStr(Month(Now)),2)
ymdt=ymdt&Right("0"& CStr(Day(Now)),2)

hmst=Right("0"&CStr(Hour(Now)),2)
hmst=hmst& Right("0"&CStr(Minute(Now)),2)& Right("0"& CStr(Second(Now)),2)


adminid = ChkAdmin("235407")

Set RS=Server.CreateObject("ADODB.RecordSet")
RS.Open " SELECT orders.* FROM orders" , Conn, 1, 3
On Error Resume Next
RS.AddNew
	RS("OrderID")=Session("OrderID")
	RS("OrderDate")=ymdt
	RS("OrderTime")=hmst
	RS("UserID")=Session("UserID")
	RS("Name")=SName
	RS("Address")=SAddress
	RS("City")=SCity
	RS("Province")=SProvince
	RS("Zip")=SZip
	RS("Country")=SCountry
	RS("Phone")=SPhone
	RS("place")=Splace
	RS("num")=Snum
	RS("moo")=Smoo
    RS("building")=Sbuilding
    RS("soi")=Ssoi
    RS("road")=Sroad
	RS("tumbon")=Stumbon
'	RS("GiftWrap")=Session("GiftWrap")
'	RS("GiftMessage")=Session("GiftMessage")
	RS("orderstatus")="0"
	RS("ShipmentStatus")="1"	
	RS("PaymentMethod")=Session("PaymentMethod")
	RS("delivery")=Session("delivery")
	RS("Amount")=Session("Amount")
	RS("SAHC")=Session("SAHC")
'	RS("Kios")=Session("kios")
'	If CurrencyNumber=1 Then
	RS("MoneyUnit")="BHT"
	RS("adminid")=adminid
	'RS("first_remark")=first_remark
'	Else
'	RS("MoneyUnit")="USD"
'	End If
'	RS("CurrencyFactor")=b2dfactor
RS.Update
Set RS = Nothing


'Function Send Email
'=============================================
Set RSM=Server.CreateObject("ADODB.RecordSet")
RSM.Open  "SELECT email FROM account WHERE UserID like '" & Session("UserID") & "'", Conn, 1, 3
CEmail=RSM("email")
Set RSM=Nothing

Cfrom="info@cubook.chula.ac.th"
Cto=CEmail

Csubject="Your order with Chulabook.com (" + CStr(Session("OrderID"))  +")"
Cbody = Cbody  + "--------------------------------------------------------------------------"+Chr(13)+Chr(10)
Cbody = Cbody  + "THANK YOU for shopping at Chulabook.com [ " & now() &" ]"+Chr(13)+Chr(10)
Cbody = Cbody  + "Your order  (" + CStr(Session("OrderID"))  +") information will be confirmed as below."+Chr(13)+Chr(10)+Chr(13)+Chr(10)

Cbody = Cbody  + "E-MAIL : " + CEmail+Chr(13)+Chr(10)
Cbody = Cbody  + "We received your order (tracking) ID " + CStr(Session("OrderID")) + " on " + Date + Chr(13) + Chr(10)
Cbody = Cbody  & "Payment Method : " &PrintMethod(Session("PaymentMethod")) &Chr(13)&Chr(10)
Cbody = Cbody  + "Shipping Address  : " + SAddress+Chr(13)+Chr(10)
Cbody = Cbody  + "City : " + SCity+Chr(13)+Chr(10)
Cbody = Cbody  + "Province  : " + SProvince+Chr(13)+Chr(10)
Cbody = Cbody  + "Zipcode  : " + SZip+Chr(13)+Chr(10)
Cbody = Cbody  + "Country  : " + SCountry+Chr(13)+Chr(10)
Cbody = Cbody  + "Tel.  : " + SPhone+Chr(13)+Chr(10)+Chr(13)+Chr(10)

Cbody = Cbody  + "THANKS YOU FOR YOUR SHOPPING."+Chr(13)+Chr(10)
Cbody = Cbody  + "--------------------------------------------------------------------------"+Chr(13)+Chr(10)
Cbody = Cbody  + "PRODUCTS"+Chr(13)+Chr(10)
Cbody = Cbody  + "(BARCODE/AVAILABILITY)"+Chr(13)+Chr(10)
Cbody = Cbody  + "PRICE ( x QUANTITY )"+Chr(13)+Chr(10)
Cbody = Cbody  + "--------------------------------------------------------------------------"+Chr(13)+Chr(10)

Dim YearC, YearB, BookNumber, PublishedYear, YearType, HTF
'YearC=Year(Date())-2
'YearB=Year(Date())+543-2
HTFcount=0
HTFcountTH=0
HTFcountEN=0

			For p = 1 to Session("NOAI")
							HTF=""
							sql= "Select * From booklist Where barcode= '" & Session("Barcode" & p) &"'" 
							Set RSB=Server.CreateObject("ADODB.RecordSet")
							RSB.open sql, Conn, 1, 3							
							
							Session("Title"& p)  = RSB("title")+RSB("title1")
							
							availability=Cint(RSB("stock_oh"))+Cint(RSB("cb_oh"))+Cint(RSB("sb_oh")) 
							If (availability > 0)  Then
							HTF=""
							Else 
							' check for 2 years before
							If (CInt(RSB("language"))=1 and CInt(RSB("year")) > (Year(Date())+543-2)) Then
							HTF=""
							'Out of stock
							ElseIf (CInt(RSB("language"))=2 and CInt(RSB("year")) > (Year(Date())-2)) Then
							HTF=""
							Else
							HTF="/hard to find"
							HTFcount=HTFcount+1
							End If
							End If
							
							
							Set RSB=Nothing
							
							If b2dfactor=1 Then
							CurrencyName="BHT"
							Else
							CurrencyName="BHT"
							End If
							
							Cbody = Cbody + Session("Title"& p) +Chr(13)+Chr(10)
							Cbody = Cbody +"(" & Session("Barcode"&p) & HTF & ")" +Chr(13)+Chr(10)
							Cbody = Cbody +FormatNumber(Session("price"&p),2) &" " &CurrencyName &" " & "( x " & CStr(Session("taken"&p)) & " )"+Chr(13)+Chr(10)+Chr(13)+Chr(10)
							
			Next

Cbody = Cbody  + "Subtotal = " & FormatNumber(Session("Amount"),2) &" " &CurrencyName +Chr(13)+Chr(10)
Cbody = Cbody  + "Shipment & Handling Charge = " & FormatNumber(Session("SAHC"),2) &" " &CurrencyName +Chr(13)+Chr(10)
Cbody = Cbody  + "Total    = " &  FormatNumber(CSng(Session("Amount"))+ CSng(Session("SAHC")),2) &" " &CurrencyName +Chr(13)+Chr(10)

'if session("check_wait_item") = 1 then
	'Cbody = Cbody  +"** รายการสินค้าที่ท่านสั่งบางรายการ ต้องรอสั่งซื้อหรือโอนจากต่างสาขา ทางเราจะจัดส่งตามให้ภายหลัง"+Chr(13)+Chr(10)
	'Cbody = Cbody  + "ใช้ระยะเวลาดำเนินการประมาณ 1- 2 สัปดาห์ โดยไม่คิดค่าจัดส่งเพิ่มเติมค่ะ (ทางเราจะจัดส่งรายการสินค้าที่มีไปให้ท่านก่อน)"+Chr(13)+Chr(10)
	'session("check_wait_item") = 0
'end if

Cbody = Cbody  + "====================================================================="+Chr(13)+Chr(10)

Cbody = Cbody  +"ค่าจัดส่งหนังสือสำหรับลูกค้าที่อยู่ต่างประเทศ พนักงานจะยืนยันค่าจัดส่งที่ถูกต้อง และแจ้งให้ทราบอีกครั้งหนึ่งภายใน 24 ชม. ของวันทำการ"+Chr(13)+Chr(10)
Cbody = Cbody  + "For Overseas Delivery Charges,We will confirm you within 24 hours."+Chr(13)+Chr(10)

Cbody = Cbody  + "====================================================================="+Chr(13)+Chr(10)

Cbody = Cbody  + " "+Chr(13)+Chr(10)
Cbody = Cbody  + "การโอนเงินผ่านธนาคาร/ตู้ ATM/ออนไลน์"+Chr(13)+Chr(10)
Cbody = Cbody  + "- ธนาคารไทยพาณิชย์ สาขาสุรวงษ์ บัญชีเลขที่ 002-2-08292-3"+Chr(13)+Chr(10)
Cbody = Cbody  + "- ธนาคารกสิกรไทย สาขาสยามสแควร์ บัญชีเลขที่ 026-2-42844-3"+Chr(13)+Chr(10)
Cbody = Cbody  + "- ธนาคารกรุงเทพ สาขาสยามสแควร์ บัญชีเลขที่ 152-0-91525-5"+Chr(13)+Chr(10)
Cbody = Cbody  + "- ธนาคารกรุงไทย สาขาสยามสแควร์ บัญชีเลขที่ 052-1-25100-1"+Chr(13)+Chr(10)
Cbody = Cbody  + "--------------------------------------------------------------------------"+Chr(13)+Chr(10)

Cbody = Cbody  + "  "+Chr(13)+Chr(10)
Cbody = Cbody  + "แจ้งผลการโอนเงิน การโอนเงินผ่านธนาคาร/ตู้ ATM/ออนไลน์"+Chr(13)+Chr(10)
Cbody = Cbody  + "หลังจากที่ท่านโอนเงินเข้าบัญชีศูนย์หนังสือจุฬาฯ แล้ว"+Chr(13)+Chr(10)
Cbody = Cbody  + "-แจ้งผลการโอนเงินผ่านเว็บไซต์ http://www.chulabook.com/banktransfer.asp"+Chr(13)+Chr(10)
Cbody = Cbody  + "  "+Chr(13)+Chr(10)
Cbody = Cbody  + "--------------------------------------------------------------------------"+Chr(13)+Chr(10)

Cbody = Cbody  + "  "+Chr(13)+Chr(10)
Cbody = Cbody  + "ตรวจสอบสถานะการสั่งซื้อสินค้า/สถานะการแจ้งผลการโอนเงิน ที่เว็บไซต์"+Chr(13)+Chr(10)
Cbody = Cbody  + "คลิกที่นี่ http://www.Chulabook.com/orderstatus.asp"+Chr(13)+Chr(10)
Cbody = Cbody  + "หรือ โทรสอบถามที่ Tel.0-2255-4433,0-2218-9891,08-6323-3703,08-6323-3704"+Chr(13)+Chr(10)
Cbody = Cbody  + "  "+Chr(13)+Chr(10)
Cbody = Cbody  + "--------------------------------------------------------------------------"+Chr(13)+Chr(10)

Cbody = Cbody  + "** NOTE: Price(s) may subject to change without notice. **"+Chr(13)+Chr(10)+Chr(13)+Chr(10)
Cbody = Cbody  + "Always enjoy re-visitting your Chulabook.com."+Chr(13)+Chr(10)+Chr(13)+Chr(10)
Cbody = Cbody  + "Sincerely yours,"+Chr(13)+Chr(10)

Cbody = Cbody  + "Customer Service"+Chr(13)+Chr(10)
'Cbody = Cbody  + "C.U. Cyber Bookshop 'Center of Knowledge' 24 hours service every day"+Chr(13)+Chr(10)
Cbody = Cbody  + "Save up to 50 %  from 200,000 titles AT YOUR CHOICE"+Chr(13)+Chr(10)
Cbody = Cbody  + "http://www.Chulabook.com "+Chr(13)+Chr(10)
Cbody = Cbody  + "Tel.0-2255-4433,0-2218-9891,08-6323-3703,08-6323-3704"+Chr(13)+Chr(10)
Cbody = Cbody  + "Fax.0-2255-4441 or 0-2254-9495  "+Chr(13)+Chr(10)
Cbody = Cbody  +Chr(13)+Chr(10)

if HTFcount > 0 then
Cbcc="info@cubook.chula.ac.th"
else
Cbcc="info@cubook.chula.ac.th"
end if
Set Conn2=Server.CreateObject("ADODB.Connection")
conn2.open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&Server.mappath("db/mailsystem.mdb")
Sql2="Select * from orderdetail"
Set RS2 =Server.CreateObject("ADODB.Recordset")
RS2.open Sql2,Conn2,1,3
RS2.AddNew

RS2("orderid") = Session("orderid")
Cbody2=replace(replace(replace(Cbody,"<","&lt;"),">","&gt;"),chr(13),"<br>")
rs2("cbody") = cbody2

RS2.update
RS2.close
Conn2.close


Set myMail=Server.CreateObject("CDO.Message")
	myMail.BodyPart.Charset = "UTF-8"
	myMail.From = Cfrom
	myMail.To = Cto
	'myMail.BCC = "cpornthi@cubook.chula.ac.th"
	myMail.Subject = Csubject
	myMail.TextBody = Cbody
	myMail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	'Name or IP of remote SMTP server
	myMail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
	'Server port
	myMail.Configuration.Fields.Item _
	("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
	myMail.Configuration.Fields.Update
	myMail.Send
Set myMail= Nothing


'=============================================
Set RS1=Server.CreateObject("ADODB.RecordSet")
RS1.Open " SELECT orderdetails .* FROM orderdetails " , Conn, 1, 3
For p=1 to Session("NOAI")
'On Error Resume Next

	If Session("un"&p) = 1 Then
	
		RS1.AddNew
			RS1("OrderID")=Session("OrderID")
			RS1("Barcode")=Session("barcode"&p)
			RS1("Quantity")=Session("taken"&p)
			RS1("Price")=Session("price"&p)
			RS1("Available")=0
			RS1("WaitStateA")=0
			RS1("WaitStateB")=0
			RS1("Cancel")=0
			RS1("Finished")=0
			RS1("orderstatus")=0
		'response.Write "orderid" &Session("OrderID") & "<br>"
		'response.Write "barcode" & Session("barcode"&p) & "<br>"
		'response.Write "quantity" & Session("taken"&p) & "<br>"
		'response.Write "price" &Session("price"&p) & "<br>"
		RS1.Update
		'RS1.MoveNext
		
	End If	
	
Next	
'Set RS1 = Nothing
'for each item in request.Form
'response.Write item &  " : " &  request.form(item) & "<br>"
'next
Function final
OrderID=Session("OrderID")
If Session("PaymentMethod") = "2" Then
	Response.redirect "payment_selector.asp?OrderID=" & OrderID
Else


   	For p = 1 to Session("NOAI")
		Session("Barcode" & p) = ""	
	Next 

	Response.redirect "thank.asp?OrderID=" & OrderID
End IF
'response.Write "tracking number" &orderid& "<br>"
End Function
%>

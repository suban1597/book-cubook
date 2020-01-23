<%
'-----------Extranote-----------
Extranote = ""
'-----------Global Variable-----------
'Distribute Discount (%)
 DisPercent= 0.85
'Normal Discount(%)
 NormalPercent=0.90
 'Normal Discount20(20%)
 DisPercent20=0.80

'-----------discount 10 %, factor=0.90 if not factor = 1.0-----------
Function discount(InputVal)
	IF IsNumeric(InputVal) Then
		discount = FormatNumber(InputVal*NormalPercent,0)	
	Else
		discount = 0
	End IF
End Function

'-----------discount 15 %, factor=0.85 if not factor = 1.0-----------
Function distribute(InputVal)
	IF IsNumeric(InputVal) Then
		distribute = FormatNumber(InputVal*DisPercent,0)
	Else
		distribute = 0
	End IF
End Function

'discount 20 %, factor=0.80 if not factor = 1.0
Function distribute20(InputVal)
	IF IsNumeric(InputVal) Then
		distribute20 = FormatNumber(InputVal*DisPercent20,0)
	Else
		distribute20 = 0
	End IF
End Function

'-----------Calculate Price <Update 07/01/2009 By Phumsiri Phumsiriruk>-----------
Function Calculate_Price(Barcode)
Barcode = Barcode
sqlBook=" SELECT barcode, disctype, price, disctype1, [language], distribute FROM booklist WHERE barcode = '"&Barcode&"'" 
Set RsBook=Server.CreateObject("ADODB.RecordSet")
RsBook.Open  sqlBook, Conn, 1, 3

sqlSOL=" SELECT barcode,price FROM booksprice WHERE barcode = '"& RSBook("Barcode") &"'" 
Set RsSOL=Server.CreateObject("ADODB.RecordSet")
RsSOL.Open  sqlSOL, Conn, 1, 3

'Case 1 Net Price  Table  Bookprice
If (not RSSOL.EOF) Then 
		SpecialPrice = FormatNumber(RSSOL("price"),2)
		Calculate_Price = SpecialPrice
		
'Case 2 Type N	
elseif Lcase(Rsbook("disctype"))="n" Then		
	    SpecialPrice = FormatNumber(RsBook("price"),2)
		Calculate_Price = SpecialPrice	

'Case 3 C111 10% 
elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute") ="1" Then
	    SpecialPrice = FormatNumber(discount(RsBook("price")),2)	
		Calculate_Price = SpecialPrice

'Case 4 C112 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute")="2" Then	
		SpecialPrice = FormatNumber(distribute(RsBook("price")),2)
		Calculate_Price = SpecialPrice

'Case 5 C121 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="2" and RsBook("distribute") ="1" Then
		SpecialPrice = FormatNumber(discount(RsBook("price")),2)	
		Calculate_Price = SpecialPrice

'Case 6 C211 10%		
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="1" and RsBook("distribute") ="1" Then	
		SpecialPrice = FormatNumber(discount(RsBook("price")),2)	
		Calculate_Price = SpecialPrice

'Case 7 C221 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="2" and RsBook("distribute") ="1" Then	
		SpecialPrice = FormatNumber(discount(RsBook("price")),2)	
		Calculate_Price = SpecialPrice

'Case 8 C222 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="2" and RsBook("distribute")="2" Then	
		SpecialPrice = FormatNumber(discount(RsBook("price")),2)	
		Calculate_Price = SpecialPrice

'Case 9 C321 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="1" Then	
		SpecialPrice = FormatNumber(discount(RsBook("price")),2)	
		Calculate_Price = SpecialPrice

'Case 10 C322 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="2" Then	
		SpecialPrice = FormatNumber(discount(RsBook("price")),2)	
		Calculate_Price = SpecialPrice
	
'Case 11 C323 10%		
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="3" Then	
		SpecialPrice = FormatNumber(discount(RsBook("price")),2)	
		Calculate_Price = SpecialPrice
end if			

'================================		
RsBook.Close
End Function


'-----------Calculate DiscountRate <Update 02/03/2009 By Phumsiri Phumsiriruk>-----------
Function Cal_DiscountRate(Barcode)
Barcode = Barcode
sqlBook=" SELECT barcode, disctype, price, disctype1, [language], distribute FROM booklist WHERE barcode = '"&Barcode&"'" 
Set RsBook=Server.CreateObject("ADODB.RecordSet")
RsBook.Open  sqlBook, Conn, 1, 3

sqlSOL=" SELECT barcode,price FROM booksprice WHERE barcode = '"& RSBook("Barcode") &"'" 
Set RsSOL=Server.CreateObject("ADODB.RecordSet")
RsSOL.Open  sqlSOL, Conn, 1, 3

'Case 1 Net Price  Table  Bookprice
If (not RSSOL.EOF) Then
		 DiscountRate = RsBook("price") - RsSOL("price")
		 response.Write Formatnumber(DiscountRate,2) & " บาท"
		
'Case 2 Type N	
elseif Lcase(Rsbook("disctype"))="n" Then
		DiscountRate = "สินค้าพิเศษ ไม่มีส่วนลดค่ะ"
		 response.Write DiscountRate

'Case 3 C111 10% 
elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute") ="1" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.9,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
'Case 4 C112 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute")="2" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.85,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
'Case 5 C121 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="2" and RsBook("distribute") ="1" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.9,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
'Case 6 C211 10%		
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="1" and RsBook("distribute") ="1" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.9,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
'Case 7 C221 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="2" and RsBook("distribute") ="1" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.9,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
'Case 8 C222 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="2" and RsBook("distribute")="2" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.90,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
'Case 9 C321 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="1" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.9,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
'Case 10 C322 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="2" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.9,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
'Case 11 C323 10%		
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="3" Then
		DiscountRate = FormatNumber(RsBook("price")) - FormatNumber(RsBook("price")*0.9,0)
		response.Write Formatnumber(DiscountRate,2) & " บาท"
end if			

'================================		
RsBook.Close
End Function

'-----------Calculate DiscountPercent <Update 02/03/2009 By Phumsiri Phumsiriruk>-----------
Function Cal_DiscountPercent(Barcode)
Barcode = Barcode
sqlBook=" SELECT barcode, disctype, price, disctype1, [language], distribute FROM booklist WHERE barcode = '"&Barcode&"'" 
Set RsBook=Server.CreateObject("ADODB.RecordSet")
RsBook.Open  sqlBook, Conn, 1, 3

sqlSOL=" SELECT barcode FROM booksprice WHERE barcode = '"& RSBook("Barcode") &"'" 
Set RsSOL=Server.CreateObject("ADODB.RecordSet")
RsSOL.Open  sqlSOL, Conn, 1, 3

'Case 1 Net Price  Table  Bookprice
If (not RSSOL.EOF) Then
		DiscountPercent = ""
		Cal_DiscountPercent = DiscountPercent
		
'Case 2 Type N	
elseif Lcase(Rsbook("disctype"))="n" Then
		DiscountPercent = ""
    	Cal_DiscountPercent = DiscountPercent

'Case 3 C111 10% 
elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute") ="1" Then
		DiscountPercent = FormatNumber((RsBook("price") - (RsBook("price")*0.9))*100/RsBook("price"),0)
    	Cal_DiscountPercent = DiscountPercent
'Case 4 C112 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="1" and RsBook("distribute")="2" Then
		DiscountPercent =  FormatNumber((RsBook("price") - (RsBook("price")*0.85))*100/RsBook("price"),0)
		Cal_DiscountPercent = DiscountPercent
'Case 5 C121 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="1" and RSBook("language")="2" and RsBook("distribute") ="1" Then
		DiscountPercent = FormatNumber((RsBook("price") - (RsBook("price")*0.9))*100/RsBook("price"),0)
		Cal_DiscountPercent = DiscountPercent
'Case 6 C211 10%		
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="1" and RsBook("distribute") ="1" Then
		DiscountPercent = FormatNumber((RsBook("price") - (RsBook("price")*0.9))*100/RsBook("price"),0)
		Cal_DiscountPercent = DiscountPercent
'Case 7 C221 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="2" and RsBook("distribute") ="1" Then
		DiscountPercent = FormatNumber((RsBook("price") - (RsBook("price")*0.9))*100/RsBook("price"),0)
		Cal_DiscountPercent = DiscountPercent
'Case 8 C222 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="2" and RSBook("language")="2" and RsBook("distribute")="2" Then
		DiscountPercent = FormatNumber((RsBook("price") - (RsBook("price")*0.90))*100/RsBook("price"),0)
		Cal_DiscountPercent = DiscountPercent
'Case 9 C321 10% ǧԴ 15%
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="1" Then
		DiscountPercent = FormatNumber((RsBook("price") - (RsBook("price")*0.9))*100/RsBook("price"),0)
		Cal_DiscountPercent = DiscountPercent
'Case 10 C322 10% ǧԴ 15%	
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="2" Then
		DiscountPercent = FormatNumber((RsBook("price") - (RsBook("price")*0.9))*100/RsBook("price"),0)
		Cal_DiscountPercent = DiscountPercent
'Case 11 C323 10%		
	elseif Lcase(Rsbook("disctype"))="c" and RSBook("disctype1")="3" and RSBook("language")="2" and RsBook("distribute") ="3" Then
		DiscountPercent = FormatNumber((RsBook("price") - (RsBook("price")*0.9))*100/RsBook("price"),0)
		Cal_DiscountPercent = DiscountPercent
end if			

'================================		
RsBook.Close
End Function


%>
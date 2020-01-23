<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
          <td width="100%" valign="top">
            <div align="left">
              <%
		  If  not IsNull(Author) Then
		  	Call AuthorBooks(Author)
		  End IF
		   %>
           </div></td>
  </tr>
      </table>
<%
Public Sub AuthorBooks(PAuthor)
				
					
					maxchar =  len(PAuthor)
					
					NewAuthur = ""	
					
					
					for i = 1 to maxchar
					
						IF  ASC(mid(PAuthor,i,1)) <> 160 Then
								NewAuthur = NewAuthur & mid(PAuthor,i,1)
						End If
					next
					
					

					
					Dim SqlRe
					SqlRe = "SELECT  top 6  title,title1,category,barcode,author FROM booklist "
					SqlRe = SqlRe &  " where  Replace(author,'และคณะ','') like '%" & ReplaceString(NewAuthur) & "%'"
					SqlRe = SqlRe &  " and barcode <> '"&barcode&"' " 
					SqlRe = SqlRe &  " and (sb14_oh+sb_oh)>5 Order by CONVERT(datetime,recvdate,5) DESC"
					
				
					'response.Write SqlRe
					'response.End()
					Set RsRBook=Server.CreateObject("ADODB.RecordSet")
					RsRBook.Open  SqlRe, Conn, 1, 3
					
					TableLoop = 1
					Datapage = "<table border=0 cellspacing=3 cellpadding=3 align=center >"
					

					IF   not rsRBook.EOF  Then
						response.write "<font class=big-text><b>หนังสือเล่มอื่นๆ โดย " & author & "</b>&nbsp;&nbsp;(บางส่วน)</font><br>"
				   Else
				   	response.Write "<font class=big-text><b>ไม่มีสินค้าที่เกี่ยวข้องค่ะ</b></font>"
					End if

					Do while not rsRBook.EOF
					
					If TableLoop = 1 Then
					 	 Datapage = Datapage &  "<tr>"
					   End If
				  
					
					Datapage = Datapage & "<td width=25% align=center>"
					  
					NBarcode = RsRBook("Barcode")
					        
					'Dim CoverFile
					CoverFile = NBarcode & ".gif" 	

				
                    On Error Resume Next
                    ' Find Book Cover
		' ===================================================================
		'bookimgpt = "D:\Chulabook\cgi-bin\main\2010\images\books\" & NBarcode &  ".gif"			
		'bookimgpt2 = "D:\Chulabook\cgi-bin\main\2010\images\book2\" & NBarcode &  ".gif"	
		'if   ChkFile(bookimgpt) = true then
				'bookimg = "http://www.chulabook.com/images/books/" & NBarcode &  ".gif"				
		'elseif ChkFilebook2(bookimgpt2) = true then
				'bookimg = "http://www.chulabook.com/images/book2/" & NBarcode &  ".gif"
		'else	
				'bookimg = "http://www.chulabook.com/images/books/apology.gif"
		'end if

		    bookimgpt = "C:\Chulabook\images\book-400\" & NBarcode &  ".jpg" 
		    'bookimgpt2 = "C:\Chulabook\images\book2\" & NBarcode &  ".jpg"    
		    if   ChkFile(bookimgpt) = true then
		        bookimg = "images/book-400/" & NBarcode &  ".jpg"        
		    'elseif ChkFilebook2(bookimgpt2) = true then
		        'bookimg = "http://203.154.162.41/images/book2/" & NBarcode &  ".jpg"
		    else  
		        bookimg = "images/book-400/apology.jpg"
		    end if
		' =================================================================
					 Datapage = Datapage & "<img src="& bookimg &"  alt=""Book"" border=0 height=100/>"					  
					 Datapage = Datapage &  "<br><font ><a href=""description.asp?barcode=" & Nbarcode &  """ class=text>" & rsRBook("title") & rsRBook("title1") & "</a></font><br>"
					 Datapage = Datapage &  "<font class=blacktext>" & rsRBook("Author")  & "</font><br>"
					 Datapage = Datapage & "</td>"
					
						If TableLoop < 2 Then
							TableLoop = TableLoop + 1

						Else
							Datapage = Datapage &  "</tr>"
							TableLoop = 1
						End if
						
					rsRBook.movenext
					Loop
					
				Datapage = Datapage &   "</table>"
				
				Response.write  Datapage

' If having a Book 
'===========================
'If Not RsBook.Eof Then

End Sub
%>
<!--#include file="connect_db.asp"-->
<%
	email = request.Form("email")
	'response.Write email
	 'step1 ) Selecy Account Information
	 		
				sql = "SELECT Email, Pword, Bname FROM Account  WHERE Email like '" & email & "'  "
				Set RS = Server.CreateObject("ADODB.RecordSet")
				Rs.Open Sql,Conn,1,3

				password = Rs("Pword")			
				'response.Write password

				Cfrom="webmaster@cubook.chula.ac.th"
				Cto=Email

				Csubject="Your password on your login. www.chulabook.com"

				Cbody = Cbody  + "Dear : "&Rs("Bname")&""+Chr(13)+Chr(10)
				Cbody = Cbody  + "Your username: "&Rs("Email")&""+Chr(13)+Chr(10)	
				Cbody = Cbody  + "Your password: "&Rs("Pword")&""+Chr(13)+Chr(10)
				Cbody = Cbody  + "If you want to change the password. You can change the code by clicking on Login and then clicking on Select. change Password."+Chr(13)+Chr(10)
				Cbody = Cbody  + "If you have any questions or need more information. Please contact customer service."+Chr(13)+Chr(10)
				Cbody = Cbody  + "E-mail : webmaster@cubook.chula.ac.th"+Chr(13)+Chr(10)
				Cbody = Cbody  + "Tel : 0-2255-4433"+Chr(13)+Chr(10)
				Cbody = Cbody  + "fax : 0-2255-4441"+Chr(13)+Chr(10)
				Cbody = Cbody  + "Open : Mon – Fri. 9am - 17pm "+Chr(13)+Chr(10)

				Cbody = Cbody  + "Yours sincerely"+Chr(13)+Chr(10)
				Cbody = Cbody  + "Customer Service "+Chr(13)+Chr(10)
				Cbody = Cbody  + "Chulabook Center"+Chr(13)+Chr(10)

					
					'Set ObjMail=Server.CreateObject("CDONTS.Newmail")

				Set myMail=Server.CreateObject("CDO.Message")
					myMail.From = Cfrom
					myMail.To = Cto
					myMail.BCC = Cbcc
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

				response.Redirect("final_sendpassword.asp")
				   
%>
<%
kidroom = request.QueryString("kidroom")
'response.Write kidroom
If kidroom = "" or kidroom = 1  then
kidroom_img = "images/kidroom/01.jpg"
elseif kidroom = 2 then
kidroom_img = "images/kidroom/02.jpg"
elseif kidroom = 3 then
kidroom_img = "images/kidroom/03.jpg"
elseif kidroom = 4 then
kidroom_img = "images/kidroom/04.jpg"
elseif kidroom = 5 then
kidroom_img = "images/kidroom/05.jpg"
elseif kidroom = 6 then
kidroom_img = "images/kidroom/06.jpg"
elseif kidroom = 7 then
kidroom_img = "images/kidroom/07.jpg"
elseif kidroom = 8 then
kidroom_img = "images/kidroom/08.jpg"
elseif kidroom = 9 then
kidroom_img = "images/kidroom/09.jpg"
elseif kidroom = 10 then
kidroom_img = "images/kidroom/10.jpg"
elseif kidroom = 11 then
kidroom_img = "images/kidroom/11.jpg"
elseif kidroom = 12 then
kidroom_img = "images/kidroom/12.jpg"
elseif kidroom = 13 then
kidroom_img = "images/kidroom/13.jpg"
elseif kidroom = 14 then
kidroom_img = "images/kidroom/16.jpg"
End If
%>

<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div align="center"><img src="<%=kidroom_img%>" border="0" /></div></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <div align="left"><!--<a href="playground.asp">&lt;&lt; ͹˹</a>-->
        <%' for itscount = 1 to itsallpage %>
         <span class="text"> จำนวนหน้า <% for itscount = 1 to 14 %></span>
      <a href="kidroom.asp?kidroom=<%=itscount%>" class="text"> <%=itscount%></a>
        <%next%>
      <!--  <a href="#">Ѵ &gt;&gt;</a> -->
    </div></td>
  </tr>
</table>
<br>

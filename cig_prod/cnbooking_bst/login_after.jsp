<html>
<head>
<title>CNHotelBooking.com��̨������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>

<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:setProperty name="UserInfo" property="username"/>
<jsp:setProperty name="UserInfo" property="password"/>

<%
   boolean Authorized = UserInfo.login();
%>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr > 
    <td width="80">&nbsp; </td>
        <table width="250" border="0" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff" align="center">
          <tr> 
          <% if (!Authorized) {%>
            <td colspan="2" class="font9" align="center">�Բ�������û�е�¼�������Ѿ���ʱ������<a href="main_middle.htm">��¼</a></td>
          <% }else{%>
            <td><p>&nbsp;</p><p>&nbsp;</p><center><p></p><p></p><p></p><img src="/images/loginsucess.gif"></center></td>
          <% }%>      
          </tr>
        </table>
    </td>
  </tr>
</table>
</body> 
</html>
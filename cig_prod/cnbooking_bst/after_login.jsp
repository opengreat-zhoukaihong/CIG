<html>
<head><title>JdbcTest12</title></head>
<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:setProperty name="UserInfo" property="username"/>
<jsp:setProperty name="UserInfo" property="password"/>

<%
   boolean Authorized = UserInfo.login();
%>

<Body>

<form method="post" action="">
  <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr valign="top"> 
      <td height="172"> 
        <table width="600" border="0" cellspacing="0" cellpadding="0" align="left">
          <tr align="center"> 
            <% if (!Authorized) {%>
            <td height="185">�Բ�������û�е�¼�������Ѿ���ʱ������<a href="main_middle.htm"><font color="#990000">��¼</font></a></td>
            <% }else{%>
            <td><p>&nbsp;</p><p>&nbsp;</p><center><p></p><p></p><p></p><img src="/images/loginsucess.gif"></center></td>
            <% }%>            
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

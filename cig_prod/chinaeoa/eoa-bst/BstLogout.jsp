<%@ page import="java.lang.*" %>
<jsp:useBean id="login" scope="session" class="com.cig.chinaeoa.LoginBean" />
<html>
<head>
<%
       session.removeValue("cneoa.MemberId");
       session.removeValue("cneoa.UserId");
       session.removeValue("cneoa.CompName");
       session.removeValue("cneoa.MemberType");
       session.removeValue("cneoa.UserLevel");

       login.setUserId("");
       login.setMemberId("");
       login.setMemberType("");
       login.setUserLevel("");
       login.setCompName("");


       %>
           <jsp:forward page="bstLogin.htm"></jsp:forward>
        <% 

%>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >

</body>
</html>
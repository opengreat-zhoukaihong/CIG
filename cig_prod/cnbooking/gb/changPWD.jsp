<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" />
<%
String info="";
String passwd=request.getParameter("passwd");
if(passwd==null)
passwd="";
passwd=passwd.trim();
if(passwd.length()>0){
    if(UserInfo.changPWD(passwd)){ 
	info += "恭喜,修改成功!<br>";
    }
    else{
	info +="很抱歉,修改未能成功，请检查数据!";
    }
} 
String title="修改密码";

   response.sendRedirect("/cnbooking/gb/ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>
<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

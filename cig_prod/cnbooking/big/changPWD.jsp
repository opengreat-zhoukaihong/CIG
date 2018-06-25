<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" />
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" />
<%
String info="";
String passwd=request.getParameter("passwd");
if(passwd==null)
passwd="";
passwd=passwd.trim();
if(passwd.length()>0){
    if(UserInfo.changPWD(Convert.b2g(passwd))){ 
	info += "恭喜,修改成功!<br>";
    }
    else{
	info +="很抱歉,修改未能成功，請檢查數据!";
    }
} 
String title="修改密碼";

   response.sendRedirect("/cnbooking/big/ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>
<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

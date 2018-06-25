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
	info += "Congratulations!,change successfully!<br>";
    }
    else{
	info +="Sorry,update failed ,please check !";
    }
} 
String title="Update Password";

   response.sendRedirect("/cnbooking/en/ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>
<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

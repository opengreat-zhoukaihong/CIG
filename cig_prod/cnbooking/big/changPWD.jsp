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
	info += "����,�ק令�\!<br>";
    }
    else{
	info +="�ܩ�p,�ק良�ন�\�A���ˬd���u!";
    }
} 
String title="�ק�K�X";

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

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
	info += "��ϲ,�޸ĳɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,�޸�δ�ܳɹ�����������!";
    }
} 
String title="�޸�����";

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

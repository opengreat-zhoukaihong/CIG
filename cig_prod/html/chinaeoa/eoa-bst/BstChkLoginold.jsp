<%@ page import="java.lang.*" %>
<html>
<head>
<%
    String isDone = (String)session.getValue("cneoa.MemberId");    
    String wGoPage = request.getParameter("GoPage");

    if (isDone != null)
    {
      //response.sendRedirect(request.getScheme() + "://" + request.getServerName() +
      //  ":" + request.getServerPort() + "/" + wGoPage);
           %>
           <jsp:forward page="<%= wGoPage %>"></jsp:forward>
        <% 
        }
    else
    {
      //response.sendRedirect(request.getScheme() + "://" + request.getServerName() +
      //  ":" + request.getServerPort() + "/chinaeoa/eoa-bst/bstLogin.htm");
	%>
           <jsp:forward page="bstLogin.htm"></jsp:forward>
        <% 

     }
      //response.sendRedirect("http://test.chinaeoa.com/chinaeoa/eoa-bst/bstLogin.htm");

%>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >

</body>
</html>
<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/paperec_backm/login.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  String funcId = "fnConBbsMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

<%@ page import="bbs.*, java.util.*, java.net.*" %>
<jsp:useBean id="PostAction" scope="page" class="bbs.PostAction" /> 
<%
    String info;
    String article_ID=request.getParameter("article_ID").trim();
    String area_ID=request.getParameter("area_ID").trim();
    PostAction.setArticle_ID(article_ID);
  
   if(PostAction.delArticle()) 
    { 
	info = "Success!<br>";
    }
    else
    {
	info ="Failed! ";
    }
    response.sendRedirect("bbsBK_List.jsp?area_ID=" + area_ID+"&pageNo=1");
%>
<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>


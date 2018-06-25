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
<jsp:useBean id="PostDelMore" scope="page" class="bbs.PostDelMore" /> 
<%
    String inf="";
    String fromDate=request.getParameter("fromDate").trim();
    String toDate=request.getParameter("toDate").trim();
    String area_ID=request.getParameter("area_ID").trim();
    PostDelMore.setDateFrom(fromDate);
    PostDelMore.setDateTo(toDate);
    PostDelMore.setArea_ID(area_ID);
     
   if(PostDelMore.delArticleMore()) 
    { 
	inf += " Success!<br>";
    }
    else
    {
	inf += " Failed!";
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


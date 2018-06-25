<%--  @# func_process.jsp  Ver 1.0 --%>
<%@ page language="java" import="com.jspsmart.upload.*,java.util.*, java.net.*"%>
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
  String funcId = "fnPbiMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

<%
String articleId;
String orderNo;
String art_id;
String action;
String info="";
articleId= request.getParameter("articleId");
orderNo = request.getParameter("orderNo");
%>
<jsp:useBean id="ArticleImageManager" scope="page" class="com.cig.article.ArticleImageManager" /> 
<jsp:setProperty name="ArticleImageManager" property="DEBUG" value="true"/> 
<jsp:setProperty name="ArticleImageManager" property="dbpoolName" value="paperec"/> 

<%
     art_id = articleId; 
      
      if (ArticleImageManager.deleteArticleImage(art_id,orderNo))
      {
          response.sendRedirect("articleImageList.jsp?articleId="+art_id); 
          info += "删除成功!";
      }
      else
          info += "删除失败!";
%>

<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>

</SCRIPT>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="100" height="50">&nbsp; </td>
    <td width="495" height="50">&nbsp; </td>
  </tr>
  <tr> 
    <td width="100" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407" class="font12"> 
	<%=info%>
    </td>
  </tr>
</table>
</body>
</html>


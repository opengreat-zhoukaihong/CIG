<%--  @# article_process.jsp  Ver 1.0 --%>

<%--@ page import="java.util.*" %>
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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
<%}--%>

<%@ page import="java.util.*,com.cig.article.*" %>
<jsp:useBean id="article" scope="page" class="com.cig.article.Article" /> 
<jsp:setProperty name="article" property="DEBUG" value="true"/> 
<jsp:setProperty name="article" property="dbpoolName" value="paperec"/> 
<jsp:setProperty name="article" property="articleId"/> 
<jsp:setProperty name="article" property="langCode"/> 
<jsp:setProperty name="article" property="header"/>
<jsp:setProperty name="article" property="title"/>
<jsp:setProperty name="article" property="subTitle"/>
<jsp:setProperty name="article" property="author"/>
<jsp:setProperty name="article" property="content"/>
<jsp:setProperty name="article" property="source"/>
<jsp:setProperty name="article" property="templateId"/>
<jsp:setProperty name="article" property="htmlURL"/>
<jsp:setProperty name="article" property="metaKey"/>
<jsp:setProperty name="article" property="opeId"/>
<jsp:setProperty name="article" property="pbDate"/>
<jsp:setProperty name="article" property="crDate"/>
<jsp:setProperty name="article" property="mdDate"/>
<jsp:setProperty name="article" property="status" value="Y"/>

<jsp:useBean id="atcMgr" scope="page" class="com.cig.article.ArticleManager" /> 
<jsp:setProperty name="atcMgr" property="DEBUG" value="true"/> 
<jsp:setProperty name="atcMgr" property="dbpoolName" value="paperec"/> 
<%
  atcMgr.setArticle(article);
%>

<%
    String name, value;
    Enumeration e = request.getParameterNames();
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);
%>
<!--<%=name%>=<%=value%><br>-->
<%
    }
%>

<%
  String info = "";
  
  String action = request.getParameter("action");
  action = action==null?"":action;
  
  if (action.equals("add"))
  {
      if (atcMgr.addArticle())
      {
          //response.sendRedirect("operator_detail.jsp?opeId=" + operator.getOpeId()); 
          info = "���ӳɹ�!"; 
      }
      else
          info = "����ʧ��!"; 
  }
  else if (action.equals("update"))
  {
      if (atcMgr.updateArticle())
          info = "���³ɹ�!";
      else
          info = "����ʧ��!";
  }
  else if (action.equals("delete"))
  {
      if (atcMgr.deleteArticle(article.getArticleId()))
      {
          //response.sendRedirect("operator_list.jsp"); 
          info = "ɾ���ɹ�!";
      }
      else
          info = "ɾ��ʧ��!";
  }
  else if (action.equals("multi_del"))
  {
      String[] opeIds = request.getParameterValues("chk_opeid");
      if (opeIds==null)
          info = "û��ָ������ԱID!";
      else
      {
          for (int i=0; i<opeIds.length; i++)
          {
              atcMgr.deleteArticle(opeIds[i]);
          }
          response.sendRedirect("operator_list.jsp"); 
          info = "��ɾ���������!";
      }
  }
  else
      info = "����ʧ��!";
      
%>

<html>
<head>
<title>PBI��̨������</title>
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

<!--Err: 
<%=article.errMsg%>

Err2:
<%=atcMgr.errMsg%>
-->
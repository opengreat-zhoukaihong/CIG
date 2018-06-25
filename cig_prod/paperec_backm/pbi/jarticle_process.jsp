<%--  @# column_process.jsp  Ver 1.0 --%>

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
<jsp:useBean id="jArticle" scope="page" class="com.cig.article.JArticle" /> 
<jsp:setProperty name="jArticle" property="DEBUG" value="true"/> 
<jsp:setProperty name="jArticle" property="dbpoolName" value="paperec"/> 
<jsp:setProperty name="jArticle" property="journalId"/> 
<jsp:setProperty name="jArticle" property="columnId"/> 
<jsp:setProperty name="jArticle" property="articleId"/> 
<jsp:setProperty name="jArticle" property="orderNo"/> 
<jsp:setProperty name="jArticle" property="status"/> 

<jsp:useBean id="journal" scope="page" class="com.cig.article.Journal" /> 
<jsp:setProperty name="journal" property="DEBUG" value="true"/> 
<jsp:setProperty name="journal" property="dbpoolName" value="paperec"/> 
<jsp:setProperty name="journal" property="journalId"/> 
<!--
<%
    String name, value;
    Enumeration e = request.getParameterNames();
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);
%>
<%=name%>=<%=value%><br>
<%
    }
%>
-->

<%
  String info = "";
  
  String action = request.getParameter("action");
  action = action==null?"":action;
  
  if (action.equals("accept"))
  {
      if (journal.acceptArticle(jArticle))
      {
          //response.sendRedirect("operator_detail.jsp?opeId=" + operator.getOpeId()); 
          info = "���ܳɹ�!"; 
      }
      else
          info = "����ʧ��!"; 
  }
  else if (action.equals("remove"))
  {
      if ( journal.removeArticle(jArticle.getColumnId(), jArticle.getArticleId() ))
      {
          //response.sendRedirect("operator_list.jsp"); 
          info = "�Ƴ��ɹ�!";
      }
      else
          info = "�Ƴ�ʧ��!";
  }
//  else if (action.equals("multi_del"))
//  {
//      String[] opeIds = request.getParameterValues("chk_opeid");
//      if (opeIds==null)
//          info = "û��ָ������ԱID!";
//      else
//      {
//          for (int i=0; i<opeIds.length; i++)
//          {
//              colMgr.deleteColumn(opeIds[i]);
//          }
//          response.sendRedirect("operator_list.jsp"); 
//          info = "��ɾ���������!";
//      }
//  }
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
<%=journal.errMsg%>
-->
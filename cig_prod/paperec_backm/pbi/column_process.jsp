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
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}--%>

<%@ page import="java.util.*,com.cig.article.*" %>
<jsp:useBean id="column" scope="page" class="com.cig.article.Column" /> 
<jsp:setProperty name="column" property="DEBUG" value="true"/> 
<jsp:setProperty name="column" property="dbpoolName" value="paperec"/> 
<jsp:setProperty name="column" property="columnId"/> 
<jsp:setProperty name="column" property="langCode"/> 
<jsp:setProperty name="column" property="columnName"/>

<jsp:useBean id="colMgr" scope="page" class="com.cig.article.ColumnManager" /> 
<jsp:setProperty name="colMgr" property="DEBUG" value="true"/> 
<jsp:setProperty name="colMgr" property="dbpoolName" value="paperec"/> 
<%
  colMgr.setColumn(column);
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
      boolean task = false;
      if (column.getColumnId()==null 
          || column.getColumnId().trim().equals(""))
        task = colMgr.addColumn();
      else
        task = colMgr.insertColumn();
      
      if (task)
      {
          //response.sendRedirect("operator_detail.jsp?opeId=" + operator.getOpeId()); 
          info = "增加成功!"; 
      }
      else
          info = "增加失败!"; 
  }
  else if (action.equals("update"))
  {
      if (colMgr.updateColumn())
          info = "更新成功!";
      else
          info = "更新失败!";
  }
  else if (action.equals("delete"))
  {
      if (colMgr.deleteColumn(column.getColumnId()))
      {
          //response.sendRedirect("operator_list.jsp"); 
          info = "删除成功!";
      }
      else
          info = "删除失败!";
  }
  else if (action.equals("multi_del"))
  {
      String[] opeIds = request.getParameterValues("chk_opeid");
      if (opeIds==null)
          info = "没有指定操作员ID!";
      else
      {
          for (int i=0; i<opeIds.length; i++)
          {
              colMgr.deleteColumn(opeIds[i]);
          }
          response.sendRedirect("operator_list.jsp"); 
          info = "多删除操作完成!";
      }
  }
  else
      info = "操作失败!";
      
%>

<html>
<head>
<title>PBI后台管理工具</title>
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
<%=column.errMsg%>

Err2:
<%=colMgr.errMsg%>
-->
<%--  @# func_process.jsp  Ver 1.0 --%>

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
  String funcId = "fnSecMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
<%}%>


<%@ page import="java.util.*" %>

<jsp:useBean id="funcMgr" scope="page" class="com.paperec.bst.permission.FuncManager" /> 
<jsp:setProperty name="funcMgr" property="DEBUG" value="true"/> 
<jsp:setProperty name="funcMgr" property="dbpoolName" value="paperec"/> 
<jsp:setProperty name="funcMgr" property="funcId"/> 
<jsp:setProperty name="funcMgr" property="moduleId"/>
<jsp:setProperty name="funcMgr" property="descr"/>

<%
  String info = "";
  
  String action = request.getParameter("action");
  action = action==null?"":action;
  
  if (action.equals("add"))
  {
      if (funcMgr.funcAdd())
      {
          response.sendRedirect("func_list.jsp"); 
          info = "���ӳɹ�!"; 
      }
      else
          info = "����ʧ��!"; 
  }
  else if (action.equals("update"))
  {
//      if (funcMgr.update())
//          info = "���³ɹ�!";
//      else
          info = "����ʧ��!";
  }
  else if (action.equals("delete"))
  {
      if (funcMgr.funcDelete())
      {
          response.sendRedirect("func_list.jsp"); 
          info = "ɾ���ɹ�!";
      }
      else
          info = "ɾ��ʧ��!";
  }
  else
      info = "����ʧ��!";
      
%>

<html>
<head>
<title>CNHotelBooking.com��̨������</title>
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

<%--Err: <%=funcMgr.errMsg--%>
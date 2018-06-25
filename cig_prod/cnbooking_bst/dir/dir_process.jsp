<%--  @# dir_process_list.jsp  Ver 1.0 --%>

<%@ page import="java.util.*" %>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/main_middle.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnDirMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
<%}%>


<jsp:useBean id="DirHelper" scope="page" class="com.cnbooking.bst.dir.DirHelper" /> 
<jsp:setProperty name="DirHelper" property="action"/>
<jsp:setProperty name="DirHelper" property="dirId"/>
<jsp:setProperty name="DirHelper" property="dir"/>
<jsp:setProperty name="DirHelper" property="descr"/>
<jsp:setProperty name="DirHelper" property="opeId"/> 

<%
    String name, value;
    Enumeration e = request.getParameterNames();
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);
%>
<%--=name%>=<%=value%><br>--%>
<%
    }
%>

<%
  boolean processTask = DirHelper.process();
  String info = "";
  
  String action = request.getParameter("action");
  action = action==null?"":action;
  
  if (action.equals("add") && processTask)
  {
      response.sendRedirect("dir_detail.jsp?dirId=" + DirHelper.getDirId());  
  }
  else if (action.equals("update") && processTask)
  {
      info = "���³ɹ�!";
  }
  else if (action.equals("delete") && processTask)
  {
      info = "ɾ���ɹ�!";
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

<%--Err: <%=DirHelper.errMsg--%>
<%--  @# func_process.jsp  Ver 1.0 --%>
<%@ page language="java" import="com.cig.article.*,java.util.*, java.net.*"%>
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

String action = request.getParameter("action");

String info="";
%>
<jsp:useBean id="journalManager" scope="page" class="com.cig.article.JournalManager" /> 
<jsp:setProperty name="journalManager" property="DEBUG" value="true"/> 
<jsp:setProperty name="journalManager" property="dbpoolName" value="paperec"/> 

<jsp:useBean id="journal" scope="page" class="com.cig.article.Journal" /> 
<jsp:setProperty name="journal" property="DEBUG" value="true"/> 
<jsp:setProperty name="journal" property="dbpoolName" value="paperec"/> 
<jsp:setProperty name="journal" property="journalIssue"/>
<jsp:setProperty name="journal" property="langCode" value="GB"/>
<jsp:setProperty name="journal" property="journalSerialNo"/>
<jsp:setProperty name="journal" property="journalName"/>
<jsp:setProperty name="journal" property="journalComments"/>
 
 <%=journal.getJournalName()%>
<%
  String journal_id;
  
  if (action.equals("add"))
  {   
      journalManager.setJournal(journal);
 %>
 <%=request.getParameter("JournalName")%>
 <%    
      if (journalManager.addJournal())
      {
          journal_id = journal.getJournalId();
          //response.sendRedirect("journalList.jsp?pageNo=1&journalId="+journal_id); 
          info += "增加成功!"; 
      }
      else
          info += "增加失败!"; 
  }
  else if (action.equals("update"))
  {
//      if (funcMgr.update())
//          info += "更新成功!";
//      else
          info += "更新失败!";
  }
  else
      info += "操作失败!";
      
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

<%=journalManager.errMsg%>
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

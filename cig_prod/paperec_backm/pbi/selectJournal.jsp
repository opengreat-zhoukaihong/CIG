<%--  @# add_operator.jsp  Ver 1.0 --%>

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

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.fmColumnAdd;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
</SCRIPT>



<%@ page import="com.cig.article.*" %>

<jsp:useBean id="journalList" scope="page" class="com.cig.article.JournalList" />
<jsp:setProperty name="journalList" property="DEBUG" value="true"/> 
<jsp:setProperty name="journalList" property="dbpoolName" value="paperec"/>

<%
   Journal[] jour=null;
   String article_id = request.getParameter("articleId");
   
   journalList.search();
   jour = journalList.getJournals();
%>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name="fmColumnAdd" method="post" action="selectColumn.jsp">

	<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">请选择文稿所属的期刊</td>
          </tr>
        </table>
        <table width="350" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
         <tr align="left"> 
           <td class="font9" width="150" height="15">文稿Id：</td>
           <td class="font9" width="300" height="15"><%=article_id%></td>
           <input type="hidden" name="articleId" size="20" value="<%=article_id%>">
         </tr>
          <tr> 
            <td width="100" class="font9">期刊：</td>
            <td width="200" class="font9">
              <select name="journalId">
              <% for (int i=0; i<jour.length; i++) {%>
		<option value="<%=jour[i].getJournalId()%>"><%=jour[i].getJournalName()%>(<%=jour[i].getLangCode()%>)</option>
	      <% }%>
            </td>
          </tr>
        </table>
        <table width="350" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30"> <input type="submit" value="继续">&nbsp;&nbsp;&nbsp;&nbsp;
              </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

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

<jsp:useBean id="journal" scope="page" class="com.cig.article.Journal" />
<jsp:setProperty name="journal" property="dbpoolName" value="paperec"/>
<jsp:setProperty name="journal" property="DEBUG" value="true" />
<jsp:setProperty name="journal" property="journalId" />


<%
   
   String article_id = request.getParameter("articleId");
   
    String journal_id = "";

    JColumn[] jcols=null;
    Column col=null;
    
    journal_id = request.getParameter("journalId");

    jcols = journal.getColumns();
    
%>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name="fmColumnAdd" method="post" action="jarticle_accept_list.jsp">
      
	<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">请选择文稿所属的栏目</td>
          </tr>
        </table>
        <table width="350" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
         <tr align="left"> 
           <td class="font9" width="150" height="15">期刊Id：</td>
           <td class="font9" width="300" height="15"><%=journal_id%></td>
           <input type="hidden" name="journalId" size="20" value="<%=journal_id%>">
         </tr>
         <tr align="left"> 
           <td class="font9" width="150" height="15">文稿Id：</td>
           <td class="font9" width="300" height="15"><%=article_id%></td>
           <input type="hidden" name="articleId" size="20" value="<%=article_id%>">
         </tr>         
          <tr> 
            <td width="100" class="font9">栏目：</td>
            <td width="200" class="font9">
              <select name="columnId">
              <% for (int i=0; i<jcols.length; i++) {
                   col = jcols[i].getColumn();
              %>
		<option value="<%=col.getColumnId()%>"><%=col.getColumnName()%></option>
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

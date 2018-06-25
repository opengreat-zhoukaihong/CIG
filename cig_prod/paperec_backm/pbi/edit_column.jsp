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

<%@ page import="java.util.*,com.cig.article.*" %>
<jsp:useBean id="colMgr" scope="page" class="com.cig.article.ColumnManager" /> 
<jsp:setProperty name="colMgr" property="DEBUG" value="true"/> 
<jsp:setProperty name="colMgr" property="dbpoolName" value="paperec"/> 


<%
  String columnId = request.getParameter("columnId");
  Column column = colMgr.getColumn(columnId);
  if (column==null) column = new Column();
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

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.fmColumnAdd;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
</SCRIPT>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="30" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407"> 
      <form name="fmColumnUpdate" method="post" action="column_process.jsp">
      <input type="HIDDEN" name="action" value="update">

	<table width="545" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td class="font12">栏目编辑</td>
          </tr>
        </table>
        <table width="350" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#F9C026" bordercolordark="#FFFFFF">
          <tr> 
            <td width="100" class="font9">语言代码：</td>
            <td width="200" class="font9">
              <select name="langCode">
		<option value='GB' <%if(column.getLangCode().equals("GB")){%>selected<%}%>>GB</option>
		<option value='EN' <%if(column.getLangCode().equals("EN")){%>selected<%}%>>English</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="100" class="font9">栏目ID：</td>
            <td width="200" class="font9">
              <%=column.getColumnId()%>&nbsp;
              <input type="HIDDEN" name="columnId" value="<%=column.getColumnId()%>">
            </td>
          </tr>
          <tr> 
            <td width="100" class="font9">栏目名称：</td>
            <td width="200" class="font9">
              <input type="text" name="columnName" value="<%=column.getColumnName()%>">
            </td>
          </tr>
        </table>
        <table width="350" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="30"> <input type="submit" value="更新">&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="reset" value="Reset"></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>

<Err: 
<%=colMgr.errMsg%>
>
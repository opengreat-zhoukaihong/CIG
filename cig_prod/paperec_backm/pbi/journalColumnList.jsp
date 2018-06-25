<%--  @# chanpindl_gglb.jsp Ver.1.1 --%>

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
  boolean isPermitted;
  String userID;
  String funcId;

  funcId = "fnPbiMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>


<%@ page import="com.cig.article.*" %>

<jsp:useBean id="journal" scope="page" class="com.cig.article.Journal" />
<jsp:setProperty name="journal" property="dbpoolName" value="paperec"/>
<jsp:setProperty name="journal" property="DEBUG" value="true" />
<jsp:setProperty name="journal" property="journalId" />

<jsp:useBean id="colList" scope="page" class="com.cig.article.ColumnList" />
<jsp:setProperty name="colList" property="dbpoolName" value="paperec"/>
<jsp:setProperty name="colList" property="DEBUG" value="true" />

<%
    String journal_id = "";
    JColumn[] jcols=null;
    Column col=null;
    Column[]  cols=null;
    
    journal_id = request.getParameter("journalId");

    jcols = journal.getColumns();
    
    colList.search();
    cols = colList.getColumns();
%>

<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>PBI后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "宋体"}
        A:visited {text-decoration: none; font-family: "宋体"}
        A:active {text-decoration: none; font-family: "宋体"}
        A:hover {text-decoration: underline; color: #FFCC33}
-->
</style>
</head>


<%=journal.errMsg%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>     
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form method="post" action="journalColumnProcess.jsp">
      <input type=hidden name="journalId" value="<%=journal_id%>" >
      <input type=hidden name="action" value="add" >
        <table width="650" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#f9c026" bordercolordark="#FFFFFF" align="center">
          <tr> 
            <td colspan="6" class="font12">期刊--栏目列表：期刊ID: <%=journal_id%></td>
          </tr>
          <tr align="center" class="font9"> 
            <td width="60"><b>序号</b></td>
            <td width="60"><b>栏目ID</b></td>
            <td width="60"><b>语言</b></td>
            <td width="100"><b>栏目名称</b></td>
            <td width="60"><b>&nbsp;</b></td>
            <td width="60">&nbsp;</td>
          </tr>
	<%
	  for (int i=0; i<jcols.length; i++) {
	     col = jcols[i].getColumn();
	%>
          <tr align="center" class="font9"> 
            <td width="60">&nbsp;<%=jcols[i].getOrderNo()%></td>
            <td width="60">&nbsp;<%=col.getColumnId()%></td>
            <td width="60">&nbsp;<%=col.getLangCode()%></td>
            <td width="100">&nbsp;<%=col.getColumnName()%></td>
            <td width="60"><a href="jarticle_list.jsp?journalId=<%=journal_id%>&columnId=<%=col.getColumnId()%>" class="font9">查看该栏目文稿</a></td>
            <td width="60"><a href="journalColumnProcess.jsp?action=delete&journalId=<%=journal_id%>&columnId=<%=col.getColumnId()%>" onClick="return confirm('确实要从该期刊中删除此栏目吗?')" class="font9">删除</a></td>
          </tr>
        <% } %>
	</table>    
        <table width="450" border="0" cellspacing="2" cellpadding="5" height="10">
                <tr> 
                  <td class="font12">&nbsp;</td>
                </tr>
        </table>	    
        <table width="300" border="0" cellspacing="2" cellpadding="4" bordercolorlight="#f9c026" bordercolordark="#FFFFFF" align="center">        
         <tr align="left"> 
           <td class="font9" width="100" height="15">序号：</td>
           <td class="font9" width="220" height="15"><input type="text" name="orderNo" size="4"></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="100" height="15">栏目：</td>
           <td class="font9" width="220" height="15">
              <select name="columnId">
              <% for (int i=0; i<cols.length; i++) {%>
		<option value="<%=cols[i].getColumnId()%>"><%=cols[i].getColumnName()%>(<%=cols[i].getLangCode()%>)</option>
	      <% }%>
              </select>           
           </td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="100" height="15">栏目是否开放：</td>
           <td class="font9" width="220" height="15">
              <select name="status">
		<option value="Y">开放</option>
		<option value="N">不开放</option>
              </select>           
           </td>         
         </tr>         
         <tr align="center" colspan="2"> 
           <td colspan="2">
              <input type="button" name="btnAdd" value="对该期刊增加栏目" OnClick="javascript:submit()">
            </td>
         </tr>         
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

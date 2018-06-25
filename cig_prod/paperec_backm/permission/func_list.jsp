<%--  @# func_list.jsp  Ver 1.0 --%>

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
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>


<%@ page import="java.util.*,java.io.*" %>
<jsp:useBean id="funcMgr" scope="page" class="com.paperec.bst.permission.FuncManager" /> 
<jsp:setProperty name="funcMgr" property="DEBUG" value="true" />
<jsp:setProperty name="funcMgr" property="dbpoolName" value="paperec" />

<jsp:useBean id="moduleMgr" scope="page" class="com.paperec.bst.permission.ModuleManager" /> 
<jsp:setProperty name="moduleMgr" property="DEBUG" value="true" />
<jsp:setProperty name="moduleMgr" property="dbpoolName" value="paperec" />
<%
    String[][] funcs = funcMgr.getFuncs();    
    String[][] modules = moduleMgr.getModules();    
        
%> 

<html>
<head>

<title>CNHotelBooking.com后台管理工具</title>
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

<script language="JavaScript">	
function delete_selected()
{
    if(confirm("Are you sure to delete selected Functions?"))
    {
	document.fmFuncProcess.action.value = "delete"
	document.fmFuncProcess.submit()
    }		
}
	
function del_func(func_id)
{
    if(confirm("Are you sure to delete this Function?"))
    {
	document.emptyform.action="func_process.jsp?action=delete&funcId=" + func_id; 
	document.emptyform.submit()
    }		
}
	
function js_callpage(htmlurl) 
{
    var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=566,height=327");
    return false;
}
	
</script>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">



<span class="font9"></span> <span class="font9"></span> 
<table width="500" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr> 
    <td> 
      <table border="0" cellpadding="0" cellspacing="0" width="500">
        <tr> 
          <td width="30">&nbsp; </td>
          <td> 

            <form name=fmFuncProcess method="post" action="func_process.jsp">
	    <input type="hidden" name="action" value="add">
	    
              <table width="450" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">角色管理</td>
                </tr>
              </table>
              <table width="450" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr align="center"> 
                  <td class="font9" width="50" height="15">Func ID</td>
                  <td class="font9" width="100" height="15">Module 名称</td>
                  <td class="font9" width="250" height="15">描述</td>
                  <td class="font9" width="50" height="15">操作</td>
                </tr>
                <% 
              	  if (funcs != null){                   
                   for (int i=0; i<funcs.length; i++){%>
                <tr align="center"> 
                  <td class="font9" width="50" height="15"><%=funcs[i][0]%>&nbsp;</td>
                  <td class="font9" width="100" height="15"><%=funcs[i][2]%>&nbsp;</td>
                  <td class="font9" width="250" height="15"><%=funcs[i][3]%>&nbsp;</td>
                  <td class="font9" width="25" height="15">[<a href="javascript:del_func('<%=funcs[i][0]%>')" class="font9">delete</a>]</td>
                </tr>
                <% }
                  }
                %>
              </table>
              <table width="450" border="0" cellspacing="2" cellpadding="5" height="10">
                <tr> 
                  <td class="font12">&nbsp;</td>
                </tr>
              </table>
              <table width="450" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr align="left"> 
                  <td class="font9" width="150" height="15">Func ID</td>
                  <td class="font9" width="300" height="15"><input type="text" name="funcId"></td>
                </tr>
                <tr align="left"> 
                  <td class="font9" width="150" height="15">Module </td>
                  <td class="font9" width="300" height="15">
		    <select name="moduleId">
                      <option value=0>--select--</option>
              	      <% for (int i=0;i<modules.length;i++) {%>
                      <option value="<%=modules[i][0]%>"><%=modules[i][1]%></option>
                      <% }%>
                    </select>
                  </td>
                </tr>
                <tr align="left"> 
                  <td class="font9" width="150" height="15">描述</td>
                  <td class="font9" width="300" height="15"><textarea name="descr"></textarea></td>
                </tr>
                <tr align="center"> 
                  <td class="font9" height="30" colspan=2>
                    <input type="submit" name="submit" value="增 加">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="reset" name="reset" value="Reset">
                  </td>
                </tr>
              </table>
            </form>

            <form action="" name="emptyform" method="post"></form>

          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

<%--Err: <%=funcMgr.errMsg--%>
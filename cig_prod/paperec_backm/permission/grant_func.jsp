<%--  @# grant_func.jsp  Ver 1.0 --%>

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

<jsp:useBean id="role" scope="page" class="com.paperec.bst.permission.RoleManager" /> 
<jsp:setProperty name="role" property="DEBUG" value="true" />
<jsp:setProperty name="role" property="dbpoolName" value="paperec" />
<jsp:setProperty name="role" property="roleId" />

<%
    String[][] funcs = funcMgr.getFuncs();
    //role.fetch();
    
    String roleId = request.getParameter("roleId");    
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

            <form name=fmFuncGrant method="post" action="func_grant.jsp">
	    <input type="hidden" name="roleId" value="<%=roleId%>">
	    
              <table width="350" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">角色授权(功能)</td>
                </tr>
                <tr> 
                  <td class="font9">角色ID: <%=roleId%></td>
                </tr>
              </table>
              <table width="350" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr align="center"> 
                  <td class="font9" width="25" height="15">&nbsp;</td>
                  <td class="font9" width="50" height="15">Func ID</td>
                  <td class="font9" width="100" height="15">Module </td>
                  <td class="font9" width="150" height="15">描述</td>
                </tr>
                <% 
              	  if (funcs != null){                   
                   for (int i=0; i<funcs.length; i++){%>
                <tr align="center"> 
                  <td class="font9" width="25" height="15">
	            <% if (role.isFuncGranted(funcs[i][0])) {%>
                    <input type="checkbox" name="funcId" value="<%=funcs[i][0]%>" checked>
                    <%} else {%>
                    <input type="checkbox" name="funcId" value="<%=funcs[i][0]%>">
                    <%} %>
                  </td>
                  <td class="font9" width="50" height="15"><%=funcs[i][0]%>&nbsp;</td>
                  <td class="font9" width="100" height="15"><%=funcs[i][2]%>&nbsp;</td>
                  <td class="font9" width="150" height="15"><%=funcs[i][3]%>&nbsp;</td>
                </tr>
                <% }
                  }
                %>
              </table>
	      <table width="350" border="0" cellspacing="0" cellpadding="0">
        	<tr align="middle"> 
            	  <td height="30">
            	    <input type="submit" name="grant" value="Grant">
            	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	    <input type="reset" name="reset" value="Reset">
            	  </td>
          	</tr>
              </table>
            </form>

          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

<%--Err: <%=funcMgr.errMsg--%>
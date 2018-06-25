<%--  @# operator_list.jsp  Ver 1.0 --%>

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
<jsp:useBean id="roleMgr" scope="page" class="com.paperec.bst.permission.RoleManager" /> 
<jsp:setProperty name="roleMgr" property="DEBUG" value="true" />
<jsp:setProperty name="roleMgr" property="dbpoolName" value="paperec" />

<jsp:useBean id="operator" scope="page" class="com.paperec.bst.permission.Operator" /> 
<jsp:setProperty name="operator" property="DEBUG" value="true" />
<jsp:setProperty name="operator" property="dbpoolName" value="paperec" />
<jsp:setProperty name="operator" property="opeId" />

<%
    String[][] roles = roleMgr.getRoles();
    //operator.fetch();
    
    String opeId = request.getParameter("opeId");    
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

            <form name=fmRolesGrant method="post" action="roles_grant.jsp">
	    <input type="hidden" name="opeId" value="<%=opeId%>">
	    
              <table width="350" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">操作员授权(角色)</td>
                </tr>
                <tr> 
                  <td class="font9">操作员ID: <%=opeId%></td>
                </tr>
              </table>
              <table width="350" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr align="center"> 
                  <td class="font9" width="25" height="15">&nbsp;</td>
                  <td class="font9" width="50" height="15">Role ID</td>
                  <td class="font9" width="100" height="15">Role 名称</td>
                  <td class="font9" width="150" height="15">描述</td>
                </tr>
                <% 
              	  if (roles != null){                   
                   for (int i=0; i<roles.length; i++){%>
                <tr align="center"> 
                  <td class="font9" width="25" height="15">
	            <% if (operator.isRoleAssigned(roles[i][0])) {%>
                    <input type="checkbox" name="roleId" value="<%=roles[i][0]%>" checked>
                    <%} else {%>
                    <input type="checkbox" name="roleId" value="<%=roles[i][0]%>">
                    <%} %>
                  </td>
                  <td class="font9" width="50" height="15"><%=roles[i][0]%>&nbsp;</td>
                  <td class="font9" width="100" height="15"><%=roles[i][1]%>&nbsp;</td>
                  <td class="font9" width="150" height="15"><%=roles[i][2]%>&nbsp;</td>
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

<%--Err: <%=operator.errMsg--%>
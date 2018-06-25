<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" %>
<jsp:useBean id="grantInfo" scope="request" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String functionID;
%>
<%
  functionID = "fnRoleMg";
  userID = (String)session.getValue("operator");
  grantInfo.setFuncID(functionID);
  grantInfo.setUserID(userID);
  isPermitted = grantInfo.isPermitted();
  if(!isPermitted) {
%>
<jsp:forward page="../BackResultsError.jsp?message=Sorry! You have no permission!" />
<%  } %>


<%! String roleID;
    String[] funcIDs;    // all function; 0:func_ID;1:module_ID;2:modole_Name;3:description
    int errorCode = 0;
%>
<%
    roleID = request.getParameter("roleID");
    funcIDs = request.getParameterValues("granted");
    try
    {
      grantInfo.setRoleID(roleID);
      grantInfo.deletePermission();
      for(int i=0;i<funcIDs.length;i++)
      {
        grantInfo.setRoleID(roleID);
        grantInfo.setFuncID(funcIDs[i]);
        grantInfo.grantPermission();
      }
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
%>

<html>
<head>
<title>Grant Rights</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body bgcolor="#FFFFFF">
<table width="74%" border="0" height="188" cellpadding="0" cellspacing="0">
  <tr>
    <td width="2%" height="4">&nbsp;</td>
    <td width="95%" height="4">&nbsp;</td>
    <td width="3%" height="4">&nbsp;</td>
  </tr>
  <tr>
    <td width="2%" height="141">&nbsp;</td>
    <td width="95%" height="141">
      <table width="100%" border=1 cellpadding=0 cellspacing=0 bordercolorlight=#6666Ff bordercolordark="#FFFFFF">
      <h4>
      <%
        errorCode = grantInfo.getErrorCode();
        if(errorCode==0)
          out.println("授权成功!");
        else
          out.println("授权失败!");
      %></h4><br>
      <p><a href="roleAdd.jsp">返回</a></p>

      </table>
    </td>
    <td width="3%" height="141">&nbsp;</td>
  </tr>
  <tr>
    <td width="2%" height="2">&nbsp;</td>
    <td width="95%" height="2">&nbsp;</td>
    <td width="3%" height="2">&nbsp;</td>
  </tr>
</table>
</body>
</html>

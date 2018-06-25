<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" %>
<jsp:useBean id="roleManager" scope="request" class="com.cig.permission.RoleManager" />
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


<%! String action,roleID,roleName,descr;
    String[][] rolesList;
%>
<%
  try
  {
    action = request.getParameter("action");
    if(action!=null && action.equals("add"))
    {
      roleID = request.getParameter("roleID");
      roleName = request.getParameter("roleName");
      descr = request.getParameter("descr");
      roleManager.setRoleID(roleID);
      roleManager.setRoleName(roleName);
      roleManager.setDescr(descr);
      roleManager.roleAdd();
    }
    if(action!=null && action.equals("delete"))
    {
      roleID = request.getParameter("roleID");
      roleManager.setRoleID(roleID);
      roleManager.roleDelete();
    }
    rolesList = roleManager.getRoles();
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
%>

<html>
<head>
<title>Role Manager</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
<script>

  function validateForm()
  {
    if(document.roleAdd.roleID.value == "")
    {
      alert("Please input RoleID!");
      document.roleAdd.roleID.focus();
      return false;
    }
    if(document.roleAdd.roleName.value == "")
    {
      alert("Please input Role name !");
      document.roleAdd.roleName.focus();
      return false;
    }
  }

  function roleDelete(tempRoleID)
  {
    document.roleDel.roleID.value = tempRoleID;
    if(confirm("Do you want to delete the role?"))
      document.roleDel.submit();
  }
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="487" border="0" cellspacing="0" cellpadding="2" height="235">
  <tr> 
    <td rowspan="3">&nbsp;</td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr>
    <td height="108"> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF
      cellpadding=5 cellspacing=2 width=469>
        <tr bgcolor="#FFFFFF"> 
          <td height="30" colspan="6" align="center"><h4>Role Manager</h4></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td align="center" width="53" height="34"> 
            <div align="center">Role ID</div>
          </td>
          <td width="73" height="34"> 
            <div align="center">Role Name</div>
          </td>
          <td width="195" height="34"> 
            <div align="center">Description</div>
          </td>
          <td width="26" height="34">&nbsp;</td>
          <td width="48" height="34">&nbsp;</td>
        </tr>
        <%  for(int i=0;i<rolesList.length;i++)
            {
      %> 
        <tr bgcolor="#FFFFFF"><font size="3"> 
          <td align="center" width="53" height="29"> <%=rolesList[i][0]%></td>
          <td height="29" width="73">
        <%  if(rolesList[i][1]==null) { %>&nbsp;
        <% } else { %><%=rolesList[i][1]%><% } %>
          </td>
          <td height="29" width="195">
        <%  if(rolesList[i][2]==null) { %>&nbsp;
        <%  } else { %><%=rolesList[i][2]%><% } %>
          </td>
          <td height="29" width="26">
            <div align="center"><font size="2"><a href="javascript:roleDelete('<%=rolesList[i][0]%>')">[Del]</a></font></div>
          </td>
          <td height="29" width="48"><a href="funcGrant.jsp?roleID=<%=rolesList[i][0]%>&roleName=<%=rolesList[i][1]%>">[grant]</a></td>
          </font> </tr>
        <%   } %>
      </table>
    </td>
  </tr>
  <tr>
    <td height="113"> 
      <table width="90%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#6666FF" bordercolordark="#FFFFFF">
        <form name="roleAdd" method="post" action="roleAdd.jsp?action=add" onSubmit="return validateForm()">
          <tr> 
            <td width="19%" height="31"><font size="3">RoleID: 
              <input type="text" name="roleID" maxlength="2" size="3">
              </font></td>
            <td width="64%" height="31"><font size="3">Role Name: 
              <input type="text" name="roleName" size="30">
              </font></td>
            <td rowspan="2" height="61" valign="bottom" width="17%"> 
              <input type="submit" name="Submit" value="Submit">
            </td>
          </tr>
          <tr valign="top"> 
            <td width="19%" height="30" valign="middle"><font size="3">Description: 
              </font></td>
            <td width="64%" height="30"> <font size="3"> 
              <textarea name="descr" cols="38">
</textarea>
              </font></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
  <form name="roleDel" method="post" action="roleAdd.jsp?action=delete">
    <input type="hidden" name="roleID">
  </form>
</table>
</body>
</html>

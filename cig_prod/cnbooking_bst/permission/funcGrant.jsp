<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" %>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/main_middle.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnSecMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>


<jsp:useBean id="funcManager" scope="request" class="com.cig.permission.FuncManager" />
<jsp:useBean id="grantInfo" scope="request" class="com.cig.permission.Permission" />
<jsp:useBean id="moduleManager" scope="request" class="com.cig.permission.ModuleManager" />

<%! String roleID,roleName;
    String[][] funcList;    // all function; 0:func_ID;1:module_ID;2:modole_Name;3:description
    Vector grantedFuncs = new Vector();        // funcIDs granted to a role;
%>
<%
    if(!grantedFuncs.isEmpty())
      grantedFuncs.removeAllElements();

    roleID = request.getParameter("roleID");
    roleName = request.getParameter("roleName");

//    funcList = funcManager.getFunctions();
    funcList = funcManager.getFuncs();
    grantInfo.setRoleID(roleID);
    grantedFuncs = grantInfo.getGrantedFuncs();
%>

<html>
<head>
<title>Funcion Manager</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body bgcolor="#FFFFFF">
<table width="74%" border="0" height="188" cellpadding="0" cellspacing="0" >
  <tr>
    <td width="2%" height="4">&nbsp;</td>
    <td width="95%" height="4">&nbsp;</td>
    <td width="3%" height="4">&nbsp;</td>
  </tr>
  <tr>
    <td width="2%" height="141">&nbsp;</td>
    <td width="95%" height="141">
     <form name="grant" method="post" action="grantRes.jsp">
      <table width="100%" border=1 cellpadding=0 cellspacing=0 bordercolorlight=#6666Ff bordercolordark="#FFFFFF">
        <tr> 
          <td colspan="4" height="29"> 
            <div align="center"> 
              <h4>Role_ID:<%=roleID%>&nbsp;&nbsp; Role Name:<%=roleName%></h4>
              <input type="hidden" name="roleID" value="<%=roleID%>">
            </div>
          </td>
        </tr>
        <tr> 
          <td width="13%">Granted </td>
          <td width="20%"> 
            <div align="center">Func_ID</div>
          </td>
          <td width="23%"> 
            <div align="center">Module</div>
          </td>
          <td width="44%"> 
            <div align="center">description</div>
          </td>
        </tr>
        <tr> <%  for(int i=0;i<funcList.length;i++)
        {
        %> 
          <td width="13%">
            <div align="center">
            <% if(grantedFuncs.contains(funcList[i][0])) { %>
              <input type="checkbox" name="granted" value="<%=funcList[i][0]%>" checked>
            <% } else { %>
              <input type="checkbox" name="granted" value="<%=funcList[i][0]%>" >
            <%  } %>
            </div>
          </td>
          <td width="20%"><%=funcList[i][0]%></td>
          <td width="23%">
      <%  if(funcList[i][2]==null) { %>&nbsp;
      <%  } else { %><%=funcList[i][2]%><%  } %>
          </td>
          <td width="44%">
      <%  if(funcList[i][3]==null) { %>&nbsp;
      <%  } else { %><%=funcList[i][3]%><%  } %>
        </td>
        </tr>
        <%  } %>
        <tr> 
          <td width="13%">&nbsp;</td>
          <td width="20%">&nbsp;</td>
          <td width="23%">&nbsp;</td>
          <td width="44%">&nbsp;</td>
        </tr>
        <tr valign="middle"> 
          <td colspan="4"> 
            <div align="center"> 
              <input type="submit" name="submit" value="Grant">
              <input type="reset" name="reset" value="Reset">
            </div>
          </td>
        </tr>
      </table>
      </form>
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

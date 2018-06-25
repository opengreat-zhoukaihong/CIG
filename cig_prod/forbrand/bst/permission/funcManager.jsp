<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" %>
<jsp:useBean id="funcManager" scope="request" class="com.cig.permission.FuncManager" />
<jsp:useBean id="moduleManager" scope="request" class="com.cig.permission.ModuleManager" />
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String functionID;
%>
<%
  functionID = "fnFuncMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(functionID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if((!isPermitted)||(!userID.equals("cig"))) {
%>
<jsp:forward page="../BackResultsError.jsp?message=Sorry! You have no permission!" />
<%  } %>


<%! String action,funcID,moduleID,descr;
    boolean keyExisted = false;
    String[][] funcList;
    String[][] moduleList;
%>
<%
  try
  {
    action = request.getParameter("action");
    if(action!=null && action.equals("add"))
    {
      funcID = request.getParameter("funcID");
      moduleID = request.getParameter("moduleID");
      descr = request.getParameter("descr");
      funcManager.setFuncID(funcID);
      funcManager.setModuleID(moduleID);
      funcManager.setDescr(descr);
      keyExisted = funcManager.keyExisted();
      if(!keyExisted)
        funcManager.funcAdd();
    }
    if(action!=null && action.equals("delete"))
    {
      funcID = request.getParameter("funcID");
      funcManager.setFuncID(funcID);
      funcManager.funcDelete();
    }

    funcList = funcManager.getFuncs();
    moduleList = moduleManager.getModules();

  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
%>

<html>
<head>
<title>Function Manager</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
<script>

  function validateForm()
  {
    if(document.funcAdd.funcID.value == "")
    {
      alert("Please input FuncID!");
      document.funcAdd.funcID.focus();
      return false;
    }
    if(document.funcAdd.moduleID.selectedIndex == 0)
    {
      alert("Please select a module!");
      document.funcAdd.moduleID.focus();
      return false;
    }
  }

  function funcDelete(tempFuncID)
  {
    document.funcDel.funcID.value = tempFuncID;
    if(confirm("Do you want to delete the function?"))
      document.funcDel.submit();
  }
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<% if(keyExisted) {%>
<script>alert("This function existed.");</script>
<% }  %>
<table width="491" border="0" cellspacing="0" cellpadding="2" height="235">
  <tr>
    <td rowspan="3">&nbsp;</td>
    <td height="20" valign="bottom">
      <div align="center">
        <h4>Function Manager</h4>
      </div>
    </td>
  </tr>
  <tr>
    <td height="52">
      <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#6666FF" bordercolordark="#FFFFFF">
        <tr >
          <td width="16%">
            <div align="center">Function ID</div>
          </td>
          <td width="32%">
            <div align="center">Module</div>
          </td>
          <td width="40%">
            <div align="center">Description</div>
          </td>
          <td width="12%">
            <div align="center">&nbsp;</div>
          </td>
        </tr>
      <%  for(int i=0;i<funcList.length;i++)
          {
      %>
        <tr >
          <td width="16%"><%=funcList[i][0]%></td>
          <td width="32%">
          <%  if(funcList[i][2]==null) { %>&nbsp;
          <%  } else {  %><%=funcList[i][2]%><% } %>
          </td>
          <td width="40%">
          <%  if(funcList[i][3]==null) { %>&nbsp;
          <%  } else {  %><%=funcList[i][3]%><% } %>
          </td>
          <td width="12%">
            <div align="center"><a href="javascript:funcDelete('<%=funcList[i][0]%>')">[Del]</a></div>
          </td>
        </tr>
      <% } %>
      </table>
    </td>
  </tr>
  <tr>
    <td height="112">
      <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#6666FF" bordercolordark="#FFFFFF">
        <form name="funcAdd" method="post" action="funcManager.jsp?action=add" onSubmit="return validateForm()">
          <tr>
            <td width="29%" height="31"><font size="3">FuncID: 
              <input type="text" name="funcID" maxlength="20" size="8">
              </font></td>
            <td width="55%" height="31"><font size="3">Module: 
              <select name="moduleID">
                <option value=0>--select--</option>
              <%  for(int i=0;i<moduleList.length;i++)
                  {
              %>
                    <option value="<%=moduleList[i][0]%>"><%=moduleList[i][1]%></option>
              <%  }  %>
              </select>
              </font></td>
            <td rowspan="2" height="61" valign="bottom" width="16%"> 
              <input type="submit" name="Submit" value="Submit">
            </td>
          </tr>
          <tr valign="top">
            <td width="29%" height="30" valign="middle">
              <div align="right"><font size="3">Description: </font></div>
            </td>
            <td width="55%" height="30"> <font size="3"> 
              <textarea name="descr" cols="40">
</textarea>
              </font></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
  <form name="funcDel" method="post" action="funcManager.jsp?action=delete">
    <input type="hidden" name="funcID">
  </form>
</table>
</body>
</html>

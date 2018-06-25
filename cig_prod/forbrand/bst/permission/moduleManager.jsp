<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" %>
<jsp:useBean id="moduleManager" scope="request" class="com.cig.permission.ModuleManager" />
<jsp:useBean id="grantInfo" scope="request" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String functionID;
%>
<%
  functionID = "fnModuMg";
  userID = (String)session.getValue("operator");
  grantInfo.setFuncID(functionID);
  grantInfo.setUserID(userID);
  isPermitted = grantInfo.isPermitted();
  if((!isPermitted)||(!userID.equals("cig"))) {
%>
<jsp:forward page="../BackResultsError.jsp?message=Sorry! You have no permission!" />
<%  } %>


<%! String action,moduleID,moduleName,descr;
    String[][] moduleList;
%>
<%
  try
  {
    action = request.getParameter("action");
    if(action!=null && action.equals("add"))
    {
      moduleName = request.getParameter("moduleName");
      descr = request.getParameter("descr");
      moduleManager.setModuleName(moduleName);
      moduleManager.setDescr(descr);
      moduleManager.moduleAdd();
    }
    if(action!=null && action.equals("delete"))
    {
      moduleID = request.getParameter("moduleID");
      moduleManager.setModuleID(moduleID);
      moduleManager.moduleDelete();
    }
    moduleList = moduleManager.getModules();
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
    if(document.moduleAdd.moduleName.value == "")
    {
      alert("Please input Module name !");
      document.moduleAdd.moduleName.focus();
      return false;
    }
  }

  function moduleDelete(tempModuleID)
  {
    document.moduleDel.moduleID.value = tempModuleID;
    if(confirm("Do you want to delete this module?"))
      document.moduleDel.submit();
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
    <td height="110"> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF
      cellpadding=5 cellspacing=2 width=469>
        <tr bgcolor="#FFFFFF">
          <td height="30" colspan="5" align="center">Module Manager</td>
        </tr>
        <tr bgcolor="#FFFFFF"><font size="3">
          <td width="97" height="24"> 
            <div align="center"><h4>Module Name</h4></div>
          </td>
          <td width="177" height="24"> 
            <div align="center">Description</div>
          </td>
          <td width="40" height="24">&nbsp;</td>
        </font></tr>
        <%  for(int i=0;i<moduleList.length;i++)
            {
      %>
        <tr bgcolor="#FFFFFF"><font size="3">
          <td height="24" width="97">
          <%  if(moduleList[i][1]==null) { %>&nbsp;
          <%  } else { %><%=moduleList[i][1]%><%  } %>
          </td>
          <td height="24" width="177">
          <%  if(moduleList[i][2]==null) { %>&nbsp;
          <%  } else { %><%=moduleList[i][2]%><%  } %>
          </td>
          <td height="24" width="29"> 
            <div align="center"><font size="2"><a href="javascript:moduleDelete('<%=moduleList[i][0]%>')">[Del]</a></font></div>
          </td>
          </font> </tr>
      <%  }  %>
      </table>
    </td>
  </tr>
  <tr>
    <td height="106"> 
      <table width="99%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#6666FF" bordercolordark="#FFFFFF" height="71">
        <form name="moduleAdd" method="post" action="moduleManager.jsp?action=add" onSubmit="return validateForm()">
          <tr>
            <td width="33%" height="27">
              <div align="center"><font size="3">Module Name: </font></div>
            </td>
            <td height="27" valign="middle" width="53%">
              <div align="center"><font size="3">Description: </font> </div>
            </td>
            <td width="14%">&nbsp;</td>
          </tr>
          <tr valign="top"> 
            <td width="33%" height="50" valign="middle" rowspan="2"><font size="3"> 
              <input type="text" name="moduleName" size="20">
              </font></td>
            <td rowspan="2" height="50" valign="middle" width="53%">
              <textarea name="descr" rows="2" cols="28"></textarea>
            </td>
            <td rowspan="2" height="33" width="14%" valign="middle"> <font size="3"> 
              <input type="submit" name="Submit" value="Submit">
              </font></td>
          </tr>
          <tr valign="top"> </tr>
        </form>
      </table>
    </td>
  </tr>
  <form name="moduleDel" method="post" action="moduleManager.jsp?action=delete">
    <input type="hidden" name="moduleID">
  </form>
</table>
</body>
</html>

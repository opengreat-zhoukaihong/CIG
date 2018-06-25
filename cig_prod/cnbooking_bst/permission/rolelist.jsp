<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="../login/error.jsp"%>
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


<jsp:useBean id="role" scope="page" class="com.cig.permission.RoleManager" />
<jsp:useBean id="operator" scope="page" class="com.cig.permission.OperatorInfoBean" />
<html>
<head>
<title>Role Assignment</title>
<META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT"> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="/public.css">
</head>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr>
    <td valign="middle">
      <table width="80%" align="center">
        <tr bgcolor="#0066ff" valign="middle">
          <td class="white-title"  >
            <p>Role Assignment:</p>
          </td>
        </tr>
      </table>
      <br>
      <%! int row,i; %>
      <%! String roleid[][]; %>
      <% 
		  roleid = role.getRoles();
		  row = roleid.length;
      %>
      <form name="roleform" action="grantrole.jsp" method="post">
        <table class="black-m-text" align="center" width="80%">
          <tr bgcolor="#E1E0EF" bordercolor="#E1E0EF" class="dalei">
            <td width="5%"> </td>
            <td width="13%">&nbsp; Role_ID </td>
            <td width="28%">&nbsp; Role_Name </td>
            <td width="54%">&nbsp; Description </td>
          </tr>

          <% for(i=0;i<row;i++)
            {
  %>
          <tr>
            <td width="5%">
            <% if(operator.isRoleAssigned(request.getParameter("ope_ID"),roleid[i][0]))
               { %>
              <input type="Checkbox"  value="<%=roleid[i][0]%>" name="Checkbox" checked>
            <%  }
              else
                { %>
              <input type="Checkbox"  value="<%=roleid[i][0]%>" name="Checkbox">
            <%  } %>
            </td>
            <td width="13%">&nbsp;<%=roleid[i][0]%>
            <td width="28%">&nbsp;<%=(roleid[i][1]==null?"":roleid[i][1])%>
            <td width="54%">&nbsp;<%=(roleid[i][2]==null?"":roleid[i][2])%>
          </tr>
          <%  } %>
          <script type="text/javascript" language="JavaScript">
<!--

function grant()
{
	var irow=0
	for(i=0;i<<%=row%>;i++)
	{
		if(document.roleform.elements[i].checked)
		{
			document.all.roleids.value += document.roleform.elements[i].value
			document.all.roleids.value += ","
			irow++
		}
	}
	document.all.roleno.value = irow
	roleform.submit()
}

-->
</script>
          <tr>
            <td colspan="4">
              <input type="hidden" name="roleids" value="">
              <input type="hidden" name="roleno" value="">
              <input type="hidden" name="ope_ID" value="<%=request.getParameter("ope_ID")%>">
            </td>
          </tr>
          <tr>
            <td colspan="4" align="center">
              <input type="button"  onClick="grant()" name="btn" value="Grant">
            </td>
          </tr>
        </table>
      </form>
<br>
      <table width="80%" align="center">
        <tr bgcolor="#0066ff" valign="middle">
          <td class="bottom-menu"  >
            <p class="white-title" align="right"> &gt;&gt;<a href="javascript:window.close()"><font color="#FFFFFF">Close</font></a>&lt;&lt;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

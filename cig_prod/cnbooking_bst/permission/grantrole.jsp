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

<jsp:useBean id="operator" scope="page" class="com.cig.permission.OperatorInfoBean" />
<jsp:useBean id="strconvert" scope="page" class="com.cnbooking.bst.member.StringConvert" />
<%! String[] roleids; %>
<%! String rolestr,oid; %>
<%! int roleno,i; %>
<%  rolestr = request.getParameter("roleids");
    roleno = (Integer.valueOf(request.getParameter("roleno"))).intValue();
    oid = request.getParameter("ope_ID");
    roleids = strconvert.convertToArray(rolestr,roleno);
    operator.deleteOperatorRole(oid);
    for(i=0;i<roleno;i++)
    {	
      operator.grantOperator(oid,roleids[i]);
    }
%>
<html>
<head>
	<title>Grant Role Result</title>
<META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT"> 
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
        <table class="black-m-text" align="center" width="80%">
          <tr class="dalei">
            <td width="5%">You have successfully assigned roles for this Operator. </td>
          </tr>
        </table>

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

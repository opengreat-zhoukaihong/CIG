<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="../login/error.jsp"%>
<% if(session.getAttribute("operator")==null) {%>
<jsp:forward page="../bst/BackResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnOpeMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../bst/BackResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>

<jsp:useBean id="operator" scope="page" class="com.forbrand.member.OperatorInfoBean" />
<jsp:useBean id="strconvert" scope="page" class="com.forbrand.member.StringConvert" />
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
<link rel="stylesheet" href="../../public.css">
</head>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr>
    <td valign="middle">
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle">
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
        <tr bgcolor="#003399" valign="middle">
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

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

<jsp:useBean id="operator" scope="request" class="com.forbrand.member.OperatorInfoBean"/>
<jsp:setProperty name="operator" property="*"/>

<html>
<head>
<title>Answer Question</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../public.css">
<script src="/js/formcheck.js"></script>
</head>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr> 
    <td valign="middle"> 
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="white-title"  > 
            <p>Answer Question:</p>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr> 
            <td class="bottom-menu" colspan="3" > 
<% if(operator.modifyOperator())
	{	%> 
<p align="center"><span class="contact">You have successfully modified this operator's 
  information. </span>
  <script language="JavaScript">
  	opener.document.emptyform.submit()
  </script>
<%	}	
	else
	{	%> </p>
<p align="center"><span class="contact">You failed to modify this operator's information. 
  Please contact the webmaster.</span> <%	}	%> </p>
            </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="bottom-menu"  > 
            <p class="white-title" align="right"> &gt;&gt;<a href="javascript:window.close()"><font color="#FFFFFF">Go 
              Back</font></a>&lt;&lt;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

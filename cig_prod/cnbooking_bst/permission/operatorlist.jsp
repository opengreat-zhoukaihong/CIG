<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java"%>
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


<jsp:useBean id="operator" scope="request" class="com.cig.permission.OperatorInfoBean"/>
<% if(request.getParameter("deleid")!="" && request.getParameter("deleid")!=null)
	{
		operator.deleteOperator(request.getParameter("deleid"));
	}	%>
<%! int row,i; %>
<%! String[] opeids; %>
<% row=operator.getAllOpe(); %>
<% opeids=operator.getOpeIDs(); %>
<html>
<head>
	<title>Operator List</title>
<META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT"> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="/public.css">
</head>
<body bgcolor="#FFFFFF">
<script language="JavaScript">
	function modify(opeid)
	{
		topurl = "modifyoperator.jsp?ope_ID="+opeid
		js_callpage(topurl)
	}
	
	function grant(opeid)
	{
		js_callpage("rolelist.jsp?ope_ID="+opeid)
	}
	
	function deleope(opeid)
	{
		if(confirm("Are you sure to delete this operator?"))
		{
			document.all.deleid.value = opeid
			document.emptyform.submit()
		}
		
	}
	
	function js_callpage(htmlurl) {
	  var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=566,height=327");
	  return false;
	}
	
</script>
<table class="black-m-text" width="506" align="center">
  <tr bgcolor="#0066ff" class="white-title" align="left"> 
    <td width="55">&nbsp;Ope_ID</td>
    <td width="62">&nbsp;Name</td>
    <td width="71">&nbsp;Tel</td>
    <td width="73">&nbsp;Email</td>
    <td width="99">&nbsp;Description</td>
    <td width="37">&nbsp;Status</td>
    <td width="37" colspan=3 align="center">&nbsp;Function 
  </tr>
  <% for(i=0;i<row;i++)
        {
          operator.getOperatorInfo(opeids[i]);
      %> 
  <tr bgcolor="#E1E0EF" class="black-m-text"> 
    <td width="55">&nbsp;<%=operator.getOpe_ID()%></td>
    <td width="62">&nbsp;<%=operator.getName()%></td>
    <td width="71">&nbsp;<%=operator.getTel()%></td>
    <td width="73">&nbsp;<%=operator.getEmail()%></td>
    <td width="99">&nbsp;<%=operator.getDescr()%></td>
    <td width="37">&nbsp;<%=operator.getStatus()%></td>
    <td width="37">&nbsp;[<a href="javascript:modify('<%=operator.getOpe_ID()%>')">modi</a>] 
    </td>
    <td width="36">&nbsp;[<a href="javascript:grant('<%=operator.getOpe_ID()%>')">grant</a>] 
    </td>
    <td width="36">&nbsp;[<a href="javascript:deleope('<%=operator.getOpe_ID()%>')">dele</a>] 
    </td>
  </tr>
  <%  } %> 
</table>
    <form action="operatorlist.jsp" name="emptyform" method="post"> <input type="hidden" name="deleid" value=""></form>

</body>
</html>

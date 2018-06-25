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
<% if(request.getParameter("deleid")!="")
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
<link rel="stylesheet" href="../../public.css">
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
  <tr bgcolor="#000099" class="white-title"> 
    <td width="55">&nbsp;Ope_ID</td>
    <td width="62">&nbsp;Name</td>
    <td width="71">&nbsp;Tel</td>
    <td width="73">&nbsp;Email</td>
    <td width="99">&nbsp;Description</td>
    <td width="37">&nbsp;Status</td>
    <td width="37">&nbsp;Modify</td>
    <td width="36">&nbsp;Grant</td>
    <td width="36">&nbsp;Delete</td>
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
    <td width="37">&nbsp; 
      <input type="Radio" value="<%=operator.getOpe_ID()%>" onClick="modify(this.value)" name="modi">
    </td>
    <td width="36">&nbsp; 
      <input type="Radio" value="<%=operator.getOpe_ID()%>" onClick="grant(this.value)" name="gran">
    </td>
    <td width="36">
	 <input type="Radio" value="<%=operator.getOpe_ID()%>" onClick="deleope(this.value)" name="dele">
	</td>
  </tr>
  <%  } %> 
</table>
    <form action="operatorlist.jsp" name="emptyform" method="post"> <input type="hidden" name="deleid" value=""></form>

</body>
</html>

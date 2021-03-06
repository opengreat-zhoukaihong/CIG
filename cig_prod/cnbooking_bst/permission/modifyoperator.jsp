<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="../bst/error.jsp"%>
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
<% operator.getOperatorInfo(request.getParameter("ope_ID")); %>

<html>
<head>
<title>Modify Operator Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT"> 
<link rel="stylesheet" href="/public.css">
<script language="JavaScript" src="../../js/formcheck.js"></script>
<script language="JavaScript">
	function checkAll()
	{
		if(document.all.email.value!=""&&!checkEmail(document.all.email))
		{
			alert("Invalaid Email Address!")
			return false
		}
		document.modiform.submit()
	}
</script>

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
<p class="contact" align="center">Modify Operator's Infomation</p>
<form name="modiform" method="post" action="opemodify.jsp">
  <table border="0" class="black-m-text" width="64%" align="center" height="176">
    <tr> 
      <td width="17%" height="8"><b>Name:</b></td>
      <td width="37%" height="8"> 
        <input type="text" name="name" width=20 maxlength=20 value="<%=operator.getName()%>">
      </td>
      <td width="46%" height="8">(The true name of operator.)</td>
    </tr>
    <tr> 
      <td width="17%" height="13"><b>Telephone:</b></td>
      <td width="37%" height="13"> 
        <input type="text" name="tel" width=20 maxlength=20 value="<%=operator.getTel()%>">
      </td>
      <td width="46%" height="13">&nbsp; 
        <input type="hidden" name="ope_ID" value="<%=request.getParameter("ope_ID")%>">
      </td>
    </tr>
    <tr> 
      <td width="17%" height="7"><b>Email:</b></td>
      <td width="37%" height="7"> 
        <input type="text" name="email" width=20 maxlength=20 value="<%=operator.getEmail()%>">
      </td>
      <td width="46%" height="7">&nbsp;</td>
    </tr>
    <tr> 
      <td width="17%" height="45"><b>Description:</b></td>
      <td width="37%" height="45"> 
        <textarea cols="20" rows="4" name="descr" ><%=operator.getDescr()%></textarea>
      </td>
      <td width="46%" height="45">(The additional information of operator.)</td>
    </tr>
    <tr> 
      <td colspan="3" height="11"> 
        <div align="center"><b><img src="/images/done-buttom.jpg" width="68" height="25" onClick="document.modiform.submit()" style="cursor: hand;"></b></div>
      </td>
    </tr>
  </table>
</form>
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

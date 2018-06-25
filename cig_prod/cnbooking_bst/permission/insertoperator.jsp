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


<html>
<head>
<title>Insert Operator</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT"> 
<link rel="stylesheet" href="/public.css">
<script language="JavaScript" src="../../js/formcheck.js"></script>
<script language="JavaScript">
	function checkAll()
	{
		if(document.all.ope_ID.value=="")
		{
			alert("Please enter Ope_ID!")
			return false
		}
		if(!isValidChar(document.all.ope_ID.value))
		{
			alert("Ope_ID should not have invalid characters!")
			return false
		}
		if(document.all.passwd.value=="")
		{
			alert("Passwd should not be empty!")
			return false
		}
		if(document.all.passwd.value.length<6)
		{
			alert("Passwd should not less than 6 characters!")
			return false
		}
		if(!isValidChar(document.all.passwd.value))
		{
			alert("Passwd should not have invalid characters!")
			return false
		}
		if(!checkPasswd(document.all.passwd,document.all.passwdChk))
		{
			alert("The two Password are not same!")
			return false
		}
		if(document.all.email.value!=""&&!checkEmail(document.all.email))
		{
			alert("Invalaid Email Address!")
			return false
		}
		
		document.insertform.submit()
	}
</script>
</head>

<body bgcolor="#FFFFFF">

<p class="contact" align="center">Insert Operator:</p>
<form name="insertform" method="post" action="opeinsert.jsp">
  <table border="0" class="black-m-text" width="606" height="266" align="center">
    <tr> 
      <td width="22%" height="17"><b>Ope_ID:<font color="#FF0000">*</font></b></td>
      <td width="31%" height="17"> 
        <input type="text" name="ope_ID" width=20 maxlength=20 value="">
      </td>
      <td width="47%" height="17">(The login name of operator.)</td>
    </tr>
    <tr> 
      <td width="22%" height="9"><b>Passwd:<font color="#FF0000">*</font></b></td>
      <td width="31%" height="9"> 
        <input type="Password" name="passwd" width=20 maxlength=20 value="">
      </td>
      <td rowspan="2" width="47%">(Must be at least six (6) characters long, 
        may contain numbers (0-9) and upper and lowercase letters (A-Z, a-z), 
        but no spaces. )</td>
    </tr>
    <tr> 
      <td width="22%" height="7"><b>ReEnter Password:<font color="#FF0000">*</font></b></td>
      <td width="31%" height="7"> 
        <input type="Password" name="passwdChk" width=20 maxlength=20 value="">
      </td>
    </tr>
    <tr> 
      <td width="22%" height="10"><b>Name:</b></td>
      <td width="31%" height="10"> 
        <input type="text" name="name" width=20 maxlength=20 value="">
      </td>
      <td width="47%" height="10">(The true name of operator.)</td>
    </tr>
    <tr> 
      <td width="22%" height="3"><b>Telephone:</b></td>
      <td width="31%" height="3"> 
        <input type="text" name="tel" width=20 maxlength=20 value="">
      </td>
      <td width="47%" height="3">&nbsp;</td>
    </tr>
    <tr> 
      <td width="22%" height="2"><b>Email:</b></td>
      <td width="31%" height="2"> 
        <input type="text" name="email" width=20 maxlength=20 value="">
      </td>
      <td width="47%" height="2">&nbsp;</td>
    </tr>
    <tr> 
      <td width="22%" height="72"><b>Description:</b></td>
      <td width="31%" height="72"> 
        <textarea cols="20" rows="4" name="descr" value=""></textarea>
      </td>
      <td width="47%" height="72">(The additional information of operator.)</td>
    </tr>
    <tr> 
      <td colspan="3" height="19"> 
        <div align="center"><b><img src="/images/done-buttom.jpg" width="68" height="25" onClick="document.insertform.submit()" style="cursor: hand;"></b></div>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

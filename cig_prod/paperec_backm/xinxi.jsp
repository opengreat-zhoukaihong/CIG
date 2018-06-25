<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="login.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  boolean isPermitted;
  String userID;
  String funcId;

  funcId = "fnMemberMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<%@ page  language="java" %>
<jsp:useBean id="memb" scope="page" class="member.MemberBG" /> 
<jsp:setProperty name="memb" property="*" />
<%
  String[] submit=new String[7];
  submit[0]=request.getParameter("buy_sale_flag");
  submit[1]=request.getParameter("name");
  submit[2]=request.getParameter("address1");
  submit[3]=request.getParameter("address2");
  submit[4]=request.getParameter("bank");
  submit[5]=request.getParameter("pri_user_id");
  submit[6]=request.getParameter("old_user_id");
%>

<script language="javascript">
   function back(){
    window.history.back()
    }
</script>   
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中国纸网后台管理系统</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "宋体"; font-size: 9pt}
.title12 {  font-family: "宋体"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "宋体"; text-decoration: underline}
a:visited {  font-family: "宋体"; text-decoration: underline}
a:active {  font-family: "宋体"; text-decoration: underline}
a:hover {  font-family: "宋体"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>    
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <form method="post" action="">
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" height="300" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr align="center"> 
            <td class="title12" height="249"><%=memb.getSubmit(submit)%></td>
          </tr>
          <tr align="center"> 
            <td class="title12">
            <a href="" onclick="javascript:back()">  <input type="image" border="0" name="imageField" src="../images/back.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
        <br>
        <br>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>
</jsp:useBean>
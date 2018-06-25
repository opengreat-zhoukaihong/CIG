 
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

  funcId = "fnEquipMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>


<%@ page import="java.util.*" %>
<%@ page import="equipment.*" %>

<jsp:useBean id="EquipType" scope="page" class="equipment.EquipType" /> 
<jsp:setProperty name="EquipType" property="cateId"/>

<%
    boolean canDel = EquipType.checkDelCond();
    String str ="";
    if (canDel) {
%>
	<jsp:forward page="equip_type_list.jsp" />
	</jsp:forward>    	
<%  }else{
	str = EquipType.getReturnStr();
    }
%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr> 
    
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <form method="post" action="">
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" height="300" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr align="center"> 
            <td class="title12" height="249"><%=str%></td>
          </tr>
          <tr align="center"> 
            <td class="title12">
              <a href="#" onclick="javascript:window.history.go(-1)"><input type="image" border="0" name="imageField" src="../images/back.gif" width="68" height="26"></a>
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

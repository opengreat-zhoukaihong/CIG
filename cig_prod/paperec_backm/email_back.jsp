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

  funcId = "fnConInfMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>

<%@ page  %>
<jsp:useBean id="im" scope="page" class="postcenter.InserMessage" />
<% 
   String title=request.getParameter("title");
   String detial=request.getParameter("detial");
   String cb1=request.getParameter("cb1");
   String cb2=request.getParameter("cb2");
   String cb3=request.getParameter("cb3");
   if(cb1==null)cb1="N";
   if(cb2==null)cb2="N";
   if(cb3==null)cb3="N";
   im.setTitle(title);
   im.setDetail(detial);
   im.getUserMessEmail(cb1,cb2,cb3);
%>
<script language="javascript">
  function winclose(){
    window.close();
  }
</script>
<html><!-- #BeginTemplate "/Templates/backm_paperec.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>�й�ֽ����̨����ϵͳ</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "����"; font-size: 9pt}
.title12 {  font-family: "����"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "����"; text-decoration: underline}
a:visited {  font-family: "����"; text-decoration: underline}
a:active {  font-family: "����"; text-decoration: underline}
a:hover {  font-family: "����"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257"> 
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" -->
      <form method="post" action="">
        <br>
        <table width="477" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF" height="314">
          <tr align="center"> 
            <td colspan="2" height="214">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��Ϣ��ȷ���͡� </td>
          </tr>
          <tr align="center"> 
            <td colspan="2" height="2"><a href="javascript:winclose()">�˳� </a></td>
          </tr>
        </table>
        <br>
        <br>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>
<% im.getDestroy();%>
</jsp:useBean>
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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>


<%@ page import="java.util.*" %>
<%@ page import="member.*" %>

<jsp:useBean id="CompanyReaList" scope="page" class="member.CompanyReaList" /> 
<jsp:setProperty name="CompanyReaList" property="companyId"/>
<jsp:setProperty name="CompanyReaList" property="action"/>



<%
   int rea_count;
   String[][] rea_list;
   
   CompanyReaList.initRea();

   CompanyReaList.retriveReaList();
   rea_count = CompanyReaList.getReaCount();
   rea_list = CompanyReaList.getReaList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.reaForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
        
    function confirmDelete(){

          return confirm("��ȷ��ɾ���˴˹�˾������?")

    }
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>
      <form method="reaForm" action="">
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="3" class="title12">������˾�б�</td>
          </tr>
          <tr> 
            <td align="center"><b>������˾ID</b></td>
            <td align="center"><b>������˾����</b></td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td align="center"><a href="#">009</a></td>
            <td align="center">dfhsdh</td>
            <td align="center"><a href="#">ɾ��</a></td>
          </tr>
          <tr> 
            <td align="center"><a href="#">009</a></td>
            <td align="center">dfhsdh</td>
            <td align="center"><a href="#">ɾ��</a></td>
          </tr>
          <tr> 
            <td align="center"><a href="#">009</a></td>
            <td align="center">dfhsdh</td>
            <td align="center"><a href="#">ɾ��</a></td>
          </tr>
          <tr align="center"> 
            <td colspan="3">���������˾�� 
              <select name="select">
              </select>
              <input type="image" border="0" name="imageField" src="../images/addguanlian.gif" width="90" height="23">
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

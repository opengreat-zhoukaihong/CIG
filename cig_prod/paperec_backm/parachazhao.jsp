
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

  funcId = "fnSysMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>
 
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
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

<SCRIPT LANGUAGE="Javascript">
        
    function submitThis(){  
        var mf=document.lbSelectForm;     
 
      	mf.submit();

    }
     
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" -->
      <form name="lbSelectForm" method="post" action="xitongcslb.jsp?action=&">     
        <br>
        <table width="450" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr>
            <td class="title12">��ѡ��ϵͳ�������</td>
          </tr>
          <tr align="center"> 
            <td> 
              <select name="id">
              <option value="1" selected> ���� </option>
              <option value="2"> ֧����ʽ </option>
              <option value="3"> ��Ʒ��� </option>
              <option value="4"> �ۿ� </option>
              <option value="5"> ��Ϣ��Դ </option>
              <option value="6"> ״̬ </option>
              <option value="7"> ���� </option>
              <option value="8"> ����ְ�� </option>
              <option value="9"> ��ҵ </option>
              <option value="10"> ISO��֤ </option>
              <option value="11"> ����ְ�� </option>
              <option value="12"> ��ƷƷ�� </option>
              <option value="13"> ���ʽ </option>
              <option value="14"> �۸����� </option>
              <option value="15"> ���ö� </option>
              <option value="16"> ��Ʊ��֧������ </option>
              <option value="17"> ����֤���� </option>
              <option value="18"> ��ҵ��ģ </option>
              <option value="19"> ��Ӫҵ�� </option>
              <option value="20"> �ʺ����� </option>
              <option value="21"> ����Ŀǰ״̬ </option>
              </select>
              <a href="" onClick="javascript:submitThis()"><input type="image" border="0" name="imageField" src="../images/jixu.gif" width="68" height="26">
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

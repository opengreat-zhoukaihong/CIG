 
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

  funcId = "fnContractMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>


<SCRIPT LANGUAGE="Javascript">
        
    function makeHref(){  
        var mf=document.listForm;
        var para = mf.str.value;
                
      	mf.action = "htmuban_lb.jsp" + para;

	mf.submit();
        
     }
     

</SCRIPT>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" -->
      <form name="listForm" method="post" action="">
        <br>
        <table width="450" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr>
            <td class="title12">��ѡ���ͬģ�壺</td>
          </tr>
          <tr align="center"> 
            <td> 
              <select name="str">
              <option value="?contFlag=1&langCode=GB">����ó�׺�ͬģ��</option>
              <option value="?contFlag=3&langCode=GB">����ó�׺�ͬģ�� <����></option>
	      <option value="?contFlag=3&langCode=EN">����ó�׺�ͬģ�� <Ӣ��></option>
              </select>
              <a href="#" onClick="javascript:makeHref()"><input type="image" border="0" name="imageField" src="../images/jixu.gif" width="68" height="26"></a>
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

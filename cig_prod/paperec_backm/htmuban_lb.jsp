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

<%@ page import="java.util.*" %>
<%@ page import="transaction.*" %>

<jsp:useBean id="ContTempList" scope="page" class="transaction.ContTempList" /> 
<jsp:setProperty name="ContTempList" property="contFlag"/>
<jsp:setProperty name="ContTempList" property="langCode"/>

<jsp:useBean id="ContTemp" scope="page" class="transaction.ContTemp" /> 
<jsp:setProperty name="ContTemp" property="action"/>
<jsp:setProperty name="ContTemp" property="contFlag"/>
<jsp:setProperty name="ContTemp" property="langCode"/>
<jsp:setProperty name="ContTemp" property="sno"/>
<jsp:setProperty name="ContTemp" property="editDispCont"/>


<%
   String cont_flag = request.getParameter("contFlag");
   String lang_code = request.getParameter("langCode");
   int temp_count;
   String[][] temp_list;
      
   ContTemp.initContTemp();   
   
   ContTempList.getTempList();
   
   temp_count = ContTempList.getTempCount();
   temp_list = ContTempList.getTempList();
%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>
      <table width="500" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
        <tr> 
          <td colspan="4" class="title12">��ͬģ���б�</td>
        </tr>
        <tr> 
          <td width="40" align="center"><b>��ʾ���</b></td>
          <td width="250" align="center"><b>��ʾ����</b></td>
          <td width="40" align="center"><b>ȡֵ��־</b></td>
          <td width="40">&nbsp;</td>
        </tr>
        <%
            for (int i=0;i<temp_count;i++){
        %>
        <tr align="center"> 
          <td width="40"><%=temp_list[i][0]%></td>
          <td width="250"><%=temp_list[i][1]%></td>
          <td width="40"><%=temp_list[i][2]%></td>
          <td width="40"><a href="htmuban_edit.jsp?contFlag=<%=cont_flag%>&langCode=<%=lang_code%>&sno=<%=temp_list[i][0]%>">�༭</a></td>
        </tr>
        <%  } %>
      </table>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

<%--  @# hetonglieb.jsp Ver.1.3 --%>
]
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


<%@ page import="postcenter.*, product.*" %>
<jsp:useBean id="HetongliebPage" scope="page" class="backpage.HetongliebPage" /> 
<jsp:setProperty name="HetongliebPage" property="langCode" value="GB"/>
<jsp:setProperty name="HetongliebPage" property="postingId"/>
<jsp:setProperty name="HetongliebPage" property="bidId"/>
<jsp:setProperty name="HetongliebPage" property="companyId"/>
<jsp:setProperty name="HetongliebPage" property="userId"/>
<jsp:setProperty name="HetongliebPage" property="contId"/>
<jsp:setProperty name="HetongliebPage" property="crDateFrom"/>
<jsp:setProperty name="HetongliebPage" property="crDateTo"/>
<jsp:setProperty name="HetongliebPage" property="status"/>
<jsp:setProperty name="HetongliebPage" property="crUserId"/>

<% 
    String[][] contItems = HetongliebPage.getContItems();
%>

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
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
        <tr> 
          <td colspan="9" class="title12">��ͬ�б�</td>
        </tr>
        <tr align="center"> 
          <td width="64"><b>��ͬ��</b></td>
          <td width="25"><b>����</b></td>
          <td width="57"><b>��ͬ״̬</b></td>
          <td width="61"><b>������</b></td>
          <td width="69"><b>��ۺ�</b></td>
          <td width="86"><b>������˾����</b></td>
          <td width="51"><b>����ǩ��</b></td>
          <td width="69"><b>�򷽹�˾����</b></td>
          <td width="61"><b>��ǩ��</b></td>
        </tr>
    <% for(int i=0; i<contItems.length; i++) {
           String status = "";
           if (contItems[i][2].equals("Y")) 
               status = "�Ѿ��˿�";
           else if (contItems[i][2].equals("N")) 
               status = "��δ�˿�";
           else if (contItems[i][2].equals("C")) 
               status = "ȡ��";
           else if (contItems[i][2].equals("F")) 
               status = "�Ѿ�����";
    %>
        <tr align="center"> 
          <td width="64">&nbsp;<a href="hetong.jsp?contId=<%=contItems[i][0]%>&langCode=<%=contItems[i][1]%>"><%=contItems[i][0]%></a></td>
          <td width="25">&nbsp;<%=contItems[i][1]%></td>
          <td width="57">&nbsp;<%=status%></td>
          <td width="61">&nbsp;<%=contItems[i][3]%></td>
          <td width="69">&nbsp;<%=contItems[i][4]%></td>
          <td width="86">&nbsp;<%=contItems[i][5]%></td>
          <td width="51">&nbsp;<%=contItems[i][6]%></td>
          <td width="69">&nbsp;<%=contItems[i][7]%></td>
          <td width="61">&nbsp;<%=contItems[i][8]%></td>
        </tr>
    <% }%>
      </table>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

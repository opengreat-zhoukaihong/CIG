<%--  @# memberuser_cpzllb.jsp Ver.1.1 --%>

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

<%@ page import="postcenter.*" %>
<jsp:useBean id="MemberuserCpzllbPage" scope="page" class="backpage.MemberuserCpzllbPage" />
<jsp:setProperty name="MemberuserCpzllbPage" property="langCode" value="GB" />
<jsp:setProperty name="MemberuserCpzllbPage" property="action" />
<jsp:setProperty name="MemberuserCpzllbPage" property="companyId" />
<jsp:setProperty name="MemberuserCpzllbPage" property="productId" />
<%
    boolean b = MemberuserCpzllbPage.process();
    String[][] perProdItems = MemberuserCpzllbPage.getPerProdItems();
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
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="9" class="title12">��Ա��Ʒ�����б�</td>
          </tr>
          <tr align="center"> 
            <td><b>��˾ID</b></td>
            <td><b>��ƷID</b></td>
            <td><b>��Ʒ����</b></td>
            <td><b>��ƷƷ��</b></td>
            <td><b>����</b></td>
            <td><b>�������</b></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
	<% for (int i=0; i<perProdItems.length; i++) {%>
          <tr align="center"> 
            <td>&nbsp;<%=perProdItems[i][5]%></td>
            <td>&nbsp;<%=perProdItems[i][0]%></td>
            <td>&nbsp;<%=perProdItems[i][1]%></td>
            <td>&nbsp;<%=perProdItems[i][2]%></td>
            <td>&nbsp;<%=perProdItems[i][3]%></td>
            <td>&nbsp;<%=perProdItems[i][4]%></td>
            <td><a href="memberuser_cpzllb.jsp?companyId=<%=MemberuserCpzllbPage.getCompanyId()%>&action=approve&productId=<%=perProdItems[i][0]%>">��׼����</a></td>
            <td><a href="memberuser_cpzllb.jsp?companyId=<%=MemberuserCpzllbPage.getCompanyId()%>&action=deapprove&productId=<%=perProdItems[i][0]%>">�ܾ�����</a></td>
            <td><a href="memberuser_cpzlwh.jsp?action=edit&productId=<%=perProdItems[i][0]%>">�༭</a></td>
          </tr>
        <% } %>
          <tr align="center"> 
            <form method="post" action="memberuser_cpzlwh.jsp?action=insert">
            <td colspan="9">
              ��˾ID: 
              <input type="text" name="companyId" size="10"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="image" src="../images/add.gif" width="68" height="26" border="0">
            </td>
            </form>
          </tr>
        </table>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

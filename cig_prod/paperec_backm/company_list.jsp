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


<jsp:useBean id="CompanyList" scope="page" class="member.CompanyList" />
<jsp:setProperty name="CompanyList" property="fromDate" />
<jsp:setProperty name="CompanyList" property="toDate" />
<jsp:setProperty name="CompanyList" property="buySaleFlag" />
<jsp:setProperty name="CompanyList" property="approved" />
<jsp:setProperty name="CompanyList" property="companyId" />
<jsp:setProperty name="CompanyList" property="country" />
<jsp:setProperty name="CompanyList" property="state" />
<jsp:setProperty name="CompanyList" property="city" />
<jsp:setProperty name="CompanyList" property="langCode" />
<jsp:setProperty name="CompanyList" property="companyName" />
<jsp:setProperty name="CompanyList" property="priUserId" />

<%
    int company_count=0;
    String[][] company_list;
    
    CompanyList.retriveCompanyList();
    
    company_count=CompanyList.getCompanyCount();
    company_list = CompanyList.getCompanyList();
    
 %>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --> <br>
      <br>
      <table width="600" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#4078e0" bordercolordark="#FFFFFF" align="center">
        <tr> 
          <td colspan="8" class="title12">��Ա��˾��ѯ�б�</td>
        </tr>
        <tr align="center"> 
          <td width="70"><b>��˾ID</b></td>
          <td width="89"><b>��˾����</b></td>
          <td width="74"><b>����</b></td>
          <td width="62"><b>��/����</b></td>
          <td width="53"><b>��׼״̬</b></td>
          <td width="68"><b>��Ҫ��ϵ��</b></td>
          <td width="31"><b>&nbsp;</b></td>
          <td width="71">&nbsp;</td>
        </tr>
        <% for (int i=0;i<company_count;i++){
        %>
        <tr> 
          <td width="70" align="center"><a href="membercompany_dedail.jsp?trans=&act=comp&company_id=<%=company_list[i][0]%>&lang_code=GB"><%=company_list[i][0]%></a></td>
          <td width="89" align="center"><%=company_list[i][1]%></td>
          <td width="74" align="center"><%=company_list[i][2]%></td>
          <td width="62" align="center"><%=company_list[i][3]%></td>
          <td width="53" align="center"><%=company_list[i][4]%></td>
          <td width="68" align="center"><a href="memberusers_detail.jsp?act=comp&user_id=<%=company_list[i][5]%>&lang_code=GB"><%=company_list[i][5]%></a></td>
          <td width="31" align="center"><a href="membercompany_dedail.jsp?trans=&act=comp&company_id=<%=company_list[i][0]%>&lang_code=GB">�༭</a></td>
          <td width="71" align="center"><a href="memberusers_lb.jsp?act=comp&company_id=<%=company_list[i][0]%>&lang_code=GB">�鿴�û�</a></td>
        </tr>
        <% }%>
      </table>
      <br>
      <br>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

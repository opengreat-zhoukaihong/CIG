<%--  @# chanpindl_gglb.jsp Ver.1.1 --%>

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

  funcId = "fnCateMgr";
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
<jsp:useBean id="ChanpindlGglbPage" scope="page" class="backpage.ChanpindlGglbPage" />
<jsp:setProperty name="ChanpindlGglbPage" property="action" />
<jsp:setProperty name="ChanpindlGglbPage" property="cateId" />
<jsp:setProperty name="ChanpindlGglbPage" property="specId" />
<jsp:setProperty name="ChanpindlGglbPage" property="valueFlag" />
<jsp:setProperty name="ChanpindlGglbPage" property="required" />
<jsp:setProperty name="ChanpindlGglbPage" property="measFlag" />
<jsp:setProperty name="ChanpindlGglbPage" property="unitM" />
<jsp:setProperty name="ChanpindlGglbPage" property="unitI" />
<jsp:setProperty name="ChanpindlGglbPage" property="value1" />
<jsp:setProperty name="ChanpindlGglbPage" property="value2" />

<%
    ChanpindlGglbPage.process();
%>

<jsp:useBean id="SpecList" scope="page" class="postcenter.SpecList" />
<jsp:setProperty name="SpecList" property="langCode" value="GB" />
<jsp:setProperty name="SpecList" property="measureFlag" value="M"/>
<jsp:setProperty name="SpecList" property="cateId" />
<%
    Spec[] specItems = SpecList.fetchSpecItems();
%>

<jsp:useBean id="Category" scope="page" class="product.Category" />
<jsp:setProperty name="Category" property="langCode" value="GB" />
<jsp:setProperty name="Category" property="cateId" />

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

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>     
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form method="post" action="">
        <table width="650" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#4078e0" bordercolordark="#FFFFFF" align="center">
          <tr> 
            <td colspan="10" class="title12">��Ʒ�������б�</td>
          </tr>
          <tr> 
            <td colspan="10"><%= SpecList.getCateId() %>����<%= Category.getCategoryName() %></td>
          </tr>
          <tr align="center"> 
            <td width="61"><b>���ID</b></td>
            <td width="61"><b>�������</b></td>
            <td width="61"><b>�Ƿ�Ϊ����ȡֵ</b></td>
            <td width="109"><b>�Ƿ�Ϊ��Ҫ���</b></td>
            <td width="51"><b>����</b></td>
            <td width="58"><b>����</b></td>
            <td width="54"><b>������λ</b></td>
            <td width="38">&nbsp;</td>
            <td width="65">&nbsp;</td>
            <td width="65">&nbsp;</td>
          </tr>
	<% for (int i=0; i<specItems.length; i++) {%>
          <tr align="center"> 
            <td width="61">&nbsp;<%=specItems[i].specId%></td>
            <td width="61">&nbsp;<%=specItems[i].specName%></td>
            <td width="61">&nbsp;<%=specItems[i].specValFlag%></td>
            <td width="109">&nbsp;<%=specItems[i].specRequired%></td>
            <td width="51">&nbsp;<%=specItems[i].specValue1%></td>
            <td width="58">&nbsp;<%=specItems[i].specValue2%></td>
            <td width="54">&nbsp;<%=specItems[i].specUnit%></td>
            <td width="38"><a href="chanpindl_ggedit.jsp?cateId=<%=SpecList.getCateId()%>&specId=<%=specItems[i].specId%>&action=edit">�༭</a></td>
            <td width="65"><a href="chanpindl_gglb.jsp?cateId=<%=SpecList.getCateId()%>&action=delete&specId=<%=specItems[i].specId%>" onClick="return confirm('ȷʵҪɾ���˹������?')">ɾ��</a></td>
            <td width="65"><a href="chanpingg_canslb.jsp?cateId=<%=SpecList.getCateId()%>&specId=<%=specItems[i].specId%>">�༭������</a></td>
          </tr>
        <% } %>
          <tr align="center"> 
            <td colspan="10">
              <a href="chanpindl_ggedit.jsp?cateId=<%=SpecList.getCateId()%>&action=insert"><img src="../images/add.gif" width="68" height="26" border="0"></a>
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

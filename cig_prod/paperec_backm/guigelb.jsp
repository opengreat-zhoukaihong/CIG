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


<%@ page import="java.util.*" %>
<%@ page import="product.*" %>

<jsp:useBean id="SpecBaseList" scope="page" class="product.SpecBaseList" /> 

<jsp:useBean id="SpecBase" scope="page" class="product.SpecBase" /> 

<jsp:useBean id="SpecBaseHelper" scope="page" class="product.SpecBaseHelper" />
<jsp:setProperty name="SpecBaseHelper" property="action"/>
<jsp:setProperty name="SpecBaseHelper" property="specId"/>
<jsp:setProperty name="SpecBaseHelper" property="editSpecName"/>
<jsp:setProperty name="SpecBaseHelper" property="editSpecDesc"/>
<jsp:setProperty name="SpecBaseHelper" property="langCode"/>
 


<%
    SpecBase[] specbaselist;
    
    SpecBaseHelper.initSpecBase();
    
    specbaselist = SpecBaseList.getSpecBaseItems();
%>


<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.specBaseForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("��ȷ��ɾ���˹������?")

    }
</SCRIPT>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>    
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="specBaseForm" method="post" action="#">
            <input type="HIDDEN" name="action">
        <table width="650" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="6" class="title12" height="33">������б���</td>
          </tr>
          <tr align="center"> 
            <td width="40"><b>���ID</b></td>
            <td width="55"><b>���Դ���</b></td>
            <td width="60"><b>�������</b></td>
            <td width="60"><b>�������</b></td>
            <td width="40">&nbsp;</td>
            <td width="40">&nbsp;</td>
          </tr>
          <% for (int i=0;i<specbaselist.length;i++){%>
          <tr align="center"> 
            <td width="40"><%=specbaselist[i].specId%></a></td>
            <td width="55"><%=specbaselist[i].langCode%></td>
            <td width="60"><%=specbaselist[i].specName%></td>
            <td width="60"><%=specbaselist[i].specDesc%></td>
            <td width="40"><a href="guigeedit.jsp?specId=<%=specbaselist[i].specId%>&langCode=<%=specbaselist[i].langCode%>">�༭</a></td>
            <td width="40"><a href="guigelb.jsp?action=delete&specId=<%=specbaselist[i].specId%>" onClick="return confirmDelete()">ɾ��</a></td>
          </tr>
          <%  }%>
          <tr align="center"> 
            <td colspan="6"> ���Դ��� 
              <select name="langCode">
              <option value=GB selected> ���� </option>
              <option value=EN> Ӣ�� </option>
              </select>
              ������� 
              <input type="text" name="editSpecName" size="10">
              ������� 
              <input type="text" name="editSpecDesc" size="10">
              <a href="#" onClick="javascript:addSubmit()"><input type="image" border="0" name="imageField" src="../images/add.gif" width="68" height="26"></a>
              <a href="" onClick="javascript:reset()"><input type="image" border="0" name="imageField2" src="../images/cancle.gif" width="68" height="26"></a>
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
<!-- #EndTemplate --></html>

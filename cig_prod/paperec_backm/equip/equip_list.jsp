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

  funcId = "fnEquipMgr";
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
<%@ page import="equipment.*" %>

<jsp:useBean id="EquipCateList" scope="page" class="equipment.EquipCateList" /> 

<jsp:useBean id="EquipCate" scope="page" class="equipment.EquipCate" /> 
<jsp:setProperty name="EquipCate" property="action"/>
<jsp:setProperty name="EquipCate" property="cateName"/>
<jsp:setProperty name="EquipCate" property="langCode"/>
<jsp:setProperty name="EquipCate" property="cateId"/>




<%
   int cate_count;
   String[][] cate_list;

   EquipCate.initCate();

   EquipCateList.retriveCateList();
   cate_count = EquipCateList.getCateCount();
   cate_list = EquipCateList.getCateList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.cateForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
     
    function confirmDelete(){

          return confirm("��ȷ��ɾ���˴�����?")

    }
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>    
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="cateForm" method="post" action="equip_list.jsp">
      
      <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="8" class="title12" height="33">�豸�����б�
            </td>
          </tr>
          <tr align="center"> 
            <td width="80"><b>����ID</b></td>
            <td width="80"><b>���Դ���</b></td>
            <td width="160"><b>��������</b></td>
            <td width="80">&nbsp;</td>
            <td width="80">&nbsp;</td>
            <td width="140">&nbsp;</td>
          </tr>
          <%
            if (cate_count>0){
              for (int i=0;i<cate_count;i++){
          %>
          <tr align="center"> 
            <td width="80"><a href="#"><%=cate_list[i][0]%></a></td>
            <td width="80"><%=cate_list[i][1]%></td>
            <td width="160"><%=cate_list[i][2]%></td>
            <td width="80"><a href="equip_cate_edit.jsp?cateId=<%=cate_list[i][0]%>&langCode=<%=cate_list[i][1]%>">�༭</a></td>
            <td width="80"><a href="delete_cate.jsp?action=delete&cateId=<%=cate_list[i][0]%>" onClick="return confirmDelete()">ɾ��</a></td>
            <td width="140"><a href="equip_type_list.jsp?cateId=<%=cate_list[i][0]%>">�鿴��������</a></td>
          </tr>
          <%  }
            }
          %>
          <tr align="center"> 
            <td colspan="8"> ���Դ���
              <select name="langCode">
              <option value=GB selected> ���� </option>
              <option value=EN> Ӣ�� </option>
              </select>
              �������� 
              <input type="text" name="cateName" size="10">
              <a href="#" onClick="javascript:addSubmit()"><input type="image" border="0" name="imageField" src="/images/add.gif" width="68" height="26"></a>
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

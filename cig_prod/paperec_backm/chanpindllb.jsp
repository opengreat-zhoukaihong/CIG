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

<jsp:useBean id="CategoryList" scope="page" class="product.CategoryList" /> 
<jsp:setProperty name="CategoryList" property="classFlag"/>

<jsp:useBean id="Category" scope="page" class="product.Category" /> 
<jsp:setProperty name="Category" property="classFlag"/>
<jsp:setProperty name="Category" property="action"/>
<jsp:setProperty name="Category" property="cateName"/>
<jsp:setProperty name="Category" property="langCode"/>
<jsp:setProperty name="Category" property="cateId"/>




<%
   int cate_count;
   String[][] cate_list;
   String class_flag = request.getParameter("classFlag");
   
   if (class_flag.equals("")){
       CategoryList.setClassFlag("C");
       Category.setClassFlag("C");
   }

   Category.initCate();

   CategoryList.retriveCateList();
   cate_count = CategoryList.getCateCount();
   cate_list = CategoryList.getCateList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.cateForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function changeClassFlag(e){
    	var mf=document.cateForm;
    	if (e==1)
	    mf.classFlag.value = "C";
        else
            mf.classFlag.value = "E";
           
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
      <form name="cateForm" method="post" action="chanpindllb.jsp">
      
      <input type="HIDDEN" name="classFlag" value=<%=class_flag%>>
      <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="8" class="title12" height="33">��Ʒ�����б�
                <img src="../images/space.gif" width="150" height="1">
            	<a href="#" onClick="javascript:changeClassFlag(1)"><input type="image" src="../images/guoneiflbz.gif" width="90" height="23"></a>��
            	<a href="#" onClick="javascript:changeClassFlag(2)"><input type="image" src="../images/guowaiflbz.gif" width="90" height="23"></a>
            	<%=(class_flag.equals("C"))?"����":"����"%>
            </td>
          </tr>
          <tr align="center"> 
            <td width="61"><b>����ID</b></td>
            <td width="80"><b>���Դ���</b></td>
            <td width="78"><b>��������</b></td>
            <td width="54">&nbsp;</td>
            <td width="43">&nbsp;</td>
            <td width="51">&nbsp;</td>
            <td width="73">&nbsp;</td>
            <td width="78">&nbsp;</td>
          </tr>
          <%
            if (cate_count>0){
              for (int i=0;i<cate_count;i++){
          %>
          <tr align="center"> 
            <td width="61"><a href="#"><%=cate_list[i][0]%></a></td>
            <td width="80"><%=cate_list[i][1]%></td>
            <td width="78"><%=cate_list[i][2]%></td>
            <td width="54"><a href="chanpinedit.jsp?fromFlag=1&classFlag=<%=class_flag%>&cateId=<%=cate_list[i][0]%>&langCode=<%=cate_list[i][1]%>">�༭</a></td>
            <td width="43"><a href="deleteCate.jsp?classFlag=<%=class_flag%>&action=delete&cateId=<%=cate_list[i][0]%>" onClick="return confirmDelete()">ɾ��</a></td>
            <td width="51"><a href="chanpindl_gglb.jsp?cateId=<%=cate_list[i][0]%>">�鿴���</a></td>
            <td width="73"><a href="chanpinzllb.jsp?classFlag=<%=class_flag%>&cateId=<%=cate_list[i][0]%>">�鿴��������</a></td>
            <td width="78"><a href="chanpinfenleigllb.jsp?cateId=<%=cate_list[i][0]%>">�鿴�������</a></td>
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
              <a href="#" onClick="javascript:addSubmit()"><input type="image" border="0" name="imageField" src="../images/add.gif" width="68" height="26"></a>
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

<html><!-- #BeginTemplate "/Templates/backm_paperec.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中国纸网后台管理系统</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "宋体"; font-size: 9pt}
.title12 {  font-family: "宋体"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "宋体"; text-decoration: underline}
a:visited {  font-family: "宋体"; text-decoration: underline}
a:active {  font-family: "宋体"; text-decoration: underline}
a:hover {  font-family: "宋体"; color: #FFCC66; text-decoration: none}
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
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>


<%@ page import="java.util.*" %>
<%@ page import="product.*" %>

<jsp:useBean id="Category" scope="page" class="product.Category" /> 
<jsp:setProperty name="Category" property="classFlag"/>
<jsp:setProperty name="Category" property="cateName"/>
<jsp:setProperty name="Category" property="langCode"/>
<jsp:setProperty name="Category" property="cateId"/>

<jsp:useBean id="Type" scope="page" class="product.Type" /> 
<jsp:setProperty name="Type" property="classFlag"/>
<jsp:setProperty name="Type" property="cateId"/>
<jsp:setProperty name="Type" property="typeId"/>
<jsp:setProperty name="Type" property="editTypeName"/>
<jsp:setProperty name="Type" property="langCode"/>

<jsp:useBean id="Grade" scope="page" class="product.Grade" /> 
<jsp:setProperty name="Grade" property="classFlag"/>
<jsp:setProperty name="Grade" property="action"/>
<jsp:setProperty name="Grade" property="typeId"/>
<jsp:setProperty name="Grade" property="gradeId"/>
<jsp:setProperty name="Grade" property="editGradeName"/>
<jsp:setProperty name="Grade" property="langCode"/>

<%
    String fromFlag = request.getParameter("fromFlag");
    String class_flag = request.getParameter("classFlag");
    String cate_id = request.getParameter("cateId");
    String lang_code = request.getParameter("langCode");
    String cate_name="";
    String type_id="";
    String type_name="";
    String grade_id="";
    String grade_name="";
    
    cate_name = Category.getCategoryName();
    if (fromFlag.equals("2")){
        type_id = request.getParameter("typeId");
        type_name = Type.getTypeName();
    }
    if (fromFlag.equals("3")){
        type_id = request.getParameter("typeId");
        type_name = Type.getTypeName();
        grade_id = request.getParameter("gradeId");
        grade_name = Grade.getGradeName();
    }
       
     
    
%>


<SCRIPT LANGUAGE="Javascript">
        
    function updateSubmit(){  
        var mf=document.nameEditForm;
	mf.action.value = "update";
        
      	mf.submit();


     }
     

</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" -->
      <% if (fromFlag.equals("1")){%>
      <form name="nameEditForm" method="post" action="chanpindllb.jsp">
      <% }else if (fromFlag.equals("2")){%>
      <form name="nameEditForm" method="post" action="chanpinzllb.jsp">
      <% }else if (fromFlag.equals("3")){%>
      <form name="nameEditForm" method="post" action="chanpinxllb.jsp">
      <% }%>
      <input type="HIDDEN" name="action" value="">
      <input type="HIDDEN" name="classFlag" value=<%=class_flag%>>
      <input type="HIDDEN" name="cateId" value=<%=cate_id%>>
      <input type="HIDDEN" name="typeId" value=<%=type_id%>>
      <input type="HIDDEN" name="gradeId" value=<%=grade_id%>>
      <input type="HIDDEN" name="langCode" value=<%=lang_code%>>
        <br>
        <br>
        <table width="400" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="title12">
            <% if (fromFlag.equals("1")){%>
            产品大类编辑：<%=cate_id%>:<%=cate_name%>
            <% }else if (fromFlag.equals("2")){%>
            产品中类编辑：<%=cate_name%>><%=type_name%>
            <% }else if (fromFlag.equals("3")){%>
            产品小类编辑：<%=cate_name%>><%=type_name%>><%=grade_name%>
            <% }%>	
            </td>
          </tr>
          <tr> 
            <td colspan="2">名称： 
              <% if (fromFlag.equals("1")){ %>
              <input type="text" name="cateName" value="<%=cate_name%>">
              <% }else if (fromFlag.equals("2")){%>
              <input type="text" name="editTypeName" value="<%=type_name%>">
	      <% }else if (fromFlag.equals("3")){%>
              <input type="text" name="editGradeName" value="<%=grade_name%>">
              <% }%>
              <a href="#" onClick="javascript:updateSubmit()"><input type="image" border="0" name="imageField" src="../images/submit.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

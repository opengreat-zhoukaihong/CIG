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

<jsp:useBean id="GradeList" scope="page" class="product.GradeList" /> 
<jsp:setProperty name="GradeList" property="classFlag"/>
<jsp:setProperty name="GradeList" property="typeId"/>

<jsp:useBean id="Type" scope="page" class="product.Type" /> 
<jsp:setProperty name="Type" property="langCode" value="GB"/>
<jsp:setProperty name="Type" property="typeId"/>

<jsp:useBean id="Category" scope="page" class="product.Category" /> 
<jsp:setProperty name="Category" property="langCode" value='GB'/>
<jsp:setProperty name="Category" property="cateId"/>

<jsp:useBean id="Grade" scope="page" class="product.Grade" /> 
<jsp:setProperty name="Grade" property="classFlag"/>
<jsp:setProperty name="Grade" property="action"/>
<jsp:setProperty name="Grade" property="cateId"/>
<jsp:setProperty name="Grade" property="typeId"/>
<jsp:setProperty name="Grade" property="gradeId"/>
<jsp:setProperty name="Grade" property="editGradeName"/>
<jsp:setProperty name="Grade" property="langCode"/>


<%
   int grade_count;
   String[][] grade_list;
   String class_flag = request.getParameter("classFlag");
   String cate_id = request.getParameter("cateId");
   String type_id = request.getParameter("typeId");
   String cate_name = Category.getCategoryName();
   String type_name = Type.getTypeName();

   Grade.initGrade();
   
   GradeList.retriveGradeList();
   grade_count = GradeList.getGradeCount();
   grade_list = GradeList.getGradeList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.gradeForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("你确定删除此小类吗?")

    }
</SCRIPT>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="gradeForm" method="post" action="chanpinxllb.jsp">
      
      <input type="HIDDEN" name="classFlag" value=<%=class_flag%>>
      <input type="HIDDEN" name="cateId" value=<%=cate_id%>>
      <input type="HIDDEN" name="typeId" value=<%=type_id%>>
      <input type="HIDDEN" name="action">
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="8" class="title12" height="33">产品小类列表：
                <img src="../images/space.gif" width="150" height="1">
                <%=cate_name%>><%=type_name%>
            </td>
          </tr>
          <tr align="center"> 
            <td width="61"><b>小类ID</b></td>
            <td width="80"><b>语言代码</b></td>
            <td width="78"><b>小类名称</b></td>
            <td width="54">&nbsp;</td>
            <td width="43">&nbsp;</td>
            <td width="51">&nbsp;</td>
            <td width="73">&nbsp;</td>
            <td width="78">&nbsp;</td>
          </tr>
          <%
            if (grade_count>0){
              for (int i=0;i<grade_count;i++){
          %>
          <tr align="center"> 
            <td width="61"><a href="#"><%=grade_list[i][0]%></a></td>
            <td width="80"><%=grade_list[i][1]%></td>
            <td width="78"><%=grade_list[i][2]%></td>
            <td width="54"><a href="chanpinedit.jsp?fromFlag=3&classFlag=<%=class_flag%>&cateId=<%=cate_id%>&typeId=<%=type_id%>&gradeId=<%=grade_list[i][0]%>&langCode=<%=grade_list[i][1]%>">编辑</a></td>
            <td width="43"><a href="deleteGrade.jsp?classFlag=<%=class_flag%>&action=delete&cateId=<%=cate_id%>&typeId=<%=type_id%>&gradeId=<%=grade_list[i][0]%>" onClick="return confirmDelete()">删除</a></td>
            <td width="51"><a href="chanpindl_gglb.jsp?cateId=<%=cate_id%>">查看规格</a></td>
            <td width="73"><a href="chanpinfenleigllb.jsp?cateId=<%=cate_id%>">查看分类关联</a></td>
            <td width="78">&nbsp;</td>
          </tr>
          <%  }
            }
          %>
          <tr align="center"> 
            <td colspan="8"> 语言代码
              <select name="langCode">
              <option value=GB selected> 中文 </option>
              <option value=EN> 英文 </option>
              </select>
              小类名称 
              <input type="text" name="editGradeName" size="10">
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

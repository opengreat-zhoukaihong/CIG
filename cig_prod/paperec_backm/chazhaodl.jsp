 
<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
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


<jsp:useBean id="CategoryList" scope="page" class="product.CategoryList" /> 
<jsp:setProperty name="CategoryList" property="classFlag" value=""/>

<%
   int cate_count;
   String[][] cate_list;
   String fromFlag = request.getParameter("fromFlag");
   
   CategoryList.retriveCateList();
   cate_count = CategoryList.getCateCount();
   cate_list = CategoryList.getCateList();
%>

<SCRIPT LANGUAGE="Javascript">
        
    function submitThis(){  
        var mf=document.cateSelectForm;     
 
      	mf.submit();

    }
     
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" -->
      <% if (fromFlag.equals("1")){%>
      <form name="cateSelectForm" method="post" action="chanpindl_gglb.jsp?ClassFlag="C"">
      <% }else if (fromFlag.equals("2")){%>
      <form name="cateSelectForm" method="post" action="chanpinfenleigllb.jsp">     
      <% }%>
        <br>
        <table width="450" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr>
            <td class="title12">请选择大类：</td>
          </tr>
          <tr align="center"> 
            <td> 
              <select name="cateId">
              <% for (int i=0;i<cate_list.length;i++){
              	    if (cate_list[i][1].equals("GB")){
              %>
              <option value="<%=cate_list[i][0]%>"> <%=cate_list[i][2]%>(<%=cate_list[i][3]%>) </option>
              <%    }
                 }
              %>
              </select>
              <a href="" onClick="javascript:submitThis()"><input type="image" border="0" name="imageField" src="../images/jixu.gif" width="68" height="26">
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

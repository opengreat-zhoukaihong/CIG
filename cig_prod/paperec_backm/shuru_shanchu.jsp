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
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>


 <%@page language="java" %>
<jsp:useBean id="cf" scope="page" class="member.CompanyFind" />
<jsp:setProperty name="cf" property="company_id" />
<jsp:setProperty name="cf" property="company_id1" />
<%  String company_id=request.getParameter("company_id");
    cf.setLang_code("GB");
    String str="";
    String str1=request.getParameter("act");
    if(str1.equals("dele"))cf.getDeleComp();
    if(!cf.isExist()){
       str="您提供的公司ID并不存在！请查证。";
    }else if(str1.equals("inst")){
           cf.getInstComp();           
    } 
    if(str1.equals("begin"))str="";      
     String[][] corr=cf.getCorrelation(); 
%>


<SCRIPT LANGUAGE="Javascript">
    function confirmDelete(){

          return confirm("你确定删除此关联吗?")

    }
</SCRIPT>   
 
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
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --> <br>
      <br>
      
        <table width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="4" class="title12" height="33">公司关联列表：
                <img src="../images/space.gif" width="150" height="1">公司ID:<%=company_id%>
            </td>
          </tr>
          <tr>   
           <%=str%>      
          </tr>          
           <tr> 
            <td width="201" align="center">公司ID</td>
            <td width="301" align="center">公司名称</td>
            <td width="227" align="center">&nbsp;</td>
          </tr>
          <% for(int i=0;i<corr.length;i++){  %>
          <tr> 
            <td width="201" align="center"> <%=corr[i][0]%> </td>
            <td width="301" align="center"><%=corr[i][1]%></td>
            <td width="227" align="center"><a href="shuru_shanchu.jsp?act=dele&company_id=<%=company_id%>&company_id1=<%=corr[i][0]%>" onClick="return confirmDelete()">删除</a></td>
          </tr>
          <%    }    %>
         <form method="post" action="shuru_shanchu.jsp"> 
          <tr> 
            <td colspan="3" align="center">输入公司id：

              <input type="text" name="company_id1">
              <input type="hidden" name="company_id" value="<%=company_id%>">
              <input type="hidden" name="act" value="inst">
              <input type="image" border="0" name="imageField" src="../images/tianjia.gif" width="68" height="26">
            </td>
          </tr>
         </form> 
        </table>
     
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>
<%  cf.getDestroy();  %>
</jsp:useBean>
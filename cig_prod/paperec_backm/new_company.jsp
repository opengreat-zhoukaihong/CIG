
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

<%@ page  language="java" %>
<jsp:useBean id="memb" scope="page" class="member.MemberBG" />
<%
    memb.setLang_code ("GB");
    String com[][]=memb.getApprovedCom(); 
 %>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>     
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form method="post" action="">
        <table width="650" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="8" class="title12">新会员公司列表：</td>
          </tr>
          <tr align="center"> 
            <td width="65"><b>公司ID</b></td>
            <td width="87"><b>公司名称</b></td>
            <td width="72"><b>国家</b></td>
            <td width="52"><b>省份</b></td>
            <td width="50"><b>城市</b></td>
            <td width="66"><b>买方/卖方</b></td>
            <td width="44"><b>状态</b></td>
            <td width="49">&nbsp;</td>
            <td width="73">&nbsp;</td>
          </tr>
        <%  for(int i=0;i<com.length;i++){  %>  
          <tr align="center"> 
            <td width="65"><%=com[i][0]%></td>
            <td width="87"><%=com[i][5]%></td>
            <td width="72"><%=com[i][1]%></td>
            <td width="52"><%=com[i][2]%></td>
            <td width="50"><%=com[i][3]%></td>
            <td width="66"><%=com[i][4]%></td>
            <td width="44">N</td>
            <td width="49"><a href="membercompany_dedail.jsp?lang_code=GB&company_id=<%=com[i][0]%>">编辑</a></td>
            <td width="73"><a href="memberusers_lb.jsp?act=comp&lang_code=GB&company_id=<%=com[i][0]%>">查看会员用户</a></td>
          </tr>
         <%   }     %> 
          
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>
<%   memb.getDestroy();  %>
</jsp:userBean>
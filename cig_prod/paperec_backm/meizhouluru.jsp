
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

  funcId = "fnConPickMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

 <jsp:useBean id="pw" scope="page" class="system.PickWeek" />  
 <%
   String act=request.getParameter("act");
   String pick_id="";String lang_code="";
   String[] cert=new String[8];
   for(int i=0;i<8;i++)cert[i]="";
   if(act.equals("modi")){
      pick_id=request.getParameter("pick_id");
      pw.setPick_id(pick_id);
      lang_code=request.getParameter("lang_code");
      pw.setLang_code(lang_code);
      cert=pw.getCertain();
   }  
%>
 
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
    <td><!-- #BeginEditable "body" -->
      <form method="post" action="meizhoujingxuan_list.jsp">
        <br>
        <br>
        <table width="500" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="2" class="title12">每周精选录入：</td>
          </tr>
          <tr> 
            <td width="165" align="center">公司名称：</td>
            <td width="313"> 
              <input type="text" name="name" value="<%=cert[0]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">公司背景：</td>
            <td width="313"> 
              <input type="text" name="background" value="<%=cert[1]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">公司规模：</td>
            <td width="313"> 
              <input type="text" name="comp_size" value="<%=cert[2]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">产品技术：</td>
            <td width="313"> 
              <input type="text" name="prod_tech" value="<%=cert[3]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">客户服务：</td>
            <td width="313"> 
              <input type="text" name="service" value="<%=cert[4]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">公司荣誉：</td>
            <td width="313"> 
              <input type="text" name="comp_honor" value="<%=cert[5]%>">
            </td>
          </tr>
          <tr> 
            <td width="165" align="center">远景目标：</td>
            <td width="313"> 
              <input type="text" name="comp_object" value="<%=cert[6]%>">
            </td>
          </tr>
   <%   if(act.equals("inse")){ %>       
          <tr align="center"> 
            <td colspan="2"> 
              <input type="radio" name="lang_code" value="GB">中 文
              　　&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="radio" name="lang_code" value="EN">英 文
            </td>
          </tr>
   <%   }   %>       
          <tr align="center"> 
            <td colspan="2">
              <input type="hidden" name="lang_code" value="<%=lang_code%>"> 
              <input type="hidden" name="pick_id" value="<%=pick_id%>"> 
              <input type="hidden" name="act" value="<%=act%>">
              <input type="submit" name="Submit" value="提  交">              　　
              <input type="reset" name="Reset" value="取  消">
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
<% pw.getDestroy();%>
</jsp:useBean>
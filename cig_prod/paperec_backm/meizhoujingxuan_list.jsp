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
   if(act.equals("dele")){
      pw.setLang_code(request.getParameter("lang_code"));
      pw.setPick_id(request.getParameter("pick_id"));
      pw.getDelete();
   }
   if(act.equals("modi")){
      String[] modi=new String[9];
      modi[0]=pw.translate(request.getParameter("pick_id"));
      modi[1]=pw.translate(request.getParameter("name"));
      modi[2]=pw.translate(request.getParameter("background"));
      modi[3]=pw.translate(request.getParameter("comp_size"));
      modi[4]=pw.translate(request.getParameter("prod_tech"));
      modi[5]=pw.translate(request.getParameter("service"));
      modi[6]=pw.translate(request.getParameter("comp_honor"));
      modi[7]=pw.translate(request.getParameter("comp_object"));
      pw.setLang_code(request.getParameter("lang_code"));
      pw.getModify(modi);
   }
   if(act.equals("inse")){
      String[] inse=new String[8];
      inse[0]=pw.translate(request.getParameter("name"));
      inse[1]=pw.translate(request.getParameter("background"));
      inse[2]=pw.translate(request.getParameter("comp_size"));
      inse[3]=pw.translate(request.getParameter("prod_tech"));
      inse[4]=pw.translate(request.getParameter("service"));
      inse[5]=pw.translate(request.getParameter("comp_honor"));
      inse[6]=pw.translate(request.getParameter("comp_object"));
      pw.setLang_code(request.getParameter("lang_code"));
      pw.getInsert(inse);
   }   
   
   String pick[][]=pw.getAllPick();
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
      <form method="post" action="meizhouluru.jsp">
        <br>
        <br>
        <table width="500" border="1" cellspacing="0" cellpadding="6" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td align="center"><b>公司ID</b></td>            
            <td align="center"><b>公司名称</b></td>
            <td align="center"><b>语言代码</b></td>
            <td align="center"><b>时间</b></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
       <%  for(int i=0;i<pick.length;i++){    %>   
          <tr> 
            <td align="center"><%=pick[i][0]%></td>
            <td align="center"><%=pick[i][1]%></td>
            <td align="center"><%=pick[i][2]%></td>
            <td align="center"><%=pick[i][3]%></td>
            <td align="center"><a href="meizhouluru.jsp?pick_id=<%=pick[i][0]%>&lang_code=<%=pick[i][2]%>&act=modi">编辑</a></td>
            <td align="center"><a href="meizhoujingxuan_list.jsp?pick_id=<%=pick[i][0]%>&lang_code=<%=pick[i][2]%>&act=dele">删除</a></td>
          </tr>
       <%   }   %>   
          <tr> 
            <td align="center" colspan="6">
              <input type="hidden" name="act" value="inse">
              <input type="image" border="0" name="imageField" src="../images/add.gif" width="68" height="26">
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
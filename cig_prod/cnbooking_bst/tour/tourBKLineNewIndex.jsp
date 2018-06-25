<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>后台管理</title>
<style type="text/css">
<!--
 input {font-family: "宋体"; font-size: 12px ;color:#666666}
 select {font-family: "宋体"; font-size: 12px ; color:#666666}
 td {font-family: "宋体", "Times New Roman"; font-size: 12px; color:#666666; line-height: 18px}
 A:link {text-decoration: none; color: #715922; font-family: 宋体}
 A:visited {text-decoration: none; color: #715922; font-family: 宋体}
 A:active {text-decoration: none; font-family: 宋体}
 A:hover {text-decoration: underline; color:#CAA54D}
 .title { font-size: 12px; font-weight: normal; font-family: "宋体"}
-->
</style>
</head>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnTuOthMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>
<%
    String ope_ID=request.getParameter("ope_ID");
%>
<body bgcolor="#FFFFFF">
<form method="POST" name="LineMap" action="tourBKLineInsert.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<p><span class="title"><span class="title">旅游主题(中)： 
<input type="text" name="titleGB" size="30" value="" >
<br>
 旅游主题(英)： 
 <input type="text" name="titleEN" size="30" value="" >
  <br>
  </span></span><span class="title"><span class="title">行程介绍(中)：
  <TEXTAREA cols=40 name="scheGB" rows=3></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">行程介绍(英)：
  <TEXTAREA cols=40 name="scheEN" rows=3></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">服务内容(中)：
  <TEXTAREA cols=40 name="servicesGB" rows=3></TEXTAREA>
  <br>
   </span></span><span class="title"><span class="title">服务内容(英)：
  <TEXTAREA cols=40 name="servicesEN" rows=3></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">最近操作员：
   <input type="text" name="man_id" size="20" value="<%=ope_ID%>" disabled >
   <br>
   <br>
   </span></span></span></span></p>
  <table width="250" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
        <div align="center"><input type="submit" value="添加提交" name="changSub"></div>
      </td>
    </tr>
  </table>
  </form>
  <p><span class="title"><span class="title"><span class="title"><span class="title"> 
    </span></span></span></span></p>
  <hr>
  <br>
</body>
</html>

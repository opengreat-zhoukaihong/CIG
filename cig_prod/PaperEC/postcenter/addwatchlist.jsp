<html>
<head>
<title>我的纸网--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  font-size: 10pt; text-decoration: none}
a:visited {  font-size: 10pt; text-decoration: none}
a:active {  font-size: 10pt; text-decoration: none}
a:hover {  font-size: 10pt; color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; color: #000000}
-->
</style>

</head>


<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />
<jsp:useBean id="WatchList" scope="page" class="mypaperec.WatchList" />

<jsp:setProperty name="WatchList" property="userId" />
<jsp:setProperty name="WatchList" property="langCode" />
<jsp:setProperty name="WatchList" property="measureFlag" />
<jsp:setProperty name="WatchList" property="postingId" />

<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>

<% boolean flag = WatchList.addToWatchList();%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method="post" name="successForm" action="">
  <table width="273" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF" align="center">
    <tr bordercolor="#FFFFFF" valign="top"> 
      <td height="172"> 
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="left">
          <tr align="center" bgcolor="#E6EDFB"> 
          <%if (flag) { %>
            <td class="font9" height="185">已成功加入收藏夹!</td>
          <%}else{%>
            <td class="font9" height="185">您的收藏夹中已经包含该发布信息!</td>
          <%}%>
          </tr>
          <tr bgcolor="#4078E0" align="center"> 
            <td height="25"> 
              <input type="submit" name="Submit2" value="关闭" onClick="javascript:window.close()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

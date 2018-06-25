<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/paperec_backm/login.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  String funcId = "fnConBbsMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

<html>
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网BBS--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--

var onTop = false
function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}
// -->
</script>
<style type="text/css">
<!--
.white {  font-family: "宋体"; font-size: 10pt; color: #FFFFFF}
a:link {  font-family: "宋体"; text-decoration: none}
a:visited {  font-family: "宋体"; text-decoration: none}
a:active {  font-family: "宋体"; text-decoration: none}
a:hover {  font-family: "宋体"; text-decoration: underline}
td {  font-family: "宋体"; font-size: 10pt}
.black {  font-family: "宋体"; color: #000000}
.algin {  font-family: "宋体"; font-size: 10pt; text-align: justify; line-height: 18pt}
.b9 {  font-family: "宋体"; font-size: 10pt}
.textfield {  border-color: #4078E0 #FFFFFF; border: 1px solid}
.yellow {  font-family: "宋体"; font-size: 10pt; color: #FF9900}
-->
</style>
</head>
<%
    String area_ID = request.getParameter("area_ID").trim();
    if(area_ID.trim().equals(""))
    area_ID="1";
    String cate_ID = request.getParameter("cate_ID").trim();
    if(cate_ID.trim().equals(""))
    cate_ID="1";
    String article_ID=request.getParameter("article_ID").trim();
    String parent_ID="0";
   
%>
<jsp:useBean id="BBS_ViewDetail" scope="page" class="bbs.BBS_ViewDetail" />
<jsp:setProperty name="BBS_ViewDetail" property="pageFlag" value="N"/>
<jsp:setProperty name="BBS_ViewDetail" property="restriction" value="16"/>
<%
BBS_ViewDetail.setArticle_ID(article_ID);
int articleCount=0;
int totalPage=0;
String[][] articleLists;
int pageno=1;
articleLists = BBS_ViewDetail.getArticleList();
articleCount = BBS_ViewDetail.getArticleCount();
totalPage = BBS_ViewDetail.getTotalPage();
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
      <form method="post" name="bbsIn">
        <table width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#000000" bordercolordark="#FFFFFF">
          <tr>
            <td>
              <table width="550" border="0" cellspacing="0" cellpadding="4" align="center" bgcolor="#D8E4F8">
              <%for(int i=0;i<articleCount;i++){
                %>
              <tr> 
                  <td width="108" height="28">发帖人、时间：</td>
                  <td width="414" height="28"><%=articleLists[i][3]%> 于 <%=articleLists[i][0]%></td>
                </tr>
                <tr> 
                  <td width="108" height="32">标  题 ：</td>
                  <td width="414" height="32"><%=articleLists[i][2]%></td>
                </tr>
                <tr> 
                  <td width="108" valign="top">帖子内容: </td>
                  <td width="414"><%=articleLists[i][5]%></td>
                </tr>
                <tr> 
                  <td width="108">&nbsp;</td>
                  <td width="414" align="right"><a href="javascript:window.history.go(-1)">回到论坛</a>|<a href="bbsBK_List.jsp?pageNo=1&area_ID=<%=area_ID%>">回到首页</a>|<a href="bbsBK_Del.jsp?area_ID=<%=area_ID%>&article_ID=<%=articleLists[i][1]%>">删除此贴</a></td>
                </tr>
                <tr> 
                  <td colspan="2">
                    <hr>
                  </td>
                </tr>
                <%}%>
              </table>
              <table width="550" border="0" cellspacing="0" cellpadding="4">
              <tr align="center"></tr>
              </table>
            </td>
          </tr>
        </table>
      </form>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../../images/dline.gif"  border="0" width="776" height="6"></td>
  </tr>
  <tr align="center"> 
    <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
      2000 PaperEC.com Inc. All Rights Reserved</font></td>
  </tr>
  <tr align="center"> 
    <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif" width="80" height="24" border="0"></a></td>
  </tr>
</table>
</body>
</html>
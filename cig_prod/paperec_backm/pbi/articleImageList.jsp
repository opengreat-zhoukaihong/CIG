<%--  @# chanpindl_gglb.jsp Ver.1.1 --%>

<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="/login.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  boolean isPermitted;
  String userID;
  String funcId;

  funcId = "fnPbiMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>


<%@ page import="com.cig.article.*" %>


<jsp:useBean id="Article" scope="page" class="com.cig.article.Article" />
<jsp:setProperty name="Article" property="dbpoolName" value="paperec"/>
<jsp:setProperty name="Article" property="articleId" />

<%
    Article.DEBUG=true;
    String art_id = "";
    ArticleImage[] art_imgs=null;
    
    art_id = request.getParameter("articleId");

    art_imgs = Article.getArticleImages();
%>

<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>PBI后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "宋体"}
        A:visited {text-decoration: none; font-family: "宋体"}
        A:active {text-decoration: none; font-family: "宋体"}
        A:hover {text-decoration: underline; color: #FFCC33}
-->
</style>
</head>


<%=Article.errMsg%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>     
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form method="post" action="articleImageProcess.jsp" enctype="multipart/form-data">
      <input type=hidden name="articleId" value="<%=art_id%>" >
      <input type=hidden name="action" value="add" >
        <table width="650" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#f9c026" bordercolordark="#FFFFFF" align="center">
          <tr> 
            <td colspan="7" class="font12">文稿图象列表：</td>
          </tr>
          <tr align="center" class="font9"> 
            <td width="60"><b>文稿ID</b></td>
            <td width="60"><b>图象编号</b></td>
            <td width="60"><b>图象URL</b></td>
            <td width="100"><b>图象标题</b></td>
            <td width="60"><b>上传标志</b></td>
            <td width="200"><b>图象预览</b></td>
            <td width="60">&nbsp;</td>
          </tr>
	<%
	  for (int i=0; i<art_imgs.length; i++) {
	%>
          <tr align="center" class="font9"> 
            <td width="60">&nbsp;<%=art_imgs[i].getArticleId()%></td>
            <td width="60">&nbsp;<%=art_imgs[i].getOrderNo()%></td>
            <td width="60">&nbsp;<%=art_imgs[i].getImageURL()%></td>
            <td width="100">&nbsp;<%=art_imgs[i].getImageTitle()%></td>
            <td width="60">&nbsp;<%=art_imgs[i].getStatus()%></td>
            <td width="200"><img src="<%=art_imgs[i].getImageURL()%>" width="100" border="0"></td>
            <td width="60"><a href="articleImageProcessDel.jsp?action=delete&articleId=<%=art_id%>&orderNo=<%=art_imgs[i].getOrderNo()%>" onClick="return confirm('确实要删除此图象吗?')" class="font9">删除</a></td>
          </tr>
        <% } %>
	</table>    
        <table width="450" border="0" cellspacing="2" cellpadding="5" height="10">
                <tr> 
                  <td class="font12">&nbsp;</td>
                </tr>
        </table>	    
        <table width="450" border="0" cellspacing="2" cellpadding="4" bordercolorlight="#f9c026" bordercolordark="#FFFFFF" align="center">        
         <tr align="left"> 
           <td class="font9" width="150" height="15">图象编号：</td>
           <td class="font9" width="300" height="15"><input type="text" name="orderNo" size="4"></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="150" height="15">图象URL：</td>
           <td class="font9" width="300" height="15"><input type="file" name="imageFile1"  size="30" ></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="150" height="15">图象标题：</td>
           <td class="font9" width="300" height="15"><input type="text" name="imageTitle" size="40"></td>
         </tr>
         <tr align="center" colspan="10"> 
           <td colspan="10">
              <input type="button" name="btnAdd" value="增加图象" OnClick="javascript:submit()">
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

<%--  @# func_process.jsp  Ver 1.0 --%>
<%@ page language="java" import="com.jspsmart.upload.*,java.util.*, java.net.*"%>
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
  String funcId = "fnPbiMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

<%
String articleId;
String orderNo;
String imageURL=null;
String imageTitle;
String art_id;
String action;
int count=0;
String info="";
%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%

myUpload.initialize(pageContext);
myUpload.upload();

String path="/www/html/paperec/pbi_image/";
try{
  count = myUpload.save(path);
  info= count + " 个图片文件上载.<br>";
} 
catch (Exception e){ 
 count=0;
 info = e.toString();
}
String fileField;
for (int i=0;i<myUpload.getFiles().getCount();i++)
{
   fileField = myUpload.getFiles().getFile(i).getFieldName();		
   if (fileField.equals("imageFile1"))
     imageURL ="/pbi_image/"+myUpload.getFiles().getFile(i).getFileName();
   if (myUpload.getFiles().getFile(i).isMissing())
      imageURL=null;
}

     articleId=myUpload.getRequest().getParameter("articleId");
     orderNo=myUpload.getRequest().getParameter("orderNo");
     imageTitle=myUpload.getRequest().getParameter("imageTitle");
     action = myUpload.getRequest().getParameter("action");
     action = action==null?"":action;
%>
<jsp:useBean id="ArticleImageManager" scope="page" class="com.cig.article.ArticleImageManager" /> 
<jsp:setProperty name="ArticleImageManager" property="DEBUG" value="true"/> 
<jsp:setProperty name="ArticleImageManager" property="dbpoolName" value="paperec"/> 


<jsp:useBean id="ArticleImage" scope="page" class="com.cig.article.ArticleImage" /> 
<jsp:setProperty name="ArticleImage" property="DEBUG" value="true"/> 
<jsp:setProperty name="ArticleImage" property="dbpoolName" value="paperec"/> 
<jsp:setProperty name="ArticleImage" property="status" value="Y"/>

<%
  art_id = articleId; 
  if (action.equals("add"))
  {   
      if(count>=1)
      ArticleImage.setImageURL(imageURL);
      ArticleImage.setOrderNo(orderNo);
      ArticleImage.setArticleId(articleId);
      ArticleImage.setImageTitle(imageTitle);
      ArticleImageManager.setArticleImage(ArticleImage);
      if (ArticleImageManager.addArticleImage())
      {
          response.sendRedirect("articleImageList.jsp?articleId="+art_id); 
          info += "增加成功!"; 
      }
      else
          info += "增加失败!"; 
  }
  else if (action.equals("update"))
  {
//      if (funcMgr.update())
//          info += "更新成功!";
//      else
          info += "更新失败!";
  }
  else
      info += "操作失败!";
      
%>

<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>

</SCRIPT>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<span class="font9"></span> <span class="font9"></span> 
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="100" height="50">&nbsp; </td>
    <td width="495" height="50">&nbsp; </td>
  </tr>
  <tr> 
    <td width="100" height="407">&nbsp; </td>
    <td width="495" valign="top" height="407" class="font12"> 
	<%=info%>
    </td>
  </tr>
</table>
</body>
</html>

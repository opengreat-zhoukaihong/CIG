<%@ page import="java.util.*,com.cig.article.*" %>
<jsp:useBean id="atcMgr" scope="page" class="com.cig.article.ArticleManager" /> 
<jsp:setProperty name="atcMgr" property="DEBUG" value="true"/> 
<jsp:setProperty name="atcMgr" property="dbpoolName" value="paperec"/> 
<%
  String articleId = request.getParameter("articleId");
  Article article = atcMgr.getArticle(articleId);
  if (article==null) article = new Article();
%>

<html>
<head>
<title>文 稿</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-family: "宋体"; font-size: 12px}
a:link {  font-family: "宋体"; text-decoration: none; font-size: 12px; color: #000000}
a:visited {  font-family: "宋体"; color: #000000; font-size: 12px; text-decoration: none}
a:active {  font-family: "宋体"; color: #000000; font-size: 12px}
a:hover {  font-family: "宋体"; color: #6666FF; text-decoration: underline; font-size: 12px}
-->
</style>
</head>

<body bgcolor="#FFFFFF" onload="Javascript:Load()">
<SCRIPT LANGUAGE=JavaScript>
<!--
function Load()
{
  now = new Date();
  wMonth = now.getMonth() + 1;
  if (wMonth < 10)
    wMonth = "0" + wMonth;
  wDate = now.getDate();
  if (wDate < 10)
    wDate="0"+ wDate;
  fmArticleUpdate.pbDate.value = now.getYear() + "-" + wMonth + "-" + wDate;
}
function PostForm(I)
{
   if (fmArticleUpdate.pbDate.value == "")
   {
	 alert("请输入发布日期!");
	 return;
   }
   if (fmArticleUpdate.header.value == "")
   {
	 alert("请输入文稿标题内容!");
	 return;
   }
   if (fmArticleUpdate.content.value == "")
   {
	 alert("请输入文稿正文内容!");
	 return;
   }
   fmArticleUpdate.submit();
}
//-->
</SCRIPT>
<table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#94000" bordercolordark="#FFFFFF" align="center">
  <tr align="center"> 
    <TD  class=font9 height=22 width=85><A 
      href="/paperec_backm/pbi">文稿分类</A></TD>
    <TD height=22 width=85><A class=font9 
      href="/paperec_backm/pbi">查询文稿</A></TD>
    <TD bgColor=#cccccc class=font9 height=22 width=85><A 
      href="/paperec_backm/pbi">添加文稿</A></TD>
    <TD class=font9 height=22 width=85><A 
      href="/paperec_backm/pbi">热点文稿</A></TD>
    <TD class=font9 height=22 width=85><A 
      href="/paperec_backm/pbi">预览文稿</A></TD>
    <TD class=font9 height=22 width=85><A 
      href="/paperec_backm/pbi">上载文稿</A></TD>
    <TD class=font9 height=22 width=88><A 
      href="/paperec_backm/pbi">退出系统</A></TD></TR></TBODY></TABLE><BR><BR>
<form name="fmArticleUpdate" method="post" action="/paperec_backm/pbi/article_process.jsp">
  <input type="HIDDEN" name="action" value="update">
  <input type="HIDDEN" name="articleId" value="<%=articleId%>">
  <table width="600" border="1" cellspacing="0" cellpadding="6" align="center" bordercolorlight="#94000" bordercolordark="#FFFFFF">
    <tr> 
      <td height="469"> 
        文稿ID : <%=articleId%>
        <table width="600" border="0" cellspacing="0" cellpadding="4">
          <tr bgcolor="#fff3ee"> 
            <td width="117" class="font9">语言代码：</td>
            <td width="164"> 
              <select name="langCode">
<option value='EN' <%if(article.getLangCode().equals("EN")){%>selected<%}%>>English</option>
<option value='GB' <%if(article.getLangCode().equals("GB")){%>selected<%}%>>GB</option>
              </select>
            </td>
            <td width="99" class="font9">文稿来源：</td>
            <td width="188"> 
              <input type="text" name="source" size="18" value="<%=article.getSource()%>">
            </td>
          </tr>
          <tr> 
            <td class="font9" width="117">模板类型：</td>
            <td width="164"> 
              <select name="templateId">
                <option value="0" <%if(article.getLangCode().equals("0")){%>selected<%}%>>静态页面</option>
                <option value="1" <%if(article.getLangCode().equals("1")){%>selected<%}%>>图片居左</option>
                <option value="2" <%if(article.getLangCode().equals("2")){%>selected<%}%>>图片居中</option>
                <option value="3" <%if(article.getLangCode().equals("3")){%>selected<%}%>>图片居右</option>
                <option value="4" <%if(article.getLangCode().equals("4")){%>selected<%}%>selected>无图片</option>
              </select>
            </td>
            <td class="font9" width="99">作者：</td>
            <td width="188"> 
              <input type="text" name="Author" size="18" value="<%=article.getAuthor()%>">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td class="font9" width="117">静态文稿URL：</td>
            <td width="164"> 
              <input type="text" name="htmlURL" size="18" value="<%=article.getHtmlURL()%>">
            </td>
            <td class="font9" width="99"> &nbsp;</td>
            <td width="188"> &nbsp;
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td class="font9" width="117">文稿索引标题：</td>
            <td colspan="3"> 
              <input type="text" name="header" size="50" value="<%=article.getHeader()%>">
              <font color="#FF6666">*</font> </td>
          </tr>
          <tr> 
            <td class="font9" width="117">发布日期：</td>
            <td width="164"> 
              <input type="text" name="pbDate" size="18" value="<%=article.getPbDate()%>">
              <font color="#FF6666">*</font> </td>
            <td class="font9" width="99">文稿关键字：</td>
            <td width="188"> 
              <input type="text" name="metaKey" size="18" value="<%=article.getMetaKey()%>">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td class="font9" width="117">文稿标题内容：</td>
            <td colspan="3"> 
              <input type="text" name="title" size="50" value="<%=article.getTitle()%>">
              <font color="#FF6666">*</font> </td>
          </tr>
          <tr> 
            <td class="font9" width="117">文稿子标题内容：</td>
            <td colspan="3"> 
              <input type="text" name="subTitle" size="50" value="<%=article.getSubTitle()%>">
            </td>
          </tr>
          <tr bgcolor="#fff3ee"> 
            <td class="font9" width="117">文稿正文内容：</td>
            <td colspan="3"> 
              <textarea name="content" cols="50" rows="10"><%=article.getContent()%></textarea>
              <font color="#FF6666">*</font> </td>
          </tr>
          <tr align="center"> 
            <td colspan="4"> 
              <input type="button" name="Submit3" value="更新" onClick="javaScript:PostForm(1)">
              <input type="reset" name="Submit4" value="取消">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

<!--Err: 
<%=atcMgr.errMsg%>
-->
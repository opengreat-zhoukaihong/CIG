<%--  @# article_list.jsp  Ver 1.0 --%>

<%--@ page import="java.util.*,system.*" %> 
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
<%}--%>

<%@ page import="java.util.*,java.io.*,com.cig.article.*" %>
<jsp:useBean id="articleList" scope="page" class="com.cig.article.ArticleList" /> 
<jsp:setProperty name="articleList" property="DEBUG" value="true" />
<jsp:setProperty name="articleList" property="dbpoolName" value="paperec" />
<jsp:setProperty name="articleList" property="pageNo" value="1" />
<jsp:setProperty name="articleList" property="restriction" value="20" />
<jsp:setProperty name="articleList" property="condLangCode" />
<jsp:setProperty name="articleList" property="condHeader" />
<jsp:setProperty name="articleList" property="condDateFrom" />
<jsp:setProperty name="articleList" property="condDateTo" />
<jsp:setProperty name="articleList" property="condMetaKey" />
<%
    int totalCount = 0;
    int totalPage = 0;
    ArticleIdx[] articleIdxs;
    
    String name;
    String value;
    Enumeration e = request.getParameterNames();
    String str="";
    int pageNo = 1;
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);
%>
<%--=name%>=<%=value%><br>--%>
<%
	if ( name.equals("opeId") && !value.equals("")) {
	    str += "&opeId=" + value;
	}
	if ( name.equals("email") && !value.equals("")) {
	    str += "&email=" + value;
	}
    }
    
    try {
        pageNo = (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    } catch(Exception err) {pageNo = 1;}  
    
    articleList.search();

    articleIdxs = articleList.getArticleIdxs();
    totalCount = articleList.getTotalCount();
    totalPage = articleList.getTotalPage();
        
%> 


<html>
<head>


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

<script language="JavaScript">	
function delete_selected()
{
    if(confirm("你确认删除所有选中的文稿吗?"))
    {
	document.fmOperatorProcess.action.value = "multi_del"
	document.fmOperatorProcess.submit()
    }		
}
	
function del_atc(article_id)
{
    if(confirm("你确认删除此文稿吗?"))
    {
	document.emptyform.action="article_process.jsp?action=delete&articleId=" + article_id; 
	document.emptyform.submit()
    }		
}

function js_callpage(htmlurl) 
{
    var newwin=window.open(htmlurl,"newwin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=566,height=327");
    return false;
}
	
</script>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">



<span class="font9"></span> <span class="font9"></span> 
<table width="500" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr> 
    <td> 
      <table border="0" cellpadding="0" cellspacing="0" width="500">
        <tr> 
          <td width="30">&nbsp; </td>
          <td> 

            <form name=fmArticleProcess method="post" action="article_process.jsp">
	    <input type="hidden" name="action" value="">
	    
              <table width="650" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">文稿查询结果(修改请按ID号)</td>
                </tr>
              </table>
              <table width="650" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="5" align="left">共有<%=totalCount%>条记录，共<%=totalPage%>页</td>  
                  <td class="font9" colspan="6" align="right">第<%=pageNo%>页&nbsp;&nbsp;
                    <% if (pageNo>1) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageNo-1%><%=str%>" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageNo<totalPage) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageNo+1%><%=str%>" class="font9">下一页</a>&nbsp; 
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="font9" width="25" height="15">&nbsp;</td>
                  <td class="font9" width="50" height="15">文稿ID</td>
                  <td class="font9" width="150" height="15">索引标题</td>
                  <td class="font9" width="100" height="15">发布日期</td>
                  <td class="font9" width="60" height="15">语言</td>
                  <td class="font9" width="60" height="15">来源</td>
                  <td class="font9" width="25" height="15">模板</td>
                  <td class="font9" colspan="4" width="240" height="15">操作</td>
                </tr>
                <% 
              	  if (articleIdxs != null){                   
                   for (int i=0; i<articleIdxs.length; i++){%>
                <tr align="center"> 
                  <td class="font9" width="25" height="15"><input type="checkbox" name="chk_opeid" value="<%=articleIdxs[i].getArticleId()%>"></td>
                  <td class="font9" width="50" height="15"><a href="edit_article.jsp?articleId=<%=articleIdxs[i].getArticleId()%>" class="font9"><%=articleIdxs[i].getArticleId()%></a>&nbsp;</td>
                  <td class="font9" width="150" height="15"><%=articleIdxs[i].getHeader()%>&nbsp;</td>
                  <td class="font9" width="100" height="15"><%=articleIdxs[i].getPbDate()%>&nbsp;</td>
                  <td class="font9" width="60" height="15"><%=articleIdxs[i].getLangCode()%>&nbsp;</td>
                  <td class="font9" width="60" height="15"><%=articleIdxs[i].getSource()%>&nbsp;</td>
                  <td class="font9" width="25" height="15"><%=articleIdxs[i].getTemplateId()%>&nbsp;</td>
                  <td class="font9" width="60" height="15">[<a href="edit_article.jsp?articleId=<%=articleIdxs[i].getArticleId()%>" class="font9">文稿编辑</a>]</td>
                  <td class="font9" width="60" height="15">[<a href="javascript:del_atc('<%=articleIdxs[i].getArticleId()%>')" class="font9">文稿删除</a>]</td>
                  <td class="font9" width="60" height="15">[<a href="articleImageList.jsp?articleId=<%=articleIdxs[i].getArticleId()%>" class="font9">文稿图象</a>]</td>
                  <td class="font9" width="60" height="15">[<a href="selectJournal.jsp?articleId=<%=articleIdxs[i].getArticleId()%>" class="font9">文稿归属</a>]</td>
                </tr>
                <% }
                  }
                %>
              </table>
	      <table width="600" border="0" cellspacing="0" cellpadding="0">
        	<tr align="middle"> 
            	  <td height="30">
            	  <input type="button" name="btnDel" value="删 除" OnClick="javascript:delete_selected()"> 
            	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	  <input type="reset" value="Reset">
            	  </td>
          	</tr>
              </table>
            </form>

            <form action="" name="emptyform" method="post"></form>

          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

<!--Err: 
<%=articleList.errMsg%>
-->
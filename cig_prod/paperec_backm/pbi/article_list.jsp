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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
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


<title>PBI��̨������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: none; font-family: "����"}
        A:visited {text-decoration: none; font-family: "����"}
        A:active {text-decoration: none; font-family: "����"}
        A:hover {text-decoration: underline; color: #FFCC33}
-->
</style>
</head>

<script language="JavaScript">	
function delete_selected()
{
    if(confirm("��ȷ��ɾ������ѡ�е��ĸ���?"))
    {
	document.fmOperatorProcess.action.value = "multi_del"
	document.fmOperatorProcess.submit()
    }		
}
	
function del_atc(article_id)
{
    if(confirm("��ȷ��ɾ�����ĸ���?"))
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
                  <td class="font12">�ĸ��ѯ���(�޸��밴ID��)</td>
                </tr>
              </table>
              <table width="650" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="5" align="left">����<%=totalCount%>����¼����<%=totalPage%>ҳ</td>  
                  <td class="font9" colspan="6" align="right">��<%=pageNo%>ҳ&nbsp;&nbsp;
                    <% if (pageNo>1) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageNo-1%><%=str%>" class="font9">��һҳ</a>&nbsp;
                    <%}%>
                    <% if (pageNo<totalPage) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageNo+1%><%=str%>" class="font9">��һҳ</a>&nbsp; 
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="font9" width="25" height="15">&nbsp;</td>
                  <td class="font9" width="50" height="15">�ĸ�ID</td>
                  <td class="font9" width="150" height="15">��������</td>
                  <td class="font9" width="100" height="15">��������</td>
                  <td class="font9" width="60" height="15">����</td>
                  <td class="font9" width="60" height="15">��Դ</td>
                  <td class="font9" width="25" height="15">ģ��</td>
                  <td class="font9" colspan="4" width="240" height="15">����</td>
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
                  <td class="font9" width="60" height="15">[<a href="edit_article.jsp?articleId=<%=articleIdxs[i].getArticleId()%>" class="font9">�ĸ�༭</a>]</td>
                  <td class="font9" width="60" height="15">[<a href="javascript:del_atc('<%=articleIdxs[i].getArticleId()%>')" class="font9">�ĸ�ɾ��</a>]</td>
                  <td class="font9" width="60" height="15">[<a href="articleImageList.jsp?articleId=<%=articleIdxs[i].getArticleId()%>" class="font9">�ĸ�ͼ��</a>]</td>
                  <td class="font9" width="60" height="15">[<a href="selectJournal.jsp?articleId=<%=articleIdxs[i].getArticleId()%>" class="font9">�ĸ����</a>]</td>
                </tr>
                <% }
                  }
                %>
              </table>
	      <table width="600" border="0" cellspacing="0" cellpadding="0">
        	<tr align="middle"> 
            	  <td height="30">
            	  <input type="button" name="btnDel" value="ɾ ��" OnClick="javascript:delete_selected()"> 
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
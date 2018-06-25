<%--  @# jarticle_list.jsp  Ver 1.0 --%>

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
<jsp:useBean id="jArticleList" scope="page" class="com.cig.article.JArticleList" /> 
<jsp:setProperty name="jArticleList" property="DEBUG" value="true" />
<jsp:setProperty name="jArticleList" property="dbpoolName" value="paperec" />
<jsp:setProperty name="jArticleList" property="journalId" />
<jsp:setProperty name="jArticleList" property="columnId" />

<jsp:useBean id="atcIdxMgr" scope="page" class="com.cig.article.ArticleIdxManager" /> 
<jsp:setProperty name="atcIdxMgr" property="DEBUG" value="true" />
<jsp:setProperty name="atcIdxMgr" property="dbpoolName" value="paperec" />
<%
    int totalCount = 0;
    int totalPage = 0;
    
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
    
    String columnId = request.getParameter("columnId");
    columnId = columnId==null?"":columnId;
    String journalId = request.getParameter("journalId");
    journalId = journalId==null?"":journalId;
    String articleId = request.getParameter("articleId");
    articleId = articleId==null?"":articleId;    

    jArticleList.search();
        
    JArticle[] jArticles =  jArticleList.getJArticles();
    if (jArticles==null) jArticles=new JArticle[0];
    totalCount = jArticleList.getTotalCount();
    totalPage = jArticleList.getTotalPage();
        
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

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.fmArticleProcess;
	mf.action.value = "accept";
        
      	mf.submit();


     }
     
</SCRIPT>
<script language="JavaScript">	
function delete_selected()
{
    if(confirm("Are you sure to delete selected articleIdxs?"))
    {
	document.fmOperatorProcess.action.value = "multi_del"
	document.fmOperatorProcess.submit()
    }		
}
	
function del_atc(article_id)
{
    if(confirm("Are you sure to delete this Article?"))
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

            <form name=fmArticleProcess method="post" action="jarticle_process.jsp">
	    <input type="hidden" name="action" value="">
	    
              <table width="650" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">�ڿ�-��Ŀ-�ĸ��б�</td>
                </tr>
              </table>
              <table width="650" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="5" align="left">����<%=totalCount%>����¼����<%=totalPage%>ҳ</td>  
                  <td class="font9" colspan="5" align="right">��<%=pageNo%>ҳ&nbsp;&nbsp;
                    <% if (pageNo>1) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageNo-1%><%=str%>" class="font9">��һҳ</a>&nbsp;
                    <%}%>
                    <% if (pageNo<totalPage) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageNo+1%><%=str%>" class="font9">��һҳ</a>&nbsp; 
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <!--<td class="font9" width="25" height="15">&nbsp;</td>-->
                  <td class="font9" width="50" height="15">�ڿ�ID</td>
                  <td class="font9" width="50" height="15">ר��ID</td>
                  <td class="font9" width="50" height="15">�ĸ�ID</td>
                  <td class="font9" width="25" height="15">����</td>
                  <td class="font9" width="180" height="15">��������</td>
                  <td class="font9" width="100" height="15">��������</td>
                  <td class="font9" width="60" height="15">����</td>
                  <td class="font9" width="60" height="15">��Դ</td>
                  <td class="font9" width="25" height="15">״̬</td>
                  <td class="font9" colspan="1" width="120" height="15">����</td>
                </tr>
                <% 
              	  if (jArticles != null){                   
                   for (int i=0; i<jArticles.length; i++){
                     ArticleIdx atcIdx = atcIdxMgr.getArticleIdx(jArticles[i].getArticleId());
                     if (atcIdx==null) atcIdx = new ArticleIdx(); %>
                <tr align="center"> 
                  <!--<td class="font9" width="25" height="15"><input type="checkbox" name="chk_opeid" value="<%=jArticles[i].getArticleId()%>"></td>-->
                  <td class="font9" width="50" height="15"><%=jArticles[i].getJournalId()%>&nbsp;</td>
                  <td class="font9" width="50" height="15"><%=jArticles[i].getColumnId()%>&nbsp;</td>
                  <td class="font9" width="50" height="15"><a href="edit_article.jsp?articleId=<%=jArticles[i].getArticleId()%>" class="font9"><%=jArticles[i].getArticleId()%></a>&nbsp;</td>
                  <td class="font9" width="25" height="15"><%=jArticles[i].getOrderNo()%>&nbsp;</td>
                  <td class="font9" width="180" height="15"><%=atcIdx.getHeader()%>&nbsp;</td>
                  <td class="font9" width="100" height="15"><%=atcIdx.getPbDate()%>&nbsp;</td>
                  <td class="font9" width="60" height="15"><%=atcIdx.getLangCode()%>&nbsp;</td>
                  <td class="font9" width="60" height="15"><%=atcIdx.getSource()%>&nbsp;</td>
                  <td class="font9" width="25" height="15"><%=jArticles[i].getStatus()%>&nbsp;</td>
                  <td class="font9" width="120" height="15">[<a href="jarticle_process.jsp?action=remove&journalId=<%=journalId%>&columnId=<%=columnId%>&articleId=<%=jArticles[i].getArticleId()%>" class="font9">�ĸ��Ƴ�</a>]</td>
                </tr>
                <% }
                  }
                %>
              </table>
	      <!--table width="600" border="0" cellspacing="0" cellpadding="0">
        	<tr align="middle"> 
            	  <td height="30">
            	  <input type="button" name="btnDel" value="ɾ ��" OnClick="javascript:delete_selected()"> 
            	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	  <input type="reset" value="Reset">
            	  </td>
          	</tr>
              </table-->
        <table width="300" border="0" cellspacing="2" cellpadding="4" bordercolorlight="#4078e0" bordercolordark="#FFFFFF" align="center">        
         <tr align="left"> 
           <td class="font9"  colspan="2" width="450" height="15">&nbsp;</td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="150" height="15">�ڿ�Id��</td>
           <td class="font9" width="300" height="15"><input type="text" name="journalId" size="20" value="<%=journalId%>"></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="150" height="15">��ĿId��</td>
           <td class="font9" width="300" height="15"><input type="text" name="columnId" size="20" value="<%=columnId%>"></td>
         </tr> 
         <tr align="left"> 
           <td class="font9" width="150" height="15">�ĸ�Id��</td>
           <td class="font9" width="300" height="15"><input type="text" name="articleId" size="20" value="<%=articleId%>"></td>
         </tr>                  
         <tr align="left"> 
           <td class="font9" width="100" height="15">��ţ�</td>
           <td class="font9" width="220" height="15"><input type="text" name="orderNo" size="4"></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="100" height="15">��Ŀ�Ƿ񿪷ţ�</td>
           <td class="font9" width="220" height="15">
              <select name="status">
		<option value="Y">����</option>
		<option value="N">������</option>
              </select>           
           </td>         
         </tr>         
         <tr align="center" colspan="2"> 
           <td colspan="2">
              <!--a href="#" onClick="javascript:addSubmit()"><input type="image" border="0" name="imageField" src="/images/add.gif" width="68" height="26"></a-->   
              <input type="button" name="btnAccept" value="�ĸ�����" OnClick="javascript:addSubmit()">         
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
<%=jArticleList.errMsg%>
-->
<%--  @# chanpindl_gglb.jsp Ver.1.1 --%>

<%--@ page import="java.util.*" %>
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
<%}--%>


<%@ page import="java.util.*,com.cig.article.*" %>
<jsp:useBean id="journalList" scope="page" class="com.cig.article.JournalList" />
<jsp:setProperty name="journalList" property="DEBUG" value="true"/> 
<jsp:setProperty name="journalList" property="dbpoolName" value="paperec"/>
<jsp:setProperty name="journalList" property="pageFlag" value="Y"/>
<jsp:setProperty name="journalList" property="condLangCode" value="GB"/>
<jsp:setProperty name="journalList" property="pageNo"/>
<jsp:setProperty name="journalList" property="condJournalId"/>
<jsp:setProperty name="journalList" property="condName"/>
<jsp:setProperty name="journalList" property="condIssue"/>
<jsp:setProperty name="journalList" property="condSerialNo"/>
<jsp:setProperty name="journalList" property="condComments"/>

<%
    int total_page =0;
    int journal_count=0;
    Journal[] journals=null;
    
    int pageNo = 1;
    try {
        pageNo = (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    } catch(Exception err) {pageNo = 1;}  
    
    String re_name;
    String value;
    String str="";
    Enumeration e = request.getParameterNames();
    
    while ( e.hasMoreElements()){
    	re_name = (String)e.nextElement();
	value = request.getParameter(re_name);

	if ( re_name.equals("condName") && !value.equals("")) {
	    str += "&condName=" + value;
	}
	if ( re_name.equals("condIssue") && !value.equals("")) {
	    str += "&condIssue=" + value;
	}
	if ( re_name.equals("condSerailNo") && !value.equals("")) {
	    str += "&condSerailNo=" + value;
	}
	if ( re_name.equals("condComments") && !value.equals("")) {
	    str += "&condComments=" + value;
	}		

    }

    boolean return_code ;
    return_code = journalList.search();
    
    journals = journalList.getJournals();
    if (journals==null) journals = new Journal[0];
    journal_count = journalList.getTotalCount();
    total_page = journalList.getTotalPage();
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

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>     
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form method="post" action="journalProcess.jsp?action=add">
        <table width="650" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#f9c026" bordercolordark="#FFFFFF" align="center">
          <tr> 
            <td colspan="8" class="font12">期刊列表：</td>
          </tr>
          <tr>
                  <td class="font9" colspan="4" align="left">共有<%=journal_count%>个期刊，共<%=total_page%>页</td>  
                  <td class="font9" colspan="4" align="right">第<%=pageNo%>页&nbsp;&nbsp;
                    <% if (pageNo!=1) {%>
                    <a href="<%="journalList.jsp?pageNo="+(pageNo-1)+str%>" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageNo!=total_page && total_page>0) {%>
                    <a href="<%="cityList.jsp?pageNo="+(pageNo+1)+str%>" class="font9">下一页</a>&nbsp; 
                    <%}%>                    
                  </td>
          </tr>     
          <tr align="center" class="font9"> 
            <td width="40"><b>期刊ID</b></td>
            <td width="100"><b>期刊名称</b></td>
            <td width="60"><b>期刊号</b></td>
            <td width="60"><b>总期号</b></td>
            <td width="100"><b>期刊注解</b></td>
            <td width="70"><b>&nbsp;</b></td>
            <td width="70"><b>&nbsp;</b></td>
            <td width="60">&nbsp;</td>
          </tr>          
          <% 
          	int restrict = journalList.getRestriction();
                   int list_count = journal_count<restrict?journal_count:restrict;
		   int maxNum = list_count;            
              	  if (pageNo == total_page){
              	      maxNum = journal_count-restrict*(pageNo-1);
              	  }  
              	  if (journal_count >0){                   
                   for (int i=0;i<maxNum;i++){
                 %>          
          <tr align="center" class="font9">
            <td width="40">&nbsp;<%=journals[i].getJournalId()%></td>
            <td width="100">&nbsp;<%=journals[i].getJournalName()%></td>
            <td width="60">&nbsp;<%=journals[i].getJournalIssue()%></td>
            <td width="60">&nbsp;<%=journals[i].getJournalSerialNo()%></td>
            <td width="100">&nbsp;<%=journals[i].getJournalComments()%></td>
            <td width="50"><a href="journalColumnList.jsp?journalId=<%=journals[i].getJournalId()%>" class="font9">查看该期刊栏目</a></td>
            <td width="50"><a href="jarticle_list.jsp?journalId=<%=journals[i].getJournalId()%>" class="font9">查看该期刊文稿</a></td>
            <td width="60"><a href="journalProcess.jsp?action=delete&journalId=<%=journals[i].getJournalId()%>" onClick="return confirm('若该期刊存在其他栏目或文稿将无法删除, 你确认要删除此期刊吗?')" class="font9">期刊删除</a></td>
          </tr>
        <%        }
                 }
         %>
	</table>    
        <table width="450" border="0" cellspacing="2" cellpadding="5" height="10">
                <tr> 
                  <td class="font12">&nbsp;</td>
                </tr>
        </table>	    
        <table width="450" border="0" cellspacing="2" cellpadding="4" bordercolorlight="#f9c026" bordercolordark="#FFFFFF" align="center">        
         <tr align="left"> 
           <td class="font9" width="150" height="15">期刊号：</td>
           <td class="font9" width="300" height="15"><input type="text" name="journalIssue" size="20"></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="150" height="15">总期号：</td>
           <td class="font9" width="300" height="15"><input type="text" name="journalSerialNo" size="20" ></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="150" height="15">期刊名称：</td>
           <td class="font9" width="300" height="15"><input type="text" name="journalName" size="40"></td>
         </tr>
         <tr align="left"> 
           <td class="font9" width="150" height="15">期刊注解：</td>
           <td class="font9" width="300" height="15"><input type="text" name="journalComments" size="40"></td>
         </tr>
         <tr align="center"> 
           <td  colspan="2">
              <input type="button" name="btnAdd" value="增加期刊" OnClick="javascript:submit()">
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

<!--Err: 
<%=journalList.errMsg%>
<%=journals.length%>
-->
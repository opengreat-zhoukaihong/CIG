<%--  @# operator_list.jsp  Ver 1.0 --%>

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
  String funcId = "fnSecMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

<%@ page import="java.util.*,java.io.*" %>
<jsp:useBean id="operatorList" scope="page" class="com.paperec.bst.permission.OperatorList" /> 
<jsp:setProperty name="operatorList" property="DEBUG" value="true" />
<jsp:setProperty name="operatorList" property="dbpoolName" value="paperec" />
<jsp:setProperty name="operatorList" property="pageNo" value="1" />
<jsp:setProperty name="operatorList" property="restriction" value="20" />
<%
    int operatorsCount = 0;
    int totalPage = 0;
    String[][] operators;
    
    String name;
    String value;
    Enumeration e = request.getParameterNames();
    String str="";
    int pageno = 1;
    
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
        pageno = (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    } catch(Exception err) {pageno = 1;}  
    
    operatorList.search();

    operators = operatorList.getOperators();
    operatorsCount = operatorList.getOperatorsCount();
    totalPage = operatorList.getTotalPage();
        
%> 


<html>
<head>


<title>CNHotelBooking.com后台管理工具</title>
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
    if(confirm("Are you sure to delete selected operators?"))
    {
	document.fmOperatorProcess.action.value = "multi_del"
	document.fmOperatorProcess.submit()
    }		
}
	
function del_ope(ope_id)
{
    if(confirm("Are you sure to delete this operator?"))
    {
	document.emptyform.action="operator_process.jsp?action=delete&opeId=" + ope_id; 
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

            <form name=fmOperatorProcess method="post" action="operator_process.jsp">
	    <input type="hidden" name="action" value="">
	    
              <table width="550" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">操作员查询结果(修改请按ID号)</td>
                </tr>
              </table>
              <table width="550" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="5" align="left">共有<%=operatorsCount%>条记录，共<%=totalPage%>页</td>  
                  <td class="font9" colspan="4" align="right">第<%=pageno%>页&nbsp;&nbsp;
                    <% if (pageno>1) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageno-1%><%=str%>" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageno<totalPage) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageno+1%><%=str%>" class="font9">下一页</a>&nbsp; 
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="font9" width="25" height="15">&nbsp;</td>
                  <td class="font9" width="50" height="15">操作员ID</td>
                  <td class="font9" width="60" height="15">操作员名称</td>
                  <td class="font9" width="60" height="15">电话</td>
                  <td class="font9" width="100" height="15">EMAIL</td>
                  <td class="font9" width="100" height="15">描述</td>
                  <td class="font9" width="25" height="15">状态</td>
                  <td class="font9" colspan="2" width="80" height="15">操作</td>
                </tr>
                <% 
              	  if (operators != null){                   
                   for (int i=0; i<operators.length; i++){%>
                <tr align="center"> 
                  <td class="font9" width="25" height="15"><input type="checkbox" name="chk_opeid" value="<%=operators[i][0]%>"></td>
                  <td class="font9" width="50" height="15"><a href="operator_detail.jsp?opeId=<%=operators[i][0]%>" class="font9"><%=operators[i][0]%></a>&nbsp;</td>
                  <td class="font9" width="60" height="15"><%=operators[i][2]%>&nbsp;</td>
                  <td class="font9" width="60" height="15"><%=operators[i][3]%>&nbsp;</td>
                  <td class="font9" width="100" height="15"><%=operators[i][4]%>&nbsp;</td>
                  <td class="font9" width="140" height="15"><%=operators[i][5]%>&nbsp;</td>
                  <td class="font9" width="25" height="15"><%=operators[i][6]%>&nbsp;</td>
                  <td class="font9" width="40" height="15">[<a href="grant_roles.jsp?opeId=<%=operators[i][0]%>" class="font9">grant</a>]</td>
                  <td class="font9" width="40" height="15">[<a href="javascript:del_ope('<%=operators[i][0]%>')" class="font9">delete</a>]</td>
                </tr>
                <% }
                  }
                %>
              </table>
	      <table width="506" border="0" cellspacing="0" cellpadding="0">
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

<%--Err: <%=operatorList.errMsg--%>
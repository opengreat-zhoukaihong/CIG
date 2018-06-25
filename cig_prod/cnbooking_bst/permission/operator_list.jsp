<%--  @# operators_list.jsp  Ver 1.0 --%>

<%@ page import="java.util.*,java.io.*" %>
<%--<jsp:useBean id="UserInfo" scope="page" class="com.cnbooking.bst.UserInfo" /> 
<%
    if (!UserInfo.getAuthorized() && false){
%>
        <jsp:forward page="main_middle.htm" />
        </jsp:forward>
<%  }--%>

<jsp:useBean id="OperatorsList" scope="page" class="com.cnbooking.bst.permission.OperatorsList" /> 
<jsp:setProperty name="OperatorsList" property="pageNo" value="1" />
<jsp:setProperty name="OperatorsList" property="restriction" value="20" />
<%
    int operatorsCount = 0;
    int totalPage = 0;
    String[][] operators;
    
    String name;
    String value;
    Enumeration e = request.getParameterNames();
    String dateFrom="";
    String dateTo="";
    String custName="";
    String custId="";
    String str="";
    int pageno = 1;
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);
%>
<%--=name%>=<%=value%><br>--%>
<%
	if ( name.equals("dateFrom") && !value.equals("")) {
	    str += "&dateFrom=" + value;
	}
	if ( name.equals("dateTo") && !value.equals("")) {
	    str += "&dateTo=" + value;
	}
	if ( name.equals("custName") && !value.equals("")) {
	    str += "&custName=" + value;
	}
	if ( name.equals("custId") && !value.equals("")) {
	    str += "&custId=" + value;
	}
	if ( name.equals("login") && !value.equals("")) {
	    str += "&login=" + value;
	}
	if ( name.equals("email") && !value.equals("")) {
	    str += "&email=" + value;
	}
    }
    
    try {
        pageno = (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    } catch(Exception err) {pageno = 1;}  
    
    OperatorsList.process();

    operators = OperatorsList.getOperators();
    operatorsCount = OperatorsList.getOperatorsCount();
    totalPage = OperatorsList.getTotalPage();
        
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


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">



<span class="font9"></span> <span class="font9"></span> 
<table width="500" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr> 
    <td> 
      <table border="0" cellpadding="0" cellspacing="0" width="500">
        <tr> 
          <td width="30">&nbsp; </td>
          <td> 

              <table width="550" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">操作员查询结果(修改请按ID号)</td>
                </tr>
              </table>
              <table width="550" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="3" align="left">共有<%=operatorsCount%>条记录，共<%=totalPage%>页</td>  
                  <td class="font9" colspan="3" align="right">第<%=pageno%>页&nbsp;&nbsp;
                    <% if (pageno>1) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageno-1%><%=str%>" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageno<totalPage) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageno+1%><%=str%>" class="font9">下一页</a>&nbsp; 
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="font9" width="50" height="15">操作员ID</td>
                  <td class="font9" width="140" height="15">密码</td>
                  <td class="font9" width="60" height="15">操作员名称</td>
                  <td class="font9" width="250" height="15">电话</td>
                  <td class="font9" width="50" height="15">状态</td>
                </tr>
                <% 
              	  if (operators != null){                   
                   for (int i=0; i<operators.length; i++){%>
                <tr align="center"> 
                  <td class="font9" width="50" height="15">&nbsp;<a href="member_user_detail.jsp?custId=<%=operators[i][0]%>" class="font9"> 
                    <%=operators[i][0]%></a></td>
                  <td class="font9" width="140" height="15">&nbsp;<%=operators[i][1]%></td>
                  <td class="font9" width="60" height="15"><a href="#" class="font9"> 
                    &nbsp;<%=operators[i][2]%></a></td>
                  <td class="font9" width="250" height="15">&nbsp;<%=operators[i][3]%></td>
                  <td class="font9" width="50" height="15"><a href="mailto:<%=operators[i][4]%>" class="font9">&nbsp;<%=operators[i][4]%></a></td>
                </tr>
                <% }
                  }
                %>
              </table>
	      <table width="506" border="0" cellspacing="0" cellpadding="0">
        	<tr align="middle"> 
            	  <td height="30">&nbsp; </td>
          	</tr>
              </table>

          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

<%--Err: <%=OperatorsList.errMsg--%>
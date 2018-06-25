<%--  @# member_user_list.jsp  Ver 1.0 --%>

<%@ page import="java.util.*,java.io.*" %>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/main_middle.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnCusMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>


<jsp:useBean id="MemberList" scope="page" class="com.cnbooking.bst.member.MemberList" /> 
<jsp:setProperty name="MemberList" property="pageNo"/>
<jsp:setProperty name="MemberList" property="dateFrom"/> 
<jsp:setProperty name="MemberList" property="dateTo"/>
<jsp:setProperty name="MemberList" property="login"/>
<jsp:setProperty name="MemberList" property="custName"/>
<jsp:setProperty name="MemberList" property="custId"/>
<jsp:setProperty name="MemberList" property="email"/>
<%
    int member_count = 0;
    int total_page = 0;
    String[][] member_list;
    
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
    
    MemberList.getResult();

    member_list = MemberList.getMemberList();
    member_count = MemberList.getMemberCount();
    total_page = MemberList.getTotalPage();
        
%> 

<html>
<head>


<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
        A:link {text-decoration: underline; font-family: "宋体"}
        A:visited {text-decoration: underline; font-family: "宋体"}
        A:active {text-decoration: underline; font-family: "宋体"}
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
                  <td class="font12">会员查询结果(修改请按ID号)</td>
                </tr>
              </table>
              <table width="550" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="3" align="left">共有<%=member_count%>条记录，共<%=total_page%>页</td>  
                  <td class="font9" colspan="3" align="right">第<%=pageno%>页&nbsp;&nbsp;
                    <% if (pageno>1) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageno-1%><%=str%>" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageno<total_page) {%>
                    <a href="member_user_list.jsp?pageNo=<%=pageno+1%><%=str%>" class="font9">下一页</a>&nbsp; 
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="font9" width="50" height="15">会员ID号</td>
                  <td class="font9" width="140" height="15">登录名</td>
                  <td class="font9" width="60" height="15">会员名称</td>
                  <td class="font9" width="250" height="15">入会时间</td>
                  <td class="font9" width="50" height="15">EMAIL</td>
                </tr>
                <% 
              	  if (member_list != null){                   
                   for (int i=0; i<member_list.length; i++){%>
                <tr align="center"> 
                  <td class="font9" width="50" height="15">&nbsp;
                    <a href="member_user_detail.jsp?custId=<%=member_list[i][0]%>" class="font9"><%=member_list[i][0]%></a></td>
                  <td class="font9" width="140" height="15">&nbsp;<%=member_list[i][1]%></td>
                  <td class="font9" width="60" height="15">&nbsp;<%=member_list[i][2]%></a></td>
                  <td class="font9" width="250" height="15">&nbsp;<%=member_list[i][3]%></td>
                  <td class="font9" width="50" height="15">&nbsp;<%=member_list[i][4]%></td>
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

<%--Err: <%=MemberList.errMsg--%>
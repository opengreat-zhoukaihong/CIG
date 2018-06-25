<%--  @# dir_list.jsp  Ver 1.0 --%>

<%@ page import="java.util.*" %>
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

  funcID = "fnDirMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

<jsp:useBean id="DirList" scope="page" class="com.cnbooking.bst.dir.DirList" /> 
<jsp:setProperty name="DirList" property="pageNo"/>
<%
    int dir_count = 0;
    int total_page = 0;
    String[][] dir_list;
    
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
    }
    
    try {
        pageno = (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    } catch(Exception err) {pageno = 1;}  
    
    DirList.getResult();

    dir_list = DirList.getDirList();
    dir_count = DirList.getDirCount();
    total_page = DirList.getTotalPage();
        
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
<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    	  <td width="30" height="407">&nbsp; </td>
          <td> 
              <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">目录设置查询结果(修改请按ID号)</td>
                </tr>
              </table>
              <table width="500" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="2" align="left">共有<%=dir_count%>条记录，共<%=total_page%>页</td>  
                  <td class="font9" colspan="1" align="right">第<%=pageno%>页&nbsp;&nbsp;
                    <% if (pageno>1) {%>
                    <a href="dir_list.jsp?pageNo=<%=pageno-1%><%=str%>" class="font9">上一页</a>&nbsp;
                    <%}%>
                    <% if (pageno<total_page) {%>
                    <a href="dir_list.jsp?pageNo=<%=pageno+1%><%=str%>" class="font9">下一页</a>&nbsp; 
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="font9" width="100" height="15">目录ID号</td>
                  <td class="font9" width="200" height="15">路径</td>
                  <td class="font9" width="200" height="15">说明</td>
                </tr>
                <% 
              	  if (dir_list != null){                   
                   for (int i=0; i<dir_list.length; i++){%>
                <tr align="center"> 
                  <td class="font9" width="100" height="15">&nbsp;
                    <a href="dir_detail.jsp?dirId=<%=dir_list[i][0]%>" class="font9"><%=dir_list[i][0]%></a></td>
                  <td class="font9" width="200" height="15" align="left">&nbsp;<%=dir_list[i][1]%></td>
                  <td class="font9" width="200" height="15">&nbsp;<%=dir_list[i][2]%></a></td>
                </tr>
                <% }
                  }
                %>
              </table>
             <table width="400" border="0" cellspacing="0" cellpadding="0">
               <tr align="middle"> 
                 <td height="30">&nbsp;</td>
               </tr>
             </table>
          </td>
  </tr>
</table>
</body>
</html>

<%--Err: <%=DirList.errMsg--%>
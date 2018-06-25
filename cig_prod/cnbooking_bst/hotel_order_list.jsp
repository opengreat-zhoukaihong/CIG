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


<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.bst.hotel.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnHtBookMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<jsp:useBean id="OrderList" scope="page" class="com.cnbooking.bst.hotel.OrderList" /> 
<jsp:setProperty name="OrderList" property="pageNo"/>
<jsp:setProperty name="OrderList" property="dateFrom"/> 
<jsp:setProperty name="OrderList" property="dateTo"/>
<jsp:setProperty name="OrderList" property="hotelName"/>
<jsp:setProperty name="OrderList" property="bookId"/>
<jsp:setProperty name="OrderList" property="liveName"/>
<jsp:setProperty name="OrderList" property="contactName"/>
<jsp:setProperty name="OrderList" property="status"/>
<%
    int order_count = 0;
    int total_page = 0;
    String[][] order_list;
    
    String name;
    String value;
    Enumeration e = request.getParameterNames();
    String status="";
    String contact_name="";
    String live_name="";
    String dateFrom="";
    String dateTo="";
    String hotelName="";
    String bookId="";
    String str="";
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);

	if ( name.equals("dateFrom") && !value.equals("")) {
	    str += "&dateFrom=" + value;
	}
	if ( name.equals("dateTo") && !value.equals("")) {
	    str += "&dateTo=" + value;
	}
	if ( name.equals("hotelName") && !value.equals("")) {
	    str += "&hotelName=" + value;
	}
	if ( name.equals("bookId") && !value.equals("")) {
	    str += "&bookId=" + value;
	}
	if ( name.equals("liveName") && !value.equals("")) {
	    str += "&liveName=" + value;
	}
	if ( name.equals("contactName") && !value.equals("")) {
	    str += "&contactName=" + value;
	}
	if ( name.equals("status") && !value.equals("")) {
	    str += "&status=" + value;
	}

    }
    
    int pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
      
    
    order_list = OrderList.getOrderList();
    order_count = OrderList.getOrderCount();
    total_page = OrderList.getTotalPage();
        
%> 

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">



<span class="font9"></span> <span class="font9"></span> 
<table width="500" border="0" cellspacing="0" cellpadding="0" height="216">
  <tr> 
    <td width="397"> 
      <table border="0" cellpadding="0" cellspacing="0" width="500">
        <tr> 
          <td width="10">&nbsp; </td>
          <td> 
            <form name=fmOrderResult  action="">
              <table width="400" border="0" cellspacing="2" cellpadding="5" height="40">
                <tr> 
                  <td class="font12">订单查询结果(修改请按ID号)</td>
                </tr>
              </table>
              <table width="450" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
                <tr>
                  <td class="font9" colspan="3" align="left">共有<%=order_count%>条记录，共<%=total_page%>页</td>  
                  <td class="font9" colspan="3" align="right">第<%=pageno%>页&nbsp;&nbsp;
                    <% if (pageno!=total_page) {%>
                    <a href="hotel_order_list.jsp?pageNo=<%=pageno+1%><%=str%>" class="font9">下一页</a>&nbsp; 
                    <%}%>
                    <% if (pageno!=1) {%>
                    <a href="hotel_order_list.jsp?pageNo=<%=pageno-1%><%=str%>" class="font9">上一页</a>&nbsp;
                    <%}%>
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="font9" width="50" height="15">订单号</td>
                  <td class="font9" width="140" height="15">酒店名称</td>
                  <td class="font9" width="60" height="15">入住人</td>
                  <td class="font9" width="150" height="15">预订时间</td>
                  <td class="font9" width="50" height="15">状态</td>
                </tr>
                <% 
                   int list_count = order_count<20?order_count:20;
		   int maxNum = list_count;            
              	  if (pageno == total_page){
              	      maxNum = order_count-OrderList.restriction*(pageno-1);
              	  }  
              	  if (order_count >0){                   
                   for (int i=0;i<maxNum;i++){%>
                <tr align="center"> 
                  <td class="font9" width="50" height="15"><a href="hotel_order_detail.jsp?bookId=<%=order_list[i][0]%>" class="font9"> 
                    <%=order_list[i][0]%></a></td>
                  <td class="font9" width="140" height="15"><a href="HotelModify.jsp?HotelId=<%=order_list[i][5]%>" class="font9"><%=order_list[i][1]%></a></td>
                  <td class="font9" width="60" height="15"><%=order_list[i][2]%></td>
                  <td class="font9" width="150" height="15"><%=order_list[i][3]%></td>
                  <td class="font9" width="50" height="15"><%=order_list[i][4]%></td>
                </tr>
                <% }
                  }
                %>
              </table>
            </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

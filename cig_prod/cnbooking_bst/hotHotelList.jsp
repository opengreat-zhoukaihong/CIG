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

  funcID = "fnHtAddMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>


<jsp:useBean id="HotHotelList" scope="page" class="com.cnbooking.bst.hotel.HotHotelList" /> 

<jsp:useBean id="HotHotel" scope="page" class="com.cnbooking.bst.hotel.HotHotel" /> 
<jsp:setProperty name="HotHotel" property="choiceId"/>
<jsp:setProperty name="HotHotel" property="action"/>
<jsp:setProperty name="HotHotel" property="hotelId"/>
<jsp:setProperty name="HotHotel" property="operatorId"/>


<%
   int hotel_count;
   String[][] hotel_list;
   
  
   String act= request.getParameter("action");

   String operator_id = UserInfo.getUsername();
   
   HotHotel.setOperatorId(operator_id);
    
    
   HotHotel.initHotel();
   
   hotel_list = HotHotelList.getHotelList();   
   hotel_count = HotHotelList.getHotelCount();
   
%>

<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.paraForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("若删除该城市，将会造成已经使用该城市的信息无法显示。你确定删除此城市吗?")

    }
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="font9"></span> <span class="font9"></span> <span class="font12"></span> 
<span class="font12"></span>
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr>   
    <td height="257" valign="top"><!-- #BeginEditable "body" --><br>
      <br>
      <form name="paraForm" method="post" action="">
      
      
        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#f9c026" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="5" class="font12" height="33">热门推荐酒店列表：
                <img src="../images/space.gif" width="150" height="1">
            </td>
          </tr>    
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><b>推荐ID</b></td>
            <td width="60" class="font9"><b>酒店ID</b></td>
            <td width="120" class="font9"><b>酒店名称</b></td>          
            <td width="60" class="font9"><b>推荐标志</b></td>
            <td width="60" class="font9">&nbsp;</td>
          </tr>
                <% 
              	  if (hotel_count >0){                   
                   for (int i=0;i<hotel_count;i++){
                     if (hotel_list[i][3].equals("H")) 
                     	hotel_list[i][3] = "热门";
                     else if (hotel_list[i][3].equals("S")) 
                     	hotel_list[i][3] = "精选";
                     else 
                        hotel_list[i][3] = "&nbsp;";
                     	
                 %>
          <tr align="center" class="font9"> 
            <td width="60" class="font9"><a href="hotHotelEdit.jsp?choiceId=<%=hotel_list[i][0]%>&hotelId=<%=hotel_list[i][1]%>" class="font9"><%=hotel_list[i][0]%></a></td>
            <td width="60" class="font9"><%=hotel_list[i][1]%></td>
            <td width="120" class="font9"><%=hotel_list[i][2]%></td>
            <td width="60" class="font9"><%=hotel_list[i][3]%></td>
            <td width="60" class="font9"><a href="hotHotelEdit.jsp?choiceId=<%=hotel_list[i][0]%>&hotelId=<%=hotel_list[i][1]%>" class="font9">编辑</a></td>
          </tr>
          <%  }
            }
          %>
        </table>
        <br>
        <br>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

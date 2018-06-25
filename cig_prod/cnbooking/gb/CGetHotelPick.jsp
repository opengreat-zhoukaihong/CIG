<html>
<head>
<title>中港澳酒店订房专家</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style>
<!--
        input {font-family:  "宋体"; font-size: 12px ;color:#666666}
        select {font-family:  "宋体"; color:#666666}
        A:link {text-decoration: none; font-family: "宋体"}
        A:visited {text-decoration: none; font-family: "宋体"}
        A:active {text-decoration: none; font-family: 宋体}
        A:hover {text-decoration: underline}
.star {  font-size: 9px; color: #FF8000}
-->
</style>
<style type="text/css">
<!--
td {font-family:  "宋体", "Times New Roman";font-size: 12px;}
-->
</style>
<style type="text/css">
<!--
.email {  font-size: 7.5pt}
.title {  font-size: 14pt; font-weight: bold}
.txt {  font-size: 9pt; line-height: 12pt}
.bigtxt {  font-size: 11pt; line-height: 15pt}
.copyright {  font-size: 8pt; color: #000000}
-->
</style>
<base target="cnhotelmain">

</head>

<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.hotel.*" %> 

<jsp:useBean id="HotelList" scope="page" class="com.cnbooking.hotel.HotelList" /> 
<jsp:setProperty name="HotelList" property="langCode" value="GB"/> 
<jsp:setProperty name="HotelList" property="pageFlag" value="N"/> 
<jsp:setProperty name="HotelList" property="promotion" value="Y"/>
<jsp:setProperty name="HotelList" property="cityId"/>
<jsp:setProperty name="HotelList" property="restriction" value="20"/>

<%
    int hotel_count = 0;
    int total_page = 0;
    String[][] hotel_list;
    String city_id = request.getParameter("cityId");
    
    hotel_list = HotelList.getHotelList();
    hotel_count = HotelList.getHotelCount();

%>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table border="0" width="224" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td width="224" height="64" valign="top"><img src="../../images/special-t.gif" alt="This Month's Special" width="223" height="70"></td>
  </tr>
  <tr> 
    <td width="100%" valign="top"> 
      <table border="0" width="224" cellspacing="0" cellpadding="0" height="1">
        <tr> 
          <td width="6" height="10" align="center"> </td>
          <td colspan="3" width="216"><img src="../../images/space.gif"  width="205" height="9"></td>
        </tr>
        <% for (int i=0;i<hotel_count;i++){
        %>
        <tr> 
           <td height=5 width="8"></td>
           <td valign=center width=109><a href="hotel_detail.jsp?hotelId=<%=hotel_list[i][0]%>" target="cnhotelmain"><font color="#FF8000"><%=hotel_list[i][7]%><%=hotel_list[i][1]%></font></a></td>
           <td valign=center width=52><img src="<%=hotel_list[i][4]%>" height="9"></td>
           <td valign=center width=55><font color="#ff8000"><%=hotel_list[i][5]%></font></td>
       </tr>
       <tr> 
           <td height=3 width="8"></td>
           <td valign=center colspan="3" width="216"><img src="../../images/space.gif"  width="205" height="9"></td>
       </tr>
       <%  }
       %>
       <tr> 
          <td height=5 width="8"></td>
          <td valign=center width=109></td>
          <td valign=center colspan="2" width=107>&nbsp;&nbsp;&nbsp;&nbsp; 
            <a href="hotel_list.jsp?pageNo=1&cityId=<%=city_id%>">更多酒店...</a></td>
       </tr>
        <tr> 
          <td width="6" height="1"></td>
          <td colspan="3" width="216" align="center">
            <table width="50" cellspacing="0" cellpadding="2" border="1" bordercolor="#CFC8CF">
              <tr align="center"> 
                <td><b><a href="javascript:window.close();" target="_self"><font color="#000000">关&nbsp;&nbsp;闭</font></a></b></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td width="8" height="1"></td>
          <td colspan="3" width="216" valign="middle"><img src="../../images/space.gif"  width="205" height="9"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

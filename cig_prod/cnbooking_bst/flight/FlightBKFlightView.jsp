<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
function zy_callpage(url) {
  var newwin=window.open(url,"DetailWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }

function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}
//-->
</script>
<title>后台管理</title>
<style type="text/css">
<!--
 input {font-family: "宋体"; font-size: 12px ;color:#666666}
 select {font-family: "宋体"; font-size: 12px ; color:#666666}
 td {font-family: "宋体", "Times New Roman"; font-size: 12px; color:#666666; line-height: 18px}
 A:link {text-decoration: none; color: #715922; font-family: 宋体}
 A:visited {text-decoration: none; color: #715922; font-family: 宋体}
 A:active {text-decoration: none; font-family: 宋体}
 A:hover {text-decoration: underline; color:#CAA54D}
 .title { font-size: 12px; font-weight: normal; font-family: "宋体"}
-->
</style>
</head>
<%
    String seatClass = request.getParameter("seatClass");
    String flight_Seq=request.getParameter("flight_Seq");
    String round_Trip=request.getParameter("round_Trip");
    String weekday=request.getParameter("weekday");
%>
<jsp:useBean id="FlightBKFlightView" scope="page" class="com.cnbooking.bst.flight.FlightBKFlightView" /> 
<%
FlightBKFlightView.setLangCode("GB");
FlightBKFlightView.setSeatClass(seatClass);
FlightBKFlightView.setRound_Trip(round_Trip);
FlightBKFlightView.setFlight_Seq(flight_Seq);
FlightBKFlightView.setWeekday(weekday);
String[] flightDetail;
flightDetail=FlightBKFlightView.getFlightDetail();
flightDetail=flightDetail==null?(new String[19]):flightDetail;
%>
<body bgcolor="#FFFFFF">
 <p><span class="title"><span class="title"><span class="title"><span class="title"> 
   </span></span></span></span></p>
<hr>
<table width="300" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
<form method="POST" action="">
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">航 班 号：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[0]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">起飞时间：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[1]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        </span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">到达时间：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[2]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">飞机型号：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[4]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">经　　停：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[3]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">起飞城市：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[6]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">到达城市：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[7]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">起飞机场：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[8]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">到达机场：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[9]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">航程类型：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(round_Trip.equals("O")){%>单程<%}else{%>双程<%}%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">舱位等级：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(seatClass.equals("E")){%>经济舱<%}%><%if(seatClass.equals("F")){%>头等舱<%}%><%if(seatClass.equals("B")){%>公务舱<%}%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">星　　期：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=weekday%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">航空公司：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[5]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">定    价：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(flightDetail[10]!=null){%><%=flightDetail[12]%><%=flightDetail[10]%><%}else{%>请电 <%}%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">现    价：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(flightDetail[11]!=null){%><%=flightDetail[12]%><%=flightDetail[11]%><%}else{%>请电 <%}%></span></span></td>
    </tr>
  </table>
  <p align="center"><span class="title"><a href="javascript:window.close();">关闭窗口</a></span></p>
</form>
<br>
</body>
</html>

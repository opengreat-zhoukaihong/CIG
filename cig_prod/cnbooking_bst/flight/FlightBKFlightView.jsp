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
<title>��̨����</title>
<style type="text/css">
<!--
 input {font-family: "����"; font-size: 12px ;color:#666666}
 select {font-family: "����"; font-size: 12px ; color:#666666}
 td {font-family: "����", "Times New Roman"; font-size: 12px; color:#666666; line-height: 18px}
 A:link {text-decoration: none; color: #715922; font-family: ����}
 A:visited {text-decoration: none; color: #715922; font-family: ����}
 A:active {text-decoration: none; font-family: ����}
 A:hover {text-decoration: underline; color:#CAA54D}
 .title { font-size: 12px; font-weight: normal; font-family: "����"}
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
        <div align="right"><span class="title"><span class="title">�� �� �ţ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[0]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">���ʱ�䣺</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[1]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        </span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">����ʱ�䣺</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[2]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�ɻ��ͺţ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[4]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">������ͣ��</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[3]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��ɳ��У�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[6]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">������У�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[7]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��ɻ�����</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[8]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">���������</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[9]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�������ͣ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(round_Trip.equals("O")){%>����<%}else{%>˫��<%}%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��λ�ȼ���</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(seatClass.equals("E")){%>���ò�<%}%><%if(seatClass.equals("F")){%>ͷ�Ȳ�<%}%><%if(seatClass.equals("B")){%>�����<%}%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�ǡ����ڣ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=weekday%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">���չ�˾��</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=flightDetail[5]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��    �ۣ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(flightDetail[10]!=null){%><%=flightDetail[12]%><%=flightDetail[10]%><%}else{%>��� <%}%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��    �ۣ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(flightDetail[11]!=null){%><%=flightDetail[12]%><%=flightDetail[11]%><%}else{%>��� <%}%></span></span></td>
    </tr>
  </table>
  <p align="center"><span class="title"><a href="javascript:window.close();">�رմ���</a></span></p>
</form>
<br>
</body>
</html>

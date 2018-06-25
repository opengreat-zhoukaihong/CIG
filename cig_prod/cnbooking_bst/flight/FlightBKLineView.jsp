<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
<script language="JavaScript">
<!--
function changeFromCity(){
document.PortMap.fromCityGB.value=document.PortMap.fromCityID.options[document.PortMap.fromCityID.selectedIndex].text;
document.PortMap.fromCityEN.value=document.PortMap.fromCityIDEN.options[document.PortMap.fromCityID.selectedIndex].value;
document.PortMap.fromCity_ID.value=document.PortMap.fromCityID.options[document.PortMap.fromCityID.selectedIndex].value;
}

function changeToCity(){
document.PortMap.toCityGB.value=document.PortMap.toCityID.options[document.PortMap.toCityID.selectedIndex].text;
document.PortMap.toCityEN.value=document.PortMap.toCityIDEN.options[document.PortMap.toCityID.selectedIndex].value;
document.PortMap.toCity_ID.value=document.PortMap.toCityID.options[document.PortMap.toCityID.selectedIndex].value;
}

function changeTakeOff_Name(){
document.PortMap.takeOff_NameGB.value=document.PortMap.takeOff_NameID.options[document.PortMap.takeOff_NameID.selectedIndex].text;
document.PortMap.takeOff_NameEN.value=document.PortMap.takeOff_NameIDEN.options[document.PortMap.takeOff_NameID.selectedIndex].value;
document.PortMap.takeOff_ID.value=document.PortMap.takeOff_NameID.options[document.PortMap.takeOff_NameID.selectedIndex].value;
}
function changeLand_Name(){
document.PortMap.land_NameGB.value=document.PortMap.land_NameID.options[document.PortMap.land_NameID.selectedIndex].text;
document.PortMap.land_NameEN.value=document.PortMap.land_NameIDEN.options[document.PortMap.land_NameID.selectedIndex].value;
document.PortMap.land_ID.value=document.PortMap.land_NameID.options[document.PortMap.land_NameID.selectedIndex].value;
}
function changeAirlineName(){
document.PortMap.airlineNameGB.value=document.PortMap.airlineID.options[document.PortMap.airlineID.selectedIndex].text;
document.PortMap.airlineNameEN.value=document.PortMap.airlineIDEN.options[document.PortMap.airlineID.selectedIndex].value;
document.PortMap.airline_ID.value=document.PortMap.airlineID.options[document.PortMap.airlineID.selectedIndex].value;
}
function changePlaneType(){
document.PortMap.plane_TypeGB.value=document.PortMap.plane_TypeID.options[document.PortMap.plane_TypeID.selectedIndex].text;
document.PortMap.plane_TypeEN.value=document.PortMap.plane_TypeIDEN.options[document.PortMap.plane_TypeID.selectedIndex].value;
document.PortMap.plane_Type_ID.value=document.PortMap.plane_TypeID.options[document.PortMap.plane_TypeID.selectedIndex].value;
}
//-->
</script>
<%
    String ope_ID=request.getParameter("ope_ID");
    String line_Seq = request.getParameter("line_Seq");
    String seatClass = request.getParameter("seatClass");
    String round_Trip = request.getParameter("round_Trip");
    String weekday = request.getParameter("weekday");
%>
<jsp:useBean id="FlightBKFlightView" scope="page" class="com.cnbooking.bst.flight.FlightBKFlightView" /> 
<%
FlightBKFlightView.setLangCode("GB");
FlightBKFlightView.setSeatClass(seatClass);
FlightBKFlightView.setRound_Trip(round_Trip);
FlightBKFlightView.setFlight_Seq(line_Seq);
FlightBKFlightView.setWeekday(weekday);
String[] flightDetailGB;
flightDetailGB=FlightBKFlightView.getFlightDetail();
flightDetailGB=flightDetailGB==null?(new String[19]):flightDetailGB;
FlightBKFlightView.setLangCode("EN");
String[] flightDetailEN;
flightDetailEN=FlightBKFlightView.getFlightDetail();
flightDetailEN=flightDetailEN==null?(new String[19]):flightDetailEN;
%>
<jsp:useBean id="BKCity" scope="page" class="com.cnbooking.bst.BKCity" /> 
<%
int cityCount=0;
String[][] cityList;
cityList=BKCity.getCityList();
cityCount=BKCity.getCityCount();
%>
<jsp:useBean id="BKAirLine" scope="page" class="com.cnbooking.bst.flight.BKAirLine" /> 
<%
int lineCount=0;
String[][] lineList;
lineList=BKAirLine.getAirList();
lineCount=BKAirLine.getAirCount();
%>
<jsp:useBean id="BKAirPort" scope="page" class="com.cnbooking.bst.flight.BKAirPort" /> 
<%
int portCount=0;
String[][] portList;
portList=BKAirPort.getPortList();
portCount=BKAirPort.getPortCount();
%>
<jsp:useBean id="BKParameter" scope="page" class="com.cnbooking.bst.BKParameter" /> 
<%
int pCount=0;
String[][] pList;
BKParameter.setID("2");
pList=BKParameter.getList();
pCount=BKParameter.getCount();
%>
<body bgcolor="#FFFFFF">
<form method="POST" name="PortMap" action="FlightBKLineChang.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="line_Seq" value="<%=line_Seq%>" >
<input type=hidden name="seatClass" value="<%=seatClass%>" >
<input type=hidden name="round_Trip" value="<%=round_Trip%>" >
<input type=hidden name="weekday" value="<%=weekday%>" >

<input type=hidden name="fromCity_ID" value="<%=flightDetailGB[14]%>" >
<input type=hidden name="toCity_ID" value="<%=flightDetailGB[15]%>" >
<input type=hidden name="takeOff_ID" value="<%=flightDetailGB[17]%>" >
<input type=hidden name="land_ID" value="<%=flightDetailGB[18]%>" >
<input type=hidden name="airline_ID" value="<%=flightDetailGB[13]%>" >
<input type=hidden name="plane_Type_ID" value="<%=flightDetailGB[16]%>" >
<p><span class="title"><span class="title">航班号： 
<input type="text" name="flightID" size="20" value="<%=flightDetailGB[0]%>" >
<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="plane_TypeID" onchange="javascript:changePlaneType();">
 <%for(int i=0;i<pCount;i++){%>
 <option value="<%=pList[i][0]%>" <%if(flightDetailGB[16].equals(pList[i][0])){%>selected<%}%> ><%=pList[i][1]%></option>
 <%}%>
 <option value="0">其他</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="plane_TypeIDEN" size="1">
 <%for(int i=0;i<pCount;i++){%>
 <option value="<%=pList[i][2]%>"><%=pList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
<br>飞机型号(中)：
<input type="text" name="plane_TypeGB" size="20" value="<%=flightDetailGB[4]%>" disabled >
<br>
飞机型号(英)： 
<input type="text" name="plane_TypeEN" size="20" value="<%=flightDetailEN[4]%>" disabled >
  <br>起飞时间：
  <input type="text" name="takeoff_Time" size="20" value="<%=flightDetailGB[1]%>" >
  <br>
  到达时间： 
  <input type="text" name="arrival_Time" size="20" value="<%=flightDetailGB[2]%>" >
  <br>
  经　　停： 
  <input type="text" name="stay" size="20" value="<%=flightDetailGB[3]%>" >
  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="fromCityID" onchange="javascript:changeFromCity();">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][0]%>" <%if(flightDetailGB[14].equals(cityList[i][0])){%>selected<%}%> ><%=cityList[i][1]%></option>
 <%}%>
 <option value="0">其他</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="fromCityIDEN" size="1">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][2]%>"><%=cityList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
  </span></span><span class="title"><span class="title">起飞城市(中)： 
  <input type="text" name="fromCityGB" size="20" value="<%=flightDetailGB[6]%>" disabled >
 <br>
  </span></span><span class="title"><span class="title">起飞城市(英)： 
  <input type="text" name="fromCityEN" size="20" value="<%=flightDetailEN[6]%>" disabled >
  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="toCityID" onchange="javascript:changeToCity();">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][0]%>" <%if(flightDetailGB[15].equals(cityList[i][0])){%>selected<%}%> ><%=cityList[i][1]%></option>
 <%}%>
 <option value="0">其他</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="toCityIDEN" size="1">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][2]%>"><%=cityList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
  </span></span><span class="title"><span class="title">到达城市(中)： 
  <input type="text" name="toCityGB" size="20" value="<%=flightDetailGB[7]%>" disabled >
 <br>
  </span></span><span class="title"><span class="title">到达城市(英)： 
  <input type="text" name="toCityEN" size="20" value="<%=flightDetailEN[7]%>" disabled >
  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="takeOff_NameID" onchange="javascript:changeTakeOff_Name();">
 <%for(int i=0;i<portCount;i++){%>
 <option value="<%=portList[i][0]%>" <%if(flightDetailGB[17].equals(portList[i][0])){%>selected<%}%> ><%=portList[i][1]%></option>
 <%}%>
 <option value="0">其他</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="takeOff_NameIDEN" size="1">
 <%for(int i=0;i<portCount;i++){%>
 <option value="<%=portList[i][2]%>"><%=portList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
  </span></span><span class="title"><span class="title">起飞机场(中)： 
  <input type="text" name="takeOff_NameGB" size="20" value="<%=flightDetailGB[8]%>" disabled >
 <br>
  </span></span><span class="title"><span class="title">起飞机场(英)： 
  <input type="text" name="takeOff_NameEN" size="20" value="<%=flightDetailEN[8]%>" disabled >
  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="land_NameID" onchange="javascript:changeLand_Name();">
 <%for(int i=0;i<portCount;i++){%>
 <option value="<%=portList[i][0]%>" <%if(flightDetailGB[18].equals(portList[i][0])){%>selected<%}%> ><%=portList[i][1]%></option>
 <%}%>
 <option value="0">其他</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="land_NameIDEN" size="1">
 <%for(int i=0;i<portCount;i++){%>
 <option value="<%=portList[i][2]%>"><%=portList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
  </span></span><span class="title"><span class="title">到达机场(中)： 
  <input type="text" name="land_NameGB" size="20" value="<%=flightDetailGB[9]%>" disabled >
 <br>
  </span></span><span class="title"><span class="title">到达机场(英)： 
  <input type="text" name="land_NameEN" size="20" value="<%=flightDetailEN[9]%>" disabled >
  <br>
  航程类型：
  <select name="round_Trip_" size="1">
 <option value="O" <%if(round_Trip.equals("O")){%>selected<%}%>>单程</option>
 <option value="R" <%if(round_Trip.equals("R")){%>selected<%}%> >双程</option>
 </select> 
   <br>
   舱位等级：
  <select name="seatClass_" size="1">
 <option value="E" <%if(seatClass.equals("E")){%>selected<%}%>>经济舱</option>
 <option value="F" <%if(seatClass.equals("F")){%>selected<%}%> >头等舱</option>
 <option value="B" <%if(seatClass.equals("B")){%>selected<%}%> >公务舱</option>
 </select> 
   <br>
   星　　期：
  <input type="text" name="weekday_" size="20" value="<%=weekday%>" >
  <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="airlineID" onchange="javascript:changeAirlineName();">
 <%for(int i=0;i<lineCount;i++){%>
 <option value="<%=lineList[i][0]%>" <%if(flightDetailGB[13].equals(lineList[i][0])){%>selected<%}%> ><%=lineList[i][1]%></option>
 <%}%>
 <option value="0">其他</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="airlineIDEN" size="1">
 <%for(int i=0;i<lineCount;i++){%>
 <option value="<%=lineList[i][2]%>"><%=lineList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
  </span></span><span class="title"><span class="title">航空公司(中)： 
  <input type="text" name="airlineNameGB" size="20" value="<%=flightDetailGB[5]%>" disabled >
 <br>
  </span></span><span class="title"><span class="title">航空公司(英)： 
  <input type="text" name="airlineNameEN" size="20" value="<%=flightDetailEN[5]%>" disabled >
  <br>
    定    价： 
  <input type="text" name="price" size="20" value="<%=flightDetailGB[10]%>" ><%=flightDetailGB[12]%>
  <br>
   现    价：
  <input type="text" name="curr_price" size="20" value="<%=flightDetailGB[11]%>" ><%=flightDetailGB[12]%>
  </span></span><span class="title"><span class="title">最近操作员：
  <input type="text" name="man_id" size="20" value="<%=ope_ID%>" disabled >
    <br>
    <br>
   </span></span></span></span></p>
  <table width="250" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
        <div align="center"><input type="submit" value="内容修改提交" name="changSub"></div>
      </td>
    </tr>
  </table>
  </form>
  <p><span class="title"><span class="title"><span class="title"><span class="title"> 
    </span></span></span></span></p>
  <hr>
  <p align="center"><span class="title"><a href="javascript:window.close();">关闭窗口</a></span></p>
<br>

</body>
</html>

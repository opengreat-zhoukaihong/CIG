<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>中港澳酒店订房专家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--

var onTop = false
function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}

function zy_callpage(url) {
  var newwin=window.open(url,"DetailWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=605,height=500");
  newwin.focus();
  return false;
 }
// -->
</script>
<style type="text/css">
<!--
 input {font-family: "宋体"; font-size: 12px ;color:#666666}
 select {font-family: "宋体"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 宋体}
 A:visited {text-decoration: none; color: #715922; font-family: 宋体}
 A:active {text-decoration: none; font-family: 宋体}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "宋体", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "宋体"; font-size: 12px}
-->
</style>
</head>
<%
    String ticketAgencyID = request.getParameter("ticketAgencyID").trim();
    String flightWay = request.getParameter("flightWay").trim();
    //(FlightWay.equals("Single") or "Double")
    String homecity = request.getParameter("homecity1").trim();
    String destcity = request.getParameter("destcity1").trim();
    ///String seatClass = request.getParameter("seatClass").trim();
    String airlineChoice = request.getParameter("airlineChoice").trim();
    
    String d_Year = request.getParameter("d_Year").trim();
    String d_Month = request.getParameter("d_Month").trim();
    String d_Day= request.getParameter("d_Day").trim();
    String a_Year = "";
    String a_Month = "";
    String a_Day = "";
    
    if(flightWay.equals("Double")){
    flightWay="R";
    a_Year = request.getParameter("a_Year").trim();
    a_Month = request.getParameter("a_Month").trim();
    a_Day = request.getParameter("a_Day").trim();
    }
    else{flightWay="O";}
    
%>

<jsp:useBean id="FlightList" scope="page" class="com.cnbooking.flight.FlightList" /> 
<%
    FlightList.setLangCode("GB");
    ///FlightList.setSeatClass(seatClass);
    FlightList.setFromCityID(homecity);
    FlightList.setToCityID(destcity);
    FlightList.setTicketAgencyID(ticketAgencyID);
    FlightList.setAirline(airlineChoice);
    FlightList.setRound_Trip(flightWay);
    FlightList.setDYear(d_Year);
    FlightList.setDMonth(d_Month);
    FlightList.setDDay(d_Day);
    ///FlightList.setDHour(d_Hour);
    ///FlightList.setDMinute(d_Minute);
    
    int flightCount=0;
    String[][] flightLists;
    String fromCity="";
    String toCity="";
    
    flightLists = FlightList.getFlightList();
    flightCount = FlightList.getFlightCount();
    fromCity=FlightList.getFormCity();
    toCity=FlightList.getToCity();
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language="JavaScript" src="/javascript/gb/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr> 
    <td width="664" height="34"> 
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr> 
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/gb/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" -->==&gt;&gt;航班搜索结果<!-- #EndEditable --></td>
          <td width="415" background="/images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="/images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> 
     <form name="flightListForm" method="post" action="FlightDestine.jsp">
        <table width="650" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr align="center"> 
            <td height="60"> <br>
              <table width=300 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b><font color="#000000"><%=fromCity%>----&gt;<%=toCity%></font></b></font></span></td>
                </tr>
                <tr align="center"> 
                  <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
              </table>
              <br>
              <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b><font color="#000000">出发航班</font></b></font></span></td>
                </tr>
                <tr align="center"> 
                  <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp; 
              <table width="66" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04">
                <tr valign="middle"> 
                  <td> 
                    <table width="640" border="0" cellspacing="0" cellpadding="0">
                      <tr bgcolor="#FFBC04"> 
                        <td colspan="12" height="1"><img src="/images/space.gif" width="630" height="1" align="absmiddle"></td>
                      </tr>
                      <tr align="center" valign="middle"> 
                        <td width="30">预订</td>
                        <td width="64">航班号</td>
                        <td height="20" width="64">起飞时间</td>
                        <td height="20" width="64">到达时间</td>
                        <td height="20" width="64">起飞机场</td>
                        <td height="20" width="64">到达机场</td>
                        <td height="20" width="64">航空公司</td>
                        <td height="20" width="64">机型</td>
                        <td height="20" width="64">舱位等级</td>
                        <td height="20" width="64">定价</td>
                        <td height="20" width="64">现价</td>
                        <td height="20" width="64">经停</td>
                      </tr>
                      <tr bgcolor="#FFBC04"> 
                        <td colspan="12"><img src="/images/space.gif" width="630" height="1" align="absmiddle"></td>
                      </tr>
              <input type=hidden name=seatClass value="">
              <input type=hidden name=d_Year value="<%=d_Year%>">
              <input type=hidden name=d_Month value="<%=d_Month%>">
              <input type=hidden name=d_Day value="<%=d_Day%>">
              <input type=hidden name=flight_ID value="">
              <input type=hidden name=takeoff_Time value="">
              <input type=hidden name=curr_Price value="">
              <input type=hidden name=currency value="">
              <input type=hidden name=flight_Seq value="">
              <%
              	       int maxNum = flightCount;            
              	       if(flightCount >0){
              	       for (int i=0;i<maxNum;i++){
              	       %>
              	       <tr> 
                        <td height="30"> 
                          <input name=flightsel type=radio onclick="javascript:setdata_d('<%=flightLists[i][0]%>','<%=flightLists[i][1]%>','<%=flightLists[i][8]%>','<%=flightLists[i][9]%>','<%=flightLists[i][10]%>','<%=flightLists[i][12]%>')">
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists[i][0]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists[i][1]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists[i][2]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists[i][4]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists[i][5]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists[i][6]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists[i][3]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%if(flightLists[i][10].equals("E")){%>经济舱<%}%><%if(flightLists[i][10].equals("F")){%>头等舱<%}%><%if(flightLists[i][10].equals("B")){%>公务舱<%}%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%if(flightLists[i][7]!=null){%><%=flightLists[i][7]%><%=flightLists[i][9]%><%}else{%>请电<%}%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%if(flightLists[i][8]!=null){%><%=flightLists[i][8]%><%=flightLists[i][9]%><%}else{%>请电<%}%></div>
                        </td>
                        <td height="30" width="30"><div align="center"><%=flightLists[i][11]%></div></td>
                     </tr>
                     <%}%>
           </table>
           </td>
           </tr>
           </table>
        <font color="#666666"> </font> </td>
       </tr>
         <%
          }else{%>
         </table>
         </td>
         </tr>
        </table>
        <font color="#666666"> </font> </td>
       </tr>
        <tr align="center">
            <td class="txt">&nbsp;</td>
          </tr>
          <tr align="center"> 
            <td class="txt"><font color="#FF0000"><b>目前还没有可预定的此航线，请再做选择！</b></font></td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;</td>
          </tr>
       <%flightWay="O";}%>
        </table>
   <input type=hidden name=a_Year value="<%=a_Year%>">
   <input type=hidden name=a_Month value="<%=a_Month%>">
   <input type=hidden name=a_Day value="<%=a_Day%>">
   <input type=hidden name=seatClass_A value="">
   <input type=hidden name=flight_ID_A value="">
   <input type=hidden name=takeoff_Time_A value="">
   <input type=hidden name=curr_Price_A value="">
   <input type=hidden name=currency_A value="">
   <input type=hidden name=Flight_Seq_A value="">
    <%if(flightWay.equals("R")){%>
    <%
    FlightList.setLangCode("GB");
    ///FlightList.setSeatClass(seatClass);
    FlightList.setFromCityID(destcity);
    FlightList.setToCityID(homecity);
    FlightList.setTicketAgencyID(ticketAgencyID);
    FlightList.setAirline(airlineChoice);
    FlightList.setRound_Trip(flightWay);
    FlightList.setDYear(a_Year);
    FlightList.setDMonth(a_Month);
    FlightList.setDDay(a_Day);
    ///FlightList.setDHour(a_Hour);
    ///FlightList.setDMinute(a_Minute);
    
    flightCount=0;
    String[][] flightLists1;
    fromCity="";
    toCity="";
    
    flightLists1 = FlightList.getFlightList();
    flightCount = FlightList.getFlightCount();
    fromCity=FlightList.getFormCity();
    toCity=FlightList.getToCity();
%>
        <table width="650" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr align="center"> 
            <td> 
              <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b><font color="#000000">返回航班</font></b></font></span></td>
                </tr>
                <tr align="center"> 
                  <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp; 
              <table width="66" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04">
                <tr valign="middle"> 
                  <td> 
                    <table width="640" border="0" cellspacing="0" cellpadding="0">
                      <tr bgcolor="#FFBC04"> 
                        <td colspan="12" height="1"><img src="/images/space.gif" width="630" height="1" align="absmiddle"></td>
                      </tr>
                      <tr align="center" valign="middle"> 
                        <td width="30">预订</td>
                        <td width="64">航班号</td>
                        <td height="20" width="64">起飞时间</td>
                        <td height="20" width="64">到达时间</td>
                        <td height="20" width="64">起飞机场</td>
                        <td height="20" width="64">到达机场</td>
                        <td height="20" width="64">航空公司</td>
                        <td height="20" width="64">机型</td>
                        <td height="20" width="64">舱位等级</td>
                        <td height="20" width="64">定价</td>
                        <td height="20" width="64">现价</td>
                        <td height="20" width="64">经停</td>
                      </tr>
                      <tr bgcolor="#FFBC04"> 
                        <td colspan="12"><img src="/images/space.gif" width="630" height="1" align="absmiddle"></td>
                      </tr>
                     <%
              	     maxNum = flightCount;            
              	     if(flightCount >0){
              	     for (int i=0;i<maxNum;i++){
              	       %>
              	       <tr> 
                        <td height="30"> 
                        <input name=flightsel type=radio onclick="javascript:setdata_a('<%=flightLists1[i][0]%>','<%=flightLists1[i][1]%>','<%=flightLists1[i][8]%>','<%=flightLists1[i][9]%>','<%=flightLists1[i][10]%>','<%=flightLists1[i][12]%>')">
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][0]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][1]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][2]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][4]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][5]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][6]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][3]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%if(flightLists1[i][10].equals("E")){%>经济舱<%}%><%if(flightLists1[i][10].equals("F")){%>头等舱<%}%><%if(flightLists1[i][10].equals("B")){%>公务舱<%}%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][7]%><%=flightLists1[i][9]%></div>
                        </td>
                        <td height="30"> 
                          <div align="center"><%=flightLists1[i][8]%><%=flightLists1[i][9]%></div>
                        </td>
                        <td height="30" width="30"><div align="center"><%if(flightLists1[i][11].equals("Y")){%>Y<%}else{%>N<%}%></div></td>
                      </tr>
             </table>
            </td>
            </tr>
           </table>
          <font color="#666666"> </font> </td>
          </tr>
           <%}
           }else{%>
           </table>
            </td>
            </tr>
           </table>
          <font color="#666666"> </font> </td>
          </tr>
        <tr align="center">
            <td class="txt">&nbsp;</td>
          </tr>
          <tr align="center"> 
            <td class="txt"><font color="#FF0000"><b>目前还没有可预定的此航线，请再做选择！</b></font></td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;</td>
          </tr>
       <%flightWay="O";}%>
       <tr align="center"> 
            <td class="txt">&nbsp;</td>
          </tr>
        </table>
        <br>
     <%}%> 
   <input type=hidden name=ticketAgencyID value="<%=ticketAgencyID%>"> 
   <input type=hidden name=round_Trip value="<%=flightWay%>">
  </from>
  
<script language=javascript>
<!-- //
function setdata_d(flight_ID,takeoff_Time, curr_Price, currency,seatClass,flight_Seq) {
	document.flightListForm.flight_ID.value = flight_ID;
	document.flightListForm.takeoff_Time.value = takeoff_Time;
	document.flightListForm.curr_Price.value = curr_Price;
	document.flightListForm.currency.value = currency;
	document.flightListForm.seatClass.value = seatClass;
	document.flightListForm.flight_Seq.value = flight_Seq;
}

function setdata_a(flight_ID,takeoff_Time, curr_Price, currency,seatClass,flight_Seq) {
	document.flightListForm.flight_ID_A.value = flight_ID;
	document.flightListForm.takeoff_Time_A.value = takeoff_Time;
	document.flightListForm.curr_Price_A.value = curr_Price;
	document.flightListForm.currency_A.value = currency;
	document.flightListForm.seatClass_A.value = seatClass;
	document.flightListForm.flight_Seq_A.value = flight_Seq;
}
function checkdata(sWay)
	{
		if (document.flightListForm.flight_ID.value.length == 0) {
			window.alert("请确定出发的航班!!");
			return;
		  }
		if (sWay=="R" && document.flightListForm.flight_ID_A.value.length == 0) {
			window.alert("请确定返程航班!!如果您不想预订返程航班，请在前页选择单程选项!!");
			return;
        	  }	
		//document.flightListForm.flightWay.value = sWay;
		document.flightListForm.submit();
	}
//-->
</script>
 <div align="center"><a href="javascript:checkdata('<%=flightWay%>');"><img src="/images/gb/enter_air.gif" width="138" height="18" border="0"></a> 
 </div>
 <form method="post" action="">
 </form>
<!-- #EndEditable --></td>
 </tr>
  <tr align="center"> 
  <td colspan="3" height="20" ><a href="javascript:window.history.go(-1);">返回</a></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <%@ include file="../foot_tel.jsp"%>  
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
<script language="JavaScript" src="/javascript/gb/foot.js">
</script>
</table>
</body>
<!-- #EndTemplate -->
</html>

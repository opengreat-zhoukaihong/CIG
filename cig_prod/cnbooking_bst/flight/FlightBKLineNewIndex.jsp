<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnFlOthMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
<%}%>
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
<form method="POST" name="PortMap" action="FlightBKLineInsert.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >

<input type=hidden name="fromCity_ID" value="0" >
<input type=hidden name="toCity_ID" value="0" >
<input type=hidden name="takeOff_ID" value="0" >
<input type=hidden name="land_ID" value="0" >
<input type=hidden name="airline_ID" value="0" >
<input type=hidden name="plane_Type_ID" value="0" >
<p><span class="title"><span class="title">����ţ�
<input type="text" name="flightID" size="20" value="" >
<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="plane_TypeID" onchange="javascript:changePlaneType();">
 <%for(int i=0;i<pCount;i++){%>
 <option value="<%=pList[i][0]%>" ><%=pList[i][1]%></option>
 <%}%>
 <option value="0">����</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="plane_TypeIDEN" size="1">
 <%for(int i=0;i<pCount;i++){%>
 <option value="<%=pList[i][2]%>"><%=pList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
<br>�ɻ��ͺ�(��)��
<input type="text" name="plane_TypeGB" size="20" value="" disabled >
<br>
�ɻ��ͺ�(Ӣ)�� 
<input type="text" name="plane_TypeEN" size="20" value="" disabled >
<br>���ʱ�䣺
<SELECT NAME=d_Hour SIZE=1 Class=Small><%for(int i=1;i<25;i++){%><OPTION VALUE="<%=i%>" ><%=i%></OPTION><%}%></select>ʱ
<SELECT NAME=d_Minute SIZE=1 Class=Small><%for(int i=1;i<61;i++){%><OPTION VALUE="<%=i%>" ><%=i%></OPTION><%}%></select>��
<!--<input type="text" name="takeoff_Time" size="20" value="" >-->
  <br>
����ʱ�䣺 
<SELECT NAME=a_Hour SIZE=1 Class=Small><%for(int i=1;i<25;i++){%><OPTION VALUE="<%=i%>" ><%=i%></OPTION><%}%></select>ʱ
<SELECT NAME=a_Minute SIZE=1 Class=Small><%for(int i=1;i<61;i++){%><OPTION VALUE="<%=i%>" ><%=i%></OPTION><%}%></select>��
<!--<input type="text" name="arrival_Time" size="20" value="" >-->
 <br>
 ������ͣ�� 
<input type="text" name="stay" size="20" value="0" >
  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="fromCityID" onchange="javascript:changeFromCity();">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][0]%>" ><%=cityList[i][1]%></option>
 <%}%>
 <option value="0">����</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="fromCityIDEN" size="1">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][2]%>"><%=cityList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
 <br>
 </span></span><span class="title"><span class="title">��ɳ���(��)�� 
 <input type="text" name="fromCityGB" size="20" value="" disabled >
 <br>
  </span></span><span class="title"><span class="title">��ɳ���(Ӣ)�� 
  <input type="text" name="fromCityEN" size="20" value="" disabled >
  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="toCityID" onchange="javascript:changeToCity();">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][0]%>" ><%=cityList[i][1]%></option>
 <%}%>
 <option value="0">����</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="toCityIDEN" size="1">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][2]%>"><%=cityList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
 <br>
 </span></span><span class="title"><span class="title">�������(��)�� 
 <input type="text" name="toCityGB" size="20" value="" disabled >
 <br>
 </span></span><span class="title"><span class="title">�������(Ӣ)�� 
 <input type="text" name="toCityEN" size="20" value="" disabled >
 <br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="takeOff_NameID" onchange="javascript:changeTakeOff_Name();">
 <%for(int i=0;i<portCount;i++){%>
 <option value="<%=portList[i][0]%>" ><%=portList[i][1]%></option>
 <%}%>
 <option value="0">����</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="takeOff_NameIDEN" size="1">
 <%for(int i=0;i<portCount;i++){%>
 <option value="<%=portList[i][2]%>"><%=portList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
  </span></span><span class="title"><span class="title">��ɻ���(��)�� 
  <input type="text" name="takeOff_NameGB" size="20" value="" disabled >
 <br>
  </span></span><span class="title"><span class="title">��ɻ���(Ӣ)�� 
  <input type="text" name="takeOff_NameEN" size="20" value="" disabled >
  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="land_NameID" onchange="javascript:changeLand_Name();">
 <%for(int i=0;i<portCount;i++){%>
 <option value="<%=portList[i][0]%>" ><%=portList[i][1]%></option>
 <%}%>
 <option value="0">����</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="land_NameIDEN" size="1">
 <%for(int i=0;i<portCount;i++){%>
 <option value="<%=portList[i][2]%>"><%=portList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
  </span></span><span class="title"><span class="title">�������(��)�� 
  <input type="text" name="land_NameGB" size="20" value="" disabled >
 <br>
  </span></span><span class="title"><span class="title">�������(Ӣ)�� 
  <input type="text" name="land_NameEN" size="20" value="" disabled >
  <br>
  �������ͣ�
  <select name="round_Trip_" size="1">
 <option value="O" >����</option>
 <option value="R" >˫��</option>
 </select> 
   <br>
   ��λ�ȼ���
  <select name="seatClass_" size="1">
 <option value="E" >���ò�</option>
 <option value="F" >ͷ�Ȳ�</option>
 <option value="B" >�����</option>
 </select> 
   <br>
   �ǡ����ڣ�
  <input type="text" name="weekday_" size="20" value="" >
  <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="airlineID" onchange="javascript:changeAirlineName();">
 <%for(int i=0;i<lineCount;i++){%>
 <option value="<%=lineList[i][0]%>" ><%=lineList[i][1]%></option>
 <%}%>
 <option value="0">����</option></select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="airlineIDEN" size="1">
 <%for(int i=0;i<lineCount;i++){%>
 <option value="<%=lineList[i][2]%>"><%=lineList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
 </span></span><span class="title"><span class="title">���չ�˾(��)�� 
 <input type="text" name="airlineNameGB" size="20" value="" disabled >
 <br>
 </span></span><span class="title"><span class="title">���չ�˾(Ӣ)�� 
 <input type="text" name="airlineNameEN" size="20" value="" disabled >
 <br>
 ��    �ۣ� 
 <input type="text" name="price" size="20" value="" >
 ��    �ۣ�
 <input type="text" name="curr_price" size="20" value="" >
 <br>
 ��    �� 
 <input type="text" name="currency" size="20" value="" >
 <br>
 </span></span><span class="title"><span class="title">�������Ա��
 <input type="text" name="man_id" size="20" value="<%=ope_ID%>" disabled >
  <br>
  <br>
 </span></span></span></span></p>
 <table width="250" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
        <div align="center"><input type="submit" value="����ύ" name="changSub"></div>
      </td>
    </tr>
 </table>
 </form>
 <p><span class="title"><span class="title"><span class="title"><span class="title"> 
    </span></span></span></span></p>
  <hr>
  <br>
</body>
</html>

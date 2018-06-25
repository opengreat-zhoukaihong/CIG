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
function changeCity(){
document.PortMap.cityNameGB.value=document.PortMap.cityID.options[document.PortMap.cityID.selectedIndex].text;
document.PortMap.cityNameEN.value=document.PortMap.cityIDEN.options[document.PortMap.cityID.selectedIndex].value;
document.PortMap.city_ID.value=document.PortMap.cityID.options[document.PortMap.cityID.selectedIndex].value;
}
//-->
</script>
<%
    String port_ID = request.getParameter("port_ID");
    String ope_ID=request.getParameter("ope_ID");
%>
<jsp:useBean id="FlightBKPortView" scope="page" class="com.cnbooking.bst.flight.FlightBKPortView" /> 
<%
FlightBKPortView.setLangCode("GB");
FlightBKPortView.setPort_ID(port_ID);
String[] portDetailGB;
portDetailGB=FlightBKPortView.getPortDetail();
portDetailGB=portDetailGB==null?(new String[6]):portDetailGB;
String[] portDetailEN;
FlightBKPortView.setLangCode("EN");
portDetailEN=FlightBKPortView.getPortDetail();
portDetailEN=portDetailEN==null?(new String[6]):portDetailEN;
%>
<jsp:useBean id="BKCity" scope="page" class="com.cnbooking.bst.BKCity" /> 
<%
int cityCount=0;
String[][] cityList;
cityList=BKCity.getCityList();
cityCount=BKCity.getCityCount();
%>
<body bgcolor="#FFFFFF">
<form method="POST" name="PortMap" action="FlightBKPortChang.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="port_ID" value="<%=port_ID%>" >
<input type=hidden name="city_ID" value="<%=portDetailGB[5]%>"  >
<p><span class="title"><span class="title">机场名(中)： 
<input type="text" name="portNameGB" size="20" value="<%=portDetailGB[1]%>" >
  <br>
  机场名(英)： 
  <input type="text" name="portNameEN" size="20" value="<%=portDetailEN[1]%>" >
  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="cityID" onchange="javascript:changeCity();">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][0]%>" <%if(portDetailGB[5].equals(cityList[i][0])){%>selected<%}%> ><%=cityList[i][1]%></option>
 <%}%>
 <option value="0">其他</option></select>
 <div id="stateid" style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select name="cityIDEN" size="1">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][2]%>"><%=cityList[i][2]%></option>
 <%}%>
 <option value="0">other</option>
 </select>
 </div> 
  <br>
  </span></span><span class="title"><span class="title">城市名(中)： 
  <input type="text" name="cityNameGB" size="20" value="<%=portDetailGB[4]%>" disabled >
 <br>
  </span></span><span class="title"><span class="title">城市名(英)： 
  <input type="text" name="cityNameEN" size="20" value="<%=portDetailEN[4]%>" disabled >
  <br>
  </span></span><span class="title"><span class="title">机场说明(中)：
  <TEXTAREA cols=40 name="portDescrGB" rows=3>&nbsp;<%=portDetailGB[2]%></TEXTAREA>
  <br>
  机场说明(英)：
  <TEXTAREA cols=40 name="portDescrEN" rows=3>&nbsp;<%=portDetailEN[2]%></TEXTAREA>
    <br>
    </span></span><span class="title"><span class="title">最近操作员：
    <input type="text" name="man_id" size="20" value="<%=portDetailGB[3]%>" disabled >
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

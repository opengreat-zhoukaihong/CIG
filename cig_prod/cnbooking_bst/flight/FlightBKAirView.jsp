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
<%
    String air_ID = request.getParameter("air_ID");
    String ope_ID=request.getParameter("ope_ID");
%>
<jsp:useBean id="FlightBKAirView" scope="page" class="com.cnbooking.bst.flight.FlightBKAirView" /> 
<%
FlightBKAirView.setLangCode("GB");
FlightBKAirView.setAir_ID(air_ID);
String[] airDetailGB;
airDetailGB=FlightBKAirView.getAirDetail();
airDetailGB=airDetailGB==null?(new String[3]):airDetailGB;
String[] airDetailEN;
FlightBKAirView.setLangCode("EN");
airDetailEN=FlightBKAirView.getAirDetail();
airDetailEN=airDetailEN==null?(new String[3]):airDetailEN;
%>
<body bgcolor="#FFFFFF">
<form method="POST" name="AirMap" action="FlightBKAirChang.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="air_ID" value="<%=air_ID%>" >
<p><span class="title"><span class="title">航空公司名(中)： 
<input type="text" name="airNameGB" size="20" value="<%=airDetailGB[1]%>" >
  <br>
  航空公司名(英)： 
  <input type="text" name="airNameEN" size="20" value="<%=airDetailEN[1]%>" >
  <br>
  </span></span><span class="title"><span class="title">最近操作员：
    <input type="text" name="man_id" size="20" value="<%=airDetailGB[2]%>" disabled >
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

<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>中港澳酒店订房专家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
String hotelID=request.getParameter("HotelID");
%>
<jsp:useBean id="CShowHotelMap" scope="page" class="com.cnbooking.hotel.CShowHotelMap" /> 
<%
CShowHotelMap.setLangCode("GB");
CShowHotelMap.setHotelID(hotelID);
if(!CShowHotelMap.getHotelMap()){
%>
       <jsp:forward page="failed.jsp?info=对不起，没有得到此酒店地图!&title=具体位置" />
       </jsp:forward>
<%}
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
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;<a href="hotel_detail.jsp?hotelId=<%=hotelID%>"><%=CShowHotelMap.getName()%></a></font><!-- #EndEditable --></td>
          <td width="415" background="/images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="/images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> <br>
      <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr align="center"> 
          <td> 
            <p><br>
              <%if(CShowHotelMap.getMapfilename()!=null){%><img src="<%=CShowHotelMap.getMapdir()%><%=CShowHotelMap.getMapfilename()%>" border="0" width="424" height="384"><%}else{%><%=CShowHotelMap.getName()%>暂无地图!<%}%></p>
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
      <br><br>
 <table width="560" border="0" cellspacing="0"  align="center">
<tr><td><img width="15"  height="17" src="/images/jd_.gif"   border="0">
<%=CShowHotelMap.getName()%>
</tr></table>
<table width="560" border="0" cellspacing="0"  align="center">
<%
int count=0;
count=CShowHotelMap.getCount();
String[][] mapNamelist;
mapNamelist=CShowHotelMap.getMapNameList();
%>
<%
int col = 0;

for(int i=0;i<count;i++){
if(col == 0){
%>
<tr>
<%
}
col ++;
%>
<td width="25%" noWrap >
<font size="2"><%=mapNamelist[i][0]%>. <%=mapNamelist[i][1]%></font>
</td>
<%if(col == 4){%></tr><%
   col = 0;
 }
}
if(col>0){
 while (col<3){%><td width="25%">&nbsp;</td>
 <%
 col ++;
 }
 %>
</tr>
<%}%>
</table>
<!-- #EndEditable --></td>
</tr>
  <tr>
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <%@ include file="foot_tel.jsp"%> 
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="/javascript/gb/foot.js">
</script>
</table>
</body>
<!-- #EndTemplate --></html>

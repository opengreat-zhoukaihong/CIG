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
// -->
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
    String line_ID=request.getParameter("line_ID");
%>
<jsp:useBean id="TourBKTourView" scope="page" class="com.cnbooking.bst.tour.TourBKTourView" /> 
<%
TourBKTourView.setLangCode("GB");
TourBKTourView.setLine_ID(line_ID);
String[] tourDetail;
tourDetail=TourBKTourView.getTourDetail();
tourDetail=tourDetail==null?(new String[18]):tourDetail;
%>
<body bgcolor="#FFFFFF">
 <p><span class="title"><span class="title"><span class="title"><span class="title"> 
   </span></span></span></span></p>
<hr>
<table width="300" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
<form method="POST" action="">
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">旅游主题：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[0]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">图片名：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[3]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">城市名：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[4]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">图片路径：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[5]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">周一价格：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[6]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">周二价格：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[7]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">周三价格：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[8]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">周四价格：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[9]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">周五价格：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[10]%>&nbsp;&nbsp;</span></span></td>
    </tr>
        <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">周六价格：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[11]%></span></span></td>
    </tr>
        <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">周日价格：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[12]%>&nbsp;&nbsp;</span></span></td>
    </tr>
        <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">联系电话：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[14]%>&nbsp;&nbsp;</span></span></td>
    </tr>
        <tr> 
      <td height="40" width="80"> 
        <div align="right"><span class="title"><span class="title">行程介邵：</span></span></div>
      </td>
      <td height="40" width="220"><span class="title"><span class="title"><%=tourDetail[1]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
     <td height="40" width="80"> 
        <div align="right"><span class="title"><span class="title">服务内容：</span></span></div>
      </td>
      <td height="40" width="220"><span class="title"><span class="title"><%=tourDetail[2]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">最近操作员：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[15]%>&nbsp;&nbsp;</span></span></td>
    </tr>
  </table>
  <p align="center"><span class="title"><a href="javascript:window.close();">关闭窗口</a></span></p>
</form>
<br>
</body>
</html>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
function changeCity(){
document.PortMap.cityNameGB.value=document.PortMap.cityID.options[document.PortMap.cityID.selectedIndex].text;
document.PortMap.city_ID.value=document.PortMap.cityID.options[document.PortMap.cityID.selectedIndex].value;
}
function changeDir(){
document.PortMap.dirpath.value=document.PortMap.dirID2.options[document.PortMap.dirID.selectedIndex].value;
document.PortMap.dir.value=document.PortMap.dirID.options[document.PortMap.dirID.selectedIndex].text;
document.PortMap.dir_ID.value=document.PortMap.dirID.options[document.PortMap.dirID.selectedIndex].value;
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
    String line_ID=request.getParameter("line_ID");
    String ope_ID=request.getParameter("ope_ID");
    String pathValue="";
%>
<jsp:useBean id="TourBKTourView" scope="page" class="com.cnbooking.bst.tour.TourBKTourView" /> 
<%
TourBKTourView.setLangCode("GB");
TourBKTourView.setLine_ID(line_ID);
String[] tourDetail;
tourDetail=TourBKTourView.getTourDetail();
tourDetail=tourDetail==null?(new String[18]):tourDetail;
%>
<jsp:useBean id="BKCity" scope="page" class="com.cnbooking.bst.BKCity" /> 
<%
int cityCount=0;
String[][] cityList;
cityList=BKCity.getCityList();
cityCount=BKCity.getCityCount();
%>
<jsp:useBean id="DirList" scope="page" class="com.cnbooking.bst.dir.DirList" /> 
<jsp:setProperty name="DirList" property="pageFlag" value="N"/>
<%
    int dir_count = 0;
    String[][] dir_list;
    DirList.getResult();
    dir_list = DirList.getDirList();
    dir_count = DirList.getDirCount();
%>
    
<body bgcolor="#FFFFFF">
 <form method="POST" name="PortMap" action="tourBKTourChang.jsp" enctype="multipart/form-data">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="cityID" onchange="javascript:changeCity();">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][0]%>" <%if(tourDetail[16].equals(cityList[i][0])){%>selected<%}%> ><%=cityList[i][1]%></option>
 <%}%>
 </select><br>
 <input type=hidden name="ope_ID" value="<%=ope_ID%>" >
 <input type=hidden name="line_ID" value="<%=line_ID%>" >
 <input type=hidden name="city_ID" value="<%=tourDetail[16]%>"  >
 <input type=hidden name="dir_ID" value="<%=tourDetail[17]%>"  >
 <input type=hidden name="dirpath" value="<%=tourDetail[5]%>" >
<p><span class="title"><span class="title">城市名(中)：
<input type="text" name="cityNameGB" size="20" value="<%=tourDetail[4]%>" disabled >
 <br>
  图片名：
  <input type="file" name="imageFile1"  size="20" >
   <br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="dirID" onchange="javascript:changeDir();">
 <%for(int i=0;i<dir_count;i++){%>
 <option value="<%=dir_list[i][0]%>" <%if(tourDetail[17].equals(dir_list[i][0])){%>selected
 <% pathValue=dir_list[i][2];
 }%>><%=dir_list[i][2]%></option>
 <%}%>
 </select>
 <div style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
 <select size="1" name="dirID2">
 <%for(int i=0;i<dir_count;i++){%>
 <option value="<%=dir_list[i][1]%>" <%if(tourDetail[17].equals(dir_list[i][0])){%>selected<%}%> ><%=dir_list[i][1]%></option>
 <%}%>
 </select>
 </div> 
 <br>
    图片路径：
    <input type="text" name="dir" size="30" value="<%=pathValue%>" disabled >
    <br>
    </span></span><span class="title"><span class="title">周一价格： 
    <input type="text" name="price1" size="20" value="<%=tourDetail[6]%>">
    <br>
    </span></span><span class="title"><span class="title">周二价格： 
    <input type="text" name="price2" size="15" value="<%=tourDetail[7]%>">
    <br>
    </span></span><span class="title"><span class="title">周三价格： 
    <input type="text" name="price3" size="15" value="<%=tourDetail[8]%>">
    <br>
    </span></span><span class="title"><span class="title">周四价格： 
    <input type="text" name="price4" size="15" value="<%=tourDetail[9]%>">
    <br>
    </span></span><span class="title"><span class="title">周五价格： 
    <input type="text" name="price5" size="15" value="<%=tourDetail[10]%>">
    <br>
    </span></span><span class="title"><span class="title">周六价格： 
    <input type="text" name="price6" size="15" value="<%=tourDetail[11]%>">
    <br>
    </span></span><span class="title"><span class="title">周日价格： 
    <input type="text" name="price0" size="15" value="<%=tourDetail[12]%>">
    <br>
    币　　别： 
    <input type="text" name="currency" size="20" value="<%=tourDetail[13]%>">
    <br>
    <br>
    </span></span><span class="title"><span class="title">联系电话： 
    <input type="text" name="tel" size="20" value="<%=tourDetail[14]%>" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
  <table width="300" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
  <form method="POST" action="">
    <tr> 
      <td height="30" width="80"> 
        <div align="right"><span class="title"><span class="title">旅游主题：</span></span></div>
      </td>
      <td height="30" width="220"><span class="title"><span class="title"><%=tourDetail[0]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="40" width="80"> 
        <div align="right"><span class="title"><span class="title">行程介绍：</span></span></div>
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
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[15]%>&nbsp;</span></span></td>
    </tr>
  </table>
  <p align="center"><span class="title"><a href="javascript:window.close();">关闭窗口</a></span></p>
</form>
<br>
</body>
</html>

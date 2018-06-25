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
function changeRoomType(e){
e.room_Type.value=e.room_TypeID.options[e.room_TypeID.selectedIndex].text;
e.room_Type_ID1.value=e.room_TypeID.options[e.room_TypeID.selectedIndex].value;
}
function changePriceType(e){
e.price_Type.value=e.price_TypeID.options[e.price_TypeID.selectedIndex].text;
e.price_Type_ID1.value=e.price_TypeID.options[e.price_TypeID.selectedIndex].value;
}
function changeSource(e){
e.source_Name.value=e.sourceID.options[e.sourceID.selectedIndex].text;
e.source_ID1.value=e.sourceID.options[e.sourceID.selectedIndex].value;
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
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnHtPriceMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=Sorry! You have no permission!" />
<%}%>
<%
    String hotel_ID = request.getParameter("hotel_ID");
    if(hotel_ID==null)
    hotel_ID="800";
    String ope_ID=request.getParameter("ope_ID");
%>
<jsp:useBean id="BKParameter" scope="page" class="com.cnbooking.bst.BKParameter" /> 
<%
int rCount=0;
String[][] rList;
BKParameter.setID("1");
rList=BKParameter.getList();
rCount=BKParameter.getCount();
int pCount=0;
String[][] pList;
BKParameter.setID("4");
pList=BKParameter.getList();
pCount=BKParameter.getCount();
%>
<jsp:useBean id="BKIndusCorp" scope="page" class="com.cnbooking.bst.BKIndusCorp" /> 
<%
int corpCount=0;
String[][] corpList;
corpList=BKIndusCorp.getCorpList();
corpCount=BKIndusCorp.getCorpCount();
%>
<body bgcolor="#FFFFFF">
<p><center><big><b>捷旅内部价格表</b></big></center></p><br>
<form method="POST" name="hotelMap" action="HotelBKPriceAdd.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="hotel_ID" value="<%=hotel_ID%>" >

<input type=hidden name="room_Type_ID1" value="0" >
<input type=hidden name="price_Type_ID1" value="0" >
<input type=hidden name="source_ID1" value= "0" >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="room_TypeID" onchange="javascript:changeRoomType(hotelMap);">
 <%for(int i=0;i<rCount;i++){%>
 <option value="<%=rList[i][0]%>"><%=rList[i][1]%></option>
 <%}%>
 <option value="0" selected>其他</option></select>
 <br>
<p><span class="title"><span class="title">房间类型： 
<input type="text" name="room_Type" size="20" value="" disabled >
    <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="price_TypeID" onchange="javascript:changePriceType(hotelMap);">
 <%for(int i=0;i<pCount;i++){%>
 <option value="<%=pList[i][0]%>"><%=pList[i][3]%></option>
 <%}%>
 <option value="0" selected >其他</option></select>
 <br>
 价格类型： 
 <input type="text" name="price_Type" size="20" value="" disabled >
 <br>
 </span></span><span class="title"><span class="title">生效日期： 
 <input type="text" name="bgn_Date1" size="20" value="">
 <br>
 </span></span><span class="title"><span class="title">失效日期： 
 <input type="text" name="end_Date1" size="15" value="">
 <br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="sourceID" onchange="javascript:changeSource(hotelMap);">
 <%for(int i=0;i<corpCount;i++){%>
 <option value="<%=corpList[i][0]%>"><%=corpList[i][1]%></option>
 <%}%>
 <option value="0" selected >其他</option></select>
 <br>
 </span></span><span class="title"><span class="title">价格来源： 
 <input type="text" name="source_Name" size="20" value="" disabled >
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
 平日价格： 
 <input type="text" name="weekDay_Price" size="20" value="">
    <br>
    </span></span><span class="title"><span class="title">周五价格： 
    <input type="text" name="week5_Price" size="20"value="" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
    周六价格： 
    <input type="text" name="week6_Price" size="20" value="">
    <br>
    </span></span><span class="title"><span class="title">周日价格： 
    <input type="text" name="week7_Price" size="20" value="" >
    <br>
    节日价格： 
    <input type="text" name="holiday_Price" size="20" value="">
    <br>
    门市价格： 
    <input type="text" name="market_Price" size="20" value="">
    <br>
    币    别： 
    <select name="currency1" >
    <option value="HKD" >HKD</option>
    <option value="RMB" >RMB</option>
    <option value="USD" >USD</option>
    </select> 
    <br>
    信用级别： 
    <input type="text" name="level" size="20" value="">
    <br>
    </span></span><span class="title"><span class="title">是否发布： 
    <select name="published" >
    <option value="Y" >是</option>
    <option value="N" >否</option>
    </select>
    <br>
    </span></span><span class="title"><span class="title">备注： 
    <textarea cols=50 name="remark"></textarea>
    <br>
   </span></span></span></span></p>
<table width="250" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
 <td>
  <div align="center"><input type="submit" value="更改提交" name="changSub"></div>
 </td>
</tr>
<tr>  
<td>
<span class="title"><center><a href="javascript:window.close();">关闭窗口</a></center></span>
</td>
</tr>
</table>
</form>
  <p><span class="title"><span class="title"><span class="title"><span class="title"> 
    </span></span></span></span></p>
<br>
</body>
</html>

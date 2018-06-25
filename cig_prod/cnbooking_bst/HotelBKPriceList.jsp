<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
function zy_callpage(url) {
  var newwin=window.open(url,"book","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }
function zy_callpage1(url) {
  var newwin=window.open(url,"flight","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }
 function zy_callpage2(url) {
  var newwin=window.open(url,"man","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }
//-->
</script>
<title>后台管理</title>
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
<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.jsp" />
	</jsp:forward>
<% }
   String ope_ID=UserInfo.getUsername();

   String hotel_ID = request.getParameter("hotel_ID");
    if(hotel_ID==null)
    hotel_ID="800";
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
    if(ope_ID==null)
    ope_ID="admin";
    boolean isPermitted=false;
%>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
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
<jsp:useBean id="HotelBKPriceList" scope="page" class="com.cnbooking.bst.hotel.HotelBKPriceList" /> 
<jsp:setProperty name="HotelBKPriceList" property="pageFlag" value="N"/>
<jsp:setProperty name="HotelBKPriceList" property="restriction" value="16"/>
<jsp:setProperty name="HotelBKPriceList" property="dateFrom" />
<jsp:setProperty name="HotelBKPriceList" property="dateTo" />
<%
    HotelBKPriceList.setLangCode("GB");
    HotelBKPriceList.setHotel_ID(hotel_ID);
    HotelBKPriceList.setChoose("I");
    int priceCount=0;
    int totalPage=0;
    String[][] priceLists;
    int pageno=1;
    pageno= (Integer.valueOf(pageNo)).intValue();
     
    priceLists = HotelBKPriceList.getPriceList();
    priceCount = HotelBKPriceList.getPriceCount();
%>
<body bgcolor="#FFFFFF">
<p><center><span class="txt"><%=HotelBKPriceList.getHotelName()%></span></center></P>
<p><center><span class="txt">捷旅内部价格表</span></center></p>
<p><span class="txt">共有<%=priceCount%>份,&nbsp;&nbsp;&nbsp;&nbsp;<a href="HotelBKPriceList.jsp?pageNo=<%=pageno%>&hotel_ID=<%=hotel_ID%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>">刷新浏览 </a>
&nbsp;&nbsp;&nbsp;&nbsp;<a href="HotelBKNewLogin.jsp?hotel_ID=<%=hotel_ID%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage2(this.href)" >新添加 </a>
</span></p>
<table border="1" width="100%" height="40" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
<form name="BKList">
  <tr> 
    <td width="6%" height="20" class="txt"><font color="#666666">ID</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">房间类型</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">价格类型</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">生效日期</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">失效日期</font></td>
    <td width="10%" height="20" class="txt"><font color="#666666">价格来源</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">平日价</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">周五价</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">周六价</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">周日价</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">节日价</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">备注</font></td>
    <%if(isPermitted){%>
    <td width="7%" height="20" class="txt"><font color="#666666">删除</font></td>
    <%}%>
  </tr>
  <%int maxNum = priceCount;            
     if (priceCount >0){
     for (int i=0;i<maxNum;i++){
    if (i%2 ==0){
    %>
    <tr bgcolor="#ffffff"> 
    <td width="6%" height="20" class="txt">
    <%}else{%><tr bgcolor="#ffffff">
    <td width="6%" height="20" class="txt"><%}%>
    <a href="HotelBKPriceView.jsp?hotel_ID=<%=priceLists[i][18]%>&choose=I&room_Type_ID=<%=priceLists[i][0]%>&price_Type_ID=<%=priceLists[i][2]%>&bgn_Date=<%=priceLists[i][16]%>&end_Date=<%=priceLists[i][17]%>&currency=<%=priceLists[i][10]%>&source_ID=<%=priceLists[i][14]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);"> 
    <%=priceLists[i][18]%></a></td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][1]%> </td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][3]%></td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][16]%></td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][17]%> </td>
    <td width="10%" height="20" class="txt"><%=priceLists[i][15]%> </td>                        
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][4]%></td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][5]%></td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][6]%></td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][7]%></td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][8]%></td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][19]%>&nbsp;</td>
    <%if(isPermitted){%>
    <td width="7%" height="20" class="txt"><a href="HotelBKPriceDel.jsp?hotel_ID=<%=priceLists[i][18]%>&pageNo=<%=pageno%>&room_Type_ID=<%=priceLists[i][0]%>&price_Type_ID=<%=priceLists[i][2]%>&bgn_Date=<%=priceLists[i][16]%>&end_Date=<%=priceLists[i][17]%>&currency=<%=priceLists[i][10]%>&source_ID=<%=priceLists[i][14]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>">删除</a></td>
    <%}%>
    </tr>
    <%
    }
    }
    %> 
</form>    
</table>
<br>
<%
    HotelBKPriceList.setLangCode("GB");
    HotelBKPriceList.setHotel_ID(hotel_ID);
    HotelBKPriceList.setChoose("O");
    priceCount=0;
    totalPage=0;
    priceLists = HotelBKPriceList.getPriceList();
    priceCount = HotelBKPriceList.getPriceCount();
%>
<p><center><span class="txt">对外发布的酒店价格表</span></center></p>
<p><span class="txt">共有<%=priceCount%>份,&nbsp;&nbsp;&nbsp;&nbsp;<a href="HotelBKPriceList.jsp?pageNo=<%=pageno%>&hotel_ID=<%=hotel_ID%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>">刷新浏览</a></span></p>
<%if(isPermitted){%>
<p>&nbsp;&nbsp;&nbsp;&nbsp;<a href="calPriceResult.jsp?hotel_ID=<%=hotel_ID%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>">价格推算</a></span></p>
<%}%>
<table border="1" width="100%" height="40" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
<form name="BKList">
  <tr> 
    <td width="8%" height="20" class="txt"><font color="#666666">ID</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">房间类型</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">价格类型</font></td>
    <td width="10%" height="20" class="txt"><font color="#666666">价格来源</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">生效日期</font></td>
    <td width="12%" height="20" class="txt"><font color="#666666">失效日期</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">平日价</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">周五价</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">周六价</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">周日价</font></td>
    <td width="7%" height="20" class="txt"><font color="#666666">节日价</font></td>
  </tr>
  <% maxNum = priceCount;            
     if (priceCount >0){
     for (int i=0;i<maxNum;i++){
    if (i%2 ==0){
    %>
    <tr bgcolor="#ffffff"> 
    <td width="8%" height="20" class="txt">
    <%}else{%><tr bgcolor="#ffffff">
    <td width="8%" height="20" class="txt"><%}%>
    <a href="HotelBKPriceView.jsp?hotel_ID=<%=priceLists[i][18]%>&choose=O&room_Type_ID=<%=priceLists[i][0]%>&price_Type_ID=<%=priceLists[i][2]%>&bgn_Date=<%=priceLists[i][16]%>&end_Date=<%=priceLists[i][17]%>&currency=<%=priceLists[i][10]%>&source_ID=<%=priceLists[i][14]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage1(this.href);"> 
    <%=priceLists[i][18]%></a></td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][1]%> </td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][3]%></td>
    <td width="10%" height="20" class="txt"><%=priceLists[i][15]%></td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][16]%></td>
    <td width="12%" height="20" class="txt"><%=priceLists[i][17]%> </td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][4]%></td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][5]%></td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][6]%></td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][7]%></td>
    <td width="7%" height="20" class="txt"><%=priceLists[i][10]%><%=priceLists[i][8]%></td>
    </tr>
    <%
    }
    }
    %> 
</form>    
</table>
<p><span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></p>
</body>
</html>

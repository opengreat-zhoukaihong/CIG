<html>
<script language="JavaScript">
<!--
var gt = unescape('%3e');
var popup = null;
var over = "Launch Pop-up Navigator";
popup = window.open('', 'popupnav', 'width=320,height=300,resizable=1,scrollbars=auto');
if (popup != null) {
if (popup.opener == null) {
popup.opener = self; 
}
popup.location.href = '../../big/2001.htm';
}
// -->
</script>
<head>
<!-- #BeginEditable "doctitle" -->
<title>中港澳酒店訂房專家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "細明體"; font-size: 12px ;color:#666666}
 select {font-family: "細明體"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 細明體}
 A:visited {text-decoration: none; color: #715922; font-family: 細明體}
 A:active {text-decoration: none; font-family: 細明體}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "細明體", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "細明體"; font-size: 12px}
-->
</style>

<%@ page import="java.util.*" %>
<%@ page import="com.cnbooking.hotel.*" %> 

<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="quHotList" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="dbLookup" scope="page" class="com.cnbooking.hotel.DBLookUp" />

<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" /> 

<%
quHotList.setConnection(db.getConnection());
dbLookup.setConnection(db.getConnection());
sqlProvide.setLangCode("GB");
int rowCount = 0;
quHotList.executeQuery(sqlProvide.getSql("HotHotel"));
quHotList.setRow(1);
String hotHotelName = Convert.g2b(quHotList.getFieldValue("city_name")) + Convert.g2b(quHotList.getFieldValue("name"));
String hotHotelIamge = quHotList.getFieldValue("Dir") +  quHotList.getFieldValue("ImageFile1") ;
String hotHotelId = quHotList.getFieldValue("Hotel_id");
%>


<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language="JavaScript">
<!--
window.name = "cnhotelmain";
var onTop = false;
function launchRemote(url) {
remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=245,height=360');
}
// -->
</script>
<script language="javascript">

var data = new Array
(
<%
quHotList.executeQuery(sqlProvide.getSql("Lookup.state_city"));
rowCount = quHotList.rowCount();
String strState = "";
String strCity = "";
String stateName = "";
strState = "-偌吽庈靡備刲坰-|0|null";
strCity = "-偌傑庈靡備刲坰-|0|0";
//out.print(quHotList.getMessage());
for (int i = 1; i <= rowCount ; i++)
{
   quHotList.setRow(i);
   if (!stateName.equals(quHotList.getFieldValue("state_name")))
   {
      strState = strState + "*" + quHotList.getFieldValue("state_name") 
   		+ "|" + quHotList.getFieldValue("state_id") + "|null"; 
      stateName = quHotList.getFieldValue("state_name");
      strCity = strCity + "*-偌傑庈靡備刲坰--|0|" + quHotList.getFieldValue("state_id");
   }
   strCity = strCity + "*" + quHotList.getFieldValue("city_name") + 
   	     "|" + quHotList.getFieldValue("city_id") + "|" + 
   	     quHotList.getFieldValue("state_id");
   
  
}
out.println(Convert.g2b("\"" + strState + "\",\"" + strCity + "\""));

%>
);
var selectArray = new Array();
function clearOptions()
{
for(var i=1;i<selectArray.length;i++)
{
for(var j=0;j<selectArray[i].length;j++)
{
selectArray[i].options[j].text=" ";
selectArray[i].options[j].value="";
}
}
}
function updateMenus ()
{
clearOptions();
for ( var i=1 ; i <selectArray.length;i++)
{
var n = selectArray[i-1].selectedIndex;
var optionIndex =0;
var parentID;
var newparent;
var ancestryField;
var childfields = new String();
var childstr = new String();
var allParent;
var lengthCounter = 0;
// parent=selectArray[i-1].options[n].text;
parentID=selectArray[i-1].options[n].value	
//newparent=rTrim(parent);
if(data[i]!=0)
{
childstr = data[i].split("*");
for ( var k=0; k<childstr.length;k++)
{
childfields = childstr[k].split("|");
ancestryField = childfields[2];
allParent = ancestryField.split(",");
for (var j=0;j < allParent.length; j++)
{
 // if(newparent=="-按省市名稱搜索-" && childfields[0]!="-按城市名稱搜索-")
if(parentID==0 && childfields[1]!=0)
 {
lengthCounter += 1;
selectArray[i].length += 1;
selectArray[i].options[optionIndex].text=rTrim(childfields[0]);
selectArray[i].options[optionIndex].value=childfields[1];
optionIndex+=1;
}
else
{ 
//if(newparent == allParent[j])
if(parentID==allParent[j])
{
lengthCounter += 1;
selectArray[i].length += 1;
selectArray[i].options[optionIndex].text=childfields[0];
selectArray[i].options[optionIndex].value=childfields[1];
optionIndex+=1;
}
}
}
}
}

if(lengthCounter==0)
{
selectArray[i].options[optionIndex].text=" ";
selectArray[i].options[optionIndex].value=-1;
}
else
selectArray[i].length=lengthCounter;
}
}

function createMenus()
{
  //alert("dfgdh");
  str = data[0].split("*");
  document.myForm.stateId.length = str.length;
  for ( var i=0; i < str.length; ++i) 
  {
    field = str[i].split("|");
    document.myForm.stateId.options[i].text=rTrim(field[0]);
    document.myForm.stateId.options[i].value=field[1];
  }
  document.myForm.stateId.length = str.length;
  selectArray[0]=document.myForm.stateId;
  selectArray[1]=document.myForm.cityId;
  for ( i=0;i<selectArray.length;i++)
  {
    selectArray[i].selectedIndex = 0;
  }
  updateMenus();
}

function AllSearch()
{
document.myForm.stateId.options[document.myForm.stateId.selectedIndex].text="-按省市名稱搜索-";
document.myForm.cityId.options[document.myForm.cityId.selectedIndex].text="-按城市名稱搜索-";
document.myForm.starId.options[document.myForm.starId.selectedIndex].text="-按星級標准搜索-";
document.myForm.hotelName.value="";
document.myForm.action="hotel_list.jsp?pageNo=1";
document.myForm.method="POST";
document.myForm.submit();
}
function Search()
{
var mystate=document.myForm.stateId.options[document.myForm.stateId.selectedIndex].text;
var mycity=document.myForm.cityId.options[document.myForm.cityId.selectedIndex].text;
var star=document.myForm.starId.options[document.myForm.starId.selectedIndex].text;
var hotel=document.myForm.hotelName.value;
if(mystate=="-按省市名稱搜索-" && mycity=="-按城市名稱搜索-" && star=="-按星級標准搜索-" &&  validateSpaceField(hotel))
{
alert("請輸入查詢條件!");
}
else
{
document.myForm.action="hotel_list.jsp?pageNo=1";
 document.myForm.method="POST";
document.myForm.submit();
}
}
function validateSpaceField(field)
{
if(field.length!=0)
{
for(var i=0;i<field.length;i++)
{
if(field.charAt(i)!=" ")
{
return false;
}
}
}
return true;
}
function rTrim(field)
{

if(field.length!=0)
{
for(var i=0;i<field.length;i++)
{
if(field.charAt(i)==" ")
{
return field.substring(0,field.indexOf(" "));
}
}
}
return field;
}
function bookmark(){
window.external.AddFavorite("http://www.cnbooking.com", "中港澳酒店訂房專家")
}
// -->
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5" onLoad="MM_preloadImages('../../images/link_11b.gif','../../images/link_08b.gif');createMenus()">
<script language="JavaScript" src="../../javascript/gb/title.js">
</script>

<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr> 
    <td width="664" height="3"><img src="../../images/space.gif" width="100" height="3"></td>
  </tr>
  <tr> 
    <td width="664" height="12" bgcolor="#CCCCCC"><a href="/cnbooking/gb/index.jsp"><img src="../../images/gb.gif" width="71" height="12" border="0"></a><a href="/cnbooking/en/index.jsp"><img src="../../images/en.gif" width="71" height="12" border="0"></a></td>
  </tr>
  <tr> 
    <td width="664" height="25"><img src="../../images/big/top_bar.gif" width="664" height="25" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="293,6,357,19" href="../../big/user_manual.htm"><area shape="rect" coords="365,6,429,19" href="../../big/abouts.htm"><area shape="rect" coords="436,6,500,19" href="../../big/jobs.htm"><area shape="rect" coords="508,6,572,19" href="../../big/co-operation.htm"><area shape="rect" coords="580,6,644,19" href="../../big/secrecy.htm"></map></td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="155" height="313" valign="top">
      <table width="155" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="16" background="../../images/right_back.gif">&nbsp;</td>
          <td width="126">
            <table border="0" width="126" cellspacing="0" cellpadding="0" align="center">
              <form name="LoginForm" action="CnBookingLogin.jsp?answerInput=" method="POST">
                <tr align="center" bgcolor="#FFDA9D">
                  <td><span class="pt9">會員： </span>
                    <input type="text" name="username" size="9" style="font-family: 燦　砰; font-size: 12px ;color:#666666">
                  </td>
                </tr>
                <tr align="center" bgcolor="#FFDA9D">
                  <td><span class="pt9">密碼： </span>
                    <input type="password" name="passwd" size="9" style="font-family: 燦　砰; font-size: 12px ;color:#666666">
                  </td>
                </tr>
                <tr bgcolor="#FFDA9D">
                  <td height="8" align="center"><a href="javascript:document.LoginForm.submit()"><font color="#000000"><span class="pt9">登錄</span></font></a>
                    <span class="pt9"><a href="free_register.jsp"><font color="#000000">免費注冊</font></a></span></td>
                </tr>
                <tr>
                  <td height="7" valign="top"><img src="../../images/login_down.gif" width="126" height="7"></td>
                </tr>
              </form>
            </table>
          </td>
          <td width="13">&nbsp;</td>
        </tr>
      </table>
      <table width="155" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="16" height="89" background="../../images/right_back.gif" valign="bottom"><img src="../../images/right_down.gif" width="13" height="26" align="absbottom"></td>
          <td width="126" height="89"> <a href="../../big/hotel_whole_sale.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/big/link_01b.gif',1)"><img src="../../images/big/link_01a.gif" width="127" height="22" border="0" name="Image1"></a> 
            <a href="../../big/hotel_boardinghouse_main.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/big/link_02b.gif',1)"><img src="../../images/big/link_02a.gif" width="127" height="22" border="0" name="Image2"></a> 
            <a href="tour/TourLogin.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/big/link_03b.gif',1)"><img src="../../images/big/link_03a.gif" width="127" height="22" border="0" name="Image3"></a> 
            <a href="../../big/car.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/big/link_04b.gif',1)"><img src="../../images/big/link_04a.gif" width="127" height="22" border="0" name="Image4"></a> 
            <a href="../../big/tour.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','../../images/big/link_05b.gif',1)"><img src="../../images/big/link_05a.gif" width="127" height="22" border="0" name="Image5"></a> 
            <a href="../../big/golf.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../images/big/link_06b.gif',1)"><img src="../../images/big/link_06a.gif" width="127" height="22" border="0" name="Image6"></a> 
            <a href="../../big/translators.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../../images/big/link_07b.gif',1)"><img src="../../images/big/link_07a.gif" width="127" height="22" border="0" name="Image7"></a> 
            <a href="flight/FlightLogin.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','../../images/big/link_08b.gif',1)"><img src="../../images/big/link_08a.gif" width="127" height="22" border="0" name="Image8"></a> 
            <a href="free_register.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','../../images/big/link_09b.gif',1)"><img src="../../images/big/link_09a.gif" width="127" height="22" border="0" name="Image9"></a> 
            <a href="news/tour_news.jsp?pageNo=1" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','../../images/big/link_10b.gif',1)"><img src="../../images/big/link_10a.gif" width="127" height="22" border="0" name="Image10"></a> 
          </td>
          <td width="13" height="89">&nbsp;</td>
        </tr>
      </table>
      <table width="155" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><a href="flight/FlightLogin.jsp"><img src="../../images/big/air_logo.gif" width="155" height="108" border="0"></a></td>
        </tr>
      </table>
    </td>
    <td width="355" height="313" valign="top">
      <table width="355" border="0" cellspacing="0" cellpadding="0" height="55">
        <tr>
          <td><img src="../../images/big/super.gif" width="350" height="50"></td>
        </tr>
      </table>
      <table border="0" width="355" cellspacing="0" cellpadding="0">
        <tr> 
          <td height=10 width="10" class="pt9"></td>
          <td valign=center colspan="4" class="pt9"><img src="../../images/line.gif" width="345" height="1"></td>
        </tr>
        <%
quHotList.executeQuery(sqlProvide.getSql("HotList"));
rowCount = quHotList.rowCount();
//out.print(quHotList.getMessage());
for (int i = 1; i <= rowCount ; i++)
{
   quHotList.setRow(i);
   //out.println(quHotList.getItem(i,4));
%> 
        <tr> 
          <td height=10 width="10" class="pt9"></td>
          <td valign=center width=210 class="pt9"><a href="hotel_detail.jsp?hotelId=<%=quHotList.getFieldValue("Hotel_id")%>"><font color="#FF8000"><%=Convert.g2b(quHotList.getFieldValue("city_name")) + " " + Convert.g2b(quHotList.getFieldValue("name"))%> 
            </font></a></td>
          <td valign=center width=50 class="pt9"><font color="#ff8000"><span class=star> 
            <img src="../..<%=quHotList.getFieldValue("dir") + quHotList.getFieldValue("ImageFile")%>"  height="9"> 
            </span></font></td>
          <td valign=center width=50 class="pt9"><font color="#ff8000"><%
if (!quHotList.getFieldValue("weekday_price").equals("null"))
  out.print(quHotList.getFieldValue("currency") + quHotList.getFieldValue("weekday_price"));
else
  out.print(Convert.g2b("③萇"));
%></font></font></td>
          <td valign=center width=45 class="pt9"> 
            <div align="right"><font color="#ff8000"><%=Convert.g2b(quHotList.getFieldValue("str_value"))%></font></div>
          </td>
        </tr>
        <tr> 
          <td height=10 width="10" class="pt9"></td>
          <td valign=center colspan="4" width="216" class="pt9" height="5"><img src="../../images/line.gif" width="345" height="1"></td>
        </tr>
        <%
}
out.print(quHotList.getMessage());
%> 
        <tr> 
          <td width="10" height="22" class="pt9"></td>
          <form name="form1">
            <td width="216" valign="middle" colspan="4" class="pt9" height="26" align="right"> 
              <font color="#666666"> </font> 
              <select name=list size=1 onChange="launchRemote('CGetHotelPick.jsp?cityId=' + this.form.list.options[this.form.list.selectedIndex].value)">
              <option selected>-各大城市精選-</option>
              <%
       		dbLookup.setSqlLookup(sqlProvide.getSql("Lookup.city"));
       		dbLookup.setDisplayField("name");
       		dbLookup.setValueField("city_id");
       		out.print(Convert.g2b(dbLookup.getLookUp()));
       		%> 
            </select>
          </td>
          </form>
        </tr>
      </table>
    </td>
    <td width="155" height="313" valign="top">
	
        <table width="155" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="155" height="4"><img src="../../images/space.gif" width="155" height="4"></td>
          </tr>
          <tr>
            <td width="155">
              <div align="right">
              <img src="<%=hotHotelIamge%>" width="140" height="93" ></div>
            </td>
          </tr>
          <tr>
            <td width="155"><img src="../../images/big/hot_hotel.gif" width="155" height="31"></td>
          </tr>
          <tr>
            <td width="155" height="22">
              <div align="center"><a href="hotel_detail.jsp?hotelId=<%=hotHotelId%>"><%=hotHotelName%></a></div>
            </td>
          </tr>
          <tr>
            <td height="58" width="155">
              <div align="right"><img src="../../images/big/chabooking.gif" width="138" height="54"></div>
            </td>
          </tr>
          <tr>
            <td width="155">
              <form name="myForm">
              <table width="139" border="0" cellspacing="0" cellpadding="0" align="right">
              	
                <tr align="center">
                  <td height="29"><img src="../../images/big/search-1.gif" width="139" height="26"></td>
                </tr>
                <tr align="center">
                  <td height="25"> 
                    <select name="stateId" size="1" onChange="updateMenus()">
                      <option>-按省市名稱搜索-</option>
                  
                    </select>
                  </td>
                </tr>
                <tr align="center">
                  <td height="25">
                    <select name="cityId" size="1">
                      <option>-按城市名稱搜索-</option>
                      
                    </select>
                  </td>
                </tr>
                <tr align="center">
                  <td height="25">
                    <select name="starId" size="1">
                      <option value="0">-按星級標准搜索-</option>
                      <%
       			
       			dbLookup.setSqlLookup(sqlProvide.getSql("Lookup.star"));
       			dbLookup.setDisplayField("name");
       			dbLookup.setValueField("Id");
       			out.print(Convert.g2b(dbLookup.getLookUp()));
       		      %>
                    </select>
                  </td>
                </tr>
                <tr align="center">
                  <td height="25">价格從 
                    <input type="text" name="priceForm" size="3" maxlength="5">
                    到 
                    <input type="text" name="priceTo" size="3" maxlength="5">
                  </td>
                </tr>
                <tr align="center">
                  <td> <font color="#666666">按酒店名稱搜索</font></td>
                </tr>
                <tr align="center">
                  <td>
                    <input type="text" name="hotelName" size="20" value="" >
                  </td>
                </tr>
                <tr align="center">
                  <td><img src="../../images/big/search-2.gif" width="139" height="21" usemap="#Map2" border="0"><map name="Map2"><area shape="rect" coords="56,3,130,18" href="JavaScript:AllSearch();"><area shape="rect" coords="6,3,45,18" href="JavaScript:Search();"></map></td>
                </tr>
                
              </table>
              </form>
            </td>
          </tr>
        </table>
        
  </tr>
  <tr>
    <td height="2" colspan="3" bgcolor="#FFCC00"><img src="../../images/space.gif" width="600" height="2" align="middle"></td>
  </tr>
  <tr>
    <td height="160" colspan="3">
      <table width="660" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFCC00" bordercolorlight="#CCCCCC" bordercolordark="#FFFFFF">
        <tr align="center" valign="middle"> 
          <td width="110" height="45"><a href="http://www.newone.com.cn" target="_blank"><img src="../../images/banner/ani_logo.gif" width="106" height="41" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.cjol.com" target="_blank"><img src="../../images/banner/cjollogo.gif" width="106" height="30" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.shanghai-air.com" target="_blank"><img src="../../images/banner/shanghaititle.gif" width="106" height="30" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.114online.com/" target="_blank"><img src="../../images/banner/logo_114.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.travelsky.com/" target="_blank"><img src="../../images/banner/travelsky.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.okzjj.com/" target="_blank"><img src="../../images/banner/zlogo2.gif" width="88" height="31" border="0"></a></td>
        </tr>
        <tr align="center" valign="middle"> 
          <td width="110" height="45"><a href="http://www.chinayat.com/" target="_blank"><img src="../../images/banner/yaly.jpg" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.airwap.com" target="_blank"><img src="../../images/banner/airwaplogo.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.travelchannel.com.cn/" target="_blank"><img src="../../images/banner/travelchannel.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.travel10k.com" target="_blank"><img src="../../images/banner/bnr_travellink.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.visapass.com" target="_blank"><img src="../../images/banner/logo88.gif" width="88" height="40" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.pconline.com.cn/pcedu" target="_blank"><img src="../../images/banner/pcedu88.GIF" width="88" height="31" border="0"></a></td>
        </tr>
        <tr align="center" valign="middle"> 
          <td width="110" height="45"><a href="http://www.lnits.com" target="_blank"><img src="../../images/banner/logoa1o.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.96968.com" target="_blank"><img src="../../images/banner/city_logo.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.21sale.net" target="_blank"><img src="../../images/banner/friend_21sale.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45"><a href="http://www.bingmayon.com" target="_blank"><img src="../../images/banner/88x31r.gif" width="88" height="31" border="0"></a></td>
          <td width="110" height="45">&nbsp;</td>
          <td width="110" height="45">&nbsp;</td>
        </tr>
        <tr align="center" valign="middle"> 
          <td width="110" height="20"><a href="http://www.YeahTour.com" target="_blank">四川旅游網</a></td>
          <td width="110" height="20"><a href="http://cxits.yeah.net" target="_blank">北京協力國旅</a></td>
          <td width="110" height="20">&nbsp;</td>
          <td width="110" height="20">&nbsp;</td>
          <td width="110" height="20">&nbsp;</td>
          <td width="110" height="20">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <%@ include file="foot_tel.jsp"%>  
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="../../javascript/big/foot.js">
  </script>
</table>


</body>
</html>
<%db.closeConection();%>

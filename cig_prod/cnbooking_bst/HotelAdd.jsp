<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   String yesterday="";
   String tomorrow="";
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% }else{
   	yesterday = UserInfo.getYesterday();
   	tomorrow  = UserInfo.getTomorrow();
   }
%>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  String userID;
  String funcID;

  funcID = "fnHtAddMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=Sorry! You have no permission!" />
<%}%>
<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="quHotel" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="dbLookup" scope="page" class="com.cnbooking.hotel.DBLookUp" />
<%
quHotel.setConnection(db.getConnection());
dbLookup.setConnection(db.getConnection());
sqlProvide.setLangCode("GB");
int rowCount = 0;
quHotel.executeQuery(sqlProvide.getSql("Bst.StateCity"));
rowCount = quHotel.rowCount();
String strState = "";
String strCity = "";
String stateName = "";
for (int i=1; i<=rowCount ; i++)
{
  quHotel.setRow(i);
  if (!stateName.equals(quHotel.getFieldValue("state_name")))
  {
      //"1.安徽.1","1.澳门.2"
      if (i == rowCount)
        strState = strState + "\"" + quHotel.getFieldValue("Country_id") + 
                 "." + quHotel.getFieldValue("state_name") +
   		 "." + quHotel.getFieldValue("state_id") + "\"";
      else
        strState = strState + "\"" + quHotel.getFieldValue("Country_id") + 
                 "." + quHotel.getFieldValue("state_name") +
   		 "." + quHotel.getFieldValue("state_id") + "\","; 
      stateName = quHotel.getFieldValue("state_name");
      
  }
  if (i == rowCount)
    strCity = strCity + "\"" + quHotel.getFieldValue("Country_id") + 
                 "." + quHotel.getFieldValue("State_id") + 
                 "." + quHotel.getFieldValue("city_name") +
   		 "." + quHotel.getFieldValue("City_id") + "\""; 
  else
     strCity = strCity + "\"" + quHotel.getFieldValue("Country_id") + 
                 "." + quHotel.getFieldValue("State_id") + 
                 "." + quHotel.getFieldValue("city_name") +
   		 "." + quHotel.getFieldValue("City_id") + "\",";
  
}


%>
<html>
<head>
<title>CNHotelBooking.com后台管理工具</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font9 {  font-size: 9pt; color: #FF8000; font-weight: normal}
.font12 {  font-size: 12pt; color: #FF8000; font-weight: bold}
-->
</style>
</head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="initArea()">
<SCRIPT language="JavaScript">
<!--
  provinceArray = new Array(<%=strState%>);
  cityArray = new Array(<%=strCity%>);
  //provinceArray = new Array("1.安徽.1","1.澳门.2","1.北京.3","1.福建.4","1.甘肃.5","1.广东.6","1.广西.7","1.贵州.8","1.海南.9","1.河北.10","1.河南.11","1.黑龙江.12","1.湖北.13","1.湖南.14","1.吉林.15","1.江苏.16","1.江西.17","1.辽宁.18","1.内蒙古.19","1.山东.20","1.山西.21","1.陕西.22","1.上海.23","1.四川.24","1.天津.25","1.西藏.26","1.香港.27","1.新疆.28","1.云南.29","1.浙江.30","1.重庆.31","1.台湾.41","1.宁夏.42","1.青海.43");
  //cityArray = new Array("1.1.合肥.1","1.1.黄山.148","1.2.澳门.2","1.3.北京.3","1.4.福州.4","1.4.武夷山.5","1.4.厦门.6","1.5.敦煌.7","1.5.兰州.8","1.6.东莞.9","1.6.番禺.10","1.6.佛山.11","1.6.广州.12","1.6.鹤山.13","1.6.惠州 .14","1.6.江门.15","1.6.梅州.16","1.6.汕头.17","1.6.深圳.18","1.6.顺德.19","1.6.台山.20","1.6.湛江.21","1.6.肇庆.22","1.6.中山.23","1.6.珠海.24","1.6.潮州.134","1.6.南海.137","1.6.从化.147","1.6.花都.150","1.7.北海.25","1.7.桂林.26","1.7.南宁.27","1.7.阳朔.145","1.8.贵阳.28","1.9.海口.29","1.9.三亚.30","1.9.兴隆 .31","1.10.石家庄.32","1.10.保定.133","1.10.秦皇岛.135","1.11.洛阳.33","1.11.郑州.34","1.12.哈尔滨.35","1.13.武汉.36","1.14.长沙.37","1.15.长春.38","1.16.常州.39","1.16.连云港.40","1.16.南京.41","1.16.苏州.42","1.16.无锡 .43","1.17.南昌.44","1.18.大连.45","1.18.丹东.46","1.18.沈阳.47","1.19.呼和浩特 .48","1.19.包头.151","1.20.济南.49","1.20.青岛.50","1.20.烟台.51","1.21.太原.52","1.22.西安.53","1.23.上海.54","1.24.成都.55","1.25.天津.56","1.26.拉萨.57","1.27.香港.58","1.28.乌鲁木齐.59","1.29.昆明.60","1.30.杭州.61","1.30.宁波.62","1.30.温州.63","1.30.余杭.136","1.30.金华.138","1.31.重庆.64","1.32.台湾.161");
  dropDownItem = new String();

  function changeProvinceInfo(countryBox,provinceBox,cityBox)
  {
    var countryItem = countryBox.value;
    var itemCount;

    if(countryItem>0)
    {
      provinceBox.length=1;
      cityBox.length=1;
      for(var i=0;i<provinceArray.length;i++)
      {
        dropDownItem = provinceArray[i].split(".");
        if(countryItem==dropDownItem[0])
        {
          itemCount = provinceBox.length;
          provinceBox.length += 1;
          provinceBox.options[itemCount].value = dropDownItem[2];
          provinceBox.options[itemCount].text = dropDownItem[1];
        }
      }
      if((document.fmAddHotel.provinceSelect.value==null)||(document.fmAddHotel.provinceSelect.value==""))
        provinceBox.selectedIndex = 1;
      else
        provinceBox.selectedIndex = document.fmAddHotel.provinceSelect.value;
    }
    else
    {
      provinceBox.selectedIndex = 1;
      cityBox.selectedIndex = 1;
      provinceBox.length=1;
      cityBox.length=1;
    }
  }

  function changeCityInfo(countryBox,provinceBox,cityBox)
  {
    var countryItem = countryBox.value;
    var provinceItem = provinceBox.value;
    var itemCount;

    if(provinceItem>0)
    {
      cityBox.length=1;
      for(var i=0;i<cityArray.length;i++)
      {
        dropDownItem = cityArray[i].split(".");
        if(dropDownItem[0]==countryItem && dropDownItem[1]==provinceItem)
        {
          itemCount = cityBox.length;
          cityBox.length += 1;
          cityBox.options[itemCount].value = dropDownItem[3];
          cityBox.options[itemCount].text = dropDownItem[2];
        }
      }
      if((document.fmAddHotel.citySelect.value==null)||(document.fmAddHotel.citySelect.value==""))
        cityBox.selectedIndex = 1;
      else
        cityBox.selectedIndex = document.fmAddHotel.citySelect.value;
    }
    else
    {
      cityBox.selectedIndex = 1;
      cityBox.length=1;
    }
  }

  // 保存省份的选择值
  function saveProvince()
  {
    //document.fmAddHotel.provinceSelect.value = document.fmAddHotel.StateId.selectedIndex;
  }

  // 保存城市的选择值
  function saveCity()
  {
    //document.fmAddHotel.citySelect.value = document.fmAddHotel.CityId.selectedIndex;
  }


  function initArea()
  {
    //changeProvinceInfo(document.fmAddHotel.CountryId,document.fmAddHotel.StateId,document.fmAddHotel.CityId);
    //changeCityInfo(document.fmAddHotel.CountryId,document.fmAddHotel.StateId,document.fmAddHotel.CityId);
  }
//-->
</SCRIPT>
<SCRIPT LANGUAGE=javascript>
<!--
function SetValue()
 {
   fmAddHotel.ImageDir.value = fmAddHotel.ImageDir.options[fmAdd.PicDir1.selectedIndex].text;
  // alert(fmAdd.Dir1.value);
 }

function PostForm()
{
  if (fmAddHotel.Name.value == "")
  {	
	alert("请输入中文名称!");
	return;
  }
  if (fmAddHotel.Address.value == "")
  {	
	alert("请输入地址!");
	return;
  }
  if (fmAddHotel.CityId.value == "0")
  {	
	alert("请输入城市!");
	return;
  }
  if (fmAddHotel.StateId.value == "0")
  {	
	alert("请输入省份!");
	return;
  }
  if (fmAddHotel.CountryId.value == "0")
  {	
	alert("请选择国家!");
	return;
  }

  if (fmAddHotel.Tel.value == "")
  {	
	alert("请输入电话号码!");
	return;
  }
  fmAddHotel.submit();
}
//-->
</SCRIPT>
<span class="font9"></span> <span class="font9"></span> 
<table border="0" celgetUpdateSqllpadding="0" cellspacing="0">
  <tr> 
    <td width="26">&nbsp; </td>
    <td width="547"> 
      <form name= fmAddHotel method="post" action="InsertHotel.jsp" enctype="multipart/form-data">
        <table width="550" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td height="30" class="font12"> 添加酒店资料</td>
          </tr>
        </table>
        <table width="554" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr class="font9"> 
            <td width="78" class="font9" height="35">名称：</td>
            <td class="font9" height="35" width="179"> 
              <input name="Name" 
           >
              * </td>
            <td class="font9" height="35" width="63">国家： 
              <input type="hidden" name="provinceSelect">
              <input type="hidden" name="citySelect" >
            </td>
            <td class="font9" height="35" width="174"> 
              <select name="CountryId" size="1" onChange="changeProvinceInfo(CountryId,StateId,CityId)">
                <option value="0" selected >--请选择--</option>
                <%
                dbLookup.setSqlLookup(sqlProvide.getSql("Bst.Country"));
       		dbLookup.setDisplayField("name");
       		dbLookup.setValueField("Country_Id");
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78">省份：</td>
            <td width="179"> 
              <select name="StateId" size="1" onChange="changeCityInfo(CountryId,StateId,CityId)" onBlur="saveProvince()">
                <option value="0" selected >--请选择--</option>
              </select>
              * </td>
            <td width="63">城市：</td>
            <td width="174"> 
              <select name="CityId" size="1" onBlur="saveCity()">
                <option value="0" selected >--请选择--</option>
              </select>
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78">区域：</td>
            <td width="179"> 
              <select name="LocaId" size="1">
                <option value="0" selected >--请选择--</option>
                <%
                //dbLookup.setSqlLookup(sqlProvide.getSql("Bst.Loca"));
       		//dbLookup.setDisplayField("Loca_name");
       		//dbLookup.setValueField("Loca_Id");
       		//out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
            <td width="63">建立预订：</td>
            <td width="174"> 
              <input type="radio" name="Status" value="Y">
              是 
              <input type="radio" name="Status" value="N" checked>
              否</td>
          </tr>
          <tr class="font9"> 
            <td width="78">地址：</td>
            <td colspan="3"> 
              <input name="Address" maxlength="150" size="50" 
           >
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78">邮政编号：</td>
            <td width="179"> 
              <input name="Postcode" 
           >
            </td>
            <td width="63" class="font9" height="37">电话：</td>
            <td width="174" height="37"> 
              <input name="Tel" 
            style="HEIGHT: 22px; WIDTH: 153px">
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">传真：</td>
            <td width="179"> 
              <input name="Fax" 
           >
            </td>
            <td width="63" class="font9">电子信箱：</td>
            <td width="174"> 
              <input name="Email" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78">星级：</td>
            <td width="179"> 
              <select name="StarRating" size="1">
                <%
       		dbLookup.setSqlLookup(sqlProvide.getSql("Lookup.star"));
       		dbLookup.setDisplayField("name");
       		dbLookup.setValueField("Id");
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
              * </td>
            <td width="63" class="font9">联系人：</td>
            <td width="174"> 
              <input name="Contact" 
           >
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">酒店主页：</td>
            <td colspan="3" class="font9"> 
              <input name="Url" size="50">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">图片路径：</td>
            <td colspan="3"> 
              <select name="ImageDir" size="1">
                <%
       		dbLookup.setSqlLookup(sqlProvide.getSql("Bst.DirSetting"));
       		dbLookup.setDisplayField("DESCR");
       		dbLookup.setValueField("dir_Id");
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">图片文件1：</td>
            <td colspan="3" class="font9"> 
              <input type="file" name="ImageFile1">
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">图片文件2：</td>
            <td colspan="3" class="font9"> 
              <input type="file" name="ImageFile2">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78">图片文件3</td>
            <td colspan="3"> 
              <input type="file" name="ImageFile3">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">地图目录：</td>
            <td colspan="3"> 
              <select name="MapDirId" size="1">
                <%
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78">地图文件：</td>
            <td colspan="3"> 
              <input type="file" name="MapFileName">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">要求推荐：</td>
            <td width="179"> 
              <input type="radio" name="Promotion" value="Y">
              是 
              <input type="radio" name="Promotion" value="N" checked>
              否 </td>
            <td width="63">价格类型：</td>
            <td width="174"> 
              <select name="PriceTypeId" size="1">
                <%
       		dbLookup.setSqlLookup(sqlProvide.getSql("Bst.PriceType"));
       		dbLookup.setDisplayField("DESCR");
       		dbLookup.setValueField("Code");
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9" height="38">具体位置：</td>
            <td colspan="3" height="38"> 
              <input type="text" name="Location" maxlength="100" size="50">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">餐饮设施：</td>
            <td colspan="3"> 
              <TEXTAREA cols=50 name=FacilityDrink></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">娱乐设施：</td>
            <td colspan="3"> 
              <textarea cols=50 name=FacilityEnt></textarea>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">服务设施：</td>
            <td colspan="3"> 
              <TEXTAREA cols=50 name=FacilityServ></TEXTAREA>
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">详细描述：</td>
            <td colspan="3"> 
              <textarea cols=50 name=FullDescr></textarea>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">备注：</td>
            <td colspan="3"> 
              <textarea cols=50 name=Remark></textarea>
            </td>
          </tr>
        </table>
        <table width="550" border="0" cellspacing="0" cellpadding="0">
          <tr align="middle"> 
            <td height="40"> <A href="JavaScript:PostForm()"><IMG border=0 height=26 src="/images/botton_add.gif" width=68></A><IMG height=1 src="images/dot.gif" width=50> 
              <A href="http://bst.cnbooking.com/Hotelprofile_add.htm"><IMG border=0 height=26 src="/images/botton_restore.gif" width=68></a></td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
<%db.closeConection();%>

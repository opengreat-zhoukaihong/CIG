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
      //"1.����.1","1.����.2"
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
<title>CNHotelBooking.com��̨������</title>
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
  //provinceArray = new Array("1.����.1","1.����.2","1.����.3","1.����.4","1.����.5","1.�㶫.6","1.����.7","1.����.8","1.����.9","1.�ӱ�.10","1.����.11","1.������.12","1.����.13","1.����.14","1.����.15","1.����.16","1.����.17","1.����.18","1.���ɹ�.19","1.ɽ��.20","1.ɽ��.21","1.����.22","1.�Ϻ�.23","1.�Ĵ�.24","1.���.25","1.����.26","1.���.27","1.�½�.28","1.����.29","1.�㽭.30","1.����.31","1.̨��.41","1.����.42","1.�ຣ.43");
  //cityArray = new Array("1.1.�Ϸ�.1","1.1.��ɽ.148","1.2.����.2","1.3.����.3","1.4.����.4","1.4.����ɽ.5","1.4.����.6","1.5.�ػ�.7","1.5.����.8","1.6.��ݸ.9","1.6.��خ.10","1.6.��ɽ.11","1.6.����.12","1.6.��ɽ.13","1.6.���� .14","1.6.����.15","1.6.÷��.16","1.6.��ͷ.17","1.6.����.18","1.6.˳��.19","1.6.̨ɽ.20","1.6.տ��.21","1.6.����.22","1.6.��ɽ.23","1.6.�麣.24","1.6.����.134","1.6.�Ϻ�.137","1.6.�ӻ�.147","1.6.����.150","1.7.����.25","1.7.����.26","1.7.����.27","1.7.��˷.145","1.8.����.28","1.9.����.29","1.9.����.30","1.9.��¡ .31","1.10.ʯ��ׯ.32","1.10.����.133","1.10.�ػʵ�.135","1.11.����.33","1.11.֣��.34","1.12.������.35","1.13.�人.36","1.14.��ɳ.37","1.15.����.38","1.16.����.39","1.16.���Ƹ�.40","1.16.�Ͼ�.41","1.16.����.42","1.16.���� .43","1.17.�ϲ�.44","1.18.����.45","1.18.����.46","1.18.����.47","1.19.���ͺ��� .48","1.19.��ͷ.151","1.20.����.49","1.20.�ൺ.50","1.20.��̨.51","1.21.̫ԭ.52","1.22.����.53","1.23.�Ϻ�.54","1.24.�ɶ�.55","1.25.���.56","1.26.����.57","1.27.���.58","1.28.��³ľ��.59","1.29.����.60","1.30.����.61","1.30.����.62","1.30.����.63","1.30.�ຼ.136","1.30.��.138","1.31.����.64","1.32.̨��.161");
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

  // ����ʡ�ݵ�ѡ��ֵ
  function saveProvince()
  {
    //document.fmAddHotel.provinceSelect.value = document.fmAddHotel.StateId.selectedIndex;
  }

  // ������е�ѡ��ֵ
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
	alert("��������������!");
	return;
  }
  if (fmAddHotel.Address.value == "")
  {	
	alert("�������ַ!");
	return;
  }
  if (fmAddHotel.CityId.value == "0")
  {	
	alert("���������!");
	return;
  }
  if (fmAddHotel.StateId.value == "0")
  {	
	alert("������ʡ��!");
	return;
  }
  if (fmAddHotel.CountryId.value == "0")
  {	
	alert("��ѡ�����!");
	return;
  }

  if (fmAddHotel.Tel.value == "")
  {	
	alert("������绰����!");
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
            <td height="30" class="font12"> ��ӾƵ�����</td>
          </tr>
        </table>
        <table width="554" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr class="font9"> 
            <td width="78" class="font9" height="35">���ƣ�</td>
            <td class="font9" height="35" width="179"> 
              <input name="Name" 
           >
              * </td>
            <td class="font9" height="35" width="63">���ң� 
              <input type="hidden" name="provinceSelect">
              <input type="hidden" name="citySelect" >
            </td>
            <td class="font9" height="35" width="174"> 
              <select name="CountryId" size="1" onChange="changeProvinceInfo(CountryId,StateId,CityId)">
                <option value="0" selected >--��ѡ��--</option>
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
            <td width="78">ʡ�ݣ�</td>
            <td width="179"> 
              <select name="StateId" size="1" onChange="changeCityInfo(CountryId,StateId,CityId)" onBlur="saveProvince()">
                <option value="0" selected >--��ѡ��--</option>
              </select>
              * </td>
            <td width="63">���У�</td>
            <td width="174"> 
              <select name="CityId" size="1" onBlur="saveCity()">
                <option value="0" selected >--��ѡ��--</option>
              </select>
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78">����</td>
            <td width="179"> 
              <select name="LocaId" size="1">
                <option value="0" selected >--��ѡ��--</option>
                <%
                //dbLookup.setSqlLookup(sqlProvide.getSql("Bst.Loca"));
       		//dbLookup.setDisplayField("Loca_name");
       		//dbLookup.setValueField("Loca_Id");
       		//out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
            <td width="63">����Ԥ����</td>
            <td width="174"> 
              <input type="radio" name="Status" value="Y">
              �� 
              <input type="radio" name="Status" value="N" checked>
              ��</td>
          </tr>
          <tr class="font9"> 
            <td width="78">��ַ��</td>
            <td colspan="3"> 
              <input name="Address" maxlength="150" size="50" 
           >
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78">������ţ�</td>
            <td width="179"> 
              <input name="Postcode" 
           >
            </td>
            <td width="63" class="font9" height="37">�绰��</td>
            <td width="174" height="37"> 
              <input name="Tel" 
            style="HEIGHT: 22px; WIDTH: 153px">
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">���棺</td>
            <td width="179"> 
              <input name="Fax" 
           >
            </td>
            <td width="63" class="font9">�������䣺</td>
            <td width="174"> 
              <input name="Email" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78">�Ǽ���</td>
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
            <td width="63" class="font9">��ϵ�ˣ�</td>
            <td width="174"> 
              <input name="Contact" 
           >
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">�Ƶ���ҳ��</td>
            <td colspan="3" class="font9"> 
              <input name="Url" size="50">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">ͼƬ·����</td>
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
            <td width="78" class="font9">ͼƬ�ļ�1��</td>
            <td colspan="3" class="font9"> 
              <input type="file" name="ImageFile1">
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">ͼƬ�ļ�2��</td>
            <td colspan="3" class="font9"> 
              <input type="file" name="ImageFile2">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78">ͼƬ�ļ�3</td>
            <td colspan="3"> 
              <input type="file" name="ImageFile3">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">��ͼĿ¼��</td>
            <td colspan="3"> 
              <select name="MapDirId" size="1">
                <%
       		out.print(dbLookup.getLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78">��ͼ�ļ���</td>
            <td colspan="3"> 
              <input type="file" name="MapFileName">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">Ҫ���Ƽ���</td>
            <td width="179"> 
              <input type="radio" name="Promotion" value="Y">
              �� 
              <input type="radio" name="Promotion" value="N" checked>
              �� </td>
            <td width="63">�۸����ͣ�</td>
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
            <td width="78" class="font9" height="38">����λ�ã�</td>
            <td colspan="3" height="38"> 
              <input type="text" name="Location" maxlength="100" size="50">
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">������ʩ��</td>
            <td colspan="3"> 
              <TEXTAREA cols=50 name=FacilityDrink></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">������ʩ��</td>
            <td colspan="3"> 
              <textarea cols=50 name=FacilityEnt></textarea>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">������ʩ��</td>
            <td colspan="3"> 
              <TEXTAREA cols=50 name=FacilityServ></TEXTAREA>
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">��ϸ������</td>
            <td colspan="3"> 
              <textarea cols=50 name=FullDescr></textarea>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">��ע��</td>
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

<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="quHotel" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="quDir" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="dbLookup" scope="page" class="com.cnbooking.hotel.DBLookUp" />
<%
String langCode = request.getParameter("LangCode");
if (langCode == null)
  langCode = "GB";
quHotel.setConnection(db.getConnection());
dbLookup.setConnection(db.getConnection());
sqlProvide.setLangCode(langCode);
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

sqlProvide.setHotelId(request.getParameter("HotelId"));
quHotel.executeQuery(sqlProvide.getSql("Bst.HotelDetail"));
quHotel.setRow(1);
sqlProvide.setStateId(quHotel.getFieldValue("State_id"));
sqlProvide.setCountryId(quHotel.getFieldValue("Country_id"));

quDir.setConnection(db.getConnection());
sqlProvide.setDirId(quHotel.getFieldValue("Imagedir"));
quDir.executeQuery(sqlProvide.getSql("Bst.GetDir"));
//out.print(sqlProvide.getSql("Bst.GetDir"));
quDir.setRow(1);
String imageDir = quDir.getFieldValue("Dir");
//out.print("imageDir" + imageDir);
sqlProvide.setDirId(quHotel.getFieldValue("mapDirId"));
quDir.executeQuery(sqlProvide.getSql("Bst.GetDir"));
quDir.setRow(1);
String mapDir = quDir.getFieldValue("Dir");
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
  dropDownItem = new String();

  function changeProvinceInfo(countryBox,provinceBox,cityBox)
  {
    var countryItem = countryBox.selectedIndex;
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
    var countryItem = countryBox.selectedIndex;
    var provinceItem = provinceBox.selectedIndex;
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
    document.fmAddHotel.provinceSelect.value = document.fmAddHotel.StateId.selectedIndex;
  }

  // ������е�ѡ��ֵ
  function saveCity()
  {
    document.fmAddHotel.citySelect.value = document.fmAddHotel.CityId.selectedIndex;
  }


  function initArea()
  {
    changeProvinceInfo(document.fmAddHotel.CountryId,document.fmAddHotel.StateId,document.fmAddHotel.CityId);
    changeCityInfo(document.fmAddHotel.CountryId,document.fmAddHotel.StateId,document.fmAddHotel.CityId);
  }
//-->
</SCRIPT>
<SCRIPT LANGUAGE=javascript>
<!--


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
  if (fmAddHotel.CityId.value == "")
  {	
	alert("���������!");
	return;
  }
  if (fmAddHotel.StateId.value == "")
  {	
	alert("������ʡ��!");
	return;
  }
  if (fmAddHotel.CountryId.value == "")
  {	
	alert("��ѡ�����!");
	return;
  }
  if (fmAddHotel.Postcode.value == "")
  {	
	alert("�������������!");
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

<table border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="26">&nbsp; </td>
    <td width="547"> 
      <form name= fmAddHotel method="post" action="UpdateHotel.jsp" enctype="multipart/form-data">
        <table width="550" border="0" cellspacing="2" cellpadding="5" height="40">
          <tr> 
            <td height="30" class="font12"> ���¾Ƶ�����
              <input type="hidden" name="HotelId" value="<%=quHotel.getFieldValue("Hotel_id")%>">
              <input type="hidden" name="LangCode" value="<%=langCode%>">
            </td>
          </tr>
        </table>
        <table width="554" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#f9c026" bordercolordark="#ffffff">
          <tr class="font9"> 
            <td width="78" class="font9" height="35">���ƣ�</td>
            <td class="font9" height="35" width="179"> 
              <input name="Name" value="<%=quHotel.getFieldValue("Name")%>"
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
       		dbLookup.setSelectValue(quHotel.getFieldValue("Country_id"));
       		out.print(dbLookup.setLookUp());
       	      %> 
              </select>
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78">ʡ�ݣ�</td>
            <td width="179"> 
              <select name="StateId" size="1" onChange="changeCityInfo(CountryId,StateId,CityId)" onBlur="saveProvince()">
                <option value="0" selected >--��ѡ��--</option>
                <%
                dbLookup.setSqlLookup(sqlProvide.getSql("Bst.SetState"));
       		dbLookup.setDisplayField("name");
       		dbLookup.setValueField("State_Id");
       		dbLookup.setSelectValue(quHotel.getFieldValue("State_id"));
       		out.print(dbLookup.setLookUp());
       	      %> 
              </select>
              * </td>
            <td width="63">���У�</td>
            <td width="174"> 
              <select name="CityId" size="1" onBlur="saveCity()">
                <option value="0" selected >--��ѡ��--</option>
                <%
                dbLookup.setSqlLookup(sqlProvide.getSql("Bst.SetCity"));
       		dbLookup.setDisplayField("name");
       		dbLookup.setValueField("City_Id");
       		dbLookup.setSelectValue(quHotel.getFieldValue("City_id"));
       		out.print(dbLookup.setLookUp());
       	      %> 
              </select>
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78">����</td>
            <td width="179"> 
              <select name="LocaId" size="1">
                <option value="0" selected >--��ѡ��--</option>
                <%
                dbLookup.setSqlLookup(sqlProvide.getSql("Bst.Loca"));
       		dbLookup.setDisplayField("Loca_name");
       		dbLookup.setValueField("Loca_Id");
       		dbLookup.setSelectValue(quHotel.getFieldValue("Loca_id"));
       		out.print(dbLookup.setLookUp());
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
              <input name="Address" maxlength="150" size="50" value="<%=quHotel.getFieldValue("Address")%>"
           >
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78">������ţ�</td>
            <td width="179"> 
              <input name="Postcode" value="<%=quHotel.getFieldValue("Postcode")%>" 
           >
              &nbsp;* </td>
            <td width="63" class="font9" height="37">�绰��</td>
            <td width="174" height="37"> 
              <input name="Tel" value="<%=quHotel.getFieldValue("tel")%>" 
            style="HEIGHT: 22px; WIDTH: 153px">
              &nbsp;* </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">���棺</td>
            <td width="179"> 
              <input name="Fax"  value="<%=quHotel.getFieldValue("fax")%>"
           >
            </td>
            <td width="63" class="font9">�������䣺</td>
            <td width="174"> 
              <input name="Email" value="<%=quHotel.getFieldValue("email")%>" 
           >
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78">�Ǽ���</td>
            <td width="179"> 
              <select name="Starating" size="1">
                <%
       		dbLookup.setSqlLookup(sqlProvide.getSql("Lookup.star"));
       		dbLookup.setDisplayField("name");
       		dbLookup.setValueField("Id");
       		dbLookup.setSelectValue(quHotel.getFieldValue("Star_rating"));
       		out.print(dbLookup.setLookUp());
       	      %> 
              </select>
              * </td>
            <td width="63" class="font9">��ϵ�ˣ�</td>
            <td width="174"> 
              <input name="Contact" value="<%=quHotel.getFieldValue("Contact")%>"
           >
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">�Ƶ���ҳ��</td>
            <td colspan="3" class="font9"> 
              <input name="Url" size="50" value="<%=quHotel.getFieldValue("url")%>">
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
       		dbLookup.setSelectValue(quHotel.getFieldValue("Imagedir"));
       		out.print(dbLookup.setLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">ͼƬ�ļ�1��</td>
            <td class="font9"> 
              <input type="file" name="ImageFile1">
              <input type="hidden" name="OldImageFile1" value="<%=quHotel.getFieldValue("ImageFile1")%>">
            </td>
            <td colspan="2" class="font9"><img src="<%=imageDir + quHotel.getFieldValue("ImageFile1")%>" width="150" ></td>
          </tr>
          <tr> 
            <td width="78" class="font9">ͼƬ�ļ�2��</td>
            <td class="font9"> 
              <input type="file" name="ImageFile2">
              <input type="hidden" name="OldImageFile2" value="<%=quHotel.getFieldValue("ImageFile2")%>">
            </td>
            <td colspan="2" class="font9"><img src="<%=imageDir + quHotel.getFieldValue("ImageFile2")%>"  width="150"></td>
          </tr>
          <tr class="font9"> 
            <td width="78">ͼƬ�ļ�3</td>
            <td> 
              <input type="file" name="ImageFile3">
              <input type="hidden" name="OldImageFile3" value="<%=quHotel.getFieldValue("ImageFile3")%>">
            </td>
            <td colspan="2"><img src="<%=imageDir + quHotel.getFieldValue("ImageFile3")%>" width="150" ></td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">��ͼĿ¼��</td>
            <td colspan="3"> 
              <select name="MapDirId" size="1">
                <%
       		dbLookup.setSelectValue(quHotel.getFieldValue("Mapdirid"));
       		out.print(dbLookup.setLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78">��ͼ�ļ���</td>
            <td> 
              <input type="file" name="MapFileName">
              <input type="hidden" name="OldMapFileName" value="<%=quHotel.getFieldValue("MapFileName")%>">
            </td>
            <td colspan="2"><img src="<%=mapDir + quHotel.getFieldValue("MapFileName")%>" width="150" ></td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">Ҫ���Ƽ���</td>
            <td width="179"> <% 
              if (quHotel.getFieldValue("Status").equals("Y"))
              {
              %> 
              <input type="radio" name="Promotion" value="Y" checked>
              �� 
              <input type="radio" name="Promotion" value="N" >
              �� <%
              }
              else
              {
              %> 
              <input type="radio" name="Promotion" value="Y" >
              �� 
              <input type="radio" name="Promotion" value="N" checked>
              �� <%
              }
              %></td>
            <td width="63">�۸����ͣ�</td>
            <td width="174"> 
              <select name="PriceTypeId" size="1">
                <%
       		dbLookup.setSqlLookup(sqlProvide.getSql("Bst.PriceType"));
       		dbLookup.setDisplayField("DESCR");
       		dbLookup.setValueField("Code");
       		dbLookup.setSelectValue(quHotel.getFieldValue("Price_type_id"));
       		out.print(dbLookup.setLookUp());
       	      %> 
              </select>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">������ʩ��</td>
            <td colspan="3"> 
              <TEXTAREA cols=50 name=FacilityDrink><%=quHotel.getFieldValue("Facility_Drink")%></TEXTAREA>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">������ʩ��</td>
            <td colspan="3"> 
              <textarea cols=50 name=FacilityEnt><%=quHotel.getFieldValue("Facility_Ent")%></textarea>
            </td>
          </tr>
          <tr class="font9"> 
            <td width="78" class="font9">������ʩ��</td>
            <td colspan="3"> 
              <TEXTAREA cols=50 name=FacilityServ><%=quHotel.getFieldValue("Facility_serv")%></TEXTAREA>
            </td>
          </tr>
          <tr> 
            <td width="78" class="font9">��ϸ������</td>
            <td colspan="3"> 
              <textarea cols=50 name=FullDescr><%=quHotel.getFieldValue("FullDescr")%></textarea>
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
            <td height="40"> <A href="JavaScript:PostForm()"><IMG border=0 height=26 src="/images/botton_update.gif" width=68></A><IMG height=1 src="images/dot.gif" width=50> 
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

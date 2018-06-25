<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
<%!
    String highLevel = "5";
    String userLevel,eoaLoginID;
    // userLevel 1: normal user; 5: power user;
%>
<%
    eoaLoginID = (String)session.getValue("cneoa.UserId");
    userLevel = (String)session.getValue("cneoa.UserLevel");

    if(eoaLoginID == null)    // can not get the loginID from session
    {
%>
      <jsp:forward page="loginIdError.jsp" />
<%
    }
    else
    {
      if(!(highLevel.equals(userLevel)))      // the user is not a power user
      {
%>
      <jsp:forward page="permError.jsp" />
<%        
      }
    }

%>


<html><!-- #BeginTemplate "/Templates/ceoa.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ChinaEOA.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
<script
language="JavaScript">
<!--
img1on = new Image();
img1on.src = "/images/temp/menu_1_0.gif";
img2on = new Image();
img2on.src = "/images/temp/menu_2_0.gif";
img3on = new Image();
img3on.src = "/images/temp/menu_3_0.gif";
img4on = new Image();
img4on.src = "/images/temp/menu_4_0.gif";
img5on = new Image();
img5on.src = "/images/temp/menu_5_0.gif";
img6on = new Image();
img6on.src = "/images/temp/menu_6_0.gif";
img7on = new Image();
img7on.src = "/images/temp/menu_r07_c1_f2.gif";
img8on = new Image();
img8on.src = "/images/temp/menu_r08_c1_f2.gif";
img9on = new Image();
img9on.src = "/images/temp/menu_r09_c1_f2.gif";
img0on = new Image();
img0on.src = "/images/temp/menu_r10_c1_f2.gif";
img1off = new Image();
img1off .src = "/images/temp/menu_1.gif";
img2off = new Image();
img2off .src = "/images/temp/menu_2.gif";
img3off = new Image();
img3off .src = "/images/temp/menu_3.gif";
img4off = new Image();
img4off .src = "/images/temp/menu_4.gif";
img5off = new Image();
img5off .src = "/images/temp/menu_5.gif";
img6off = new Image();
img6off .src = "/images/temp/menu_6.gif";
img7off = new Image();
img7off .src = "/images/temp/menu_7.gif";
img8off = new Image();
img8off .src = "/images/temp/menu_r08_c1.gif";
img9off = new Image();
img9off .src = "/images/temp/menu_r09_c1.gif";
img0off = new Image();
img0off .src = "/images/temp/menu_r10_c1.gif";
function imgOn (imgName) {
if (document.images) {
document[imgName].src = eval (imgName + "on.src");
}
}
function imgOff (imgName) {
if (document.images) {
document[imgName].src = eval(imgName + "off.src");
}
}
function MM_preloadImages() { //v3.0
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

 function validateForm(formName)
 {
    if(formName.country.value=="0")
		{
			alert("��ѡ���ջ������ڵĹ��ң�Ȼ���ύ!");
			formName.country.focus();
      return false;
    }
		if(formName.province.value=="0")
    {
			alert("��ѡ���ջ������ڵ�ʡ�ݣ�Ȼ���ύ!");
      formName.province.focus();
      return false;
    }
		if(formName.city.value=="0")
    {
			alert("��ѡ���ջ������ڵĳ��У�Ȼ���ύ!");
			formName.city.focus();
      return false;
    }
    if(formName.shipName.value=="")
		{
			alert("�������ջ������ƣ�Ȼ���ύ!");
			formName.shipName.focus();
			return false;
		}
    if(formName.address.value=="")
    {
      alert("�������ջ�����ַ,Ȼ���ύ!");
      formName.address.focus();
      return false;
    }
    if(formName.zipCode.value.length!=6)
    {
      alert("����ȷ������������,Ȼ���ύ!");
      formName.zipCode.focus();
      return false;
    }
    if(formName.contName.value=="")
    {
      alert("��������ϵ������,Ȼ���ύ!");
      formName.contName.focus();
      return false;
    }
    if(formName.telephone.value.length<7)
    {
      alert("��������ϵ�绰,Ȼ���ύ!");
      formName.telephone.focus();
      return false;
    }
    if(formName.contEmail.value.indexOf("@")<1)
    {
      alert("Email��ַ����,����������!");
      formName.contEmail.focus();
      return false;
    }
 }

//-->
</script>
<%-- �����ݿ���ȡ������,ʡ��,���кͻ�Ա������Ϣ --%>

<%!
  String lang_code = "GB";
  Vector v_country = new Vector();
  Vector v_countryID = new Vector();
  Vector v_province = new Vector();
  Vector v_city = new Vector();

  ResultSet countryData,provinceData,cityData;
  String tempIdStr,tempSqlStr,tempProvinceStr,tempCityStr;
  String memberID;
  int i,j;
%>

<jsp:useBean id="areaInfo" scope="page" class="com.cig.chinaeoa.member.AreaInfo" />

<%
  try
  {
    if(!v_country.isEmpty())
      v_country.removeAllElements();
    if(!v_countryID.isEmpty())
      v_countryID.removeAllElements();
    if(!v_province.isEmpty())
      v_province.removeAllElements();
    if(!v_city.isEmpty())
      v_city.removeAllElements();

    memberID = (String)session.getValue("cneoa.MemberId");

    // ȡ��������Ϣ,ʡ����Ϣ��������Ϣ,���ڸ��Ե�������
    // Ȼ����JavaScript �н��ж�̬��ʾ
    areaInfo.setSqlStr("select countryID,name from country where Lang_code='"+lang_code+"' order by countryID");
    countryData = areaInfo.getDatas();

    i=0;
    while(countryData.next())
    {
      i++;
      v_country.addElement(countryData.getString("name"));

      tempIdStr = countryData.getString("countryID");
      v_countryID.addElement(tempIdStr);
      tempSqlStr = "select provinceID,name from province where lang_code='"+lang_code+"' and countryID='" +
        tempIdStr + "'" + " order by provinceID";
      areaInfo.setSqlStr(tempSqlStr);
      provinceData = areaInfo.getDatas();

      j=0;
      while(provinceData.next())
      {
        j++;
        tempIdStr = provinceData.getString("provinceID");
        v_province.addElement(""+i+"."+provinceData.getString("name")+"."+tempIdStr);

        tempSqlStr = "select cityID,name from city where lang_code='"+lang_code+"' and provinceID='" +
          tempIdStr + "'" + " order by cityID";
        areaInfo.setSqlStr(tempSqlStr);
        cityData = areaInfo.getDatas();

        while(cityData.next())
        {
          tempIdStr = cityData.getString("cityID");
          v_city.addElement(""+i+"."+j+"."+cityData.getString("name")+"."+tempIdStr);
        }
        areaInfo.disconn();   // free the connection from connection pool;

      } // for while(provinceData.next())
      areaInfo.disconn();

    }   // for while( countryData.next())
    areaInfo.disconn();


    tempProvinceStr = "\""+v_province.elementAt(0)+"\""+",";
    tempCityStr = "\""+v_city.elementAt(0)+"\""+",";
    for(i=1;i<v_province.size()-1;i++)
    {
      tempProvinceStr += "\""+v_province.elementAt(i)+"\""+",";
    }
    tempProvinceStr += "\""+v_province.elementAt(v_province.size()-1)+"\"";

    for(i=1;i<v_city.size()-1;i++)
    {
      tempCityStr += "\""+v_city.elementAt(i)+"\""+",";
    }
    tempCityStr += "\""+v_city.elementAt(v_city.size()-1)+"\"";
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
%>

<SCRIPT language="JavaScript"><!--
  provinceArray = new Array(<%=tempProvinceStr%>);
  cityArray = new Array(<%=tempCityStr%>);
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
      if((document.newShip.provinceSelect.value==null)||(document.newShip.provinceSelect.value==""))
        provinceBox.selectedIndex = 1;
      else
        provinceBox.selectedIndex = document.newShip.provinceSelect.value;
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
      if((document.newShip.citySelect.value==null)||(document.newShip.citySelect.value==""))
        cityBox.selectedIndex = 1;
      else
        cityBox.selectedIndex = document.newShip.citySelect.value;
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
    document.newShip.provinceSelect.value = document.newShip.province.selectedIndex;
  }

  // ������е�ѡ��ֵ
  function saveCity()
  {
    document.newShip.citySelect.value = document.newShip.city.selectedIndex;
  }

  function initArea()
  {
    changeProvinceInfo(document.newShip.country,document.newShip.province,document.newShip.city);
    changeCityInfo(document.newShip.country,document.newShip.province,document.newShip.city);
  }
//-->
</SCRIPT>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif" onLoad="initArea()">

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr>
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/title.js">
</script>
<table width="640" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" colspan="2"><!-- #BeginEditable "body" -->
      <table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td width="40"><img src="/images/spacer.gif" width="40" height="1"></td>
          <td>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr>
                <td height="30"><img src="/images/temp/path.gif" width="49" height="13"> 
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">��ҳ</a> 
                  <img src="/images/arrow.gif" width="7" height="11"> <font title="�����ʲô�ö�����"> 
                  <a href="MyEoa.jsp">MyEoa</a> <img src="/images/arrow.gif" width="7" height="11"> 
                  <font title="�����ʲô�ö�����"> �������͵�</font></font></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF"> 
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center">�������͵�</td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
              </tr>
              <tr bgcolor="#000066"> 
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">

              <form name="newShip" method="post" action="addShipResult.jsp" onSubmit="return validateForm(newShip)">
                <tr bgcolor="#F4FCFF"> 
                  <td height="30" colspan="2" align="center">�С�<font color="#CC0000">*</font>�� 
                    �ŵ���ĿΪ������ </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="137">��&nbsp;&nbsp;&nbsp;&nbsp;�ң�</td>
                  <td bgcolor="#DFEEFF" width="351"> 
                    <select name="country" onChange="changeProvinceInfo(newShip.country,newShip.province,newShip.city)">
                      <option value="0" >--��ѡ��--</option>

           <%  for(i=0;i<v_country.size();i++) { %>
                <option value="<%=v_countryID.elementAt(i)%>"><%=v_country.elementAt(i)%></option>
           <%  }   %>

                   </select>

                    <font color="#CC0000">*</font></td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF" width="137">ʡ&nbsp;&nbsp;&nbsp;&nbsp;�ݣ�</td>
                  <td bgcolor="#F4FCFF" width="351"> 
                    <select  name="province" onChange="changeCityInfo(newShip.country,newShip.province,newShip.city)" onBlur="saveProvince()">
                        <option value="0" >--��ѡ��--</option>
                        <option value=""></option>
                        <option value=""></option>
                        <option value=""></option>
                        <option value=""></option>
                        <option value=""></option>

                      </select>

                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr bgcolor="#DFEEFF">
                  <td align="right" bgcolor="#DFEEFF" width="137">��&nbsp;&nbsp;&nbsp;&nbsp;�У�</td>
                  <td bgcolor="#DFEEFF" width="351"> 
                    <select name="city" onBlur="saveCity()">
                      <option value="0" >--��ѡ��--</option>
                      <option value=""></option>
                      <option value=""></option>
                      <option value=""></option>
                      <option value=""></option>
                      <option value=""></option>
                    </select>

                    <input type="hidden" name="provinceSelect">
                    <input type="hidden" name="citySelect" >

                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#F4FCFF" width="137">�ջ������ƣ�</td>
                  <td bgcolor="#F4FCFF" width="351"> 
                    <input type="text" name="shipName" size="35" class="font1">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr bgcolor="#DFEEFF">
                  <td align="right" bgcolor="#DFEEFF" width="137">�ջ�����ַ��</td>
                  <td bgcolor="#DFEEFF" width="351"> 
                    <input type="text" name="address" size="35" class="font1">
                    <font color="#CC0000">*</font> </td>
                </tr>

                <tr bgcolor="#DFEEFF">
                  <td align="right" bgcolor="#F4FCFF" width="137">��&nbsp;&nbsp;&nbsp;&nbsp;�ࣺ</td>
                  <td bgcolor="#F4FCFF" width="351"> 
                    <input type="text" name="zipCode" size="20" class="font1">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr bgcolor="#DFEEFF">
                  <td align="right" bgcolor="#DFEEFF" width="137">�� ϵ �ˣ�</td>
                  <td bgcolor="#DFEEFF" width="351"> 
                    <input type="text" name="contName" size="20" class="font1">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr bgcolor="#F4FCFF">
                  <td align="right" bgcolor="#F4FCFF" width="137">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
                  <td bgcolor="#F4FCFF" width="351"> 
                    <input type="text" name="telephone" size="20" class="font1">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr bgcolor="#DFEEFF">
                  <td align="right" bgcolor="#DFEEFF" width="137">��&nbsp;&nbsp;&nbsp;&nbsp;�棺</td>
                  <td bgcolor="#DFEEFF" width="351"> 
                    <input type="text" name="fax" size="20" class="font1">
                  </td>
                </tr>
                <tr bgcolor="#F4FCFF">
                  <td align="right" bgcolor="#F4FCFF" width="137">E-mail��</td>
                  <td bgcolor="#F4FCFF" width="351"> 
                    <input type="text" name="contEmail" size="35" class="font1">
                    <font color="#CC0000">*</font> </td>
                </tr>
                <tr>
                  <td colspan="2" align="center" bgcolor="#DFEEFF">
                    <input type="image" src="/images/temp/b_add.gif" name="cancel2" value="ȡ   ��" class="font1" width="80" height="17">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="addShip.jsp" target="_self"><img src="/images/temp/reset.gif" name="cancel" value="ȡ   ��" class="font1" width="80" height="17" border="0" ></a> 
                    <input type="hidden" name="memberID" value="<%=memberID%>">

                  </td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td colspan="2">&nbsp;</td>
                </tr>
                <tr bgcolor="#000066"> 
                  <td colspan="2" height="1"><img src="/images/spacer.gif" width="1" height="1"></td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>
</body>
<!-- #EndTemplate --></html>


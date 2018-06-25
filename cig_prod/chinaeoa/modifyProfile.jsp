<%@ page import="java.util.*,java.sql.*" session="true" language="java" errorPage="error.jsp"%>
<%!
    String highLevel = "5";
    String userType,userLevel,eoaLoginID;
    // userType 1:EOA; 2:individual; 3:company; 4:dealer; 5:supplier; 6:supplier&dealer;
    // userLevel 1: normal user; 5: powerUser;
%>
<%
    eoaLoginID = (String)session.getValue("cneoa.UserId");
    userLevel = (String)session.getValue("cneoa.UserLevel");
    userType = (String)session.getValue("cneoa.MemberType");
%>
<%
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
//-->
</script>

<SCRIPT LANGUAGE="JavaScript"><!--
  // This function is used to check the validity of
  // the datas input from the form.
  // @param : formName which indicates the name of the input form
  function validateForm(formName)
  {
    if(formName.country.value=="0")
		{
			alert("请选择您所在的国家，然后提交!");
			formName.country.focus();
      return false;
    }
		if(formName.province.value=="0")
    {
			alert("请选择您所在的省份，然后提交!");
      formName.province.focus();
      return false;
    }
		if(formName.city.value=="0")
    {
			alert("请选择您所在的城市，然后提交!");
			formName.city.focus();
      return false;
    }

    if(formName.compName.value=="")
		{
			alert("请输入公司名称，然后提交!");
			formName.compName.focus();
			return false;
		}
    if(formName.compAddr.value=="")
    {
      alert("请输入联系地址,然后提交!");
      formName.compAddr.focus();
      return false;
    }
    if(formName.zipCode.value.length!=6)
    {
      alert("请正确输入邮政编码,然后提交!");
      formName.zipCode.focus();
      return false;
    }
    if(formName.telephone.value.length<7)
    {
      alert("请输入联系电话,然后提交!");
      formName.telephone.focus();
      return false;
    }

    if(formName.lawRep.value=="")
    {
      alert("请输入法人代表,然后提交!");
      formName.lawRep.focus();
      return false;
    }

    if(formName.bankAccount.value=="")
    {
      alert("请输入公司帐号,然后提交!");
      formName.bankAccount.focus();
      return false;
    }
    if(formName.bank.value=="")
    {
      alert("请输入开户银行,然后提交!");
      formName.bank.focus();
      return false;
    }
    if(formName.taxAccount.value=="")
    {
      alert("请输入公司税号,然后提交!");
      formName.taxAccount.focus();
      return false;
    }
    if(formName.contName.value=="")
    {
      alert("请输入联系人姓名,然后提交!");
      formName.contName.focus();
      return false;
    }
    if(formName.contEmail.value.indexOf("@")<1)
    {
      alert("Email地址有误,请重新输入!");
      formName.contEmail.focus();
      return false;
    }
    if(formName.question.value=="")
    {
      alert("请输入密码提示!");
      formName.question.focus();
      return false;
    }
    if(formName.answer.value=="")
    {
      alert("请输入您的答案,然后提交!");
      formName.answer.focus();
      return false;
    }
  }

//-->
</SCRIPT>

<%-- 从数据库中取出国家,省份,城市和会员类别的信息 --%>
<%!
  String lang_code = "GB";
  Vector v_country = new Vector();
  Vector v_countryID = new Vector();
  Vector v_provinceID = new Vector();
  Vector v_provinceName = new Vector();
  Vector v_province = new Vector();
  Vector v_cityID = new Vector();
  Vector v_cityName = new Vector();
  Vector v_city = new Vector();
  Vector v_compTypeID = new Vector();
  Vector v_compType = new Vector();

  ResultSet countryData,provinceData,cityData,memberTypeData,compTypeInfo;
  String tempIdStr,tempSqlStr,tempProvinceStr,tempCityStr;
  int i,j;

%>
<jsp:useBean id="modifyProf" scope="page" class="com.cig.chinaeoa.member.ModifyProfile"/>
<jsp:useBean id="areaInfo" scope="page" class="com.cig.chinaeoa.member.AreaInfo" />

<%
  try
  {
    if(!v_country.isEmpty())
      v_country.removeAllElements();
    if(!v_countryID.isEmpty())
      v_countryID.removeAllElements();
    if(!v_provinceID.isEmpty())
      v_provinceID.removeAllElements();
    if(!v_provinceName.isEmpty())
      v_provinceName.removeAllElements();
    if(!v_province.isEmpty())
      v_province.removeAllElements();
    if(!v_cityID.isEmpty())
      v_cityID.removeAllElements();
    if(!v_cityName.isEmpty())
      v_cityName.removeAllElements();
    if(!v_compTypeID.isEmpty())
      v_compTypeID.removeAllElements();
    if(!v_compType.isEmpty())
      v_compType.removeAllElements();

    // 取出公司类别信息
    tempSqlStr = "select code,str_value from parameter where ID='1' and lang_code = '" +
      lang_code + "'";
    areaInfo.setSqlStr(tempSqlStr);
    compTypeInfo = areaInfo.getDatas();
    while(compTypeInfo.next())
    {
      v_compTypeID.addElement(compTypeInfo.getString("code"));
      v_compType.addElement(compTypeInfo.getString("str_value"));
    }
    areaInfo.disconn();

    // 取出国家信息,省份信息，城市信息,存于个自的向量中
    // 然后在JavaScript 中进行动态显示
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
<%!
  ResultSet detailInfo;
  String loginID;
  String memberID,memberTypeID,memberType,countryID,provinceID,cityID,country,province,city;
  String zipCode,telephone,fax;
  String bankAccount,taxAccount,bank;
  String contName,contSex,contDept,contTitle,contEmail;
  String question,answer;
  String compName,address,lawRep,compSize,compType;
%>

<%
  try
  {
    loginID = (String)session.getValue("cneoa.UserId");

    modifyProf.setUserID(loginID);
    memberID = modifyProf.getMemberID();
    detailInfo = modifyProf.getDatas();
    if (detailInfo!=null){
      if(detailInfo.next())
      {
        memberTypeID = detailInfo.getString("memberTypeID");
        memberType = detailInfo.getString("memberType");
        countryID = detailInfo.getString("countryID");
        country = detailInfo.getString("country");
        provinceID = detailInfo.getString("provinceID");
        province = detailInfo.getString("province");
        cityID = detailInfo.getString("cityID");
        city = detailInfo.getString("city");
        zipCode = detailInfo.getString("zipCode");
        telephone = detailInfo.getString("tel");
        fax = detailInfo.getString("fax");
        if(fax==null)
          fax = "";
        bankAccount = detailInfo.getString("account");
        taxAccount = detailInfo.getString("taxAccount");
        bank = detailInfo.getString("bank");
        contName = detailInfo.getString("contName_F");
        contDept = detailInfo.getString("contDept");
        if(contDept== null)
          contDept = "";
        contTitle = detailInfo.getString("contTitle");
        if(contTitle == null)
          contTitle = "";
        contEmail = detailInfo.getString("contEmail");
        question = detailInfo.getString("question");
        answer = detailInfo.getString("answer");
        contSex = detailInfo.getString("contSex");
        compName = detailInfo.getString("compName");
        address = detailInfo.getString("address1");
        lawRep = detailInfo.getString("lawRep_F");
        compSize = detailInfo.getString("compSize");
        compType = detailInfo.getString("compType");
      }
      modifyProf.disconn();
    }


  }
  catch(Exception e)
  {
    out.println("");
  }

  try
  {
    tempSqlStr = "select provinceID,name from province where lang_code='"+lang_code+"' and countryID='" +
      countryID + "'" + " order by provinceID";
    areaInfo.setSqlStr(tempSqlStr);
    provinceData = areaInfo.getDatas();
    while(provinceData.next())
    {
      v_provinceID.addElement(provinceData.getString("provinceID"));
      v_provinceName.addElement(provinceData.getString("name"));
    }
    areaInfo.disconn();

    tempSqlStr = "select cityID,name from city where lang_code='"+lang_code+"' and provinceID='" +
      provinceID + "'" + " order by cityID";
    areaInfo.setSqlStr(tempSqlStr);
    cityData = areaInfo.getDatas();
    while(cityData.next())
    {
      v_cityID.addElement(cityData.getString("cityID"));
      v_cityName.addElement(cityData.getString("name"));
    }
    areaInfo.disconn();

  }
  catch(Exception e)
  {
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
      if((document.memberInfo.provinceSelect.value==null)||(document.memberInfo.provinceSelect.value==""))
        provinceBox.selectedIndex = 1;
      else
        provinceBox.selectedIndex = document.memberInfo.provinceSelect.value;
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
      if((document.memberInfo.citySelect.value==null)||(document.memberInfo.citySelect.value==""))
        cityBox.selectedIndex = 1;
      else
        cityBox.selectedIndex = document.memberInfo.citySelect.value;
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
    document.memberInfo.provinceSelect.value = document.memberInfo.province.selectedIndex;
  }

  // 保存城市的选择值
  function saveCity()
  {
    document.memberInfo.citySelect.value = document.memberInfo.city.selectedIndex;
  }


  function initUserInfo()
  {
    for(i=0;i<document.memberInfo.compSize.length;i++)
    {
      if(document.memberInfo.compSize.options[i].value == <%=compSize%>)
      {
        document.memberInfo.compSize.options[i].selected = true;
        break;
      }
    }

    if("<%=contSex%>"=="F")
      document.memberInfo.contSex[0].checked=true;
    else
      document.memberInfo.contSex[1].checked=true;

    if((document.memberInfo.provinceSelect.value==null)||(document.memberInfo.provinceSelect.value==""))
      document.memberInfo.provinceSelect.value = document.memberInfo.province.selectedIndex;
    if((document.memberInfo.citySelect.value==null)||(document.memberInfo.citySelect.value==""))
      document.memberInfo.citySelect.value = document.memberInfo.city.selectedIndex;

    changeProvinceInfo(document.memberInfo.country,document.memberInfo.province,document.memberInfo.city);
    changeCityInfo(document.memberInfo.country,document.memberInfo.province,document.memberInfo.city);
  }
//-->
</SCRIPT>


</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif" onLoad="initUserInfo()">
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
      <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td height="30"><img src="/images/temp/path.gif" width="49" height="13"> 
            <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">首页</a> 
            <img src="/images/arrow.gif" width="7" height="11"> <font title="里边有什么好东西呢"> 
            <a href="MyEoa.jsp">MyEoa</a> <img src="/images/arrow.gif" width="7" height="11"> 
            <font title="里边有什么好东西呢"> 修改用户信息</font></font></td>
        </tr>
      </table>
      <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr bgcolor="#99CCFF"> 
          <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
          <td height="25" class="font4b" align="center">修改用户信息</td>
          <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
        </tr>
        <tr bgcolor="#000066"> 
          <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
      <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">
        <form name="memberInfo" method="post" action="modifyProfResult.jsp" onSubmit="return validateForm(memberInfo)">
          <tr bgcolor="#F4FCFF"> 
            <td height="26" colspan="2" align="center">有“<font color="#CC0000">*</font>” 
              号的栏目为必添项 </td>
          </tr>
          <tr bgcolor="#DFEEFF"> 
            <td align="right">用户类别：</td>
            <td bgcolor="#DFEEFF"><%=memberType%> 

             </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">国&nbsp;&nbsp;&nbsp;&nbsp;家：</td>
            <td bgcolor="#F4FCFF">
              <select name="country" onChange="changeProvinceInfo(memberInfo.country,memberInfo.province,memberInfo.city)">
                <option value="0" >--请选择--</option>

                           <%  for(i=0;i<v_country.size();i++) {
                                 if((v_countryID.elementAt(i)).equals(countryID))
                                 {
                           %>
                             <option value="<%=v_countryID.elementAt(i)%>" selected><%=v_country.elementAt(i)%></option>
                           <%
                                 }
                                 else
                                 {
                           %>
                              <option value="<%=v_countryID.elementAt(i)%>"><%=v_country.elementAt(i)%></option>
                          <%
                                 }
                              }
                          %>

              </select>
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">省&nbsp;&nbsp;&nbsp;&nbsp;份：</td>
            <td bgcolor="#DFEEFF">
              <select name="province"  onChange="changeCityInfo(memberInfo.country,memberInfo.province,memberInfo.city)" onBlur="saveProvince()">
                <option value="0" >--请选择--</option>

                           <%  for(i=0;i<v_provinceID.size();i++) {
                                 if((v_provinceID.elementAt(i)).equals(provinceID))
                                 {
                           %>
                             <option value="<%=v_provinceID.elementAt(i)%>" selected><%=v_provinceName.elementAt(i)%></option>
                           <%
                                 }
                                 else
                                 {
                           %>
                              <option value="<%=v_provinceID.elementAt(i)%>"><%=v_provinceName.elementAt(i)%></option>
                          <%
                                 }
                              }
                          %>
              </select>
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">所在城市：</td>
            <td bgcolor="#F4FCFF">
              <select name="city" onBlur="saveCity()">
                <option value="0" >--请选择--</option>
                           <%  for(i=0;i<v_cityID.size();i++) {
                                 if((v_cityID.elementAt(i)).equals(cityID))
                                 {
                           %>
                             <option value="<%=v_cityID.elementAt(i)%>" selected><%=v_cityName.elementAt(i)%></option>
                           <%
                                 }
                                 else
                                 {
                           %>
                              <option value="<%=v_cityID.elementAt(i)%>"><%=v_cityName.elementAt(i)%></option>
                          <%
                                 }
                              }
                          %>
              </select>

              <input type="hidden" name="provinceSelect" >
              <input type="hidden" name="citySelect">

              <font color="#CC0000">*</font></td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">公司名称：</td>
            <td bgcolor="#DFEEFF"> 
              <input type="text" name="compName" size="35" value="<%=compName%>" class="font1">
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">联系地址：</td>
            <td bgcolor="#F4FCFF">
              <input type="text" name="compAddr" value="<%=address%>" size="35" class="font1">
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">邮政编码：</td>
            <td bgcolor="#DFEEFF">
              <input type="text" name="zipCode" value="<%=zipCode%>" size="15" class="font1">
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">联系电话：</td>
            <td bgcolor="#F4FCFF">
              <input type="text" name="telephone" value="<%=telephone%>" size="15" class="font1">
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr bgcolor="#DFEEFF"> 
            <td align="right" bgcolor="#DFEEFF">传&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
            <td> 
              <input type="text" name="fax" value="<%=fax%>" size="15" class="font1" bgcolor="#DFEEFF">
            </td>
          </tr>
          <tr> 
            <td align="right" bgcolor="#F4FCFF">公司规模：</td>
            <td bgcolor="#F4FCFF"> 
                <select name="compSize" size="1" >
                            <option value="1">1-20人 </option>
                            <option value="2">21-40人 </option>
                            <option value="3">41-60人 </option>
                            <option value="4">61-100人 </option>
                            <option value="5">100人以上 </option>
                 </select>
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr bgcolor="#DFEEFF"> 
            <td align="right" bgcolor="#DFEEFF">法人代表：</td>
            <td><font color="#CC0000" bgcolor="#DFEEFF"> 
              <input type="text" name="lawRep" value="<%=lawRep%>" size="15" class="font1">
              *</font> </td>
          </tr>
          <tr> 
            <td align="right" bgcolor="#F4FCFF">行业类别：</td>
            <td bgcolor="#F4FCFF">
                <select name="compType" >

               <%
                    for(i=0;i<v_compTypeID.size();i++)
                    {
                      if(v_compTypeID.elementAt(i).equals(compType))
                      {
                %>
                    <option value="<%=v_compTypeID.elementAt(i)%>" selected><%=v_compType.elementAt(i)%></option>
                <%
                      }
                      else
                      {
                %>
                    <option value="<%=v_compTypeID.elementAt(i)%>" ><%=v_compType.elementAt(i)%></option>
                <%
                      }
                    }
                %>
                </select>
            </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">公司帐号：</td>
            <td><font color="#CC0000" bgcolor="#DFEEFF">
              <input type="text" name="bankAccount" value="<%=bankAccount%>" size="15" class="font1">
              *</font></td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">开户银行：</td>
            <td bgcolor="#F4FCFF"><font color="#CC0000" bgcolor="#F4FCFF">
              <input type="text" name="bank" value="<%=bank%>" size="15" class="font1">
              *</font> </td>
          </tr>
          <tr bgcolor="#DFEEFF"> 
            <td align="right" bgcolor="#DFEEFF">公司税号：</td>
            <td><font color="#CC0000" bgcolor="#DFEEFF"> 
              <input type="text" name="taxAccount" value="<%=taxAccount%>" size="15" class="font1">
              *</font> </td>
          </tr>
          <tr> 
            <td align="right" bgcolor="#F4FCFF">&nbsp;</td>
            <td bgcolor="#F4FCFF">&nbsp;</td>
          </tr>
          <tr bgcolor="#DFEEFF"> 
            <td align="right" bgcolor="#DFEEFF">联 系 人：</td>
            <td bgcolor="#DFEEFF"> 
              <input type="text" name="contName" value="<%=contName%>" size="15" class="font1">
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr> 
            <td align="right" bgcolor="#F4FCFF">称&nbsp;&nbsp;&nbsp;&nbsp;谓：</td>
            <td bgcolor="#F4FCFF"> 
              <input type="radio" name="contSex" value="F" >
              女士
              <input type="radio" name="contSex" value="M" checked>
              先生 </td>
          </tr>
          <tr bgcolor="#DFEEFF"> 
            <td align="right" bgcolor="#DFEEFF">工作部门：</td>
            <td> 
              <input type="text" name="contDept" value="<%=contDept%>" size="15" class="font1" bgcolor="#DFEEFF">
            </td>
          </tr>
          <tr>
            <td align="right" bgcolor="#F4FCFF">职&nbsp;&nbsp;&nbsp;&nbsp;务：</td>
            <td bgcolor="#F4FCFF">
              <input type="text" name="contTitle" value="<%=contTitle%>" size="15" class="font1" bgcolor="#F4FCFF">
            </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right">E-mail : </td>
            <td bgcolor="#DFEEFF">
              <input type="text" name="contEmail" value="<%=contEmail%>" size="25" class="font1">
              <font color="#CC0000">*</font></td>
          </tr>
          <tr bgcolor="#F4FCFF"> 
            <td colspan="2">&nbsp;</td>
          </tr>

          <tr>
            <td align="right" bgcolor="#F4FCFF">密码提示：</td>
            <td bgcolor="#DFEEFF"> 
              <input type="text" name="question" value="<%=question%>" size="25" class="font1">
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr bgcolor="#DFEEFF">
            <td align="right" bgcolor="#DFEEFF">答&nbsp;&nbsp;&nbsp;&nbsp;案： </td>
            <td bgcolor="#F4FCFF"> 
              <input type="text" name="answer" value="<%=answer%>" size="25" class="font1">

              <input type="hidden" name="memberID" value="<%=memberID%>">
              <font color="#CC0000">*</font> </td>
          </tr>

          <tr bgcolor="#DFEEFF">
          </tr>
          <tr bgcolor="#DFEEFF"> 
            <td colspan="2"><font color="#660066" bgcolor="#F4FCFF">现在您已准备修改您的用户信息。要修改您的用户信息，单击“修改”按钮。 
              要取消更改，单击下面的“取消”按钮。</font></td>
          </tr>
          <tr bgcolor="#F4FCFF"> 
            <td colspan="2" align="center"> 
              <div align="center"> 
                <input type="image" src="/images/temp/b_modify.gif" name="cancel2" value="修   改" class="font1" width="80" height="17">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="modifyProfile.jsp" target="_self"><img src="/images/temp/reset.gif" name="cancel" value="取   消" class="font1" border="0" ></a> 
              </div>
            </td>
          </tr>
          <tr bgcolor="#DFEEFF"> 
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr bgcolor="#000066"> 
            <td colspan="2" height="1"><img src="/images/spacer.gif" width="1" height="1"></td>
          </tr>
        </form>
      </table>
      <p>&nbsp;</p>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>

</body>
<!-- #EndTemplate --></html>

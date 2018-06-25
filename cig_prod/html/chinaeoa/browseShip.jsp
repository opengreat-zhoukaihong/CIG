<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
<%!
    String highLevel = "5";
    String userLevel,eoaLoginID;
    // userLevel 0: normal user; 5: power user;
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
//-->
</script>

<%!
  String lang_code = "GB";

  ResultSet shipInfo;
  String tempSqlStr;
  String shipID,memberID,country,province,city,shipName,address,zipCode;
  String contName,telephone,fax,contEmail;
  int i,j;
%>

<jsp:useBean id="shipManager" scope="page" class="com.cig.chinaeoa.member.ShipManager" />

<%
  try
  {
    shipID = request.getParameter("shipID");

    tempSqlStr = "select s.zipCode,s.tel,s.fax,s.email,sl.shipName,sl.contName_F," +
      " sl.address1,cr.name as country,p.name as province,ct.name as city " +
      " from shipment s,shipment_l sl,country cr,province p,city ct " +
      " where s.shipID = '" + shipID + "' and  sl.lang_code='" + lang_code +
      "' and cr.lang_code='" + lang_code + "' and p.lang_code = '" + lang_code +
      "' and ct.lang_code = '" + lang_code + "' and s.shipID = sl.shipID and " +
      " s.countryID = cr.countryID and s.provinceID = p.provinceID and  " +
      " s.cityID = ct.cityID";

    shipManager.setSqlStr(tempSqlStr);

    shipInfo = shipManager.getDetail();

    if(shipInfo != null)
    {
      if(shipInfo.next())
      {
        country = shipInfo.getString("country");
        province = shipInfo.getString("province");
        city = shipInfo.getString("city");
        telephone = shipInfo.getString("tel");
        fax = shipInfo.getString("fax");
        if(fax == null)
          fax = "";
        zipCode = shipInfo.getString("zipCode");
        contEmail = shipInfo.getString("email");
        address = shipInfo.getString("address1");
        contName = shipInfo.getString("contName_F");
        shipName = shipInfo.getString("shipName");

      }
      shipManager.disconn();
    }
   }
   catch(Exception e)
   {
      e.printStackTrace();
   }
%>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif" >

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
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">首页</a> 
                  <img src="/images/arrow.gif" width="7" height="11"> <font title="里边有什么好东西呢"> 
                  <a href="MyEoa.jsp">MyEoa</a> <img src="/images/arrow.gif" width="7" height="11"> 
                  <font title="里边有什么好东西呢"> 修改运送地</font></font></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF"> 
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center">修改运送地</td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
              </tr>
              <tr bgcolor="#000066"> 
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">
              <form name="modifyShip" method="post" action="modifyShipResult.jsp" onSubmit="return validateForm(modifyShip)">
                <tr bgcolor="#F4FCFF"> 
                  <td height="17" colspan="2" align="center">&nbsp; </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="161">国&nbsp;&nbsp;&nbsp;&nbsp;家：</td>
                  <td bgcolor="#DFEEFF" width="327"><%=country%> </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF" width="161">省&nbsp;&nbsp;&nbsp;&nbsp;份：</td>
                  <td bgcolor="#F4FCFF" width="327"> <%=province%> </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="161">城&nbsp;&nbsp;&nbsp;&nbsp;市：</td>
                  <td bgcolor="#DFEEFF" width="327"><%=city%> </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF" width="161">收货方名称：</td>
                  <td bgcolor="#F4FCFF" width="327"><%=shipName%> </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="161">收货方地址：</td>
                  <td bgcolor="#DFEEFF" width="327"><%=address%> </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#F4FCFF" width="161">邮&nbsp;&nbsp;&nbsp;&nbsp;编：</td>
                  <td bgcolor="#F4FCFF" width="327"><%=zipCode%> </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="161">联 系 人：</td>
                  <td bgcolor="#DFEEFF" width="327"><%=contName%> </td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td align="right" bgcolor="#F4FCFF" width="161">电&nbsp;&nbsp;&nbsp;&nbsp;话：</td>
                  <td bgcolor="#F4FCFF" width="327"><%=telephone%> </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="161">传&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
                  <td bgcolor="#DFEEFF" width="327"><%=fax%> </td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td align="right" bgcolor="#F4FCFF" width="161">E-mail：</td>
                  <td bgcolor="#F4FCFF" width="327"><%=contEmail%> </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td colspan="2" align="center">&nbsp;</td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td colspan="2" align="center"> 
                    <p class="font3b"><a href="javascript:history.go(-1);">返回</a></p>
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


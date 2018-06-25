<%@ page import="java.util.*, java.sql.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
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

    if(eoaLoginID == null)    // can not get the loginID from session
    {
      //response.sendRedirect("loginIdError.jsp");
%>
      <jsp:forward page="loginIdError.jsp" />
<%
    }
    else
    {
      if(!(highLevel.equals(userLevel)))      // the user is not a power user
      {
        //response.sendRedirect("permError.jsp");
%>
       <jsp:forward page="permError.jsp" />
<%
      }
      else
      {
        if((!"5".equals(userType))&&(!"1".equals(userType)))             // only accessible for supplier
        {
%>
        <jsp:forward page="permError.jsp" />
<%        
        }
      }
    }

%>


<html>
<!-- #BeginTemplate "/Templates/ceoa.dwt" --> 
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

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">


<jsp:useBean id="deliveryManager" scope="page" class="com.cig.chinaeoa.member.DeliveryManager" />
<%!
    String memberID,countryID,provinceID,cityID,deliveryName,address,zipCode,contName;
    String supplierID,contTitle,note;
    String telephone,fax,contEmail;
    String tempSqlStr;
    int errorCode;
%>
<%
    memberID = request.getParameter("memberID");
    countryID = request.getParameter("country");
    provinceID = request.getParameter("province");
    cityID = request.getParameter("city");
    deliveryName = request.getParameter("deliveryName");
    address = request.getParameter("address");
    zipCode = request.getParameter("zipCode");
    contName = request.getParameter("contName");
    telephone = request.getParameter("telephone");
    fax = request.getParameter("fax");
    contEmail = request.getParameter("contEmail");
    contTitle = request.getParameter("contTitle");
    note = request.getParameter("note");

%>

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
      <table width="667" border="0" cellpadding="0" cellspacing="0" height="300">
        <tr align="center">
          <td class="font4b">

<%
          deliveryManager.setMemberID(memberID);
          supplierID = deliveryManager.getSupplierID();

          tempSqlStr = "insert into delivery (deliveryID,supplierID,countryID,provinceID, " +
            " cityID,zipCode,tel,fax,email,cr_date,md_date) " +
            " values (seq_deliveryID.NextVal,'" + supplierID + "','" + countryID +
            "','" + provinceID +"','" + cityID + "','" + zipCode + "','" + telephone +
            "','" + fax + "','" + contEmail + "',sysdate,sysdate )";

          deliveryManager.setSqlStr(tempSqlStr);

          tempSqlStr = "insert into delivery_L (deliveryID,lang_code,contact_F,name,address1," +
            " contTitle,note)" +
            " values (seq_deliveryID.CurrVal,'GB','" + contName + "','" + deliveryName + "','" +
            address + "','" + contTitle + "','" + note + "')";

          deliveryManager.setSqlStr2(tempSqlStr);

          deliveryManager.modifyDelivery();
          errorCode = deliveryManager.getErrorCode();

          if(errorCode == 0)
          {
%>
            <p>操作成功!</p>
            <p><a href="javascript:history.go(-1);">返回</a></p>

<%
          }
          else
          {
%>
            <p>操作失败!</p>
            <p><a href="javascript:history.go(-1);">返回</a></p>

<%
          }
%>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>
</body>

<UL>
<LI><%=deliveryManager.getSqlStr()%>
<LI><%=deliveryManager.getSqlStr2()%>
<LI><%=memberID%>
</UL>


<!-- #EndTemplate -->
</html>



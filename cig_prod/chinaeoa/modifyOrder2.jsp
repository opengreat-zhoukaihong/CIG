<%@ page import="java.sql.*,java.util.*,com.cig.chinaeoa.orderpro.*,java.io.*,sun.net.smtp.*" session="true" language="java" errorPage="error.jsp"%>
<%-- control the access to the page --%>
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
      else
      {
        if(!("5".equals(userType)))
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
<script><!--

//-->
</script>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<jsp:useBean id="orderProc" scope="page" class="com.cig.chinaeoa.orderpro.OrderProcessor" />

<%!
  String status,orderID;
  String userID;
  int pageNo,errorCode;
  String estimateDateOld,cashPaidOld;
  String estimateDate,cashPaid;
  String lang_code = "GB";
  String tempSqlStr;

%>
<%
  userID = (String)session.getValue("cneoa.UserId");

  orderID = request.getParameter("orderID");
  status = request.getParameter("status");
  cashPaidOld = request.getParameter("cashPaidOld");
  if((cashPaidOld == null)||(cashPaidOld.equals("")))
    cashPaidOld = "0";
  estimateDateOld = request.getParameter("estimateDateOld");
  if(estimateDateOld == null)
    estimateDateOld = "";

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
      <table width="600" border="0" cellspacing="0" cellpadding="0" height="300" align="center">
        <tr valign="top">
          <td>
            <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr>
                <td class="font4b" height="13">修改订单&nbsp;</td>
                <td class="font4b" height="13">&nbsp;</td>
                <td class="font4b" height="13">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3">
<%

  try
  {
    orderProc.setUserID(userID);
    orderProc.setOrderID(orderID);
    orderProc.setStatus(status);

    if(status.equals("2"))
    {
      estimateDate = request.getParameter("estimateDate");
      if(estimateDate == null)
        estimateDate = "";

      orderProc.setEstimateDate(estimateDate);
      orderProc.updateEstimateDate();
    }
    else if(status.equals("3")||status.equals("4")||status.equals("5")||status.equals("6")||status.equals("7"))
    {
      cashPaid = request.getParameter("cashPaid");
      if((cashPaid == null)||(cashPaid.equals("")))
        cashPaid = "0";
      if(!cashPaid.equals(cashPaidOld))
      {
        orderProc.setCashPaid(cashPaid);
        orderProc.setCashPaidOld(cashPaidOld);
        orderProc.updateCashPaid();
      }
      else
        errorCode = 0;
    }


      if(errorCode == 0)
      {
%>
        <p align="center" >修改成功!</p>
        <p align="center" ><a href="javascript:window.history.go(-2);" class="font3b">返回</a></p>
<%
      }
      else
      {
        out.println("失败!");
      }
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
%>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>

</body>
<!-- #EndTemplate -->
</html>

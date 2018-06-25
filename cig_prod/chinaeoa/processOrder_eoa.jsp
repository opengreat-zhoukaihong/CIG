<%@ page import="java.util.*,java.io.*,sun.net.smtp.*,com.cig.chinaeoa.orderpro.* " session="true" language="java" errorPage="error.jsp"%>
<%-- control the access to the page --%>
<%!
    String highLevel = "5";
    String userType,userLevel,eoaLoginID;
    // userType 1:EOA; 2:individual; 3:company; 4:dealer; 5:supplier; 6:supplier&dealer;
    // userLevel 0: normal user; 1: powerUser;    
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
        if(!("1".equals(userType)))
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

<jsp:useBean id="orderProc" scope="page" class="com.cig.chinaeoa.orderpro.OrderProcessor_eoa" />
<jsp:useBean id="checkMember" scope="page" class="com.cig.chinaeoa.member.MemberDetail" />

<%!
  String status,orderID;
  int pageNo;
  Vector orders = new Vector();
  Order myOrder;

  SmtpClient mailConfirm;
  PrintStream psMail;
  String sellerID,sellerName;
  String userInfo[] = new String[3];  //userInfo[0]:userID;userInfo[1]:password;
                                      //userInfo[2]:contact Email;

%>
<%
  try
  {
    status = request.getParameter("status");
    orderID = request.getParameter("orderID");

    orderProc.setStatus(status);
    orderProc.setOrderID(orderID);
    orderProc.setOrderDateBgn("2000-07-31");
    orderProc.setOrderDateEnd("2099-07-31");
    orderProc.setSellerName("");
    orderProc.setBuyerName("");

    pageNo = 1;
    orderProc.setPageNo(pageNo);

    orders = orderProc.getOrders();

    myOrder = (Order)orders.elementAt(0);

    sellerID = myOrder.getSellerID();
    sellerName = myOrder.getSellerName();

    checkMember.setMemberID(sellerID);
    userInfo = (String[])checkMember.getUserInfo();   // get contact email
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
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
                <td class="font4b" height="13">处理订单&nbsp;</td>
                <td class="font4b" height="13">&nbsp;</td>
                <td class="font4b" height="13">&nbsp;</td>
              </tr>
              <tr>
                <td >&nbsp; </td>
                <td align="right">&nbsp; </td>
              </tr>
              <tr>
                <td colspan="3" height="18">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3">
<%
  try
  {
    mailConfirm = new SmtpClient("cig.com.cn");
    mailConfirm.from("service@chinaeoa.com");
    mailConfirm.to("zwj@cig.com.cn");        //userInfo[2]

    psMail = mailConfirm.startMessage();

    psMail.println("Subject: 处理新订单.");
    psMail.println(sellerName + ":\n");
    psMail.println("给您的新订单（订单号："+orderID+"）已超过一天了，\n ");
    psMail.println("您应该尽快处理。\n");
    psMail.println("谢谢! \n");
    psMail.println("如有任何疑问或建议，请与我们联系. \n");
    psMail.println("ChinaEOA.com. \n");
    mailConfirm.closeServer();
    out.println("已经发 email 通知代理商了.");
  }
  catch(Exception e)
  {
    e.printStackTrace();
    out.println("Email 发送失败.");
  }
%>

                </td>
              </tr>
              <tr>
                <td colspan="3"> &nbsp;
                </td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
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

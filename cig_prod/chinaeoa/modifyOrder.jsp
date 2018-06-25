<%@ page import="java.util.*,com.cig.chinaeoa.orderpro.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
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
  function validateForm(status)
  {
    if(status == '2')
    {
      var checkDate = document.modifyOrder.estimateDate.value;
      var tempDate = checkDate;
      if(tempDate != "")
      {
        if((tempDate.charAt(4)!="-")||(tempDate.charAt(7)!="-"))
        {
          alert("输入的日期的格式有误,请按正确格式输入!");
          document.modifyOrder.estimateDate.focus();
          return false;
        }
        if(tempDate.length != 10)
        {
          alert("输入的日期的格式有误,请按正确格式输入!");
          document.modifyOrder.estimateDate.focus();
          return false;
        }
        tempDate = checkDate.substring(0,4);
        if(tempDate<'1980'||tempDate>'2099')
        {
          alert("输入的年份有误!")
          document.modifyOrder.estimateDate.focus();
          return false;
        }
        for(i=0;i<tempDate.length;i++)
        {
          if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
          {
            alert("请输入数字.");
            document.modifyOrder.estimateDate.focus();
            return false;
          }
        }
        tempDate = checkDate.substring(5,7);
        if(tempDate<'01'||tempDate>'12')
        {
          alert("输入的月份有误!")
          document.modifyOrder.estimateDate.focus();
          return false;
        }
        for(i=0;i<tempDate.length;i++)
        {
          if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
          {
            alert("请输入数字.");
            document.modifyOrder.estimateDate.focus();
            return false;
          }
        }
        tempDate = checkDate.substring(8,10);
        if(tempDate<'01'||tempDate>'31')
        {
          alert("输入的日期有误!")
          document.modifyOrder.estimateDate.focus();
          return false;
        }
        for(i=0;i<tempDate.length;i++)
        {
          if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
          {
            alert("请输入数字.");
            document.modifyOrder.estimateDate.focus();
            return false;
          }
        }
      }
    }

    if(status=='3'||status=='4'||status=='5'||status=='6'||status=='7')
    {
      if(document.modifyOrder.cashPaid.value != "")
      {
        var tempPaid = document.modifyOrder.cashPaid.value;
        for(i=0;i<tempPaid.length;i++)
        {
          if((tempPaid.charAt(i)<'0'||tempPaid.charAt(i)>'9')&&(tempPaid.charAt(i)!='.'))
          {
            alert("现付已收款输入有误!");
            document.modifyOrder.cashPaid.focus();
            return false;
          }
        }
        if(document.modifyOrder.cashDue.value < tempPaid)
        {
          alert("现付已收款不能大于现付应收款!");
          document.modifyOrder.cashPaid.focus();
          return false;
        }
      }
    }

    return true;
  }



//-->
</script>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<jsp:useBean id="orderSearch" scope="page" class="com.cig.chinaeoa.orderpro.OrderProcessor" />
<%!
  public String getPageNo(HttpServletRequest request,String pageNo)
  {
      if(request.getParameter(pageNo) == null)
        return "1";
      else
        return request.getParameter(pageNo);
  }
  String status,orderID,sellerID;
  String statusName,paymentMethod,paymentID;
  String searchOrderID,buyerName,orderDateBgn,orderDateEnd;
  int pageNo;
  Vector orders = new Vector();
  Order myOrder;
%>
<%
  sellerID = (String)session.getValue("cneoa.MemberId");

  status = request.getParameter("status");
  orderID = request.getParameter("orderID");

  searchOrderID = request.getParameter("searchOrderID");
  buyerName = request.getParameter("name");
  orderDateBgn = request.getParameter("orderDateBgn");
  orderDateEnd = request.getParameter("orderDateEnd");

  if(buyerName == null)
    buyerName = "";
  if(orderDateBgn == null||orderDateBgn.equals(""))
    orderDateBgn = "2000-07-31";
  if(orderDateEnd == null||orderDateEnd.equals(""))
    orderDateEnd = "2099-07-31";

  orderSearch.setStatus(status);
  orderSearch.setOrderID(orderID);
  orderSearch.setOrderDateBgn(orderDateBgn);
  orderSearch.setOrderDateEnd(orderDateEnd);
  orderSearch.setBuyerName("");
  orderSearch.setSellerID(sellerID);

  switch(Integer.parseInt(status))
  {
    case 0:
      statusName = "违约订单";
      break;
    case 1:
      statusName = "新订单";
      break;
    case 2:
      statusName = "已收到订单";
      break;
    case 3:
      statusName = "已确认订单";
      break;
    case 4:
      statusName = "部分发货订单";
      break;
    case 5:
      statusName = "已完成订单";
      break;
    case 6:
      statusName = "已完成订单";
      break;
    case 7:
      statusName = "被取消订单";
      break;
    case 8:
      statusName = "延期订单";
      break;
    case 9:
      statusName = "被拒绝订单";
      break;
    default:
      statusName = "状态不明";
  }

  pageNo = 1;
  orderSearch.setPageNo(pageNo);

  orders = orderSearch.getOrders();

  myOrder = (Order)orders.elementAt(0);

  paymentID = myOrder.getPaymentMethod();

  if((paymentID!=null)&&(!paymentID.equals("")))
  {
    switch(Integer.parseInt(paymentID))
    {
      case 1:
        paymentMethod = "信用支付";
        break;
      case 2:
        paymentMethod = "汇票支付";
        break;
      case 3:
        paymentMethod = "支票支付";
        break;
      case 4:
        paymentMethod = "电汇支付";
        break;
      case 5:
        paymentMethod = "现金支付";
        break;
      default:
        paymentMethod = "不详";
    }
  }
  else
    paymentMethod = "不详";
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

             <form name="modifyOrder" action="modifyOrder2.jsp" method="post" onSubmit="return validateForm(<%=status%>)">

              <tr>
                  <td class="font4b" height="13" width="592">修改订单&nbsp;</td>
              </tr>
              <tr>
                <td width="592" >&nbsp; </td>
              </tr>
              <tr>
                <td>
                    <table width="599" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#6666FF" bordercolordark="#FFFFFF">
                      <tr bgcolor="#FFFFFF"> 
                        <td height="20" width="107" align="center"> 
                          <div align="right">订单号：</div>
                      </td>
                        <td height="20" width="186" align="center">&nbsp;<%=myOrder.getOrderID()%></td>
                        <td height="20" width="135" align="center"> 
                          <div align="right">客户订单号：</div>
                      </td>
                        <td height="20" width="151" align="center">&nbsp;<%=myOrder.getPoNumber()%></td>
                    </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td height="20" width="107" align="center"> 
                          <div align="right">订购用户：</div>
                      </td>
                        <td height="20" width="186" align="center">&nbsp;<%=myOrder.getBuyerName()%></td>
                        <td height="20" width="135" align="center"> 
                          <div align="right">订单状态：</div>
                      </td>
                        <td height="20" width="151" align="center">&nbsp;<%=statusName%></td>
                    </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td height="20" width="107" align="center"> 
                          <div align="right">订购日期：</div>
                      </td>
                        <td height="20" width="186" align="center">&nbsp;<%=myOrder.getOrderDate()%></td>
                        <td height="20" width="135" align="center"> 
                          <div align="right">要求收货日期：</div>
                      </td>
                        <td height="20" width="151" align="center">&nbsp;<%=myOrder.getRequDate()%></td>
                    </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td height="20" width="107" align="center"> 
                          <div align="right">支付方式：</div>
                      </td>
                        <td height="20" width="186" align="center">&nbsp;<%=paymentMethod%></td>
                        <td height="20" width="135" align="center"> 
                          <div align="right">预计发货日期：</div>
                      </td>
                        <td height="20" width="151" align="center">&nbsp; <%    if(status.equals("2"))
                        {  %> 
                          <input type="text" name="estimateDate" value="<%=myOrder.getEstimateDate()%>">
                  <%    }
                        else
                        {
                  %>
                        <%=myOrder.getEstimateDate()%>
                  <%    }     %>

                      </td>
                    </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td height="20" width="107" align="center"> 
                          <div align="right">总应收款：</div>
                      </td>
                        <td height="20" width="186" align="center">&nbsp;<%=myOrder.getTotalDue()%></td>
                        <td height="20" width="135" align="center"> 
                          <div align="right">总已收款：</div>
                      </td>
                        <td height="20" width="151" align="center">&nbsp;<%=myOrder.getAmountPaid()%></td>
                    </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td height="20" width="107" align="center"> 
                          <div align="right"><font color="#000000">现付应收款：</font></div>
                      </td>
                        <td height="20" width="186" align="center">&nbsp;<%=myOrder.getCashDue()%></td>
                        <td height="20" width="135" align="center"> 
                          <div align="right"><font color="#000000">现付已收款：</font></div>
                      </td>
                        <td height="20" width="151">&nbsp; <%
                        if(status.equals("3")||status.equals("4")||status.equals("5")||status.equals("6")||status.equals("7"))
                        {
                 %> 
                          <input type="text" name="cashPaid" value="<%=myOrder.getCashPaid()%>">
                 <%
                        }
                        else
                        {
                 %>
                        <%=myOrder.getCashPaid()%>
                 <%
                        }
                 %>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
                <tr>
                  <td width="592" height="18"><font color="#FF6633">说明:当修改日期时,请按 
                    YYYY-MM-DD 的格式输入日期!</font></td>
                </tr>
                <tr> 
                  <td height="15"> 
                    <div align="left"></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" align="center"> 
                    <input type="image" src="/images/temp/b_modify.gif" name="cancel2" value="修   改" class="font1" width="80" height="17">
                  </td>

                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td> 
                    <input type="hidden" name="orderID" value="<%=orderID%>" >
                    <input type="hidden" name="status" value="<%=status%>" >
                    <input type="hidden" name="estimateDateOld" value="<%=myOrder.getEstimateDate()%>">
                    <input type="hidden" name="cashPaidOld" value="<%=myOrder.getCashPaid()%>">
                    <input type="hidden" name="cashDue" value="<%=myOrder.getCashDue()%>">
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
              </form>
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

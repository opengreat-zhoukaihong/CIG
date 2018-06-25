<%@ page import="java.util.*,com.cig.chinaeoa.orderpro.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
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
  function received()
  {
    document.orderProcess.action.value = "1";
    document.orderProcess.submit();
  }
  function confirmed()
  {
    document.orderProcess.action.value = "2";
    document.orderProcess.submit();
  }
  function partialSend()
  {
    if(confirm("在进行该操作之前,请先核对发货数量!\n" + "您是否已核对过发货数量？"))
    {
      document.orderProcess.action.value = "3";
      document.orderProcess.submit();
    }
  }
  function allSend()
  {
    if(confirm("在进行该操作之前,请先核对发货数量!\n" + "您是否已核对过发货数量？"))
    {
      document.orderProcess.action.value = "4";
      document.orderProcess.submit();
    }
  }
  function canceled()
  {
    if(confirm("您确实要取消该订单吗？"))
    {
      if(document.orderProcess.remark.value == null || document.orderProcess.remark.value == "")
      {
        alert("进行取消订单操作时,必需填写备注!");
        return;
      }
      else
      {
        document.orderProcess.action.value = "5";
        document.orderProcess.submit();
      }   
    }
  }
  function delayed()
  {
    if(confirm("您确实要暂延该订单吗？"))
    {
      if(document.orderProcess.remark.value == null || document.orderProcess.remark.value == "")
      {
        alert("进行暂延订单操作时,必需填写备注!");
        return;
      }
      else
      {
        document.orderProcess.action.value = "6";
        document.orderProcess.submit();
      }
    }
  }
  function breaked()
  {
    if(document.orderProcess.remark.value == null || document.orderProcess.remark.value == "")
    {
      alert("进行违约订单处理时,必需填写备注!");
      return;
    }
    else
    {
      document.orderProcess.action.value = "7";
      document.orderProcess.submit();
    }
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
                <td colspan="3"> 
                  <table width="600" border="1" cellspacing="2" cellpadding="5" bordercolorlight="#6666FF" bordercolordark="#FFFFFF">
                    <tr align="center" bgcolor="#FFFFFF"> 
                      <td height="20" width="107"> 
                        <div align="right">订单号：</div>
                      </td>
                      <td height="20" width="186">&nbsp;<%=myOrder.getOrderID()%></td>
                      <td height="20" width="135"> 
                        <div align="right">客户订单号：</div>
                      </td>
                      <td height="20" width="152">&nbsp;<%=myOrder.getPoNumber()%></td>
                    </tr>
                    <tr align="center" bgcolor="#FFFFFF"> 
                      <td height="20" width="107"> 
                        <div align="right">订购用户：</div>
                      </td>
                      <td height="20" width="186">&nbsp;<%=myOrder.getBuyerName()%></td>
                      <td height="20" width="135"> 
                        <div align="right">订单状态：</div>
                      </td>
                      <td height="20" width="152">&nbsp;<%=statusName%></td>
                    </tr>
                    <tr align="center" bgcolor="#FFFFFF"> 
                      <td height="20" width="107"> 
                        <div align="right">订购日期：</div>
                      </td>
                      <td height="20" width="186">&nbsp;<%=myOrder.getOrderDate()%></td>
                      <td height="20" width="135"> 
                        <div align="right">要求收货日期：</div>
                      </td>
                      <td height="20" width="152">&nbsp;<%=myOrder.getRequDate()%></td>
                    </tr>
                    <tr align="center" bgcolor="#FFFFFF"> 
                      <td height="20" width="107"> 
                        <div align="right">支付方式：</div>
                      </td>
                      <td height="20" width="186">&nbsp;<%=paymentMethod%></td>
                      <td height="20" width="135"> 
                        <div align="right">预计发货日期：</div>
                      </td>
                      <td height="20" width="152">&nbsp;<%=myOrder.getEstimateDate()%></td>
                    </tr>
                    <tr align="center" bgcolor="#FFFFFF"> 
                      <td height="20" width="107"> 
                        <div align="right">总应收款：</div>
                      </td>
                      <td height="20" width="186">&nbsp;<%=myOrder.getTotalDue()%></td>
                      <td height="20" width="135"> 
                        <div align="right">总已收款：</div>
                      </td>
                      <td height="20" width="152">&nbsp;<%=myOrder.getAmountPaid()%></td>
                    </tr>
                    <tr align="center" bgcolor="#FFFFFF"> 
                      <td height="20" width="107"> 
                        <div align="right"><font color="#000000">现付应收款：</font></div>
                      </td>
                      <td height="20" width="186">&nbsp;<%=myOrder.getCashDue()%></td>
                      <td height="20" width="135"> 
                        <div align="right"><font color="#000000">现付已收款：</font></div>
                      </td>
                      <td height="20" width="152">&nbsp;<%=myOrder.getCashPaid()%></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <form name="orderProcess" action="processOrder2.jsp" method="post">
                <tr> 
                  <td colspan="3" height="18">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="3" height="15"> 
                    <div align="left"><font color="#CC0000">备注(进行 取消订单,暂延订单或违约订单的处理时,必需填写备注!):</font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3" height="75"> 
                    <textarea name="remark" cols="70" rows="3"></textarea>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="3"> 
                    <input type="hidden" name="action" >
                    <input type="hidden" name="orderID" value="<%=orderID%>" >
                    <input type="hidden" name="status" value="<%=status%>" >
                    <input type="hidden" name="poNumber" value="<%=myOrder.getPoNumber()%>" >
                    <input type="hidden" name="orderDate" value="<%=myOrder.getOrderDate()%>" >
                    <input type="hidden" name="compName" value="<%=myOrder.getBuyerName()%>">
                    <input type="hidden" name="buyerID" value="<%=myOrder.getBuyerID()%>">
                    <input type="hidden" name="searchOrderID" value="<%=searchOrderID%>">
                    <input type="hidden" name="name" value="<%=buyerName%>">
                    <input type="hidden" name="orderDateBgn" value="<%=orderDateBgn%>">
                    <input type="hidden" name="orderDateEnd" value="<%=orderDateEnd%>">
                    <%
        if(status.equals("1")) {
%> <a href="javascript:received()"> <b>收到订单</b>&nbsp; </a> <%      }
        if(status.equals("2")||status.equals("8")) {
%> <a href="javascript:confirmed()"> <b>确认订单</b>&nbsp; </a> <%      }
        if(status.equals("3")) {
%> <a href="javascript:partialSend()"> <b>部分发货</b>&nbsp; </a> <a href="javascript:allSend()"> 
                    <b>全部发货</b>&nbsp; </a> <%      }
        if(status.equals("1")||status.equals("2")||status.equals("8"))
        {
%> <a href="javascript:canceled()"> <b>取消订单</b>&nbsp; </a> <%
        }
        if(status.equals("2"))
        {
%> <a href="javascript:delayed()"> <b>暂延订单</b>&nbsp; </a> <%      }
        if(status.equals("3")||status.equals("4")||status.equals("5"))
        {
%> <a href="javascript:breaked()"> <b>违约订单</b></a> <%      }
%> </td>
                </tr>
                <tr> 
                  <td colspan="3">&nbsp;</td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0">
        <tr> 
          <td width="1%">&nbsp; </td>
          <td width="15%"> 
            <div align="right"><font color="#CC0000">订单处理说明: </font></div>
          </td>
          <td width="84%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="15%"> 
            <div align="right">收到订单: </div>
          </td>
          <td width="84%">当代理商收到订单时,进行此项操作,它将通知购买者代理商已收到订单;</td>
        </tr>
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="15%"> 
            <div align="right">确认订单: </div>
          </td>
          <td width="84%">当代理商对订单内容确认没有问题,可以按订单要求供货时进行此项操作;</td>
        </tr>
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="15%"> 
            <div align="right">部分发货: </div>
          </td>
          <td width="84%">当只有一部分订购物品发货时,进行此项操作;</td>
        </tr>
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="15%"> 
            <div align="right">全部发货: </div>
          </td>
          <td width="84%">当所有订购物品都发货时,进行此项操作;</td>
        </tr>
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="15%"> 
            <div align="right">取消订单: </div>
          </td>
          <td width="84%">由于某种原因使该订单无法履行时,进行此项操作;</td>
        </tr>
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="15%"> 
            <div align="right">暂延订单: </div>
          </td>
          <td width="84%">由于库存等问题,使得订单暂时无法履行,但购买者同意延期处理时,进行此项操作;</td>
        </tr>
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="15%"> 
            <div align="right">违约订单: </div>
          </td>
          <td width="84%">当货品已送出,而购买者此时违约取消订单,则进行此项操作;</td>
        </tr>
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="15%">&nbsp;</td>
          <td width="84%">&nbsp;</td>
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

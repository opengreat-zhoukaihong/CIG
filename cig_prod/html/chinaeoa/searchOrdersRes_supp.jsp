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
        if(!("5".equals(userType)))             // only accessible for supplier
        {
%>
      <jsp:forward page="permError.jsp" />
<%
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

  function getNewPage(pageno)
  {
    document.browseList.pageNo.value = pageno;
    document.browseList.submit();
  }

  function processOrder(tempOrderID)
  {
    document.fmProcessOrder.orderID.value = tempOrderID;
    document.fmProcessOrder.action = "processOrder.jsp";
    document.fmProcessOrder.submit();
  }
  function orderContent(tempOrderID)
  {
    document.fmProcessOrder.orderID.value = tempOrderID;
    document.fmProcessOrder.action = "orderContent.jsp";
    document.fmProcessOrder.submit();
  }

  function modifyOrder(tempOrderID)
  {
    document.fmProcessOrder.orderID.value = tempOrderID;
    document.fmProcessOrder.action = "modifyOrder.jsp";
    document.fmProcessOrder.submit();
  }

  function orderDetail(tempOrderID,tempBuyerID)
  {
    document.fmSubOrder.orderID.value = tempOrderID;
    document.fmSubOrder.buyerID.value = tempBuyerID;
    document.fmSubOrder.submit();
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
  String status,buyerName,orderDateBgn,orderDateEnd,searchOrderID,sellerID;
  String statusName;
  Vector orders = new Vector();
  int pageNo,prePageNo,nextPageNo;
  int pageCount,rowCount;
%>
<%
  sellerID = (String)session.getValue("cneoa.MemberId");

  status = request.getParameter("status");
  buyerName = request.getParameter("name");
  orderDateBgn = request.getParameter("orderDateBgn");
  orderDateEnd = request.getParameter("orderDateEnd");
  searchOrderID = request.getParameter("searchOrderID");

  if(buyerName == null)
    buyerName = "";
  if(orderDateBgn == null||orderDateBgn.equals(""))
    orderDateBgn = "2000-07-31";
  if(orderDateEnd == null||orderDateEnd.equals(""))
    orderDateEnd = "2099-07-31";
  if(searchOrderID == null)
    searchOrderID = "";

  orderSearch.setStatus(status);
  orderSearch.setOrderID(searchOrderID);
  orderSearch.setOrderDateBgn(orderDateBgn);
  orderSearch.setOrderDateEnd(orderDateEnd);
  orderSearch.setBuyerName(buyerName);
  orderSearch.setSellerID(sellerID);
  //orderSearch.setBuyerID("");

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
                <td class="font4b">&nbsp;</td>
                <td class="font4b">查询订单信息</td>
                <td class="font4b">&nbsp;</td>
              </tr>
              <tr>
                <td width="10">&nbsp;</td>

<FORM NAME="browseList" action="searchOrdersRes_supp.jsp" METHOD="post" >
  <INPUT TYPE="HIDDEN" NAME="pageNo" >
  <input type="hidden" name="searchOrderID" value="<%=searchOrderID%>">
  <input type="hidden" name="name" value="<%=buyerName%>">
  <input type="hidden" name="orderDateBgn" value="<%=orderDateBgn%>">
  <input type="hidden" name="orderDateEnd" value="<%=orderDateEnd%>">
  <input type="hidden" name="status" value="<%=status%>">
</FORM>

<form name="fmProcessOrder" method="post">
  <input type="hidden" name="orderID" >
  <input type="hidden" name="searchOrderID" value="<%=searchOrderID%>">
  <input type="hidden" name="name" value="<%=buyerName%>">
  <input type="hidden" name="orderDateBgn" value="<%=orderDateBgn%>">
  <input type="hidden" name="orderDateEnd" value="<%=orderDateEnd%>">
  <input type="hidden" name="status" value="<%=status%>">
</form>

<form name="fmSubOrder" method="post" action="orderDetails.jsp">
  <input type="hidden" name="orderID">
  <input type="hidden" name="buyerID">
  <input type="hidden" name="status" value="<%=status%>">
</form>

<%
        pageCount = orderSearch.getPageCount();
        if(pageCount == 0)
        {
%>

              <td width="580" align="center">

<%
          out.println("没有查询结果!");
        }
        else
        {
%>
  <td width="580" align="right"><font color="#CC0000">订单状态:<%=statusName%></font>
<%
          pageNo = (Integer.valueOf(getPageNo(request,"pageNo"))).intValue();

          prePageNo = pageNo - 1;
          nextPageNo = pageNo + 1;

          if(prePageNo > 0)
          {
%>
<a href="javascript:getNewPage(<%=prePageNo%>)">上一页</a>
<%
          }

          if(nextPageNo <= pageCount)
          {
%>
<a href="javascript:getNewPage(<%=nextPageNo%>)">下一页</a>
<%
          }
%>
                <td width="10">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3">
                  <table width="600" border="0" cellspacing="2" cellpadding="0">
                    <tr align="center" bgcolor="#0C7AC9">
                      <td height="20"><font color="#FFFFFF">订单流水号</font></td>
                      <td height="20"><font color="#FFFFFF">客户订单号</font></td>
                      <td height="20"><font color="#FFFFFF">订购日期</font></td>
                      <td height="20"><font color="#FFFFFF">订购用户</font></td>
                      <td height="20"><font color="#FFFFFF">总应付款</font></td>
                      <td height="20"><font color="#FFFFFF">要求收货日期</font></td>
                 <%   if(status.equals("2")||status.equals("3")||status.equals("4")||status.equals("5")||status.equals("6")||status.equals("7"))
                      {
                 %>
                      <td height="20"><font color="#FFFFFF">&nbsp;</font></td>
                 <%   }   %>
                      <td height="20"><font color="#FFFFFF">&nbsp;</font></td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>

<%
          orderSearch.setPageNo(pageNo);

          orders = orderSearch.getOrders();

          for(int i=0;i<orders.size();i++)
          {
            Order myOrder = (Order)orders.elementAt(i);
            rowCount = Integer.valueOf(myOrder.getRid()).intValue();

            if((rowCount%2) == 0)
            {
%>
                    <tr align="center" bgcolor="#E7F4FE">
                      <td><%=myOrder.getOrderID()%></td>
                      <td><%=myOrder.getPoNumber()%></td>
                      <td><%=myOrder.getOrderDate()%></td>
                      <td><%=myOrder.getBuyerName()%></td>
                      <td><%=myOrder.getTotalDue()%></td>
                      <td><%=myOrder.getRequDate()%></td>
                 <%   if(status.equals("2")||status.equals("3")||status.equals("4")||status.equals("5")||status.equals("6")||status.equals("7"))
                      {
                 %>
                      <td><a href="javascript:modifyOrder('<%=myOrder.getOrderID()%>')">修改</a></td>
                 <%   }   %>
                      <td><a href="javascript:processOrder('<%=myOrder.getOrderID()%>')">处理</a></td>
                      <td><a href="javascript:orderContent('<%=myOrder.getOrderID()%>')">概要</a></td>
                      <td><a href="javascript:orderDetail('<%=myOrder.getOrderID()%>','<%=myOrder.getBuyerID()%>')">订购内容</a></td>
                    </tr>
<%          }
            else
            {
%>
                    <tr align="center" bgcolor="#F4FCFF">
                      <td><%=myOrder.getOrderID()%></td>
                      <td><%=myOrder.getPoNumber()%></td>
                      <td><%=myOrder.getOrderDate()%></td>
                      <td><%=myOrder.getBuyerName()%></td>
                      <td><%=myOrder.getTotalDue()%></td>
                      <td><%=myOrder.getRequDate()%></td>
                 <%   if(status.equals("2")||status.equals("3")||status.equals("4")||status.equals("5")||status.equals("6")||status.equals("7"))
                      {
                 %>
                      <td><a href="javascript:modifyOrder('<%=myOrder.getOrderID()%>')">修改</a></td>
                 <%   }   %>
                      <td><a href="javascript:processOrder('<%=myOrder.getOrderID()%>')">处理</a></td>
                      <td><a href="javascript:orderContent('<%=myOrder.getOrderID()%>')">概要</a></td>
                      <td><a href="javascript:orderDetail('<%=myOrder.getOrderID()%>','<%=myOrder.getBuyerID()%>')">订购内容</a></td>
                    </tr>
<%          }
          }
        }
%>

                  </table>
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

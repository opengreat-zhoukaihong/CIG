<%@ page import="java.util.*,com.cig.chinaeoa.orderpro.*,java.io.*" session="true" language="java" errorPage="error.jsp"%>
<%-- control the access to the page --%>
<%!
    String highLevel = "5";
    String userType,userLevel,eoaLoginID;
    // userType 1:EOA; 2:individual; 3:company; 4:dealer; 5:supplier; 6:supplier&dealer;
    // userLevel 0: normal user; 1: powerUser;
    String action;   // used to denote the operate type on the db. include:"add";"modify";"delete";

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
        if(!("5".equals(userType)))             // only accessible for supplier
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

  function modifyOrder(tempSubOrderID)
  {
    document.fmModifyOrder.subOrderID.value = tempSubOrderID;
    document.fmModifyOrder.submit();
  }

//-->
</script>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<jsp:useBean id="orderDetail" scope="page" class="com.cig.chinaeoa.orderpro.SubOrderProc" />
<%!
  public String getPageNo(HttpServletRequest request,String pageNo)
  {
      if(request.getParameter(pageNo) == null)
        return "1";
      else
        return request.getParameter(pageNo);
  }
  String orderID,buyerID,status;
  String shipMethodID,shipMethod;
  Vector subOrders = new Vector();
  int pageNo,prePageNo,nextPageNo;
  int pageCount,rowCount;
%>
<%
  orderID = request.getParameter("orderID");
  buyerID = request.getParameter("buyerID");
  status = request.getParameter("status");

  orderDetail.setOrderID(orderID);
  orderDetail.setSubOrderID("");

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
                <td class="font4b">查询订单详细信息</td>
                <td class="font4b">&nbsp;</td>
              </tr>
              <tr>
                <td width="10">&nbsp;</td>

<FORM NAME="browseList" action="orderDetails.jsp" METHOD="post" >
  <INPUT TYPE="HIDDEN" NAME="pageNo" >
  <input type="hidden" name="orderID" value="<%=orderID%>">
  <input type="hidden" name="buyerID" value="<%=buyerID%>">
  <input type="hidden" name="status" value="<%=status%>">
</FORM>

<form name="fmModifyOrder" action="modifyOrderDetail.jsp" method="post">
  <INPUT TYPE="HIDDEN" NAME="pageNo" >
  <input type="hidden" name="orderID" value="<%=orderID%>">
  <input type="hidden" name="buyerID" value="<%=buyerID%>">
  <input type="hidden" name="subOrderID" >
  <input type="hidden" name="status" value="<%=status%>">
</form>

<%
        pageCount = orderDetail.getPageCount();
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
          <td width="580" align="right">
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
                      <td height="20"><font color="#FFFFFF">产品品牌</font></td>
                      <td height="20"><font color="#FFFFFF">产品类别</font></td>
                      <td height="20"><font color="#FFFFFF">产品型号</font></td>
                      <td height="20"><font color="#FFFFFF">订购价格</font></td>
                      <td height="20"><font color="#FFFFFF">订购数量</font></td>
                      <td height="20"><font color="#FFFFFF">已送数量</font></td>
                      <td height="20"><font color="#FFFFFF">运送方式</font></td>
                      <td>&nbsp;</td>
                    </tr>

<%
          orderDetail.setPageNo(pageNo);

          subOrders = orderDetail.getSubOrders();

          for(int i=0;i<subOrders.size();i++)
          {
            SubOrder mySubOrder = (SubOrder)subOrders.elementAt(i);
            shipMethodID = mySubOrder.getShipMethod();
            if((shipMethodID==null)||(shipMethodID.equals("")))
              shipMethod = "不详";
            else if(shipMethodID.equals("1"))
              shipMethod = "自提";
            else if(shipMethodID.equals("2"))
              shipMethod = "铁路";
            else if(shipMethodID.equals("3"))
              shipMethod = "航空";
            else if(shipMethodID.equals("4"))
              shipMethod = "汽车";
            else if(shipMethodID.equals("5"))
              shipMethod = "船运";
            else
              shipMethod = "不详";

                

            rowCount = Integer.valueOf(mySubOrder.getRid()).intValue();

            if((rowCount%2) == 0)
            {
%>
                    <tr align="center" bgcolor="#E7F4FE">
                      <td><%=mySubOrder.getBrand()%></td>
                      <td><%=mySubOrder.getCateName()%></td>
                      <td><%=mySubOrder.getProductNo()%></td>
                      <td><%=mySubOrder.getSalePrice()%></td>
                      <td><%=mySubOrder.getQuantity()%></td>
                      <td><%=mySubOrder.getQuantitySend()%></td>
                      <td><%=shipMethod%></td>
                      <td><a href="javascript:modifyOrder('<%=mySubOrder.getSubOrderID()%>')">修改订单</a></td>
                    </tr>
<%          }
            else
            {
%>
                    <tr align="center" bgcolor="#F4FCFF">
                      <td><%=mySubOrder.getBrand()%></td>
                      <td><%=mySubOrder.getCateName()%></td>
                      <td><%=mySubOrder.getProductNo()%></td>
                      <td><%=mySubOrder.getSalePrice()%></td>
                      <td><%=mySubOrder.getQuantity()%></td>
                      <td><%=mySubOrder.getQuantitySend()%></td>
                      <td><%=shipMethod%></td>
                      <td><a href="javascript:modifyOrder('<%=mySubOrder.getSubOrderID()%>')">修改订单</a></td>
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

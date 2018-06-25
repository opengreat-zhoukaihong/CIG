<%@ page import="java.util.*, java.sql.*,java.io.*,com.cig.chinaeoa.orderpro.*" session="true" language="java" errorPage="error.jsp"%>
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

<script><!--

  function checkDate(checkedDate)
  {
    var tempDate = checkedDate;
    if(tempDate != "")
    {
      if((tempDate.charAt(4)!="-")||(tempDate.charAt(7)!="-"))
      {
        alert("输入的日期的格式有误,请按正确格式输入!");
        return false;
      }
      if(tempDate.length != 10)
      {
        alert("输入的日期的格式有误,请按正确格式输入!");
        return false;
      }
      tempDate = checkedDate.substring(0,4);
      if(tempDate<'1980'||tempDate>'2099')
      {
        alert("输入的年份有误!")
        return false;
      }
      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
          alert("输入的年份有误.");
          return false;
        }
      }
      tempDate = checkedDate.substring(5,7);
      if(tempDate<'01'||tempDate>'12')
      {
        alert("输入的月份有误!")
        return false;
      }
      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
          alert("输入的月份有误!");
          return false;
        }
      }
      tempDate = checkedDate.substring(8,10);
      if(tempDate<'01'||tempDate>'31')
      {
        alert("输入的日期有误!")
        return false;
      }

      for(i=0;i<tempDate.length;i++)
      {
        if((tempDate.charAt(i)<'0')||(tempDate.charAt(i)>'9'))
        {
          alert("输入的日期有误.");
          return false;
        }
      }
    }
    return true;
  }
  function isDigital(tempStr)
  {
    for(var i=0;i<tempStr.length;i++)
    {
      if((tempStr.charAt(i)<'0')||(tempStr.charAt(i)>'9'))
        return false;
    }
    return true;
  }

  function validateForm(tempStatus,tempQuantity)
  {
    if(tempStatus=="1"||tempStatus=="2"||tempStatus=="8")
    {
      if(!checkDate(document.modifyOrderDetail.shipDate.value))
      {
        document.modifyOrderDetail.shipDate.focus();
        return false;
      }
      if(!isDigital(document.modifyOrderDetail.quantity.value))
      {
        alert("订购数量输入有误!");
        document.modifyOrderDetail.quantity.focus();
        return false;
      }
      if(tempQuantity != document.modifyOrderDetail.quantity.value)
      {
        if(document.modifyOrderDetail.remark.value=="")
        {
          alert("如果您修改了订购数量,必需填写备注,说明修改原因!");
          document.modifyOrderDetail.remark.focus();
          return false;
        }
      }
    }
    else if(tempStatus=="3")
    {
      if(!checkDate(document.modifyOrderDetail.shipDate.value))
      {
        document.modifyOrderDetail.shipDate.focus();
        return false;
      }
      if(!isDigital(document.modifyOrderDetail.quantitySend.value))
      {
        alert("已送数量输入有误!");
        document.modifyOrderDetail.quantitySend.focus();
        return false;
      }
      if((0+document.modifyOrderDetail.quantitySend.value) > tempQuantity)
      {
        alert("已送数量超过订购数量!");
        document.modifyOrderDetail.quantitySend.focus();
        return false;
      }
    }
    else if(tempStatus=="4")
    {
      if(!isDigital(document.modifyOrderDetail.quantitySend.value))
      {
        alert("已送数量输入有误!");
        document.modifyOrderDetail.quantitySend.focus();
        return false;
      }
      if((0+document.modifyOrderDetail.quantitySend.value) > tempQuantity)
      {
        alert("已送数量超过订购数量!");
        document.modifyOrderDetail.quantitySend.focus();
        return false;
      }
    }
    return true;
  }



//-->
</script>


<%!
  String lang_code = "GB";
  Vector v_shipID = new Vector();
  Vector v_shipName = new Vector();
  Vector v_deliveryID = new Vector();
  Vector v_deliveryName = new Vector();
  Vector subOrders = new Vector();

  SubOrder mySubOrder;
  ResultSet deliveryInfo,shipInfo;
  String orderID,subOrderID,buyerID,sellerID,status;
  String shipID,shipName;
  String tempSqlStr;

%>

<jsp:useBean id="shipManager" scope="page" class="com.cig.chinaeoa.member.ShipManager" />
<jsp:useBean id="deliveryManager" scope="page" class="com.cig.chinaeoa.member.DeliveryManager" />
<jsp:useBean id="orderDetailProc" scope="page" class="com.cig.chinaeoa.orderpro.SubOrderProc" />

<%
  try
  {
    sellerID = (String)session.getValue("cneoa.MemberId");

    orderID = request.getParameter("orderID");
    subOrderID = request.getParameter("subOrderID");
    buyerID = request.getParameter("buyerID");
    status = request.getParameter("status");

    tempSqlStr = "select sl.shipID,sl.shipName from shipment s,shipment_l sl " +
      " where s.memberID = '" + buyerID + "' and sl.lang_code = '" + lang_code +
      "' and s.shipID = sl.shipID ";

    shipManager.setSqlStr(tempSqlStr);

    shipInfo = shipManager.getDetail();

    if(shipInfo != null)
    {
      while(shipInfo.next())
      {
        v_shipID.addElement(shipInfo.getString("shipID"));
        v_shipName.addElement(shipInfo.getString("shipName"));
      }
      shipManager.disconn();
    }

    tempSqlStr = "select dl.deliveryID,name from delivery d,delivery_l dl,supplier s " +
      " where s.memberID = '" + sellerID + "' and dl.lang_code = '" + lang_code + "' and " +
      " s.supplierID = d.supplierID and d.deliveryID = dl.deliveryID ";

    deliveryManager.setSqlStr(tempSqlStr);
    deliveryInfo = deliveryManager.getDetail();
    if(deliveryInfo!=null)
    {
      while(deliveryInfo.next())
      {
        v_deliveryID.addElement(deliveryInfo.getString("deliveryID"));
        v_deliveryName.addElement(deliveryInfo.getString("name"));
      }
      deliveryManager.disconn();
    }

    orderDetailProc.setOrderID(orderID);
    orderDetailProc.setSubOrderID(subOrderID);
    orderDetailProc.setPageNo(1);

    subOrders = orderDetailProc.getSubOrders();

    mySubOrder = (SubOrder)subOrders.elementAt(0);

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
                  修改订单详细信息</font></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr bgcolor="#99CCFF">
                <td class="font4b" align="center" width="7" valign="top"><img src="/images/temp/corner_l.gif" width="7" height="7"></td>
                <td height="25" class="font4b" align="center">修改订单详细信息</td>
                <td class="font4b" align="center" bgcolor="#99CCFF" width="7" valign="top"><img src="/images/temp/corner_r.gif" width="7" height="7"></td>
              </tr>
              <tr bgcolor="#000066"> 
                <td height="1" class="font4b" align="center" colspan="3" valign="top"><img src="/images/spacer.gif" width="1" height="1"></td>
              </tr>
            </table>
            <table width="500" border="0" cellspacing="0" cellpadding="3" align="center">
              <form name="modifyOrderDetail" method="post" action="modifyOrderDetail2.jsp" onSubmit="return validateForm('<%=status%>','<%=mySubOrder.getQuantity()%>')">
                <tr bgcolor="#DFEEFF"> 
                  <td height="22" colspan="2" align="center">&nbsp;</td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#F4FCFF" width="123">品&nbsp;&nbsp;&nbsp;&nbsp;牌：</td>
                  <td bgcolor="#F4FCFF" width="365"> <%=mySubOrder.getBrand()%> 
                  </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#DFEEFF" width="123">产品类别：</td>
                  <td bgcolor="#DFEEFF" width="365"><%=mySubOrder.getCateName()%> 
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#F4FCFF" width="123">产品型号：</td>
                  <td bgcolor="#F4FCFF" width="365"><%=mySubOrder.getProductNo()%> 
                  </td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#DFEEFF" width="123">订购价格：</td>
                  <td bgcolor="#DFEEFF" width="365"><%=mySubOrder.getSalePrice()%>
                  </td>
                </tr>
                <tr> 
                  <td align="right" bgcolor="#F4FCFF" width="123" height="31">订购数量：</td>
                  <td bgcolor="#F4FCFF" width="365" height="31"> <%  if("1".equals(status)||"2".equals(status)||"8".equals(status))  {   %> 
                    <input type="text" name="quantity" value="<%=mySubOrder.getQuantity()%>" size="15" class="font1">
                    <%  } else {  %> <%=mySubOrder.getQuantity()%> <%  }   %> 
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="123" height="27">已送数量：</td>
                  <td bgcolor="#DFEEFF" width="365" height="27"> <%  if("3".equals(status)||"4".equals(status))  {   %> 
                    <input type="text" name="quantitySend" value="<%=mySubOrder.getQuantitySend()%>" size="15" class="font1">
                    <%  } else {  %> <%=mySubOrder.getQuantitySend()%> <%  }   %> 
                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#F4FCFF" width="123">收货方名称：</td>
                  <td bgcolor="#F4FCFF" width="365"> <%  if("1".equals(status)||"2".equals(status)||"3".equals(status)||"8".equals(status))
                    {
                %> 
                    <select name="shipID">
                      <%    for(int i=0;i<v_shipID.size();i++)
                      {
                        if((v_shipID.elementAt(i)).equals(mySubOrder.getShipID()))
                        {
                %> 
                      <option value="<%=v_shipID.elementAt(i)%>" selected><%=v_shipName.elementAt(i)%></option>
                      <%
                        }
                        else
                        {
                %> 
                      <option value="<%=v_shipID.elementAt(i)%>"><%=v_shipName.elementAt(i)%></option>
                      <%
                        }
                      }
                %> 
                    </select>
                    <%  }
                    else
                    {
                      for(int i=0;i<v_shipID.size();i++)
                      {
                        if((v_shipID.elementAt(i)).equals(mySubOrder.getShipID()))
                        {
                %> <%=v_shipName.elementAt(i)%> <%
                          break;
                        }
                      }
                    }
                %> </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="123">投递方名称：</td>
                  <td bgcolor="#DFEEFF" width="365"> <%  if("1".equals(status)||"2".equals(status)||"3".equals(status)||"8".equals(status))
                    {
                %> 
                    <select name="deliveryID" >
                      <%    for(int i=0;i<v_deliveryID.size();i++)
                      {
                        if((v_deliveryID.elementAt(i)).equals(mySubOrder.getDeliveryID()))
                        {
                %> 
                      <option value="<%=v_deliveryID.elementAt(i)%>" selected><%=v_deliveryName.elementAt(i)%></option>
                      <%
                        }
                        else
                        {
                %> 
                      <option value="<%=v_deliveryID.elementAt(i)%>"><%=v_deliveryName.elementAt(i)%></option>
                      <%
                        }
                      }
                %> 
                    </select>
                    <%  }
                    else
                    {
                      for(int i=0;i<v_deliveryID.size();i++)
                      {
                        if((v_deliveryID.elementAt(i)).equals(mySubOrder.getDeliveryID()))
                        {
                %> <%=v_deliveryName.elementAt(i)%> <%
                          break;
                        }
                      }
                    }

                %> </td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td align="right" bgcolor="#F4FCFF" width="123">运送日期：</td>
                  <td bgcolor="#F4FCFF" width="365"> <%    if("1".equals(status)||"2".equals(status)||"3".equals(status)||"8".equals(status))
                  {
            %> 
                    <input type="text" name="shipDate" value="<%=mySubOrder.getShipDate()%>" size="15" class="font1">
                    <font color="#cc0000">(按YYYY-MM-DD 格式输入)</font> <%    }
                  else
                  {
            %> <%=mySubOrder.getShipDate()%> <%
                  }
            %> </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td align="right" bgcolor="#DFEEFF" width="123">运输方式：</td>
                  <td bgcolor="#DFEEFF" width="365"> <%    if("1".equals(status)||"2".equals(status)||"3".equals(status)||"8".equals(status))
                  {
            %> 
                    <select name="shipMethod">
                      <%        switch(Integer.parseInt(mySubOrder.getShipMethod()))
                      {
                        case 2:
            %> 
                      <option value="1" >自提</option>
                      <option value="2" selected>铁路</option>
                      <option value="3">航空</option>
                      <option value="4">公路</option>
                      <option value="5">船运</option>
                      <%            break;
                        case 3:
            %> 
                      <option value="1" >自提</option>
                      <option value="2" >铁路</option>
                      <option value="3" selected>航空</option>
                      <option value="4">公路</option>
                      <option value="5">船运</option>
                      <%            break;
                        case 4:
            %> 
                      <option value="1" >自提</option>
                      <option value="2" >铁路</option>
                      <option value="3" >航空</option>
                      <option value="4" selected>公路</option>
                      <option value="5">船运</option>
                      <%            break;
                        case 5:
            %> 
                      <option value="1" >自提</option>
                      <option value="2" >铁路</option>
                      <option value="3" >航空</option>
                      <option value="4" >公路</option>
                      <option value="5" selected>船运</option>
                      <%            break;
                        default:
            %> 
                      <option value="1" selected>自提</option>
                      <option value="2" >铁路</option>
                      <option value="3" >航空</option>
                      <option value="4" >公路</option>
                      <option value="5" >船运</option>
                      <%        } %> 
                    </select>
                    <%   }
                  else
                  {
                    switch(Integer.parseInt(mySubOrder.getShipMethod()))
                    {
                      case 1:
             %> 自提 <%         break;
                      case 2:     
             %> 铁路 <%         break;
                      case 3:
             %> 航空 <%         break;
                      case 4:
             %> 公路 <%         break;
                      case 5:
             %> 船运 <%         break;
                      default:
             %> 不详 <%     }
                  }
             %> </td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td align="right" bgcolor="#F4FCFF" width="123" height="61">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
                  <td bgcolor="#F4FCFF" width="365" height="61"> 
                    <p> 
                      <textarea name="remark" cols="30" rows="2"></textarea>
                    </p>
                    <input type="hidden" name="status" value="<%=status%>">
                    <input type="hidden" name="orderID" value="<%=orderID%>">
                    <input type="hidden" name="subOrderID" value="<%=subOrderID%>">
                    <input type="hidden" name="buyerID" value="<%=buyerID%>">
                    <input type="hidden" name="quantityOld" value="<%=mySubOrder.getQuantity()%>">
                    <input type="hidden" name="quantitySendOld" value="<%=mySubOrder.getQuantitySend()%>">
                    <input type="hidden" name="salePrice" value="<%=mySubOrder.getSalePrice()%>">

                  </td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td bgcolor="#DFEEFF" align="center">&nbsp;</td>
                  <td align="center" bgcolor="#DFEEFF"> 
                    <div align="left"><font color="#CC0000">说明:如果您修改了订购数量,必需填写备注!</font> 
                    </div>
                  </td>
                </tr>
                <tr bgcolor="#F4FCFF"> 
                  <td colspan="2" align="center">&nbsp;</td>
                </tr>
                <tr bgcolor="#DFEEFF"> 
                  <td colspan="2" align="center"> 
                    <input type="image" src="/images/temp/b_modify.gif" name="cancel2" value="取   消" class="font1" width="80" height="17">
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


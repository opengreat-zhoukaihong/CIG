<%@ page import="java.sql.*, java.util.Hashtable,java.util.Enumeration" %>
<jsp:useBean id="Order" scope="session" class="com.cig.chinaeoa.OrderBean" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
   String MemberId  = (String)session.getValue("cneoa.MemberId");
   String MemberType = (String)session.getValue("cneoa.MemberType");
   String UserLevel = (String)session.getValue("cneoa.UserLevel");

   if (MemberId == null) 
   {
   %>
 	<jsp:forward page="/LoginError.htm" />

   <%
   }

   String Qty = "";
   String ProdId = "";
   String Brand = "";
   String ProductNo = "";
   String Category = "";
   String LangCode = request.getParameter("LangCode");
   //String Supplier = request.getParameter("Supplier");
   float Price = 0;
   float Total = 0;
   float SumTotal = 0;
   String PO = request.getParameter("PO");
   //String ShipId = request.getParameter("ShipId");
   //String EstimateDate = request.getParameter("ShipDate");
   String RequDate = "";
   String Payment = "";
   //String ShipMethod = request.getParameter("ShipMethod");
   String OrderId = "";
   Hashtable hash;
   hash = Order.getSupplierPayment();
   String Supplier = "";
   Enumeration enumSupplier = hash.keys();
   Object obj;		
   while (enumSupplier.hasMoreElements())
   {		
     obj = enumSupplier.nextElement();
     Supplier = (String)obj;
     Payment = request.getParameter("Payment" + Supplier);
     if (Payment !=  null)
       Order.AddSupplierPayment(Supplier,Payment);
     RequDate = request.getParameter("RequDate" + Supplier);
     if (RequDate != null)
       Order.AddSupplierRequDate(Supplier,RequDate);
   }

   String OrderType = "";
   if (MemberType.equals("4"))
     OrderType = "1";
  

%>


<html>
<head>


<title>订购结果</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<%
try
{
  //Order.AddOrder(OrderType, MemberId, PO, LangCode);
}
finally
{
  //out.println(Order.getSQL());
}

%>

<form method="post" action="OrderPre.jsp?LangCode=<%=LangCode%>" name="fmList">
  <table width="500" border="0" cellspacing="1" cellpadding="2" topmargin="0" align="center">
    <tr> 
      <td colspan="6"  height="38">采购完成，谢谢您使用ChinaEOA在线采购系统，我们的客户服务部会安排送货事宜。 </td>
    </tr>
    <tr> 
      <td height="21" colspan="6">
        <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="#2078CB">
          <tr bgcolor="#FFFFFF" bordercolor="#3399FF"> 
            <td height="28" nowrap width="104" class="font1b" bordercolor="#3399FF" bgcolor="#003399"><font color="#FFFFFF">客户内部订单号:</font></td>
            <td height="28" nowrap colspan="4" class="font1b" bgcolor="#003399" bordercolor="#3399FF"><font color="#FFFFFF"><%=PO%></font></td>
          </tr>
        <%
	  if (Order.AddOrder(OrderType, MemberId, PO, LangCode))
        {
          //out.println(Order.getSQL());
          enumSupplier = hash.keys();
   		  while (enumSupplier.hasMoreElements())
   		 {		
           obj = enumSupplier.nextElement();
           Supplier = (String)obj;
           OrderId = Order.getOrder(obj);
           %>
          <tr bgcolor="#FFFFFF" bordercolor="#3399FF"> 
            <td height="28" nowrap width="104" class="font1b">EOA在线订单号:</td>
            <td height="28" nowrap width="64" class="font1b"><%=OrderId%></td>
            <td height="28" nowrap width="48" class="font1b">供应商:</td>
            <td height="28" nowrap colspan="2" width="259" class="font1b"><%=Order.getSupplierName(Supplier,LangCode)%></td>
          </tr>
          <%
		}
          }
	    else
          {
		out.println("对不起!订购失败!");
		out.println(Order.getSQL());
	     }
		
          %>
        </table>
      </td>
    </tr>
    <tr> 
      <td width="1" height="27">&nbsp;</td>
      <td width="270" height="27">&nbsp;</td>
      <td width="73" height="27">&nbsp; </td>
      <td width="82" height="27">&nbsp; </td>
      <td width="47" height="27">&nbsp; </td>
      <td width="78" height="27"> 
        <input type="button" name="Button" value="关  闭" onClick="javascript:window.close();">
      </td>
    </tr>
  </table>
</form>
<%Result.CloseStm();%>
<p>&nbsp;</p>
</body>
</html>



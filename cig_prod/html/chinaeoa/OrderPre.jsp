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

   String Qty = request.getParameter("Qty");
   String ProdId = request.getParameter("ProdId");
   String Brand = "";
   String ProductNo = "";
   String Category = "";
   String LangCode = request.getParameter("LangCode");
   String Type = request.getParameter("Type");
   float Price = 0;
   float Total = 0;
   float SumTotal = 0;
   String ProdIds = "";
   String Amount = "0";
   String Supplier = "";
   String Class = "1";
   Hashtable hash;
   hash = Order.getHash();
   Enumeration enumProd = hash.keys();
   Object obj;
   ResultSet rs;
   String SQL = "";
   while (enumProd.hasMoreElements())
   {		
        obj = enumProd.nextElement();
	    ProdIds = ProdIds + (String)obj + ",";
	    //Qty = (String)hash.get(obj);
   }
   ProdIds = "(" + ProdIds + "0" + ")";
   SQL = "select  p.*, b.name, c.catename,m.Class,m.CreditAmount from " +
          			" product p,  brand b, category c, payment m  where " +
          			"  B.lang_code = '" + LangCode + "' and p.brandid = b.brandid  " +
          			" and  p.cateid = c.cateid and c.lang_code = B.lang_code and p.prodid in " + 
					 ProdIds + "  and p.supplier = m.supplierid(+) and m.memberid(+) = '" +
					 MemberId + "' order by p.supplier,p.cateid,p.prodid";
   rs = Result.getRS(SQL);
 Order.ClearSupplier();
 %>

<html>
<head>
<script language="JavaScript">
<!--
function Post()
{
  //alert(fmList.Payment.checked);
  if (fmList.PO.value == "")
  {
    alert("请输入客户订单号");
    return;
  }
  for (j=0;j<fmList.elements.length;++j)
  { 
       //alert(fmList.elements[j].type);
       if (fmList.elements[j].type == "text")
      {
      	   if (fmList.elements[j].value == "")
          {
            alert ("请输入收货日期!");
            return;
          }
       }
  }
  
  

  fmList.action = "OrderResult.jsp?LangCode=<%=LangCode%>";
  fmList.method = "post";
  fmList.submit();
}

//-->
</script>

<title>我的购物车</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF">

<form method="post" action="" name="fmList">

  <table width="500" border="0" cellspacing="1" cellpadding="2" topmargin="0" align="center">
    <tr> 
      <td colspan="6" class="font3b">结帐:</td>
    </tr>
    <tr> 
      <td height="84" colspan="6"> 
        <table width="500" border="0" cellspacing="0" cellpadding="1" bgcolor="#2078CB">
          <tr> 
            <td> 
              <table border="0" cellspacing="1" cellpadding="2" height="64" width="500">
                <tr class="font1b" bgcolor="#003399"> 
                  <td height="29" nowrap width="96"> 
                    <div align="center"><font color="#FFFFFF">客户订单号: </font></div>
                  </td>
                  <td height="29" nowrap colspan="5" align="left" bgcolor="#003399"> 
                    <input type="text" name="PO">
                    <font color="#FFFFFF">*</font> <font color="#FFFFFF">[输字母或数字,长度小于12]</font> 
                  </td>
                </tr>
                 
                <tr class="font1b"> <% 
//out.println(SQL);
if (rs != null)
{
   boolean isLast = false;
   rs.next();
  while (!isLast)
  {
      
%> 
                  <td height="29" nowrap width="96" bgcolor="#DFEEFF"> 
                    <div align="center">供应商:</div>
                  </td>
                  <td height="29" nowrap colspan="5" bgcolor="#DFEEFF"> 
                    <div align="center"><%=Order.getSupplierName(rs.getString("Supplier"),LangCode)%> 
                      <input type="hidden" name="Supplier" value="<%=rs.getString("Supplier")%>">
                    </div>
                    <div align="center"></div>
                    <div align="center"></div>
                  </td>
                </tr>
                <tr class="font1b"> 
                  <td height="28" nowrap width="96" bgcolor="#FFFFFF"> 
                    <div align="center">品牌</div>
                  </td>
                  <td height="28" nowrap width="97" bgcolor="#FFFFFF"> 
                    <div align="center">型号</div>
                  </td>
                  <td height="28" nowrap width="110" bgcolor="#FFFFFF"> 
                    <div align="center">单价</div>
                  </td>
                  <td height="28" nowrap colspan="2" bgcolor="#FFFFFF"> 
                    <div align="center">数量</div>
                  </td>
                  <td height="28" width="71" nowrap align="center" bgcolor="#FFFFFF">小计</td>
                </tr>
                <%
		       Supplier = rs.getString("Supplier");
			   Order.AddSupplierPayment(Supplier,"0");
			   Amount = Order.getAmount(Supplier,MemberId);
			   if ((Amount == null) || (Amount.equals("")))
			     Amount = "0";
		       Total = 0;
		       SumTotal = 0;
		       Class = rs.getString("Class");
                   while (Supplier.equals(rs.getString("Supplier")))
                   {    
			obj = rs.getString("Prodid");
    			Qty = (String)hash.get(obj);		
			Brand = rs.getString("Name");
			ProductNo = rs.getString("ProductNo") + "<br> " + rs.getString("CateName");
		    Price = rs.getFloat("ListPrice");
			if ((Class != null) && (Class.length()>0))
			  Price = rs.getFloat("Price" + Class);
            else
              Price = rs.getFloat("ListPrice");
			Total =  Integer.parseInt(Qty) * Price;
			SumTotal = SumTotal + Total;
			
			
			

		   				

                %> 
                <tr> 
                  <td height="22" width="96" bgcolor="#FFFFFF"> 
                    <div align="center"><%=Brand%></div>
                  </td>
                  <td height="22" width="97" bgcolor="#FFFFFF"> 
                    <div align="center"><%=ProductNo%></div>
                  </td>
                  <td height="22" width="110" bgcolor="#FFFFFF"> 
                    <div align="center"><%=Price%></div>
                  </td>
                  <td height="22" colspan="2" align="center" bgcolor="#FFFFFF"> 
                    <div align="center"> </div>
                    <a href="javascript:Update(<%=ProdId%>)"></a><%=Qty%></td>
                  <td width="71" height="22" align="right" bgcolor="#FFFFFF"><%=Total%></td>
                </tr>
                <%
			if (!rs.next())
			{ 
            		  isLast = true;	   	  
			  break;	
			}			    	
    		      }
		   %> 
                <tr> 
                  <td height="27" align="right" colspan="5" bgcolor="#FFFFFF"> 
                    <div align="center"></div>
                    <font color="#FF3333"><b>合计金额:</b></font> </td>
                  <td height="27" width="71" align="right" bgcolor="#FFFFFF"><%=SumTotal%></td>
                </tr>
                <tr > 
                  <td height="28" nowrap width="96" class="font1b" bgcolor="#FFFFFF"> 
                    <div align="center">收货日期:</div>
                  </td>
                  <td height="28" nowrap colspan="5" bgcolor="#FFFFFF"> 
                    <input type="text" name="RequDate<%=Supplier%>" size="18" maxlength="10">
                    <font color="#FF0033"> [输入格式 YYYY-MM-DD，2000-03-06] </font></td>
                </tr>
                <tr > 
                  <td height="28" nowrap width="96" class="font1b" bgcolor="#FFFFFF"> 
                    <div align="center">付款方式:</div>
                  </td>
                  <td height="28" nowrap colspan="3" bgcolor="#FFFFFF"> 
                    <input type="hidden" name="Amount" value="<%=Amount%>">
                    <input type="hidden" name="SumTotal" value="<%=SumTotal%>">
                    <select name="Payment<%=Supplier%>">
                      <%
						if (SumTotal<Integer.parseInt(Amount)) 
                        { 
							%> 
                      <option value="1" selected>信用</option>
                      <option value="2" >汇票</option>
                      <% }
						else 
 						{
						%> 
                      <option value="2" selected >汇票</option>
                      <%
						}%> 
                      <option value="3">支票</option>
                      <option value="4">电汇</option>
                      <option value="5">现金 .</option>
                    </select>
                    <%if (SumTotal>Integer.parseInt(Amount))
					    out.println("<font color=\"#FF0033\">信用余额不足!</font>");
					  
					%> </td>
                  <td height="28" nowrap align="center" width="78" class="font1b" bgcolor="#FFFFFF">信用余额:</td>
                  <td height="28" nowrap width="71" bgcolor="#FFFFFF"><% 

out.println(Amount);
%></td>
                </tr>
                <tr class="font1b"> 
                  <td height="20" nowrap colspan="6" bgcolor="#FFFFFF"> 
                    <div align="center"> </div>
                  </td>
                </tr>
                <%
       
  }
}
%> 
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td width="1" height="27">&nbsp;</td>
      <td width="270" height="27">&nbsp; </td>
      <td width="73" height="27">&nbsp; </td>
      <td width="82" height="27">&nbsp; </td>
      <td width="47" height="27">
        <input type="button" name="Button2" value="提  交" onClick="javascript:Post();">
      </td>
      <td width="78" height="27">
        <input type="button" name="Button22" value="返  回" onClick="javascript:window.history.go(-1);">
      </td>
    </tr>
  </table>
</form>
<%Result.CloseStm();%>
<p>&nbsp;</p>
</body>
</html>



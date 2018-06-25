<%@ page import="java.sql.*, java.util.Hashtable,java.util.Enumeration" %>
<jsp:useBean id="Order" scope="session" class="com.cig.chinaeoa.OrderBean" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<%
     String MemberId  = (String)session.getValue("cneoa.MemberId");
     String MemberType = (String)session.getValue("cneoa.MemberType");
     String UserLevel = (String)session.getValue("cneoa.UserLevel");

      if (MemberId == null) 
      {
      %>
 	<jsp:forward page="LoginError.jsp" />

      <%
     }
 
   String Qty = request.getParameter("Qty");
   String ProdId = request.getParameter("ProdId");
   String Brand = "";
   String ProductNo = "";
   String Category = "";
   String LangCode = request.getParameter("LangCode");
   String Type = request.getParameter("Type");
   if (Type == null)
     Type = "";
   float Price = 0;
   float Total = 0;
   float SumTotal = 0;
       
%> 


<html>
<head>
<script language="JavaScript">
<!--
function OrderPre()
{ 
  for (j=0;j<fmList.elements.length;++j)
   { 
       //alert(fmList.elements[j].type);
       if (fmList.elements[j].type == "select-one")
      {
      	   if (fmList.elements[j].value == "0")
          {
            alert ("请选择送货地址!");
            return;
          }
       }
  }
  fmList.action="OrderPre.jsp?LangCode=<%=LangCode%>";
  fmList.method="post";
  fmList.submit(); 
}
function Save()
{
  // alert("test");
   for (j=0;j<fmList.elements.length;++j)
   { 
       //alert(fmList.elements[j].type);
       if (fmList.elements[j].type == "select-one")
      {
      	   if (fmList.elements[j].value == "0")
          {
            alert ("请选择送货地址!");
            return;
          }
        else
          fmList.action = "/chinaeoa/OrderShip.jsp?Type=S&LangCode=<%=LangCode%>";
       }
  }
  //alert("test");
  fmList.method="post";
  fmList.submit();
}

function Update(ProdId)
{
   for (j=0;j<fmList.elements.length;++j)
   { 
       if ((fmList.elements[j].type == "text") && (fmList.elements[j].name == ProdId))
      {
      	   if ((fmList.elements[j].value == "") || (fmList.elements[j].value == "0"))
          {
         alert ("请输入订购数量!");
          return;
          }
        else
          fmList.action = "/chinaeoa/AddOrder.jsp?Type=E&LangCode=<%=LangCode%>&ProdId=" + ProdId + "&Qty=" + fmList.elements[j].value;
       }
  }
  //alert("test");
  fmList.method="post";
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
      <td colspan="6" class="font3b">产品配送：</td>
    </tr>
    <tr> 
      <td height="84" colspan="6"> 
        <table width="500" border="0" cellspacing="0" cellpadding="1" bgcolor="#2078CB">
          <tr> 
            <td> 
              <table border="0" cellspacing="1" cellpadding="2" height="64" width="500">
                <tr bgcolor="#FFFFFF" class="font1b"> 
                  <td height="28" nowrap width="50"> 
                    <div align="center">品牌</div>
                  </td>
                  <td height="28" nowrap width="78"> 
                    <div align="center">型号</div>
                  </td>
                  <td height="28" nowrap width="102"> 
                    <div align="center">单价</div>
                  </td>
                  <td height="28" nowrap colspan="2"> 
                    <div align="center">数量</div>
                  </td>
                  <td height="28" width="108" nowrap align="center">送货地址</td>
                  <td height="28" colspan="2" nowrap width="58"> 
                    <div align="center">送货方式</div>
                  </td>
                </tr>
                <%
				Hashtable hash;
                String ShipId = "";
				String ShipMethod = "";
                hash = Order.getHash();
				Enumeration enumProd = hash.keys();
    			Object obj;
 				ResultSet rs;
				String Class = "";
                
    			while (enumProd.hasMoreElements())
    			{		
      			   obj = enumProd.nextElement();
				   ProdId = (String)obj;
				   if (Type.equals("S"))
				   {
					 ShipMethod = request.getParameter("ShipMethod" + ProdId);
				     ShipId = request.getParameter("ShipId" + ProdId); 
				   }
				   else
				   {
                     ShipId = Order.getShip(obj);
					 ShipMethod = Order.getShipMethod(obj);
				   }
				   if (ShipId == null)
					 ShipId = "";
				   else
 				     Order.AddShip(ProdId, ShipId);
				   
				   
				   //ShipMethod = "2";
				   if (ShipMethod == null)
                     ShipMethod = "";
				   else
				     Order.AddShipMethod(ProdId, ShipMethod);
				   Qty = (String)hash.get(obj);
                   rs = Result.getRS("select  p.*, b.name, c.catename,m.class from " +
          			" product p,  brand b, category c, payment m  where " +
          			"  B.lang_code = '" + LangCode + "' and p.brandid = b.brandid  " +
          			" and  p.cateid = c.cateid and c.lang_code = B.lang_code and p.prodid ='" +
           			ProdId + "' and p.supplier = m.supplierid(+) and m.memberid(+) = '" +
					 MemberId + "'");
					
				   if (rs != null)
				   {
					  if (rs.next())
					  {
						Brand = rs.getString("Name");
						ProductNo = rs.getString("ProductNo") + "<br> " + rs.getString("CateName");
						Class = rs.getString("Class");
						if ((Class != null) && (Class.length()>0))
						  Price = rs.getFloat("Price" + Class);
                        else
                          Price = rs.getFloat("ListPrice");
						Total =  Integer.parseInt(Qty) * Price;
						SumTotal = SumTotal + Total;
						
					   }
					}
                %> 
                <tr bgcolor="#FFFFFF"> 
                  <td height="22" width="50"> 
                    <div align="center"><%=Brand%></div>
                  </td>
                  <td height="22" width="78"> 
                    <div align="center"><%=ProductNo%></div>
                  </td>
                  <td height="22" width="102"> 
                    <div align="center"><%="￥" + Price%></div>
                  </td>
                  <td height="22" colspan="2" align="center"> 
                    <div align="center"> </div>
                    <a href="javascript:Update(<%=ProdId%>)"></a><%=Qty%></td>
                  <td width="108" height="22" align="left"> 
                    <select name="ShipId<%=ProdId%>" size="1" >
                      <option value="0" selected>-请选择-</option>
                      <%=LookUp.setLookUp("select s.shipid, " +  " p.Name||c.name||l.address1||l.address2||l.shipname as ShipName " + 
 " from  shipment s , shipment_l l,  city c, province p " +
 " where s.shipid = l.shipid and l.lang_code ='" + LangCode + "' and s.cityid = c.cityid " +
 " and  c.lang_code = l.lang_code and p.ProvinceId =S.ProvinceId and P.Lang_code = " +
 " l.Lang_code and memberid = '" + MemberId + "'","ShipName","ShipId",ShipId)%> 
                    </select>
                  </td>
                  <td colspan="2" height="22" width="58" align="center" bgcolor="#FFFFFF"> 
                    <div align="center"><a href="AddOrder.jsp?Type=D&amp;LangCode=<%=LangCode%>&amp;ProdId=<%=ProdId%>"> 
                      </a> 
                      <select name="ShipMethod<%=ProdId%>">
                        <option value="1" <%if (ShipMethod.equals("")|| ShipMethod.equals("1"))
											  out.println("selected");%>>自提</option>
                        <option value="2" <%if (ShipMethod.equals("2"))
											  out.println("selected");%>>铁路</option>
                        <option value="3" <%if (ShipMethod.equals("3"))
											  out.println("selected");%>>航空</option>
                        <option value="4" <%if (ShipMethod.equals("4"))
											  out.println("selected");%>>汽车</option>
						<option value="5" <%if (ShipMethod.equals("5"))
											  out.println("selected");%>>海运</option>
                      </select>
                    </div>
                  </td>
                </tr>
                <%
				   	  
				    	
    			}
				%> 
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td width="1">&nbsp;</td>
      <td width="270">&nbsp;</td>
      <td width="73">&nbsp; </td>
      <td width="82" align="center"> 
        <input type="button" name="Button" value="保  存" onClick="javascript:Save();">
      </td>
      <td width="47">
        <input type="button" name="Button3" value="返  回" onClick="javascript:window.history.go(-1);">
      </td>
      <td width="78">
        <% if (!Order.getShipHash().isEmpty())
           {
 	        %>
        <input type="button" name="Button2" value="去收银台" onClick="javascript:OrderPre();">
		<%}%>
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<%
LookUp.CloseStm();
Result.CloseStm();
%>
</body>
</html>



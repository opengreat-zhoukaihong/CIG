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
   float Price = 0;
   float Total = 0;
   float SumTotal = 0;
   String Class = "1";
     if (Qty != null && ProdId != null)
     {
       //Order.setMemeberId("1");
       if (Type.equals("A") || Type.equals("E"))
         Order.AddOrder(ProdId, Qty);
       
       //out.println(Order.getSQL());
     }
     if (ProdId != null && Type.equals("D"))
       Order.RemoveProd(ProdId);
       
%> 


<html>
<head>
<script language="JavaScript">
<!--
function OrderPre()
{
  fmList.action="OrderShip.jsp?LangCode=<%=LangCode%>";
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
  <table width="533" border="0" cellspacing="1" cellpadding="2" topmargin="0" align="center">
    <tr> 
      <td colspan="6" class="font3b">您已订购了以下商品：</td>
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
                  <td height="28" nowrap width="104"> 
                    <div align="center">型号</div>
                  </td>
                  <td height="28" nowrap width="100"> 
                    <div align="center">单价</div>
                  </td>
                  <td height="28" nowrap colspan="2"> 
                    <div align="center">数量</div>
                  </td>
                  <td height="28" width="91" nowrap align="center">小计</td>
                  <td height="28" colspan="2" nowrap width="43"> 
                    <div align="center"></div>
                  </td>
                </tr>
                <%
				Hashtable hash;
                hash = Order.getHash();
				Enumeration enumProd = hash.keys();
    			Object obj;
 				ResultSet rs;
                String SQL = "";;

    			while (enumProd.hasMoreElements())
    			{		
      			   obj = enumProd.nextElement();
				   ProdId = (String)obj;
				   Qty = (String)hash.get(obj);
				   SQL = "select  p.*, b.name, c.catename, m.class from " +
          			" product p,  brand b, category c, payment m  where " +
          			"  B.lang_code = '" + LangCode + "' and p.brandid = b.brandid  " +
          			" and  p.cateid = c.cateid and c.lang_code = B.lang_code and p.prodid ='" +
           			ProdId + "' and p.supplier = m.supplierid(+) and m.memberid(+) = '" + MemberId + "'";
                   rs = Result.getRS(SQL);
				   //out.println(SQL);
				   if (rs != null)
				   {
					  if (rs.next())
					  {
						Brand = rs.getString("Name");
						ProductNo = rs.getString("ProductNo") + "<br> " + rs.getString("CateName");
						Class = rs.getString("Class");
                        //out.print(Class+ "|");
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
                  <td height="22" width="104"> 
                    <div align="center"><%=ProductNo%></div>
                  </td>
                  <td height="22" width="100"> 
                    <div align="center"><%="￥" + Price%></div>
                  </td>
                  <td height="22" width="45"> 
                    <div align="center"> 
                      <input type="text"  name="<%=ProdId%>" value="<%=Qty%>" size="4">
                    </div>
                  </td>
                  <td height="22" width="24" align="center"><a href="javascript:Update(<%=ProdId%>)"><font color="#FF0066">修改</font></a></td>
                  <td width="91" height="22" align="right"><%=Total%></td>
                  <td colspan="2" height="22" width="43" align="center" bgcolor="#FFFFFF"> 
                    <div align="center"><a href="AddOrder.jsp?Type=D&amp;LangCode=<%=LangCode%>&amp;ProdId=<%=ProdId%>"><font color="#FF0033">删除</font> 
                      </a></div>
                  </td>
                </tr>
                <%
				   	  
				    	
    			}
				
				%> 
                <tr bgcolor="#FFFFFF"> 
                  <td height="2" align="right" colspan="5"> 
                    <div align="center"></div>
                    合计金额: </td>
                  <td height="2" width="91" align="right"><%=SumTotal%></td>
                  <td height="2" colspan="2" width="43"> 
                    <div align="center"><font size="2" color="#FFFFFF"> </font></div>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td width="1">&nbsp;</td>
      <td width="265">&nbsp;</td>
      <td width="63">&nbsp;</td>
      <td width="73"> 
        <input type="button" name="Button" value="继续选购" onClick="javascript:window.close();">
      </td>
      <td width="73"> <% if (!hash.isEmpty())
                    {
 	        %> 
        <input type="button" name="Button2" value="去收银台" onClick="javascript:OrderPre();">
        <%}%> </td>
      <td width="35">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="6">* 注：</td>
    </tr>
    <tr> 
      <td colspan="6" height="17">----更改商品的数量，请在修改数量栏中重新输入你计划订购的商品数量，然后单击“修改数量”按钮即可</td>
    </tr>
    <tr> 
      <td colspan="6" height="20">----去掉某项商品，可单击商品旁“删除”按钮</td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
</body>
<%Result.CloseStm();%>
</html>



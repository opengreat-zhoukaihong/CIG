<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<jsp:useBean id="ResultSpec" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");
String Category = request.getParameter("Category");

String Brand = request.getParameter("Brand");
String PriceRange = request.getParameter("PriceRange");
String PartProdNo = request.getParameter("PartProdNo");
if (PartProdNo == null)
  PartProdNo = "0";
String ProdId = request.getParameter("ProductNo");
String SQL = "";
String CateName = request.getParameter("CateName");
//String SpecIds[] = {"0","0","0","0","0","0","0","0"};
String SpecId = "";
String SpecValue1 = "";
String wStr = "";
int i;
int SpecCount;
ResultSet rs = null;
ResultSet rsSpec;
//out.println(SQL);
%>
<html><!-- #BeginTemplate "/Templates/ceoa1.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ChinaEOA.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
<script
language="JavaScript">
<!--
function openorder(url)
{   
   OpenWindow=window.open(url, "win1", "height=300 width=600,toolbar=no,scrollbars=yes,menubar=no,resize=yes");
}

function Order(ProdId)
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
          openorder("/chinaeoa/AddOrder.jsp?Type=A&LangCode=<%=LangCode%>&ProdId=" + ProdId + "&Qty=" + fmList.elements[j].value);
       }
  }
  //alert("test");
  //fmList.method="post";
  //fmList.submit();
}

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
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr> 
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<%@ include file="title.jsp"%>
<table width="640" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" colspan="2"><!-- #BeginEditable "body" --> 
      <table border="0" cellspacing="0" cellpadding="0" align="center" width="600">
		<form name="fmList" method="post" >
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" align="center" width="600">
              <tr> 
                <td colspan="2" height="20"> <img src="/images/temp/path.gif" width="49" height="13"> 
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="index.jsp">首页</a> 
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="ProductCentre.jsp?LangCode=GB">产品中心</a> 
                  <img src="/images/arrow.gif" width="7" height="11"> 产品列表</td>
              </tr>
            </table>
            <table border="0" cellspacing="0" cellpadding="0" width="600" align="center">
              <tr align="right"> 
                <td align="left" height="20">
                             <% if (!(TypeId.equals("4")||TypeId.equals("5")))
		          {
                                    rs = Result.getRS("select * from category where typeid=" + TypeId  + " and lang_code='" + LangCode + "' order by cateid");
                    if (rs != null) 
                    {
                      String CategoryName;
                      String CateId;
                      while (rs.next())
                      {
                        out.println("<img src=\"/images/temp/arrow_red.gif\" width=\"7\" height=\"11\">");
                        CategoryName = rs.getString("CateName");
                        CateId = rs.getString("Cateid"); 
                        out.println("<a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=" + TypeId + "&LangCode=GB\">" + CategoryName + "</a>"); 
            
                       
          
                      }
                       
                     }
                                   } 
                  
                  %> </td>
                <td align="right" height="20"><img src="/images/temp/car.gif" width="19" height="16" align="absbottom"> 
                  <a href="#" onClick="openorder('AddOrder.jsp?LangCode=<%=LangCode%>')">查看购物车</a></td>
              </tr>
            </table>
			<%
             if (TypeId.equals("4") || TypeId.equals("5"))
			 {
                out.print(request.getParameter("BrandText"));
                if (!PartProdNo.equals("0") && !PartProdNo.equals(""))
                  out.print("&nbsp;" + PartProdNo);
                else
                {
                  if (request.getParameter("ProductText") != null) 
                    out.print("&nbsp;" + request.getParameter("ProductText"));
                  if (request.getParameter("CateText") != null) 
                    out.print("&nbsp;" + request.getParameter("CateText"));
                 }
			
			  }
			%>
            <br>

            <table border="0" cellspacing="2" cellpadding="2" boder="thin mediun thick none" align="center" width="600">
              <tr align="center"> 
                <td bgcolor="#99CCFF"> <a name="one"></a>
				<%
                if (TypeId.equals("4") || TypeId.equals("5"))
                  out.print("产品名称");
				else
				  out.print("品牌");
                %></td>
               
                <td bgcolor="#99CCFF"> 
                <% 
                  if (TypeId.equals("4") || TypeId.equals("5") || TypeId.equals("6"))
                    out.println("零件编号");
                  else
                    out.println("型号");
                %>
                
                </td>
                
                <%
                
                SpecCount = 0;
                rs = Result.getRS("select * from spec where typeid =" + TypeId + " and query= 'A' and lang_code = '" + LangCode  + "' order by specid");
                //out.println("select * from spec where typeid =" + TypeId + " and query= 'A' and lang_code = '" + LangCode  + "' order by specid");
                SQL = "";
                if (rs != null)
                {
                  if (rs.next())
                  {
                    //SpecIds[SpecCount] = rs.getString("SpecId");
		           SpecId = rs.getString("SpecId");

                   
                   out.println("<td bgcolor=\"#99CCFF\">" + rs.getString("Name")  + "</td>");
			
                  }
                }
                if (SQL != "")
                {
                  /*SQL = "(" + SQL + ") s";
                  SQL = "select  l.shortdesc, l.descr, p.*, b.name, c.catename from product p, product_l l, brand b, category c, "
                    + SQL + " where p.prodid = l.prodid and l.lang_code = '" + LangCode + "' and p.brandid = b.brandid and b.lang_code = l.lang_code "
                    + " and p.Status='Y' and p.cateid = c.cateid and c.lang_code = l.lang_code and p.prodid = s.prodid";
			*/
                }
                else
                { 
                  if (TypeId.equals("4") || TypeId.equals("5"))
                  {
                     SQL = "select p.*, s.specid,s.value1,s.unit s_unit,l.prod_name, l.shortdesc, l.descr,  b.name, c.catename from prod_part pp, product p, product_l l, brand b, category c, prod_spec s "
                      + " where p.Status='Y' and pp.partprodid(+) = p.prodid and p.prodid = l.prodid and l.lang_code = '" + LangCode + "' and p.brandid = b.brandid and b.lang_code = l.lang_code "
                      + " and  p.cateid = c.cateid and c.lang_code = l.lang_code and p.prodid = s.prodid(+) and s.specid(+) = '" +  SpecId +  "'";
                  }
				  else
				  {
                    SQL = "select p.*, s.specid,s.value1,s.unit s_unit, l.shortdesc, l.descr,  b.name, c.catename from product p, product_l l, brand b, category c, prod_spec s "
                      + " where p.Status='Y' and p.prodid = l.prodid and l.lang_code = '" + LangCode + "' and p.brandid = b.brandid and b.lang_code = l.lang_code "
                      + " and  p.cateid = c.cateid and c.lang_code = l.lang_code and p.prodid = s.prodid(+) and s.specid(+) = '" +  SpecId +  "'";
				  }
                }

                wStr = "";
                //out.println(TypeId);
		// if (!TypeId.equals("0"))
                //  wStr = " and  p.TypeID = '" + TypeId + "'";
                if (!Brand.equals("0"))
                  wStr = wStr + " and  p.BrandID = '" + Brand + "'";
                if (Category != null && !Category.equals("0"))
                  wStr = wStr + " and  p.CateId = '" + Category + "'";
                if (PriceRange == null)
		      PriceRange = "0";
                if (!PriceRange.equals("0"))
                {
                  i = PriceRange.indexOf("~");
                  wStr = wStr + " and  p.ListPrice >= " + PriceRange.substring(0,i).trim()
                    + " and  p.ListPrice <= " + PriceRange.substring(i + 1).trim();
                }
                            if (ProdId != null)
                { 
 		       if (!ProdId.equals("0"))
                                 wStr = wStr + " and pp.prodId = '" + ProdId + "' ";
                             }
                             if (!PartProdNo.equals("0") && !PartProdNo.equals(""))
                {
  		        PartProdNo = "'%" + PartProdNo + "%'";
		        if (!PartProdNo.equals("'%%'"))
                                  wStr = wStr + " and p.ProductNo like " + PartProdNo;
 		     }
                SQL = SQL + wStr + " order by p.brandid, p.cateid,to_number(s.value1), p.productNo";
                            
		    //out.println(PartProdNo);

                //out.println(SQL);
                %>

                <td bgcolor="#99CCFF"> 价格</td>
                <td bgcolor="#99CCFF"> 订购数量</td>
                <td nowrap bgcolor="#99CCFF"> 放进购物车</td>

              </tr>
              <%
              rs = Result.getRS(SQL);
              
              String ColorName = "#F4FCFF";
              boolean IsColor = false;
              boolean HasRecord = false;
              String BrandName ="";
              if (rs != null)
              {
                while (rs.next())
                {
                  HasRecord = true;
                  if (IsColor)
                  {
                    IsColor = false;
                    ColorName = "#F4FCFF";
                  }
                  else
                  {
                    IsColor = true;
                    ColorName = "#DFEEFF";
                  }
                  ProdId = rs.getString("ProdId");
                  %>
                  <tr>
                    <td bgcolor="<%=ColorName%>" align="center"> 
                      <% if (TypeId.equals("4") || TypeId.equals("5"))
						 { 
			   if (rs.getString("Prod_Name") != null)
                             out.println(rs.getString("Prod_Name"));
                           else
                             out.println(rs.getString("CateName")); 
                          }
                         else
                         {
						   if (!BrandName.equals(rs.getString("Name")))
						   {
     					     BrandName = rs.getString("Name");
                             out.println(BrandName);
                            }
						  }
                       %></td>
                    <td bgcolor="<%=ColorName%>" align="left"> <font color="#333333">
                     <a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=<%=LangCode%>">
                      <%if (TypeId.equals("4") || TypeId.equals("5"))
                          out.print(rs.getString("ProductNo"));
                        else
                          out.print(rs.getString("ProductNo") + " " + rs.getString("CateName"));%></a></font></td>
                    <%
                    /*for (i=0; i<SpecCount; i++)
                    {
                      rsSpec = ResultSpec.getRS("select value1, value2 from prod_spec where prodid = " + ProdId  + " and specid = " + SpecIds[i] );
                      //out.println("select value1, value2 from prod_spec where prodid = " + ProdId  + " and specid = " + SpecIds[i]);
                      if (rsSpec != null)
                      {
                        while (rsSpec.next())
                        {
                          SpecValue1 = rsSpec.getString("Value1");
                        }
                      }
                      else
                      {
                        out.println("select value1, value2 from prod_spec where prodid = " + ProdId  + " and specid = " + SpecIds[i]);
                      }
                      out.println("<td bgcolor=\"" + ColorName + "\" align=\"center\">" + SpecValue1 + "</td>");
                    }
			*/
                    %>
			<%
			 if ((SpecId != null) && (SpecId != ""))
                                     {	
			    %>
			    <td bgcolor="<%=ColorName%>" align="center">
			    <%
 			    if ((rs.getString("Value1") != null) && (rs.getString("s_unit") != null))
			    {  
			       out.println(rs.getString("Value1") + " " + rs.getString("s_unit"));
			    }
			    else if (rs.getString("value1") != null)
                      		      out.println(rs.getString("Value1"));
			    %>
			    </td>
			    <%
			}
			%>

                    <td bgcolor="<%=ColorName%>" align="right">
                                     <%if (rs.getString("ListPrice") != null && !rs.getString("ListPrice").equals("0"))
         				  		out.println("￥" + rs.getString("ListPrice") + ".00");
			    		        else
                                           				out.println("面议");

                                      %></td>
                    <td bgcolor="<%=ColorName%>" align="center"><input type="text" name="<%=rs.getString("ProdId")%>" size="3"></td>
                    <td bgcolor="<%=ColorName%>" align="center">
                    <a href="javascript:Order(<%=rs.getString("ProdId")%>);"> 
                                            <img src="/images/temp/b_ok.gif" name="Submit1" value="确定" width="41" height="17" border="0"></a>
                   </td>
                 </tr>
                 <%
                }
               if  (HasRecord == false) 
                             out.println("<center>暂无符合要求的产品,请再选择!</center>");
               //out.println(SQL);
                         }
              %>
              
            </table>
            <table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr align="center"> 
                <td height="30"><a href="#top"><img src="/images/temp/top.gif" width="60" height="17" border="0"></a></td>
              </tr>
            </table>
          </td>
        </tr>
	  </form>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot1.js">
</script>
<%
ResultSpec.CloseStm(); 
Result.CloseStm();
%>

</body>
<!-- #EndTemplate --></html>

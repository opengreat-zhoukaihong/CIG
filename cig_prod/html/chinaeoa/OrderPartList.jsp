<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<jsp:useBean id="ResultSpec" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");
String MainProd = request.getParameter("MainProd");
String Category = "";
String Brand = "";
String PriceRange = "";
String PartProdNo = "";
if (PartProdNo == null)
  PartProdNo = "0";
String ProdId = request.getParameter("ProductNo");
String SQL = "";
String CateName = "";
//String SpecIds[] = {"0","0","0","0","0","0","0","0"};
String SpecId = "";
String SpecValue1 = "";
String wStr = "";
int i;
int SpecCount;
ResultSet rs;
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
                    <img src="/images/arrow.gif" width="7" height="11"> <a href="OrderOnLine.jsp?LangCode=GB">在线订购</a> 
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
              <font color="#003399">主产品：<%=MainProd%></font><br>

            <table border="0" cellspacing="2" cellpadding="2" boder="thin mediun thick none" align="center" width="600">
              <tr align="center"> 
                <td bgcolor="#99CCFF"> <a name="one"></a>品牌</td>
               
                <td bgcolor="#99CCFF"> 型号</td>
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
            
               SQL = "select  p.*, s.*,  l.shortdesc, l.descr, b.name, c.catename from product p, product_l l, brand b, category c, prod_spec s, prod_part pp "
                    + " where p.prodid = l.prodid and l.lang_code = '" + LangCode + "' and p.brandid = b.brandid and b.lang_code = l.lang_code "
                    + " and  p.cateid = c.cateid and c.lang_code = l.lang_code and p.prodid = s.prodid(+) and s.specid(+) = '" +  SpecId +  "' and P.prodid = PP.partProdId and PP.prodid = '" + ProdId + "' and p.TypeId = " + TypeId;
               
                wStr = "";
  
                            
		

                //out.println(SQL);
                %>

                <td bgcolor="#99CCFF"> 价格(元)</td>
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
                      <% if (!BrandName.equals(rs.getString("Name")))
						 {
     					   BrandName = rs.getString("Name");
                           out.println(BrandName);
                          }
                       %></td>
                    <td bgcolor="<%=ColorName%>" align="center"> <font color="#333333">
                     <a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=<%=LangCode%>">
                      <%= rs.getString("ProductNo") + rs.getString("CateName")%></a></font></td>
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
 			    if ((rs.getString("unit") != null) && (rs.getString("unit") != null))
			    {  
			       out.println(rs.getString("Value1") + " " + rs.getString("unit"));
			    }
			    else if (rs.getString("value1") != null)
                      		      out.println(rs.getString("Value1"));
			    %>
			    </td>
			    <%
			}
			%>

                    <td bgcolor="<%=ColorName%>" align="center">
                                     <%if (rs.getString("ListPrice") != null) 
                                           out.println(rs.getString("ListPrice"));
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
                             out.println("<center>没有符合要求的产品,请再选择!</center>");
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
<%if (ResultSpec.CloseStm()) 
        out.println("");%>
<%if (Result.CloseStm()) 
        out.println("");%>

</body>
<!-- #EndTemplate --></html>

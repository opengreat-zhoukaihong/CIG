<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<jsp:useBean id="ResultSpec" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");
String Category = request.getParameter("Category");
String Brand = request.getParameter("BrandId");
String PriceRange = request.getParameter("PriceRange");
String ProdId="";
String SQL = "";
String CateName = request.getParameter("CateName");
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
<script language="JavaScript">
function opendealer(url)
    {   
        OpenWindow=window.open(url, "newwin", "width=320,toolbar=no,scrollbars=yes,menubar=no");
}
function openorder(url)
    {   
        OpenWindow=window.open(url, "win1", "height=300 width=600,toolbar=no,scrollbars=yes,menubar=no,resize=yes");
}
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
      <table border="0" cellspacing="0" cellpadding="1" height="230" width="640">
        <tr> 
          <td valign="top"> 
            <table width="150" border="0" cellspacing="0" cellpadding="0" height="20">
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table>
            <table width="80" border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="#217ACE">
              <tr> 
                <td> 
                  <table width="150" border="0" cellspacing="1" cellpadding="0" align="center">
                    <tr align="center" bgcolor="#217ACE"> 
                      <td colspan="2" class="font3b" height="30"><font color="#FFFFFF">品牌列表</font></td>
                    </tr>
                    <%
                    rs = Result.getRS("select b.*, bb.name ename from brand b, brand bb " 
       					+ " where b.brandid = bb.brandid and b.lang_code ='" + LangCode + "' and bb.lang_code <> b.Lang_code order by b.brandId");
                    if (rs != null) 
                    {
                      while (rs.next())
                      {
                       %> 
                    <tr align="left" bgcolor="#FFFFFF"> 
                      <td height="25"  colspan="2"> <a href="BrandList.jsp?LangCode=<%=LangCode%>&TypeId=3&BrandId=<%=rs.getString("BrandId")%>"> 
                        <%
                          if (rs.getString("Name").length() == 4)
                            out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + rs.getString("Name") + " " + rs.getString("EName"));
                          else if (rs.getString("Name").length() == 6)
                            out.print("&nbsp;&nbsp;&nbsp;&nbsp;" + rs.getString("Name") + " " + rs.getString("EName"));
                          else
                            out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + rs.getString("Name") + " " + rs.getString("EName"));
                          %></a></td>
                    </tr>
                    <%
                       }
                     }
                     %> 
                  </table>
                </td>
              </tr>
            </table>
            <br>
            <br>
          </td>
          <td valign="top"> 
            <table width="400" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>
                  <table border="0" cellspacing="0" cellpadding="0" width="460" align="center">
                    <tr> 
                      <td height="20" colspan="2">
                        <table border="0" cellspacing="0" cellpadding="0" width="460">
                          <tr> 
                            <td height="20" width="227"><img src="/images/temp/path.gif" width="49" height="13"> 
                              <img src="/images/arrow.gif" width="7" height="11"> 
                              <a href="index.jsp">首页</a> <img src="/images/arrow.gif" width="7" height="11"> 
                              <a href="ProductCentre.jsp?LangCode=GB">产品中心</a> 
                              <img src="/images/arrow.gif" width="7" height="11"> 
                              品牌专柜 </td>
                            <td align="right" height="20" width="233"><img src="/images/temp/car.gif" width="19" height="16" align="absbottom"> 
                              <a href="#" onClick="openorder('AddOrder.jsp?LangCode=<%=LangCode%>')">查看购物车</a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  
                </td>
              </tr>
              <tr>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0" height="300">
					<form name="fmList" method="post" >
                    <tr valign="top" align="center"> 
                      <td> 
                        <table border="0" cellspacing="0" cellpadding="0" height="300">
                          <tr> 
                            <td height="61" align="center"> 
                              <table border="0" cellspacing="0" cellpadding="0" width="486">
                                <tr valign="top"> 
                                    <td><img src="/images/temp/p_title.gif" width="486" height="61" usemap="#MapMap" border="0"> 
                                      <map name="MapMap"><area shape="circle" coords="446,33,27" href="ProductSearch.jsp?TypeId=5&amp;LangCode=GB"> 
                                        <area shape="circle" coords="382,31,28" href="ProductSearch.jsp?TypeId=4&amp;LangCode=GB"> 
                                        <area shape="circle" coords="316,30,28" href="ProductSearch.jsp?TypeId=8&amp;LangCode=GB"> 
                                        <area shape="circle" coords="247,31,27" href="ProductSearch.jsp?TypeId=2&amp;LangCode=GB"> 
                                        <area shape="circle" coords="177,29,26" href="ProductSearch.jsp?TypeId=1&amp;LangCode=GB"> 
                                        <area shape="circle" coords="106,29,25" href="ProductSearch.jsp?TypeId=3&amp;LangCode=GB"></map></td>
                                </tr>
                              </table>
                              <br>
                            </td>
                          </tr>
                          <tr align="right"> 
                            <td valign="top" height="16"> 
                              <table width="476" border="0" cellspacing="2" cellpadding="2">
                                <tr align="right" valign="middle"> 
                                  <td align="left" width="18"> <%
                                   rs = Result.getRS("Select * from Brand where Lang_code='" + LangCode + "' and brandid = '" + Brand + "'");
                                   if (rs != null)
                                   {
                                     if (rs.next())
             						 {	
                                       if (rs.getString("FileName") != null)
                                         out.println("<img src=\"../images/BrandLogo/"  + rs.getString("FileName")   + "\" " +
                                          " width=\"80\" height=\"22\" border=\"0\" alt=\""+ rs.getString("Name") + "\" align=\"left\">");
                                       else
                                         out.println("<font color=\"#FFFFFF\"><b>" + rs.getString("Name") + "</b></font>");
                                      }
                                   }
					
                                  %> </td>
                                  <td align="left" width="444"><font color="#333333"> 
                                    <%                    
			rs = Result.getRS("select * from prod_type where lang_code='" + LangCode + "' order by Typeid");
                    if (rs != null) 
                    {
                      String TypeName;
                      String wTypeId;
                      while (rs.next())
                      {
                        out.println("<img src=\"/images/temp/arrow_red.gif\" width=\"7\" height=\"11\">");
                        TypeName = rs.getString("Name");
                        wTypeId = rs.getString("Typeid");
			      if (wTypeId.equals(TypeId))
                            out.println("<a href=\"BrandList.jsp?TypeId=" + 
                               wTypeId + "&LangCode=" + LangCode + "&BrandId=" + 
                                Brand + "\"><font color=\"#0033CC\">" + TypeName + "</font> </a>");
			      else
				out.println("<a href=\"BrandList.jsp?TypeId=" + 
                               wTypeId + "&LangCode=" + LangCode + "&BrandId=" + 
                                Brand + "\">" + TypeName + "</a>");
 
            
                       
          
                      }
                       
                     }
		      
                  
                  %></font></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" align="center"> 
                              <table width="486" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td width="65"><img src="/images/spacer.gif" width="10" height="1"></td>
                                  <td> 
                                    <table border="0" cellspacing="2" cellpadding="2" align="center" width="476">
                                      <tr align="center"> 
                                        <td nowrap bgcolor="#99CCFF">类型系列</td>
                                        <td bgcolor="#99CCFF">
                <% 
                  if (TypeId.equals("4") || TypeId.equals("5") || TypeId.equals("6"))
                    out.println("零件编号");
                  else
                    out.println("型号");
                %></td>
                <%
                if (TypeId.equals("4"))
                  out.println("<td bgcolor=\"#99CCFF\"> 主产品型号</td>");
                SpecCount = 0;
                rs = Result.getRS("select * from spec where typeid = " + TypeId + "  and query= 'A' and lang_code = '" + LangCode  + "' order by specid");
                //out.println("select * from spec where typeid =" + TypeId + " and query= 'A' and lang_code = '" + LangCode  + "' order by specid");
                SQL = "";
                if (rs != null)
                {
                  if (rs.next())
                  {
                    //SpecIds[SpecCount] = rs.getString("SpecId");
			SpecId = rs.getString("SpecId");

                    //SpecValue1 = request.getParameter(SpecIds[SpecCount]);
                    //if (SpecValue1 == null)
                    //  SpecValue1 = "0";
                   //SpecCount++;
                   out.println("<td bgcolor=\"#99CCFF\">" + rs.getString("Name")  + "</td>");

                  }
                }

                //out.println(SQL);
                %>

                <td bgcolor="#99CCFF"> 价格</td>
                <td bgcolor="#99CCFF"> 订购数量</td>
                <td nowrap bgcolor="#99CCFF"> 放进购物车</td>

              </tr>
               <%
              rs = Result.getRS("select  p.*, s.specid, s.value1,s.unit s_unit,l.shortdesc, l.descr,b.name, " + 
                    " c.catename from product p, product_l l, brand b, category c, prod_spec s  " + 
                    " where p.Status='Y' and p.prodid = l.prodid and l.lang_code = '" + LangCode + "' and " + 
                    " p.brandid = b.brandid and b.lang_code = l.lang_code and  " +
		           " p.prodid = s.prodid(+) and s.specId(+) = '" + SpecId + "' and  " +
                    " p.brandId = '" + Brand +  "' and " +
                    " p.cateid = c.cateid and c.lang_code = l.lang_code and p.typeid = " + TypeId +
                    " order by p.Cateid, to_number(s.value1), p.ProductNo " );
              String ColorName = "#F4FCFF";
              boolean IsColor = false;
                         boolean HasRecord = false;
		CateName = "";
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
          			<% if (!CateName.equals(rs.getString("CateName")))
						 {
     					   CateName = rs.getString("CateName");
                           out.println(CateName);
                          }
                       %></td>
                    <td bgcolor="<%=ColorName%>" align="left"> <font color="#333333">
                     <a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=<%=LangCode%>">
                      <%= rs.getString("ProductNo")%></a></font></td>
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
 			    if ((rs.getString("value1") != null) && (rs.getString("s_unit") != null))
			    {  
			       out.println(rs.getString("Value1") + " " + rs.getString("s_unit"));
			    }
			    else if (rs.getString("value1") != null)
                      		      out.println(rs.getString("Value1"));
			    %>
			    </td>
			    <%
			}
			if (TypeId.equals("4"))
			{
			  out.println("<td bgcolor=" + ColorName + 
			       		" align=\"center\">");
			  rsSpec = ResultSpec.getRS("Select p.productNo from product p, prod_part pp " +
			           " where pp.prodid = p.prodid and pp.partprodid = " + ProdId );
			  //out.println("Select p.productNo from product p, prod_part pp " +
			  //         " where pp.prodid = p.prodid and pp.partprodid = " + ProdId );
			  if (rsSpec != null)
			  {
			    while (rsSpec.next())
			    {
			       out.println(rsSpec.getString("ProductNO") + "&nbsp;");
			    }
			  } 
			  out.println("&nbsp;</td>");
			  
			}
			%>
			

                    <td bgcolor="<%=ColorName%>" align="right">
                      <%if (rs.getString("ListPrice") != null && !rs.getString("ListPrice").equals("0"))
         				  out.println("￥" + rs.getString("ListPrice") + ".00&nbsp");
			    else
                                           out.println("面议");

                       %></td>
                    <td bgcolor="<%=ColorName%>" align="center"><input type="text" name="<%=rs.getString("ProdId")%>" size="3"></td>
                                          <td bgcolor="<%=ColorName%>" align="center"><a href="javascript:Order(<%=rs.getString("ProdId")%>);"> 
                                            <img src="/images/temp/b_ok.gif" name="ok" value="确定" width="41" height="17"  border="0"></a>
                   </td>
                 </tr>
                 <%
                }
              }
                         if  (HasRecord == false) 
                             out.println("<center>暂无产品,请再选择!</center>");

              %>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </form>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="330" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr align="center"> 
                      <td><a href="/guide.htm">订购指南</a> | <a href="/service.htm">售后服务</a> 
                        | <a href="/about.htm#contactus">联系我们 </a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> 
    </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>
<%
 Result.CloseStm();   
 ResultSpec.CloseStm();     
%>

</body>
<!-- #EndTemplate --></html>

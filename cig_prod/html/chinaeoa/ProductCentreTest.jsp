<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
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
<script language="JavaScript">
function opendealer(url)
    {   
        OpenWindow=window.open(url, "newwin", "width=320,toolbar=no,scrollbars=yes,menubar=no");
}
function openorder(url)
    {   
        OpenWindow=window.open(url, "win1", "height=300 width=550,toolbar=no,scrollbars=yes,menubar=no,resize=yes");
}
</script>
</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr> 
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<%@ include file="titletest.jsp"%>
<table width="640" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" colspan="2"><!-- #BeginEditable "body" --> 
      <table border="0" cellspacing="0" cellpadding="1" height="230" width="640">
        <tr> 
          <td valign="top"> 
            <table width="100" border="0" cellspacing="0" cellpadding="0" height="20">
              <tr>
                <td><font color="#FFFFFF">sf</font></td>
              </tr>
            </table>
            <table width="80" border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="#217ACE">
              <tr> 
                <td> 
                  <table width="150" border="0" cellspacing="1" cellpadding="0" align="center">
                    <tr align="center" bgcolor="#217ACE"> 
                      <td class="font3b" height="30"><font color="#FFFFFF">品牌列表</font></td>
                    </tr>
                    <%
                    String LangCode = request.getParameter("LangCode");
                    ResultSet rs = Result.getRS("select b.*, bb.name ename from brand b, brand bb " 
       					+ " where b.brandid = bb.brandid and b.lang_code ='" + LangCode + "' and bb.lang_code <> b.Lang_code order by b.brandId");
                    if (rs != null) 
                    {
                      while (rs.next())
                      {
                       %>
                        <tr align="center" bgcolor="#FFFFFF"> 
                        <td height="25" > <a href="BrandList.jsp?LangCode=<%=LangCode%>&TypeId=3&BrandId=<%=rs.getString("BrandId")%>">
                          <%=rs.getString("Name") + ":" + rs.getString("EName")%></a></td>
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
                              产品中心 </td>
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
                    <tr valign="top" align="center"> 
                      <td> 
                        <table border="0" cellspacing="0" cellpadding="0" width="486">
                          <tr valign="top"> 
                            <td><img src="/images/temp/p_title.gif" width="486" height="61" usemap="#Map" border="0"><map name="Map"><area shape="circle" coords="447,31,27" href="ProductSearch.jsp?TypeId=5&amp;LangCode=GB"><area shape="circle" coords="380,31,28" href="ProductSearch.jsp?TypeId=4&amp;LangCode=GB"><area shape="circle" coords="316,30,28" href="ProductSearch.jsp?TypeId=2&amp;LangCode=GB"><area shape="circle" coords="248,31,27" href="ProductSearch.jsp?TypeId=2&amp;LangCode=GB"><area shape="circle" coords="178,29,26" href="ProductSearch.jsp?TypeId=1&amp;LangCode=GB"><area shape="circle" coords="106,28,25" href="ProductSearch.jsp?TypeId=3&amp;LangCode=GB"></map></td>
                          </tr>
                        </table>
                        <br>
                        <% 
					     rs = Result.getRS("select p.Prodid, p.productNo,p.listprice, b.name, b.Filename as bFilename, c.catename,d.dir,s.filename1 from product p, " + 
  						   " brand b, category c, speci_sale s, dir_setting d " +
 						   " where p.brandid = b.brandid and b.lang_code = 'GB' " + 
						   " and  p.cateid = c.cateid and c.lang_code = b.lang_code " + 
						   " and p.prodid = s.prodid and s.location='P' " +
						   " and s.picdir1 = d.dirid(+)");
                           //rs = null;
   					     if (rs!=null)
                         {

						   
                           if (rs.next())
                           {
					       %>
                        <table width="347" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"> 
                              <img src="<%="../images/BrandLogo/"+rs.getString("bFilename")%>" width="80" height="21" border="0" ></a></td>
                          </tr>
                          <tr> 
                            <td> 
                              <table width="347" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td> 
                                    <table width="346" border="0" cellspacing="0" cellpadding="0" background="/images/temp/hot_bg.gif" height="104">
                                      <tr> 
                                        <td align="center"><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB">
                                        <img src="<%
                                    String FileName = "";
                                    if (rs.getString("Dir") == null)
                                      FileName = "../images/hots/" + rs.getString("FileName1");
									else
    								  FileName = "/" + rs.getString("Dir") + rs.getString("FileName1");
									out.println(FileName);
                                 %>" width="149" height="89" border="0"></a></td>
                                        <td align="center"> 
                                          <table width="160" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                                              <td><%=rs.getString("name")%></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                              <td><%=rs.getString("ProductNo")+rs.getString("catename")%></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                              <td><%="价格:" + rs.getString("listPrice") + "元"%></td>
                                            </tr>
                                            <tr align="center"> 
                                              <td colspan="2" height="30"> 
                                                <table width="160" border="0" cellspacing="0" cellpadding="0">
                                                  <tr align="center"> 
                                                    <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&amp;LangCode=GB">
                                                      <img src="/images/temp/b_detail.gif" width="44" height="17" border="0"></a></td>
                                                    <td><a href="#"><img src="/images/temp/b_buy.gif" width="44" height="17" border="0"></a></td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                          </tr>
                        </table>
                         <% 
                          }
                          if (rs.next())
                          {
                          %>
                        <table width="347" border="0" cellspacing="0" cellpadding="0">
                          <tr align="right"> 
                            <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"><img src="<%="../images/BrandLogo/"+rs.getString("bFilename")%>" width="80" height="21" border="0" ></a></td>
                          </tr>
                          <tr> 
                            <td> 
                              <table width="347" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td> 
                                    <table width="346" border="0" cellspacing="0" cellpadding="0" background="/images/temp/hot_bg.gif" height="104">
                                      <tr> 
                                        <td align="center">
                                          <table width="160" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                                              <td><%=rs.getString("name")%></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                              <td> <%=rs.getString("ProductNo")+rs.getString("catename")%></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                              <td><%="价格:" + rs.getString("listPrice")+ "元"%></td>
                                            </tr>
                                            <tr align="center"> 
                                              <td colspan="2" height="30"> 
                                                <table width="160" border="0" cellspacing="0" cellpadding="0">
                                                  <tr align="center"> 
                                                    <td><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&amp;LangCode=GB"><img src="/images/temp/b_detail.gif" width="44" height="17" border="0"></a></td>
                                                    <td><a href="#"><img src="/images/temp/b_buy.gif" width="44" height="17" border="0"></a></td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                        <td align="center"><a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"><img src="<%
                                    String FileName = "";
                                    if (rs.getString("Dir") == null)
                                      FileName = "../images/hots/" + rs.getString("FileName1");
									else
    								  FileName = "/" + rs.getString("Dir") + rs.getString("FileName1");
									out.println(FileName);
                                 %>" width="149" height="89" border="0"></a> </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                          </tr>
                        </table>
                      <%
                         }
                       }%>
                      </td>
                    </tr>
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
<%if (Result.CloseStm()) 
        out.println("");%>

</body>
<!-- #EndTemplate --></html>

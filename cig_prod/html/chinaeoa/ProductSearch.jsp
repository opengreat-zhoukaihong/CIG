<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");
String SQL = "";
String SelectName = "";
String DisplayField = "";
String ValueField = "";
String SpecId = "";
String SpecName = "";
String onLoad = "";
SQL = "select * from spec where lang_code ='" + LangCode + "' and  typeid = '" + TypeId + "' and query = 'A' order by specID";
ResultSet rs;
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

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

//-->
</script>
<%
if (TypeId.equals("4") || TypeId.equals("5"))
{
%>


<script language="JavaScript">
<!--

function Post()
{
  var wAction = "";
  if (fmSearch.Brand.value == "0" || fmSearch.Brand.value == "")
  {
    alert("请选择品牌");
    return false;
  }
  
  fmSearch.BrandText.value = fmSearch.Brand.options[fmSearch.Brand.selectedIndex].text; 
  if (fmSearch.ProductNo.value != "0" && fmSearch.ProductNo.value != "")
    fmSearch.ProductText.value = fmSearch.ProductNo.options[fmSearch.ProductNo.selectedIndex].text; 
  else
    fmSearch.ProductText.value = "";
  if (fmSearch.Category.value != "0" && fmSearch.Category.value != "")
    fmSearch.CateText.value = fmSearch.Category.options[fmSearch.Category.selectedIndex].text; 
  else
    fmSearch.CateText.value = "";
  //fmSearch.sumit();
  //alert(fmSearch.ProductText.value + fmSearch.CateText.value);
  fmSearch.action = "SearchProdList.jsp?LangCode=GB&TypeId=<%=TypeId%>";
  return true;
    
}


provinceArrayN = new Array(
<%=LookUp.getDynamicLookUp("select p.brandId,p.productno,P.prodid from product p ," + 
" brand b where p.brandid = b.brandid and b.lang_code = '" + LangCode  + "' and p.Typeid in (1,2,3,7,8) order by brandid",3)%>);
  //cityArray = new Array("1.1.guangzhou.1","1.1.shenzheng.2","1.2.xiamen.3","1.2.fuzhou.4");
  dropDownItemN = new String();

  function changeProvinceInfoN(countryBox,provinceBox)
  {
    var countryItem = countryBox.selectedIndex;
    var itemCount;

    if(countryItem>0)
    {
      provinceBox.length=1;
      //cityBox.length=1;
      for(var i=0;i<provinceArrayN.length;i++)
      {
        dropDownItemN = provinceArrayN[i].split(".");
        if(countryItem==dropDownItemN[0])
        {
          itemCount = provinceBox.length;
          provinceBox.length += 1;
          provinceBox.options[itemCount].value = dropDownItemN[2];
          provinceBox.options[itemCount].text = dropDownItemN[1];
        }
      }
      if((document.fmSearch.NewProductNo.value==null)||(document.fmSearch.NewProductNo.value==""))
        provinceBox.selectedIndex = 1;
      else
        provinceBox.selectedIndex = document.fmSearch.NewProductNo.value;
    }
    else
    {
      provinceBox.selectedIndex = 1;
      //cityBox.selectedIndex = 1;
      provinceBox.length=1;
      //cityBox.length=1;
    }
  }

function saveProvinceN()
{
  document.fmSearch.NewProductNo.value =     document.fmSearch.ProductNo.selectedIndex;
}

 

  function initAreaN()
  {
    	changeProvinceInfoN(document.fmSearch.Brand,document.fmSearch.ProductNo);

  }
//-->
</script>
<%
  
  
}
if (TypeId.equals("4") || TypeId.equals("5"))
    onLoad = "onLoad = \"initAreaQ();initAreaN()\"";
else
    onLoad = "onLoad = \"initAreaQ()\"";
%>




</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif" <%=onLoad%> >
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
      <table border="0" cellspacing="0" cellpadding="0" width="626">
        <tr> 
          <td width="190" valign="top"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr valign="top"> 
                <td><img src="/images/temp/product_menu.gif" width="176" height="242" usemap="#Map" border="0"><map name="Map"><area shape="circle" coords="86,51,19" href="ProductSearch.jsp?TypeId=3&LangCode=GB"><area shape="circle" coords="86,111,23" href="ProductSearch.jsp?TypeId=1&LangCode=GB"><area shape="circle" coords="84,168,22" href="ProductSearch.jsp?TypeId=2&LangCode=GB"><area shape="circle" coords="35,88,24" href="ProductSearch.jsp?TypeId=8&amp;LangCode=GB"><area shape="circle" coords="32,145,24" href="ProductSearch.jsp?TypeId=4&LangCode=GB"><area shape="circle" coords="31,202,24" href="ProductSearch.jsp?TypeId=5&amp;LangCode=GB"></map></td>
              </tr>
            </table>
          </td>
          <td align="center" width="269" valign="top"> 
            <table width="250" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="2" height="20"> <img src="/images/temp/path.gif" width="49" height="13"> 
                  <img src="/images/arrow.gif" width="7" height="11"> <a href="index.jsp">首页</a> 
                  <img src="/images/arrow.gif" width="7" height="11"> <font title="里边有什么好东西呢"><a href="ProductCentre.jsp?LangCode=GB">产品中心</a> 
                  </font></td>
              </tr>
            </table>
            <table border="0" cellspacing="1" width="250">
              <form name="fmSearch" method="post"  
              <% if (TypeId.equals("4") || TypeId.equals("5"))
              	   out.print("onSubmit=\"return Post()\"");
                 else
                   out.print("action=\"SearchProdList.jsp?LangCode=GB&TypeId=" + TypeId + "\""); %>
              >
                <tr align="center"> 
                  <td colspan="2" height="30" class="font4b"> <% if (TypeId.equals("1"))
                       out.println("打印机展示");
                     else if (TypeId.equals("2"))
                       out.println("传真机展示");
                     else if (TypeId.equals("3"))
                       out.println("复印机展示");
                     else if (TypeId.equals("4"))
                       out.println("耗材供应");
                     else if (TypeId.equals("5"))
                       out.println("零件供应");
                     else if (TypeId.equals("6"))
                       out.println("选购件供应");
                     else if (TypeId.equals("8"))
                       out.println("扫描仪展示");


                  %>中心 </td>
                </tr>
                            <%if (!(TypeId.equals("4") || TypeId.equals("5")))
                                  {
			%>
                <tr><td colspan="2">
                  <%rs = Result.getRS("select * from category where typeid=" + TypeId  + " and lang_code='" + LangCode + "' order by cateid");
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
                  
                  %>
                  </td>
               </tr>
		     <%
                         }%>
                          <tr><td colspan="2">&nbsp;</td></tr>
                <tr> 
                  <td width="70">品牌</td>
                  <td width="174"><font size="2"> 
                    <select name="Brand" size="1" 
                                       <%if (TypeId.equals("4") || TypeId.equals("5"))
                                               out.println("onChange=\"changeProvinceInfoN(Brand,ProductNo)\"");%>>
                      <option value="0" selected>-请选择-</option>
                      <%
         			    if (TypeId.equals("4") || TypeId.equals("5"))
			    {
                                           out.println(LookUp.getLookUp("select Name, BrandId from brand  where lang_code = '" +
                                     LangCode  + "' order by brandid","name","brandid"));
			    }
		                else
			    {
                                         out.println(LookUp.getLookUp("select b.* from brand b, brand_type bt where b.brandid =bt.brandid " +
				" and bt.typeid = " + TypeId + " and b.lang_code = '" + LangCode + "' order by bt.disp_no,b.brandid","name","brandid"));
			    }
			%> 
                    </select>
                    <input type="hidden" name="NewProductNo">
                    <input type="hidden" name="BrandText">
                    </font></td>
                </tr>
                            <%
                if (TypeId.equals("4") || TypeId.equals("5"))
		    {
                            %> 
                            <tr> 
                  <td width="70">产品型号</td>
                  <td width="174"><font size="2"> 
                    <select name="ProductNo" size="1" onBlur="saveProvinceN()">
                      <option value="0" selected>-请选择-</option>
                    </select>
                    <input type="hidden" name="ProductText">
                    </font></td>
                </tr>
                                 <%if (TypeId.equals("5") || TypeId.equals("4")) 
                                      { %> 
		    <tr> 
                  <td width="70">零件编号</td>
                  <td width="174"><font size="2"> 
                    <input type="text" name="PartProdNo" size="10">
                    </font></td>
                </tr> 

                          <% }
                                } %>
				
                <tr> 
                  <td width="70">产品类别</td>
                  <td width="174"><font size="2"> 
                    <select name="Category">
                      <option value="0" selected>-请选择-</option>
                      <%=LookUp.getLookUp("select CateName,CateId from category  where lang_code = '" +
            LangCode  + "' and (typeid='" + TypeId  + "' or typeid = 7 ) order by cateid","CateName","CateId")%> 
                    </select>
                    <input type="hidden" name="CateText">
                    </font></td>
                </tr>
              
                <% 
 				  
                if (TypeId.equals("1") || TypeId.equals("2") || TypeId.equals("3"))
                {
                %>
                <tr> 
                  <td width="70">价格范围 </td>
                  <td width="174"><font size="2"> 
                    <select name="PriceRange">
                      <option value="0" selected>-请选择-</option>
                      <%=LookUp.getLookUp("select price_l||'~'||price_u price,price_l||'~'||price_u||'元' Display from price_range  where typeid ='" +
               TypeId  + "' order by price_l","Display","price")%> <%=TypeId%> 
                    </select>
                    </font></td>
                </tr>

                <% 
                 }
        /*rs = Result.getRS(SQL);
    if (rs != null) 
    {
      while (rs.next())
      {
        SpecId = rs.getString("SpecId");
        SpecName = rs.getString("Name");
        out.println("<tr>");
        out.println("<td width=\"107\"><font size=\"2\">" + SpecName + "</font></td>");
        out.println("<td width=\"191\"><font size=\"2\">");
        out.println("<select name=\"" + SpecId + "\">");
          out.println("<option value=\"0\">-请选择-</option>");
          out.println(LookUp.getLookUp("select distinct value1 from prod_spec where SpecId = '" +
            SpecId  + "' and Value1 <> '0'  order by Value1","Value1","Value1"));
        out.println("</select>");
        out.println("</font>");
        out.println("</td>");
        out.println("</tr>");
      }

    }
    else
      out.println(SQL);*/
    %> 
                <tr> 
                  <td colspan="2"><b>您可以根据您的需要进行单项或多项查询</b> </td>
                </tr>
                <tr align="center"> 
                  <td colspan="2" height="50"><font size="2"> <input type="image" src="/images/temp/b_search.gif" width="44" height="17" border="0"> 
                    </font></td>
                </tr>
              </form>
            </table>
          </td>
          <td align="right" valign="top" width="167"> 
            <table width="154" border="0" cellspacing="0" cellpadding="0">
              <tr align="center"> 
                <td colspan="2" height="20"> 
                  <div align="right"><img src="/images/temp/car.gif" width="19" height="16" align="absbottom"> 
                    <a href="#">查看购物车</a></div>
                </td>
              </tr>
            </table>
            <table width="154" border="0" cellspacing="0" cellpadding="0">
              <tr align="center"> 
                <td valign="top" width="154"><img src="/images/temp/title_hot.gif" width="154" height="28"></td>
              </tr>
              <tr align="center"> 
                <td width="154"> 
                  <table width="154" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="3" valign="top"><img src="/images/temp/left_bars.gif" width="3" height="76"></td>
                      <td width="149"> 
                        <table width="149" border="0" cellspacing="0" cellpadding="0">
                          <% 
					  rs = Result.getRS("select p.Prodid, p.productNo,p.listprice, b.name, c.catename,d.dir,s.filename1 from product p, " + 
  						" brand b, category c, speci_sale s, dir_setting d " +
 						" where p.brandid = b.brandid and b.lang_code = 'GB' " + 
						" and  p.cateid = c.cateid and c.lang_code = b.lang_code " + 
						" and p.prodid = s.prodid and s.location='F' " +
						" and s.picdir1 = d.dirid(+)");
                      //rs = null;
   					  if (rs!=null)
                      {
                        if (rs.next())
                        {
					     %> 
                          <tr align="center"> 
                            <td colspan="2"> <a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"> 
                              <img src="<% String FileName = "";
                                    if (rs.getString("Dir") == null)
                                      FileName = "../images/hots/" + rs.getString("FileName1");
									else
    								  FileName = "/" + rs.getString("Dir") + rs.getString("FileName1");
									out.println(FileName);
                                 %>" width="149" height="89" border="0"></a></td>
                          </tr>
                          <tr align="center"> 
                            <td colspan="2"> 
                              <table width="149" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td width="22">&nbsp;</td>
                                  <td width="129">&nbsp;</td>
                                </tr>
                                <tr> 
                                  <td width="22"><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                                  <td width="129"><%=rs.getString("Name")%></td>
                                </tr>
                                <tr> 
                                  <td width="22"></td>
                                  <td width="129"><%=rs.getString("ProductNo")+rs.getString("CateName")%></td>
                                </tr>
                                <tr> 
                                  <td width="22"></td>
                                  <td width="129"><%="价格: " + rs.getString("ListPrice") +   "元"%></td>
                                </tr>
                                <tr align="center"> 
                                  <td colspan="2" height="30"> 
                                    <table width="149" border="0" cellspacing="0" cellpadding="0">
                                      <tr align="center"> 
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <%
					   }
                     }
                    %> 
                        </table>
                      </td>
                      <td width="2" valign="top"><img src="/images/temp/right_bars.gif" width="2" height="76"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
      <br>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<%if (LookUp.CloseStm()) 
        out.println("");%>
<%if (Result.CloseStm()) 
        out.println("");%>

<script language="JavaScript" src="/javascript/foot1.js">
</script>
</body>
<!-- #EndTemplate --></html>

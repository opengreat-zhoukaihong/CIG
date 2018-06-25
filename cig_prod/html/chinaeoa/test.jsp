<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<html>
<head>
<title>ChinaEOA.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--

function Search()
{
  if (fmSearch.Brand.value == "0" || fmSearch.ProductNo.value == "0")
  {
    alert("请选择品牌与型号");
  }
  else
  {
    fmSearch.action = "ProductDetail.jsp?LangCode=GB&ProdId=" + fmSearch.ProductNo.value;
    fmSearch.submit();
   }
}

function Query()
{
  if (fmQuery.Brand.value == "0" || fmQuery.ProductNo.value == "0")
  {
    alert("请选择品牌与型号");
  }
  else
  {
    fmQuery.action = "ProductDetail.jsp?LangCode=GB&ProdId=" + fmQuery.ProductNo.value;
    fmQuery.submit();
   }
}
//-->
</script>

<script language="JavaScript">
<!--
provinceArray = new Array(
<%=LookUp.getFirstLookUp("select p.brandId,p.productno,P.prodid, C.cateName from product p ," + 
" brand b, category c where p.cateid = c.cateid and p.brandid = b.brandid and b.lang_code = 'GB' and p.typeid<4 order by p.brandid,p.cateid, p.productno",3,"CateName")%>);//
  //cityArray = new Array("1.1.guangzhou.1","1.1.shenzheng.2","1.2.xiamen.3","1.2.fuzhou.4");
  dropDownItem = new String();

  function changeProvinceInfo(countryBox,provinceBox)
  {
    var countryItem = countryBox.value;
    var itemCount;

    if(countryItem>0)
    {
      provinceBox.length=1;
     // cityBox.length=1;
      for(var i=0;i<provinceArray.length;i++)
      {
        dropDownItem = provinceArray[i].split(".");
        if(countryItem==dropDownItem[0])
        {
          itemCount = provinceBox.length;
          provinceBox.length += 1;
          provinceBox.options[itemCount].value = dropDownItem[2];
          provinceBox.options[itemCount].text = dropDownItem[1];
        }
      }
    }
  }

//-->
</script>
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
img7on.src = "/images/temp/menu_service_0.gif";
img8on = new Image();
img8on.src = "/images/temp/menu_service10.gif";
img9on = new Image();
img9on.src = "/images/temp/menu_service20.gif";
img10on = new Image();
img10on.src = "/images/temp/menu_service30.gif"; 
img11on = new Image();
img11on.src = "/images/temp/menu_service40.gif";
img12on = new Image();
img12on.src = "/images/temp/menu_service50.gif";
img13on = new Image();
img13on.src = "/images/temp/menu_service60.gif";
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
img7off .src = "/images/temp/menu_service.gif";
img8off = new Image();
img8off .src = "/images/temp/menu_service1.gif";
img9off = new Image();
img9off .src = "/images/temp/menu_service2.gif";
img10off = new Image();
img10off.src = "/images/temp/menu_service3.gif"; 
img11off = new Image();
img11off.src = "/images/temp/menu_service4.gif";
img12off = new Image();
img12off.src = "/images/temp/menu_service5.gif";
img13off = new Image();
img13off.src = "/images/temp/menu_service6.gif";
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

<table width="665" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td width="665"> 
      <table width="667" border="0" cellspacing="0" cellpadding="0" height="25">
        <tr> 
          <td width="283"><a href="index.html"><img src="/images/temp/head_up_1.gif" width="283" height="25" border="0"></a></td>
          <td> 
            <table width="384" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="36"><img src="/images/temp/head_menu_1h.gif" width="36" height="25"></td>
                <td width="320"> 
                  <table width="320" border="0" cellspacing="0" cellpadding="0" height="25">
                    <tr> 
                      <td width="320"> 
                        <table width="320" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="61"> <a href="ProductCentre.jsp?LangCode=GB" onMouseOver="imgOn('img3')" onMouseOut="imgOff('img3')"><img src="/images/temp/menu_3.gif" width="61" height="22" border="0" name="img3"></a></td>
                            <td width="61"><a href="registration.jsp" onMouseOver="imgOn('img2')" onMouseOut="imgOff('img2')"><img src="/images/temp/menu_2.gif" width="61" height="22" border="0" name="img2"></a></td>
                            <td width="62"> <a href="/service.htm" onMouseOver="imgOn('img5')" onMouseOut="imgOff('img5')"><img src="/images/temp/menu_5.gif" width="62" height="22" border="0" name="img5"></a></td>
                            <td width="74"><a href="/dealer.htm" onMouseOver="imgOn('img4')" onMouseOut="imgOff('img4')"><img src="/images/temp/menu_4.gif" width="74" height="22" border="0" name="img4"></a></td>
                            <td width="62"> <a href="/about.htm" onMouseOver="imgOn('img6')" onMouseOut="imgOff('img6')"><img src="/images/temp/menu_6.gif" width="62" height="22" border="0" name="img6"></a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td height="3" width="362"><img src="/images/temp/head_menu_3.gif" width="320" height="3"></td>
                    </tr>
                  </table>
                </td>
                <td align="right" width="28"><img src="/images/temp/head_menu_2h.gif" width="28" height="25"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td width="665"> 
      <table width="667" border="0" cellspacing="0" cellpadding="0" height="46">
        <tr> 
          <td width="283"><img src="/images/temp/head_dn_1.gif" width="283" height="46"></td>
          <td>
            <table width="384" border="0" cellspacing="0" cellpadding="0" height="46" background="/images/temp/head_dn_2.gif">
              <form name="fmLogin" method="post" action="Login.jsp">
              <tr>
                  <td height="28">品 牌 
                    <select name="select" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                      <option value="0" selected>-请选择-</option>
                      <%=LookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
                    </select>
                    型 号： 
                    <select name="select2" >
                      <option value="0" selected>-请选择-</option>
                    </select>
                    <a href="javascript:Search()"><img src="/images/temp/b_search.gif" width="44" height="17" border="0"></a> 
                  </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr></form>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="667" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" width="443"> 
      <table width="443" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
            <div id="Layer1" style="position:absolute; left:160px; top:215px;z-index:2; visibility: hidden"> 
              <table width="100" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="5" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(1)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td height="90"> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <% 
						           ResultSet rs = Result.getRS("select * from category where typeid=3 and lang_code='GB' order by cateid");
   						         int i = 0;
                       String CategoryName = "";
                       String CateId = "";
   						         if (rs!=null)
                       {
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=3&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
			        out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=3&LangCode=GB\">更多...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer2" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(2)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=1");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=1&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
                                            out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=1&LangCode=GB\">更多...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer3" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(3)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td>
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=2 and lang_code='GB' order by cateid");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=2&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
                                            out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=2&LangCode=GB\">更多...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer4" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(4)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=7 and lang_code='GB' order by cateid");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=7&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
			       // out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=7&LangCode=GB\">更多...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer5" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(5)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=4 and lang_code='GB' order by cateid");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=4&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
          			        out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=4&LangCode=GB\">更多...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>
            <div id="Layer6" style="position:absolute; left:160; top:215;z-index:2; layer-background-color: #FFFFFF; visibility: hidden"> 
              <table width="100" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="4" align="right"><img src="/images/cross.gif" border="0" onMouseDown="HideLayer(6)" width="14" height="5"></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                      <%
						           rs = Result.getRS("select * from category where typeid=5 and lang_code='GB' order by cateid");
   						         if (rs!=null)
                       {
                         i = 0;
                         while (rs.next() && i<4)
                         {
                           i++;
                           CategoryName = rs.getString("CateName");
                           CateId = rs.getString("CateId");
                           out.println("<tr align=\"center\">");
                           out.println("<td height=\"18\"><a href=\"ProductList.jsp?CateName="
                             + URLEncoder.encode(CategoryName) + "&Category=" + CateId +
                             "&TypeId=5&LangCode=GB\">" + CategoryName + "</a></td>");
                           out.println("</tr>");
                         }
                                            out.println("<tr align=\"center\"><td height=\"18\"><a href=\"ProductSearch.jsp?TypeId=5&LangCode=GB\">更多...</a></td></tr>");
                       }
                      %>
                    </table>
                  </td>
                </tr>
              </table>
            </div>

            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="3"><img src="/images/temp/body_up.gif" width="443" height="146" border="0" usemap="#Map"><map name="Map"><area shape="circle" coords="257,50,26" href="ProductSearch.jsp?TypeId=3&LangCode=GB" onMouseOver="ShowLayer(1)"><area shape="circle" coords="197,57,23" href="ProductSearch.jsp?TypeId=1&amp;LangCode=GB" onMouseOver="ShowLayer(2)"><area shape="circle" coords="141,76,25" href="ProductSearch.jsp?TypeId=2&amp;LangCode=GB" onMouseOver="ShowLayer(3)"><area shape="circle" coords="101,115,25" onMouseOver="ShowLayer(4)"><area shape="circle" coords="68,154,27" href="ProductSearch.jsp?TypeId=4&amp;LangCode=GB" onMouseOver="ShowLayer(5)"></map></td>
              </tr>
              <tr> 
                <td width="270"><img src="/images/temp/body_m1.gif" width="270" height="72" border="0" usemap="#Map2"><map name="Map2"><area shape="circle" coords="49,56,24" href="ProductSearch.jsp?TypeId=5&amp;LangCode=GB" onMouseOver="ShowLayer(6)"><area shape="circle" coords="65,5,22" href="ProductSearch.jsp?TypeId=4&amp;LangCode=GB" onMouseOver="ShowLayer(5)"></map></td>
                <td width="124">
                  <table width="124" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="23"><a href="/train.htm" onMouseOver="imgOn('img8')" onMouseOut="imgOff('img8')"><img src="/images/temp/menu_service1.gif" width="23" height="72" name="img8" border="0"></a></td>
                      <td width="19"><a href="/tech.htm" onMouseOver="imgOn('img9')" onMouseOut="imgOff('img9')"><img src="/images/temp/menu_service2.gif" width="19" height="72" name="img9" border="0"></a></td>
                      <td width="21"><a href="/guide.htm" onMouseOver="imgOn('img10')" onMouseOut="imgOff('img10')"><img src="/images/temp/menu_service3.gif" width="21" height="72" name="img10" border="0"></a></td>
                      <td width="19"><a href="/service.htm" onMouseOver="imgOn('img11')" onMouseOut="imgOff('img11')"><img src="/images/temp/menu_service4.gif" width="19" height="72" name="img11" border="0"></a></td>
                      <td width="21"><a href="/rate.htm" onMouseOver="imgOn('img12')" onMouseOut="imgOff('img12')"><img src="/images/temp/menu_service5.gif" width="21" height="72" name="img12" border="0"></a></td>
                      <td width="21"><a href="/mk.htm" onMouseOver="imgOn('img13')" onMouseOut="imgOff('img13')"><img src="/images/temp/menu_service6.gif" width="21" height="72" name="img13" border="0"></a></td>
                    </tr>
                  </table>
                </td>
                <td width="49"><img src="/images/temp/body_m2.gif" width="49" height="72"></td>
              </tr>
              <tr> 
                <td colspan="3"><img src="/images/temp/body_b.gif" width="443" height="40" usemap="#Map3" border="0"><map name="Map3"><area shape="circle" coords="51,-22,32" href="ProductSearch.jsp?TypeId=5&amp;LangCode=GB" onMouseOver="ShowLayer(6)"></map></td>
              </tr><form name="FORM_Data"><input type="hidden" name="HIDDEN_LayerCount" value="6"></form>
            </table><script language="JavaScript">
function  ShowLayer(iLayer)
{	
	var strName;
	var theObj;
	HideAllLayer();
	strName = "Layer" + iLayer
	if(navigator.appName == 'Netscape' && document.layers != null){
		strName = "document.layers." + strName
		theObj = eval(strName);
		theObj.visibility = "visible";
	}
	else if (document.all != null){
		document.all(strName).style.visibility = "visible";
	}
}

function  HideLayer(iLayer)
{	
	var strName;
	var theObj;
	strName = "Layer" + iLayer
	//alert("strName");
	if(navigator.appName == 'Netscape' && document.layers != null){
		strName = "document.layers." + strName
		theObj = eval(strName);
		theObj.visibility = "hidden";
	}
	else if (document.all != null){
		document.all(strName).style.visibility = "hidden";
	}
}

function  HideAllLayer()
{	
	var strName, iLayerCount, i;
	var theObj;
	iLayerCount = document.forms.FORM_Data.HIDDEN_LayerCount.value;
	for(i = 1; i <= iLayerCount; i++)
	{
		strName = "Layer" + i
		if(navigator.appName == 'Netscape' && document.layers != null){
			strName = "document.layers." + strName
			theObj = eval(strName);
			theObj.visibility = "hidden";		
		}
			else if (document.all != null){
			document.all(strName).style.visibility = "hidden";
		}
	}
}
</script></td>
        </tr>
        <tr> 
          <td><img src="/images/temp/service.gif" width="443" height="92"></td>
        </tr>
      </table>
    </td>
    <td valign="top" align="center" width="197"> 
      <table width="154" border="0" cellspacing="0" cellpadding="0">
        <tr align="center"> 
          <td valign="top" width="154"><img src="/images/temp/title_search.gif" width="154" height="25"></td>
        </tr>
        <tr align="center"> 
          <td valign="top" width="154"> 
            <table width="154" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="3" valign="top"><img src="/images/temp/left_bars.gif" width="3" height="76"></td>
                <td valign="top" width="149"> 
                  <table width="149" border="0" cellspacing="0" cellpadding="0"><form name="fmSearch" method="post" >
                    <tr> 
                      <td width="54" align="center">品 牌</td>
                      <td width="95"> 
                        <select name="Brand" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                           <option value="0" selected>-请选择-</option>
                           <%=LookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
                        </select>
                      </td>
                    </tr>
                    <tr> 
                      <td width="54" align="center">型 号</td>
                      <td width="95"> 
                        <select name="ProductNo" >
                           <option value="0" selected>-请选择-</option>
                        </select>
                      </td>
                    </tr>
                    <tr align="center"> 
                      <td width="54">&nbsp;</td>
                        <td width="95" height="40"><a href="javascript:Search()"><img src="/images/temp/b_search.gif" width="44" height="17" border="0"></a></td>
                    </tr></form>
                  </table>
                </td>
                <td width="2" valign="top"><img src="/images/temp/right_bars.gif" width="2" height="76"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr align="center"> 
          <td valign="top" width="154">&nbsp;</td>
        </tr>
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
                      <td colspan="2">
                 	   
                       <a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB">
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
                            <td width="22">&nbsp;</td>
                            <td width="129"><%=rs.getString("ProductNo")+rs.getString("CateName")%></td>
                          </tr>
                          <tr> 
                            <td width="22">&nbsp;</td>
                            <td width="129"><%="价格: " + rs.getString("ListPrice") + "元"%></td>
                          </tr>
                          <tr> 
                            <td width="22"><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                            <td width="129"><a href="ProductCentre.jsp?LangCode=GB">更多....</a></td>
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
<table width="667" border="0" cellspacing="0" cellpadding="0">
  <tr align="center"> 
    <td><img src="/images/temp/foot.gif" width="620" height="23"> </td>
  </tr>
</table>
<%if (LookUp.CloseStm()) 
        out.println("");%>
<%if (Result.CloseStm()) 
        out.println("");%>
</body>
</html>


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
 function Login()
{
  if (fmLogin.User.value == "" || fmLogin.Passwd.value == "")
  {
    alert("请输入用户与口令");
  }
  else
  {
    //launchRemote("Login.jsp?User=" + fmLogin.User.value + "&Passwd=" + fmLogin.Passwd.value);
    //fmLogin.action = "";
    fmLogin.submit();
  }
}
function Search()
{
  if (fmSearch.Brand.value == "0" || fmSearch.ProductNo.value == "0" || fmSearch.ProductNo.value == null)
  {
    alert("请选择品牌与型号");
  }
  else
  {
    fmSearch.action = "ProductDetail.jsp?LangCode=GB&ProdId=" + fmSearch.ProductNo.value;
    fmSearch.submit();
   }
}
//-->
</script>

<script language="JavaScript">
<!--
provinceArray = new Array(
<%=LookUp.getFirstLookUp("select p.brandId,p.productno,P.prodid, C.cateName from product p ," + 
" brand b, category c where p.cateid = c.cateid and p.brandid = b.brandid and b.lang_code = 'GB' and p.typeid in (1,2,3,7,8,9) and p.Status='Y' order by p.brandid,p.cateid, p.productno",3,"CateName")%>);//
  //cityArray = new Array("1.1.guangzhou.1","1.1.shenzheng.2","1.2.xiamen.3","1.2.fuzhou.4");
  dropDownItem = new String();

  function changeProvinceInfo(countryBox,provinceBox)
  {
    var countryItem = countryBox.selectedIndex;
    var itemCount;

    if(countryItem>0)
    {
      provinceBox.length=1;
      //cityBox.length=1;
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

function saveProvince()
{
  document.fmSearch.NewProductNo.value =     document.fmSearch.ProductNo.selectedIndex;
}

 

  function initArea()
  {
    	changeProvinceInfo(document.fmSearch.Brand,document.fmSearch.ProductNo);

  }
//-->
</script>
<script
language="JavaScript">
<!--
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
<!--
<!--
window.name = "eoa"
var onTop = false
function launchRemote(url) {
remote=open(url, "login", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=180,height=360')
}
// -->

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
</script>
</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="/images/temp/bg.gif" onLoad="initArea();MM_preloadImages('../images/chinaeoa2_08_0.gif','../images/chinaeoa2_09_0.gif','../images/chinaeoa2_10_0.gif','../images/chinaeoa2_11_0.gif','../images/chinaeoa2_12_0.gif','../images/chinaeoa2_13_0.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr> 
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=725>
  <tbody> 
  <tr> 
    <td width=283><a 
            href="index.jsp"><img border=0 
            height=25 src="/images/temp/head_up_1.gif" width=283></a></td>
    <td width=17><img height=25 
                  src="/images/temp/head_menu_1.gif" width=17></td>
    <td width=413 background="/images/temp/dt.gif" align="center"><img src="/images/temp/ico.gif" width="8" height="10" name="pic1"><a href="index.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic1','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">首页</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic2"><a href="ProductCentre.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic2','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">产品中心</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic3"><a href="OrderOnLine.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic3','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">在线订购</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic4"><a href="registration.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic4','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">用户注册</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic5"><a href="MyEoa.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic5','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">MYEOA</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic6"><a href="../service.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic6','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">客户服务</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic7"><a href="../dealer.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic7','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">经销商</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic8"><a href="../about.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic8','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">关于我们</font></a> 
    </td>
    <td align=right width=12 background="/images/temp/dt.gif"><img height=25 
                  src="/images/temp/head_menu_2.gif" 
              width=8></td>
  </tr>
  </tbody> 
</table>
<table border=0 cellpadding=0 cellspacing=0 height=46 width=726>
  <tbody> 
  <tr> 
    <td width=283 valign="top"><img height=46 src="/images/temp/head_dn_1.gif" 
            width=283></td>
    <td width="443"> 
      <table background=/images/temp/head_dn_2.gif border=0 
            cellpadding=0 cellspacing=0 height=46 width=432>
        <form action="Login.jsp" method=post name=fmLogin>
          <tr align="right"> 
            <td height=28>用 户： 
              <input type="text" name="User" size="10" class="font1">
              密 码： 
              <input type="password" name="Passwd" size="10" class="font1">
              <a href="javascript:Login();"><img src="/images/temp/b_login.gif" width="41" height="15" border="0" alt="登录"> 
              </a><a href="rpass1.jsp"><img src="/images/temp/b_pw.gif" width="57" height="15" border="0" alt="忘记密码"></a> 
            </td>
          </tr>
          <tr> 
            <td></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
  </tbody> 
</table>
<table width="723" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" width="470"> 
      <table border=0 cellpadding=0 cellspacing=0>
        <tr> 
          <td rowspan=4 background="/images/chinaeoa2_03.gif" width="45"> <img src="/images/chinaeoa2_03.gif" width=13 height=253></td>
          <td> <img src="/images/chinaeoa2_04.gif" width=255 height=132 usemap="#Map4" border="0"><map name="Map4"><area shape="circle" coords="246,47,26" href="ProductSearch.jsp?TypeId=3&LangCode=GB" onMouseOver="MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','hide')" alt="复印机" title="复印机"><area shape="circle" coords="186,56,25" href="ProductSearch.jsp?TypeId=1&LangCode=GB" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','show','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','hide')" alt="打印机" title="打印机"><area shape="circle" coords="130,77,27" href="ProductSearch.jsp?TypeId=2&LangCode=GB" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','show','Layer4','','hide','Layer5','','hide','Layer6','','hide')" alt="传真机" title="传真机"><area shape="circle" coords="89,117,27" href="ProductSearch.jsp?TypeId=8&LangCode=GB" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','show','Layer5','','hide','Layer6','','hide')" alt="扫描仪" title="扫描仪"></map></td>
          <td colspan=7> <img src="/images/chinaeoa2_05.gif" width=170 height=132 usemap="#Map5" border="0"><map name="Map5"><area shape="circle" coords="4,49,22" href="ProductSearch.jsp?TypeId=3&LangCode=GB" onMouseOver="MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','hide')" alt="复印机" title="复印机"></map></td>
        </tr>
        <tr> 
          <td rowspan=3> <img src="/images/chinaeoa2_07.gif" width=255 height=121 usemap="#Map6" border="0"><map name="Map6"><area shape="circle" coords="56,15,26" href="ProductSearch.jsp?TypeId=4&LangCode=GB" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','show','Layer6','','hide')" alt="耗材" title="耗材"><area shape="circle" coords="36,69,26" href="ProductSearch.jsp?TypeId=5&LangCode=GB" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','hide','Layer5','','hide','Layer6','','show')" alt="零件" title="零件"></map></td>
          <td rowspan=2> <a href="/train.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('image1','','../images/chinaeoa2_08_0.gif',1)"><img src="/images/chinaeoa2_08.gif" width=25 height=90 border="0" name="image1" alt="培训活动"></a></td>
          <td rowspan=2> <a href="/tech.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('image2','','../images/chinaeoa2_09_0.gif',1)"><img src="/images/chinaeoa2_09.gif" width=20 height=90 border="0" name="image2" alt="技术支持"></a></td>
          <td rowspan=2> <a href="/guide.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('image3','','../images/chinaeoa2_10_0.gif',1)"><img src="/images/chinaeoa2_10.gif" width=19 height=90 border="0" name="image3" alt="购买指南"></a></td>
          <td rowspan=2> <a href="/service.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('image4','','../images/chinaeoa2_11_0.gif',1)"><img src="/images/chinaeoa2_11.gif" width=21 height=90 border="0" name="image4" alt="客户服务"></a></td>
          <td rowspan=2> <a href="javascript:alert(&quot;正在建设中&quot;);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('image5','','../images/chinaeoa2_12_0.gif',1)"><img src="/images/chinaeoa2_12.gif" width=20 height=90 border="0" name="image5" alt="产品评论"></a></td>
          <td rowspan=2> <a href="javascript:alert(&quot;正在建设中&quot;);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('image6','','../images/chinaeoa2_13_0.gif',1)"><img src="/images/chinaeoa2_13.gif" width=22 height=90 border="0" name="image6" alt="管理知识"></a></td>
          <td> <img src="/images/chinaeoa2_14.gif" width=43 height=1></td>
        </tr>
        <tr> 
          <td> <img src="/images/chinaeoa2_15.gif" width=43 height=89></td>
        </tr>
        <tr> 
          <td colspan=7> <img src="/images/chinaeoa2_16.gif" width=170 height=31></td>
        </tr>
        <tr align="right"> 
          <td colspan="9"><img src="/images/temp/service.gif" width="443" height="92"></td>
        </tr>
      </table>
      <script language="JavaScript">
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
</script>
      <div id="Layer1" style="position:absolute; left:174px; top:207px; width:124px; height:105px; z-index:3; visibility: hidden"> 
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
      <div id="Layer2" style="position:absolute; left:174px; top:207px; width:124px; height:105px; z-index:3; visibility: hidden"> 
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
      <div id="Layer3" style="position:absolute; left:174px; top:207px; width:124px; height:105px; z-index:3; visibility: hidden"> 
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
      <div id="Layer4" style="position:absolute; left:174px; top:207px; width:124px; height:105px; z-index:3; visibility: hidden"> 
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
      <div id="Layer5" style="position:absolute; left:174px; top:207px; width:124px; height:105px; z-index:3; visibility: hidden"> 
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
      <div id="Layer6" style="position:absolute; left:174px; top:207px; width:124px; height:105px; z-index:3; visibility: hidden"> 
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
    </td>
    <td valign="top" align="center" width="260"> 
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
                        <select name="ProductNo" onBlur="saveProvince()" >
                           <option value="0" selected>-请选择-</option>
                        </select>
                      </td>
                    </tr>
                    <tr align="center"> 
                      <td width="54">
                          <input type="hidden" name="NewProductNo">
                        </td>
                        <td width="95" height="40"><a href="javascript:Search()"><img src="/images/temp/b_search.gif" width="44" height="17" border="0" alt="查询"></a></td>
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
                <td width="10" valign="top"><img src="/images/temp/left_bars.gif" width="3" height="76"></td>
                <td width="142"> 
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
                                 %>" width="149" height="89" border="0" alt="本月特别推荐"></a></td>
                       
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
<table width="704" border="0" cellspacing="0" cellpadding="0">
  <tr align="right"> 
    <td><img src="/images/temp/foot.gif" width="620" height="23"> </td>
  </tr>
</table>
<%
LookUp.CloseStm();
Result.CloseStm(); 
%> 
</body>
</html>


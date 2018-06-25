<%@ page import="java.util.*,java.sql.*" %>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<%String LangCode = "GB";%>

<html><!-- #BeginTemplate "/Templates/ceoa.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ChinaEOA.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">



<script language="JavaScript">
<!--

function Search()
{
  if (fmOrder.Brand.value == "0" || fmOrder.ProductNo.value == "0" || fmOrder.ProductNo.value == "" )
  {
    alert("请选择品牌与型号");
  }
  else
  {
    fmOrder.action = "ProductDetail.jsp?LangCode=GB&ProdId=" + fmOrder.ProductNo.value;
    fmOrder.submit();
   }
}

function GoPart()
{
  if (fmOrder.Brand.value == "0" || fmOrder.ProductNo.value == "0")
  {
    alert("请选择品牌与型号");
  }
  else
  {
       fmOrder.MainProd.value = fmOrder.Brand.options[fmOrder.Brand.selectedIndex].text +
			          fmOrder.ProductNo.options[fmOrder.ProductNo.selectedIndex].text ;
    fmOrder.action = "OrderPartList.jsp?LangCode=GB&ProdId=" + fmOrder.ProductNo.value;
    fmOrder.submit();
   }
}
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
      if((document.fmOrder.NewProductNo.value==null)||(document.fmOrder.NewProductNo.value==""))
        provinceBox.selectedIndex = 1;
      else
        provinceBox.selectedIndex = document.fmOrder.NewProductNo.value;
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
  document.fmOrder.NewProductNo.value =     document.fmOrder.ProductNo.selectedIndex;
}

 

  function initArea()
  {
    	changeProvinceInfo(document.fmOrder.Brand,document.fmOrder.ProductNo);

  }


//-->
</script>

<script
language="JavaScript">
<!--
function openorder(url)
{   
  OpenWindow=window.open(url, "win1", "height=300 width=600,toolbar=no,scrollbars=yes,menubar=no,resize=yes");
}


function Order()
{
	//alert("test");
       if (fmOrder.Brand.value == "0")
	{
     	   alert("请选择品牌");
	   return;
            }   
	if (fmOrder.ProductNo.value == "0")
	{
     	   alert("请选择型号");
	   return;
            }             
            if (fmOrder.Qty.value == "")
	{
     	   alert("请输入数量");
	   return;
            }             

       openorder("/chinaeoa/AddOrder.jsp?Type=A&LangCode=GB&ProdId=" + fmOrder.ProductNo.value + "&Qty=" + fmOrder.Qty.value);
      
  //fmList.method="post";
  //fmList.submit();
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



</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  tracingopacity="80" background="/images/temp/bg.gif" onLoad="initArea()">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr>
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/title.js">
</script>

<table width="700" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" colspan="2"><!-- #BeginEditable "body" --> 
      <table width="680" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td height="30"><img src="/images/temp/path.gif" width="49" height="13"> 
            <img src="/images/arrow.gif" width="7" height="11"> <a href="/chinaeoa/index.jsp">首页</a> 
            <img src="/images/arrow.gif" width="7" height="11"> <font title="里边有什么好东西呢"> 
            在线订购</font></td>
          <td height="30" align="right"><font title="里边有什么好东西呢"><img src="/images/temp/car.gif" width="19" height="16" align="absbottom"> 
            <a href="#" onClick="openorder('AddOrder.jsp?LangCode=<%=LangCode%>')">查看购物车</a></font></td>
        </tr>
      </table>
      <table width="680" border="0" cellspacing="0" cellpadding="3" align="center">
        <tr> 
          <td height="30" colspan="7" align="left" bgcolor="#F4FCFF"><b>订购产品</b></td>
        </tr>
        <form name="fmOrder" method="post" >
          <tr> 
            <td width="44" align="right" bgcolor="#DFEEFF">品 牌:</td>
            <td width="84" bgcolor="#DFEEFF"> 
              <select name="Brand" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
              </select>
            </td>
            <td width="35" align="right" bgcolor="#DFEEFF">型 号:</td>
            <td width="139" bgcolor="#DFEEFF"> 
              <select name="ProductNo" onBlur="saveProvince()">
                <option value="0" selected>-请选择-</option>
              </select>
            </td>
            <td height="30" align="right" width="72" bgcolor="#DFEEFF">订购数量:</td>
            <td height="30" width="88" bgcolor="#DFEEFF"> 
              <input type="text" name="Qty" maxlength="3" size="10">
            </td>
            <td height="30" width="76" bgcolor="#DFEEFF" align="center"><a href="javascript:Search()"><img src="/images/temp/b_search.gif" width="44" height="17" border="0"></a></td>
          </tr>
          <tr> 
            <td height="30" colspan="7" align="center" bgcolor="#F4FCFF"><a href="javascript:Order();"><img src="/images/temp/b_ok.gif" width="41" height="17" border="0"></a></td>
          </tr>
          <tr> 
            <td height="30" colspan="2" bgcolor="#DFEEFF">选择类别 :</td>
            <td height="30" colspan="4" bgcolor="#DFEEFF">耗材 
              <input type="radio" name="TypeId" value="4" checked>
              &nbsp;&nbsp;&nbsp; 零件 
              <input type="radio" name="TypeId" value="5">
              &nbsp;&nbsp;&nbsp;选购件 
              <input type="radio" name="TypeId" value="6">
              <input type="hidden" name="MainProd">
              <input type="hidden" name="NewProductNo">
            </td>
            <td height="30" align="center" width="76" bgcolor="#DFEEFF"><a href="javascript:GoPart()"><img src="/images/temp/b_search.gif" width="44" height="17" border="0"></a></td>
          </tr>
          <tr bgcolor="#F4FCFF"> 
            <td colspan="7" height="138">&nbsp;</td>
          </tr>
        </form>
      </table>
      <p>&nbsp;</p>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>
<%LookUp.CloseStm();%>
</body>
<!-- #EndTemplate --></html>

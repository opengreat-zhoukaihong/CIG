


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
   fmLogin.submit();
}
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
//-->
</script>

<script language="JavaScript">
<!--
provinceArray = new Array(
"1.3001.3314","1.3030.3315","1.3040.3316","1.3050.3317","1.4512.3437","1.5421.3331","1.5518.3330","1.5615.3327","1.5618.3383","1.5837.3332","1.5845.3333","1.5855.3334","1.8825DDS.3367","1.8830DDS.3368","1.C55.3436","1.DC214.3326","1.FC160.3390","1.N24/N32.3438","1.P8e.3481","1.PHASER780/GN.3483","1.PHASER780/N.3482","1.PHASER780/P.3484","1.Phaser 740/DX.3435","1.Phaser 740/N.3433","1.Phaser 740/p.3434","1.V228.3360","1.V250.3328","1.V258.3361","1.V330.3329","1.V338.3362","1.V388.3363","1.XE60.3359","1.XJ4C.3479","1.fc170.3387","2.BJ-30.3445","2.BJC-265SP.3485","2.BJC-50.3451","2.BJC-50g.3453","2.BJC1000SP.3446","2.BJc-2000.3447","2.BJc-3000.3448","2.BJc-4310sp.3449","2.BJc-4650.3450","2.BJc-5000.3452","2.BJc-5100.3454","2.BJc-5500.3455","2.BJc-6000.3456","2.BJc-7100.3457","2.BJc-80.3458","2.BJc-w7000.3459","2.CP660.3347","2.FAX-L250.3399","2.FAX-L380.3400","2.FAX-T11.3397","2.FAX-T31.3398","2.FC-220.3336","2.GP-335.3337","2.GP-405.3338","2.GP160/160F.3365","2.LBP 660.3463","2.LBP 800.3464","2.LBP1760.3460","2.LBP2460.3461","2.LBP3260.3462","2.NP1020.3348","2.NP1215.3349","2.NP2120.3299","2.NP3050.3350","2.NP3100/3100M.3369","2.NP3100J/3100JM.3370","2.NP3300/NP3300M.3371","2.NP6045.3351","2.NP6115.3352","2.NP6241.3353","2.NP6318.3354","2.NP6330.3355","2.NP6350.3356","2.NP7163/7164.3357","2.NP7214.3358","3.5627/5827.3335","3.5632/5832.3313","3.7650.3310","3.7660.3311","3.7670.3312","3.FT4015.3307","3.FT4422.3308","3.FT5640/5840.3364","3.FW750/760.3309","3.UF-A8585.3384","3.fax111.3386","3.fax188/180.3388","3.fax288.3385","3.fax3700L.3389","4.SF1020.3293","4.SF1025.3295","4.SF1116.3294","4.SF2030.3296","4.SF2040.3297","4.SF2052.3298","5.7713.3320","5.7715.3321","5.7718.3322","5.7722.3323","5.7728.3324","5.7735.3325","5.KX-F858CN.3410","5.KX-F868CN.3411","5.KX-F969CN.3412","5.KX-FP106CN.3406","5.KX-FP128CN.3407","5.KX-FT108CN.3402","5.KX-FT118CN.3408","5.KX-FT218CN.3409","5.KX-FT32CN.3401","5.UF-A8330.3413","5.UF-A8595.3414","5.UF-A8710.3415","5.UF-A8770.3416","5.UF-A8880.3417","5.UF-A8895.3418","6.EP1054.3339","6.EP1083.3340","6.EP1085.3341","6.EP2030.3346","6.EP3000.3342","6.EP4000.3345","6.EP5000.3343","6.EP6001.3344","7.1568.3300","7.2068.3301","7.2868/2878.3318","7.3560/3570.3319","7.4560.3302","8.1212.3303","8.1216.3304","8.2223.3305","8.3231.3306","8.3240.3366","9.5216.3379","9.5220.3382","9.5355.3380","9.5365.3381","9.7216.3372","9.7228.3374","9.7320.3373","9.7335.3375","9.7345.3376","9.7355.3377","9.7365.3378","11.DeskJet1120c.3465","11.DeskJet200cci.3466","11.DeskJet420c.3467","11.DeskJet610c.3468","11.DeskJet670c.3469","11.DeskJet695cci.3470","11.DeskJet710c.3471","11.DeskJet810c.3472","11.DeskJet830c.3473","11.DeskJet880c.3474","11.DeskJet895cxi.3475","11.DeskJet930c.3476","11.DeskJet950c.3477","11.DeskJet970cxi.3478","12.COLOR 1520K.3439","12.COLOR 3000.3440","12.COLOR 660.3441","12.COLOR 750.3442","12.COLOR 850.3443","12.DLQ-3000K.3480","12.EPL-5700L.3429","12.EPL-5800.3428","12.EPL-C8200.3427","12.LQ-1600K4.3430","12.LQ-1900KⅡ.3444","12.LQ-580K.3431","12.PHOTO 870.3424","12.PHOTO1270.3425","12.PRO 7000.3426","12.SCAN 2500.3432","12.color480.3423","12.color670.3422","14.SFX-127/227.3393","14.SFX-26.3391","14.SFX-28.3392","14.SFX-311.3394","14.SFX-P1050.3395","14.SFX-P1100.3396","14.SFX111.3405","14.SFX211.3404","14.SFX211H.3403","16.1270.3419","16.MFC-1850MC.3420","16.MFC-1970MC.3421");//
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
                <td height="28">用 户：
                  <input type="text" name="User" size="10" class="font1">
                  密 码：
                  <input type="password" name="Passwd" size="10" class="font1">
                    <a href="javascript:Login();"><img src="/images/temp/b_login.gif" width="41" height="15" border="0"></a> 
                    <a href="#"><img src="/images/temp/b_pw.gif" width="57" height="15" border="0"></a></td>
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
                      <tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B5%CD%CB%D9%B8%B4%D3%A1%BB%FA&Category=11&TypeId=3&LangCode=GB">低速复印机</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%D6%D0%CB%D9%B8%B4%D3%A1%BB%FA&Category=12&TypeId=3&LangCode=GB">中速复印机</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B8%DF%CB%D9%B8%B4%D3%A1%BB%FA&Category=13&TypeId=3&LangCode=GB">高速复印机</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B2%CA%C9%AB%B8%B4%D3%A1%BB%FA&Category=14&TypeId=3&LangCode=GB">彩色复印机</a></td>
</tr>
<tr align="center"><td height="18"><a href="ProductSearch.jsp?TypeId=3&LangCode=GB">更多...</a></td></tr>

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
                      <tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%BC%A4%B9%E2%B4%F2%D3%A1%BB%FA&Category=1&TypeId=1&LangCode=GB">激光打印机</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%C5%E7%C4%AB%B4%F2%D3%A1%BB%FA&Category=2&TypeId=1&LangCode=GB">喷墨打印机</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%D5%EB%CA%BD%B4%F2%D3%A1%BB%FA&Category=3&TypeId=1&LangCode=GB">针式打印机</a></td>
</tr>
<tr align="center"><td height="18"><a href="ProductSearch.jsp?TypeId=1&LangCode=GB">更多...</a></td></tr>

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
                      <tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%C6%D5%CD%A8%D6%BD%B4%AB%D5%E6%BB%FA&Category=31&TypeId=2&LangCode=GB">普通纸传真机</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%C8%C8%C3%F4%D6%BD%B4%AB%D5%E6%BB%FA&Category=32&TypeId=2&LangCode=GB">热敏纸传真机</a></td>
</tr>
<tr align="center"><td height="18"><a href="ProductSearch.jsp?TypeId=2&LangCode=GB">更多...</a></td></tr>

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
                      <tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%BA%DA%C9%AB%C4%AB%BA%D0&Category=41&TypeId=4&LangCode=GB">黑色墨盒</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B2%CA%C9%AB%C4%AB%BA%D0&Category=42&TypeId=4&LangCode=GB">彩色墨盒</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B4%F2%D3%A1%BD%E9%D6%CA&Category=43&TypeId=4&LangCode=GB">打印介质</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B8%B4%D3%A1%D6%BD%D5%C5&Category=44&TypeId=4&LangCode=GB">复印纸张</a></td>
</tr>
<tr align="center"><td height="18"><a href="ProductSearch.jsp?TypeId=4&LangCode=GB">更多...</a></td></tr>

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
                      <tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B8%B4%D3%A1%BB%FA%C1%E3%BC%FE&Category=60&TypeId=5&LangCode=GB">复印机零件</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B4%F2%D3%A1%BB%FA%C1%E3%BC%FE&Category=61&TypeId=5&LangCode=GB">打印机零件</a></td>
</tr>
<tr align="center">
<td height="18"><a href="ProductList.jsp?CateName=%B4%AB%D5%E6%BB%FA%C1%E3%BC%FE&Category=62&TypeId=5&LangCode=GB">传真机零件</a></td>
</tr>
<tr align="center"><td height="18"><a href="ProductSearch.jsp?TypeId=5&LangCode=GB">更多...</a></td></tr>

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
                           <option value='1'>施乐</option><option value='2'>佳能</option><option value='3'>理光</option><option value='4'>夏普</option><option value='5'>松下</option><option value='6'>美能达</option><option value='7'>东芝</option><option value='8'>柯尼卡</option><option value='9'>雷立</option><option value='10'>奥西</option><option value='11'>惠普</option><option value='12'>爱普生</option><option value='13'>利盟</option><option value='14'>三洋</option><option value='15'>三星</option><option value='16'>兄弟</option><option value='17'>OKI</option> 
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
    				
                    <tr align="center"> 
                      <td colspan="2">
                 	   
                       <a href="ProductDetail.jsp?ProdId=3494&LangCode=GB">
                       <img src="/hots/xk35c.jpg
" width="149" height="89" border="0"></a></td>
                       
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
                            <td width="129">施乐</td>
                          </tr>
                          <tr> 
                            <td width="22"><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                            <td width="129">XK35C彩色复印机</td>
                          </tr>
                          <tr> 
                            <td width="22"><img src="/images/temp/arrow_d.gif" width="13" height="6"></td>
                            <td width="129">价格: 4688</td>
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




</body>
</html>


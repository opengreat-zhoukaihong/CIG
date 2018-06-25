<jsp:useBean id="tLookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<script language="JavaScript">
<!--

provinceArrayQ = new Array(
<%=tLookUp.getFirstLookUp("select p.brandId,p.productno,P.prodid, C.cateName from product p ," + 
" brand b, category c where p.cateid = c.cateid and p.brandid = b.brandid and b.lang_code = 'GB' and p.typeid in (1,2,3,7,8,9) order by p.brandid,p.cateid, p.productno",3,"CateName")%>);//
  //cityArray = new Array("1.1.guangzhou.1","1.1.shenzheng.2","1.2.xiamen.3","1.2.fuzhou.4");
  dropDownItem = new String();
  function changeProvinceInfoQ(countryBox,provinceBox)
  {
    var countryItem = countryBox.selectedIndex;
    var itemCount;

    if(countryItem>0)
    {
      provinceBox.length=1;
      //cityBox.length=1;
      for(var i=0;i<provinceArrayQ.length;i++)
      {
        dropDownItemQ = provinceArrayQ[i].split(".");
        if(countryItem==dropDownItemQ[0])
        {
          itemCount = provinceBox.length;
          provinceBox.length += 1;
          provinceBox.options[itemCount].value = dropDownItemQ[2];
          provinceBox.options[itemCount].text = dropDownItemQ[1];
        }
      }
      if((document.fmQuery.NewProductNo.value==null)||(document.fmQuery.NewProductNo.value==""))
        provinceBox.selectedIndex = 1;
      else
        provinceBox.selectedIndex = document.fmQuery.NewProductNo.value;
    }
    else
    {
      provinceBox.selectedIndex = 1;
      //cityBox.selectedIndex = 1;
      provinceBox.length=1;
      //cityBox.length=1;
    }
  }

function saveProvinceQ()
{
  document.fmQuery.NewProductNo.value =     document.fmQuery.ProductNo.selectedIndex;
}

 

  function initAreaQ()
  {
    	changeProvinceInfoQ(document.fmQuery.Brand,document.fmQuery.ProductNo);

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

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

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

//-->
</script>

<table border=0 cellpadding=0 cellspacing=0 width=752>
  <tbody> 
  <tr> 
    <td width=752> 
      <table border=0 cellpadding=0 cellspacing=0 width=725>
        <tbody> 
        <tr> 
          <td width=283><a 
            href="index.jsp"><img border=0 
            height=25 src="/images/temp/head_up_1.gif" width=283></a></td>
          <td width=17><img height=25 
                  src="/images/temp/head_menu_1.gif" width=17></td>
          <td width=413 background="/images/temp/dt.gif"><img src="/images/temp/ico.gif" width="8" height="10" name="pic1"><a href="index.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic1','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">首页</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic2"><a href="ProductCentre.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic2','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">产品中心</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic3"><a href="OrderOnLine.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic3','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">在线订购</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic4"><a href="registration.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic4','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">用户注册</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic5"><a href="MyEoa.jsp?LangCode=GB" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic5','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">MYEOA</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic6"><a href="../service.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic6','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">客户服务</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic7"><a href="../dealer.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic7','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">经销商</font></a><img src="/images/temp/ico.gif" width="8" height="10" name="pic8"><a href="../about.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('pic8','','/images/temp/ico1.gif',1)"><font color="#FFFFFF">关于我们</font></a> 
          </td>
          <td align=right width=12 background="/images/temp/dt.gif"><img height=25 
                  src="/images/temp/head_menu_2.gif" 
              width=8></td>
        </tr>
        </tbody> 
      </table>
    </td>
  </tr>
  <tr> 
    <td width=752> 
      <table border=0 cellpadding=0 cellspacing=0 height=46 width=726>
        <tbody> 
        <tr> 
          <td width=283 valign="top"><img height=46 src="/images/temp/head_dn_1.gif" 
            width=283></td>
          <td width="443"> 
            <table background=/images/temp/head_dn_2.gif border=0 
            cellpadding=0 cellspacing=0 height=46 width=398>
              <form action="" method=post name=fmQuery>
                <tr align="right"> 
                  <td height=28>品 牌 
                    <select name=Brand 
                  onChange=changeProvinceInfoQ(Brand,ProductNo) size=1>
                      <option 
                    selected value=0>-请选择-</option>
                    <%=tLookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
                    </select>
                    型 号 
                    <select name=ProductNo onBlur="saveProvinceQ()" >
                      <option selected value=0>-请选择-</option>
                    </select>
                    <input type="hidden" name="NewProductNo">
                    <a 
                  href="javascript:Query()"><img border=0 height=15 
                  src="/images/temp/b_searchTitle.gif" width=41></a> <a 
                  href="index.jsp"><img border=0 height=15 
                  src="/images/temp/b_login.gif" width=41></a> </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
        </tbody> 
      </table>
    </td>
  </tr>
  </tbody> 
<%tLookUp.CloseStm();%>
</table>

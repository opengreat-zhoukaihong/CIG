<jsp:useBean id="tLookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<script language="JavaScript">
<!--
provinceArray = new Array(
<%=tLookUp.getFirstLookUp("select p.brandId,p.productno,P.prodid, C.cateName from product p ," + 
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

<table width=665 border=0 cellspacing=0 cellpadding=0 >  <tr>     <td width=665>       <table width=667 border=0 cellspacing=0 cellpadding=0 height=25>        <tr>           <td width=283><a href=/chinaeoa/index.jsp><img src=/images/temp/head_up_1.gif width=283 height=25 border=0></a></td>          <td>             <table width=384 border=0 cellspacing=0 cellpadding=0>              <tr>                 <td width=17><img src=/images/temp/head_menu_1.gif width=17 height=25></td>                <td width=358>                   <table width=358 border=0 cellspacing=0 cellpadding=0 height=25>                    <tr>                       <td width=358>                         <table width=358 border=0 cellspacing=0 cellpadding=0>                          <tr>                             <td width=38><a href=/chinaeoa/index.jsp onMouseOver=imgOn('img1') onMouseOut=imgOff('img1')><img src=/images/temp/menu_1.gif width=38 height=22 border=0 name=img1></a></td>                            <td width=61> <a href=/chinaeoa/ProductCentre.jsp?LangCode=GB onMouseOver=imgOn('img3') onMouseOut=imgOff('img3')><img src=/images/temp/menu_3.gif width=61 height=22 border=0 name=img3></a></td>                            <td width=61><a href=/chinaeoa/registration.jsp onMouseOver=imgOn('img2') onMouseOut=imgOff('img2')><img src=/images/temp/menu_2.gif width=61 height=22 border=0 name=img2></a></td>                            <td width=62> <a href=/service.htm onMouseOver=imgOn('img5') onMouseOut=imgOff('img5')><img src=/images/temp/menu_5.gif width=62 height=22 border=0 name=img5></a></td>                            <td width=74><a href=/dealer.htm onMouseOver=imgOn('img4') onMouseOut=imgOff('img4')><img src=/images/temp/menu_4.gif width=74 height=22 border=0 name=img4></a></td>                            <td width=62> <a href=/about.htm onMouseOver=imgOn('img6') onMouseOut=imgOff('img6')><img src=/images/temp/menu_6.gif width=62 height=22 border=0 name=img6></a></td>                          </tr>                        </table>                      </td>                    </tr>                    <tr>                       <td height=3 width=362><img src=/images/temp/head_menu_3.gif width=358 height=3></td>                    </tr>                  </table>                </td>                <td align=right width=9><img src=/images/temp/head_menu_2.gif width=9 height=25></td>              </tr>            </table>          </td>        </tr>      </table>    </td>  </tr>  <tr>     <td width=665>       <table width=667 border=0 cellspacing=0 cellpadding=0 height=46>        <tr>           <td width=283><img src=/images/temp/head_dn_1.gif width=283 height=46></td>          <td>             <table width=384 border=0 cellspacing=0 cellpadding=0 height=46 background=/images/temp/head_dn_2.gif>              <form name="fmQuery" method="post" action="">                <tr>                   
                  <td height=28>品 牌 
                    <select name="Brand" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                      <option value="0" selected>-请选择-</option>
                      <%=tLookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
                    </select>
                    型 号
<select name="ProductNo" >
                      <option value="0" selected>-请选择-</option>
                    </select>
                    <a href="javascript:Query()"><img src="/images/temp/b_search.gif" width="44" height="17" border="0"></a> 
                  </td>
                </tr>                <tr>                   <td>&nbsp;</td>                </tr>              </form>            </table>          </td>        </tr>      </table>    </td>  </tr></table>

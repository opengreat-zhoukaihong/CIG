<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<html>
<head>
<script language="JavaScript">
<!--
 function SetValue()
 {
   fmAdd.Dir1.value = fmAdd.PicDir1.options[fmAdd.PicDir1.selectedIndex].text;
  // alert(fmAdd.Dir1.value);
 }

 function Add()
{
  if (fmAdd.Brand.value == 0)
  {
    alert("请选择品牌");
    return;
  }
  if (fmAdd.ProductNo.value == "" )
  {
    alert("请输入型号");
    return;
  }
  if (fmAdd.Type.value == 0)
  {
    alert("请选择大类");
	return;
  }
  
  if (fmAdd.Category.value == 0)
  {
    alert("请选择小类");
    return;
  }
  if (fmAdd.ListPrice.value == "")
  {
    alert("请输入网下价格");
    return;
  }
  
 
  fmAdd.submit();
 
}
function show()
{
   alert("fdgkdfjg");
  alert(fmAdd.file1.vlaue);
}
//-->
</script>

<script language="JavaScript">
<!--
provinceArray = new Array(
<%=LookUp.getDynamicLookUp("select c.typeid,c.CateName,c.CateId from category c ," + 
" Prod_type p where p.typeid = c.typeid and c.lang_code = 'GB'  order by typeid, cateid",3)%>);//
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

<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="497" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td rowspan="2">&nbsp;</td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr> 
    <td> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF 
      cellpadding=5 cellspacing=2 width=506>
        <form  name="fmAdd" method="post" action="/chinaeoa/eoa-bst/InsertProd.jsp" ENCTYPE="multipart/form-data">
          <tr bgcolor="#FFFFFF"> 
            <td height="30" colspan="4" align="center"><b>添加产品</b></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">品牌：</td>
            <td width="137"> 
              <select name="Brand" size="1"  onChange="Show()">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
              </select>
              <font color="#CC0000">*</font></td>
            <td align="center" width="78">型号：</td>
            <td width="149"> 
              <input type="text" name="ProductNo" size="15" class="font1">
              <font color="#CC0000">*</font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">大类：</td>
            <td width="137"> 
              <select name="Type" size="1"  onChange="changeProvinceInfo(Type,Category)">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select * from Prod_Type  where lang_code = 'GB' order by typeid","name","typeid")%> 
              </select>
              <font color="#CC0000">*</font> </td>
            <td align="center" width="78">小类：</td>
            <td width="149"> 
              <select name="Category" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                <option value="0" selected>-请选择-</option>
              </select>
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">网上价格：</td>
            <td width="137"> 
              <input type="text" name="ListPrice" size="15" class="font1">
              <font color="#CC0000">*</font> </td>
            <td align="center" width="78">一级代理价：</td>
            <td width="149"> 
              <input type="text" name="Price1" size="15" class="font1">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">二级代理价：</td>
            <td width="137"> 
              <input type="text" name="Price2" size="15" class="font1">
            </td>
            <td align="center" width="78">三级代理价：</td>
            <td width="149"> 
              <input type="text" name="Price3" size="15" class="font1">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">四级代理价：</td>
            <td width="137"> 
              <input type="password" name="Price4" size="15" class="font1">
            </td>
            <td align="center" width="78">五级代理价：</td>
            <td width="149"> 
              <input type="text" name="Price5" size="15" class="font1">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">经销商：</td>
            <td> 
              <select name="Supplier" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select m.compname, s.supplierId from member_l m, supplier s where m.memberid = s.memberid and m.lang_code='GB' order by supplierId","CompName","SupplierId")%> 
              </select>
              <font color="#CC0000">*</font> <img src="/images/spacer.gif" width="15" height="8"></td>
            <td align="center">产品名称：</td>
            <td>
              <input type="text" name="ProdName" size="15" class="font1">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">图片目录：</td>
            <td colspan="2"> 
              <select name="PicDir1" size="1" onChange="SetValue()" >
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select * from dir_setting  order by Dirid","Dir","DirId")%> 
              </select>
            </td>
            <td> 
              <input type="hidden" name="Dir1">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82" height="44">图片文件[1]：</td>
            <td colspan="2" height="44"> 
              <input type="file" name="file1">
            </td>
            <td height="44">&nbsp;</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">图片文件[2]：</td>
            <td colspan="2"> 
              <input type="file" name="file2">
            </td>
            <td>&nbsp;</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82" height="89">简略说明：</td>
            <td colspan="3" height="89"> 
              <textarea name="ShortDesc" rows="3" cols="50"></textarea>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">详细说明：</td>
            <td colspan="3"> 
              <textarea name="Desc" rows="8" cols="50"></textarea>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="4" align="center" height="50"> <a href="Javascript:Add()"> 
              <img src="/images/temp/b_add.gif" name="cancel2" class="font1" width="80" height="17" border="0"> 
              </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:reset();"> 
              <input type="image" src="/images/temp/reset.gif" name="cancel" value="取   消" class="font1" width="80" height="17">
              </a> </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
<%LookUp.CloseStm(); %>
</body>
</html>

<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">
<!--
 function Login()
{
  
  fmLogin.submit();
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

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table border="0" cellspacing="0" cellpadding="10" width="460">
  <tr align="center"> 
    <td rowspan="2" height="67" width="98"> <img src="/images/spacer.gif" width="80" height="1"> 
    </td>
    <td width="428" height="4"></td>
  </tr>
  <tr align="center"> 
    <td width="428"> 
      <TABLE border=1 borderColorDark=#ffffff borderColorLight=#6666FF 
      cellPadding=5 cellSpacing=2 width=300>
        <form name="fmQuery" method="post" action="/chinaeoa/eoa-bst/bstProductList.jsp?LangCode=GB">
          <tr> 
            <td align="center" width="165" height="51">品牌：</td>
            <td colspan="3" width="203" height="51">
              <select name="Brand" size="1"  onChange="Show()">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
              </select>
            </td>
          </tr>
          <tr> 
            <td align="center" width="165" height="50">大类：</td>
            <td colspan="3" width="203">
              <select name="Type" size="1"  onChange="changeProvinceInfo(Type,Category)">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select * from Prod_Type  where lang_code = 'GB' order by typeid","name","typeid")%> 
              </select>
            </td>
          </tr>
          <tr> 
            <td align="center" width="165" height="50">小类：</td>
            <td colspan="3" width="203">
              <select name="Category" size="1" >
                <option value="0" selected>-请选择-</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td align="center" width="165" height="50">型号：</td>
            <td colspan="3" width="203"> 
              <input type="text" name="ProductNo" size="15" class="font1">
            </td>
          </tr>
          <tr> 
            <td colspan="4" align="center" height="50">
              <a href="javascript:fmQuery.submit();"><img src="/images/temp/b_search.gif" width="44" height="17" border="0"></a></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

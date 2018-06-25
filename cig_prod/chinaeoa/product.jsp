<html>
<head>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
<!--
provinceArray = new Array(
<%=LookUp.getDynamicLookUp("select p.brandId,p.productno,P.prodid from product p ," + 
" brand b where p.brandid = b.brandid and b.lang_code = 'GB' order by brandid",3)%>);//
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


<body bgcolor="#FFFFFF" >
<form action="/chinaeoa/Login.jsp">
    
  <p>品牌 
    <select name="Brand" size="1" onChange="changeProvinceInfo(Brand,ProductNo)">
      <option value="0" selected>-请选择-</option>
      <%=LookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
    </select>
  </p>
  <p> 型号 
    <select name="ProductNo" size="1">
      <option value="0" selected>-请选择-</option>
    </select>
  </p>
  <p> 
    <input type="submit" name="Submit" value="Submit">
  </p>
  <p>user 
    <input type="text" name="User">
  </p>
  <p>passwd 
    <input type="password" name="Passwd">
  </p>
  <p>&nbsp;</p>
</form>
</body>
</html>

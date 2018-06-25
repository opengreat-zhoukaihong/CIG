<%@ page import="java.sql.*" %>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<jsp:useBean id="ResultId" scope="page" class="com.cig.chinaeoa.ResultBean" />

<html>
<head>
<%
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");
String SQL = "";
String SelectName = "";
String DisplayField = "";
String ValueField = "";
String SpecId = "";
String SpecName = "";
SQL = "select * from spec where lang_code ='" + LangCode + "' and  typeid = '" + TypeId + "' order by specID";
ResultSet rs = ResultId.getRS(SQL);
%>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
<!--
provinceArray = new Array(
<%=LookUp.getDynamicLookUp("select p.brandId,p.productno,P.prodid from product p ," + 
" brand b where p.brandid = b.brandid and b.lang_code = '" + LangCode  + "' order by brandid",3)%>);//
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

</head>

<body bgcolor="#FFFFFF">
<form method="post" action="/chinaeoa/ProductList.jsp?TypeId=<%=TypeId%>&LangCode=<%=LangCode%>">
  <table width="50%" border="0">
    <tr> 
      <td width="107"><font size="2" color="#333333">品牌查询</font></td>
      <td width="191"><font size="2"> 
        <select name="Brand" size="1" onChange="changeProvinceInfo(Brand,ProductNo)">
          <option value="0" selected>-请选择-</option>
          <%=LookUp.getLookUp("select * from brand  where lang_code = '" +
            LangCode  + "' order by brandid","name","brandid")%>
        </select>
        </font></td>
    </tr>
    <tr> 
      <td width="107"><font size="2">产品型号</font></td>
      <td width="191"><font size="2"> 
        <select name="ProductNo" size="1">
          <option value="0" selected>-请选择-</option>
        </select>
        </font></td>
    </tr>
    <tr> 
      <td width="107"><font size="2" color="#333333">产品类别</font></td>
      <td width="191"><font size="2"> 
        <select name="Category">
          <option value="0" selected>-请选择-</option>
          <%=LookUp.getLookUp("select * from category  where lang_code = '" +
            LangCode  + "' and typeid='" + TypeId  + "' order by cateid","CateName","CateId")%>
        </select>
        </font></td>
    </tr>
    <tr> 
      <td width="107"><font size="2" color="#333333">价格范围</font></td>
      <td width="191"><font size="2"> 
        <select name="PriceRange">
          <option value="0" selected>查询价格</option>
          <option value="0~1000">1,000元以下</option>
          <option value="1000~2000">1,000~2,000元</option>
          <option value="2000~3000">2,000~3,000元</option>
          <option value="3000~4000">3,000~4,000元</option>
          <option value="4000~5000">4,000~5.000元</option>
          <option value="5000~6000">5,000~6,000元</option>
          <option value="6000~7000">6,000~7,000元</option>
          <option value="7000~8000">7,000~8,000元</option>
          <option value="8000~9000">8,000~9,000元</option>
          <option value="9000~10000">9,000~10,000元</option>
          <option value="10000~10000000">10,000元以上</option>
        </select>
        </font></td>
    </tr>
    <%
    if (rs==null)
    {
      out.println("rs=null");
    }
    else
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
    %>
  </table>
  <p> 
    <input type="submit" name="Submit" value="Submit">
    <input type="submit" name="Submit2" value="Submit">
  </p>
</form>
</body>
</html>

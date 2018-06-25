<%@ page import="java.sql.*,java.net.*" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />

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
    alert("请选择型号");
    return;
  }
  fmAdd.submit();
 
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

<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%
String ProdId = request.getParameter("ProdId");
String LangCode = request.getParameter("LangCode");
String ProdName = request.getParameter("ProdName");
String MainProdId = request.getParameter("ProductNo");
String Brand = "" ;
String CateName = "" ;
String ProductNo = "" ;
String SQL = "";
String OP = request.getParameter("OP");
if (ProdId != null)
{
  if ((OP != null) && OP.equals("A") && (MainProdId != null))
  {
    SQL = "insert into Prod_Part (ProdId, PartProdId) values (" + 
			MainProdId + "," + ProdId + ")";
    Result.IsExecute(SQL);
  }
  if ((OP != null) && OP.equals("D")) 
  {

    MainProdId = request.getParameter("MainProdId");
    if (MainProdId != null)
    {
      SQL = "delete from Prod_Part where prodid =" + 
			MainProdId + " and partprodid =" + ProdId;
      Result.IsExecute(SQL);
    }
  }
}

SQL = "select  p.*, b.name, c.catename from " +
          " product p, brand b, category c, prod_part pp where " +
          "  b.lang_code = '" + LangCode + "' and p.brandid = b.brandid  " +
          " and  p.cateid = c.cateid and c.lang_code = b.lang_code and pp.partprodid ='" +
           ProdId + "' and p.prodid = pp.prodid ";


//out.println(SQL);
%>

<table width="529" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td rowspan="2">&nbsp;</td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr> 
    <td> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF 
      cellpadding=5 cellspacing=2 width=517>
        <form  name="fmAdd" method="post" action="bstAddMain.jsp?OP=A&ProdId=<%=ProdId%>&ProdName=<%=URLEncoder.encode(ProdName)%>&LangCode=<%=LangCode%>" >
          <tr bgcolor="#D5EFFD"> 
            <td align="center" colspan="5">增添主产品 </td>
          </tr>
          <tr bgcolor="#FFFFFF" align="left"> 
            <td width="84" height="44">产品名称：</td>
            <td colspan="4" height="44"><%=ProdName%>&nbsp;</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="84">品牌：</td>
            <td width="82"> 
              <select name="Brand" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid")%> 
              </select>
            </td>
            <td align="center" width="41">型号：</td>
            <td width="150"> 
              <select name="ProductNo" >
                <option value="0" selected>-请选择-</option>
              </select>
            </td>
            <td width="91"><a href="Javascript:Add()"> 
              <input type="image"src="/images/temp/b_add.gif" name="cancel2" class="font1" width="80" height="17" border="0">
              </a></td>
          </tr>
          <tr bgcolor="#D5EFFD"> 
            <td align="center" colspan="5" height="24">主产品列表</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="84" height="24">品牌</td>
            <td colspan="2" height="24" align="center">类别</td>
            <td width="150" height="24" align="center">型号</td>
            <td width="91" height="24" align="center">&nbsp;</td>
          </tr>
		  <%
            ResultSet rs = Result.getRS(SQL);
            if (rs!=null)
			{
  				while (rs.next())
  				{			
    				Brand = rs.getString("Name");
    				CateName = rs.getString("CateName");
    				ProductNo = rs.getString("ProductNo");
                    MainProdId = rs.getString("ProdId");
  			     %>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="84" height="24"><%=Brand%></td>
            <td colspan="2" height="24" align="center"><%=CateName%></td>
            <td width="150" height="24" align="center"><%=ProductNo%></td>
            <td width="91" height="24" align="center"><a href="bstAddMain.jsp?MainProdId=<%=MainProdId%>&OP=D&ProdId=<%=ProdId%>&ProdName=<%=URLEncoder.encode(ProdName)%>&LangCode=<%=LangCode%>"><font color="#FF6666">删除</font></a></td>
          </tr>
		  <%   }
			}%>
        </form>
      </table>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<%
LookUp.CloseStm();
Result.CloseStm();
%>
</body>
</html>

<%@ include file="bstChkLogin.jsp"%>
<%@ page import="java.sql.*,java.net.*" %>
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

 function Update()
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

<%
String ProdId = request.getParameter("ProdId");
String LangCode = request.getParameter("LangCode");
String BrandId = "" ;
String TypeId = "" ;
String CateId = "" ;
String Supplier = "" ;
String ProductNo = "" ;
String PicDir1 = "";
String FileName1 = "";
String FileName2  = "";
String ListPrice = "";
String Price1 = "";
String Price2 = "";
String Price3 = "";
String Price4 = "";
String Price5 = "";
String ShortDesc = "";
String Desc = "";
String ProdName = "";
String ProdNameL = "";
String Status = "";
String Dir = "";

String SQL = "select l.shortdesc, l.descr,l.prod_name, p.*, b.name, c.catename, d.dir from " +
          " product p, product_l l, brand b, category c, dir_setting d  where p.prodid = l.prodid " +
          " and l.lang_code = '" + LangCode + "' and p.brandid = b.brandid and b.lang_code = l.lang_code " +
          " and  p.cateid = c.cateid and c.lang_code = l.lang_code and p.prodid ='" +
           ProdId + "' and  p.picdir1 = d.dirid(+) ";


ResultSet rs = Result.getRS(SQL);
//out.print(SQL);
if (rs!=null)
{
  if (rs.next())
  {
    Desc = rs.getString("descr");
       if (Desc == null)
         Desc = "";
    //out.print("Desc=" + Desc);
    BrandId = rs.getString("BrandId");
    TypeId = rs.getString("TypeId");
    CateId = rs.getString("CateId");
    Supplier = rs.getString("Supplier");
    ProductNo = rs.getString("ProductNo");
    ProdName = rs.getString("Name") + rs.getString("cateName") + ProductNo;
    //ProdNameL = rs.getString("Prod_Name");
    PicDir1 = rs.getString("PicDir1");
       if (PicDir1 == null)
         PicDir1 = "0";
    Dir = rs.getString("Dir");
       if (Dir == null)
         Dir = "";
    FileName1 = rs.getString("FileName1");
       if (FileName1 == null)
         FileName1 = "";
    FileName2 = rs.getString("FileName2");
       if (FileName2 == null)
         FileName2 = "";
    ListPrice = rs.getString("ListPrice");
       if (ListPrice == null)
         ListPrice = "";
	
	ProdNameL = rs.getString("Prod_name");
       if (ProdNameL == null)
         ProdNameL = "";
	
    Price1 = rs.getString("Price1");
       if (Price1 == null)
         Price1 = "";

    Price2 = rs.getString("Price2");
       if (Price2 == null)
         Price2 = "";

    Price3 = rs.getString("Price3");
       if (Price3 == null)
         Price3 = "";

    Price4 = rs.getString("Price4");
       if (Price4 == null)
         Price4 = "";

    Price5 = rs.getString("Price5");
       if (Price5 == null)
         Price5 = "";

    ShortDesc = rs.getString("ShortDesc");
       if (ShortDesc == null)
         ShortDesc = "";
    
    Status = rs.getString("Status");
    if (Status == null)
      Status = "N";

  }
}
else
{
  out.println(SQL);
}
//out.println(SQL);
%>

<table width="497" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td rowspan="2">&nbsp;</td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr> 
    <td> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF 
      cellpadding=5 cellspacing=2 width=506>
        <form  name="fmAdd" method="post" action="/chinaeoa/eoa-bst/UpdateProd.jsp" ENCTYPE="multipart/form-data">
          <tr bgcolor="#FFFFFF"> 
            <td height="30" colspan="3"><b>更新产品</b><a href="bstAddMain.jsp"><font color="#FF6666"> 
              </font></a></td>
            <td height="30" align="center"><a href="bstAddMain.jsp?ProdId=<%=ProdId%>&ProdName=<%=URLEncoder.encode(ProdName)%>&LangCode=<%=LangCode%>"><font color="#FF6666">增添主产品</font></a> 
              &nbsp;&nbsp;<a href="bstAddMain.jsp?ProdName=<%=URLEncoder.encode(ProdName)%>"><font color="#FF6666"> 
              </font></a><a href="bstAddSpec.jsp?TypeId=<%=TypeId%>&ProdId=<%=ProdId%>&amp;ProdName=<%=URLEncoder.encode(ProdName)%>&amp;LangCode=<%=LangCode%>"><font color="#FF6666">增添规格</font></a></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">品牌：</td>
            <td width="137"> 
              <select name="Brand" size="1"  onChange="Show()">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.setLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid",BrandId)%> 
              </select>
              <font color="#CC0000">*</font></td>
            <td align="center" width="78">型号：</td>
            <td width="149"> 
              <input type="text" name="ProductNo" size="15" class="font1" value="<%=ProductNo%>">
              <font color="#CC0000">*</font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">大类：</td>
            <td width="137"> 
              <select name="Type" size="1"  onChange="changeProvinceInfo(Type,Category)">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.setLookUp("select * from Prod_Type  where lang_code = 'GB' order by typeid","name","typeid",TypeId)%> 
              </select>
              <font color="#CC0000">*</font> </td>
            <td align="center" width="78">小类：</td>
            <td width="149"> 
              <select name="Category" size="1">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.setLookUp("select * from category  where lang_code = 'GB' and  typeid = "  + TypeId + "  order by Cateid","CateName","Cateid",CateId)%> 
              </select>
              <font color="#CC0000">*</font> </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">网上价格：</td>
            <td width="137"> 
              <input type="text" name="ListPrice" size="15" class="font1" value="<%=ListPrice%>">
              <font color="#CC0000">*</font> </td>
            <td align="center" width="78">一级代理价：</td>
            <td width="149"> 
              <input type="text" name="Price1" size="15" class="font1" value="<%=Price1%>">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">二级代理价：</td>
            <td width="137"> 
              <input type="text" name="Price2" size="15" class="font1" value="<%=Price2%>">
            </td>
            <td align="center" width="78">三级代理价：</td>
            <td width="149"> 
              <input type="text" name="Price3" size="15" class="font1" value="<%=Price3%>">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">四级代理价：</td>
            <td width="137"> 
              <input type="text" name="Price4" size="15" class="font1" value="<%=Price4%>">
            </td>
            <td align="center" width="78">五级代理价：</td>
            <td width="149"> 
              <input type="text" name="Price5" size="15" class="font1" value="<%=Price5%>">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">经销商：</td>
            <td> 
              <select name="Supplier" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.setLookUp("select m.compname, s.supplierId from member_l m, supplier s where m.memberid = s.memberid and m.lang_code='GB' order by supplierId","CompName","SupplierId",Supplier)%> 
              </select>
              <font color="#CC0000">*</font> <img src="/images/spacer.gif" width="15" height="8"></td>
            <td align="center">产品名称：</td>
            <td> 
              <input type="text" name="ProdName" size="15" class="font1" value="<%=ProdNameL%>">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">图片目录：</td>
            <td> 
              <select name="PicDir1" size="1" onChange="SetValue()" >
                <option value="0" selected>-请选择-</option>
                <%=LookUp.setLookUp("select * from dir_setting  order by Dirid","Dir","DirId",PicDir1)%> 
              </select>
            </td>
            <td align="center"> 产品状态： </td>
            <td> 
              <select name="Status" size="1">
                <% if (Status.equals("Y")) 
                   {
                     %> 
                <option value="Y" selected>有效</option>
                <option value="N">没效</option>
                    <%
                     }
                    else
                    { 
                     %>
                 <option value="Y" >有效</option>
                 <option value="N" selected>没效</option>    
                 <%}%>   
                 <%="Status=" + Status%>    
              </select>
              <input type="hidden" name="Dir1">
              <input type="hidden" name="ProdId" value="<%=ProdId%>">
              <input type="hidden" name="ProdName" value="<%=ProdName%>">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82" height="44">图片文件[1]：</td>
            <td colspan="2" height="44"> 
              <input type="file" name="file1">
              <br>
              <%=FileName1%> </td>
            <td height="44"><img src="/<%=Dir + FileName1%>" ></td>
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
              <textarea name="ShortDesc" rows="3" cols="50"><%=ShortDesc%></textarea>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="82">详细说明：</td>
            <td colspan="3"> 
              <textarea name="Desc" rows="8" cols="50"><%=Desc%></textarea>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="4" align="center" height="50"> <a href="javascript:Update();"> 
              <img src="/images/temp/b_update.gif" name="cancel2" value="取   消" class="font1" width="80" height="17" border="0"> 
              </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:reset();"> 
              <input type="image" src="/images/temp/reset.gif" name="cancel" value="取   消" class="font1" width="80" height="17">
              </a> </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
<%
LookUp.CloseStm();
Result.CloseStm();
%>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>

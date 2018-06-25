<%@ page import="java.sql.*,java.net.*" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
String ProdId = request.getParameter("ProdId");
String Location  = request.getParameter("Location");
String LangCode = request.getParameter("LangCode");

String StartDate  = request.getParameter("StartDate");
String EndDate = "" ;
String BrandId = "";
String PicDir1 = "";
String FileName1 = "";
String Dir = "";


String SQL = "Select s.*, c.cateName, p.productNo, b.name,p.brandid, d.dir from " + 
   " Speci_sale s, product p, brand b, category c, dir_setting d " +
   " where s.prodid = p.prodid and p.brandid = b.brandid and b.Lang_code ='GB' " +
   " and c.Lang_code=b.lang_Code and p.cateid = c.cateid and s.prodid = " + 
   ProdId + " and s.Location = '" + Location + "' and TO_CHAR(s.be_date,'YYYY-MM-DD') = '" + 
   StartDate + "' and s.picdir1 = d.dirid(+)"; 

ResultSet rs =  Result.getRS(SQL);
if (rs!=null)
{
  if (rs.next())
  {
    BrandId = rs.getString("BrandId");
    if (rs.getString("End_Date") != null)
      EndDate = rs.getDate("End_Date").toString();
    Location = rs.getString("Location");
    PicDir1 = rs.getString("PicDir1");
    FileName1 = rs.getString("FileName1");
    Dir = rs.getString("Dir");
    if (FileName1 == null)
      FileName1 = "";
  }
}
%>

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
  if (fmAdd.Brand.value == "0")
  {
    alert("请选择品牌");
    return;
  }
  if (fmAdd.ProductNo.value == "0" )
  {
    alert("请选择型号");
    return;
  }
  if (fmAdd.StartDate.value == "" )
  {
    alert("请输入开始日期");
    return;
  }
  if (fmAdd.PicDir1.value == "0")
  {
    alert("请选择目录");
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

<table width="497" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td rowspan="2">&nbsp;</td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr> 
    <td> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF 
      cellpadding=5 cellspacing=2 width=506>
        <form  name="fmAdd" method="post" action="bstUpdateHot.jsp" ENCTYPE="multipart/form-data">
          <tr bgcolor="#FFFFFF"> 
            <td height="30" colspan="4" align="center"><b>更新推荐产品</b></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="81" height="30">品牌：</td>
            <td width="140" height="30"> 
              <select name="Brand" size="1"  onChange="changeProvinceInfo(Brand,ProductNo)">
                <option value="0" selected>-请选择-</option>
                <%=LookUp.setLookUp("select * from brand  where lang_code = 'GB' order by brandid","name","brandid",BrandId)%> 
              </select>
              <font color="#CC0000">*</font></td>
            <td align="center" width="86" height="30">型号：</td>
            <td width="139" height="30"> <font color="#CC0000"> 
              <select name="ProductNo" >
                <option value="0" selected>-请选择-</option>
				<%=LookUp.setLookUp("select * from Product  where Brandid = " + BrandId + " and typeid in (1,2,3,7,8) order by TypeId, ProdId","ProductNo","ProdId",ProdId)%> 
              </select>
              *</font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="81" height="30">开始日期：</td>
            <td colspan="3" height="30"> 
              <input type="text" name="StartDate" size="15" class="font1" value="<%=StartDate%>">
              <font color="#CC0000">*</font><font color="#FF6666">YYYY-MM-DD </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="81" height="30">截止日期：</td>
            <td colspan="3" height="30"> 
              <input type="text" name="EndDate" size="15" class="font1" value="<%=EndDate%>">
              <font color="#FF6666">YYYY-MM-DD </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="81" height="30">显示位置：</td>
            <td colspan="3" height="30">
              <select name="Location" size="1" onChange="SetValue()" >
                <option value="F" <% if (Location.equals("F"))
                                       out.println("selected");%>>首页</option>
                <option value="P" <% if (Location.equals("P"))
                                       out.println("selected");%>>产品中心</option>
                <option value="S" <% if (Location.equals("S"))
                                       out.println("selected");%>>查找产品</option>
              </select>
              <font color="#CC0000">*</font> 
              <input type="hidden" name="OldLocation" value="<%=Location%>">
              <input type="hidden" name="OldProdId" value="<%=ProdId%>">
              <input type="hidden" name="OldStartDate" value="<%=StartDate%>">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="81">图片目录：</td>
            <td colspan="2"> 
              <select name="PicDir1" size="1" onChange="SetValue()" >
                <option value="0" selected>-请选择-</option>
                <%=LookUp.setLookUp("select * from dir_setting  order by Dirid","Dir","DirId",PicDir1)%> 
              </select>
              <font color="#CC0000">*</font> 
              <input type="hidden" name="Dir1">
            </td>
            <td width="139">&nbsp; </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="81" height="67">图片文件：</td>
            <td colspan="2" height="67"> 
              <p> 
                <input type="file" name="file1">
                <font color="#CC0000">*</font> <%=FileName1%></p>
              </td>
            <td height="67" width="139"><img src="/<%=Dir + FileName1%>"></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="4" align="center" height="30"> <a href="Javascript:Add()"> 
              <img src="/images/temp/b_update.gif" class="font1" width="80" height="17" border="0"> 
              </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:reset();"> 
              <img src="/images/temp/reset.gif" value="取   消" class="font1" width="80" height="17" border="0"> 
              </a> </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
<%
  LookUp.CloseStm();
  //Result.CloseStm();
 %>
</body>
</html>

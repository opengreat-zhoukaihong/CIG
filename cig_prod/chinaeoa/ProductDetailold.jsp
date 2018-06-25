<%@ page import="java.sql.*" %>
<jsp:useBean id="ResultId" scope="page" class="com.cig.chinaeoa.ResultBean" />
<html>
<head>
<title>佳能/Canon 喷墨打印机</title>
<style>
.d20{line-height:18pt;font-size:9pt}
a:link{text-decoration:none;color:#999fff}
a:visited{text-decoration:none;color:#650388}
a:hover{text-decoration:underline;color:red}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>

<body bgcolor="#ffffff" topmargin="0" leftmargin="10">
<table width="100%" border="0">
<%
   String wSql = "";
   String Descr = "";
   String Spec = "";
   String SpecDesc = "";
   String ShortDesc = "";
   String CategoryId = "";
   String CategoryName = "";
   String Brand = "";
   String ProductName = "";
   String ProductNo = "";
   String BrandId = "";
   String PicDir1 = "";
   String PicFile1 = "";
   String ListPrice = "";
   String MemberPrice = "";
   String MemberClass = "1";
   String ProdId = request.getParameter("ProdId");
   if (ProdId == null)
     ProdId = "78";
   wSql = "select l.shortdesc, l.descr, p.*, b.name, c.catename, d.dir from " +
          " product p, product_l l, brand b, category c, dir_setting d  where p.prodid = l.prodid " +
          " and l.lang_code = 'GB' and p.brandid = b.brandid and b.lang_code = l.lang_code " +
          " and  p.cateid = c.cateid and c.lang_code = l.lang_code and p.prodid ='" +
           ProdId + "' and  d.dirid = p.picdir1(+) ";
   ResultSet rs = ResultId.getRS(wSql);
   int i = 0;
   if (rs==null)
   {
     out.println("rs=null");
   }
   else
   {
     //out.println("con = true");
     while (rs.next())
     {
        Descr = rs.getString("Descr");
        ShortDesc = rs.getString("ShortDesc");
        CategoryName = rs.getString("CateName");
        CategoryId = rs.getString("CateId");
        BrandId = rs.getString("BrandId");
        Brand = rs.getString("Name");
        ProductNo = rs.getString("ProductNo");
        PicDir1 = rs.getString("Dir");
        PicFile1 = rs.getString("FileName1");
        ListPrice = rs.getString("ListPrice");
        MemberPrice = rs.getString("Price" + MemberClass);
        if (ListPrice == null)
          ListPrice = "价格未定";
        if (MemberPrice == null)
          MemberPrice = "价格未定";
        ProductName =  Brand + " " + ProductNo + CategoryName;
        if (PicDir1 == null)
          PicDir1 = "images/printer/canon/";
        if (PicFile1 == null)
          PicFile1 = "bjc50g.jpg";
        break;
     }
   }
   
%>
</table>

<a name="top"></a>
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="134" height="31"><img src="images/chinaeoa.jpg" width="134" height="46" alt="chinaeoa log"></td>
    <td width="621" height="31"><img src="images/PCEC_home_03.jpg" width="502" height="42" alt="advertisement"></td>
  </tr>
</table>
<br>
<table width="640" border="0" cellspacing="0" cellpadding="0" bgcolor="#A2BFF7" height="18" leftmargin="20">
  <tr>
    <td height="2"> 
      <div align="right"><font size="2"><b><font color="#99CC33" title="赶快申请吧">&nbsp;<a href="../../../dd/zc.htm" target="_blank">会员申请</a></font></b></font> 
        <img src="images/arrow.gif" width="7" height="11"> <font size="2"><b><font color="#99CC33"><font color="#996600"><a href="#">订单查询</a></font></font></b></font> 
        <img src="images/arrow.gif" width="7" height="11"> <font size="2"><b><font color="#99CC33" title="里边有什么好东西呢"><a href="#" onClick="MM_openBrWindow('../../../library/gwc_1.htm','我的购物车','width=625,height=350')">查看购物车</a></font></b></font> 
      </div>
    </td>
  </tr>
</table>
<%=PicDir1+PicFile1%>
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td rowspan="2" colspan="2"> 
      <div align="center"><img src="<%=PicDir1+PicFile1%>" width="268" height="120" alt="佳能/Canon BJ-30喷墨打印机"></div>
    </td>
    <td width="36" rowspan="2">&nbsp;</td>
    <td width="324"><img src="images/intro.gif" width="93" height="23" alt="intro.gif"></td>
  </tr>
  <tr> 
    <td width="324" height="74"><span class="d20">
      <%
      while (ShortDesc.indexOf("\n")>=0)
      {
        i = ShortDesc.indexOf("\n");
        SpecDesc = ShortDesc.substring(0,i).trim();
        ShortDesc = ShortDesc.substring(i+1);
        out.println(SpecDesc + "<br>");
      }
      out.println(ShortDesc);
      %>
      </span></td>
  </tr>
  <tr> 
    <td colspan="2" height="17"> 
      <div align="center"><font size="2" color="#333333">
      <%=ProductName%>
      </font></div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2"></font></div>
    </td>
  </tr>
  <tr> 
    <td width="54" height="20">&nbsp;</td>
    <td width="226" height="20"><font size="2" color="#336600">
    <i><font color="#996600">网上价格</font><font color="#CC6633">：</font></i>
    </font><font size="2" color="#333333"><%=ListPrice%>元</font></td>
    <td colspan="2">
      <div align="right"><font size="2"><a href="#one">规格&nbsp;&nbsp;&nbsp;&lt;&lt;</a></font></div>
    </td>
  </tr>
  <tr> 
    <td width="54">&nbsp;</td>
    <td width="226"><font size="2" color="#009900">
    <i><font color="#996600">代理价格</font></i></font><font color="#996600"><i><font size="2">：</font></i>
    </font><font size="2" color="#333333"><%=MemberPrice%>元</font></td>
    <td colspan="2">
      <div align="right"><font size="2"><a href="#">耗材&nbsp;&nbsp;&nbsp;&lt;&lt;</a></font></div>
    </td>
  </tr>
  <tr> 
    <td height="19" width="54">&nbsp;</td>
    <td height="19" width="226"> 
      <div align="right"><img src="images/web3.gif" width="14" height="15" border="0"><font size="2"><i> 
        <a href="#">放进购物车</a></i></font> </div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2"><a href="#">选购件 &lt;&lt;</a></font></div>
    </td>
  </tr>
</table>
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="2" colspan="2"><font size="2"><i><font color="red"><font color="#ff0000">本系列其它商品</font></font></i></font></td>
  </tr>
  <tr> 
    <td height="2" colspan="2"> 
      <hr>
    </td>
  </tr>
  <tr> 
    <td width="91" height="91">&nbsp;</td>
    <td width="665" height="91"> 
      <table width="500" border="1" cellspacing="0" cellpadding="0" bordercolor="#CCCCFF">
      <%
      rs = ResultId.getRS("select l.ShortDesc, l.Descr, p.*, b.name, c.catename from " +
          " product p, product_l l, brand b, category c  where p.prodid = l.prodid and " +
          " l.lang_code = 'GB' and p.brandid = '" + BrandId + "' and p.cateid = '" +
          CategoryId  +  "' and " + " p.prodId <> '" + ProdId + "' and " +
          " p.brandid = b.brandid and b.lang_code = l.lang_code and  " +
          " p.cateid = c.cateid and c.lang_code = l.lang_code ");
      if (rs==null)
      {
        out.println("rs=null");
      }
      else
     {
       //out.println("con = true");
       while (rs.next())
       {
         CategoryName = rs.getString("CateName");
         Brand = rs.getString("Name");
         ProdId = rs.getString("ProdId");
         ProductNo = rs.getString("ProductNo");
         ProductName =  Brand + " " + ProductNo + CategoryName;
         %>
         <tr>
          <td width="235" height="21"><font size="2"><img src="images/dianc.gif" width="15" height="15">
            <a href="/chinaeoa/ProductDetail.jsp?ProdId=<%=ProdId%>"><%=ProductName%></a></font></td>
         <%
         if (rs.next())
         {
           CategoryName = rs.getString("CateName");
           Brand = rs.getString("Name");
           ProductNo = rs.getString("ProductNo");
           ProductName =  Brand + " " + ProductNo + CategoryName;
         }
         else
           ProductNo = "&nbsp;";
         %>
          <td width="259" height="21"><font size="2"><img src="images/dianc.gif" width="15" height="15">
            <a href="/chinaeoa/ProductDetail.jsp?ProdId=<%=ProdId%>"><%=ProductName%></a></font></td>
        </tr>
        <%
       }
      }
      %>

      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="2">
      <hr>
    </td>
  </tr>
</table>
<br>
<table width="639" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="45" height="30">&nbsp;</td>
    <td width="594" height="30"><a name="one"></a><img src="images/rule.gif" width="93" height="23"></td>
  </tr>
  <tr> 
    <td width="45" rowspan="3">&nbsp;</td>
    <td rowspan="2" width="594"> 
     
        <table border="0" cellspacing="1" cellpadding="0" width="536">
  <%
   if (Descr == "")
   {
     out.println("Descr = null");
   }
   else
   {
     boolean DisplayColor = false;
     String ColorName = "#FFBBDD";
     Descr = Descr + "\n";
     while (Descr.indexOf("\n")>=0)
     {
       i = Descr.indexOf("\n");
       SpecDesc = Descr.substring(0,i).trim();
       Descr = Descr.substring(i+1);
       if (SpecDesc.indexOf("|") >= 0)
       {
         i = SpecDesc.indexOf("|");
         Spec = SpecDesc.substring(0,i).trim();
         SpecDesc = SpecDesc.substring(i + 1).trim();
         if (DisplayColor)
         {
           ColorName = "#FFBBDD";
           DisplayColor = false;
         }
         else
         {
           ColorName = "#FEE7F5";
           DisplayColor = true;
         }
       }
       else
       {
         Spec = "&nbsp;";
       }
       %>
       <tr bgcolor="<%=ColorName%>">
            <td colspan="2"><font size="2"><%=Spec%></font></td>
            <td width="410"><font size="2"><%=SpecDesc%></font></td>
       </tr>
       <%
     }
   }
   %>
         
        </table>
 
    </td>
  </tr>
  <tr> </tr>
  <tr> 
    <td width="594"> 
      <div align="center"><a href="#top"><img src="images/top.gif" width="82" height="19" border="0" alt="Click here to Top!"></a></div>
    </td>
  </tr>
</table>
<%=Descr%>
</body>
</html>

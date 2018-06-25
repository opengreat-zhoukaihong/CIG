<%@ page import="java.sql.*" %>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
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
   String TypeId = "";
   String ProdId = request.getParameter("ProdId");
   String LangCode = request.getParameter("LangCode");
   String ColorName;
   String ImageFile;
   String MemberId  = (String)session.getValue("cneoa.MemberId");
   boolean HasPart4 = false;
   boolean HasPart5 = false;
   boolean HasPart6 = false;
   if (MemberId == null)
     MemberId = "";
   String MemberType = (String)session.getValue("cneoa.MemberType");
   if (MemberType == null)
     MemberType = "";
   String UserLevel = (String)session.getValue("cneoa.UserLevel");

   if (ProdId == null)
     ProdId = "78";
   wSql = "select l.shortdesc, l.descr, p.*, b.name, c.catename, d.dir,m.class from " +
          " product p, product_l l, brand b, category c, dir_setting d, payment m  where p.Status='Y' and p.prodid = l.prodid " +
          " and l.lang_code = '" + LangCode + "' and p.brandid = b.brandid and b.lang_code = l.lang_code " +
          " and  p.cateid = c.cateid and c.lang_code = l.lang_code and p.prodid ='" +
           ProdId + "' and  p.picdir1 = d.dirid(+) and p.supplier = m.supplierid(+) and m.memberid(+) = '" +
					 MemberId + "'";
   ResultSet rs = Result.getRS(wSql);
   int i = 0;
   if (rs==null)
   {
     out.println("rs=null");
   }
   else
   {
     //out.println("con = true");
     if (rs.next())
     {
        Descr = rs.getString("Descr");
        ShortDesc = rs.getString("ShortDesc");
              if (ShortDesc == null)
                ShortDesc = "";
        MemberClass = rs.getString("Class");
        CategoryName = rs.getString("CateName");
        CategoryId = rs.getString("CateId");
        BrandId = rs.getString("BrandId");
        Brand = rs.getString("Name");
        ProductNo = rs.getString("ProductNo");
        PicDir1 = rs.getString("Dir");
        PicFile1 = rs.getString("FileName1");
        ListPrice = rs.getString("ListPrice");
        TypeId = rs.getString("TypeId");
        if (MemberClass != null)
          MemberPrice = rs.getString("Price" + MemberClass);
        else
          MemberPrice = ListPrice;
        if (ListPrice == null || ListPrice.equals("0"))
          ListPrice = "面议";
        if (MemberPrice == null || MemberPrice.equals("0"))
          MemberPrice = "面议";
        ProductName =  Brand + " " + ProductNo + CategoryName;
    
     }
   }
   
%>

<html><!-- #BeginTemplate "/Templates/ceoa1.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ChinaEOA.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
<script
language="JavaScript">
<!--

function Order(ProdId)
{
   for (j=0;j<fmList.elements.length;++j)
   { 
       if ((fmList.elements[j].type == "text") && (fmList.elements[j].name == ProdId))
      {
      	   if ((fmList.elements[j].value == "") || (fmList.elements[j].value == "0"))           
	    {
         alert ("请输入订购数量!");
          return;
          }
        else
          openorder("/chinaeoa/AddOrder.jsp?Type=A&LangCode=<%=LangCode%>&ProdId=" + ProdId + "&Qty=" + fmList.elements[j].value);
       }
       
  }

}

function OrderPart(ProdId)
{
   for (j=0;j<fmPart.elements.length;++j)
   { 
       if ((fmPart.elements[j].type == "text") && (fmPart.elements[j].name == ProdId))
      {
      	   if ((fmPart.elements[j].value == "") || (fmPart.elements[j].value == "0"))           
	    {
         alert ("请输入订购数量!");
          return;
          }
        else
          openorder("/chinaeoa/AddOrder.jsp?Type=A&LangCode=<%=LangCode%>&ProdId=" + ProdId + "&Qty=" + fmPart.elements[j].value);
       }
       
  }
}

function openorder(url)
{   
  OpenWindow=window.open(url, "win1", "height=300 width=600,toolbar=no,scrollbars=yes,menubar=no,resize=yes");
}



function imgOn (imgName) {
if (document.images) {
document[imgName].src = eval (imgName + "on.src");
}
}
function imgOff (imgName) {
if (document.images) {
document[imgName].src = eval(imgName + "off.src");
}
}
function MM_preloadImages() { //v3.0
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr> 
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<%@ include file="title.jsp"%>
<table width="640" border="0" cellspacing="0" cellpadding="0" >
  <tr> 
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" colspan="2"><!-- #BeginEditable "body" --> 
      <table border="0" cellspacing="0" cellpadding="0" align="center" width="600">
        <tr> 
          <td colspan="2" height="20"> <img src="/images/temp/path.gif" width="49" height="13"> 
            <img src="/images/arrow.gif" width="7" height="11"> <a href="index.jsp">首页</a> 
            <img src="/images/arrow.gif" width="7" height="11"> <font title="里边有什么好东西呢"><a href="ProductCentre.jsp?LangCode=GB">产品中心</a> 
            </font> <font title="里边有什么好东西呢"><img src="/images/arrow.gif" width="7" height="11"></font> 
            <a href="javascript:history.go(-1);">产品列表</a> <font title="里边有什么好东西呢"><img src="/images/arrow.gif" width="7" height="11"></font> 
            产品详情</td>
        </tr>
      </table>
      <table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td> <a name="top"></a> 
            <table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr align="right"> 
                <td colspan="2"> <img src="/images/temp/car.gif" width="19" height="16" align="absbottom"> 
                  <a href="#" onClick="openorder('AddOrder.jsp?LangCode=<%=LangCode%>')">查看购物车</a></td>
              </tr>
            </table>
            <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
	         <form name="fmList" >
              <tr> 
                <td colspan="2" rowspan="2" valign="top" align="center">
                  <%
                    if (PicDir1 == null)
                      PicDir1 = "";
                    ImageFile = PicDir1+PicFile1;
                    if (PicFile1 != null)
                      out.println("<img src=\"/" + ImageFile + "\"  >");
                    else
                      out.println("暂无图片");
                  %>
                </td>
                <td rowspan="2" width="35">&nbsp;</td>
                <td width="314"><img src="/images/intro.gif" width="93" height="23"></td>
              </tr>
              <tr> 
                <td width="314" height="127" valign="top"> 
                  <p class="d20"> <%
                  while (ShortDesc.indexOf("\n")>=0)
                  {
                    i = ShortDesc.indexOf("\n");
                    SpecDesc = ShortDesc.substring(0,i).trim();
                    ShortDesc = ShortDesc.substring(i+1);
                    out.println(SpecDesc + "<br>");
                  }
                  out.println(ShortDesc);
                  %> </p>
                </td>
              </tr>
              <tr> 
                <td colspan="2" align="center"><%=ProductName%></td>
                <td colspan="2">&nbsp; </td>
              </tr>
              <tr> 
                <td width="100" rowspan="2">&nbsp;</td>
                <td width="191">&nbsp;</td>
                <td align="right" rowspan="3" colspan="2"> <a href="#three"> </a>
                  <%
                    rs = Result.getRS("select pp.partprodid  from prod_part pp, product p " +
			" where pp.partprodid = p.prodid and p.typeid = 4 and " +
			" pp.prodid = " + ProdId ); 
		    if (rs != null && rs.next())
		      HasPart4 = true;
		    rs = Result.getRS("select pp.partprodid  from prod_part pp, product p " +
			" where pp.partprodid = p.prodid and p.typeid = 6 and " +
			" pp.prodid = " + ProdId ); 
		    if (rs != null && rs.next())
		      HasPart6 = true; 
			rs = Result.getRS("select pp.partprodid  from prod_part pp, product p " +
			" where pp.partprodid = p.prodid and p.typeid = 5 and " +
			" pp.prodid = " + ProdId ); 
		    if (rs != null && rs.next())
		      HasPart5 = true; 
                  %>
                    <table width="300" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td rowspan="3" width="172"> 
                          <table width="150" border="0" cellspacing="0" cellpadding="0" align="left">
                            <tr> 
                              <td width="191">数量： 
                                <input type="text" name="<%=ProdId%>" class="font1" size="8">
                                件 </td>
                            </tr>
                            <tr align="center"> 
                              <td width="191"><a href="javascript:Order(<%=ProdId%>);"><img src="/images/temp/order.gif" width="90" height="17" border="0"></a></td>
                            </tr>
                          </table>
                        </td>
                        <td width="78" align="right"><a href="#one">规格&nbsp;&nbsp;&nbsp;&lt;&lt;</a> 
                          <a href="#two"> </a> <a href="#two"></a></td>
                      </tr>
                      <tr> 
                        <td width="78" align="right"><a href="#two"> <%if (HasPart4) 
                       		out.println("耗材&nbsp;&nbsp;&nbsp;&lt;&lt;");%> </a> 
                          <a href="#three"></a></td>
                      </tr>
                      <tr> 
                        <td width="78" align="right"><a href="#three"> <%if (HasPart6) 
                       		out.println("选购件 &lt;&lt;");%></a></td>
                      </tr>
                      <tr>
                        <td width="172">&nbsp;</td>
                        <td width="78" align="right"><a href="PartList.jsp?ProdId=<%=ProdId%>&LangCode=<%=LangCode%>"><%if (HasPart5) 
                       		out.println("零件&nbsp;&nbsp;&nbsp;&lt;&lt;");%></a></td>
                      </tr>
                    </table>
                </td>
              </tr>
              <tr> 
                <td width="191">网上价格：<%=ListPrice + "  [元]"%>  </td>
              </tr>
              <tr> 
                <td width="100">&nbsp;</td>
                <td width="191"><%if (MemberType.equals("4"))
					out.println("代理价格：" + MemberPrice + "  [元]");%></td>
              </tr>
                     </form>
            </table>
            <% if (!(TypeId.equals("4") || TypeId.equals("5")))
                {
                  %> 
            <table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr align="right"> 
                <td class="font3">&nbsp;</td>
              </tr>
              <tr> 
                <td class="font3">本系列其它商品</td>
              </tr>
              <tr> 
                <td> 
                  <hr >
                </td>
              </tr>
              <tr> 
                <td width="565"> 
                  <table border="1" cellspacing="2" cellpadding="0" bordercolor="#666666" width="600">
                    <%
                      rs = Result.getRS("select l.ShortDesc, l.Descr, p.*, b.name, c.catename from " +
                        " product p, product_l l, brand b, category c  where p.Status='Y' and p.prodid = l.prodid and " +
                        " l.lang_code = '" + LangCode + "' and p.brandid = '" + BrandId + "' and p.cateid = '" +
                        CategoryId  +  "' and " + " p.prodId <> '" + ProdId + "' and " +
                        " p.brandid = b.brandid and b.lang_code = l.lang_code and  " +
                        " p.cateid = c.cateid and c.lang_code = l.lang_code ");
                      if (rs != null)
                      {
                        //out.println("con = true");
                        String ConProdId = "";
                        while (rs.next())
                        {
                          CategoryName = rs.getString("CateName");
                          Brand = rs.getString("Name");
                          ConProdId = rs.getString("ProdId");
                          ProductNo = rs.getString("ProductNo");
                          ProductName =  Brand + " " + ProductNo + CategoryName;
                          %>
                          <tr>
                          <td><img src="/images/dianc.gif" width="15" height="15">
                            <a href="/chinaeoa/ProductDetail.jsp?ProdId=<%=ConProdId%>&LangCode=<%=LangCode%>"><%=ProductName%></a></td>

                          <%
                          if (rs.next())
                          {
                            CategoryName = rs.getString("CateName");
                            Brand = rs.getString("Name");
                            ConProdId = rs.getString("ProdId");
                            ProductNo = rs.getString("ProductNo");
                            ProductName =  Brand + " " + ProductNo + CategoryName;
                          }
                          else
                            ProductName = "&nbsp;";
                          %>
                          <td><img src="/images/dianc.gif" width="15" height="15">
                            <a href="/chinaeoa/ProductDetail.jsp?ProdId=<%=ConProdId%>&LangCode=<%=LangCode%>">
               			<%=ProductName%></a></td>
                          </tr>
                          <%
                        }
                      }
                    %>
                  </table>
                </td>
              </tr>
              <tr> 
                <td> 
                  <hr  >
                </td>
              </tr>
            </table>
            <%}%>
            
            <table width="500" cellspacing="0" cellpadding="2" border="0">
              <tr> 
                <td rowspan="11" width="78">&nbsp;</td>
                <td colspan="2" width="560"><a name="one"></a></td>
              </tr>
              <tr> 
                <td height="14" colspan="2" width="560"><img src="/images/rule.gif" width="93" height="23"></td>
              </tr>
              <tr> 
                <td height="31" colspan="2" width="560"> 
                  <table border=0 cellpadding=2 cellspacing=2 width="600">
                    <tbody>
   <%
   if ((Descr != "") && (Descr !=null))
   {
     boolean DisplayColor = false;
     ColorName = "#DDF1FF";
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
         if (ColorName.equals("#B0D3FF"))
           ColorName = "#DDF1FF";
         else
           ColorName = "#B0D3FF";
       }
       else
       {
         Spec = "&nbsp;";
       }
       %>
       <tr bgcolor="<%=ColorName%>">
            <td ><%=Spec%></td>
            <td ><%=SpecDesc%></td>
       </tr>
       <%
     }
   }
   %>


                    </tbody>
                  </table>
                </td>
              </tr>
              <tr> 
                <td height="13" colspan="2" width="560">&nbsp; </td>
              </tr>
              <tr> 
                <td height="21" colspan="2" width="560"><a name="two"></a><b> <%if (HasPart4) 
                       		out.println("耗材");%></b></td>
              </tr>
              <tr> 
                <td colspan="2" height="8" width="560"> 
                  <table border=0 cellpadding=2 cellspacing=2 width="600" height="41">
					<form name="fmPart" >
                    <tbody> <% rs = Result.getRS("select l.prod_name,p.*, c.catename from product p, " +
                         " Prod_part pp, category c, product_l l  where p.prodid=l.prodid and l.lang_code=c.lang_code and  p.cateid = c.cateid and " +
                         " c.lang_code = '" + LangCode +
                         "' and p.Status='Y' p.prodid = pp.partprodid and p.typeid = 4 and pp.prodid = " + ProdId);
                       
                       ColorName = "00";
                       if (rs != null)
                       {
                         while (rs.next())
                         {
                           if (ColorName.equals("00"))
                           {
                           %> 
                    <tr align="center"> 
                      <td bgcolor=#669FDF width="9%" height="2"> 品名<br>
                      </td>
                      <td bgcolor=#669FDF width="17%" height="2" nowrap> 型号 </td>
                      <td bgcolor=#669FDF width="17%" height="2" nowrap> 价格<br>
                        （单位：元） </td>
                      <td bgcolor=#669FDF width="17%" height="2" nowrap>订购数量</td>
                      <td bgcolor=#669FDF width="17%" height="2" nowrap>放进购物车</td>
                    </tr>
                    <%
                           }
                           if (ColorName.equals("#B0D3FF"))
                             ColorName = "#DDF1FF";
                           else
                             ColorName = "#B0D3FF";
                           %> 
                    <tr align="center"> 
                      <td bgcolor=<%=ColorName%> width="9%" height="2"><%=rs.getString("CateName")%></td>
                      <td bgcolor=<%=ColorName%> width="17%"><%=rs.getString("ProductNo")%></td>
                      <td bgcolor=<%=ColorName%> width="17%"> <%if (rs.getString("ListPrice") != null)
                           	    out.println(rs.getString("ListPrice"));
                           	  else
                           	    out.println("面议");
                           	%></td>
                      <td bgcolor="<%=ColorName%>">
                        <input type="text" name="<%=rs.getString("ProdId")%>" size="3">
                      </td>
                        <td bgcolor="<%=ColorName%>"> <a href="javascript:OrderPart(<%=rs.getString("ProdId")%>);"><img src="/images/temp/b_ok.gif" width="41" height="17" border="0"></a> 
                        </td>
                    </tr>
                    <%
                         }
                       }
                       
                    %> </tbody> </form>
                  </table>
                </td>
              </tr>
              <tr> 
                <td colspan="2" height="13" width="560">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2" height="8" width="560"><a name="three"></a><b> <%if (HasPart6) 
                       		out.println("选购件");%></b></td>
              </tr>
              <tr> 
                <td height="2" colspan="2" width="560"> 
                  <table width="600" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"> 
                        <table width="600" border="0">
                          <tr> 
                            <td valign="top" height="101"> 

                              <table border=0 cellpadding=2 cellspacing=2 width="600">
            <%
            rs = Result.getRS("select  l.shortdesc, l.descr, p.*, c.catename, " +
                     " d.dir from product p,product_l l, Prod_part pp, category c, dir_setting d " +
                     " where  p.cateid = c.cateid and p.prodId = l.prodid  and l.lang_Code = '" +
                     LangCode + "' and p.picdir1 = d.dirid(+) and c.lang_code = 'GB' and p.prodid " +
                     " = pp.partprodid and pp.prodid = " + ProdId + " and p.typeid= 6 " );
            if (rs != null)
            {
              while (rs.next())
              {
                Descr = rs.getString("ShortDesc");
                PicDir1 = rs.getString("Dir");
                PicFile1 = rs.getString("FileName1");
                if (ColorName.equals("#B0D3FF"))
                  ColorName = "#DDF1FF";
                else
                  ColorName = "#B0D3FF";
                Descr = Descr + "\n";
                %>
                <tr bgcolor="<%=ColorName%>">

                <td ><%=rs.getString("CateName")+rs.getString("ProductNo")%></td>
                <td   height="60">
                <%

                  ImageFile = PicDir1+PicFile1;
                  if ((ImageFile != null) && (PicDir1 != null))
                  {
                   out.println("<img src=" + ImageFile +
                   " width=\"80\" height=\"50\"> ");
                  }
                  else
                    out.println("暂无图片");
                %>
                </td>
                </tr>
                <%
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
                  }
                  else
                  {
                    Spec = "&nbsp;";
                  }
                  %>
                  <tr bgcolor="<%=ColorName%>">
                  <td ><%=Spec%></td>
                  <td ><%=SpecDesc%></td>
                  </tr>
                  <%
                }
              }
            }
            %>
                              </table>

                            </td>
                          </tr>
                          <tr> 
                            <td valign="top">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td height="2" colspan="2" width="560" bgcolor="#669FDF">&nbsp;</td>
              </tr>
              <tr> 
                <td height="21" colspan="2" width="560" align="center">
                  <table width="600" border="0" cellspacing="0" cellpadding="0">
                    <tr align="center"> 
                      <td height="30"><a href="#top"><img src="/images/temp/top.gif" width="60" height="17" border="0"></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot1.js">
</script>
<%if (Result.CloseStm()) 
        out.println("");%>

</body>
<!-- #EndTemplate --></html>

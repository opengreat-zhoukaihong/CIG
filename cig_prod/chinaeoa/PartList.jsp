<%@ page import="java.sql.*,java.net.*" %>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />

<%
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");
String Category = request.getParameter("Category");
String BrandName = "";
String ProductNo = "";
String Brand = request.getParameter("Brand");
String PriceRange = request.getParameter("PriceRange");
String PartProdNo = request.getParameter("PartProdNo");
if (PartProdNo == null)
  PartProdNo = "0";
String ProdId = request.getParameter("ProdId");
String SQL = "";
String CateName = request.getParameter("CateName");
String wStr = "";
int i;

ResultSet rs = null;

SQL = "select p.*,b.name, c.catename from product p, brand b, category c "
                      + " where   p.brandid = b.brandid and b.lang_code = 'GB' "
                      + " and  p.cateid = c.cateid and c.lang_code = b.lang_code and p.prodid = " 
                      + ProdId;

rs = Result.getRS(SQL);
if (rs != null)
{
  if(rs.next())
  {
	 ProductNo = rs.getString("ProductNo");
     BrandName = rs.getString("Name");
     CateName = rs.getString("CateName");
   }
}	  
SQL = "select p.*, l.prod_name, l.shortdesc, l.descr,  b.name, c.catename from prod_part pp, product p, product_l l, brand b, category c "
                      + " where pp.partprodid(+) = p.prodid and p.prodid = l.prodid and l.lang_code = '" + LangCode + "' and p.brandid = b.brandid and b.lang_code = l.lang_code "
                      + " and  p.cateid = c.cateid and c.lang_code = l.lang_code and pp.prodid = " + ProdId + " and p.typeid = 5  order by p.cateid, p.productNo";

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
function openorder(url)
{   
   OpenWindow=window.open(url, "win1", "height=300 width=600,toolbar=no,scrollbars=yes,menubar=no,resize=yes");
}

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
          openorder("/chinaeoa/AddOrder.jsp?Type=A&LangCode=GB&ProdId=" + ProdId + "&Qty=" + fmList.elements[j].value);
       }
  }
  //alert("test");
  //fmList.method="post";
  //fmList.submit();
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
		<form name="fmList" method="post" >
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" align="center" width="600">
              <tr> 
                  <td colspan="2" height="20"> <img src="/images/temp/path.gif" width="49" height="13"> 
                    <img src="/images/arrow.gif" width="7" height="11"> <a href="index.jsp">首页</a> 
                    <img src="/images/arrow.gif" width="7" height="11"> <a href="ProductCentre.jsp?LangCode=GB">产品内容</a> 
                    <img src="/images/arrow.gif" width="7" height="11"> 零件列表</td>
              </tr>
            </table>
            <table border="0" cellspacing="0" cellpadding="0" width="600" align="center">
              <tr align="right"> 
                <td align="left" height="20">
                              </td>
                <td align="right" height="20"><img src="/images/temp/car.gif" width="19" height="16" align="absbottom"> 
                  <a href="#" onClick="openorder('AddOrder.jsp?LangCode=GB')">查看购物车</a></td>
              </tr>
            </table>
			<%=BrandName + "&nbsp;" + ProductNo + "&nbsp;" + CateName%>
            <br>

              <table border="0" cellspacing="2" cellpadding="2" boder="thin mediun thick none" align="center" width="600">
                <tr align="center"> 
                  <td bgcolor="#99CCFF"> <a name="one"></a> 产品名称</td>
                  <td bgcolor="#99CCFF"> 型号</td>
                  <td bgcolor="#99CCFF"> 价格(元)</td>
                  <td bgcolor="#99CCFF"> 订购数量</td>
                  <td nowrap bgcolor="#99CCFF"> 放进购物车</td>
                </tr>
                <%
              String ColorName = "#F4FCFF";
              boolean HasRecord = false;
			  rs = null;
			  rs = Result.getRS(SQL);
              if (rs != null)
              {
                while (rs.next())
			    { 
				  HasRecord = true;
                  if (ColorName.equals("#DFEEFF"))
                    ColorName = "#F4FCFF";
				  else
                    ColorName = "#DFEEFF";
              %> 
                <tr bgcolor="<%=ColorName%>"> 
                  <td  align="center"><%if (rs.getString("Prod_name") != null)
										  out.print(rs.getString("Prod_name"));
										else
										  out.print(rs.getString("CateName"));
									   %> </td>
                  <td  align="center"> <font color="#333333"> <a href="ProductDetail.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=GB"> 
                    <%=rs.getString("ProductNo")%></a></font></td>
                  <td  align="center">
					<%
					  if (rs.getString("ListPrice") != null)
						out.print(rs.getString("ListPrice"));
					  else
						out.print("面议");
                    %>  </td>
                  <td align="center">
                    <input type="text" name="<%=rs.getString("ProdId")%>" size="3">
                  </td>
                  <td  align="center"> <a href="javascript:Order(<%=rs.getString("ProdId")%>);"> 
                    <img src="/images/temp/b_ok.gif" name="Submit1" value="确定" width="41" height="17" border="0"></a> 
                  </td>
                </tr>
                <%
					}
				}
			    if (!HasRecord)
				   out.print("暂无零件");
               
			   Result.CloseStm();
			 %> 
              </table>
            <table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr align="center"> 
                <td height="30"><a href="#top"><img src="/images/temp/top.gif" width="60" height="17" border="0"></a></td>
              </tr>
            </table>
          </td>
        </tr>
	  </form>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot1.js">
</script>


</body>
<!-- #EndTemplate --></html>

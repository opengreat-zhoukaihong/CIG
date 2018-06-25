<%@ page import="java.sql.*,java.net.*" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
String BrandId = request.getParameter("Brand");
String LangCode = request.getParameter("LangCode");
String TypeId = request.getParameter("Type");
String CateId = request.getParameter("Category");
String ProductNo = request.getParameter("ProductNo");

//out.println(ProductNo);
String SQL = null;
if (BrandId != null)
{
  if (!BrandId.equals("0"))
  {
    SQL = "where p.brandId = " + BrandId;
  }
}
if (TypeId != null)
{
  if (!TypeId.equals("0"))
  {
    if (SQL == null)
      SQL = "where p.TypeId = " + TypeId;
    else
      SQL = SQL + " and p.typeid = " + TypeId;
  }
}
if (CateId != null)
{
  if (!CateId.equals("0"))
  {
    if (SQL == null)
      SQL = "where p.CateId = " + CateId;
    else
      SQL = SQL + " and p.CateId = " + CateId;
  }
}
if (ProductNo != null)
{  
    ProductNo = "%" + ProductNo + "%";
  if (!ProductNo.equals("%%"))
  {
    if (SQL == null)
      SQL = "where p.ProductNo like  '" + ProductNo + "'";
    else
      SQL = SQL + " and p.ProductNo like  '" + ProductNo + "'";
  }
}

if (SQL == null)
  SQL = "select p.*, b.name, c.catename from product p, brand b, category c " +  
      " where  p.brandid = b.brandid and b.lang_code = '" + 
      LangCode + "' and  p.cateid = c.cateid and c.lang_code = b.lang_code order by p.brandid,p.CateId, p.ProductNo";
else
  SQL = "select p.*, b.name, c.catename from product p, brand b, category c " + SQL +  
      " and p.brandid = b.brandid and b.lang_code = '" + 
      LangCode + "' and  p.cateid = c.cateid and c.lang_code = b.lang_code order by p.brandid,p.CateId, p.ProductNo";


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


<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="497" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td rowspan="2" width="18">&nbsp; </td>
    <td width="489"><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr> 
    <td width="489"> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF 
      cellpadding=5 cellspacing=2 width=506>
        <tr bgcolor="#FFFFFF"> 
          <td colspan="6" align="center" height="26">产品列表</td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26">品牌</td>
          <td align="center" height="26">类别</td>
          <td align="center" height="26">型号</td>
          <td align="center" height="26">网上价格</td>
          <td align="center" height="26">操作</td>
        </tr>
        <%
	//out.println(SQL);
       ResultSet rs = Result.getRS(SQL);
	if (rs != null)
	{
               while (rs.next())
 	   {
                  %> 
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26"><%=rs.getString("Name")%></td>
          <td align="center" height="26"><%=rs.getString("CateName")%></td>
          <td align="center" height="26"><a href="bstProductEdit.jsp?LangCode=<%=LangCode%>&ProdId=<%=rs.getString("ProdId")%>"><%=rs.getString("ProductNo")%></a></td>
          <td align="center" height="26"><%if (rs.getString("ListPrice") != null)
        							out.println(rs.getString("ListPrice"));
						   else 
							out.println("&nbsp;");
                                                             	%></td>
          <td align="center" height="26"><a href="bstDeleteProd.jsp?ProdId=<%=rs.getString("ProdId")%>&LangCode=<%=LangCode%>">删除</a></td>
        </tr>
        <%
	   }  
	}
	else
	{
  	  out.println(SQL);
	}
	      
	Result.CloseStm();
       %> 
        <tr bgcolor="#FFFFFF"> 
          <td colspan="6" align="center" height="50"> <a href="javascript:Add();"> 
            <input type="image"src="/images/temp/b_add.gif" name="cancel2" value="取   消" class="font1" width="80" height="17" border="0">
            </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

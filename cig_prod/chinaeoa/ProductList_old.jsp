<%@ page import="java.sql.*" %>
<jsp:useBean id="ResultId" scope="page" class="com.cig.chinaeoa.ResultBean" />
<html>
<head>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--


//-->
</script>


<%
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");
String Category = request.getParameter("Category");
String Brand = request.getParameter("Brand");
String PriceRange = request.getParameter("PriceRange");
String wStr ="";
String SQL = "";
String SelectName = "";
String DisplayField = "";
String ValueField = "";
String SpecId = "";
String SpecValue1 = "";
int i;
SQL = "select * from spec where lang_code ='" + LangCode + "' and  typeid = '" + TypeId + "' order by specID";
ResultSet rs = ResultId.getRS(SQL);
%>


<body bgcolor="#FFFFFF" >
<form>
<%
if (rs == null)
{
  out.println("rs is null :" +  SQL);
}
else
{
  SQL = "";
  while (rs.next())
  {
    SpecId = rs.getString("SpecId");
    SpecValue1 = request.getParameter(SpecId);
    if (!SpecValue1.equals("0"))
    {
      if (SQL == "")
        SQL = SQL + "Select prodid from Prod_spec where SpecId='" + SpecId
            + "' and value1 ='" + SpecValue1 + "'";
      else
        SQL = SQL + "intersect Select prodid from Prod_spec where SpecId='" + SpecId
            + "' and value1 ='" + SpecValue1 + "'";
    }
  }
  if (SQL != "")
  {
    SQL = "(" + SQL + ") s";
    SQL = "select rownum, l.shortdesc, l.descr, p.*, b.name, c.catename from product p, product_l l, brand b, category c, "
        + SQL + " where p.prodid = l.prodid and l.lang_code = 'GB' and p.brandid = b.brandid and b.lang_code = l.lang_code "
        + " and  p.cateid = c.cateid and c.lang_code = l.lang_code and p.prodid = s.prodid";
  }
  else
  {
    SQL = "select rownum, l.shortdesc, l.descr, p.*, b.name, c.catename from product p, product_l l, brand b, category c "
          + " where p.prodid = l.prodid and l.lang_code = 'GB' and p.brandid = b.brandid and b.lang_code = l.lang_code "
          + " and  p.cateid = c.cateid and c.lang_code = l.lang_code ";
  }
  wStr = "";
  if (!TypeId.equals("0"))
    wStr = " and  p.TypeID = '" + TypeId + "'";
  if (!Brand.equals("0"))
    wStr = wStr + " and  p.BrandID = '" + Brand + "'";
  if (!Category.equals("0"))
    wStr = wStr + " and  p.CateId = '" + Category + "'";
  if (!PriceRange.equals("0"))
  {
    i = PriceRange.indexOf("~");
    wStr = wStr + " and  p.ListPrice >= " + PriceRange.substring(0,i).trim()
               + " and  p.ListPrice <= " + PriceRange.substring(i + 1).trim();
  }
  SQL = SQL + wStr + " order by p.brandid, p.cateid ";
  out.println(SQL);
}
%>

<jsp:useBean id="DbGridId" scope="page" class="com.cig.chinaeoa.ListBean">
<%
String[] Titles = {"序号","品牌","类别","型号","会员价"};
String[] Fields = {"rownum","name","cateName","productNo","ListPrice"};
DbGridId.setTitles(Titles);
DbGridId.setFieldNames(Fields);
//SQL = "select * from (select rownum sid, fax,name,name_en, telephone from hotel_gb) where sid >=1 and sid <= 10" ;
DbGridId.setSql(SQL);
%>
</jsp:useBean>

<%=DbGridId.getGrid() %>

</form>
</body>
</html>

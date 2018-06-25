<%@ page import="java.sql.*,java.net.*" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%




String SQL = "Select s.*, c.cateName, p.productNo, b.name from " + 
   " Speci_sale s, product p, brand b, category c " +
   " where s.prodid = p.prodid and p.brandid = b.brandid and b.Lang_code ='GB' " +
   " and c.Lang_code=b.lang_Code and p.cateid = c.cateid order by S.Be_date desc ";


%>

<html>
<head>


<title>推荐产品列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="518" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td rowspan="2" width="1">&nbsp; </td>
    <td width="509"><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr> 
    <td width="509"> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF 
      cellpadding=5 cellspacing=2 width=507>
        <tr bgcolor="#FFFFFF"> 
          <td colspan="8" align="center" height="26">推荐产品列表</td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26">品牌</td>
          <td align="center" height="26" width="50">类别</td>
          <td align="center" height="26" width="124">推荐产品</td>
          <td align="center" height="26" width="53">显示位置</td>
          <td align="center" height="26" width="54">开始日期</td>
          <td align="center" height="26" width="56">截止日期</td>
          <td align="center" height="26" width="44">操作</td>
        </tr>
        <%
	
       ResultSet rs = Result.getRS(SQL);
	if (rs != null)
	{
               while (rs.next())
 	   {
                  %> 
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26"><%=rs.getString("Name")%></td>
          <td align="center" height="26" width="50"><%=rs.getString("CateName")%></td>
          <td align="center" height="26" width="124">
<a href="bstHotEdit.jsp?ProdId=<%=rs.getString("ProdId")%>&Location=<%=rs.getString("Location")%>&StartDate=<%=rs.getDate("be_date").toString()%>"><%=rs.getString("ProductNo")%></a></td>
          <td align="center" height="26" width="53">
          <%if (rs.getString("Location").equals("F"))
			  out.println("首页");
            else if (rs.getString("Location").equals("P"))
  			  out.println("产品中心");
          %></td>
          <td align="center" height="26" width="54"><%=rs.getDate("be_date").toString()%></td>
          <td align="center" height="26" width="56"><%
         if (rs.getString("End_Date") != null)
           out.println(rs.getDate("End_date").toString()); %>&nbsp;</td>
          <td align="center" height="26" width="44"><a href="bstDeleteHot.jsp?ProdId=<%=rs.getString("ProdId")%>&Location=<%=rs.getString("Location")%>&StartDate=<%=rs.getDate("be_date").toString()%>"><font color="#FF6666">删除</font></a></td>
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
          <td colspan="8" align="center" height="50"> <a href="bstHotAdd.jsp"> 
            <img src="/images/temp/b_add.gif" name="cancel2"  class="font1" width="80" height="17" border="0"> 
            </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

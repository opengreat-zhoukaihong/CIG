<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="brandManager" scope="page" class="com.cig.chinaeoa.bst.BrandManager" />

<%!
  String sqlStr;
  ResultSet brandInfo;
  String brandID,name,langCode,langDesc,fileName,srcUrl,picDir;
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
<script>
  function brandDelete(tempBrandID,tempLangCode)
  {
    document.brandDel.brandID.value = tempBrandID;
    document.brandDel.langCode.value = tempLangCode;
    if(confirm("确实要删除吗?"))
      document.brandDel.submit();
  }
</script>

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="536" border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td rowspan="2"><img src="/images/spacer.gif" width="15" height="8"></td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr>
    <td>
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF
      cellpadding=5 cellspacing=2 width=538>
        <form name="brandList" >
          <tr bgcolor="#FFFFFF">
            <td height="30" colspan="6" align="center" class="font3">品牌清单</td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td align="center" width="77"> 
              <div align="center">品牌名称</div>
            </td>
            <td width="67"> 
              <div align="center">表达语言 </div>
            </td>
            <td width="132"> 
              <div align="center">图片目录</div>
            </td>
            <td width="109"> 
              <div align="center">品牌图标</div>
            </td>
            <td width="37"> 
              <div align="center">&nbsp;</div>
            </td>
            <td width="28"> 
              <div align="center">&nbsp;</div>
            </td>
          </tr>

<%
  sqlStr = "select b.brandID,b.lang_code,l.descr,b.name,d.dir,b.fileName " +
    " from brand b,lang_desc l,dir_setting d " +
    " where b.lang_code = l.lang_code and b.picDir = d.dirID(+) " +
    " order by brandID";

  brandManager.setSqlStr(sqlStr);

  brandInfo = brandManager.getDatas();
  if(brandInfo != null)
  {
    while(brandInfo.next())
    {
      brandID = brandInfo.getString("brandID");
      name = brandInfo.getString("name");
      langDesc = brandInfo.getString("descr");
      langCode = brandInfo.getString("lang_code");
      picDir = brandInfo.getString("dir");
      if(picDir == null)
        picDir = "";
      fileName = brandInfo.getString("fileName");
      srcUrl = "/" + picDir + fileName;

%>
          <tr bgcolor="#FFFFFF">
            <td align="center" width="77" height="30"><%=name%></td>
            <td height="30" width="67">&nbsp;&nbsp;<%=langDesc%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td height="30" width="132">&nbsp;<%=picDir%></td>
            <td height="30" width="109" align="center"><img src="<%=srcUrl%>"></td>
            <td height="30" width="37"><a href="brandModify.jsp?brandID=<%=brandID%>&langCode=<%=langCode%>">修改</a></td>
            <td height="30" width="28"><a href="javascript:brandDelete('<%=brandID%>','<%=langCode%>')">删除</a> 
            </td>
          </tr>

<%
    }
    brandManager.disconn();
  }
%>
        </form>
        <form name="brandDel" method="post" action="brandDelete.jsp">
              <input type="hidden" name="brandID" >
              <input type="hidden" name="langCode">
        </form>


      </table>
    </td>
  </tr>



</table>
</body>
</html>

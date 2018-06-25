<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="typeManager" scope="page" class="com.cig.chinaeoa.bst.TypeManager" />

<%!
  String sqlStr;
  ResultSet typeInfo;
  String typeID,typeName,langCode,langDesc;
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
<script>
  function typeDelete(tempTypeID,tempLangCode)
  {
    document.typeDel.typeID.value = tempTypeID;
    document.typeDel.langCode.value = tempLangCode;
    if(confirm("确实要删除吗?"))
      document.typeDel.submit();
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
      cellpadding=5 cellspacing=2 width=582>
        <form name="typeList" >
          <tr bgcolor="#FFFFFF">
            <td height="30" colspan="6" align="center" class="font3">产品大类清单</td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td align="center" width="78"> 
              <div align="center">产品大类名称</div>
            </td>
            <td width="68"> 
              <div align="center">表达语言 </div>
            </td>
            <td width="42">
              <div align="center">&nbsp;</div>
            </td>
            <td width="36">
              <div align="center">&nbsp;</div>
            </td>
          </tr>

<%
  sqlStr = "select b.typeID,b.lang_code,l.descr,b.name " +
    " from prod_type b,lang_desc l " +
    " where b.lang_code = l.lang_code order by typeID";

  typeManager.setSqlStr(sqlStr);

  typeInfo = typeManager.getDatas();
  if(typeInfo != null)
  {
    while(typeInfo.next())
    {
      typeID = typeInfo.getString("typeID");
      typeName = typeInfo.getString("name");
      langDesc = typeInfo.getString("descr");
      langCode = typeInfo.getString("lang_code");
%>
          <tr bgcolor="#FFFFFF">
            <td align="center" width="78" height="30"><%=typeName%></td>
            <td height="30" width="68">&nbsp;&nbsp;<%=langDesc%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td height="30" width="42"><a href="typeModify.jsp?typeID=<%=typeID%>&langCode=<%=langCode%>">修改</a></td>
            <td height="30" width="36"><a href="javascript:typeDelete('<%=typeID%>','<%=langCode%>')">删除</a>
            </td>
          </tr>

<%
    }
    typeManager.disconn();
  }
%>
        </form>
        <form name="typeDel" method="post" action="typeDelete.jsp">
              <input type="hidden" name="typeID" >
              <input type="hidden" name="langCode">
        </form>
      </table>
    </td>
  </tr>



</table>
</body>
</html>

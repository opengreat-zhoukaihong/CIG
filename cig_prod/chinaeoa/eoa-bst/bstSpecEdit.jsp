<%@ page language="java" import="java.sql.*"%>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%
String SpecId = request.getParameter("SpecId");
String LangCode = request.getParameter("LangCode");
if (LangCode == null)
  LangCode = "GB";
String SQL = "Select s.*,T.name TypeName from Spec s, Prod_type t where s.SpecId = " + SpecId 
         + " and s.Lang_code = '" + LangCode  + 
        "' and t.lang_code = s.Lang_code and s.typeid = t.typeid ";
String Spec = "";
String TypeId = "";
String Query = "";
String TypeName = "";
String Desc = "";
ResultSet rs = Result.getRS(SQL);
if ((rs != null) && (rs.next()))
{  
  Spec = rs.getString("Name");
  TypeId = rs.getString("TypeId");
  TypeName = rs.getString("TypeName");
  Query = rs.getString("Query");
   if (Query == null)
     Query = "";
  Desc = rs.getString("Descr");
  if (Desc == null)
    Desc = "";
}
Result.CloseStm();
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">
<!--
 function Add()
{
  if (fmAdd.Spec.value == "" )
  {
    alert("请输入规格");
  }
  else
   fmAdd.submit();
}

//-->
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table border="0" cellspacing="0" cellpadding="10" width="460">
  <tr align="center"> 
    <td rowspan="2" height="67" width="98"> <img src="/images/spacer.gif" width="80" height="1"> 
    </td>
    <td width="428" height="42">&nbsp;</td>
  </tr>
  <tr align="center"> 
    <td width="428"> 
      <TABLE border=1 borderColorDark=#ffffff borderColorLight=#6666FF 
      cellPadding=5 cellSpacing=2 width=300>
        <tr> 
          <td align="center" colspan="4" height="30">更新规格</td>
        </tr>
        <form name="fmAdd" method="post" action="bstUpdateSpec.jsp?LangCode=<%=LangCode%>">
          <tr> 
            <td align="center" width="77" height="30">ID：</td>
            <td colspan="3" width="191" height="30"> <%=SpecId%> 
              <input type="hidden" name="SpecId" value="<%=SpecId%>">
            </td>
          </tr>
          <tr> 
            <td align="center" width="77" height="30">类别：</td>
            <td colspan="3" width="191" height="30"> <%=TypeName%> 
              <input type="hidden" name="TypeId" value="<%=TypeId%>">
            </td>
          </tr>
          <tr> 
            <td align="center" width="77" height="30">规格：</td>
            <td colspan="3" width="191" height="30"> 
              <input type="text" name="Spec" size="25" class="font1" value = <%=Spec%>>
            </td>
          </tr>
          <tr> 
            <td align="center" width="77" height="30">说明：</td>
            <td colspan="3" width="191" height="30"> 
              <input type="text" name="Desc" size="25" class="font1" value = <%=Desc%>>
            </td>
          </tr>
          <tr> 
            <td align="center" width="77" height="30">列表显示：</td>
            <td colspan="3" width="191" height="30"> <% if (Query.equals("A"))
					Query = "checked";
                 else
                    Query = "";
               %> 
              <input type="checkbox" name="Query" value="A" <%=Query%>>
                 
            </td>
          </tr>
          <tr> 
            <td colspan="4" align="center" height="30"> <a href="Javascript:Add()"> 
              <img src="/images/temp/b_update.gif" name="cancel2" class="font1" width="80" height="17" border="0"> 
              </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:fmAdd.reset();"> 
              <img src="/images/temp/reset.gif" name="cancel" value="取   消" class="font1" width="80" height="17"  border="0"> 
              </a></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

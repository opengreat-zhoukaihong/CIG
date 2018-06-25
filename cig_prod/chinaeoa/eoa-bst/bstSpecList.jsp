<%@ page import="java.sql.*,java.net.*" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<%
String TypeId = request.getParameter("TypeId");
String LangCode = request.getParameter("LangCode");
if (LangCode == null)
  LangCode = "GB";
if (TypeId == null)
  TypeId = "1";
String SQL = "Select * from Spec where TypeId = " + TypeId + 
             "and Lang_code = '" + LangCode + "'  order by SpecId ";


%>

<html>
<head>


<title>规格列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="JavaScript">
function Query()
{
  if (fmList.TypeId.value == "0")
  { 
   alert("请选择类别");
   return;
  }
  fmList.submit();
}
</script>
<form name="fmList" action="bstSpecList.jsp" method="post">
<table width="518" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td rowspan="2" width="1">&nbsp; </td>
    <td width="509"><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr> 
    <td width="509"> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF 
      cellpadding=5 cellspacing=2 width=509>
        <tr bgcolor="#FFFFFF"> 
            <td colspan="6" align="center" height="26">规格列表</td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26">类别</td>
          <td colspan="4" height="26"> 
            <select name="TypeId" size="1" onChange="Query()" >
              <option value="0" selected>-请选择-</option>
              <%=LookUp.setLookUp("select * from prod_type  where lang_code = 'GB' order by typeid","name","typeid",TypeId)%> 
            </select>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26">ID</td>
          <td align="center" height="26" width="203">规格</td>
          <td align="center" height="26" width="97">说明</td>
          <td align="center" height="26" width="68">列表显示</td>
          <td align="center" height="26" width="43">操作</td>
        </tr>
        <%
	
       ResultSet rs = Result.getRS(SQL);
	if (rs != null)
	{
               while (rs.next())
 	   {
                  %> 
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26"><%=rs.getString("SpecId")%></td>
          <td align="center" height="26" width="203"><a href="bstSpecEdit.jsp?LangCode=<%=LangCode%>&SpecId=<%=rs.getString("SpecId")%>"><%=rs.getString("Name")%></a></td>
          <td align="center" height="26" width="97"><%
         if (rs.getString("Descr") != null)
           out.println(rs.getString("Descr")); %>&nbsp;</td>
          <td align="center" height="26" width="68"><%
         if (rs.getString("Query") != null)
           out.println("是"); %>&nbsp;</td>
          <td align="center" height="26" width="43"><a href="bstDeleteSpec.jsp?TypeId=<%=TypeId%>&LangCode=<%=LangCode%>&SpecId=<%=rs.getString("SpecId")%>"><font color="#FF6666">删除</font></a></td>
        </tr>
        <%
	   }  
	}
	else
	{
  	  out.println(SQL);
	}
	      
	Result.CloseStm();
    LookUp.CloseStm();
       %> 
        <tr bgcolor="#FFFFFF"> 
          <td colspan="6" align="center" height="50"> <a href="bstSpecAdd.jsp"> 
            <img src="/images/temp/b_add.gif" name="cancel2"  class="font1" width="80" height="17" border="0"> 
            </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
</body>
</html>

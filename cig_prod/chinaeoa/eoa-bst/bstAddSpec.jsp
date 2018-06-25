<%@ page import="java.sql.*,java.net.*" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />

<html>
<head>
<script language="JavaScript">
<!--

 function Add()
{

  if (fmAdd.Spec.value == "0")
  {
    alert("请选择规格");
    return;
  }
  if (fmAdd.SpecValue.value == "" )
  {
    alert("请输入数值");
    return;
  }
  fmAdd.submit();
 
}

//-->
</script>




<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%
String ProdId = request.getParameter("ProdId");
String LangCode = request.getParameter("LangCode");
String ProdName = request.getParameter("ProdName");
String SpecValue = request.getParameter("SpecValue");
String SpecId = request.getParameter("Spec");
String Unit = request.getParameter("Unit");
String TypeId = request.getParameter("TypeId");
if (Unit == null);
  Unit = "";
String SQL = "";
String OP = request.getParameter("OP");
if (ProdId != null)
{
  if ((OP != null) && OP.equals("A") && (SpecId != null))
  {
    SQL = "insert into Prod_Spec (ProdId, SpecId, value1, unit) values (" + 
			ProdId + "," + SpecId + ",'" + SpecValue + "','" + Unit + "' )";
    Result.IsExecute(SQL);
    
  }
  if ((OP != null) && OP.equals("D")) 
  {
	SpecId = request.getParameter("SpecId");
    if (SpecId != null)
    {
      SQL = "delete from Prod_Spec where prodid =" + 
			ProdId + " and SpecId =" + SpecId;
      Result.IsExecute(SQL);
      
    }
  }
}
//out.println(SQL);

SQL = "Select s.name,ps.* from spec s, prod_spec ps where s.specid = " + 
      " ps.specid and ps.prodid = " + ProdId + " and s.lang_code='" + LangCode +  "' order by ps.specid"; 


//out.println(SQL);
%>

<table width="635" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td rowspan="2">&nbsp;</td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr> 
    <td> 
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF 
      cellpadding=5 cellspacing=2 width=624>
        <form  name="fmAdd" method="post" action="bstAddSpec.jsp?TypeId=<%=TypeId%>&OP=A&ProdId=<%=ProdId%>&ProdName=<%=URLEncoder.encode(ProdName)%>&LangCode=<%=LangCode%>" >
          <tr bgcolor="#D5EFFD"> 
            <td align="center" colspan="7">增添规格</td>
          </tr>
          <tr bgcolor="#FFFFFF" align="left"> 
            <td width="68" height="59">产品名称：</td>
            <td colspan="6" height="59"><%=ProdName%>&nbsp;</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="68">规格：</td>
            <td width="154"> 
              <select name="Spec" size="1" >
                <option value="0" selected>-请选择-</option>
                <%=LookUp.getLookUp("select * from Spec  where lang_code = 'GB' and typeid = " + TypeId +  " order by Specid","name","Specid")%> 
              </select>
            </td>
            <td align="center" width="45">数值：</td>
            <td width="58"> 
              <input type="text" name="SpecValue" size="8">
            </td>
            <td width="40">单位：</td>
            <td width="60"> 
              <input type="text" name="Unit" size="8">
            </td>
            <td width="97"><a href="Javascript:Add()"> 
              <img src="/images/temp/b_add.gif" name="cancel2" class="font1" width="80" height="17" border="0">
              </a></td>
          </tr>
          <tr bgcolor="#D5EFFD"> 
            <td align="center" colspan="7" height="24">主产品列表</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" colspan="2" height="24">规格</td>
            <td colspan="3" height="24" align="center">数值</td>
            <td width="60" height="24" align="center">单位</td>
            <td width="97" height="24" align="center">&nbsp;</td>
          </tr>
          <%
            ResultSet rs = Result.getRS(SQL);
            if (rs!=null)
			{
  				while (rs.next())
  				{			
    			  SpecId = rs.getString("SpecId");	
    				
  			     %> 
          <tr bgcolor="#FFFFFF"> 
            <td align="center" colspan="2" height="24"><%=rs.getString("Name")%></td>
            <td colspan="3" height="24" align="center"><%=rs.getString("Value1")%></td>
            <td width="60" height="24" align="center"><% if (rs.getString("Unit") != null)
      out.println(rs.getString("Unit"));%>&nbsp;</td>
            <td width="97" height="24" align="center"><a href="bstAddSpec.jsp?TypeId=<%=TypeId%>&SpecId=<%=SpecId%>&ProdId=<%=ProdId%>&OP=D&ProdName=<%=URLEncoder.encode(ProdName)%>&LangCode=<%=LangCode%>"><font color="#FF6666">删除</font></a></td>
          </tr>
          <%   }
			}%> 
        </form>
      </table>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<%
LookUp.CloseStm();
Result.CloseStm();
%>
</body>
</html>

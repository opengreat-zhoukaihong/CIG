<%@ page import="java.sql.*,java.net.*" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="LookUp" scope="page" class="com.cig.chinaeoa.LookUpBean" />
<%
String TypeId = request.getParameter("TypeId");
if (TypeId == null)
  TypeId = "0";
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
  if (fmAdd.TypeId.value == "0" )
  {
    alert("��ѡ�����");
    return;
  }
  if (fmAdd.Spec.value == "" )
  {
    alert("��������");
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
    <td width="428" height="52">&nbsp;</td>
  </tr>
  <tr align="center"> 
    <td width="428"> 
      <TABLE border=1 borderColorDark=#ffffff borderColorLight=#6666FF 
      cellPadding=5 cellSpacing=2 width=300>
        <tr> 
          <td align="center" colspan="4" height="30">��ӹ��</td>
        </tr>
        <form name="fmAdd" method="post" action="bstInsertSpec.jsp">
          <tr> 
            <td align="center" width="77" height="30">���</td>
            <td colspan="3" width="191" height="30"> 
              <select name="TypeId" size="1" onChange="Query()" >
                <option value="0" selected>-��ѡ��-</option>
                <%=LookUp.setLookUp("select * from prod_type  where lang_code = 'GB' order by typeid","name","typeid",TypeId)%> 
              </select>
            </td>
          </tr>
          <tr> 
            <td align="center" width="77" height="30">���</td>
            <td colspan="3" width="191" height="30"> 
              <input type="text" name="Spec" size="25" class="font1">
            </td>
          </tr>
          <tr> 
            <td align="center" width="77" height="30">˵����</td>
            <td colspan="3" width="191" height="30"> 
              <input type="text" name="Desc" size="25" class="font1">
            </td>
          </tr>
          <tr> 
            <td align="center" width="77" height="30">�б���ʾ��</td>
            <td colspan="3" width="191" height="30"> 
              <input type="checkbox" name="checkbox" value="checkbox">
            </td>
          </tr>
          <tr> 
            <td colspan="4" align="center" height="30"> <a href="Javascript:Add()"> 
              <img src="/images/temp/b_add.gif" name="cancel2" class="font1" width="80" height="17" border="0"> 
              </a></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

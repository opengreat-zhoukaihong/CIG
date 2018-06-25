<%@ page import="java.sql.*,java.net.*" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<%




String SQL = "Select * from Dir_setting order by dirId ";


%>

<html>
<head>


<title>目录列表</title>
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
      cellpadding=5 cellspacing=2 width=509>
        <tr bgcolor="#FFFFFF"> 
          <td colspan="5" align="center" height="26">目录列表</td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26">ID</td>
          <td align="center" height="26" width="236">目录</td>
          <td align="center" height="26" width="111">说明</td>
          <td align="center" height="26" width="59">操作</td>
        </tr>
        <%
	
       ResultSet rs = Result.getRS(SQL);
	if (rs != null)
	{
               while (rs.next())
 	   {
                  %> 
        <tr bgcolor="#FFFFFF"> 
          <td colspan="2" align="center" height="26"><%=rs.getString("DirId")%></td>
          <td align="center" height="26" width="236"><a href="bstDirEdit.jsp?DirId=<%=rs.getString("DirId")%>"><%=rs.getString("Dir")%></a></td>
          <td align="center" height="26" width="111"><%
         if (rs.getString("Descr") != null)
           out.println(rs.getString("Descr")); %>&nbsp;</td>
          <td align="center" height="26" width="59"><a href="bstDeleteDir.jsp?DirId=<%=rs.getString("DirId")%>"><font color="#FF6666">删除</font></a></td>
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
          <td colspan="5" align="center" height="50"> <a href="bstDirAdd.jsp"> 
            <img src="/images/temp/b_add.gif" name="cancel2"  class="font1" width="80" height="17" border="0">
            </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

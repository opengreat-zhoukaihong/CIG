<html>
<%@ page import="java.util.*, java.net.*" %>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>后台管理</title>
<style type="text/css">
<!--
 input {font-family: "宋体"; font-size: 12px ;color:#666666}
 select {font-family: "宋体"; font-size: 12px ; color:#666666}
 td {font-family: "宋体", "Times New Roman"; font-size: 12px; color:#666666; line-height: 18px}
 A:link {text-decoration: none; color: #715922; font-family: 宋体}
 A:visited {text-decoration: none; color: #715922; font-family: 宋体}
 A:active {text-decoration: none; font-family: 宋体}
 A:hover {text-decoration: underline; color:#CAA54D}
 .title { font-size: 12px; font-weight: normal; font-family: "宋体"}
-->
</style>
</head>
<%
    Hashtable pHash =new Hashtable();
    String b_ID = request.getParameter("b_ID");
    if(b_ID!=null)
    pHash.put("id",b_ID);
%>
<jsp:useBean id="Int_BBS" scope="page" class="com.cnbooking.bst.board.Int_BBS" />
<%
    Int_BBS.setParameteres(pHash);
    String[] detail;
    detail=Int_BBS.getDetail();
%>
<body bgcolor="#FFFFFF">
 <p><span class="title"><span class="title"><span class="title"><span class="title"> 
   </span></span></span></span></p>
<br>
<table width="600" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
<form method="POST" action="">
    <tr> 
      <td height="20" width="160"> 
        <div align="right"><span class="title"><span class="title">ID 号：</span></span></div>
      </td>
      <td height="20" width="440"><span class="title"><span class="title"><%=detail[0]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="160"> 
        <div align="right"><span class="title"><span class="title">收信人：</span></span></div>
      </td>
      <td height="20" width="440"><span class="title"><span class="title"><%=detail[5]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="160"> 
        <div align="right"><span class="title"><span class="title">标  题：</span></span></div>
      </td>
      <td height="20" width="440"><span class="title"><span class="title"><%=detail[1]%>&nbsp;
        </span></span></td>
    </tr>
    <tr> 
      <td height="20" width="160"> 
        <div align="right"><span class="title"><span class="title">内  容：</span></span></div>
      </td>
      <td height="48" width="440"><span class="title"><span class="title"><%=detail[2]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="160"> 
        <div align="right"><span class="title"><span class="title">生成时间：</span></span></div>
      </td>
      <td height="20" width="440"><span class="title"><span class="title"><%=detail[4]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="160"> 
        <div align="right"><span class="title"><span class="title">发言人：</span></span></div>
      </td>
      <td height="20" width="440"><span class="title"><span class="title"><%=detail[3]%>&nbsp;</span></span></td>
    </tr>
  </table>
  <p align="center"><span class="title"><a href="javascript:window.close();">关闭窗口</a></span></p>
</form>
<br>
</body>
</html>

<html>
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
    String cust_ID = request.getParameter("cust_ID");
%>
<jsp:useBean id="BookBKCustView" scope="page" class="com.cnbooking.bst.BookBKCustView" /> 
<%
BookBKCustView.setLangCode("GB");
BookBKCustView.setCust_ID(cust_ID);
String[] custDetail;
custDetail=BookBKCustView.getCustDetail();
custDetail=custDetail==null?(new String[13]):custDetail;
%>
<body bgcolor="#FFFFFF">
 <p><span class="title"><span class="title"><span class="title"><span class="title"> 
   </span></span></span></span></p>
<hr>
<table width="300" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
<form method="POST" action="">
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">登 陆 名：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[0]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">性    别：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(custDetail[1].equals("M")){%> 先生 <%}else{%>女士 <%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">邮    编：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[2]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">电    话：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[3]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">电    传：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[4]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">E_mail  ：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[5]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">积    分：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[6]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">国    家：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[7]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">省    市：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[8]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">真    名：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[9]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">城    市：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[10]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">联系地此1：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=custDetail[11]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">联系地此2：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%if(custDetail[12]!=null){%><%=custDetail[12]%><%}%>&nbsp;</span></span></td>
    </tr>
  </table>
  <p align="center"><span class="title"><a href="javascript:window.close();">关闭窗口</a></span></p>
</form>
<br>
</body>
</html>

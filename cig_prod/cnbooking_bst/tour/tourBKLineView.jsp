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
    String line_ID = request.getParameter("line_ID");
    String ope_ID=request.getParameter("ope_ID");
%>
<jsp:useBean id="TourBKLineView" scope="page" class="com.cnbooking.bst.tour.TourBKLineView" /> 
<%
TourBKLineView.setLangCode("GB");
TourBKLineView.setLine_ID(line_ID);
String[] lineDetail;
lineDetail=TourBKLineView.getLineDetail();
lineDetail=lineDetail==null?(new String[8]):lineDetail;
%>
<body bgcolor="#FFFFFF">
<form method="POST" name="lineMap" action="tourBKLineChang.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="line_ID" value="<%=line_ID%>" >
<p><span class="title"><span class="title">旅游主题(中)： 
<input type="text" name="titleGB" size="30" value="<%=lineDetail[0]%>" >
<br>
 旅游主题(英)： 
 <input type="text" name="titleEN" size="30" value="<%=lineDetail[1]%>" >
  <br>
  </span></span><span class="title"><span class="title">城市名(中)： 
  <input type="text" name="cityNameGB" size="20" value="<%=lineDetail[6]%>" disabled >
  <br>
  </span></span><span class="title"><span class="title">行程介绍(中)：
  <TEXTAREA cols=40 name="scheGB" rows=3>&nbsp;<%=lineDetail[2]%></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">行程介绍(英)：
  <TEXTAREA cols=40 name="scheEN" rows=3>&nbsp;<%=lineDetail[3]%></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">服务内容(中)：
  <TEXTAREA cols=40 name="servicesGB" rows=3>&nbsp;<%=lineDetail[4]%></TEXTAREA>
  <br>
   </span></span><span class="title"><span class="title">服务内容(英)：
  <TEXTAREA cols=40 name="servicesEN" rows=3>&nbsp;<%=lineDetail[5]%></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">最近操作员：
    <input type="text" name="man_id" size="20" value="<%=lineDetail[7]%>" disabled >
    <br>
    <br>
   </span></span></span></span></p>
  <table width="250" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
        <div align="center"><input type="submit" value="内容修改提交" name="changSub"></div>
      </td>
    </tr>
  </table>
  </form>
  <p><span class="title"><span class="title"><span class="title"><span class="title"> 
    </span></span></span></span></p>
  <hr>
  <p align="center"><span class="title"><a href="javascript:window.close();">关闭窗口</a></span></p>
<br>
</body>
</html>

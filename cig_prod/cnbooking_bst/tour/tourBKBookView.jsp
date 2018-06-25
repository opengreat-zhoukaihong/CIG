<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
function zy_callpage(url) {
  var newwin=window.open(url,"DetailWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }

function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}
//-->
</script>
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
    String book_ID = request.getParameter("book_ID");
    String line_ID=request.getParameter("line_ID");
    String ope_ID=request.getParameter("ope_ID");
%>
<jsp:useBean id="TourBKBookView" scope="page" class="com.cnbooking.bst.tour.TourBKBookView" /> 
<%
TourBKBookView.setLangCode("GB");
TourBKBookView.setBook_ID(book_ID);
TourBKBookView.setLine_ID(line_ID);
String[] bookDetail;
bookDetail=TourBKBookView.getBookDetail();
bookDetail=bookDetail==null?(new String[21]):bookDetail;
%>
<body bgcolor="#FFFFFF">
 <form method="POST" action="tourBKBookChang.jsp">
 <input type=hidden name="ope_ID" value="<%=ope_ID%>" >
 <input type=hidden name="book_ID" value="<%=book_ID%>" >
 <input type=hidden name="line_ID" value="<%=line_ID%>" >
 <p><span class="title"><span class="title">出发时间： 
   <input type="text" name="bgn_Time" size="20" value="<%=bookDetail[9]%>" disabled >
   <br>
   预定人数： 
   <input type="text" name="quantity" size="20" value="<%=bookDetail[0]%>" >
    <br>
    游客姓名： 
    <input type="text" name="passenger" size="40" value="<%=bookDetail[6]%>">
    <br>
    </span></span><span class="title"><span class="title">价　　格： 
    <input type="text" name="price" size="20" value="<%=bookDetail[7]%>"><%=bookDetail[8]%>
    <br>
    </span></span><span class="title"><span class="title">联 系 人： 
    <input type="text" name="contact" size="15" value="<%=bookDetail[10]%>">
    <br>
    </span></span><span class="title"><span class="title">邮　　编： 
    <input type="text" name="cont_PostCode" size="20" value="<%=bookDetail[11]%>" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
    电　　话： 
    <input type="text" name="cont_Tel" size="20" value="<%=bookDetail[12]%>">
    <br>
    </span></span><span class="title"><span class="title">手　　机： 
    <input type="text" name="cont_Mobile" size="20"value="<%=bookDetail[13]%>" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
    传　　真： 
    <input type="text" name="cont_Fax" size="20" value="<%=bookDetail[14]%>">
    <br>
    </span></span><span class="title"><span class="title">E - Mail： 
    <input type="text" name="cont_Email" size="20" value="<%=bookDetail[15]%>" >
    <br>
    地　址(一)： 
    <input type="text" name="cont_Address1" size="20" value="<%=bookDetail[16]%>">
    <br>
    地　址(二)： 
    <input type="text" name="cont_Address2" size="20" value="<%=bookDetail[17]%>">
    <br>
    </span></span><span class="title"><span class="title">性　　别： 
    <select name="cont_Gender" >
    <option value="M" <%if(bookDetail[18].equals("M")){%>selected<%}%> >先生</option>
    <option value="F" <%if(bookDetail[18].equals("F")){%>selected<%}%> >女士</option>
    </select>
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
  <table width="300" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
  <form method="POST" action="">
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">城   市：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[1]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">旅行社电话：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[2]%></span></span></td>
    </tr>
    <tr> 
      <td height="30" width="80"> 
        <div align="right"><span class="title"><span class="title">旅游主题：</span></span></div>
      </td>
      <td height="30" width="220"><span class="title"><span class="title"><%=bookDetail[3]%></span></span></td>
    </tr>
    <tr> 
      <td height="40" width="80"> 
        <div align="right"><span class="title"><span class="title">行程介绍：</span></span></div>
      </td>
      <td height="40" width="220"><span class="title"><span class="title"><%=bookDetail[4]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="40" width="80"> 
        <div align="right"><span class="title"><span class="title">服务内容：</span></span></div>
      </td>
      <td height="40" width="220"><span class="title"><span class="title"><%=bookDetail[5]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">最近操作员：</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[19]%>&nbsp;</span></span></td>
    </tr>
  </table>
 <p align="center"><span class="title"><a href="javascript:window.close();">关闭窗口</a></span></p>
</form>
<br>
<form method="POST" name="bookDeal" action="tourBKBookDeal.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="book_ID" value="<%=book_ID%>" >
<input type=hidden name="line_ID" value="<%=line_ID%>" >
   <p><span class="txt">对此表单
    <select size="1" name="dealStatus">
     <option value="S">完成</option>
     <option value="F">取消</option>
     <option value="D">删除</option>
</select>
<input type="submit" value="确定" name="B1">
</span></p>
</form>
</body>
</html>

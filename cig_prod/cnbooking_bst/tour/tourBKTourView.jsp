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
// -->
</script>
<title>��̨����</title>
<style type="text/css">
<!--
 input {font-family: "����"; font-size: 12px ;color:#666666}
 select {font-family: "����"; font-size: 12px ; color:#666666}
 td {font-family: "����", "Times New Roman"; font-size: 12px; color:#666666; line-height: 18px}
 A:link {text-decoration: none; color: #715922; font-family: ����}
 A:visited {text-decoration: none; color: #715922; font-family: ����}
 A:active {text-decoration: none; font-family: ����}
 A:hover {text-decoration: underline; color:#CAA54D}
 .title { font-size: 12px; font-weight: normal; font-family: "����"}
-->
</style>
</head>
<%
    String line_ID=request.getParameter("line_ID");
%>
<jsp:useBean id="TourBKTourView" scope="page" class="com.cnbooking.bst.tour.TourBKTourView" /> 
<%
TourBKTourView.setLangCode("GB");
TourBKTourView.setLine_ID(line_ID);
String[] tourDetail;
tourDetail=TourBKTourView.getTourDetail();
tourDetail=tourDetail==null?(new String[18]):tourDetail;
%>
<body bgcolor="#FFFFFF">
 <p><span class="title"><span class="title"><span class="title"><span class="title"> 
   </span></span></span></span></p>
<hr>
<table width="300" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
<form method="POST" action="">
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�������⣺</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[0]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">ͼƬ����</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[3]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��������</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[4]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">ͼƬ·����</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[5]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��һ�۸�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[6]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�ܶ��۸�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[7]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�����۸�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[8]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">���ļ۸�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[9]%>&nbsp;&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">����۸�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[10]%>&nbsp;&nbsp;</span></span></td>
    </tr>
        <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�����۸�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[11]%></span></span></td>
    </tr>
        <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">���ռ۸�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[13]%><%=tourDetail[12]%>&nbsp;&nbsp;</span></span></td>
    </tr>
        <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��ϵ�绰��</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[14]%>&nbsp;&nbsp;</span></span></td>
    </tr>
        <tr> 
      <td height="40" width="80"> 
        <div align="right"><span class="title"><span class="title">�г̽��ۣ�</span></span></div>
      </td>
      <td height="40" width="220"><span class="title"><span class="title"><%=tourDetail[1]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
     <td height="40" width="80"> 
        <div align="right"><span class="title"><span class="title">�������ݣ�</span></span></div>
      </td>
      <td height="40" width="220"><span class="title"><span class="title"><%=tourDetail[2]%>&nbsp;</span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�������Ա��</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=tourDetail[15]%>&nbsp;&nbsp;</span></span></td>
    </tr>
  </table>
  <p align="center"><span class="title"><a href="javascript:window.close();">�رմ���</a></span></p>
</form>
<br>
</body>
</html>

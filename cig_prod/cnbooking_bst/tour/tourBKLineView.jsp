<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
<p><span class="title"><span class="title">��������(��)�� 
<input type="text" name="titleGB" size="30" value="<%=lineDetail[0]%>" >
<br>
 ��������(Ӣ)�� 
 <input type="text" name="titleEN" size="30" value="<%=lineDetail[1]%>" >
  <br>
  </span></span><span class="title"><span class="title">������(��)�� 
  <input type="text" name="cityNameGB" size="20" value="<%=lineDetail[6]%>" disabled >
  <br>
  </span></span><span class="title"><span class="title">�г̽���(��)��
  <TEXTAREA cols=40 name="scheGB" rows=3>&nbsp;<%=lineDetail[2]%></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">�г̽���(Ӣ)��
  <TEXTAREA cols=40 name="scheEN" rows=3>&nbsp;<%=lineDetail[3]%></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">��������(��)��
  <TEXTAREA cols=40 name="servicesGB" rows=3>&nbsp;<%=lineDetail[4]%></TEXTAREA>
  <br>
   </span></span><span class="title"><span class="title">��������(Ӣ)��
  <TEXTAREA cols=40 name="servicesEN" rows=3>&nbsp;<%=lineDetail[5]%></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">�������Ա��
    <input type="text" name="man_id" size="20" value="<%=lineDetail[7]%>" disabled >
    <br>
    <br>
   </span></span></span></span></p>
  <table width="250" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
        <div align="center"><input type="submit" value="�����޸��ύ" name="changSub"></div>
      </td>
    </tr>
  </table>
  </form>
  <p><span class="title"><span class="title"><span class="title"><span class="title"> 
    </span></span></span></span></p>
  <hr>
  <p align="center"><span class="title"><a href="javascript:window.close();">�رմ���</a></span></p>
<br>
</body>
</html>

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

//-->
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
    String book_ID = request.getParameter("book_ID");
    String flight_Seq=request.getParameter("flight_Seq");
    String ope_ID=request.getParameter("ope_ID");
%>
<jsp:useBean id="FlightBKBookView" scope="page" class="com.cnbooking.bst.flight.FlightBKBookView" /> 
<%
FlightBKBookView.setLangCode("GB");
FlightBKBookView.setFl_Book_ID(book_ID);
FlightBKBookView.setFlight_Seq(flight_Seq);
String[] bookDetail;
bookDetail=FlightBKBookView.getBookDetail();
bookDetail=bookDetail==null?(new String[30]):bookDetail;
%>
<body bgcolor="#FFFFFF">
<form method="POST" action="FlightBKBookChang.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="dealID" value="<%=book_ID%>" >
<input type=hidden name="dealSeq" value="<%=flight_Seq%>" >
<p><span class="title"><span class="title">���ʱ�䣺 
<input type="text" name="takeOff_Time" size="20" value="<%=bookDetail[0]%>" disabled >
    <br>
    �س�ʱ�䣺 
    <input type="text" name="return_Time" size="20" value="<%=bookDetail[2]%>" disabled >
    <br>
    </span></span><span class="title"><span class="title">�ۡ����� 
    <input type="text" name="price" size="20" value="<%=bookDetail[4]%>"><%=bookDetail[5]%>
    <br>
    </span></span><span class="title"><span class="title">�� ϵ �ˣ� 
    <input type="text" name="contact" size="15" value="<%=bookDetail[6]%>">
    <br>
    </span></span><span class="title"><span class="title">�ʡ����ࣺ 
    <input type="text" name="cont_PostCode" size="20" value="<%=bookDetail[7]%>" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
    �硡������ 
    <input type="text" name="cont_Tel" size="20" value="<%=bookDetail[8]%>">
    <br>
    </span></span><span class="title"><span class="title">�֡������� 
    <input type="text" name="cont_Mobile" size="20"value="<%=bookDetail[9]%>" >
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
    �������棺 
    <input type="text" name="cont_Fax" size="20" value="<%=bookDetail[10]%>">
    <br>
    </span></span><span class="title"><span class="title">E - Mail�� 
    <input type="text" name="cont_Email" size="20" value="<%=bookDetail[11]%>" >
    <br>
    �ء���ַ�� 
    <input type="text" name="cont_Address" size="20" value="<%=bookDetail[12]%>">
    <br>
    </span></span><span class="title"><span class="title">�ԡ����� 
    <select name="cont_Gender" >
    <option value="M" <%if(bookDetail[13].equals("M")){%>selected<%}%> >����</option>
    <option value="F" <%if(bookDetail[13].equals("F")){%>selected<%}%> >Ůʿ</option>
    </select>
    <br>
    �ˡ������� 
    <input type="text" name="quantity" size="15" value="<%=bookDetail[3]%>">
    <br>
    </span></span><span class="title"><span class="title">�� �� ���� 
    <input type="text" name="passenger" size="40" value="<%=bookDetail[15]%>">
    <br>
    <span class="title">��λ�ȼ���</span> <span class="title"> 
    <select name="seatClass" >
    <option value="E" <%if(bookDetail[27].equals("E")){%> selected <%}%> >���ò�</option>
    <option value="B" <%if(bookDetail[27].equals("B")){%> selected <%}%>> �����</option>
    <option value="F" <%if(bookDetail[27].equals("F")){%> selected <%}%>>ͷ�Ȳ�</option>
    </select>
    <br>
    <span class="title">�������</span> <span class="title"> 
    <select name="round_Trip" >
    <option value="O" <%if(bookDetail[28].equals("O")){%> selected <%}%> >����</option>
    <option value="R" <%if(bookDetail[28].equals("R")){%> selected <%}%>> ˫��</option>
    </select>
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
  <table width="300" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
  <form method="POST" action="">
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�ɻ��ͺţ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[16]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��ɳ��У�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[17]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        </span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">������У�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[18]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">����ʱ�䣺</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[21]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">������ͣ��</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[22]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��ɻ�����</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[24]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">���������</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[25]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�� �� �ţ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[29]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">�ǡ����ڣ�</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[26]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">���չ�˾��</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[23]%></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��Ʊ��Ա��</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><a href="../BookBKCustView.jsp?cust_ID=<%=bookDetail[1]%>" onClick="return zy_callpage(this.href);"><%=bookDetail[19]%></a></span></span></td>
    </tr>
    <tr> 
      <td height="20" width="80"> 
        <div align="right"><span class="title"><span class="title">��Ա�绰��</span></span></div>
      </td>
      <td height="20" width="220"><span class="title"><span class="title"><%=bookDetail[20]%></span></span></td>
    </tr>
  </table>
  <p align="center"><span class="title"><a href="javascript:window.close();">�رմ���</a></span></p>
</form>
<br>
<form method="POST" name="bookDeal" action="FlightBKBookDeal.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="dealID" value="<%=book_ID%>" >
<input type=hidden name="dealSeq" value="<%=flight_Seq%>" >
   <p><span class="txt">�Դ˱�
    <select size="1" name="dealStatus">
     <option value="S">���</option>
     <option value="F">ȡ��</option>
     <option value="D">ɾ��</option>
</select>
<input type="submit" value="ȷ��" name="B1">
</span></p>
</form>
</body>
</html>

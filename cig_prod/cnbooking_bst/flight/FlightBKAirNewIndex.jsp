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
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnFlOthMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
<%}%>
<%
    String ope_ID=request.getParameter("ope_ID");
%>
<body bgcolor="#FFFFFF">
<form method="POST" name="AirMap" action="FlightBKAirInsert.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<p><span class="title"><span class="title">���չ�˾��(��)�� 
<input type="text" name="airNameGB" size="20" value="" >
  <br>
  ���չ�˾��(Ӣ)�� 
  <input type="text" name="airNameEN" size="20" value="" >
  <br>
  </span></span><span class="title"><span class="title">�������Ա��
   <input type="text" name="man_id" size="20" value="<%=ope_ID%>" disabled >
   <br>
   <br>
   </span></span></span></span></p>
  <table width="250" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
        <div align="center"><input type="submit" value="����ύ" name="changSub"></div>
      </td>
    </tr>
  </table>
  </form>
  <p><span  class="title"><span class="title"><span class="title"><span class="title"> 
    </span></span></span></span></p>
  <hr>
  <br>
</body>
</html>

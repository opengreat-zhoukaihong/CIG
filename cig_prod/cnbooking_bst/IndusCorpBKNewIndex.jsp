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
<script language="JavaScript">
<!--
function changeCity(){
document.CorpMap.cityNameGB.value=document.CorpMap.cityID.options[document.CorpMap.cityID.selectedIndex].text;
document.CorpMap.city_ID.value=document.CorpMap.cityID.options[document.CorpMap.cityID.selectedIndex].value;
}
//-->
</script>
</head>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnHtCorpMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=Sorry! You have no permission!" />
<%}%>
<%
    String ope_ID=request.getParameter("ope_ID");
%>
<jsp:useBean id="BKCity" scope="page" class="com.cnbooking.bst.BKCity" /> 
<%
int cityCount=0;
String[][] cityList;
cityList=BKCity.getCityList();
cityCount=BKCity.getCityCount();
%>
<body bgcolor="#FFFFFF">
<form method="POST" name="CorpMap" action="IndusCorpBKInsert.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="city_ID" value="0"  >
<p><span class="title"><span class="title">ͬ�й�˾���� 
<input type="text" name="corpShortName" size="20" value="" >
 <br>
  ͬ�й�˾������ 
 <input type="text" name="corpName" size="32" value="" >
  <br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="cityID" onchange="javascript:changeCity();">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][0]%>" ><%=cityList[i][1]%></option>
 <%}%>
 <option value="0">����</option></select>
 <br>
  </span></span><span class="title"><span class="title">������(��)�� 
  <input type="text" name="cityNameGB" size="20" value="" disabled >
  <br>
  </span></span><span class="title"><span class="title">��ϵ�ˣ� 
  <input type="text" name="contact_Name" size="20" value="" >
 <br>
  </span></span><span class="title"><span class="title">�绰�� 
  <input type="text" name="tel" size="20" value="" >
  <br>
  </span></span><span class="title"><span class="title">��  �棺 
  <input type="text" name="fax" size="20" value="" >
  <br>
  </span></span><span class="title"><span class="title">��  ��:
  <input type="text" name="mobile" size="20" value="" >
  <br>
  </span></span><span class="title"><span class="title">E_mail�� 
  <input type="text" name="email" size="20" value="" >
  <br>
  </span></span><span class="title"><span class="title">URL�� 
  <input type="text" name="urls" size="20" value="" >
  <br>
  </span></span><span class="title"><span class="title">ʧЧ���ڣ� 
  <input type="text" name="inva_Date" size="20" value="2001-10-10" >
  <br>
  </span></span><span class="title"><span class="title">��  ע��
  <TEXTAREA cols=40 name="remark" rows=3>&nbsp;</TEXTAREA>
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
  <p><span class="title"><span class="title"><span class="title"><span class="title"> 
    </span></span></span></span></p>
  <hr>
  <br>
</body>
</html>

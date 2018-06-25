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
<script language="JavaScript">
<!--
function changeCity(){
document.CorpMap.cityNameGB.value=document.CorpMap.cityID.options[document.CorpMap.cityID.selectedIndex].text;
document.CorpMap.city_ID.value=document.CorpMap.cityID.options[document.CorpMap.cityID.selectedIndex].value;
}
//-->
</script>
</head>
<%
    String corp_ID = request.getParameter("corp_ID");
    String ope_ID=request.getParameter("ope_ID");
%>
<jsp:useBean id="IndusCorpBKView" scope="page" class="com.cnbooking.bst.IndusCorpBKView" /> 
<%
IndusCorpBKView.setLangCode("GB");
IndusCorpBKView.setCorp_ID(corp_ID);
String[] corpDetail;
corpDetail=IndusCorpBKView.getCorpDetail();
corpDetail=corpDetail==null?(new String[13]):corpDetail;
%>
<jsp:useBean id="BKCity" scope="page" class="com.cnbooking.bst.BKCity" /> 
<%
int cityCount=0;
String[][] cityList;
cityList=BKCity.getCityList();
cityCount=BKCity.getCityCount();
%>
<body bgcolor="#FFFFFF">
<form method="POST" name="CorpMap" action="IndusCorpBKChang.jsp">
<input type=hidden name="ope_ID" value="<%=ope_ID%>" >
<input type=hidden name="corp_ID" value="<%=corp_ID%>" >
<input type=hidden name="city_ID" value="<%=corpDetail[3]%>"  >
<p><span class="title"><span class="title">同行公司名： 
<input type="text" name="corpShortName" size="20" value="<%=corpDetail[10]%>" >
  <br>
  同行公司长名： 
  <input type="text" name="corpName" size="32" value="<%=corpDetail[1]%>" >
  <br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="cityID" onchange="javascript:changeCity();">
 <%for(int i=0;i<cityCount;i++){%>
 <option value="<%=cityList[i][0]%>" <%if(corpDetail[3].equals(cityList[i][0])){%>selected<%}%> ><%=cityList[i][1]%></option>
 <%}%>
 <option value="0">其他</option></select>
 <br>
  </span></span><span class="title"><span class="title">城市名(中)： 
  <input type="text" name="cityNameGB" size="20" value="<%=corpDetail[4]%>" disabled >
  <br>
  </span></span><span class="title"><span class="title">联系人： 
  <input type="text" name="contact_Name" size="20" value="<%=corpDetail[5]%>" >
 <br>
  </span></span><span class="title"><span class="title">电话： 
  <input type="text" name="tel" size="20" value="<%=corpDetail[6]%>" >
  <br>
  </span></span><span class="title"><span class="title">传  真： 
  <input type="text" name="fax" size="20" value="<%=corpDetail[11]%>" >
  <br>
  </span></span><span class="title"><span class="title">手  机:
  <input type="text" name="mobile" size="20" value="<%=corpDetail[7]%>" >
  <br>
  </span></span><span class="title"><span class="title">E_mail： 
  <input type="text" name="email" size="20" value="<%=corpDetail[8]%>" >
  <br>
  </span></span><span class="title"><span class="title">URL： 
  <input type="text" name="urls" size="20" value="<%=corpDetail[9]%>" >
  <br>
  </span></span><span class="title"><span class="title">失效日期： 
  <input type="text" name="inva_Date" size="20" value="<%=corpDetail[13]%>" >
  <br>
  </span></span><span class="title"><span class="title">备  注：
  <TEXTAREA cols=40 name="remark" rows=3>&nbsp;<%=corpDetail[12]%></TEXTAREA>
  <br>
  </span></span><span class="title"><span class="title">最近操作员：
    <input type="text" name="man_id" size="20" value="<%=corpDetail[2]%>" disabled >
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

<%@ page import="java.util.*, java.net.*" %>
<jsp:useBean id="IndusCorpBKChang" scope="page" class="com.cnbooking.bst.IndusCorpBKChang" />
<%
String ope_ID=request.getParameter("ope_ID");
String corp_ID=request.getParameter("corp_ID");

String info="";
String city_ID=request.getParameter("city_ID");
String corpShortName=request.getParameter("corpShortName");
String corpName=request.getParameter("corpName");
String contact_Name=request.getParameter("contact_Name");
String tel=request.getParameter("tel");
String fax=request.getParameter("fax");
String mobile=request.getParameter("mobile");
String email=request.getParameter("email");
String urls=request.getParameter("urls");
String remark=request.getParameter("remark");
String inva_Date=request.getParameter("inva_Date");

 IndusCorpBKChang.setOpeID(ope_ID);
 IndusCorpBKChang.setShortName(corpShortName);
 if(city_ID!=null)
 IndusCorpBKChang.setCity_ID(city_ID);
 IndusCorpBKChang.setContact(contact_Name);
 IndusCorpBKChang.setTel(tel);
 IndusCorpBKChang.setFax(fax);
 IndusCorpBKChang.setMobile(mobile);
 IndusCorpBKChang.setEmail(email);
 IndusCorpBKChang.setUrl(urls);
 IndusCorpBKChang.setRemark(remark);
 IndusCorpBKChang.setCorpName(corpName);
 if(inva_Date!=null)
 IndusCorpBKChang.setInva_Date(inva_Date);
 if(corp_ID!=null)
 IndusCorpBKChang.setCorpID(corp_ID);

 IndusCorpBKChang.setLangCode("GB");

 if(IndusCorpBKChang.UpdateIndusCorp()){
 	info += "恭喜,同行公司更改成功!<br>";
    }
    else{
	info +="很抱歉,同行公司更改未能成功，请检查数据!";
  }
String title="同行公司更改";
response.sendRedirect("ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

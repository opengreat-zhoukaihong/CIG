<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>����D�s���q�бM�a</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "�ө���"; font-size: 12px ;color:#666666}
 select {font-family: "�ө���"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: �ө���}
 A:visited {text-decoration: none; color: #715922; font-family: �ө���}
 A:active {text-decoration: none; font-family: �ө���}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "�ө���", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "�ө���"; font-size: 12px}
-->
</style>
</head>
<%@ page import="com.cig.*" %>
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" /> 
<jsp:useBean id="TourList" scope="page" class="com.cnbooking.tour.TourList" /> 
<jsp:setProperty name="TourList" property="dateFrom" />
<jsp:setProperty name="TourList" property="dateTo" />
<%
    String[] colors = {"#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC"};

    TourList.setLangCode("GB");
    TourList.setPageFlag("N");
    TourList.setRestriction("12");
    int cityCount=0;
    String[][] cityLists;
    cityLists=TourList.getFromCitys();
    cityCount=TourList.getCityCount();

    int tourCount=0;
    String[][] tourList;

%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language="JavaScript" src="/javascript/big/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/big/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;�����ȴ�</font><!-- #EndEditable --></td>
          <td width="415" background="/images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="/images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> 
      <form method="post" action="">
        <table width="550" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr align="center" valign="middle"> 
            <td> <a name="top"></a>
<table width="500" border="0" cellspacing="0" cellpadding="0" height="24">
                <tr> 
                 <%for(int i=0;i<cityCount;i++){%>
                 <td bgcolor="#FFBC04"> 
                    <div align="center"><font face="���^" size="3"><a href="#<%=Convert.g2b(cityLists[i][0])%>">&nbsp;<%=Convert.g2b(cityLists[i][1])%>&nbsp;</a></font></div>
                  </td>
                 <%}%>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <%for(int i=0;i<cityCount;i++){%>
          <%
              String tmpid=cityLists[i][0].trim();
              TourList.setFromCityID(tmpid);
              tourList = TourList.getTourList();
              tourCount = TourList.getTourCount();
          %>
          <tr> 
            <td height="22" bgcolor="<%=Convert.g2b(colors[i])%>"><a name="<%=Convert.g2b(cityLists[i][0])%>"></a><font face="���^" size="3">&nbsp;<%=Convert.g2b(cityLists[i][1])%></font></td>
          </tr>
          <tr> 
            <td> 
              <table width="550" border="1" cellspacing="0" cellpadding="0" bordercolorlight="<%=Convert.g2b(colors[i])%>" bordercolordark="#FFFFFF">
                <tr>
                 <%for(int h=0;h<tourCount;h++){%>
                  <%if(h%2 ==0){%>
                  <td width="275" height="22"> 
                    <div align="center"><a href="TourView.jsp?tour_Line_ID=<%=tourList[h][0]%>"><%=Convert.g2b(tourList[h][2])%></a></div>
                  </td>
                  <%if(h==(tourCount-1)){%><td width="275" height="22"> 
                  <div align="center">&nbsp;</div>
                  </td>
                  </tr><%}%>
                  <%}else{%>
                  <td width="275" height="22"> 
                    <div align="center"><a href="TourView.jsp?tour_Line_ID=<%=tourList[h][0]%>"><%=Convert.g2b(tourList[h][2])%></a></div>
                  </td>
                </tr>
                <%if(h<(tourCount-1)){%>
                <tr>
                <%}}}%> 
              </table>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <div align="center"><a href="#top">��^�W�@��</a></div>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <%}%>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <div align="center"><a href="javascript:window.history.go(-1)">��^</a></div>
            </td>
          </tr>
          <tr> 
            <td>&nbsp; </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
  <tr>
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
<%@ include file="../foot_tel.jsp"%>  
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
<script language="JavaScript" src="/javascript/big/foot.js">
</script>
</table>
</body>
<!-- #EndTemplate --></html>

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
<jsp:useBean id="TourViewDetail" scope="page" class="com.cnbooking.tour.TourViewDetail" /> 
<%
    TourViewDetail.setLangCode("GB");
    String tour_Line_ID=request.getParameter("tour_Line_ID").trim();
    TourViewDetail.setTour_Line_ID(tour_Line_ID);
    TourViewDetail.getTourDetail();
    String weekdays="0000000";
    String opendays="�P��";
    long tmpPrice=1000000;
    long price=0;
    if(TourViewDetail.getPrice0()!=null){
    weekdays=TourViewDetail.change(weekdays,0);
    price=Long.parseLong(TourViewDetail.getPrice0());
    if(price<tmpPrice){tmpPrice=price; }
    opendays+="��";
    }
    if(TourViewDetail.getPrice1()!=null){
    weekdays=TourViewDetail.change(weekdays,1);
    price=Long.parseLong(TourViewDetail.getPrice1());
    if(price<tmpPrice){tmpPrice=price; }
    opendays+="�@";
    }
    if(TourViewDetail.getPrice2()!=null){
    weekdays=TourViewDetail.change(weekdays,2);
    price=Long.parseLong(TourViewDetail.getPrice2());
    if(price<tmpPrice){tmpPrice=price; }
    opendays+="�G";
    }
    if(TourViewDetail.getPrice3()!=null){
    weekdays=TourViewDetail.change(weekdays,3);
    price=Long.parseLong(TourViewDetail.getPrice3());
    if(price<tmpPrice){tmpPrice=price; }
    opendays+="�T";
    }
    if(TourViewDetail.getPrice4()!=null){
    weekdays=TourViewDetail.change(weekdays,4);
    price=Long.parseLong(TourViewDetail.getPrice4());
    if(price<tmpPrice){tmpPrice=price; }
    opendays+="�|";
    }
    if(TourViewDetail.getPrice5()!=null){
    weekdays=TourViewDetail.change(weekdays,5);
    price=Long.parseLong(TourViewDetail.getPrice5());
    if(price<tmpPrice){tmpPrice=price; }
    opendays+="��";
    }
    if(TourViewDetail.getPrice6()!=null){
    weekdays=TourViewDetail.change(weekdays,6);
    price=Long.parseLong(TourViewDetail.getPrice6());
    if(price<tmpPrice){tmpPrice=price; }
    opendays+="��";
    }
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language=javascript>
<!-- //
function submitdata(){
		document.frmPost.submit();
}
//-->
</script>
<table width="663" border="0" cellspacing="0" cellpadding="0" height="60" align="center">
 <tr> 
   <td colspan="2" height="60">
     <script language="JavaScript" src="/javascript/big/title.js">
     </script>
  </td>
 </tr>
</table>
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
<form method="post" name="frmPost" action="TourDestine.jsp">
      <input type=hidden name=tour_Line_ID value="<%=tour_Line_ID%>">
      <input type=hidden name=weekdays value="<%=weekdays%>">
      <input type=hidden name=price value="<%=tmpPrice%>">
      <input type=hidden name=opendays value="<%=opendays%>">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" --> 
      <table border=0 width=600 cellpadding=0 cellspacing=0 align=CENTER>
        <tr> 
          <td width=115 align="center" valign="top">
            <table width="45" border="0" cellspacing="0" cellpadding="0" height="45">
              <tr> 
                <td width="30" height="30">&nbsp;</td>
              </tr>
            </table>
            <%if(TourViewDetail.getFileName()!=null){%><img src="<%=TourViewDetail.getDir_ID()%><%=TourViewDetail.getFileName()%>" width="140" height="88"><%}else{%>&nbsp;<%}%>
            <br>
          </td>
          <td width="4" valign="top"><img src="/images/space.gif" width="4" height="1" border="0"></td>
          <td width="1" bgcolor="#999999" valign="top"><img src="/images/space.gif" width="1" height="1" border="0"></td>
          <td width="5" valign="top"><img src="/images/space.gif" width="5" height="1" border="0"></td>
          <td width=500 valign="top"><br>
            <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
              <tr align="center" bgcolor="#CFC8CF"> 
                <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
              </tr>
              <tr align="center"> 
                <td><span class="bigtxt"><%=Convert.g2b(TourViewDetail.getTitle())%>&nbsp;</span><font color="#000000"> 
                  </font></td>
              </tr>
              <tr align="center"> 
                <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
              </tr>
            </table>
            <br>
            <table border="0" width="100%" cellpadding="0" cellspacing="0">
              <tr> 
                <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp;<%=Convert.g2b(TourViewDetail.getTour_Sche())%>&nbsp;<br>
                  <b><font color="#000000">�A�Ȥ��e</font></b><font color="#000000">�G</font><br>
                  &nbsp; 
                  <table width="450" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="2" valign="top"><%=Convert.g2b(TourViewDetail.getServices())%>&nbsp;</td>
                    </tr>
                  </table>
                  <br>
                  <br>
                  <table width="358" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr> 
                      <td colspan="2"> 
                        <table width="358" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#CCCCCC" bordercolordark="#FFFFFF">
                          <tr> 
                            <td height="26" width="20%"> 
                              <div align="right"><font color="#666666">�X�Τ���G</font></div>
                            </td>
                            <td height="26" width="80%"> 
                              <div align="left">�C�P <%=opendays%></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="26" width="20%"> 
                              <div align="right"><font color="#666666">�O�ΡG</font></div>
                            </td>
                            <td height="26" width="80%"> 
                              <div align="left"><%if(price!=1000000){%> <%=Convert.g2b(TourViewDetail.getCurrency())%><%=price%><%}else{%>�йq <%}%></div>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <br>
                  <br>
                  <table width="138" border="0" cellspacing="0" cellpadding="0" align="center" height="18">
                    <tr align="center" valign="middle"> 
                      <td><a href="javascript:submitdata();"><img src="/images/big/enter_tour.gif" width="138" height="18" border="0"></a></td>
                    </tr>
                  </table>
              </table>
      </table>
      <table width="250" border="0" cellspacing="0" cellpadding="0" align="center" height="30">
        <tr align="center" valign="middle"> 
          <td><a href="javascript:window.history.go(-1)">��^</a></td>
        </tr>
      </table>
      <!-- #EndEditable --></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <tr valign="middle" align="center"> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <td colspan="3" align="center"> <IFRAME width=560  height=350 MARGINWIDTH=0 MARGINHEIGHT=0 HSPACE=0 VSPACE=0 FRAMEBORDER=0 SCROLLING=no BORDERcolor=000000 SRC="/cnbooking/big/foot_tel.jsp"> 
    </IFRAME> <!--Here is ad end.--></td>
  </tr>
  <tr> 
    <td colspan="3" height="3"> 
      <script language="JavaScript" src="/javascript/big/foot.js">
</script>
    </td>
  </tr>
 </form>
</table>
</body>
<!-- #EndTemplate --></html>


<jsp:useBean id="packageDetail" scope="page" class="com.forbrand.show.PackageDetailBean" />
<%
  String giftID = (String) request.getParameter("giftID");
  String langCode = (String) request.getParameter("langCode");
  packageDetail.setGiftID(Integer.parseInt(giftID));
  packageDetail.setLangCode(langCode);
  packageDetail.fetchPackageDetail();
%>
<HTML>
<HEAD>
<title>Package Detail</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/public.css">
</head>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr>
    <td valign="middle">
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle">
          <td class="white-title"  >
              <p>Package Detail of #<%=giftID%> <%= packageDetail.getGiftName() %></p>
          </td>
        </tr>
      </table>
      <br>
      <table  border="1" cellspacing="1" cellpadding="1" width="80%" align="center">
        <tr>
          <td class="bottom-menu" >Measurement</td>
          <td class="bottom-menu" >
          <%if ( packageDetail.getGiftLength_M() != 0 )  {%>
            <%=packageDetail.getGiftLength_M()%>x<%=packageDetail.getGiftWidth_M()%>x<%=packageDetail.getGiftHeight_M()%> cm
          <%}%>&nbsp;
          </td>
          <td class="bottom-menu" >
          <% if ( packageDetail.getGiftLength_I() != 0 ) {%>
            <%=packageDetail.getGiftLength_I()%>x<%=packageDetail.getGiftWidth_I()%>x<%=packageDetail.getGiftHeight_I()%> in
          <%}%>&nbsp;
          </td>
        </tr>
        <tr>
          <td class="bottom-menu">Weight</td>
          <td class="bottom-menu" >
          <%if (packageDetail.getGiftWidth_M() != 0 ) {%>
          <%=packageDetail.getGiftWidth_M()%> Kg
          <%}%>&nbsp;
          </td>
          <td class="bottom-menu">
          <%if (packageDetail.getGiftWidth_I() != 0 ) {%>
          <%=packageDetail.getGiftWidth_I()%> Pd
          <%}%>&nbsp;
          </td>
        </tr>
        <tr>
          <td class="bottom-menu">Color Box Size</td>
          <td class="bottom-menu" >
          <%if (packageDetail.getClrPackLength_M() != 0) {%>
          <%=packageDetail.getClrPackLength_M()%>x<%=packageDetail.getClrPackWidth_M()%>x<%=packageDetail.getClrPackHeight_M()%> cm
          <%}%>&nbsp;
          </td>
          <td class="bottom-menu">
          <%if (packageDetail.getClrPackLength_I() != 0) {%>
          <%=packageDetail.getClrPackLength_I()%>x<%=packageDetail.getClrPackWidth_I()%>x<%=packageDetail.getClrPackHeight_I()%> in
          <%}%>&nbsp;
          </td>
        </tr>
        <tr>
          <td class="bottom-menu">Outer Carton Size</td>
          <td class="bottom-menu" >
          <%if (packageDetail.getPackLength_M() != 0) {%>
          <%=packageDetail.getPackLength_M()%>x<%=packageDetail.getPackWidth_M()%>x<%=packageDetail.getPackHeight_M()%> cm
          <%}%>&nbsp;
          </td>
          <td class="bottom-menu">
          <%if (packageDetail.getPackLength_I() != 0) {%>
          <%=packageDetail.getPackLength_I()%>x<%=packageDetail.getPackWidth_I()%>x<%=packageDetail.getPackHeight_I()%> in
          <%}%>&nbsp;
          </td>
        </tr>
        <tr>
          <td class="bottom-menu">Pieces/Carton</td>
          <td class="bottom-menu" colspan="2" >
          <%if (packageDetail.getQuantityPerPack() != 0) {%>
          <%=packageDetail.getQuantityPerPack()%>
          <%}%>&nbsp;
          </td>
        </tr>
        <tr>
          <td class="bottom-menu">Gross Weight</td>
          <td class="bottom-menu" >
          <%if (packageDetail.getPackGrsWt_M() != 0) {%>
          <%=packageDetail.getPackGrsWt_M()%> Kg
          <%}%>&nbsp;
          </td>
          <td class="bottom-menu">
          <%if (packageDetail.getPackGrsWt_I() != 0) {%>
          <%=packageDetail.getPackGrsWt_I()%> Pd
          <%}%>&nbsp;
          </td>
        </tr>
        <tr>
          <td class="bottom-menu">Net Weight</td>
          <td class="bottom-menu" >
          <%if (packageDetail.getPackNetWt_M() != 0) {%>
          <%=packageDetail.getPackNetWt_M()%> Kg
          <%}%>&nbsp;
          </td>
          <td class="bottom-menu">
          <%if (packageDetail.getPackNetWt_I() != 0) {%>
          <%=packageDetail.getPackNetWt_I()%> Pd
          <%}%>&nbsp;
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle">
          <td class="bottom-menu"  >
            <p class="white-title" align="right"> &gt;&gt;<a href="popup.jsp?giftID=<%= giftID %>&langCode=<%=langCode%>"><font color="#FFFFFF">Go
              Back</font></a>&lt;&lt;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

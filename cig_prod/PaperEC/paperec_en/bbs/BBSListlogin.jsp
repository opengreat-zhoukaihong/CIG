<html>
<head>
<title>MyPaperNetBBS--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<script language="JavaScript">
<!--

var onTop = false
function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}

// -->
</script>
<style type="text/css">
<!--
.white {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none}
a:visited {  text-decoration: none}
a:active {  text-decoration: none}
a:hover {  text-decoration: underline}
td {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 10pt}
.black {  font-family: "Arial", "Helvetica", "sans-serif"; color: #000000}
.algin {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 10pt; text-align: justify; line-height: 18pt}
-->
</style>
</head>
<%
    String area_ID = request.getParameter("area_ID").trim();
    if(area_ID.trim().equals(""))
    area_ID="1";
%> <jsp:useBean id="BBSListLoad" scope="page" class="bbs.BBSListLoad" /> <%
    BBSListLoad.setArea_ID(area_ID);
    int bbsCategoryCount=0;
    String[][] bbsCategoryList;
    
    bbsCategoryList = BBSListLoad.getBbsCategoryList();
    bbsCategoryCount = BBSListLoad.getBbsCategoryCount();
%> 
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="159" height="394"> 
      <script language="JavaScript" src="../../../javascript/caidan.js">
</script>
      <div style="position:absolute; width:141px; height:131px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr  bgcolor="#574ED3" align="center"> 
                  <td width="142" height="22"><b class="white">Specialty Equipment</b></td>
                </tr>
                <%for(int i=0;i<bbsCategoryCount;i++){
                %> 
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="22" width="142"><a href="BBSList.jsp?cate_ID=<%=bbsCategoryList[i][0]%>&area_ID=<%=area_ID%>&pageNo=1" class="white"><%=bbsCategoryList[i][1]%></a></td>
                </tr>
                <% } %> 
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../../../images/images_en/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div>
    </td>
    <td colspan="2" valign="top" height="394"> 
      <table width="550" border="0" cellpadding="4" align="center" bgcolor="#E6EDFB">
        <tr align="center"> 
          <td><b> Rules </b></td>
        </tr>
        <tr> 
          <td height="209"> 
            <ol class="algin">
              <li> All users must obey related laws of the PRC <br>
              </li>
              <li> This forum issues information, PaperEC.com does not <br>
                guarantee the accuracy of this information. <br>
              </li>
              <li> Promulgator has the responsibility to ensure the accuracy <br>
                of this information. <br>
              </li>
              <li> Information expires 30 days after being posted . Please <br>
                re-issue information at that time,if needed. <br>
              </li>
            </ol>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../../../images/images_en/dline.gif" border="0" width="776" height="6"></td>
  </tr>
  <tr align="center"> 
    <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
      2000 PaperEC.com Inc. All Rights Reserved</font></td>
  </tr>
  <tr align="center"> 
    <td><a href="mailto:info@paperec.com"><img src="../../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
  </tr>
</table>
</body>
</html>
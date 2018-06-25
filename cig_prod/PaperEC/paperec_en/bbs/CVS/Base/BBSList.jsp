<html>
<head>
<title>ÎÒµÄÖ½ÍøBBS--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<script language="JavaScript">
<!--

var onTop = false
function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}

function zy_callpage(url) {
  var newwin=window.open(url,"DetailWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=605,height=500");
  newwin.focus();
  return false;
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
    String cate_ID = request.getParameter("cate_ID").trim();
    if(cate_ID.trim().equals(""))
    cate_ID="1";
%> <jsp:useBean id="BBSListLoad" scope="page" class="bbs.BBSListLoad" /> <%
    BBSListLoad.setArea_ID(area_ID);
    int bbsCategoryCount=0;
    String[][] bbsCategoryList;
    
    bbsCategoryList = BBSListLoad.getBbsCategoryList();
    bbsCategoryCount = BBSListLoad.getBbsCategoryCount();
%> <jsp:useBean id="BBSList" scope="page" class="bbs.BBSList" /> <jsp:setProperty name="BBSList" property="pageFlag" value="Y"/> 
<jsp:setProperty name="BBSList" property="restriction" value="15"/> <jsp:setProperty name="BBSList" property="dateFrom" /> 
<jsp:setProperty name="BBSList" property="dateTo" /> <jsp:setProperty name="BBSList" property="keyWord" /> 
<jsp:setProperty name="BBSList" property="pageNo" /> <%
    BBSList.setCate_ID(cate_ID);
    int bbsCount=0;
    int totalPage=0;
    String[][] bbsLists;
    int pageno=0;
    if(!(request.getParameter("pageNo").trim().equals("")))
     pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    
    bbsLists = BBSList.getBbsList();
    bbsCount = BBSList.getBbsCount();
    totalPage = BBSList.getTotalPage();
%> 
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="159" height="394"> 
      <script> NS = (document.layers) ? 1 : 0;	IE = (document.all) ? 1: 0;	self.onError=null; ls_Y = 0; function goto_url(e) {var url = e.options[e.selectedIndex].value; if (url != "") location.href=url;} function smoothscrollMenu() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y) {move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); if(IE) document.all.scrollMenu.style.pixelTop += move; if(NS) document.scrollMenu.top += move; ls_Y = ls_Y + move;} else {move = Math.floor(move); if(IE) d = document.all.scrollMenu.style.pixelTop; else d =document.scrollMenu.top; var dd = d + move;	if (dd >2) { if(IE) document.all.scrollMenu.style.pixelTop += move; else document.scrollMenu.top += move; } ls_Y = ls_Y + move;	}}} function scrollpop() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y){move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}else {move = Math.floor(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}}} if(NS || IE) action = window.setInterval("smoothscrollMenu()",1); function showInfo(){ var newWind=window.open('/dsp_site_pilot_info.html','sitepilotinfo','toolbar=no,titlebar=no,scrollbars=no,status=no,menubar=no,width=375,height=120');
 if(newWind.opener == null) { newWind.opener = window; }} </script>
      <div style="position:absolute; width:141px; height:131px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr  bgcolor="#574ED3" align="center"> <%if(area_ID.trim().equals("3")){%> 
                  <td width="142" height="22"><b class="white">Specialty Equipment</b></td>
                  <%}else{%> 
                  <td width="142" height="22"><b class="white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
                  <%}%> </tr>
                <%for(int i=0;i<bbsCategoryCount;i++){
                %> 
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="22" width="142"><a href="BBSList.jsp?cate_ID=<%=bbsCategoryList[i][0]%>&area_ID=<%=area_ID%>&pageNo=1" class="white"><%=bbsCategoryList[i][1]%></a></td>
                </tr>
                <% } %> 
                <tr align="center" bgcolor="#523ABD"> 
                  <td height="22" class="white" width="139"> Search </td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"><form method="post" action="BBS_Find.jsp"><input type="hidden" name="area_ID"  value="<%=area_ID%>"><input type="hidden" name="pageNo"  value="1"><td height="76"  width="139" class="b9"><%if(area_ID.trim().equals("3")){%>&nbsp;Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<%}else{%>&nbsp;Keyword:<%}%><input type="text" name="titles" accesskey="a" size="8" class="textfield" ><br>&nbsp;Name&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" name="userName" accesskey="a" size="8" class="textfield" ><br><input type="submit" name="Submit" value="search"></td></form></tr>
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
      <form method="post" action="">
        <table width="600" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#F2F7FD" align="center">
          <tr> 
            <td> 
              <table width="600" border="0" cellpadding="4" cellspacing="0" align="center">
                <tr> 
                  <td height="25" bgcolor="#E6EDFB" class="font10">Total Postings: 
                    <font color="red"><%=bbsCount%></font> <%if(bbsCount>1){%>Postings<%}else{%>Posting<%}%>, 
                    <font color="red"><%=totalPage%></font> <%if(totalPage>1){%>Pages<%}else{%>Page<%}%><img src="../../../images/images_en/space.gif" border="0"  width="180" height="1">Page<font color="red"><%=pageno%></font> 
                    <a href="BBS_AddNew.jsp?cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">New 
                    Posting</a>|<%if ((pageno == 1)&&(totalPage>1)){%><a href="BBSList.jsp?pageNo=2&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">Next</a> 
                    <%  }else if ((pageno>1)&&(pageno<totalPage)){%><a href="BBSList.jsp?pageNo=<%=pageno-1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">Previous</a><a href="BBSList.jsp?pageNo=<%=pageno+1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">|Next</a> 
                    <%}else if ((pageno>1)&&(pageno==totalPage)){%> <a href="BBSList.jsp?pageNo=<%=pageno-1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">Previous</a><%  }%>|<a href="BBSList.jsp?pageNo=1&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">First</a> 
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="600" border="0" cellspacing="1" cellpadding="4" align="center">
                      <tr bgcolor="#4078E0"> 
                        <td width="285"><b class="white"> Title </b></td>
                        <td width="87" nowrap><b class="white">Name</b></td>
                        <td width="83" nowrap><b class="white"> Bytes </b></td>
                        <td width="145" nowrap><b class="white"> Time</b></td>
                      </tr>
                      <%
              	  int maxNum = BBSList.restriction;            
              	  if (pageno == totalPage){
              	      maxNum = bbsCount-BBSList.restriction*(pageno-1);
              	  }  
              	  if (bbsCount >0){
              	      for (int i=0;i<maxNum;i++){
              	          if (i%2 ==0){
              %> 
                      <tr bgcolor="#B0C8F0"> 
                        <td bgcolor="#B0C8F0" width="296"> <%}else{%>
                      <tr bgcolor="#D8E4F8"> 
                        <td width="285"><%}%> <a href="BBS_ViewDetail.jsp?cate_ID=<%=cate_ID%>&article_ID=<%=bbsLists[i][1]%>&area_ID=<%=area_ID%>" onClick="return zy_callpage(this.href);"><%=BBSList.makeUpStr(46,bbsLists[i][3])%></a></td>
                        <td width="87" nowrap><%=bbsLists[i][4]%></td>
                        <td width="83" nowrap><%=bbsLists[i][6]%></td>
                        <td width="145" nowrap><%=bbsLists[i][0]%></td>
                      </tr>
                      <%
             }
             }
             %> 
                    </table>
                  </td>
                </tr>
                <tr align="center"> 
                  <td><a href="BBS_AddNew.jsp?cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../../images/images_en/faxtz.gif" border="0"  width="60" height="22"></a><img src="../../../images/images_en/space.gif" width="33" height="1" border="0"> 
                    <%if ((pageno == 1)&&(totalPage>1)){%><a href="BBSList.jsp?pageNo=2&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../../images/images_en/next_page.gif" border="0"  width="60" height="22"></a><img src="../../../images/images_en/space.gif" width="33" height="1" border="0"> 
                    <%  }else if ((pageno>1)&&(pageno<totalPage)){%><a href="BBSList.jsp?pageNo=<%=pageno-1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../../images/images_en/last_page.gif" border="0"  width="60" height="22"></a><img src="../../../images/images_en/space.gif" width="33" height="1" border="0"> 
                    <a href="BBSList.jsp?pageNo=<%=pageno+1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../../images/images_en/next_page.gif"  border="0" width="60" height="22"></a><img src="../../../images/images_en/space.gif" width="33" height="1" border="0"> 
                    <%}else if ((pageno>1)&&(pageno==totalPage)){%> <a href="BBSList.jsp?pageNo=<%=pageno-1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../../images/images_en/last_page.gif"  border="0" width="60" height="22"></a><img src="../../../images/images_en/space.gif" width="33" height="1" border="0"> 
                  </td>
                </tr>
                <%
             }
             %> 
              </table>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../../images/images_en/dline.gif" border="0"  width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

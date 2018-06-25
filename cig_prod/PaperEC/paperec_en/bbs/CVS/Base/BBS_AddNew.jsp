<html>
<head>
<!-- #BeginEditable "doctitle" --> 
<title>BBS--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<!--

var onTop = false
function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}


function validateForm(e){
	if(e.userName.value==''){
	  alert('Please enter your name ,then submit!')
	  e.userName.focus()
	return false;
	}

	if(e.titles.value==''){
	 alert('Please enter titile,then submit!')
	e.titles.focus()
	return false;
	}
	if(e.email.value==''){
	alert('Please enter your email address,then submit!')
	return false;
	}
	if(e.email.value.indexOf("@")<1 ){
         alert(" have error in email address,please check!")
         return false;
    }
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
    String parent_ID="0";
%>
<jsp:useBean id="BBSListLoad" scope="page" class="bbs.BBSListLoad" /> 
<%
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
      <script> NS = (document.layers) ? 1 : 0;	IE = (document.all) ? 1: 0;	self.onError=null; ls_Y = 0; function goto_url(e) {var url = e.options[e.selectedIndex].value; if (url != "") location.href=url;} function smoothscrollMenu() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y) {move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); if(IE) document.all.scrollMenu.style.pixelTop += move; if(NS) document.scrollMenu.top += move; ls_Y = ls_Y + move;} else {move = Math.floor(move); if(IE) d = document.all.scrollMenu.style.pixelTop; else d =document.scrollMenu.top; var dd = d + move;	if (dd >2) { if(IE) document.all.scrollMenu.style.pixelTop += move; else document.scrollMenu.top += move; } ls_Y = ls_Y + move;	}}} function scrollpop() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y){move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}else {move = Math.floor(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}}} if(NS || IE) action = window.setInterval("smoothscrollMenu()",1); function showInfo(){ var newWind=window.open('/dsp_site_pilot_info.html','sitepilotinfo','toolbar=no,titlebar=no,scrollbars=no,status=no,menubar=no,width=375,height=120');
 if(newWind.opener == null) { newWind.opener = window; }} </script>
      <div style="position:absolute; width:141px; height:131px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr  bgcolor="#574ED3" align="center"> 
                    <%if(area_ID.trim().equals("3")){%>
                  <td width="142" height="22"><b class="white">Specialty Equipment</b></td>
                  <%}else{%>
                  <td width="142" height="22"><b class="white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
                  <%}%>
                </tr>
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
      <form method="post" name="bbsIn" action="BBS_AddPost.jsp" onSubmit="return validateForm(bbsIn);">
        <table width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#000000" bordercolordark="#FFFFFF">
          <tr>
            <td> 
              <table width="550" border="0" cellspacing="0" cellpadding="4" bgcolor="#D8E4F8">
                <tr> 
                  <td>UserName:</td>
                  <td> 
                  <input type="hidden" name="area_ID"  value="<%=area_ID%>" >
                  <input type="hidden" name="cate_ID"  value="<%=cate_ID%>" >
                  <input type="hidden" name="parent_ID"  value="<%=parent_ID%>" >
                  <input type="hidden" name="root_ID"  value="0" >
                  <input type="hidden" name="email"  value="yonger@yeah.net" >
                    <input type="text" name="userName">
                  </td>
                </tr>
                <tr> 
                  <td>title:</td>
                  <td> 
                    <input type="text" name="titles">
                  </td>
                </tr>
                <tr> 
                  <td valign="top">content:</td>
                  <td> 
                    <textarea name="content" rows="8" cols="40"></textarea>
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              </table>
              <table width="550" border="0" cellspacing="0" cellpadding="4">
              <tr align="center"><td><input type="submit" value="Post"   style="width:65px" name="submit"></td><td><img src="../../../images/images_en/space.gif" border="0" width="50" height="1"></td>
              <td><input type="reset" value="Cancel"   style="width:65px"  name="button"></td>
              <!--<td><img src="../../../images/images_en/fabubbs.gif" border="0" width="60" height="22"><img src="../../../images/images_en/space.gif" border="0"  width="50" height="1"><img src="../../../images/images_en/qingc.gif" border="0" width="60" height="22"></td>
              -->
                </tr>
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
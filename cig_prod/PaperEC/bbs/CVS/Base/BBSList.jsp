<html>
<!-- #BeginTemplate "/Templates/aboutus_template.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网BBS--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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

function loadform(){
alert("这是一个自动装载例子!");
}
// -->
</script>
<style type="text/css">
<!--
.white {  font-family: "宋体"; font-size: 10pt; color: #FFFFFF}
a:link {  font-family: "宋体"; text-decoration: none}
a:visited {  font-family: "宋体"; text-decoration: none}
a:active {  font-family: "宋体"; text-decoration: none}
a:hover {  font-family: "宋体"; text-decoration: underline}
td {  font-family: "宋体"; font-size: 10pt}
.black {  font-family: "宋体"; color: #000000}
.algin {  font-family: "宋体"; font-size: 10pt; text-align: justify; line-height: 18pt}
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
%>
<jsp:useBean id="BBSListLoad" scope="page" class="bbs.BBSListLoad" /> 
<%
    BBSListLoad.setArea_ID(area_ID);
    int bbsCategoryCount=0;
    String[][] bbsCategoryList;
    
    bbsCategoryList = BBSListLoad.getBbsCategoryList();
    bbsCategoryCount = BBSListLoad.getBbsCategoryCount();
%>

<jsp:useBean id="BBSList" scope="page" class="bbs.BBSList" /> 

<jsp:setProperty name="BBSList" property="pageFlag" value="Y"/>
<jsp:setProperty name="BBSList" property="restriction" value="15"/>
<jsp:setProperty name="BBSList" property="dateFrom" />
<jsp:setProperty name="BBSList" property="dateTo" />
<jsp:setProperty name="BBSList" property="keyWord" />
<jsp:setProperty name="BBSList" property="pageNo" />
<%
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
                <tr bgcolor="#574ED3" align="center"> 
                <%if(area_ID.trim().equals("1")){%>
                  <td width="142" height="22"><b class="white">请选择专业设备</b></td>
                  <%}else{%>
                  <td width="142" height="22"><b class="white"> 人才交流市场 </b></td>
                  <%}%>
                </tr>
                <%for(int i=0;i<bbsCategoryCount;i++){
                %>
                <tr align="center" bgcolor="#4078E0"> 
                  <td height="22" width="142"><a href="BBSList.jsp?cate_ID=<%=bbsCategoryList[i][0]%>&area_ID=<%=area_ID%>&pageNo=1" class="white"><%=bbsCategoryList[i][1]%></a></td>
                </tr>
                <% } %>
                <tr align="center" bgcolor="#523ABD"> 
                  <td height="22" class="white" width="139">帖子查找</td>
                </tr>
                <tr align="center" bgcolor="#FFCC33"> 
                  <form method="post" name="findform" action="BBS_Find.jsp">
                  <input type="hidden" name="area_ID"  value="<%=area_ID%>">
                  <input type="hidden" name="pageNo"  value="1">
                  <td height="76"  width="139" class="b9"><%if(area_ID.trim().equals("1")){%>标　题: 
                  <%}else{%>关键字:<%}%>
                  <input type="text" name="titles" accesskey="a" size="8" class="textfield" >
                  <br>
                  用户名: 
                  <input type="text" name="userName" accesskey="a" size="8" class="textfield" >
                  <br>
                  <input type="submit" name="Submit" value="查找">
                  </td>
                  </form>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td height="20"><a href="#top"><img src="../../images/leftback.gif" border="0" width="141" height="27" border="0"></a></td>
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
                <td height="25" bgcolor="#E6EDFB" class="font10">共有<%=bbsCount%>篇帖子,共<%=totalPage%>页<img src="../../images/space.gif" border="0"  width="300" height="1">第<%=pageno%>页 
                <a href="BBS_AddNew.jsp?cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">我要发言</a>|<%if ((pageno == 1)&&(totalPage>1)){%><a href="BBSList.jsp?pageNo=2&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">下一页</a>
                    <%  }else if ((pageno>1)&&(pageno<totalPage)){%><a href="BBSList.jsp?pageNo=<%=pageno-1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">上一页</a><a href="BBSList.jsp?pageNo=<%=pageno+1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">|下一页</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="BBSList.jsp?pageNo=<%=pageno-1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">上一页</a><%  }%>|<a href="BBSList.jsp?pageNo=1&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>">回到首页</a> 
              </td>
              </tr>
              <tr> 
              <td> 
              <table width="600" border="0" cellspacing="1" cellpadding="4" align="center">
              <tr bgcolor="#4078E0"> 
              <td width="285"><b class="white">帖子标题</b></td>
              <td width="87" nowrap><b class="white">发帖人姓名</b></td>
              <td width="83" nowrap><b class="white">内容字数</b></td>
              <td width="145" nowrap><b class="white">时间</b></td>
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
             <td bgcolor="#B0C8F0" width="296">
             <%}else{%><tr bgcolor="#D8E4F8"> 
              <td width="285"><%}%>
              <a href="BBS_ViewDetail.jsp?cate_ID=<%=cate_ID%>&article_ID=<%=bbsLists[i][1]%>&area_ID=<%=area_ID%>" onClick="return zy_callpage(this.href);"><%=bbsLists[i][3]%></a></td>
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
             <td><a href="BBS_AddNew.jsp?cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../images/faxtz.gif" border="0" width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
             <%if ((pageno == 1)&&(totalPage>1)){%><a href="BBSList.jsp?pageNo=2&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../images/next_page.gif" border="0" width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
             <%  }else if ((pageno>1)&&(pageno<totalPage)){%><a href="BBSList.jsp?pageNo=<%=pageno-1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../images/last_page.gif" border="0" width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
             <a href="BBSList.jsp?pageNo=<%=pageno+1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../images/next_page.gif" border="0" width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
             <%}else if ((pageno>1)&&(pageno==totalPage)){%>
             <a href="BBSList.jsp?pageNo=<%=pageno-1%>&cate_ID=<%=cate_ID%>&area_ID=<%=area_ID%>"><img src="../../images/last_page.gif" border="0" width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
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
          <td><img src="../../images/dline.gif" border="0" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif" border="0" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

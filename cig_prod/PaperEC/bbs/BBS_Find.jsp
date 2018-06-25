<%@ page import="java.util.*, java.net.*" %>
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
%>
<jsp:useBean id="BBSListLoad" scope="page" class="bbs.BBSListLoad" /> 
<%
    BBSListLoad.setArea_ID(area_ID);
    int bbsCategoryCount=0;
    String[][] bbsCategoryList;
    
    bbsCategoryList = BBSListLoad.getBbsCategoryList();
    bbsCategoryCount = BBSListLoad.getBbsCategoryCount();
    
    String findTitle=request.getParameter("titles").trim();
    String userName=request.getParameter("userName").trim();
%>

<jsp:useBean id="BBS_Find" scope="page" class="bbs.BBS_Find" /> 

<jsp:setProperty name="BBS_Find" property="pageFlag" value="Y"/>
<jsp:setProperty name="BBS_Find" property="restriction" value="15"/>
<jsp:setProperty name="BBS_Find" property="dateFrom" />
<jsp:setProperty name="BBS_Find" property="dateTo" />
<jsp:setProperty name="BBS_Find" property="keyWord" />
<jsp:setProperty name="BBS_Find" property="pageNo" />
<%
    BBS_Find.setArea_ID(area_ID);
    BBS_Find.setFindFlag("Y");
    if(!(findTitle.trim().equals(""))){
    BBS_Find.setFindWord(findTitle);
    }
    if(!(userName.trim().equals(""))){
    BBS_Find.setUserName(userName);
    }
    int bbsCount=0;
    int totalPage=0;
    String[][] bbsLists;
    int pageno=1;
    if(!(request.getParameter("pageNo").trim().equals("")))
     pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
    
    bbsLists = BBS_Find.getBbsList();
    bbsCount = BBS_Find.getBbsCount();
    totalPage =BBS_Find.getTotalPage();
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="159" height="394"> 
     <script language="JavaScript" src="../../javascript/caidan.js">
</script>
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
                  <form method="post" action="BBS_Find.jsp">
                  <input type="hidden" name="area_ID"  value="<%=area_ID%>" >
                  <input type="hidden" name="pageNo"  value="1">
                    <td height="76"  width="139" class="b9"><%if(area_ID.trim().equals("1")){%> 标　题: 
                  <%}else{%> 关键字:<%}%>
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
        <table width="600" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#F2F7FD">
          <tr>
            <td>
              <table width="600" border="0" cellpadding="4" cellspacing="0" align="center">
                <tr> 
                <td height="25" bgcolor="#E6EDFB" class="font10">共有<%=bbsCount%>篇帖子,共<%=totalPage%>页<img src="../../images/space.gif" border="0" width="300" height="1">第<%=pageno%>页 
                <%if ((pageno == 1)&&(totalPage>1)){%><a href="BBS_Find.jsp?pageNo=2&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>">下一页</a>
                    <%  }else if ((pageno>1)&&(pageno<totalPage)){%><a href="BBS_Find.jsp?pageNo=<%=pageno-1%>&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>">上一页</a><a href="BBS_Find.jsp?pageNo=<%=pageno+1%>&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>">|下一页</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="BBS_Find.jsp?pageNo=<%=pageno-1%>&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>">上一页</a><%  }%>|<a href="BBS_Find.jsp?pageNo=1&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>">回到首页</a> 
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
              	  int maxNum = BBS_Find.restriction;            
              	  if (pageno == totalPage){
              	      maxNum = bbsCount-BBS_Find.restriction*(pageno-1);
              	  }  
              	  if (bbsCount >0){
              	      for (int i=0;i<maxNum;i++){
              	          if (i%2 ==0){
              %>
             <tr bgcolor="#B0C8F0"> 
             <td bgcolor="#B0C8F0" width="296">
             <%}else{%><tr bgcolor="#D8E4F8"> 
              <td width="285"><%}%>
              <a href="BBS_FindDetail.jsp?cate_ID=<%=bbsLists[i][8]%>&article_ID=<%=bbsLists[i][1]%>&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>" onClick="return zy_callpage(this.href);"><%=bbsLists[i][3]%></a></td>
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
             <td><%if ((pageno == 1)&&(totalPage>1)){%><a href="BBS_Find.jsp?pageNo=2&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>"><img src="../../images/next_page.gif" border="0" width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
             <%  }else if ((pageno>1)&&(pageno<totalPage)){%><a href="BBS_Find.jsp?pageNo=<%=pageno-1%>&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>"><img src="../../images/last_page.gif" border="0" width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
             <a href="BBS_Find.jsp?pageNo=<%=pageno+1%>&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>"><img src="../../images/next_page.gif" border="0"  width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
             <%}else if ((pageno>1)&&(pageno==totalPage)){%>
             <a href="BBS_Find.jsp?pageNo=<%=pageno-1%>&area_ID=<%=area_ID%>&titles=<%=URLEncoder.encode(findTitle)%>&userName=<%=URLEncoder.encode(userName)%>"><img src="../../images/last_page.gif" border="0" width="60" height="22"></a><img src="../../images/space.gif" border="0" width="33" height="1" border="0">
             </td>
             </tr>
             <%}%>
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

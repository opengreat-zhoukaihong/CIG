<html>
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

function validateForm(e){
	if(e.userName1.value==''){
	  alert('请输入您的姓名，然后提交!')
	  e.userName1.focus()
	return false;
	}

	if(e.titles1.value==''){
	 alert('请输入标题，然后提交!')
	e.titles1.focus()
	return false;
	}
	if(e.email.value==''){
	alert('请输入电子邮箱，然后提交!')
	e.email.focus()
	return false;
	}
     if(e.email.value.indexOf("@")<1 ){
         alert("邮件地址有误，请验证后重新输入!")
         e.email.focus()
         return false;
    }
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
    String parent_ID="0";
    
    String findTitle=request.getParameter("titles").trim();
    String userName=request.getParameter("userName").trim();
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
            <td height="20"><a href="#top"><img src="../../images/leftback.gif" width="141" height="27" border="0"></a></td>
          </tr>
        </table>
      </div>
    </td>
    <td colspan="2" valign="top" height="394"> 
      <form method="post" name="bbsIn" action="BBS_FindPost.jsp" onSubmit="return validateForm(bbsIn);">
        <table width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#000000" bordercolordark="#FFFFFF">
          <tr>
            <td> 
              <table width="550" border="0" cellspacing="0" cellpadding="4" bgcolor="#D8E4F8">
                <tr> 
                  <td>姓名：</td>
                  <td> 
                  <input type="hidden" name="titles"  value="<%=findTitle%>" >
                  <input type="hidden" name="userName"  value="<%=userName%>" >
                  <input type="hidden" name="area_ID"  value="<%=area_ID%>" >
                  <input type="hidden" name="cate_ID"  value="<%=cate_ID%>" >
                  <input type="hidden" name="parent_ID"  value="<%=parent_ID%>" >
                  <input type="hidden" name="root_ID"  value="0" >
                  <input type="text" size="33" name="userName1">
                  </td>
                </tr>
                <tr>
                  <td>Email:</td>
                  <td>
                    <input type="text" size="33" name="email">
                  </td>
                </tr>
                <tr> 
                  <td>主题:</td>
                  <td> 
                    <input type="text" size="60" name="titles1">
                  </td>
                </tr>
                <tr> 
                  <td valign="top">内容：</td>
                  <td> 
                    <textarea name="content" rows="8" cols="60"></textarea>
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              </table>
              <table width="550" border="0" cellspacing="0" cellpadding="4">
              <tr align="center"><td><input type="submit" value="发布"   style="width:65px" name="submit"></td><td><img src="../../images/space.gif" border="0" width="50" height="1"></td>
              <td><input type="reset" value="取消"   style="width:65px"  name="button"></td>
              <!--<td><img src="../../images/fabubbs.gif" border="0" width="60" height="22"><img src="../../images/space.gif" border="0"  width="50" height="1"><img src="../../images/qingc.gif" border="0" width="60" height="22"></td>
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
    <td><img src="../../images/dline.gif" border="0" width="776" height="6"></td>
  </tr>
  <tr align="center"> 
    <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
      2000 PaperEC.com Inc. All Rights Reserved</font></td>
  </tr>
  <tr align="center"> 
    <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif" width="80" height="24" border="0"></a></td>
  </tr>
</table>
</body>
</html>
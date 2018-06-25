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
	if(e.userName.value==''){
	  alert('请输入您的姓名，然后提交!')
	  e.userName.focus()
	return false;
	}

	if(e.titles.value==''){
	 alert('请输入标题，然后提交!')
	e.titles.focus()
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

function unloadform(){
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
    String article_ID=request.getParameter("article_ID").trim();
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

<jsp:useBean id="BBS_ViewDetail" scope="page" class="bbs.BBS_ViewDetail" /> 
<jsp:setProperty name="BBS_ViewDetail" property="pageFlag" value="N"/>
<jsp:setProperty name="BBS_ViewDetail" property="restriction" value="16"/>
<%
   BBS_ViewDetail.setArticle_ID(article_ID);
   int articleCount=0;
   int totalPage=0;
   String[][] articleLists;
   int pageno=1;
   articleLists = BBS_ViewDetail.getArticleList();
   articleCount = BBS_ViewDetail.getArticleCount();
   totalPage = BBS_ViewDetail.getTotalPage();
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnUnload="unloadform()">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td colspan="2" valign="top" height="394"> 
      <form method="post" name="bbsIn" action="BBS_AddPost1.jsp"  onSubmit="return validateForm(bbsIn);">
        <table width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#000000" bordercolordark="#FFFFFF">
          <tr>
            <td>
              <table width="550" border="0" cellspacing="0" cellpadding="4" align="center" bgcolor="#D8E4F8">
              <%for(int i=0;i<articleCount;i++){
                %>
              <tr> 
                  <td width="98" height="28">发帖人、时间：</td>
                  <td width="450" height="28"><%=articleLists[i][3]%> 于 <%=articleLists[i][0]%></td>
                </tr>
                <tr> 
                  <td width="98" height="32">标  题 ：</td>
                  <td width="450" height="32"><%=articleLists[i][2]%></td>
                </tr>
                <tr> 
                  <td width="98" valign="top">帖子内容: </td>
                  <td width="450"><%=articleLists[i][5]%></td>
                </tr>
                <tr> 
                  <td width="98">&nbsp;</td>
                  <td width="450" align="right"><a href="javascript:window.close();">关闭窗口</a>|<a href="BBS_ViewDetail.jsp?cate_ID=<%=cate_ID%>&article_ID=<%=articleLists[i][1]%>&area_ID=<%=area_ID%>">回复文本</a></td>
                </tr>
                <tr> 
                  <td colspan="2">
                    <hr>
                  </td>
                </tr>
                <%}%>
              </table>
              <table width="550" border="0" cellspacing="0" cellpadding="4" bgcolor="#D8E4F8">
                <tr> 
                  <td>姓名：</td>
                  <td> 
                  <input type="hidden" name="area_ID"  value="<%=area_ID%>" >
                  <input type="hidden" name="cate_ID"  value="<%=cate_ID%>" >
                  <input type="hidden" name="root_ID"  value="<%=articleLists[0][7]%>" >
                  <input type="hidden" name="parent_ID"  value="<%=article_ID%>" >
                  <input type="hidden" name="email"  value="yonger@yeah.net" >
                  <input type="text" size="33" name="userName">
                  </td>
                </tr>
                <tr> 
                  <td>主题:</td>
                  <td> 
                    <input type="text" size="60" name="titles" value="Re:<%=articleLists[0][2]%>">
                  </td>
                </tr>
                <tr> 
                  <td valign="top">内容：</td>
                  <td> 
                    <textarea name="content" rows="8" cols="60" warp="virtual"></textarea>
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              </table>
              <table width="550" border="0" cellspacing="0" cellpadding="4">
              <tr align="center"><td><input type="submit" value="回复"   style="width:65px" name="submit"></td><td><img src="../../images/space.gif" border="0"  width="50" height="1"></td>
              <td><input type="reset" value="取消"   style="width:65px"  name="button"></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="../../images/dline.gif" border="0"  width="600" height="6"></td>
  </tr>
  <tr align="center"> 
    <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
      2000 PaperEC.com Inc. All Rights Reserved</font></td>
  </tr>
  <tr align="center"> 
    <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif"  border="0" width="80" height="24" border="0"></a></td>
  </tr>
</table>
</body>
</html>
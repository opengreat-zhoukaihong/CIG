
<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/paperec_backm/login.htm");  
    return;
  }
%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  String funcId = "fnConBbsMgr";
  String userId = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userId);

  if(!permTest.isPermitted())
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>

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

function validDateField(object){
	var value = ptrim(object.value);

	if ( !CheckDate(value))
	{
	    alert("输入值非法,请核实!");
	    object.focus();
	}
}

  function ptrim(not_trim){
	var x; var x1;
	for (x=0;not_trim.charAt(x)==' ';x++){}
	for (x1=not_trim.length-1; not_trim.charAt(x1)==' '; x1--){}
	if (x>x1) 
		return "";
	else
		return not_trim.substring(x,x1+1);
}
 
function CheckDate(object_value) { 
 	var array = new Array();
	
	array = object_value.split("-");
	if (array.length !=3){
	    return false;
	}
	if (!CheckInteger(array[0]))
	    return false;
	if (!CheckInteger(array[1]))
	    return false;
	if (!CheckInteger(array[2]))
	    return false;
	if ( eval(array[0])<2000 ||eval(array[0])>9999)
	    return false;
	if ( eval(array[1])<1 ||eval(array[1])>12)
	    return false;
	if ( eval(array[2])<1 ||eval(array[2])>31)
	    return false;
	    
	return true; 
} 
  
function CheckInteger(object_value) { 
	var GoodChars = "0123456789"; 
	var i = 0; 
	for (i=0; i<= object_value.length -1; i++) { 
	    if (GoodChars.indexOf(object_value.charAt(i)) == -1) { 
		return false; 
	    } 
	} 
	return true; 
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

<SCRIPT LANGUAGE="Javascript">
        
    function submitThis(){  
        var mf=document.bbsDelForm;     
 
      	mf.submit();

    }
     
</SCRIPT>
<%
    String area_ID = request.getParameter("area_ID").trim();
    if(area_ID.trim().equals(""))
    area_ID="1";
   
%>

<jsp:useBean id="BBS_Find" scope="page" class="bbs.BBSBK_Find" /> 

<jsp:setProperty name="BBS_Find" property="pageFlag" value="Y"/>
<jsp:setProperty name="BBS_Find" property="restriction" value="15"/>
<jsp:setProperty name="BBS_Find" property="dateFrom" />
<jsp:setProperty name="BBS_Find" property="dateTo" />
<jsp:setProperty name="BBS_Find" property="pageNo" />
<%
    BBS_Find.setArea_ID(area_ID);
    int bbsCount=0;
    int totalPage=0;
    String[][] bbsLists;
    int pageno=1;
    if(!(request.getParameter("pageNo").trim().equals("")))
     pageno= (Integer.valueOf(request.getParameter("pageNo"))).intValue();
     
    String time[]=BBS_Find.getTime();
    bbsLists = BBS_Find.getBbsList();
    bbsCount = BBS_Find.getBbsCount();
    totalPage =BBS_Find.getTotalPage();
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
     <td colspan="2" valign="top" height="394"> 
        <table width="660" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#F2F7FD">
          <tr>
            <td>
              <table width="660" border="0" cellpadding="4" cellspacing="0" align="center">
                <tr> 
                <td height="25" bgcolor="#E6EDFB" class="font10">共有<%=bbsCount%>篇帖子,共<%=totalPage%>页<img src="../../images/space.gif" width="300" border="0" height="1">第<%=pageno%>页 
                <%if ((pageno == 1)&&(totalPage>1)){%><a href="bbsBK_List.jsp?pageNo=2&area_ID=<%=area_ID%>">下一页</a>
                    <%  }else if ((pageno>1)&&(pageno<totalPage)){%><a href="bbsBK_List.jsp?pageNo=<%=pageno-1%>&area_ID=<%=area_ID%>">上一页</a><a href="bbsBK_List.jsp?pageNo=<%=pageno+1%>&area_ID=<%=area_ID%>">|下一页</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="bbsBK_List.jsp?pageNo=<%=pageno-1%>&area_ID=<%=area_ID%>">上一页</a><%  }%>|<a href="bbsBK_List.jsp?pageNo=1&area_ID=<%=area_ID%>">回到首页</a> 
              </td>
              </tr>
              <tr> 
              <td> 
              <table width="660" border="0" cellspacing="1" cellpadding="4" align="center">
              <tr bgcolor="#4078E0"> 
              <td width="290"><b class="white">帖子标题</b></td>
              <td width="88" nowrap><b class="white">发帖人姓名</b></td>
              <td width="83" nowrap><b class="white">内容字数</b></td>
              <td width="145" nowrap><b class="white">时间</b></td>
              <td width="54" nowrap><b class="white">删除</b></td>
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
              <td width="290"><%}%>
              <a href="bbsBK_Detail.jsp?cate_ID=<%=bbsLists[i][8]%>&article_ID=<%=bbsLists[i][1]%>&area_ID=<%=area_ID%>"><%=bbsLists[i][3]%></a></td>
              <td width="88" nowrap><%=bbsLists[i][4]%></td>
              <td width="83" nowrap><%=bbsLists[i][6]%></td>
              <td width="145" nowrap><%=bbsLists[i][0]%></td>
              <td width="54" nowrap><a href="bbsBK_Del.jsp?article_ID=<%=bbsLists[i][1]%>&area_ID=<%=area_ID%>">删除</a></td>
             </tr>
             <%
             }
             }
             %>
             </table>
             </td>
             </tr>
             <tr align="center"> 
             <td><%if ((pageno == 1)&&(totalPage>1)){%><a href="bbsBK_List.jsp?pageNo=2&area_ID=<%=area_ID%>"><img src="../../images/next_page.gif" width="60" border="0" height="22"></a><img src="../../images/space.gif" width="33" height="1" border="0">
             <%  }else if ((pageno>1)&&(pageno<totalPage)){%><a href="bbsBK_List.jsp?pageNo=<%=pageno-1%>&area_ID=<%=area_ID%>"><img src="../../images/last_page.gif"  border="0" width="60" height="22"></a><img src="../../images/space.gif" width="33" height="1" border="0">
             <a href="bbsBK_List.jsp?pageNo=<%=pageno+1%>&area_ID=<%=area_ID%>"><img src="../../images/next_page.gif"  border="0" width="60" height="22"></a><img src="../../images/space.gif" width="33" height="1" border="0">
             <%}else if ((pageno>1)&&(pageno==totalPage)){%>
             <a href="bbsBK_List.jsp?pageNo=<%=pageno-1%>&area_ID=<%=area_ID%>"><img src="../../images/last_page.gif"  border="0" width="60" height="22"></a><img src="../../images/space.gif" width="33" height="1" border="0">
             </td>
             </tr>
             <%}%>
           </table>
          </td>
        </tr>

       <form name="bbsDelForm" method="post" action="bbsBK_DelMore.jsp">
        <tr align="center"> 
            <td colspan="2">删除时间从 
              <input type="hidden" name="area_ID"  value="<%=area_ID%>">
              <input type="text" name="fromDate" size="10"  value=<%=time[1]%> onBlur="validDateField(this)">
              到 
              <input type="text" name="toDate" size="10" value=<%=time[0]%> onBlur="validDateField(this)">
              <a href="" onClick="javascript:submitThis()"><input type="image" border="0" name="imageField" src="../../images/jixu.gif" width="68" height="26">
            </td>
        </tr>
        </form>

       </table>
    </td>
  </tr>
</table>

<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../images/dline.gif"  border="0"  width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

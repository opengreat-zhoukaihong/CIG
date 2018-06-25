<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>后台管理</title>
<style type="text/css">
<!--
 input {font-family: "宋体"; font-size: 12px ;color:#666666}
 select {font-family: "宋体"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 宋体}
 A:visited {text-decoration: none; color: #715922; font-family: 宋体}
 A:active {text-decoration: none; font-family: 宋体}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "宋体", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "宋体"; font-size: 12px}
-->
</style>
<script language="JavaScript">
<!--
function zy_callpage(url) {
  var newwin=window.open(url,"DetailWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }

function launchRemote(url) {
	remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=420,height=455')
}
// -->
</script>
</head>
<%@ page import="java.util.*, java.net.*" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
var wStr
function delForm()
{
    wStr = "";
     for (j=0;j<document.BKList.elements.length;++j)
	{ 
	  if (document.BKList.elements[j].type == "checkbox")
	  {
        if (document.BKList.elements[j].checked == true)
        {
          wStr = wStr + "_" + document.BKList.elements[j].value;  
        }
      }
    }
    if (wStr == "")
    {
      alert ("请选择要处理的航空公司!");
      return;
    }
    document.ListDel.parameteres.value=wStr;
    document.ListDel.submit();
}
//-->
</SCRIPT>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnFlOthMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能!" />
<%}%>
<%
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
    String ope_ID=request.getParameter("ope_ID");
%>

<jsp:useBean id="FlightBKAirList" scope="page" class="com.cnbooking.bst.flight.FlightBKAirList" /> 
<jsp:setProperty name="FlightBKAirList" property="pageFlag" value="Y"/>
<jsp:setProperty name="FlightBKAirList" property="restriction" value="16"/>
<jsp:setProperty name="FlightBKAirList" property="dateFrom" />
<jsp:setProperty name="FlightBKAirList" property="dateTo" />
<jsp:setProperty name="FlightBKAirList" property="airName" />
<%
    String name;
    String value;
    Enumeration e = request.getParameterNames();
    String str="";
    
    while ( e.hasMoreElements()){
    	name = (String)e.nextElement();
	value = request.getParameter(name);

	if ( name.equals("dateFrom") && !value.equals("")) {
	    str += "&dateFrom=" + value;
	}
	if ( name.equals("dateTo") && !value.equals("")) {
	    str += "&dateTo=" + value;
	}
	if ( name.equals("airName") && !value.equals("")) {
	    str += "&airName=" + value;
	}
    }
  
    FlightBKAirList.setLangCode("GB");
    FlightBKAirList.setPageNo(pageNo);
    int airCount=0;
    int totalPage=0;
    String[][] airLists;
    int pageno=1;
    pageno= (Integer.valueOf(pageNo)).intValue();
     
    airLists = FlightBKAirList.getAirList();
    airCount = FlightBKAirList.getAirCount();
    totalPage =FlightBKAirList.getTotalPage();
%>
<body bgcolor="#FFFFFF">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  <span class="txt">航空公司列表</span></p>
<p><span class="txt">共有<%=airCount%>个航空公司,共<%=totalPage%>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;第<%=pageno%>页 
                <%if ((pageno == 1)&&(totalPage>1)){%><a href="FlightBKAirList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">下一页</a>
                <%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="FlightBKAirList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><a href="FlightBKAirList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|下一页</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="FlightBKAirList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><%  }%>|<a href="FlightBKAirList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">回到首页</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="FlightBKAirList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">刷新浏览</a></span></p>
<table border="1" width="100%" height="40" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
<form name="BKList">
  <tr> 
    <td width="25%" height="20" class="txt"><font color="#666666">ID</font></td>
    <td width="25%" height="20" class="txt"><font color="#666666">航空公司名</font></td>
    <td width="25%" height="20" class="txt"><font color="#666666">最近操作员</font></td>
    <td width="25%" height="20" class="txt"><font color="#666666">修改</font></td>
  </tr>
  <%int maxNum = FlightBKAirList.restriction;            
     if (pageno == totalPage){
        maxNum = airCount-FlightBKAirList.restriction*(pageno-1);
     }  
     if (airCount >0){
     for (int i=0;i<maxNum;i++){
    if (i%2 ==0){
    %>
    <tr bgcolor="#ffffff"> 
    <td width="25%" height="20" class="txt">
    <%}else{%><tr bgcolor="#ffffff">
    <td width="25%" height="20" class="txt"><%}%>
    <input type="checkbox" name="ckID" value="<%=airLists[i][0]%>">
    <a href="FlightBKAirView.jsp?air_ID=<%=airLists[i][0]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);"> 
    <%=airLists[i][0]%></a></td>
    <td width="25%" height="20" class="txt"><%=airLists[i][1]%> </td>
    <td width="25%" height="20" class="txt"><%=airLists[i][2]%></td>
    <td width="25%" height="20" class="txt"><a href="FlightBKAirView.jsp?air_ID=<%=airLists[i][0]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);">修改 </a> </td>
    </tr>
    <%
    }
    }
    %> 
</form>    
</table>
<p><span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if ((pageno == 1)&&(totalPage>1)){%><a href="FlightBKAirList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">下一页</a>
<%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="FlightBKAirList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><a href="FlightBKAirList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|下一页</a>
<%}else if ((pageno>1)&&(pageno==totalPage)){%>
<a href="FlightBKAirList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><%  }%>|<a href="FlightBKAirList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">回到首页</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="FlightBKAirList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">刷新浏览</a>
 </span></p>
<form method="POST" name="ListDel" action="FlightBKAirDel.jsp">
<input type=hidden name="parameteres" >
<input type=hidden name="pageNo"  value="<%=pageNo%>">
<input type=hidden name="ope_ID"  value="<%=ope_ID%>">
<input type=hidden name="str"  value="<%=str%>">
<p><span class="txt">对所选航空公司
<input type="button" value="删除" name="B1" onclick="javascript:delForm();" >
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div align="center"><a href="FlightBKAirNewIndex.jsp?ope_ID=<%=ope_ID%>">新添加</a></div>
</p>
</form>
</body>
</html>

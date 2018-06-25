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
//-->
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
      alert ("请选择要处理的航线!");
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

<jsp:useBean id="FlightBKLineList" scope="page" class="com.cnbooking.bst.flight.FlightBKLineList" /> 
<jsp:setProperty name="FlightBKLineList" property="pageFlag" value="Y"/>
<jsp:setProperty name="FlightBKLineList" property="restriction" value="16"/>
<jsp:setProperty name="FlightBKLineList" property="dateFrom" />
<jsp:setProperty name="FlightBKLineList" property="dateTo" />
<jsp:setProperty name="FlightBKLineList" property="flightID" />
<jsp:setProperty name="FlightBKLineList" property="fromCityID" />
<jsp:setProperty name="FlightBKLineList" property="toCityID" />
<jsp:setProperty name="FlightBKLineList" property="fromPortID" />
<jsp:setProperty name="FlightBKLineList" property="toPortID" />
<jsp:setProperty name="FlightBKLineList" property="airline" />
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
	if ( name.equals("flightID") && !value.equals("")) {
	    str += "&flightID=" + value;
	}
	if ( name.equals("fromCityID") && !value.equals("")) {
	    str += "&fromCityID=" + value;
	}
	if ( name.equals("toCityID") && !value.equals("")) {
	    str += "&toCityID=" + value;
	}
	if ( name.equals("fromPortID") && !value.equals("")) {
	    str += "&fromPortID=" + value;
	}
	if ( name.equals("toPortID") && !value.equals("")) {
	    str += "&toPortID=" + value;
	}
	if ( name.equals("airline") && !value.equals("")) {
	    str += "&airline=" + value;
	}

    }
    
    FlightBKLineList.setLangCode("GB");
    FlightBKLineList.setPageNo(pageNo);
    int lineCount=0;
    int totalPage=0;
    String[][] lineLists;
    int pageno=1;
    pageno= (Integer.valueOf(pageNo)).intValue();
     
    lineLists = FlightBKLineList.getLineList();
    lineCount = FlightBKLineList.getLineCount();
    totalPage =FlightBKLineList.getTotalPage();
%>
<body bgcolor="#FFFFFF">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  <span class="txt">航空线路列表</span></p>
<p><span class="txt">共有<%=lineCount%>条航空线路,共<%=totalPage%>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;第<%=pageno%>页 
                <%if ((pageno == 1)&&(totalPage>1)){%><a href="FlightBKLineList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">下一页</a>
                <%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="FlightBKLineList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><a href="FlightBKLineList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|下一页</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="FlightBKLineList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><%  }%>|<a href="FlightBKLineList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">回到首页</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="FlightBKLineList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">刷新浏览</a></span></p>
<table border="1" width="100%" height="40" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
<form name="BKList">
  <tr> 
    <td width="6%" height="20" class="txt"><font color="#666666">ID</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">航班号 </font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">起飞时间</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">到达时间</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">起飞机场</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">到达机场</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">航空公司</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">机型</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">舱位等级</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">定价</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">现价</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">经停</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">起飞城市</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">到达城市</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">星期</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">航程类型</font></td>
    <td width="4%" height="20" class="txt"><font color="#666666">修改</font></td>
  </tr>
  <%int maxNum = FlightBKLineList.restriction;            
     if (pageno == totalPage){
        maxNum = lineCount-FlightBKLineList.restriction*(pageno-1);
     }  
     if (lineCount >0){
     for (int i=0;i<maxNum;i++){
     String tmp=lineLists[i][12]+"$"+lineLists[i][10]+"$"+lineLists[i][16]+"$"+lineLists[i][15];
    if (i%2 ==0){
    %>
    <tr bgcolor="#ffffff"> 
    <td width="6%" height="20" class="txt">
    <%}else{%><tr bgcolor="#ffffff">
    <td width="6%" height="20" class="txt"><%}%>
    <input type="checkbox" name="ckID" value="<%=tmp%>">
    <a href="FlightBKLineView.jsp?line_Seq=<%=lineLists[i][12]%>&seatClass=<%=lineLists[i][10]%>&round_Trip=<%=lineLists[i][16]%>&weekday=<%=lineLists[i][15]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);"> 
    <%=lineLists[i][12]%></a></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][0]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][1]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][2]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][4]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][5]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][6]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][3]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%if(lineLists[i][10].equals("E")){%>经济舱<%}%><%if(lineLists[i][10].equals("F")){%>头等舱<%}%><%if(lineLists[i][10].equals("B")){%>公务舱<%}%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%if(lineLists[i][7]!=null){%><%=lineLists[i][7]%><%=lineLists[i][9]%><%}else{%>请电<%}%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%if(lineLists[i][8]!=null){%><%=lineLists[i][8]%><%=lineLists[i][9]%><%}else{%>请电<%}%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][11]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][13]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][14]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%=lineLists[i][15]%></div></td>
    <td width="6%" height="20" class="txt"><div align="center"><%if(lineLists[i][16].equals("O")){%>单程<%}%><%if(lineLists[i][16].equals("R")){%>双程<%}%></div></td>
    <td width="4%" height="20" class="txt"><a href="FlightBKLineView.jsp?line_Seq=<%=lineLists[i][12]%>&seatClass=<%=lineLists[i][10]%>&round_Trip=<%=lineLists[i][16]%>&weekday=<%=lineLists[i][15]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);">修改 </a> </td>
    </tr>
    <%
    }
    }
    %> 
</form>    
</table>
<p><span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if ((pageno == 1)&&(totalPage>1)){%><a href="FlightBKLineList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">下一页</a>
<%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="FlightBKLineList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><a href="FlightBKLineList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|下一页</a>
<%}else if ((pageno>1)&&(pageno==totalPage)){%>
<a href="FlightBKLineList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><%  }%>|<a href="FlightBKLineList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">回到首页</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="FlightBKLineList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">刷新浏览</a>
 </span></p>
<form method="POST" name="ListDel" action="FlightBKLineDel.jsp">
<input type=hidden name="parameteres" >
<input type=hidden name="pageNo"  value="<%=pageNo%>">
<input type=hidden name="ope_ID"  value="<%=ope_ID%>">
<input type=hidden name="str"  value="<%=str%>">
<p><span class="txt">对所选航线
<input type="button" value="删除" name="B1" onclick="javascript:delForm();" >
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div align="center"><a href="FlightBKLineNewIndex.jsp?ope_ID=<%=ope_ID%>">新添加</a></div>
</p>
</form>
</body>
</html>

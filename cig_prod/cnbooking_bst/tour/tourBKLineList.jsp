<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��̨����</title>
<style type="text/css">
<!--
 input {font-family: "����"; font-size: 12px ;color:#666666}
 select {font-family: "����"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: ����}
 A:visited {text-decoration: none; color: #715922; font-family: ����}
 A:active {text-decoration: none; font-family: ����}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "����", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "����"; font-size: 12px}
-->
</style>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnTuOthMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
<%}%>
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
      alert ("��ѡ��Ҫ�����������·!");
      return;
    }
    document.ListDel.parameteres.value=wStr;
    document.ListDel.submit();
}
//-->
</SCRIPT>
<%
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
    String ope_ID=request.getParameter("ope_ID");
%>

<jsp:useBean id="TourBKLineList" scope="page" class="com.cnbooking.bst.tour.TourBKLineList" /> 
<jsp:setProperty name="TourBKLineList" property="pageFlag" value="Y"/>
<jsp:setProperty name="TourBKLineList" property="restriction" value="16"/>
<jsp:setProperty name="TourBKLineList" property="dateFrom" />
<jsp:setProperty name="TourBKLineList" property="dateTo" />
<jsp:setProperty name="TourBKLineList" property="title"/>
<jsp:setProperty name="TourBKLineList" property="city_ID"/>
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
	if ( name.equals("title") && !value.equals("")) {
	    str += "&title=" + value;
	}
	if ( name.equals("city_ID") && !value.equals("")) {
	    str += "&city_ID=" + value;
	}

    }
    
    TourBKLineList.setLangCode("GB");
    TourBKLineList.setPageNo(pageNo);
    int lineCount=0;
    int totalPage=0;
    String[][] lineLists;
    int pageno=1;
    pageno= (Integer.valueOf(pageNo)).intValue();
     
    lineLists = TourBKLineList.getLineList();
    lineCount = TourBKLineList.getLineCount();
    totalPage =TourBKLineList.getTotalPage();
%>
<body bgcolor="#FFFFFF">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  <span class="txt">������·�б�</span></p>
<p><span class="txt">����<%=lineCount%>��������·,��<%=totalPage%>ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<%=pageno%>ҳ 
                <%if ((pageno == 1)&&(totalPage>1)){%><a href="tourBKLineList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a>
                <%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="tourBKLineList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><a href="tourBKLineList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|��һҳ</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="tourBKLineList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><%  }%>|<a href="tourBKLineList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">�ص���ҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="tourBKLineList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">ˢ�����</a></span></p>
<table border="1" width="100%" height="40" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
<form name="BKList">
  <tr> 
    <td width="10%" height="20" class="txt"><font color="#666666">ID</font></td>
    <td width="60%" height="20" class="txt"><font color="#666666">��������</font></td>
    <td width="20%" height="20" class="txt"><font color="#666666">������</font></td>
    <td width="10%" height="20" class="txt"><font color="#666666">�޸�</font></td>
  </tr>
  <%int maxNum = TourBKLineList.restriction;            
     if (pageno == totalPage){
        maxNum = lineCount-TourBKLineList.restriction*(pageno-1);
     }  
     if (lineCount >0){
     for (int i=0;i<maxNum;i++){
    if (i%2 ==0){
    %>
    <tr bgcolor="#ffffff"> 
    <td width="10%" height="20" class="txt">
    <%}else{%><tr bgcolor="#ffffff">
    <td width="10%" height="20" class="txt"><%}%>
    <input type="checkbox" name="ckID" value="<%=lineLists[i][0]%>">
    <a href="tourBKLineView.jsp?line_ID=<%=lineLists[i][0]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);"> 
    <%=lineLists[i][0]%></a></td>
    <td width="60%" height="20" class="txt"><%=lineLists[i][1]%> </td>
    <td width="20%" height="20" class="txt"><%=lineLists[i][4]%> </td>
    <td width="10%" height="20" class="txt"><a href="tourBKLineView.jsp?line_ID=<%=lineLists[i][0]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);">�޸� </a> </td>
    </tr>
    <%
    }
    }
    %> 
</form>    
</table>
<p><span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if ((pageno == 1)&&(totalPage>1)){%><a href="tourBKLineList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a>
<%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="tourBKLineList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><a href="tourBKLineList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|��һҳ</a>
<%}else if ((pageno>1)&&(pageno==totalPage)){%>
<a href="tourBKLineList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><%  }%>|<a href="tourBKLineList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">�ص���ҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="tourBKLineList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">ˢ�����</a>
 </span></p>
<form method="POST" name="ListDel" action="tourBKLineDel.jsp">
<input type=hidden name="parameteres" >
<input type=hidden name="pageNo"  value="<%=pageNo%>">
<input type=hidden name="ope_ID"  value="<%=ope_ID%>">
<input type=hidden name="str"  value="<%=str%>">
<input type=hidden name="currPage"  value="tourBKLineList.jsp">
<p><span class="txt">����ѡ������·
<input type="button" value="ɾ��" name="B1" onclick="javascript:delForm();" >
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div align="center"><a href="tourBKLineNewIndex.jsp?ope_ID=<%=ope_ID%>">�����</a></div>
</p>
</form>
</body>
</html>

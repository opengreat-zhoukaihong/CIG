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
      alert ("��ѡ��Ҫ�����ͬ�й�˾!");
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

  funcID = "fnHtCorpMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=Sorry! You have no permission!" />
<%}%>
<%
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
    String ope_ID=request.getParameter("ope_ID");
%>

<jsp:useBean id="IndusCorpBKList" scope="page" class="com.cnbooking.bst.IndusCorpBKList" /> 
<jsp:setProperty name="IndusCorpBKList" property="pageFlag" value="Y"/>
<jsp:setProperty name="IndusCorpBKList" property="restriction" value="16"/>
<jsp:setProperty name="IndusCorpBKList" property="dateFrom" />
<jsp:setProperty name="IndusCorpBKList" property="dateTo" />
<jsp:setProperty name="IndusCorpBKList" property="corpName"/>
<jsp:setProperty name="IndusCorpBKList" property="city_ID"/>
<jsp:setProperty name="IndusCorpBKList" property="contactName"/>
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
	if ( name.equals("corpName") && !value.equals("")) {
	    str += "&corpName=" + value;
	}
	if ( name.equals("city_ID") && !value.equals("")) {
	    str += "&city_ID=" + value;
	}
	if ( name.equals("contactName") && !value.equals("")) {
	    str += "&contactName=" + value;
	}

    }
    
    IndusCorpBKList.setLangCode("GB");
    IndusCorpBKList.setPageNo(pageNo);
    int corpCount=0;
    int totalPage=0;
    String[][] corpLists;
    int pageno=1;
    pageno= (Integer.valueOf(pageNo)).intValue();
     
    corpLists = IndusCorpBKList.getCorpList();
    corpCount = IndusCorpBKList.getCorpCount();
    totalPage =IndusCorpBKList.getTotalPage();
%>
<body bgcolor="#FFFFFF">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  <span class="txt">ͬ�й�˾�б�</span></p>
<p><span class="txt">����<%=corpCount%>��ͬ�й�˾,��<%=totalPage%>ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<%=pageno%>ҳ 
                <%if ((pageno == 1)&&(totalPage>1)){%><a href="IndusCorpBKList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a>
                <%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="IndusCorpBKList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><a href="IndusCorpBKList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|��һҳ</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="IndusCorpBKList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><%  }%>|<a href="IndusCorpBKList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">�ص���ҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="IndusCorpBKList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">ˢ�����</a></span></p>
<table border="1" width="100%" height="40" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
<form name="BKList">
  <tr> 
    <td width="4%" height="20" class="txt"><font color="#666666">ID</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">��˾��</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">������</font></td>
    <td width="14%" height="20" class="txt"><font color="#666666">��ϵ��</font></td>
    <td width="17%" height="20" class="txt"><font color="#666666">�绰</font></td>
    <td width="13%" height="20" class="txt"><font color="#666666">�ֻ�</font></td>
    <td width="11%" height="20" class="txt"><font color="#666666">E_mail</font></td>
    <td width="11%" height="20" class="txt"><font color="#666666">URL</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">ʧЧ����</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">����Ա</font></td>
    <td width="6%" height="20" class="txt"><font color="#666666">�޸�</font></td>
  </tr>
  <%int maxNum = IndusCorpBKList.restriction;            
     if (pageno == totalPage){
        maxNum = corpCount-IndusCorpBKList.restriction*(pageno-1);
     }  
     if (corpCount >0){
     for (int i=0;i<maxNum;i++){
    if (i%2 ==0){
    %>
    <tr bgcolor="#ffffff"> 
    <td width="4%" height="20" class="txt">
    <%}else{%><tr bgcolor="#ffffff">
    <td width="4%" height="20" class="txt"><%}%>
    <input type="checkbox" name="ckID" value="<%=corpLists[i][0]%>">
    <a href="IndusCorpBKView.jsp?corp_ID=<%=corpLists[i][0]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);"> 
    <%=corpLists[i][0]%></a></td>
    <td width="8%" height="20" class="txt"><%=corpLists[i][1]%> </td>
    <td width="8%" height="20" class="txt"><%=corpLists[i][4]%> </td>
    <td width="14%" height="20" class="txt"><%=corpLists[i][5]%> </td>
    <td width="17%" height="20" class="txt"><%=corpLists[i][6]%>&nbsp;</td>
    <td width="13%" height="20" class="txt"><%=corpLists[i][7]%>&nbsp; </td>
    <td width="11%" height="20" class="txt"><%=corpLists[i][8]%>&nbsp; </td>
    <td width="11%" height="20" class="txt"><%=corpLists[i][9]%>&nbsp; </td>
    <td width="6%" height="20" class="txt"><%=corpLists[i][10]%>&nbsp;</td>
    <td width="6%" height="20" class="txt"><%=corpLists[i][2]%></td>
    <td width="6%" height="20" class="txt"><a href="IndusCorpBKView.jsp?corp_ID=<%=corpLists[i][0]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);">�޸� </a> </td>
    </tr>
    <%
    }
    }
    %> 
</form>    
</table>
<p><span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if ((pageno == 1)&&(totalPage>1)){%><a href="IndusCorpBKList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a>
<%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="IndusCorpBKList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><a href="IndusCorpBKList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|��һҳ</a>
<%}else if ((pageno>1)&&(pageno==totalPage)){%>
<a href="IndusCorpBKList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><%  }%>|<a href="IndusCorpBKList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">�ص���ҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="IndusCorpBKList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">ˢ�����</a>
 </span></p>
<form method="POST" name="ListDel" action="IndusCorpBKDel.jsp">
<input type=hidden name="parameteres" >
<input type=hidden name="pageNo"  value="<%=pageNo%>">
<input type=hidden name="ope_ID"  value="<%=ope_ID%>">
<input type=hidden name="str"  value="<%=str%>">
<p><span class="txt">����ѡͬ�й�˾
<input type="button" value="ɾ��" name="B1" onclick="javascript:delForm();" >
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div align="center"><a href="IndusCorpBKNewIndex.jsp?ope_ID=<%=ope_ID%>">�����</a></div>
</p>
</form>
</body>
</html>

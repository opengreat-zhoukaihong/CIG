<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
function zy_callpage(url) {
  var newwin=window.open(url,"book","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }
function zy_callpage1(url) {
  var newwin=window.open(url,"flight","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }
 function zy_callpage2(url) {
  var newwin=window.open(url,"man","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }
//-->
</script>
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
</head>
<%@ page import="java.util.*, java.net.*" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
var wStr
function dealStatusForm()
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
      alert ("��ѡ��Ҫ����Ķ���!");
      return;
    }
    document.ListDeal.parameteres.value=wStr;
    document.ListDeal.submit();
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
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���!" />
<%}%>
<%
    String actions = request.getParameter("actions");
    if(actions==null)
    actions="C";
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
    String ope_ID=request.getParameter("ope_ID");
%>

<jsp:useBean id="FlightBKList" scope="page" class="com.cnbooking.bst.flight.FlightBKList" /> 
<jsp:setProperty name="FlightBKList" property="pageFlag" value="Y"/>
<jsp:setProperty name="FlightBKList" property="restriction" value="16"/>
<jsp:setProperty name="FlightBKList" property="dateFrom" />
<jsp:setProperty name="FlightBKList" property="dateTo" />
<jsp:setProperty name="FlightBKList" property="book_ID"/>
<jsp:setProperty name="FlightBKList" property="contactName"/>
<jsp:setProperty name="FlightBKList" property="passenger"/>
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
	if ( name.equals("book_ID") && !value.equals("")) {
	    str += "&book_ID=" + value;
	}
	if ( name.equals("contactName") && !value.equals("")) {
	    str += "&contactName=" + value;
	}
	if ( name.equals("passenger") && !value.equals("")) {
	    str += "&passenger=" + value;
	}

    }
    FlightBKList.setLangCode("GB");
    FlightBKList.setAction(actions);
    FlightBKList.setPageNo(pageNo);
    int bookCount=0;
    int totalPage=0;
    String[][] bookLists;
    int pageno=1;
    pageno= (Integer.valueOf(pageNo)).intValue();
     
    bookLists = FlightBKList.getBookList();
    bookCount = FlightBKList.getBookCount();
    totalPage =FlightBKList.getTotalPage();
%>
<body bgcolor="#FFFFFF">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  <span class="txt">�¶���</span></p>
<p><span class="txt">����<%=bookCount%>�ݶ���,��<%=totalPage%>ҳ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<%=pageno%>ҳ 
                <%if ((pageno == 1)&&(totalPage>1)){%><a href="FlightBK_List.jsp?pageNo=2&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a>
                <%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="FlightBK_List.jsp?pageNo=<%=pageno-1%>&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><a href="FlightBK_List.jsp?pageNo=<%=pageno+1%>&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">|��һҳ</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="FlightBK_List.jsp?pageNo=<%=pageno-1%>&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><%  }%>|<a href="FlightBK_List.jsp?pageNo=1&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">�ص���ҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="FlightBK_List.jsp?pageNo=<%=pageno%>&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">ˢ�����</a></span></p>
<table border="1" width="100%" height="40" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
<form name="BKList">
  <tr> 
    <td width="8%" height="20" class="txt"><font color="#666666">ID</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">����</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">�����</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">��ϵ��</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">����</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">���ʱ��</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">��ɳ���</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">�������</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">���</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">��λ�ȼ�</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">�۸�</font></td>
    <td width="8%" height="20" class="txt"><font color="#666666">�绰</font></td>
    <td width="4%" height="20" class="txt"><font color="#666666">׳̬</font></td>
  </tr>
  <%int maxNum = FlightBKList.restriction;            
     if (pageno == totalPage){
        maxNum = bookCount-FlightBKList.restriction*(pageno-1);
     }  
     if (bookCount >0){
     for (int i=0;i<maxNum;i++){
     String tmp=bookLists[i][0]+"$"+bookLists[i][15];
    if (i%2 ==0){
    %>
    <tr bgcolor="#ffffff"> 
    <td width="8%" height="20" class="txt">
    <%}else{%><tr bgcolor="#ffffff">
    <td width="8%" height="20" class="txt"><%}%>
    <input type="checkbox" name="ckID" value="<%=tmp%>">
    <a href="FlightBKBookView.jsp?book_ID=<%=bookLists[i][0]%>&flight_Seq=<%=bookLists[i][15]%>&ope_ID=<%=URLEncoder.encode(ope_ID)%>" onClick="return zy_callpage(this.href);"> 
    <%=bookLists[i][0]%></a></td>
    <td width="8%" height="20" class="txt"><%=bookLists[i][9]%> </td>
    <td width="8%" height="20" class="txt"><a href="FlightBKFlightView.jsp?flight_Seq=<%=bookLists[i][15]%>&seatClass=<%=bookLists[i][2]%>&round_Trip=<%=bookLists[i][3]%>&weekday=<%=bookLists[i][12]%>" onClick="return zy_callpage1(this.href);"><%=bookLists[i][1]%></a></td>
    <td width="8%" height="20" class="txt"><a href="../BookBKCustView.jsp?cust_ID=<%=bookLists[i][14]%>" onClick="return zy_callpage2(this.href);"><%=bookLists[i][13]%></td>
    <td width="8%" height="20" class="txt"><%=bookLists[i][5]%> </td>
    <td width="8%" height="20" class="txt"><%=bookLists[i][4]%> </td>                        
    <td width="8%" height="20" class="txt"><%=bookLists[i][10]%> </td>
    <td width="8%" height="20" class="txt"><%=bookLists[i][11]%> </td>
    <td width="8%" height="20" class="txt"><div align="center"><%if(bookLists[i][3].equals("O")){%>����<%}%><%if(bookLists[i][3].equals("R")){%>˫��<%}%></div></td>
    <td width="8%" height="20" class="txt"><div align="center"><%if(bookLists[i][2].equals("E")){%>���ò�<%}%><%if(bookLists[i][2].equals("F")){%>ͷ�Ȳ�<%}%><%if(bookLists[i][2].equals("B")){%>�����<%}%></div> </td>
    <td width="8%" height="20" class="txt"><%if(bookLists[i][6]!=null){%><%=bookLists[i][6]%> <%}else{%> ��� <%}%> </td>
    <td width="8%" height="20" class="txt"><%=bookLists[i][8]%></td>
    <td width="4%" height="20" class="txt"><%if(bookLists[i][16].equals("S")){%>���<%}%><%if(bookLists[i][16].equals("F")){%>ȡ��<%}%><%if(bookLists[i][16].equals("D")){%>ɾ��<%}%><%if(bookLists[i][16].equals("C")){%>δ����<%}%></td>
    </tr>
    <%
    }
    }
    %> 
</form>    
</table>
<p><span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if ((pageno == 1)&&(totalPage>1)){%><a href="FlightBK_List.jsp?pageNo=2&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a>
<%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="FlightBK_List.jsp?pageNo=<%=pageno-1%>&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><a href="FlightBK_List.jsp?pageNo=<%=pageno+1%>&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">|��һҳ</a>
<%}else if ((pageno>1)&&(pageno==totalPage)){%>
<a href="FlightBK_List.jsp?pageNo=<%=pageno-1%>&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">��һҳ</a><%  }%>|<a href="FlightBK_List.jsp?pageNo=1&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">�ص���ҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="FlightBK_List.jsp?pageNo=<%=pageno%>&actions=<%=actions%>&ope_ID=<%=ope_ID%><%=str%>">ˢ�����</a>
 </span></p>
<form method="POST" name="ListDeal" action="FlightBKBookStatus.jsp">
<input type=hidden name="parameteres" >
<input type=hidden name="actions" value="<%=actions%>" >
<input type=hidden name="pageNo"  value="<%=pageNo%>">
<input type=hidden name="ope_ID"  value="<%=ope_ID%>">
<input type=hidden name="str"  value="<%=str%>">
<p><span class="txt">����ѡ��
<select size="1" name="dealStatus">
<option value="S">���</option>
<option value="F">ȡ��</option>
<option value="D">ɾ��</option>
</select>
<input type="button" value="ȷ��" name="B1" onclick="javascript:dealStatusForm()" >
</span></p>
</form>
</body>
</html>

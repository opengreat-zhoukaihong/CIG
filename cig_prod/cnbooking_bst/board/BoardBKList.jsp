<html>
<%@ page import="java.util.*, java.net.*" %>
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
  var newwin=window.open(url,"DetailWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=420,height=500");
  newwin.focus();
  return false;
 }

function validateForm(e){
	if(e.titles.value==''){
	 alert('请输入标题，然后提交!')
	e.titles.focus()
	return false;
	}
}
//-->
</script>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%
  boolean isPermitted;
  String userID;
  String funcID;

  funcID = "fnBbsMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
%>
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
 .font9 {  font-size: 9pt; color: #FF8000; font-weight: normal} 
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "宋体"; font-size: 12px}
-->
</style>
</head>
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
      alert ("请选择要处理的公告单!");
      return;
    }
    document.ListDeal.parameteres.value=wStr;
    document.ListDeal.submit();
}
//-->
</SCRIPT>
<%
    Hashtable pHash =new Hashtable();
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
    String ope_ID=request.getParameter("ope_ID");
    if(ope_ID!=null)
    pHash.put("ope_ID",ope_ID);
%>
<jsp:useBean id="Int_BBS" scope="page" class="com.cnbooking.bst.board.Int_BBS" /> 
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
	    pHash.put(name,value);
	}
	if ( name.equals("dateTo") && !value.equals("")) {
	    str += "&dateTo=" + value;
	    pHash.put(name,value);
	}
	if ( name.equals("keyword") && !value.equals("")) {
	    str += "&keyword=" + URLEncoder.encode(value);
	    pHash.put(name,value);
	}

    }
    pHash.put("pageNo",new Integer(pageNo));
    pHash.put("restriction",new Integer(16));
    pHash.put("pageFlag",new String("Y"));
    Int_BBS.setParameteres(pHash);
    int count=0;
    int totalPage=0;
    String[][] lists;
    int pageno=1;
    pageno= (Integer.valueOf(pageNo)).intValue();
     
    lists=Int_BBS.getList();
    count = Int_BBS.getCount();
    totalPage =Int_BBS.getTotalPage();
%>
<body bgcolor="#FFFFFF">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 <span class="txt">公告版管理</span></p>
<p><span class="txt">共有<%=count%>份公告单,共<%=totalPage%>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;第<%=pageno%>页 
                <%if ((pageno == 1)&&(totalPage>1)){%><a href="BoardBKList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">下一页</a>
                <%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="BoardBKList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><a href="BoardBKList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|下一页</a>
              <%}else if ((pageno>1)&&(pageno==totalPage)){%>
              <a href="BoardBKList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><%  }%>|<a href="BoardBKList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">回到首页</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="BoardBKList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">刷新浏览</a></span></p>
<table border="1" width="100%" height="40" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
<form name="BKList">
  <tr> 
    <td width="20%" height="20" class="txt"><font color="#666666">ID</font></td>
    <td width="20%" height="20" class="txt"><font color="#666666">主题</font></td>
    <td width="20%" height="20" class="txt"><font color="#666666">收信人</font></td>
    <td width="20%" height="20" class="txt"><font color="#666666">发言人</font></td>
    <td width="20%" height="20" class="txt"><font color="#666666">详细查看</font></td>
  </tr>
  <%int maxNum = ((Integer)pHash.get("restriction")).intValue();            
     if (pageno == totalPage){
        maxNum = count-((Integer)pHash.get("restriction")).intValue()*(pageno-1);
     }  
     if (count >0){
     for (int i=0;i<maxNum;i++){
    if (i%2 ==0){
    %>
    <tr bgcolor="#ffffff"> 
    <td width="20%" height="20" class="txt">
    <%}else{%><tr bgcolor="#ffffff">
    <td width="20%" height="20" class="txt"><%}%>
    <input type="checkbox" name="ckID" value="<%=lists[i][0]%>">
    <a href="BoardBKView.jsp?b_ID=<%=lists[i][0]%>" onClick="return zy_callpage(this.href);"> 
    <%=lists[i][0]%></a></td>
    <td width="20%" height="20" class="txt"><%=lists[i][1]%>&nbsp;</td>
    <td width="20%" height="20" class="txt"><%=lists[i][5]%>&nbsp;</td>
    <td width="20%" height="20" class="txt"><%=lists[i][3]%>&nbsp; </td>
    <td width="20%" height="20" class="txt"><a href="BoardBKView.jsp?b_ID=<%=lists[i][0]%>" onClick="return zy_callpage(this.href);">详细查看</a></td>
    </tr>
    <%
    }
    }
    %> 
</form>    
</table>
<p><span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if ((pageno == 1)&&(totalPage>1)){%><a href="BoardBKList.jsp?pageNo=2&ope_ID=<%=ope_ID%><%=str%>">下一页</a>
<%}else if ((pageno>1)&&(pageno<totalPage)){%><a href="BoardBKList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><a href="BoardBKList.jsp?pageNo=<%=pageno+1%>&ope_ID=<%=ope_ID%><%=str%>">|下一页</a>
<%}else if ((pageno>1)&&(pageno==totalPage)){%>
<a href="BoardBKList.jsp?pageNo=<%=pageno-1%>&ope_ID=<%=ope_ID%><%=str%>">上一页</a><%  }%>|<a href="BoardBKList.jsp?pageNo=1&ope_ID=<%=ope_ID%><%=str%>">回到首页</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="BoardBKList.jsp?pageNo=<%=pageno%>&ope_ID=<%=ope_ID%><%=str%>">刷新浏览</a>
 </span></p>
<%if(isPermitted){%>
<form method="POST" name="ListDeal" action="BoardBKDeal.jsp">
<input type=hidden name="parameteres" >
<input type=hidden name="ope_ID"  value="<%=ope_ID%>">
<input type=hidden name="pageNo"  value="<%=pageNo%>">
<input type=hidden name="str"  value="<%=str%>">
<p><span class="txt">对所选公告单
<input type="button" value="删除" name="B1" onclick="javascript:delForm();" >
</span></p>
</form>
<br>
<%}%>
<br>
<div>
<form method="post" name="bbsIn" action="BoardBKAddPost.jsp" onSubmit="return validateForm(bbsIn);">
  <table width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#FF9933" bordercolordark="#FFFFFF">
      <tr>
        <td> 
           <table width="550" border="0" cellspacing="0" cellpadding="4" bgcolor="#ffffff">
             <input type="hidden" name="ope_ID"  value="<%=ope_ID%>" >
             <input type=hidden name="pageNo"  value="<%=pageNo%>">
             <input type=hidden name="str"  value="<%=str%>">
               <tr class="font9"> 
                 <td> to :</td>
                 <td> 
                   <input type="text" size="60" name="att">
                 </td>
                </tr>
               <tr class="font9"> 
                 <td>标题:</td>
                 <td> 
                   <input type="text" size="60" name="titles">
                 </td>
                </tr>
                <tr class="font9"> 
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
              <tr align="center" class="font9"><td><input type="submit" value="发布"   style="width:65px" name="submit"></td><td><img src="/images/space.gif" border="0" width="50" height="1"></td>
              <td><input type="reset" value="取消"   style="width:65px"  name="button"></td>
               </tr>
              </table>
            </td>
          </tr>
      </table>
    </form>
</div>
</body>
</html>

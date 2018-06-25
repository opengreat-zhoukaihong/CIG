
<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 
<% 
  if (!UserInfo.getAuthorized()){
    response.sendRedirect("/paperec_backm/login.htm");  
    return;
  }
%>

<html>
<!-- #BeginTemplate "/Templates/aboutus_template.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
var onTop = false
function launchRemote(url) {
        var remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=556,height=302');
	remote.focus();
        return false;

}
function launchRemote2(url) {
        var newwin=open(url, "pk", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=556,height=302');
	newwin.focus();
        return false;

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

//-->
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
        var mf=document.delForm;     
 
      	mf.submit();

  }
</SCRIPT>

<jsp:useBean id="Equip_Art" scope="page" class="com.paperec.equip.Equip_Art" />
<%  Hashtable pHash =new Hashtable();
    pHash.put("langCode",new String("GB"));
    pHash.put("pageFlag",new String("Y"));
    pHash.put("bst",new String("Y"));
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
    pHash.put("pageNo",new Integer(pageNo));
    pHash.put("restriction",new Integer(16));
    
     String type_ID = request.getParameter("type_ID");
     String art_Type=request.getParameter("art_Type");
     pHash.put("type_ID",type_ID);
     pHash.put("art_Type",art_Type);

     Equip_Art.setParameteres(pHash);
     int artCount=0;
     int totalPage=0;
     String[][] artLists;
     int pageno=1;
     pageno= (Integer.valueOf(pageNo)).intValue();
     
     artLists=  Equip_Art.getList();
     artCount = Equip_Art.getCount();
     totalPage =Equip_Art.getTotalPage();
     
     String[] dates;
     dates=Equip_Art.getOthers();
%> 
<script language="JavaScript">
<!--
function validateForm(e){
    return numericCheck(e);
}

function numericCheck(e){
   var maxPage=<%=totalPage%>
   nr1=e.pageNo.value;
   if(nr1.length==0){
   alert("页数不能为空，只少为1 !\n");
   e.pageNo.focus();
   return false;
   }
   cmp="123456789";
   tst=nr1.substring(0,1);
   if(cmp.indexOf(tst)<0){
   alert("页数 只接受数字，只少为1 !\n");
   e.pageNo.focus();
   return false;
   }
   cmp="0123456789";
   for (var i=1;i<nr1.length;i++){
   tst=nr1.substring(i,i+1);
   if(cmp.indexOf(tst)<0){
   alert("页数 只接受数字!\n");
   e.pageNo.focus();
   return false;
   }
  }
   if(nr1>maxPage){
   alert("页数 不能大于"+maxPage+" !\n");
   e.pageNo.focus();
   return false;
  }
return true;
}
//-->
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
     <td colspan="2" valign="top" height="394"> 
        <table width="600" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#F2F7FD">
          <tr>
            <td>
              <table width="600" border="0" cellpadding="4" cellspacing="0" align="center">
               <tr>
                  <td colspan="2">
                    <hr>
                  </td>
                </tr>
                <%int maxNum = ((Integer)pHash.get("restriction")).intValue();          
                int current= ((Integer)pHash.get("restriction")).intValue()*(pageno-1)+1; 
                if (pageno == totalPage)
                maxNum = artCount-((Integer)pHash.get("restriction")).intValue()*(pageno-1);
                int toTail=current+maxNum;
                if(current>=artCount)
                current=artCount;
                if(toTail>=artCount)
                toTail=artCount;
                %>
                <tr align="center"> 
                  <td colspan="2">共有 <%=artCount%> 条信息。（请点击ID查看详细内容）</td>
                </tr>
                <tr>
               <form method="post" name="toPage" action="equipBKList.jsp" onSubmit="return validateForm(toPage);">
               <input type=hidden name="art_Type" value="<%=art_Type%>" >
               <input type=hidden name="type_ID" value="<%=type_ID%>" >
                  <td>当前显示<%=current%>-<%=toTail%>条（倒序显示）</td><td align="right" nowrap>
                    共<%=totalPage%>页， 第<%=pageNo%>页，到
                    <input type="text" name="pageNo" size="6">
                    页
                    <input type="submit" name="Submit2" value="go">
                    <%if((totalPage>1)&&(pageno<totalPage)){%><a href="equipBKList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageno+1%>">下一页</a><%}%></td>
                </form>
               </tr>
               <tr>
                  <td colspan="2">
                    <table width="600" border="0" cellspacing="1" cellpadding="4">
                      <tr bgcolor="#4078E0" align="center" class="white"> 
                        <td><b>序号</b></td>
                        <td><b>设备名称</b></td>
                        <td><b>生产厂家</b></td>
                        <td><b>型号规格</b></td>
                        <td><b>有效期</b></td>
                        <td><b>点击次数</b></td>
                        <td><b>联系人</b></td>
                        <td><b>电话</b></td>
                        <td><b>壮态</b></td>
                        <td><b>删除</b></td>
                      </tr>
                      <%
                      if (artCount >0){
                      for (int i=0;i<maxNum;i++){
                      if (i%2 ==0){
                      %>
                      <tr bgcolor="#B0C8F0" align="center">
                      <%}else{%><tr bgcolor="#D8E4F8" align="center"> 
                      <%}%>
                       <%if(artLists[i][20]!=null){%>
                       <%if(artLists[i][20].trim().toUpperCase().equals("Y")){%>
                       <td><a href="equipPaperDetail.jsp?art_ID=<%=artLists[i][0]%>" <%if(artLists[i][23].trim().equals("1")){%>onClick="return launchRemote(this.href);"<%}else{%>onClick="return launchRemote2(this.href);"<%}%>><%=artLists[i][0]%></a></td>
                       <%}else{%>
                       <td><a href="equipDetail.jsp?art_ID=<%=artLists[i][0]%>" <%if(artLists[i][23].trim().equals("1")){%>onClick="return launchRemote(this.href);"<%}else{%>onClick="return launchRemote2(this.href);"<%}%>><%=artLists[i][0]%></a></td>
                       <%}%>
                       <%}else{%>
                       <td><a href="equipDetail.jsp?art_ID=<%=artLists[i][0]%>" <%if(artLists[i][23].trim().equals("1")){%>onClick="return launchRemote(this.href);"<%}else{%>onClick="return launchRemote2(this.href);"<%}%>><%=artLists[i][0]%></a></td>
                       <%}%>
                       <td><%=artLists[i][4]%>&nbsp;</td>
                       <td><%=artLists[i][5]%>&nbsp;</td>
                       <td><%=artLists[i][7]%>&nbsp;</td>
                       <td><%=artLists[i][12]%>&nbsp;</td>
                       <td><%if(artLists[i][21]==null){%>0<%}else{%><%=artLists[i][21]%><%}%>&nbsp;</td>
                       <td><%=artLists[i][14]%>&nbsp;</td>
                       <td><%=artLists[i][15]%>&nbsp;</td>
                       <td><%if(artLists[i][23].trim().equals("1")){%><font color=red>原帖</font><%}else{%><font color=yellow>回应</font><%}%>&nbsp;</td>
                       <td><a href="equipDelPost.jsp?art_ID=<%=artLists[i][0]%>&pageNo=<%=pageno%>">删除 </a>&nbsp;</td>
                       </tr>
                      <%}
                      }
                      %>
                    </table>
                  </td>
                </tr>
                <tr align="right">
                <form method="post" name="toPage2" action="equipBKList.jsp" onSubmit="return validateForm(toPage2);">
                <input type=hidden name="art_Type" value="<%=art_Type%>" >
                <input type=hidden name="type_ID" value="<%=type_ID%>" >
                  <td colspan="2">共<%=totalPage%>页， 第<%=pageNo%>页，到
                    <input type="text" name="pageNo" size="6">
                    页
                    <input type="submit" name="Submit2" value="go">
                    <%if((totalPage>1)&&(pageno<totalPage)){%><a href="equipBKList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageno+1%>">下一页</a><%}%></td>
                </form> 
                </tr>
                <tr>
                <td>&nbsp;</td>
                </tr>
           </table>
          </td>
        </tr>

       <form name="delForm" method="post" action="equipDelPost.jsp">
        <tr align="center"> 
            <td colspan="2">删除时间从 
              <input type=hidden name="art_Type" value="<%=art_Type%>" >
              <input type=hidden name="type_ID" value="<%=type_ID%>" >
              <input type="text" name="fromDate" size="10"  value=<%=dates[0]%> onBlur="validDateField(this)">
              到 
              <input type="text" name="toDate" size="10" value=<%=dates[1]%> onBlur="validDateField(this)">
              <a href="" onClick="javascript:submitThis()"><input type="image" border="0" name="imageField" src="/images/jixu.gif" width="68" height="26">
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
          <td><img src="/images/dline.gif"  border="0"  width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="/images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

<html>
<%@ page import="java.util.*, java.net.*" %>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
.title {  font-family: "宋体"; font-size: 14px; font-weight: 400}
-->
</style>
</head>
<script language="JavaScript">
<!--
var onTop = false
function launchRemote(url) {
        var remote=open(url, "pick", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=556,height=302');
	remote.focus();
        return false;

}
//-->
</script>
<%
    Hashtable pHash =new Hashtable();
    String queryString = request.getParameter("queryString");
    if(queryString==null)
    queryString = "0000";
    String queryString2 = request.getParameter("queryString2");
    if(queryString2==null)
    queryString2 = "000000000000000000000000000000000000000000000000000000000000";
%>
<jsp:useBean id="Equip_Cate" scope="page" class="com.paperec.equip.Equip_Cate" /> 
<%
    pHash.put("langCode",new String("GB"));
    pHash.put("pageFlag",new String("N"));
    Equip_Cate.setParameteres(pHash);
    String[][] lists;
    int count=0;
    lists = Equip_Cate.getList();
    count = Equip_Cate.getCount();
    String queryID = request.getParameter("queryID");
    if(queryID!=null)
    queryString=Equip_Cate.setBit(queryString,queryID);
    String queryID2 = request.getParameter("queryID2");
    if(queryID2!=null)
    queryString2=Equip_Cate.setBit(queryString2,queryID2);
%>
<jsp:useBean id="Equip_Type" scope="page" class="com.paperec.equip.Equip_Type" /> 
<%
    Equip_Type.setParameteres(pHash);
    String[][] tlists;
    int tcount=0;
    tlists = Equip_Type.getList();
    tcount = Equip_Type.getCount();
    
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
    pHash.put("pageNo",new Integer(pageNo));
    pHash.put("restriction",new Integer(16));
    pHash.remove("pageFlag");
    pHash.put("pageFlag",new String("Y"));
    String art_Type=request.getParameter("art_Type");
    String type_ID=request.getParameter("type_ID");
    pHash.put("art_Type",art_Type);
    pHash.put("type_ID",type_ID);
%>
<jsp:useBean id="Equip_Art" scope="page" class="com.paperec.equip.Equip_Art" />
<%
     Equip_Art.setParameteres(pHash);
     int artCount=0;
     int totalPage=0;
     String[][] artLists;
     int pageno=1;
     pageno= (Integer.valueOf(pageNo)).intValue();
     
     artLists=Equip_Art.getList();
     artCount = Equip_Art.getCount();
     totalPage =Equip_Art.getTotalPage();
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
<body bgcolor="#FFFFFF"><table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="159" height="394"> 
      <script language="JavaScript" src="/javascript/caidan.js">
      </script>
      <div style="position:absolute; width:141px; height:131px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr bgcolor="#574ED3"> 
                  <td width="142" height="22" class="white" align="center">专业设备</td>
                </tr>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageNo%>&queryString=<%=queryString%>&queryID=0&queryString2=<%=queryString2%>"><font color="#FFFFFF">浏览供应信息</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,0)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageNo%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=i%>"><b><%=lists[i][1]%></b></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString2,i)){%>
                <%for(int j=0;j<tcount;j++){%>
                <%if(tlists[j][0].trim().toUpperCase().equals(lists[i][0].trim().toUpperCase())){%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipList.jsp?art_Type=S&type_ID=<%=tlists[j][1]%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageNo%>&queryString=<%=queryString%>&queryID=1&queryString2=<%=queryString2%>"><font color="#FFFFFF">浏览需求信息</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,1)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageNo%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=count+i%>"><b><%=lists[i][1]%></b></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString2,count+i)){%>
                <%for(int j=0;j<tcount;j++){%>
                <%if(tlists[j][0].trim().toUpperCase().equals(lists[i][0].trim().toUpperCase())){%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipList.jsp?art_Type=B&type_ID=<%=tlists[j][1]%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageNo%>&queryString=<%=queryString%>&queryID=2&queryString2=<%=queryString2%>"><font color="#FFFFFF">发布供应信息</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,2)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageNo%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=2*count+i%>"><b><%=lists[i][1]%></b></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString2,2*count+i)){%>
                <%for(int j=0;j<tcount;j++){%>
                <%if(tlists[j][0].trim().toUpperCase().equals(lists[i][0].trim().toUpperCase())){%>
                <%if(!(tlists[j][3].toUpperCase().equals("Y"))){%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipPutOut.jsp?type_ID=<%=tlists[j][1]%>&art_Type=S&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}else{%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipPaperPutOut.jsp?type_ID=<%=tlists[j][1]%>&art_Type=S&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageNo%>&queryString=<%=queryString%>&queryID=3&queryString2=<%=queryString2%>"><font color="#FFFFFF">发布需求信息</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,3)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageNo%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=3*count+i%>"><b><%=lists[i][1]%></b></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString2,3*count+i)){%>
                <%for(int j=0;j<tcount;j++){%>
                <%if(tlists[j][0].trim().toUpperCase().equals(lists[i][0].trim().toUpperCase())){%>
                <%if(!(tlists[j][3].toUpperCase().equals("Y"))){%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipPutOut.jsp?type_ID=<%=tlists[j][1]%>&art_Type=B&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}else{%>
                <tr align="center" bgcolor="#FFCC33"> 
                  <td height="22"><a href="EquipPaperPutOut.jsp?type_ID=<%=tlists[j][1]%>&art_Type=B&queryString=<%=queryString%>&queryString2=<%=queryString2%>"><font color="#000000"><%=tlists[j][2]%></font></a></td>
                </tr>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <%}%>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><font color="#FFFFFF">设备查询</font></td>
                </tr>
                <tr align="center" bgcolor="#FFCC00"> 
                  <form name="seachform" method="post" action="EquipFindList.jsp">
                    <td height="15" width="142"> 
                      <input type="text" name="keyword" size="8">
                      <input type="submit" name="Submit" value="查找">
                    </td>
                  </form>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td height="20"><a href="#top"><img src="/images/leftback.gif"  width="141" height="27" border="0" ></a></td>
          </tr>
        </table>
      </div>
    </td>

    <td colspan="2" valign="top" height="466"> 
        <table width="600" border="1" cellspacing="0" cellpadding="6" bordercolorlight="#000000" bordercolordark="#FFFFFF" align="center">
          <tr>
            <td>
              <table width="600" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
              
                <tr>
                <td colspan="2" class="title"><b>专业设备--
                <%String tmpEquip="";
                 for(int j=0;j<tcount;j++){
                 if(tlists[j][1].trim().toUpperCase().equals(type_ID.trim().toUpperCase())){
                tmpEquip=tlists[j][2];
                %>
                <%=tmpEquip%>
                <%
                break;
                }
                }%>
                </b></td>
                </tr>
                <tr>
                  <td colspan="2"> ---- <%if(art_Type.trim().toUpperCase().equals("S")){%>供应<%}else{%>需求<%}%>信息列表</td>
                </tr>
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
                  <td colspan="2">共有 <%=artCount%> 条 <%=tmpEquip%> 的 <%if(art_Type.trim().toUpperCase().equals("S")){%> 供应 <%}else{%> 需求 <%}%> 信息。（请点击详细内容查看）</td>
                </tr>
                <tr>
               <form method="post" name="toPage" action="EquipList.jsp" onSubmit="return validateForm(toPage);">
               <input type=hidden name="queryString" value="<%=queryString%>" >
               <input type=hidden name="queryString2" value="<%=queryString2%>" >
               <input type=hidden name="art_Type" value="<%=art_Type%>" >
               <input type=hidden name="type_ID" value="<%=type_ID%>" >
                  <td>当前显示<%=current%>-<%=toTail%>条（倒序显示）</td><td align="right" nowrap>
                    共<%=totalPage%>页， 第<%=pageNo%>页，到
                    <input type="text" name="pageNo" size="6">
                    页
                    <input type="submit" name="Submit2" value="go">
                    <%if((totalPage>1)&&(pageno<totalPage)){%><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageno+1%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>">下一页</a><%}%></td>
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
                        <td><b>详情</b></td>
                      </tr>
                      <%
                      if (artCount >0){
                      for (int i=0;i<maxNum;i++){
                      if (i%2 ==0){
                      %>
                      <tr bgcolor="#B0C8F0" align="center">
                      <%}else{%><tr bgcolor="#D8E4F8" align="center"> 
                      <%}%>
                       <td><%=artLists[i][0]%>&nbsp;</td>
                       <td><%=artLists[i][4]%>&nbsp;</td>
                       <td><%=artLists[i][5]%>&nbsp;</td>
                       <td><%=artLists[i][7]%>&nbsp;</td>
                       <td><%=artLists[i][12]%>&nbsp;</td>
                       <td><%if(artLists[i][21]==null){%>0<%}else{%><%=artLists[i][21]%><%}%>&nbsp;</td>
                       <%if(artLists[i][20]!=null){%>
                       <%if(artLists[i][20].trim().toUpperCase().equals("Y")){%>
                       <td><a href="EquipPaperDetail.jsp?art_ID=<%=artLists[i][0]%>" onClick="return launchRemote(this.href);"> 详细内容>></a></td>
                       <%}else{%>
                       <td><a href="EquipDetail.jsp?art_ID=<%=artLists[i][0]%>" onClick="return launchRemote(this.href);"> 详细内容>></a></td>
                       <%}%>
                       <%}else{%>
                       <td><a href="EquipDetail.jsp?art_ID=<%=artLists[i][0]%>" onClick="return launchRemote(this.href);"> 详细内容>></a></td>
                       <%}%>
                      </tr>
                      <%}
                      }
                      %>
                    </table>
                  </td>
                </tr>
                <tr align="right">
                <form method="post" name="toPage2" action="EquipList.jsp" onSubmit="return validateForm(toPage2);">
                <input type=hidden name="queryString" value="<%=queryString%>" >
                <input type=hidden name="queryString2" value="<%=queryString2%>" >
                <input type=hidden name="art_Type" value="<%=art_Type%>" >
                <input type=hidden name="type_ID" value="<%=type_ID%>" >
                  <td colspan="2">共<%=totalPage%>页， 第<%=pageNo%>页，到
                    <input type="text" name="pageNo" size="6">
                    页
                    <input type="submit" name="Submit2" value="go">
                    <%if((totalPage>1)&&(pageno<totalPage)){%><a href="EquipList.jsp?art_Type=<%=art_Type%>&type_ID=<%=type_ID%>&pageNo=<%=pageno+1%>&queryString=<%=queryString%>&queryString2=<%=queryString2%>">下一页</a><%}%></td>
                </form> 
                </tr>
                <tr>
                <td>&nbsp;</td>
                </tr>
              </table>
            </td>
        </tr>
       </table>
    </td>
  </tr>
</table>

<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="/images/dline.gif" border="0" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="/images/dipic.gif" border="0" width="80" height="24"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</body>
</html>

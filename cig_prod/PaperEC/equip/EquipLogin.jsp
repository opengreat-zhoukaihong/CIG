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
%>
<body bgcolor="#FFFFFF"><table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="159" height="394"> 
      <script language="JavaScript" src="/javascript/caidan.js">
      </script>
      <div style="position:absolute; width:141px; height:131px; z-index:1; left: 2px; top: 1px" id="scrollMenu"> 
        <table width="139" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td > 
              <table width="141" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#cccccc" bordercolor="#000000">
                <tr bgcolor="#574ED3"> 
                  <td width="142" height="22" class="white" align="center">专业设备</td>
                </tr>
                <tr bgcolor="#4078E0"> 
                  <td height="22" width="142" align="center"><a href="EquipLogin.jsp?queryString=<%=queryString%>&queryID=0&queryString2=<%=queryString2%>"><font color="#FFFFFF">浏览供应信息</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,0)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipLogin.jsp?queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=i%>"><b><%=lists[i][1]%></b></a></td>
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
                  <td height="22" width="142" align="center"><a href="EquipLogin.jsp?queryString=<%=queryString%>&queryID=1&queryString2=<%=queryString2%>"><font color="#FFFFFF">浏览需求信息</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,1)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipLogin.jsp?queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=count+i%>"><b><%=lists[i][1]%></b></a></td>
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
                  <td height="22" width="142" align="center"><a href="EquipLogin.jsp?queryString=<%=queryString%>&queryID=2&queryString2=<%=queryString2%>"><font color="#FFFFFF">发布供应信息</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,2)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipLogin.jsp?queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=2*count+i%>"><b><%=lists[i][1]%></b></a></td>
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
                  <td height="22" width="142" align="center"><a href="EquipLogin.jsp?queryString=<%=queryString%>&queryID=3&queryString2=<%=queryString2%>"><font color="#FFFFFF">发布需求信息</font></a></td>
                </tr>
                <%if(Equip_Cate.JudgeBit(queryString,3)){%>
                <%for(int i=0;i<count;i++){%>
                <tr bgcolor="#E8AE00"> 
                  <td height="22" width="142" align="center"><a href="EquipLogin.jsp?queryString=<%=queryString%>&queryString2=<%=queryString2%>&queryID2=<%=3*count+i%>"><b><%=lists[i][1]%></b></a></td>
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
    <td colspan="2" valign="top" height="394"> 
      <form method="post" action="">
        <table width="500" border="1" cellspacing="0" cellpadding="6" bordercolorlight="#000000" bordercolordark="#FFFFFF" align="center">
          <tr>
            <td>
              <table width="500" border="0" cellspacing="0" cellpadding="4" align="center" bgcolor="#E6EDFB">
                <tr align="center"> 
                  <td class="title"><b>关于专业设备</b></td>
                </tr>
                <tr> 
                  <td class="algin"> 栏目宗旨: 给业内人士提供一个传递设备信息，发挥设备增值创利效能的交流地带； <br>
                    栏目特色: 由浏览者自主浏览、发布设备供求信息，用户可查阅对方的基本情况并进<br>
                    行回复； 栏目服务对象: 企业或个人从事设备管理、调配和购销的工作者；<br>
                      <br>
                    <br>
                    本栏目信息资源主要来自用户，本站力求保证这些信息资源的真实程度。为了创造一<br>
                    个良好的交流环境，希望各用户遵循以下规定： 
                    <ol>
                      <li> 遵守国家互联网电子公告服务管理规定；</li>
                      <li> PaperEC.com有权保留或删除专业设备栏目中的任意内容；</li>
                      <li>用户发布的设备信息在本站的保留时间将不超过60天。 </li>
                    </ol>
                  </td>
                </tr>
              </table>
            </td>
        </tr>
       </table>
     </form>
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

<%@ page    language="java" %>
<%! String user_id; %>
 
<html>
<head>
<title>�ҵ�ֽ��--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none; color: #000000; font-family: "����"}
a:visited {  text-decoration: none; color: #000000; font-family: "����"}
a:active {  text-decoration: none; color: #000000; font-family: "����"}
a:hover {  color: #330099; text-decoration: underline; font-family: "����"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "����"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
<script language="JavaScript">
	
function confirmDelete(){

    return confirm("��ȷ���Ӹ����ղؼ��н���ɾ����?")

}
</SCRIPT>
<script language="JavaScript">
function openForeignX(url){   
        OpenWindow=window.open(url, "foreignXwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,resizable=no,menubar=no,width=142,height=230");
}

function openMeasConv(url){   
        OpenWindow=window.open(url, "measConvwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no,width=300,height=300");
}
</script>
</head>
<%@ page info="�ҵ�ֽ��--PaperEC.com"%> <%@ page import="java.util.*" %> <%@ page import="mypaperec.*" %> 
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> <jsp:useBean id="WatchList" scope="page" class="mypaperec.WatchList" /> 
<jsp:setProperty name="WatchList" property="userId"/> <jsp:setProperty name="WatchList" property="langCode" value="GB"/> 
<jsp:setProperty name="WatchList" property="action"/> <jsp:setProperty name="WatchList" property="measureFlag"/> 
<jsp:setProperty name="WatchList" property="postingId"/> <%  if (!UserInfo.getAuthorized()){
%> <jsp:forward page="notAuthorized.jsp" /> </jsp:forward> <%    }
%> <% 
        int watchListCount=0;
        String[][] watchList;
 
        WatchList.setUserId(UserInfo.getUserId());
	WatchList.setMeasureFlag(UserInfo.getMeasureFlag());
	
	WatchList.deleteWatchList();
	
	watchList = WatchList.getWatchList();
	watchListCount = WatchList.getWatchListCount();    
%> 
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr> 
    <td width="159"> 
      <script language="JavaScript" src="../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="postcenter/demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../images/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="postcenter/product_list.jsp" class="font9"><font color="#000000">��Ӧ����</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="postcenter/request2buy.jsp"><font color="#000000">���󷢲�</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="postcenter/order_search.jsp"><font color="#000000">�������</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="mycustomer.jsp"><font color="#000000">�ҵĿͻ�</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="postcenter/product_list.jsp"><font color="#000000">�ҵĲ�Ʒ</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">IDֱͨ��</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="����">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('foreignX.htm')"><font color="#FFFFFF">�����ʻ���</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="jiaoyifu.htm"><font color="#FFFFFF">���׷���</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('huansuanresult.jsp')"><font color="#FFFFFF">������λת��</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../images/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </td>
    <td valign="top"> 
      <form method="post" action="profile2.jsp">
        <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="165"> 
              <table width="600" border="0" cellspacing="2" cellpadding="4">
                <tr bgcolor="#4078E0"> 
                  <td colspan="6" height="25"><font color="#FFFFFF" class="big"><b>�����ղؼ�</b></font></td>
                </tr>
                <tr> 
                  <td class="dan10" bgcolor="#7EA2EB" align="center" width="105">������</td>
                  <td class="dan10" bgcolor="#7EA2EB" align="center" width="155">ժҪ</td>
                  <td class="dan10" bgcolor="#7EA2EB" align="center" width="135">����ʱ��</td>
                  <td class="dan10" bgcolor="#7EA2EB" align="center" width="62">����</td>
                  <td class="dan10" bgcolor="#7EA2EB" align="center" width="87">״̬</td>
                  <td class="dan10" bgcolor="#7EA2EB" align="center" width="87">&nbsp;</td>
                </tr>
                <% if (watchListCount==0){%> 
                <tr> 
                  <td colspan="6" align="center" bgcolor="#3F78DD" height="22"><font color="#FFFFFF" class="white10">�����ղؼ�����ʱû����Ϣ��</font></td>
                </tr>
                <% }else{ 
                    for (int i=0;i<watchListCount;i++){
              %> 
                <tr> 
                  <td bgcolor="#E6EDFB" align="center" width="105"><a href="postcenter/demand_info.jsp?posting_id=<%=watchList[i][0]%>" class="dan10"><%=watchList[i][0]%></a></td>
                  <td class="dan10" bgcolor="#E6EDFB" align="center" width="155"><%=watchList[i][1]%></td>
                  <td class="dan10" bgcolor="#E6EDFB" align="center" width="135"><%=watchList[i][2]%></td>
                  <td class="dan10" bgcolor="#E6EDFB" align="center" width="62"><%=watchList[i][3]%></td>
                  <td class="dan10" bgcolor="#E6EDFB" align="center" width="87"><%=watchList[i][4]%></td>
                  <td class="dan10" bgcolor="#E6EDFB" align="center" width="87"><a href="mywatchlist.jsp?user_id=<%=UserInfo.getUserId()%>&action=1&postingId=<%=watchList[i][0]%>" ONCLICK="return confirmDelete()"><font color="#3333FF">ɾ�� 
                    </font></a> </td>
                </tr>
                <%    }
                 } 
	      %> 
                <tr bgcolor="#E6EDFB"> 
                  <td align="center" height="25" colspan="6" class="dan10"> 
                    <input type="hidden" name="langCode" value="GB">
                    <input type="submit" name="Submit2" value="����" onClick="javascript:window.history.go(-1)">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </form> </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
</jsp:useBean>
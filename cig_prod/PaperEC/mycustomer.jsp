<%@ page language="java"  %>
<jsp:useBean id="sendM1" scope="page" class="mypaperec.SendCustom" />
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" /> 

<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>

<%  String lang_code="GB";
    String user_id=UserInfo.getUserId();     %>
<jsp:setProperty name="sendM1" property="lang_code" value="<%=lang_code%>" />
<jsp:setProperty name="sendM1" property="user_id" value="<%=user_id%>" />
<%  String comp[][]=sendM1.getCompany();  %>

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
</head>
<script language="JavaScript">
function openForeignX(url){   
        OpenWindow=window.open(url, "foreignXwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,resizable=no,menubar=no,width=142,height=230");
}

function openMeasConv(url){   
        OpenWindow=window.open(url, "measConvwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no,width=300,height=300");
}
</script>
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
      <form method="post" action="custosucc.jsp">
        <table width="400" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td height="145"> 
              <table width="400" border="0" cellspacing="2" cellpadding="4">
                <tr> 
                  <td colspan="2" height="25" bgcolor="#4078E0"><font color="#FFFFFF"><b>�ҵĿͻ�</b></font></td>
                </tr>
                <%     String str=""; int j=comp.length;   %>
                <%    if(j==0){   %>
                <tr> 
                  <td colspan="2" height="22" class="dan10">
                   ���������Ϊ������֪ͨ�����Ͽͻ���׼���ġ�Ŀǰ����û���ڱ����Ϻͱ�Ļ�Ա��ɽ��ף�
                   ������û�������Ͽͻ���������˴��������޷�Ϊ������
                  </td> 
                </tr>
                <tr>
                <td height="25"> 
                  <input type="button" name="Submit2" value="�� ��" onclick="winback();">
                 </td>                     
                </tr>
                
                <%    }else{           %>
                 
                <%         
                  for(int i=0;i<j;i++){
                      if (comp[i][1] == null) comp[i][1] = " ";
                      if (comp[i][2] == null) comp[i][2] = " ";
                      str="check"+i;                   %> 
                <tr> 
                  <td width="94" height="22" class="dan10" align="center" bgcolor="#E6EDFB"> 
                    <input type="checkbox" name="<%=str%>" value="<%=comp[i][2]%>">
                  </td>
                  <td width="302" height="22" class="dan10" bgcolor="#E6EDFB"><%=comp[i][1]%></td>
                </tr>
                <%   }    %> 
                <tr>                  
                  <td colspan="2" height="22" class="dan10">�����뷢���� 
                    <input type="hidden" name="length" value="<%=j%>">
                    <input type="text" name="posting_id" size="10">
                    <input type="submit" name="Submit2" value="����">
                  </td>                 
                </tr>
               <%   }    %> 
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
            2000 PaperEC.com Inc. All Rights Reserved</font></td>
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
<script language="javascript">
    function winback(){
        window.history.back();
               }
 </script>       
<% sendM1.getDestroy();  %>
</jsp:useBean>
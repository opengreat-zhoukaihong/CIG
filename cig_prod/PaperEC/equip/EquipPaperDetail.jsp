<html>
<%@ page import="java.util.*, java.net.*" %>
<head>
<title>PAPEREC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.white {  font-family: "����"; font-size: 10pt; color: #FFFFFF}
a:link {  font-family: "����"; text-decoration: none}
a:visited {  font-family: "����"; text-decoration: none}
a:active {  font-family: "����"; text-decoration: none}
a:hover {  font-family: "����"; text-decoration: underline}
td {  font-family: "����"; font-size: 10pt}
.black {  font-family: "����"; color: #000000}
.algin {  font-family: "����"; font-size: 10pt; text-align: justify; line-height: 18pt}
.title {  font-family: "����"; font-size: 14px; font-weight: 400}
-->
</style>
<script language="JavaScript">
<!--
var onTop = false
function launchRemote(url) {
	var newwinn=open(url, "pp", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=666,height=502');
	newwinn.focus();
        return false;
}
//-->
</script>
</head>
<%
    Hashtable pHash =new Hashtable();
    String art_ID=request.getParameter("art_ID");
    pHash.put("art_ID",art_ID);
    pHash.put("langCode",new String("GB"));
    pHash.put("paperFlag",new String("Y"));
%>
<jsp:useBean id="Equip_Art" scope="page" class="com.paperec.equip.Equip_Art" />
<%
     Equip_Art.setParameteres(pHash);
     String[] detail;
    
     detail = Equip_Art.getDetail();
%> 
<body bgcolor="#FFFFFF" topmargin="0" marginwidth="0">
<table width="500" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  <tr>
    <td>
      <table width="500" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
        <tr>
          <td class="title"><b><%if(detail[1].trim().toUpperCase().equals("S")){%>��Ӧ<%}else{%>����<%}%>��Ϣ�������</b></td>
        </tr>
        <tr>
          <td>
            <hr>
          </td>
        </tr>
        <tr>
          <td height="144"> 
          
           <table width="500" border="0" cellspacing="1" cellpadding="4">
              <tr> 
                <td colspan="4" bgcolor="#4078E0"><font color="#FFFFFF"><span class="title"><b><%=detail[23]%><%=detail[0]%></b></span>(<%=detail[24]%>,�������Ϊ<%if(detail[21]==null){%>0<%}else{%><%=detail[21]%><%}%>�Σ�</font></td>
              </tr>
              <tr bgcolor="#B0C8F0"> 
                <td bgcolor="#B0C8F0" width="126"><b>�������ƣ�</b></td>
                <td width="95"><%=detail[4]%>&nbsp;</td>
                <td width="131"><b>�ͺŹ��</b></td>
                <td width="107"><%=detail[7]%>&nbsp;</td>
              </tr>
              <%if(detail[1].trim().toUpperCase().equals("S")){%> 
              <tr bgcolor="#D8E4F8"> 
                <td width="126"><b>�������̣�</b></td>
                <td width="95"><%=detail[5]%>&nbsp;</td>
                <td width="131"><b>�������ڣ�</b></td>
                <td width="107"><%=detail[6]%>&nbsp;</td>
              </tr>
              <tr bgcolor="#B0C8F0"> 
                <td bgcolor="#B0C8F0" width="126"><b>�������ڹ���</b></td>
                <td width="95"><%=detail[8]%>&nbsp;</td>
                <td width="131"><b>������������</b></td>
                <td width="107"><%=detail[30]%>&nbsp;</td>
              </tr>
              <tr bgcolor="#D8E4F8"> 
                <td width="126"><b>���������ڣ�</b></td>
                <td width="95"><%=detail[29]%>&nbsp;</td>
                <td width="131"><b>����Ŀǰ״̬��</b></td>
                <td width="100"><%=detail[25]%>&nbsp;</td>
              </tr>
              <%}%>
              <tr bgcolor="#B0C8F0"> 
                <td bgcolor="#B0C8F0" width="126"><b>����</b></td>
                <td width="95"><%=detail[26]%>&nbsp;</td>
                <td width="131"><b>�������٣�</b></td>
                <td width="107"><%=detail[27]%>&nbsp;</td>
              </tr>
              <tr bgcolor="#D8E4F8"> 
                <td width="126"><b>��ֽ������g/m2����</b></td>
                <td width="95"><%=detail[28]%>&nbsp;</td>
                <td width="131"><b>��Ϣ��Ч�ڣ��죩��</b></td>
                <td width="107"><%=detail[12]%>&nbsp;</td>
              </tr>
              <tr bgcolor="#B0C8F0"> 
                <td width="126"><b>��ע˵����</b></td>
                <td colspan="3"><%=detail[10]%>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <hr>
          </td>
        </tr>
        <tr>
          <td>��<a href="EquipRevert.jsp?art_ID=<%=detail[0]%>&art_Type=<%=detail[1]%>&type_ID=<%=detail[3]%>&artName=<%=URLEncoder.encode(detail[4])%>&manufactory=<%=URLEncoder.encode(detail[5])%>&manuf_Date=<%=URLEncoder.encode(detail[6])%>&spec=<%=URLEncoder.encode(detail[7])%>&machine_Loca=<%=URLEncoder.encode(detail[8])%>&machine_Status=<%=URLEncoder.encode(detail[9])%>&price=<%=URLEncoder.encode(detail[11])%>&vali_Date=<%=detail[12]%>&comp_name=<%=detail[13]%>&paper_Flag=<%=detail[20]%>&status=<%=URLEncoder.encode(detail[22])%>" onClick="return launchRemote(this.href);">�ظ�</a>����<a href="javascript:window.close();">�رշ���</a>��</td>
        </tr>
        <tr>
          <td>
            <hr>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

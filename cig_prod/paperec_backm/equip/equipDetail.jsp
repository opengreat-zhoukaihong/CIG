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
	var remot=open(url, "pp", 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=666,height=502');
	remot.focus();
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
    pHash.put("bst",new String("Y"));
%>
<jsp:useBean id="Equip_Art" scope="page" class="com.paperec.equip.Equip_Art" />
<%
     Equip_Art.setParameteres(pHash);
     String[] detail;
    
     detail = Equip_Art.getDetail();
%>
<jsp:useBean id="Parameter" scope="page" class="com.paperec.Parameter" />
<%
pHash.put("pageFlag",new String("N"));
pHash.put("id",new String("21"));
Parameter.setParameteres(pHash);
    String[][] plists;
    int pcount=0;
    plists = Parameter.getList();
    pcount = Parameter.getCount();
%>  
<body bgcolor="#FFFFFF" topmargin="0" marginwidth="0">
<table width="500" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  <tr>
    <td>
      <table width="500" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
        <tr>
          <td class="title"><b><%if(detail[1].trim().toUpperCase().equals("S")){%>��Ӧ<%}else{%>����<%}%><%if(!(detail[2].trim().equals("0"))){%>�ظ�<%}%>��Ϣ�������</b></td>
        </tr>
        <tr>
          <td>
            <hr>
          </td>
        </tr>
        <tr>
          <td height="144">
            <table width="500" border="0" cellspacing="1" cellpadding="4">
            <form method="POST" name="equipMap" action="equipUpdatePost.jsp" onSubmit="return validateForm(equipMap);">
            <input type=hidden name="art_ID" value="<%=art_ID%>" >
            <input type=hidden name="art_Type" value="<%=detail[1]%>" >
              <tr> 
                <td colspan="4" bgcolor="#4078E0"><font color="#FFFFFF"><span class="title"><b><%=detail[23]%><%=detail[0]%></b></span>(<%=detail[24]%>,�������Ϊ<%if(detail[21]==null){%>0<%}else{%><%=detail[21]%><%}%>�Σ�</font></td>
              </tr>
              <tr bgcolor="#B0C8F0"> 
                <td bgcolor="#B0C8F0" width="101"><b>�豸���ƣ�</b></td>
                <td width="100"><input type="text" name="artName" size="20" value="<%=detail[4]%>" ></td>
                <td width="128" bgcolor="#B0C8F0"><b>�ͺŹ��</b></td>
                <td width="130"><input type="text" name="spec" size="20" value="<%=detail[7]%>" ></td>
              </tr>
              <tr bgcolor="#D8E4F8">
              <%if(detail[1].trim().toUpperCase().equals("S")){%> 
                <td bgcolor="#D8E4F8" width="101"><b>�������̣�</b></td>
                <td width="100" bgcolor="#D8E4F8"><input type="text" name="manufactory" size="20" value="<%=detail[5]%>" ></td>
                <td width="128"><b>�������ڣ�</b></td>
                <td width="130" bgcolor="#D8E4F8"><input type="text" name="manuf_Date" size="20" value="<%=detail[6]%>" ></td>
              </tr>
              <tr bgcolor="#B0C8F0"> 
                <td bgcolor="#B0C8F0" width="101"><b>�豸���ڵأ�</b></td>
                <td colspan="3" bgcolor="#B0C8F0"><input type="text" name="machine_Loca" size="20" value="<%=detail[8]%>" ></td>
              </tr>
              <tr bgcolor="#D8E4F8"> 
                <td width="101"><b>�豸Ŀǰ״̬��</b></td>
                <td width="100"><select size="1" name="machine_Status">
                  <%for(int i=0;i<pcount;i++){%>
                  <option value="<%=plists[i][0]%>" <%if(detail[9].trim().toUpperCase().equals(plists[i][0].trim().toUpperCase())){%>selected<%}%>><%=plists[i][1]%></option>
                  <%}%>
                  </select></td>
                <%}%>
                <td width="128"><b>��Ϣ��Ч�ڣ��죩��</b></td>
                <td width="130"><input type="text" name="vali_Date" size="20" value="<%=detail[12]%>" ></td>
              </tr>
              
               <tr  bgcolor="#B0C8F0"> 
                 <td colspan="4" height="35"><b><%if(!(detail[2].trim().equals("0"))){%>�ظ���<%}%>��ϵ��Ϣ</b></td>
               </tr>
               <tr bgcolor="#D8E4F8"> 
               <td width="123"><font color="#990033">��˾���ƣ�</font></td>
                 <td> 
                   <input type="text" name="comp_name" value="<%=detail[13]%>">
                  </td>
                  <td width="123"><font color="#990033">IP</font></td>
                  <td width="123"><font color="#990033"><%=detail[28]%>&nbsp;</font></td>
               </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="123"><font color="#990033">��ϵ�ˣ�</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Name" value="<%=detail[14]%>">
                        </td>
                        <td width="94"><font color="#990033">��ϵ�绰��</font></td>
                        <td width="188"> 
                          <input type="text" name="cont_tel" value="<%=detail[15]%>">
                        </td>
                      </tr>
                      <tr bgcolor="#D8E4F8"> 
                        <td width="123"><font color="#990033">��ϵ��ַ��</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Address" value="<%=detail[16]%>">
                        </td>
                        <td width="94">���棺</td>
                        <td width="188"> 
                          <input type="text" name="cont_Fax" value="<%=detail[17]%>">
                        </td>
                      </tr>
                      <tr bgcolor="#B0C8F0"> 
                        <td width="123"><font color="#990033">�ʱࣺ</font></td>
                        <td width="154"> 
                          <input type="text" name="cont_Postcode" value="<%=detail[18]%>">
                        </td>
                        <td width="94">Email��</td>
                        <td width="188"> 
                          <input type="text" name="cont_Email" value="<%=detail[19]%>">
                        </td>
                      </tr>
               <tr bgcolor="#B0C8F0"> 
                <td width="101"><b>��ע˵����</b></td>
                <td colspan="3"><textarea name="content" rows="7"><%=detail[10]%></textarea></td>
               </tr>
               <tr>
                <td>
                <div align="center"><input type="submit" value="�����޸��ύ" name="changSub"></div>
               </td>
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
          <td>��<a href="mailto:<%=detail[19]%>">email <%=detail[14]%></a>��<%if(!(detail[2].trim().equals("0"))){%>��<a href="mailto:<%=detail[27]%>">email ԭ����:<%=detail[26]%></a>��<%}%>��<a href="javascript:window.close();">�رշ���</a>��</td>
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

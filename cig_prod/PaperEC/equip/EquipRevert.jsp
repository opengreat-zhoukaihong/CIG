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
</head>
<script language="JavaScript">
<!--
function validateForm(e){
	if(e.cont_Name.value==''){
	  alert('����������������Ȼ���ύ!')
	  e.cont_Name.focus()
	return false;
	}

	if(e.cont_tel.value==''){
	alert('������绰��Ȼ���ύ!')
	e.cont_tel.focus()
	return false;
	}
	if(e.cont_Email.value==''){
	alert('������������䣬Ȼ���ύ!')
	e.cont_Email.focus()
	return false;
	}
      if(e.cont_Email.value.indexOf("@")<1 ){
         alert("�ʼ���ַ��������֤����������!")
         e.cont_Email.focus()
         return false;
    }	
}
//-->
</script>
<%
    String art_ID=request.getParameter("art_ID");
    String art_Type=request.getParameter("art_Type");
    String type_ID=request.getParameter("type_ID");
    String artName=request.getParameter("artName");
    String manufactory=request.getParameter("manufactory");
    String manuf_Date=request.getParameter("manuf_Date");
    String spec=request.getParameter("spec");
    String machine_Loca=request.getParameter("machine_Loca");
    String machine_Status=request.getParameter("machine_Status");
    String price=request.getParameter("price");
    String vali_Date=request.getParameter("vali_Date");
    String comp_name=request.getParameter("comp_name");
    String paper_Flag=request.getParameter("paper_Flag");
    String status=request.getParameter("status");
%>
<body bgcolor="#FFFFFF" topmargin="0" marginwidth="0">
<form name="RevertForm" method="post" action="RevestPost.jsp" onSubmit="return validateForm(RevertForm);">
<input type=hidden name="art_ID" value="<%=art_ID%>" >
<input type=hidden name="art_Type" value="<%=art_Type%>" >
<input type=hidden name="type_ID" value="<%=type_ID%>" >
<input type=hidden name="artName" value="<%=artName%>" >
<input type=hidden name="manufactory" value="<%=manufactory%>" >
<input type=hidden name="manuf_Date" value="<%=manuf_Date%>" >
<input type=hidden name="spec" value="<%=spec%>" >
<input type=hidden name="machine_Loca" value="<%=machine_Loca%>" >
<input type=hidden name="machine_Status" value="<%=machine_Status%>" >
<input type=hidden name="price" value="<%=price%>" >
<input type=hidden name="vali_Date" value="<%=vali_Date%>" >
<input type=hidden name="comp_name" value="<%=comp_name%>" >
<input type=hidden name="paper_Flag" value="<%=paper_Flag%>" >
<input type=hidden name="status" value="<%=status%>" >
  <table width="600" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#000000" bordercolordark="#FFFFFF">
    <tr> 
      <td> 
        <table width="600" border="0" cellspacing="0" cellpadding="4" bgcolor="#E6EDFB">
          <tr align="center"> 
            <td class="title"><b>�ظ���Ϣ����</b></td>
          </tr>
          <tr> 
            <td> 
              <hr>
            </td>
          </tr>
          <tr> 
            <td height="144"> 
              <table width="600" border="0" cellspacing="1" cellpadding="4">
                <tr bgcolor="#B0C8F0"> 
                  <td bgcolor="#B0C8F0" width="140"><b><font color="#990033">����������</font></b></td>
                  <td width="154"> 
                    <input type="text" name="cont_Name">
                  </td>
                  <td width="120"><b> ��Ϣ��ţ�</b></td>
                  <td width="154"> 
                    <input type="text" value="<%=art_ID%>" disabled >
                  </td>
                </tr>
                <tr bgcolor="#D8E4F8"> 
                  <td bgcolor="#D8E4F8" width="140"><b><font color="#990033">����Email���䣺</font></b></td>
                  <td width="154"> 
                    <input type="text" name="cont_Email">
                  </td>
                  <td width="120"><b> <font color="#990033">���ĵ绰��</font></b></td>
                  <td width="154"> 
                    <input type="text" name="cont_tel">
                  </td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td bgcolor="#B0C8F0" width="140"><b>������ϵ��ַ��</b></td>
                  <td colspan="3" bgcolor="#B0C8F0"> 
                    <input type="text" name="cont_Address" size="30">
                  </td>
                </tr>
                <tr bgcolor="#D8E4F8"> 
                  <td width="140"><b>�����ʱࣺ</b></td>
                  <td colspan="3"> 
                    <input type="text" name="cont_Postcode" size="30">
                  </td>
                </tr>
                <tr bgcolor="#B0C8F0"> 
                  <td width="140"><b>�ظ����ݣ�</b> <br>
                    ����Ҫ����500�֣� </td>
                  <td colspan="3"> 
                    <textarea name="content" rows="10"></textarea>
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
            <td> 
              <input type="submit" name="Submit" value="����">
              <input type="reset" value="ȡ��"   name="button">
            </td>
          </tr>
          <tr> 
            <td height="2"> 
              <hr>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>


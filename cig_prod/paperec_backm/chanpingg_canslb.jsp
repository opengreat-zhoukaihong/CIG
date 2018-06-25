<html><!-- #BeginTemplate "/Templates/backm_paperec.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>�й�ֽ����̨����ϵͳ</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "����"; font-size: 9pt}
.title12 {  font-family: "����"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "����"; text-decoration: underline}
a:visited {  font-family: "����"; text-decoration: underline}
a:active {  font-family: "����"; text-decoration: underline}
a:hover {  font-family: "����"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>

<%@ page import="java.util.*" %>
<%@ page import="system.*" %> 

<jsp:useBean id="UserInfo" scope="session" class="system.UserInfo" /> 

<%
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="login.htm" />
	</jsp:forward>
<% }%>

<jsp:useBean id="permTest" scope="page" class="com.paperec.bst.permission.Permission" />
<jsp:setProperty name="permTest" property="dbpoolName" value="paperec"/>
<%
  boolean isPermitted;
  String userID;
  String funcId;

  funcId = "fnCateMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=�Բ���, ��û��Ȩ��ʹ�øù���! " />
<%}%>


<%@ page import="java.util.*" %>
<%@ page import="product.*" %>
<jsp:useBean id="Category" scope="page" class="product.Category" /> 
<jsp:setProperty name="Category" property="langCode" value="GB"/>
<jsp:setProperty name="Category" property="cateId"/>


<jsp:useBean id="SpecParaList" scope="page" class="product.SpecParaList" /> 
<jsp:setProperty name="SpecParaList" property="cateId"/>
<jsp:setProperty name="SpecParaList" property="specId"/>

<jsp:useBean id="SpecBase" scope="page" class="product.SpecBase" /> 

<jsp:useBean id="SpecBaseHelper" scope="page" class="product.SpecBaseHelper" /> 
<jsp:setProperty name="SpecBaseHelper" property="specId"/>
<jsp:setProperty name="SpecBaseHelper" property="langCode" value="GB"/>


<jsp:useBean id="SpecPara" scope="page" class="product.SpecPara" /> 
<jsp:setProperty name="SpecPara" property="cateId"/>
<jsp:setProperty name="SpecPara" property="specId"/>
<jsp:setProperty name="SpecPara" property="action"/>
<jsp:setProperty name="SpecPara" property="editStrI"/>
<jsp:setProperty name="SpecPara" property="editStrM"/>
<jsp:setProperty name="SpecPara" property="langCode"/>
<jsp:setProperty name="SpecPara" property="paraId"/>

<%
   String cate_id = request.getParameter("cateId");
   String spec_id = request.getParameter("specId");
   String cate_name = Category.getCategoryName();
   String spec_name = SpecBaseHelper.getSpecBase().specName;
   
   SpecPara.initSpecPara();
   
   SpecParaList.retriveSpecParaList();
   int specParaCount = SpecParaList.getSpecParaCount();
   String[][] specParaList = SpecParaList.getSpecParaList();
%>


<SCRIPT LANGUAGE="Javascript">
        
    function addSubmit(){  
        var mf=document.specParaForm;
	mf.action.value = "add";
        
      	mf.submit();


     }
     
    function confirmDelete(){

          return confirm("��ȷ��ɾ���˹�������?")

    }
</SCRIPT>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>
      <form name="specParaForm" method="post" action="chanpingg_canslb.jsp">
      <input type="HIDDEN" name="cateId" value=<%=cate_id%>>
      <input type="HIDDEN" name="specId" value=<%=spec_id%>>
      <input type="HIDDEN" name="action">

        <table width="600" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="6" class="title12">��Ʒ�������б�</td>
          </tr>
          <tr> 
            <td colspan="6"><%=cate_id%>: <%=cate_name%>  <%=spec_id%>: <%=spec_name%></td>
          </tr>
          <tr align="center"> 
            <td><b>����ID</b></td>
            <td><b>���Դ���</b></td>
            <td><b>����ѡ��</b></td>
            <td><b>Ӣ��ѡ��</b></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <%
               for (int i=0;i<specParaCount;i++){
          %>
          <tr align="center"> 
            <td><%=specParaList[i][0]%></td>
            <td><%=specParaList[i][1]%></td>
            <td><%=specParaList[i][2]%></td>
            <td><%=specParaList[i][3]%></td>
            <td><a href="chanpingg_cansbj.jsp?cateId=<%=cate_id%>&specId=<%=spec_id%>&paraId=<%=specParaList[i][0]%>&langCode=<%=specParaList[i][1]%>">�༭</a></td>
            <td><a href="chanpingg_canslb.jsp?cateId=<%=cate_id%>&specId=<%=spec_id%>&action=delete&paraId=<%=specParaList[i][0]%>" onClick="return confirmDelete()">ɾ��</a></td>
          </tr>
          <%   }%>
          <tr align="center"> 
            <td colspan="6">���Դ��룺 
              <select name="langCode">
              <option value=GB selected> ���� </option>
              <option value=EN> Ӣ�� </option>
              </select>
              ����ѡ�
	      <input type="text" name="editStrM" size="8">
              Ӣ��ѡ�
	      <input type="text" name="editStrI" size="8">
              <a href="#" onClick="javascript:addSubmit()"><input type="image" border="0" name="imageField" src="../images/add.gif" width="68" height="26"></a>
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

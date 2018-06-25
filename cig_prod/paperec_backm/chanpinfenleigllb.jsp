<%--  @# chanpinfenleigllb.jsp Ver.1.2 --%>

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
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>

<%@ page import="postcenter.*" %>
<jsp:useBean id="ChanpinfenleigllbPage" scope="page" class="backpage.ChanpinfenleigllbPage" />
<jsp:setProperty name="ChanpinfenleigllbPage" property="langCode" value="GB" />
<jsp:setProperty name="ChanpinfenleigllbPage" property="action" />
<jsp:setProperty name="ChanpinfenleigllbPage" property="cateId" />
<jsp:setProperty name="ChanpinfenleigllbPage" property="gradeId" />
<jsp:setProperty name="ChanpinfenleigllbPage" property="toGradeId" />
<jsp:setProperty name="ChanpinfenleigllbPage" property="relaDire" />
<jsp:setProperty name="ChanpinfenleigllbPage" property="gradeC" />
<jsp:setProperty name="ChanpinfenleigllbPage" property="gradeE" />
<%
    boolean b = ChanpinfenleigllbPage.process();
    String errMsg1 = ChanpinfenleigllbPage.errMsg;
    String[][] mapRelaItems = ChanpinfenleigllbPage.getMapRelaItems();
    String[][] gradeItemsC = ChanpinfenleigllbPage.getGradeItems("C");
    String[][] gradeItemsE = ChanpinfenleigllbPage.getGradeItems("E");
    String[][] cateItemsC = ChanpinfenleigllbPage.getCateItems("C");
    String[][] cateItemsE = ChanpinfenleigllbPage.getCateItems("E");
%>
<%
    String  gradeArrayC = "";
    String  gradeArrayE = "";
    
    gradeArrayC += "[";
    for(int i=0; i<gradeItemsC.length; i++) 
    {
    	String gradeRecArray = "["; 
	
	gradeRecArray += "'" + gradeItemsC[i][0] + "'";
	gradeRecArray += ",'" + gradeItemsC[i][1] + "'";
	gradeRecArray += ",'" + gradeItemsC[i][2] + "']";

	if (i !=0) {
	    gradeArrayC +=",";
	}
	gradeArrayC += gradeRecArray;
    }
    gradeArrayC += "]";
    
    gradeArrayE += "[";
    for(int i=0; i<gradeItemsE.length; i++) 
    {
    	String gradeRecArray = "["; 
	
	gradeRecArray += "'" + gradeItemsE[i][0] + "'";
	gradeRecArray += ",'" + gradeItemsE[i][1] + "'";
	gradeRecArray += ",'" + gradeItemsE[i][2] + "']";

	if (i !=0) {
	    gradeArrayE +=",";
	}
	gradeArrayE += gradeRecArray;
    }
    gradeArrayE += "]";    
%>

<!-- ================ Functons for Building the Tree List  ==================== -->
<script language="JavaScript">
	gradeArrayC=<%=gradeArrayC%>;
	gradeArrayE=<%=gradeArrayE%>;
</script>

<script language=javascript > 
function recreateList(list, array, key) {
	var cnt=0;

	list.length=cnt;
	for (var i=0;i<array.length;i++) {
	    if (array[i][2]==key) {
		list.length=cnt+1;
		list.options[cnt].text = array[i][1];
		list.options[cnt].value = array[i][0];
		cnt++;
	    }
	}
}
</script>


<html><!-- #BeginTemplate "/Templates/backm_paperec.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>中国纸网后台管理系统</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "宋体"; font-size: 9pt}
.title12 {  font-family: "宋体"; font-size: 12pt; color: #000099; font-weight: bold}
a:link {  font-family: "宋体"; text-decoration: underline}
a:visited {  font-family: "宋体"; text-decoration: underline}
a:active {  font-family: "宋体"; text-decoration: underline}
a:hover {  font-family: "宋体"; color: #FFCC66; text-decoration: none}
-->
</style>
</head>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<span class="dan10"></span> <span class="dan9"></span> <span class="title12"></span> 
<span class="title12"></span> 
<table width="675" border="0" cellspacing="0" cellpadding="0" height="257">
  <tr valign="top"> 
    <td><!-- #BeginEditable "body" --><br>
      <br>
      <form name="formMapRela" method="post" action="chanpinfenleigllb.jsp">
      <input type="hidden" name="action" value="insert">
        <table width="650" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="9" class="title12">产品分类关联列表：</td>
          </tr>
          <tr align="center"> 
            <td width="62"><b>大类ID</b></td>
            <td width="62"><b>大类名称</b></td>
            <td width="62"><b>中类ID</b></td>
            <td width="62"><b>中类名称</b></td>
            <td width="62"><b>小类ID</b></td>
            <td width="62"><b>小类名称</b></td>
            <td width="71"><b>相关小类ID</b></td>
            <td width="82"><b>相关小类名称</b></td>
            <td width="33">&nbsp;</td>
          </tr>
	<% for (int i=0; i<mapRelaItems.length; i++) {%>
          <tr align="center"> 
            <td width="62">&nbsp;<%=mapRelaItems[i][0]%></td>
            <td width="62">&nbsp;<%=mapRelaItems[i][1]%></td>
            <td width="62">&nbsp;<%=mapRelaItems[i][2]%></td>
            <td width="62">&nbsp;<%=mapRelaItems[i][3]%></td>
            <td width="62">&nbsp;<%=mapRelaItems[i][4]%></td>
            <td width="62">&nbsp;<%=mapRelaItems[i][5]%></td>
            <td width="71">&nbsp;<%=mapRelaItems[i][6]%></td>
            <td width="82">&nbsp;<%=mapRelaItems[i][7]%></td>
            <td width="33"><a href="chanpinfenleigllb.jsp?gradeId=<%=mapRelaItems[i][4]%>&toGradeId=<%=mapRelaItems[i][6]%>&action=delete&cateId=<%=mapRelaItems[i][0]%>" onClick="return confirm('确实要删除此关联项吗?')">删除</a></td>
          </tr>
        <% } %>
          <tr> 
            <td colspan="9">关联方向： 
              <input type="radio" name="relaDire" value="CE" checked>
              国内分类->国外分类 
              <input type="radio" name="relaDire" value="EC">
              国外分类->国内分类</td>
          </tr>
          <tr> 
            <td colspan="4">国内分类大类名称： 
              <select name="categoryC" onChange="recreateList(this.form.gradeC, gradeArrayC, this.options[this.selectedIndex].value)">
	<% for (int i=0; i<cateItemsC.length; i++) {%>
		<option value="<%=cateItemsC[i][0]%>"><%=cateItemsC[i][1]%></option>
        <% } %>
              </select>
            </td>
            <td colspan="5">国外分类大类名称： 
              <select name="categoryE" onChange="recreateList(this.form.gradeE, gradeArrayE, this.options[this.selectedIndex].value)">
	<% for (int i=0; i<cateItemsE.length; i++) {%>
		<option value="<%=cateItemsE[i][0]%>"><%=cateItemsE[i][1]%></option>
        <% } %>
              </select>
            </td>
          </tr>
          <tr> 
            <td colspan="4">国内分类小类名称： 
              <select name="gradeC">
		<option value="">--N/A--</option>
              </select>
            </td>
            <td colspan="5">国外分类小类名称： 
              <select name="gradeE">
		<option value="">--N/A--</option>
              </select>
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="9"> 
              <input type="image" border="0" name="imageField" src="images/add.gif" width="68" height="26">
            </td>
          </tr>
        </table>
        <br>
        <br>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

<!-- ============== End of Init ================== -->		
<script language="JavaScript"> 
recreateList(formMapRela.gradeC, gradeArrayC, formMapRela.categoryC.options[formMapRela.categoryC.selectedIndex].value);
recreateList(formMapRela.gradeE, gradeArrayE, formMapRela.categoryE.options[formMapRela.categoryE.selectedIndex].value);
</script>
<!-- ============== End of Init ================== -->		

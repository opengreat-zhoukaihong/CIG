<%--  @# chanpindl_ggedit.jsp Ver.1.4 --%>

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

<%@ page import="postcenter.*, product.*" %>
<jsp:useBean id="ChanpindlggEditPage" scope="page" class="backpage.ChanpindlggEditPage" />
<jsp:setProperty name="ChanpindlggEditPage" property="action" />
<jsp:setProperty name="ChanpindlggEditPage" property="cateId" />
<jsp:setProperty name="ChanpindlggEditPage" property="specId" />
<jsp:setProperty name="ChanpindlggEditPage" property="valueFlag" value="Y"/>
<jsp:setProperty name="ChanpindlggEditPage" property="required" value="N"/>
<jsp:setProperty name="ChanpindlggEditPage" property="measFlag" value="M"/>
<%
    ChanpindlggEditPage.process();
    String[] unitItemsM = ChanpindlggEditPage.getUnitItems("M");
    String[] unitItemsI = ChanpindlggEditPage.getUnitItems("I");
%>


<jsp:useBean id="SpecBaseList" scope="page" class="product.SpecBaseList" />
<jsp:setProperty name="SpecBaseList" property="langCode" value="GB" />
<% 
    SpecBase[] specBaseItems = SpecBaseList.getSpecBaseItemsSorted();
%>

<html>
<!-- #BeginTemplate "/Templates/backm_paperec.dwt" --> 
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
<table border="0" cellspacing="0" cellpadding="0" width="675">
  <tr> 
    <td height="257" valign="top"><!-- #BeginEditable "body" -->
      <form name="form1" method="post" action="chanpindl_gglb.jsp">
      <input type="HIDDEN" name="action" value="<%=ChanpindlggEditPage.getAction()%>"> 
      <input type="HIDDEN" name="cateId" value="<%=ChanpindlggEditPage.getCateId()%>"> 
        <br>
        <table width="550" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#4078e0" bordercolordark="#FFFFFF">
          <tr> 
            <td colspan="3" class="title12">产品大类规格编辑：</td>
          </tr>
          <tr> 
            <td colspan="3">规格名称： 
              <select name="specId">
<% for (int i=0; i<specBaseItems.length; i++) { %>
		<option value=<%=specBaseItems[i].specId%> <%if(ChanpindlggEditPage.getSpecId().equals(specBaseItems[i].specId)){%> selected <%}%>> <%=specBaseItems[i].specName%> </option>
<% } %>
              </select>
            </td>
          </tr>
          <tr> 
            <td colspan="3">是否由参数列表中选择 ： 
              <input type="radio" name="valueFlag" value="N" <%if(ChanpindlggEditPage.getValueFlag().equals("N")){%>checked<%}%>> 是
              <input type="radio" name="valueFlag" value="Y" <%if(!ChanpindlggEditPage.getValueFlag().equals("N")){%>checked<%}%>> 否
            </td>
          </tr>
          <tr> 
            <td colspan="3">是否为主要规格： 
              <input type="radio" name="required" value="Y"  <%if(ChanpindlggEditPage.getRequired().equals("Y")){%>checked<%}%>> 是
              <input type="radio" name="required" value="N"  <%if(!ChanpindlggEditPage.getRequired().equals("Y")){%>checked<%}%>> 否
            </td>
          </tr>
          <tr> 
            <td colspan="2" width="329">制式： 
              <input type="radio" name="measFlag" value="M" checked> 公制
              <input type="radio" name="measFlag" value="I"> 英制
            </td>
            <td width="189">公制计量单位： 
              <select name="unitM">
	    <% for (int i=0; i<unitItemsM.length; i++) {%>
                <option value="<%=unitItemsM[i]%>" <%if(ChanpindlggEditPage.getUnitM().equals(unitItemsM[i])){%>selected<%}%>> <%=unitItemsM[i]%> </option>
            <% } %>
<%--                <option value="%" <%if(ChanpindlggEditPage.getUnitM().equals("%")){%>selected<%}%>> % </option>
                <option value="km" <%if(ChanpindlggEditPage.getUnitM().equals("km")){%>selected<%}%>> km </option>
                <option value="m" <%if(ChanpindlggEditPage.getUnitM().equals("m")){%>selected<%}%>> m </option>
                <option value="cm" <%if(ChanpindlggEditPage.getUnitM().equals("cm")){%>selected<%}%>> cm </option>
                <option value="mm" <%if(ChanpindlggEditPage.getUnitM().equals("mm")){%>selected<%}%>> mm </option>                
                <option value="um" <%if(ChanpindlggEditPage.getUnitM().equals("um")){%>selected<%}%>> um </option>                
                <option value="t" <%if(ChanpindlggEditPage.getUnitM().equals("t")){%>selected<%}%>> t </option>                
                <option value="kg" <%if(ChanpindlggEditPage.getUnitM().equals("kg")){%>selected<%}%>> kg </option>                
                <option value="g" <%if(ChanpindlggEditPage.getUnitM().equals("g")){%>selected<%}%>> g </option>                
                <option value="l" <%if(ChanpindlggEditPage.getUnitM().equals("l")){%>selected<%}%>> l </option>                
                <option value="ml" <%if(ChanpindlggEditPage.getUnitM().equals("ml")){%>selected<%}%>> ml </option>                
                <option value="mN*m" <%if(ChanpindlggEditPage.getUnitM().equals("mN*m")){%>selected<%}%>> mN*m </option>                
                <option value="s" <%if(ChanpindlggEditPage.getUnitM().equals("s")){%>selected<%}%>> s </option>                
                <option value="mN" <%if(ChanpindlggEditPage.getUnitM().equals("mN")){%>selected<%}%>> mN </option>                
                <option value="kN/m" <%if(ChanpindlggEditPage.getUnitM().equals("kN/M")){%>selected<%}%>> kN/m </option>                
                <option value="kPa" <%if(ChanpindlggEditPage.getUnitM().equals("kPa")){%>selected<%}%>> kPa </option>                
                <option value="gf" <%if(ChanpindlggEditPage.getUnitM().equals("gf")){%>selected<%}%>> gf </option>                
                <option value="N" <%if(ChanpindlggEditPage.getUnitM().equals("gf")){%>selected<%}%>> N </option>                
--%>              </select>
            </td>
          </tr>
          <tr> 
            <td width="173">下限： 
              <input type="text" name="value1" size="8" value="<%=ChanpindlggEditPage.getValue1()%>">
            </td>
            <td width="156">上限： 
              <input type="text" name="value2" size="8" value="<%=ChanpindlggEditPage.getValue2()%>">
            </td>
            <td width="189">英制计量单位： 
              <select name="unitI">
	    <% for (int i=0; i<unitItemsI.length; i++) {%>
                <option value="<%=unitItemsI[i]%>" <%if(ChanpindlggEditPage.getUnitI().equals(unitItemsI[i])){%>selected<%}%>> <%=unitItemsI[i]%> </option>
            <% } %>
<%--                <option value="%" <%if(ChanpindlggEditPage.getUnitI().equals("%")){%>selected<%}%>> % </option>
                <option value="mi" <%if(ChanpindlggEditPage.getUnitI().equals("mi")){%>selected<%}%>> mi </option>
                <option value="yd" <%if(ChanpindlggEditPage.getUnitI().equals("yd")){%>selected<%}%>> yd </option>
                <option value="ft" <%if(ChanpindlggEditPage.getUnitI().equals("ft")){%>selected<%}%>> ft </option>
                <option value="in" <%if(ChanpindlggEditPage.getUnitI().equals("in")){%>selected<%}%>> in </option>                
                <option value="st" <%if(ChanpindlggEditPage.getUnitI().equals("st")){%>selected<%}%>> st </option>                
                <option value="lb" <%if(ChanpindlggEditPage.getUnitI().equals("lb")){%>selected<%}%>> lb </option>                
                <option value="oz" <%if(ChanpindlggEditPage.getUnitI().equals("oz")){%>selected<%}%>> oz </option> 
                <option value="gal" <%if(ChanpindlggEditPage.getUnitI().equals("gal")){%>selected<%}%>> gal </option> 
                <option value="lbf/in" <%if(ChanpindlggEditPage.getUnitI().equals("lbf/in")){%>selected<%}%>> lbf/in </option> 
                <option value="lbf" <%if(ChanpindlggEditPage.getUnitI().equals("lbf")){%>selected<%}%>> lbf </option> 
                <option value="kPa" <%if(ChanpindlggEditPage.getUnitI().equals("kPa")){%>selected<%}%>> kPa </option> 
                <option value="lbf/6in" <%if(ChanpindlggEditPage.getUnitI().equals("lbf/6in")){%>selected<%}%>> lbf/6in </option> 
                <option value="lbf/ft" <%if(ChanpindlggEditPage.getUnitI().equals("lbf/ft")){%>selected<%}%>> lbf/ft </option> 
                <option value="pt" <%if(ChanpindlggEditPage.getUnitI().equals("pt")){%>selected<%}%>> pt </option> 
--%>              </select>
            </td>
          </tr>
          <tr align="center"> 
            <td colspan="3"> 
              <input type="image" border="0" name="imageField" src="../images/submit.gif" width="68" height="26">
              <img border="0" src="../images/cancle.gif" width="68" height="26" onClick="javascript:document.form1.reset();">
              <a href="chanpingg_canslb.jsp?cateId=<%=ChanpindlggEditPage.getCateId()%>&specId=<%=ChanpindlggEditPage.getSpecId()%>"><img border="0" src="../images/verylong.gif" width="120" height="26"></a>
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
</table>
</body>
<!-- #EndTemplate -->
</html>

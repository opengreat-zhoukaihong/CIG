<%--  @# prod_maintain.jsp Ver.1.1 --%>

<html>
<head>
  <title> example for ProductInfoTest </title>
</head>

<body>

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

  funcId = "fnMemberMgr";
  userID = UserInfo.getUsername();
  permTest.setFuncId(funcId);
  permTest.setUserId(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
    <jsp:forward page="/inform.jsp?info=对不起, 您没有权限使用该功能! " />
<%}%>


<%@ page import="postcenter.*, java.util.*" %>
<%--<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />--%>
<jsp:useBean id="PostPerProd" scope="page" class="postcenter.PostPerProd" /> 

<jsp:setProperty name="PostPerProd" property="langCode" />
<jsp:setProperty name="PostPerProd" property="measureFlag" />
<jsp:setProperty name="PostPerProd" property="cateId" />
<jsp:setProperty name="PostPerProd" property="typeId" />
<jsp:setProperty name="PostPerProd" property="gradeId" />
<jsp:setProperty name="PostPerProd" property="sampleId" />
<jsp:setProperty name="PostPerProd" property="brandDesc" />
<jsp:setProperty name="PostPerProd" property="brandId" />
<jsp:setProperty name="PostPerProd" property="prodCounId" />
<jsp:setProperty name="PostPerProd" property="prodStateId" />
<jsp:setProperty name="PostPerProd" property="prodCityId" />
<jsp:setProperty name="PostPerProd" property="productId" />
<jsp:setProperty name="PostPerProd" property="productName" />

<% 
//    PostPerProd.setUserId(UserInfo.getUserId());
//    PostPerProd.setCompanyId(UserInfo.getCompanyId());
    PostPerProd.setUserId("");
    PostPerProd.setCompanyId(request.getParameter("companyId"));
    PostPerProd.init();
    
    Spec[] specItems=PostPerProd.specList.specItems;
    Enumeration e = request.getParameterNames();
    int i=0;

    while ( e.hasMoreElements()) {
        i++; 
        String name = (String)e.nextElement();
        String value = request.getParameter(name);

        if ( !value.equals("")) { 
	    for (int j=0; j<specItems.length; j++) {
	        if( name.equals("input_min_Spec"+specItems[j].specId)) {
		    specItems[j].setSpecMinVal(value);
	        }
	        else if( name.equals("input_max_Spec"+specItems[j].specId)) {
		    specItems[j].setSpecMaxVal(value);
	        }
	        else if( name.equals("input_option_Spec"+specItems[j].specId)) {
		    specItems[j].setSpecParaId(value);
	        }
	    }
        }
    }
    
    PostPerProd.getSpecSetCount();
%>
-------------------------<br>
spec specSetCount = <%=PostPerProd.specSetCount%><br>
<%  for(i=0; i<specItems.length; i++) {
        if (specItems[i].valueIsSet) { %>
---<br>
spec specId = <%=specItems[i].specId%>  specName = <%=specItems[i].specName%><br>
<%          if (!specItems[i].specValFlag.equals("N")) { %>
Defined Range is: <%=specItems[i].specValue1%> -- <%=specItems[i].specValue2%><br>
Value min: <%=specItems[i].specMinVal%> -- max: <%=specItems[i].specMaxVal%><br>
<%          } else { %>
SpecParaId: <%=specItems[i].specParaId %>   SpecParaStr: <%=specItems[i].getSpecParaStr() %><br>
<%          } %>
<%      }
    }%>
===========================<br>
post userId = <%=PostPerProd.userId%><br>
post companyId = <%=PostPerProd.companyId%><br>
post langCode = <%=PostPerProd.langCode%><br>
post measureFlag = <%=PostPerProd.measureFlag%><br>
post cateId = <%=PostPerProd.cateId%><br>
post typeId = <%=PostPerProd.typeId%><br>
post gradeId = <%=PostPerProd.gradeId%><br>
post sampleId = <%=PostPerProd.sampleId%><br>
post brandDesc = <%=PostPerProd.brandDesc%><br>
post brandId = <%=PostPerProd.brandId%><br>
post prodCounId = <%=PostPerProd.prodCounId%><br>
post prodStateId = <%=PostPerProd.prodStateId%><br>
post prodCityId = <%=PostPerProd.prodCityId%><br>
post productId = <%=PostPerProd.getProductId()%><br>
post productName = <%=PostPerProd.getProductName()%><br>
-------------------------<br>
<% if(PostPerProd.addOrChgProduct()) { %>
post success!
<% }else{%>
post false!
<% }%><br>
productId = <%=PostPerProd.getProductId()%><br>
<br><%=PostPerProd.errMsg%><br>
last line. <br>
</body>
</html>

<%@ page import="java.util.*,java.sql.*,java.io.*" session="true" language="java" %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnMaterialMg";
  userID = (String)session.getValue("operator");
  // Add by Frank , delete after test
  // userID = "frank";
  // End of add

  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted){
%>
<jsp:forward page="BackResultsError.jsp?message=Sorry! You have no permission!" />
<% } %>
<jsp:useBean id="material" scope="request" class="com.forbrand.bst.Material" />

<%! String materialID,langCode,materialName,opeID,mdDate,langDescr;
%>
<%
    try
    {
      materialID = request.getParameter("materialID");
      langCode = request.getParameter("langCode");
      materialName = request.getParameter("materialName");
      langDescr = request.getParameter("langDescr");
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
%>


<html>
<head>
<script>

	/**
     * Modify materian name
     */
    function materialModifyName()
    {
      if(document.materialModify.materialName.value == "")
	  {
	    alert("Please input material name !");
	    document.materialModify.materialName.focus();
	    return false;
	  }
      document.materialModify.materialID.value = "<%=materialID%>";
      document.materialModify.langCode.value = "<%=langCode%>";
      document.materialModify.opeID.value = "<%=userID%>";
	  if(confirm("Do you want to modify the material ?"))
        return true;
	}


</script>
<title>Material modify</title>
<link rel="stylesheet" href="/public.css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body bgcolor="#FFFFFF">
<table border="0" bgcolor="#FFFFFF" width="460" class="black-m-text">
  <tr>
    <td height="52">
      <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolordark="#6699FF">
        <tr bgcolor="#FFFFFF">
          <td colspan="2">
            <div align="center">Material modify</div>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td>
            <div align="center">Language Code</div>
          </td>
          <td>
            <div align="center">Material Name</div>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td>
            <div align="center"><%=langDescr%></div>
          </td>
          <td>
            <div align="center"><%=materialName%></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0">
        <tr>
          <td>
            <form method="post" action="material.jsp?action=modify" name="materialModify" onSubmit="return materialModifyName()">
              <input type="text" name="materialName" size="50" maxlength="50">
              <input type="submit" name="materialModify" value="Modify">
              <input type="hidden" name="materialID" >
              <input type="hidden" name="langCode" >
              <input type="hidden" name="opeID" >
            </form></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

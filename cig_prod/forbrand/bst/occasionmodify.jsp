<%@ page import="java.util.*,java.sql.*,java.io.*" session="true" language="java" %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnOccasionMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted){
%>
<jsp:forward page="BackResultsError.jsp?message=Sorry! You have no permission!" />
<% } %>
<jsp:useBean id="occasion" scope="request" class="com.forbrand.bst.Occasion" />

<%! String occasionID,langCode,occasionName,opeID,mdDate,langDescr;
%>
<%
    try
    {
      occasionID = request.getParameter("occasionID");
      langCode = request.getParameter("langCode");
      occasionName = request.getParameter("occasionName");
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
    function occasionModifyName()
    {
      if(document.occasionModify.occasionName.value == "")
      {
        alert("Please input occasion name !");
        document.occasionModify.occasionName.focus();
        return false;
      }
      document.occasionModify.occasionID.value = "<%=occasionID%>";
      document.occasionModify.langCode.value = "<%=langCode%>";
      document.occasionModify.opeID.value = "<%=userID%>";
      if(confirm("Do you want to modify the occasion ?"))
      {
        self.opener.document.refreshOccasion.occasionID = "<%=occasionID%>";
        self.opener.document.refreshOccasion.occasionName = document.occasionModify.occasionName.value;
        self.opener.document.refreshOccasion.langCode =  "<%=langCode%>";
        self.opener.document.refreshOccasion.opeID = "<%=userID%>";
        
        self.opener.document.refreshOccasion.submit();
        self.close();
        return true;
      }
    }


</script>
<title>Occasion modify</title>
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
            <div align="center">Occasion modify</div>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td>
            <div align="center">Language Code</div>
          </td>
          <td>
            <div align="center">Occasion Name</div>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td>
            <div align="center"><%=langDescr%></div>
          </td>
          <td>
            <div align="center"><%=occasionName%></div>
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
            <form method="post" action="occasion.jsp?action=modify" name="occasionModify" onSubmit="return occasionModifyName()">
              <input type="text" name="occasionName" size="50" maxlength="50">
              <input type="submit" name="occasionModify" value="Modify">
              <input type="hidden" name="occasionID" >
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

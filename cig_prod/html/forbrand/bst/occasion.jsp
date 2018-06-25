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

<%! String action;
    String occasionID,langCode,occasionName,opeID,crDate,mdDate;
    int occasionCount,langCodeCount;
    String [][] occasions;
    String [][] langCodes;
%>
<%
    try
    {
      action = request.getParameter("action");
      if(action != null && action.equals("delete"))  // Delete a record from table MATERIAL.
      {
        occasionID = request.getParameter("occasionID");
        langCode = request.getParameter("langCode");
        occasion.setOccasionID(occasionID);
        occasion.setLangCode(langCode);
        occasion.deleteOccasion();
      }
      if(action != null && action.equals("add"))     // Add a record from table MATERIAL.
      {
        occasionName = request.getParameter("occasionName");
        occasion.setOccasionName(occasionName);
        occasion.setOpeID(userID);
        occasion.addOccasion();
      }
      if(action != null && action.equals("modify"))     // Modify a record from table MATERIAL.
      {
        occasionName = request.getParameter("occasionName");
        opeID = request.getParameter("opeID");
        occasionID = request.getParameter("occasionID");
        langCode = request.getParameter("langCode");
        occasion.setOccasionName(occasionName);
        occasion.setOpeID(opeID);
        occasion.setLangCode(langCode);
        occasion.setOccasionID(occasionID);
        occasion.modifyOccasionName();
      }
      langCodeCount = Integer.parseInt(occasion.getLangDescCount());
      if(langCodeCount != 0)
        langCodes = occasion.getLangDescs();
      else
        langCodes = null;
      occasionCount = Integer.parseInt(occasion.getOccasionCount());
      if(occasionCount != 0)
        occasions = occasion.getOccasions();
      else
        occasions = null;
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
%>

<HTML>
<HEAD>
<script>

   /**
    * Delete one record from table MATERIAL.
    */

    function occasionDelete(occasionID,langCode)
    {
      document.occasionDel.occasionID.value = occasionID;
      document.occasionDel.langCode.value = langCode;
      if(confirm("Do you want to delete the occasion ?"))
      document.occasionDel.submit();
    }

   /**
    * Modify one record of table MATERIAL.
    */

    function occasionModify(occasionID,occasionName,langCode,langDescr)
    {
      document.occasionModify.occasionID.value = occasionID;
      document.occasionModify.occasionName.value = occasionName;
      document.occasionModify.langCode.value = langCode;
      document.occasionModify.langDescr.value = langDescr;
      if(confirm("Do you want to modify the occasion ?"))
      {
        //document.occasionModify.submit();
        window.open("occasionmodify.jsp?occasionID="+occasionID+"&occasionName="+occasionName+"&langCode="+langCode+"&langDescr="+langDescr,"OccasionModify","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=550,height=450");
      }
    }

   /**
    * Validate the input value of occasionName,it must not be null
    */

    function validateOccasionName()
    {
      if(document.occasionAdd.occasionName.value == "")
      {
        alert("Please input occasion name !");
        document.occasionAdd.occasionName.focus();
        return false;
      }
    }

</script>


<TITLE>
Occasion
</TITLE>
<link rel="stylesheet" href="/public.css">
</HEAD>
<BODY bgcolor="#FFFFFF">
<table width="87%" border="0" bordercolor="#E3E3E3" bgcolor="#FFFFFF" height="164" class="black-m-text">
  <tr>
    <td>
      <table width="100%" border="1" bgcolor="#FFFFFF" bordercolor="#FFFFFF" bordercolordark="#3399FF" class="black-m-text" bordercolorlight="#FFFFFF" cellpadding="0" cellspacing="0">
        <tr>
          <td colspan="8">
            <div align="center">Occasion</div>
          </td>
        </tr>
        <tr>
          <td height="2" width="12%">
            <div align="center"> Occasion<br>
              ID</div>
          </td>
          <td height="2" width="26%">
            <div align="center">Occasion<br>
              Name</div>
          </td>
          <td height="2" width="7%">
            <div align="center">Lang<br>
              Code</div>
          </td>
          <td height="2" width="12%">
            <div align="center">Operator<br>
              ID</div>
          </td>
          <td height="2" width="12%">
            <div align="center">Create<br>
              Date</div>
          </td>
          <td height="2" width="12%">
            <div align="center">Modify<br>
              Date</div>
          </td>
          <td height="2" width="9%">
            <div align="center">Modify</div>
          </td>
          <td height="2" width="10%">
            <div align="center">Delete</div>
          </td>
        </tr>

        <% for(int i=0;i<occasionCount;i++){%>

        <tr>
          <td width="12%">
            <div align="center">
              <% if(occasions[i][0] != null){ %> <%= occasions[i][0] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="26%">
            <div align="center">
              <% if(occasions[i][2] != null){ %> <%= occasions[i][2] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="7%">
            <div align="center">
              <% if(occasions[i][1] != null){
                   for(int m=0;m<langCodeCount;m++)
                   {
                     if(langCodes[m][0].equals(occasions[i][1])){
                       %> <%= langCodes[m][1] %>
                  <% } %>
                <% } %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="12%">
            <div align="center">
              <% if(occasions[i][3] != null){ %> <%= occasions[i][3] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="12%">
            <div align="center">
              <% if(occasions[i][4] != null){ %> <%= occasions[i][4] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="12%">
            <div align="center">
              <% if(occasions[i][5] != null){ %> <%= occasions[i][5] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="9%">
          <% for(int n=0;n<langCodeCount;n++)
             {
               if(occasions[i][1].equals(langCodes[n][0]))
               { %>
            <div align="center"><a href="javascript:occasionModify('<%= occasions[i][0] %>','<%= occasions[i][2] %>','<%= occasions[i][1] %>','<%= langCodes[n][1]%>')">[Modify]</a></div>
            <% } %>
         <% } %>
          </td>
          <td width="10%">
            <div align="center"><a href="javascript:occasionDelete('<%= occasions[i][0] %>','<%= occasions[i][1] %>')">[Delete]</a></div>
          </td>
        </tr>
      <% } %>
      </table>
    </td>
  </tr>
  <tr>
    <td height="57">
      <table width="100%" border="1" bordercolor="#FFFFFF" cellpadding="0" cellspacing="0" bordercolorlight="#6699FF">
        <tr>
          <td height="23">
            <form name="occasionAdd" method="post" action="occasion.jsp?action=add" onSubmit="return validateOccasionName()">
              <p>
                <input type="text" name="occasionName" maxlength="50" size="50">
                <input type="submit" name="occasionAdd" value="Add">
              </p>
            </form>
          </td>
        </tr>
      </table>

    </td>
  </tr>
</table>
<form method="post" action="occasion.jsp?action=delete" name="occasionDel">
  <input type="hidden" name="occasionID">
  <input type="hidden" name="langCode">
</form>
<form method="post" name="occasionModify" action="occasionmodify.jsp">
  <input type="hidden" name="occasionName">
  <input type="hidden" name="langCode">
  <input type="hidden" name="occasionID">
  <input type="hidden" name="langDescr">
</form>

<form method="post" action="occasion.jsp?action=modify" name="refreshOccasion" target="_self">
  <input type="hidden" name="occasionID">
  <input type="hidden" name="occasionName">
  <input type="hidden" name="langCode">
  <input type="hidden" name="opeID">
</form>
<p>&nbsp;</p>
</BODY>
</HTML>

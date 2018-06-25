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

<%! String action;
    String materialID,langCode,materialName,opeID,crDate,mdDate;
    int materialCount,langCodeCount;
    String [][] materials;
    String [][] langCodes;
%>
<%
    try
    {
      action = request.getParameter("action");
      if(action != null && action.equals("delete"))  // Delete a record from table MATERIAL.
      {
        materialID = request.getParameter("materialID");
        langCode = request.getParameter("langCode");
        material.setMaterialID(materialID);
        material.setLangCode(langCode);
        material.deleteMaterial();
      }
      if(action != null && action.equals("add"))     // Add a record from table MATERIAL.
      {
        materialName = request.getParameter("materialName");
        material.setMaterialName(materialName);
        material.setOpeID(userID);
        material.addMaterial();
      }
      if(action != null && action.equals("modify"))     // Modify a record from table MATERIAL.
      {
        materialName = request.getParameter("materialName");
        opeID = request.getParameter("opeID");
        materialID = request.getParameter("materialID");
        langCode = request.getParameter("langCode");
        material.setMaterialName(materialName);
        material.setOpeID(opeID);
        material.setLangCode(langCode);
        material.setMaterialID(materialID);
        material.modifyMaterialName();
      }
      langCodeCount = Integer.parseInt(material.getLangDescCount());
      if(langCodeCount != 0)
        langCodes = material.getLangDescs();
      else
        langCodes = null;
      materialCount = Integer.parseInt(material.getMaterialCount());
      if(materialCount != 0)
        materials = material.getMaterials();
      else
        materials = null;
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

    function materialDelete(materialID,langCode)
    {
      document.materialDel.materialID.value = materialID;
      document.materialDel.langCode.value = langCode;
	  if(confirm("Do you want to delete the material ?"))
		document.materialDel.submit();
	}

    /**
	 * Modify one record of table MATERIAL.
     */

    function materialModify(materialID,materialName,langCode,langDescr)
    {
      document.materialModify.materialID.value = materialID;
      document.materialModify.materialName.value = materialName;
      document.materialModify.langCode.value = langCode;
      document.materialModify.langDescr.value = langDescr;

	  if(confirm("Do you want to modify the material ?"))
      {
        document.materialModify.submit();
      }
	}

	/**
	 * Validate the input value of materialName,it must not be null
	 */

	function validateMaterialName()
	{
	  if(document.materialAdd.materialName.value == "")
	  {
	    alert("Please input material name !");
	    document.materialAdd.materialName.focus();
	    return false;
	  }
	}



</script>

<TITLE>
Material
</TITLE>
<link rel="stylesheet" href="/public.css">
</HEAD>
<BODY bgcolor="#FFFFFF">
<table width="87%" border="0" bordercolor="#E3E3E3" bgcolor="#FFFFFF" height="164">
  <tr>
    <td>
      <table width="100%" border="1" bgcolor="#FFFFFF" bordercolor="#FFFFFF" bordercolordark="#3399FF" class="black-m-text" bordercolorlight="#FFFFFF" cellpadding="0" cellspacing="0">
        <tr>
          <td colspan="8">
            <div align="center">Material</div>
          </td>
        </tr>
        <tr>
          <td height="2" width="12%">
            <div align="center"> Material<br>
              ID</div>
          </td>
          <td height="2" width="26%">
            <div align="center">Material<br>
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

        <% for(int i=0;i<materialCount;i++){%>

        <tr>
          <td width="12%">
            <div align="center">
              <% if(materials[i][0] != null){ %> <%= materials[i][0] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="26%">
            <div align="center">
              <% if(materials[i][2] != null){ %> <%= materials[i][2] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="7%">
            <div align="center">
              <% if(materials[i][1] != null){
                   for(int m=0;m<langCodeCount;m++)
                   {
                     if(langCodes[m][0].equals(materials[i][1])){
                       %> <%= langCodes[m][1] %>
                  <% } %>
                <% } %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="12%">
            <div align="center">
              <% if(materials[i][3] != null){ %> <%= materials[i][3] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="12%">
            <div align="center">
              <% if(materials[i][4] != null){ %> <%= materials[i][4] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="12%">
            <div align="center">
              <% if(materials[i][5] != null){ %> <%= materials[i][5] %>
              <% } else { %> <%=" "%> <% } %>
            </div>
          </td>
          <td width="9%">
          <% for(int n=0;n<langCodeCount;n++)
             {
               if(materials[i][1].equals(langCodes[n][0]))
               { %>
            <div align="center"><a href="javascript:materialModify('<%= materials[i][0] %>','<%= materials[i][2] %>','<%= materials[i][1] %>','<%= langCodes[n][1]%>')">[Modify]</a></div>
            <% } %>
         <% } %>
          </td>
          <td width="10%">
            <div align="center"><a href="javascript:materialDelete('<%= materials[i][0] %>','<%= materials[i][1] %>')">[Delete]</a></div>
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
            <form name="materialAdd" method="post" action="material.jsp?action=add" onSubmit="return validateMaterialName()">
              <p>
                <input type="text" name="materialName" maxlength="50" size="50">
                <input type="submit" name="materialAdd" value="Add">
              </p>
            </form>
          </td>
        </tr>
      </table>

    </td>
  </tr>
</table>
<form method="post" action="material.jsp?action=delete" name="materialDel">
  <input type="hidden" name="materialID">
  <input type="hidden" name="langCode">
</form>
<form method="post" action="materialmodify.jsp" name="materialModify">
  <input type="hidden" name="materialName">
  <input type="hidden" name="langCode">
  <input type="hidden" name="materialID">
  <input type="hidden" name="langDescr">
</form>
<p>&nbsp;</p>
</BODY>
</HTML>

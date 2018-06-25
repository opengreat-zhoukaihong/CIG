<%@ page import="java.util.*,java.sql.*,java.io.*" session="true" language="java" %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnUnitMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted){
%>
<jsp:forward page="BackResultsError.jsp?message=Sorry! You have no permission!" />
<% } %>

<jsp:useBean id="unitManager" scope="request" class="com.forbrand.bst.UnitManager" />

<%! String unit,measure,unitFlag,action;
    int unitCount;
    String [][] unitsList;
%>
<%
    try
    {
      action = request.getParameter("action");
      if(action != null && action.equals("delete"))  // Delete a record from table unit.
      {
        unit = request.getParameter("unit");
        unitManager.setUnit(unit);
        unitManager.unitDelete();
      }

      if(action != null && action.equals("add"))     // Add a record from table unit.
      {
        unit = request.getParameter("unit");
        measure = request.getParameter("measure");
        unitFlag = request.getParameter("unitFlag");
        unitManager.setUnit(unit);
        unitManager.setUnitFlag(unitFlag);
        unitManager.setMeasure(measure);
        unitManager.unitAdd();
      }


      unitCount = Integer.parseInt(unitManager.getUnitCount());   // Get data from table unit.
      unitsList = unitManager.getUnits();
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
%>



<HTML>
<HEAD>
<TITLE>
Unit Manager
</TITLE>
<link rel="stylesheet" href="/public.css">

<script>
	/**
	 * Delete one record from table unit.
	 */
	function unitDelete(tempUnit)
	{
	  document.unitDel.unit.value = tempUnit;
	  if(confirm("Do you want to delete the unit ?"))
		document.unitDel.submit();
	}
	/**
	 * Validate the input value of unit,it must not be null
	 */
	function validateForm()
	{
	  if(document.unitAdd.unit.value == "")
	  {
	    alert("Please input unit !");
	    document.unitAdd.unit.focus();
	    return false;
	  }
	}


</script>


</HEAD>
<BODY bgcolor="#FFFFFF">
<table width="65%" border="0" height="236" bordercolor="#3333FF" cellspacing="0" cellpadding="0" class="black-m-text">
  <tr align="center" valign="middle">
    <td height="83">
      <table border="1" name="Unit Lists" width="100%" height="76" bordercolordark="#6699FF" bordercolorlight="#FFFFFF" bgcolor="#FFFFFF" bordercolor="#6699FF" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFFFFF">
          <td colspan="4" height="2">
            <div align="center">Unit Manager</div>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td width="109" height="2">
            <div align="center">Unit</div>
          </td>
          <td width="107" height="2">
            <div align="center">Measure</div>
          </td>
          <td width="110" height="2">
            <div align="center">Unit Flag</div>
          </td>
          <td width="104" height="2">
            <div align="center">Operation</div>
          </td>
        </tr>
        <% for(int i=0;i<unitCount;i++){ %>
        <tr>
          <td width="109" height="2">
            <div align="center"><% if(unitsList[i][0] != null){ %> <%= unitsList[i][0] %>
              <% } else { %> <%=" "%> <% } %> </div>
          </td>
          <td width="107" height="2">
            <div align="center"><% if(unitsList[i][1] != null){ %> <%= unitsList[i][1].equals("M")?"Metric":"Imperial" %>
              <% } else { %> <%=" " %> <% } %></div>
          </td>
          <td width="110" height="2">
            <div align="center"><% if(unitsList[i][2] != null){ %> <%= unitsList[i][2].equals("L")?"Length":"Weigth" %>
              <% } else { %> <%=" " %> <% } %></div>
          </td>
          <td width="104" height="2">
            <div align="center"><a href="javascript:unitDelete('<%= unitsList[i][0] %>')">[Delete]
              </a> </div>
          </td>
        </tr>
        <% } %>
      </table>

    </td>
  </tr>
  <tr valign="bottom" align="center">
    <td height="106">
      <form method="post" action="unit.jsp?action=add" name="unitAdd" onSubmit="return validateForm()">
        <div align="center">
          <table width="100%" border="1" bordercolorlight="#FFFFFF" bordercolordark="#6699FF" cellpadding="0" cellspacing="0" bgcolor="#CCFFFF">
            <tr bgcolor="#FFFFFF">
              <td width="30%" height="30">
                <div align="right">Unit : </div>
              </td>
              <td width="42%" height="30">
                <input type="text" name="unit" size="10" maxlength="10">
              </td>
              <td rowspan="3">
                <input type="submit" name="unitAdd" value="Add Unit">
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="30%" height="30">
                <div align="right">Measure : </div>
              </td>
              <td width="42%" height="30">
                <select name="measure">
                  <option value="M" selected>Metric</option>
                  <option value="I">Imperial</option>
                </select>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="30%" height="30">
                <div align="right">Unit flag : </div>
              </td>
              <td width="42%" height="30">
                <select name="unitFlag">
                  <option value="L" selected>Length</option>
                  <option value="W">Weight</option>
                </select>
              </td>
            </tr>
          </table>
        </div>
      </form>
      </td>
  </tr>
</table>

<form method="post" action="unit.jsp?action=delete" name="unitDel">
  <input type="hidden" name="unit">
</form>
</BODY>
</HTML>

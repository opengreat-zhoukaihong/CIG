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
<jsp:useBean id="unitConversion" scope="request" class="com.forbrand.bst.UnitConversion" />


<%! String unit1,unit2,param,action;

    int unitConversionCount;          // The record number of table unit_conv,
                                      // using for list stored unitConversion
                                      // data from table unit_conv
    String [][] unitConversionsList;  // As above , store data selected from unit_conv

    int unitFlagCountLength;
    int unitFlagCountWeight;
    String unitsLength [] ;
    String unitsWeight [] ;
    int i;
%>
<%
    try
    {
      action = request.getParameter("action");
      if(action != null && action.equals("delete"))   // Delete one record from table UNIT_CONV
      {
        unit1 = request.getParameter("unit1");
        unit2 = request.getParameter("unit2");
        unitConversion.setUnit1(unit1);
        unitConversion.setUnit2(unit2);
        unitConversion.unitConversionDelete();
      }

      if(action != null && action.equals("add"))      // Add one record into table UNIT_CONV
      {
        unit1 = request.getParameter("unit1");
        unit2 = request.getParameter("unit2");
        param = request.getParameter("param");
        unitConversion.setUnit1(unit1);
        unitConversion.setUnit2(unit2);
        unitConversion.setParam(param);
        unitConversion.unitConversionAdd();
      }

      /**
       * Get data from table UNIT_CONV , then use these data fill list in this page.
       */
      if(unitConversion.getUnitConversionCount() != null)
      {
        unitConversionCount = Integer.parseInt(unitConversion.getUnitConversionCount());
        unitConversionsList = unitConversion.getUnitConversions();
      }
      else
        unitConversionCount = 0;

      /**
       * Get data from table unit, then use these data to fill listbox,
       * So you can select unit from listbox.
       */
      if(unitConversion.getUnitCountByUnitFlag("L") != null)
      {
        unitFlagCountLength = Integer.parseInt(unitConversion.getUnitCountByUnitFlag("L"));
        unitsLength = unitConversion.getUnitsByUnitFlag("L");
      }
      else
      {
        unitFlagCountLength = 0;
        unitsLength = null;
      }
      if(unitConversion.getUnitCountByUnitFlag("W") != null)
      {
        unitFlagCountWeight = Integer.parseInt(unitConversion.getUnitCountByUnitFlag("W"));
        unitsWeight = unitConversion.getUnitsByUnitFlag("W");
      }
      else
      {
        unitFlagCountWeight = 0;
        unitsWeight = null;
      }

    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
%>



<HTML>
<HEAD>
<TITLE>
Unit Conversion
</TITLE>
<link rel="stylesheet" href="/public.css" >

<script>

	var unitFlag;     // 1: is for Length , 2 : is for Weight
    var unitFlagCountLength ;
	var unitFlagCountWeight ;
	var unitsLength ;
	var unitsWeight ;

	/**
	 * Make an array
	 */
	function makeUnitArray(n)
	{
	  this.length = n;
	  for(var i=0;i<n;i++)
	    this[i] = "";
	  return this;
	}

	/**
	 * When you change unit1 listbox, use this function to change
	 * unit2 listbox contents.
	 */
	function unit2ResponeUnit1()
	{

	  var unitFlag =1 ;
	  var i;

	  unitFlagCountLength = <%= unitFlagCountLength %> ;
	  unitFlagCountWeight = <%= unitFlagCountWeight %> ;


	  if(unitFlagCountLength != 0)
	  {
	    unitsLength = new makeUnitArray(unitFlagCountLength);
	  }
	  else
	  {
	    unitsLength = new makeUnitArray(1);
	  }
	  if(unitFlagCountWeight != 0)
	  {
	    unitsWeight = new makeUnitArray(unitFlagCountWeight);
	  }
	  else
	  {
	    unitsWeight = new makeUnitArray(1);
	  }

	  if((unitFlagCountLength == 0) && (unitFlagCountWeight == 0))
      {

      }

      <% for(int i=0;i<unitFlagCountLength;i++) { %>
           unitsLength[<%=i%>] = "<%=unitsLength[i]%>";
      <% } %>
      <% for(int i=0;i<unitFlagCountWeight;i++) { %>
           unitsWeight[<%=i%>] = "<%=unitsWeight[i]%>";
      <% } %>

      var unit1 = document.unitConversionAdd.unit1.value;
      i=0;
      while((i<unitFlagCountLength) && (unit1 != unitsLength[i]))
        i++;
      if(i<unitFlagCountLength)
        unitFlag = 1;
      else
        unitFlag = 2;

      if(unitFlag == 1)
      {
        document.unitConversionAdd.unit2.length = unitFlagCountLength;
        for(i=0;i<unitFlagCountLength;i++)
        {
          document.unitConversionAdd.unit2.options[i].text = unitsLength[i];
          document.unitConversionAdd.unit2.options[i].value = unitsLength[i];
        }
      }
      if(unitFlag == 2)
      {
        document.unitConversionAdd.unit2.length = unitFlagCountWeight;
        for(i=0;i<unitFlagCountWeight;i++)
        {
          document.unitConversionAdd.unit2.options[i].text = unitsWeight[i];
          document.unitConversionAdd.unit2.options[i].value = unitsWeight[i];
        }
      }
    }

    /**
     * Use this function to decide the number of item of unit2 listbox.
     */
    function unit2SelectNumber()
	{

	  unitFlagCountLength = <%= unitFlagCountLength %> ;
	  unitFlagCountWeight = <%= unitFlagCountWeight %> ;
	  if(unitFlagCountLength < unitFlagCountWeight)
	    return unitFlagCountWeight;
	  else
	    return unitFlagCountLength;
    }

    /**
     * Fill unit2 listbox ,depending on unit1 listbox selected.
     */
    function makeUnit2Select()
    {
      var unit2Select = unit2SelectNumber();
      if(unit2Select == 0)
      {
        document.writeln("<select name=\"unit2\" >");
        document.writeln("<option value=\"\"></option>");
        document.writeln("</select>");
        return;
      }
      document.writeln("<select name=\"unit2\" >");
      for(var i=0;i<unit2Select;i++)
      {
        document.writeln("<option value=\"\"></option>");
      }
      document.writeln("</select>");
    }
    /**
     * Judge if the input char is digit or dot (".") .
     */
    function isDigitOrDot(ch)
    {
      if((ch>="0" && ch<="9") || (ch == ".") )
        return true;
      else
        return false;

    }

    /**
     * Check if the input param is number , and not null.
     */
	function validateParam()
	{
	  /**
	   * Validate if there is item in listbox
	   */

	  if(document.unitConversionAdd.unit1.value == "")
	  {
	    alert("Please select unit1 first ! ");
	    return false;
	  }
	  if(document.unitConversionAdd.unit2.value == "")
	  {
	    alert("Please select unit2 first ! ");
	    return false;
	  }

	  /**
	   * Validate parameter text
	   */
	  var flagNumber = 0;    // 0: param is a number. 1: not a number
	  var param = new String(document.unitConversionAdd.param.value);
	  var i;
	  var dotNumber =0;
	  if(param.length == 0)
	    flagNumber = 1;
	  if(param.length != 0)
	  {
	    for(i=0;i<param.length;i++)
	    {
	      if(! isDigitOrDot(param.charAt(i)))
	      {
	        flagNumber = 1;
	        break;
	      }
	      if(param.charAt(i)==".")
	      {
	        dotNumber++;
	        if(dotNumber>1)
	        {
	          flagNumber =1;
	          break;
	        }
	      }
	    }
	    if((param.charAt(0) == ".") || (param.charAt(param.length-1) == "."))
	    {
	      flagNumber = 1;
	    }
	  }
	  if(flagNumber == 1)
	  {
	    alert("Please input a number !");
	    document.unitConversionAdd.param.focus();
	    return false;
	  }
	}

	/**
	 * Use for delete select recrod.
	 */
	function unitConversionDelete(tempUnit1,tempUnit2)
	{
	  document.unitConversionDel.unit1.value = tempUnit1;
	  document.unitConversionDel.unit2.value = tempUnit2;
	  if(confirm("Do you want to delete the unit conversion ?"))
		document.unitConversionDel.submit();
	}


</script>


</HEAD>
<BODY onLoad="unit2ResponeUnit1()" bgcolor="#FFFFFF">
<table width="65%" border="0" height="236" bordercolor="#3333FF" cellspacing="0" cellpadding="0" class="black-m-text">
  <tr align="center" valign="middle">
    <td height="83">
      <table border="1" name="Unit Lists" width="100%" height="76" bordercolordark="#6699FF" bordercolorlight="#FFFFFF" bgcolor="#FFFFFF" bordercolor="#6699FF" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFFFFF">
          <td colspan="4" height="2">
            <div align="center">Unit Convesion</div>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td width="109" height="2">
            <div align="center">Unit1</div>
          </td>
          <td width="107" height="2">
            <div align="center">Unit2</div>
          </td>
          <td width="110" height="2">
            <div align="center">Parameter</div>
          </td>
          <td width="104" height="2">
            <div align="center">Operation</div>
          </td>
        </tr>
        <% for(i=0;i<unitConversionCount;i++){ %>
        <tr>
          <td width="109" height="2">
            <div align="center"><% if(unitConversionsList[i][0] != null){ %> <%= unitConversionsList[i][0] %>
              <% } else { %> <%=" "%> <% } %> </div>
          </td>
          <td width="107" height="2">
            <div align="center"><% if(unitConversionsList[i][1] != null){ %> <%= unitConversionsList[i][1] %>
              <% } else { %> <%=" " %> <% } %></div>
          </td>
          <td width="110" height="2">
            <div align="center"><% if(unitConversionsList[i][2] != null){ %> <%= unitConversionsList[i][2] %>
              <% } else { %> <%=" " %> <% } %></div>
          </td>
          <td width="104" height="2">
            <div align="center"><a href="javascript:unitConversionDelete('<%=unitConversionsList[i][0]%>','<%=unitConversionsList[i][1]%>')">[Delete]
              </a> </div>
          </td>
        </tr>
        <% } %>
      </table>

    </td>
  </tr>
  <tr valign="bottom" align="center">
    <td height="106">
      <form method="post" action="unitconversion.jsp?action=add" name="unitConversionAdd" onSubmit="return validateParam()">
        <div align="center">
          <table width="100%" border="1" bordercolorlight="#6699FF" bordercolordark="#6699FF" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" height="70">
            <tr bgcolor="#FFFFFF">
              <td colspan="5" height="50" bordercolor="#FFFFFF">
                <div align="center">
                  <table width="100%" border="0">
                    <tr>
                      <td width="25%">
                        <div align="center">Unit1</div>
                      </td>
                      <td width="5%">
                        <div align="center">=</div>
                      </td>
                      <td width="25%">
                        <div align="center">Unit2</div>
                      </td>
                      <td width="5%">
                        <div align="center">*</div>
                      </td>
                      <td width="40%">
                        <div align="center">Parameter</div>
                      </td>
                    </tr>
                  </table>
                </div>
                </td>
              <td rowspan="2" width="13%" bordercolor="#FFFFFF" valign="bottom">
                <p>
                  <input type="submit" name="unitAdd" value="Add" >
                </p>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td colspan="5" height="32" bordercolor="#FFFFFF">
                <div align="center">
                  <table width="100%" border="0">
                    <tr>
                      <td width="25%" height="18">
                        <div align="center">
                          <select name="unit1" onChange = "unit2ResponeUnit1()" >

                            <% if((unitFlagCountLength == 0) && ( unitFlagCountWeight == 0)) { %>
                            <option value= "" selected ></option>
                            <% } else { %>

                            <option value= "<%=unitsLength[0]%>" selected ><%=unitsLength[0]%></option>
                            <% for(i=1;i<unitFlagCountLength;i++){ %>
                            <option value= "<%=unitsLength[i]%>" ><%=unitsLength[i]%></option>
                            <% } %> <% for(i=0;i<unitFlagCountWeight;i++){ %>
                            <option value= "<%=unitsWeight[i]%>" ><%=unitsWeight[i]%></option>
                            <% } } %>
                          </select>
                        </div>
                      </td>
                      <td width="5%" height="18">
                        <div align="center"></div>
                        <div align="center"> =</div>
                </td>
                      <td width="25%" height="18">
                        <div align="center">
               <script>
                   makeUnit2Select();
               </script>
                        </div>
                      </td>
                      <td width="5%" height="18">
                        <div align="center"></div>
                        <div align="center"> </div>
                        <div align="center">*</div>
                </td>
                      <td width="40%" height="18">
                        <div align="center">
                          <input type="text" name="param" maxlength="38">
                        </div>
                      </td>
                    </tr>
                  </table>
                </div>
                </td>
            </tr>
          </table>
        </div>
      </form>
      </td>
  </tr>
</table>

<form method="post" action="unitconversion.jsp?action=delete" name="unitConversionDel">
  <input type="hidden" name="unit1">
  <input type="hidden" name="unit2">
</form>
</BODY>
</HTML>

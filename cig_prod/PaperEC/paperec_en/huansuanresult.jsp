<jsp:useBean id="MeasConv" scope="page" class="postcenter.MeasConv" /> 
<jsp:setProperty name="MeasConv" property="unit1" />
<jsp:setProperty name="MeasConv" property="value1" />

<% String measFlag = request.getParameter("measFlag");
   String[] unitArray = new String[0];
   if (measFlag==null)
     measFlag = "";
   if (measFlag.equals("L"))
     unitArray = new String[]{"km", "m", "cm", "mm", "um", "mi", "yd", "ft", "in."};
   else if (measFlag.equals("W"))
     unitArray = new String[]{"t", "kg", "g", "st", "lb", "oz"};
   else if (measFlag.equals("V"))
     unitArray = new String[]{"l", "ml", "gal"};
      
%>

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

function changeUnit1() {
	recreateList(measConvForm.unit1, unitArray, measConvForm.measFlag.options[measConvForm.measFlag.selectedIndex].value);
}

unitArray = [['km','km','L'],['m','m','L'],['cm','cm','L'],['mm','mm','L'],
	     ['um','um','L'],['mi','mi','L'],['yd','yd','L'],['ft','ft','L'],
	     ['in.','in.','L'],['t','t','W'],['kg','kg','W'],['g','g','W'],
	     ['st','st','W'],['lb','lb','W'],['oz','oz','W'],['l','l','V'],
	     ['ml','ml','V'],['gal','gal','V'],['ml','ml','V']];
</script> 

<html>
<head>
<title>ÎÒµÄÖ½Íø--PaperEC.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
td {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 8pt}
-->
</style>
</head>

<body bgcolor="#FFFFFF">
<form name="measConvForm" method="post" action="huansuanresult.jsp">
  <table width="275" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#E6EDFB">
    <tr> 
      <td align="center" colspan="2"><img src="../../images/images_en/jiliangdanwei.gif" width="275" height="22"></td>
    </tr>
    <tr> 
      <td align="center" colspan="2">Value: 
        <input type="text" name="value1" size="8" value="1.00" >
        Category: 
        <select name="measFlag" onChange="changeUnit1()">
          <option value="L" selected> Length </option>
          <option value="W"> Weight </option>
          <option value="V"> Volume </option>
        </select>
      </td>
    </tr>
    <tr> 
      <td align="center" colspan="2">Unit£º 
        <select name="unit1">
          <option value=01> --N/A-- </option>
        </select>
        <input type="submit" name="Submit" value="Convert">
      </td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <hr>
      </td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <table width="275" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td bgcolor="#B0C8F0" align="right" width="209" height="20">Value</td>
            <td bgcolor="#B0C8F0">&nbsp;</td>
            <td bgcolor="#B0C8F0" width="191" height="20">Unit</td>
          </tr>
<% for (int i=0; i<unitArray.length; i++){
     MeasConv.setUnit2(unitArray[i]);
     boolean b = MeasConv.convert();

     if (i%2==0) {
%>
          <tr> 
            <td bgcolor="#D8E4F8" align="right" width="209" height="20">
            <% if (b){%>
              <%=MeasConv.getValue2()%> 
            <% } else{%>
              *
            <% }%>
            </td>
            <td bgcolor="#D8E4F8">&nbsp;</td>
            <td bgcolor="#D8E4F8" width="191" height="20">
              <%=MeasConv.getUnit2()%> 
            </td>
          </tr>
<%   } else{ %>      
          <tr> 
            <td bgcolor="#B0C8F0" align="right" width="209" height="20">
            <% if (b){%>
              <%=MeasConv.getValue2()%> 
            <% } else{%>
              *
            <% }%>
            </td>
            <td bgcolor="#B0C8F0">&nbsp;</td>
            <td bgcolor="#B0C8F0" width="191" height="20">
              <%=MeasConv.getUnit2()%> 
            </td>
          </tr>
<%   }
   }
%>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

<script>
changeUnit1();
</script>
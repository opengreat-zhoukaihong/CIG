<%--  @# prodInfo.jsp EN Ver.2.0 --%>

<%@ page import="postcenter.*" %>
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />

<jsp:useBean id="ProdInfoPagePara" scope="page" class="postcenter.ProdInfoPagePara" />
<jsp:useBean id="PersonalProd" scope="page" class="postcenter.PersonalProd" />
<jsp:useBean id="CateList" scope="page" class="postcenter.CateList" />
<jsp:useBean id="SpecList" scope="page" class="postcenter.SpecList" />
<jsp:useBean id="BiddingForm" scope="page" class="postcenter.BiddingForm" />

<jsp:setProperty name="ProdInfoPagePara" property="cateId" />
<jsp:setProperty name="ProdInfoPagePara" property="list1" />
<jsp:setProperty name="ProdInfoPagePara" property="langCode" value="EN" />
<jsp:setProperty name="ProdInfoPagePara" property="classFlag" value="E" />
<jsp:setProperty name="ProdInfoPagePara" property="measureFlag" />
<jsp:setProperty name="ProdInfoPagePara" property="complexity" />
<jsp:setProperty name="ProdInfoPagePara" property="productId" />

<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>

<% if ( !(UserInfo.getBuySaleFlag().equals("S"))){%>
	<jsp:forward page="inform.jsp?info=You must become a verified seller,then you may create your product for sale!" />
	</jsp:forward>
<% }%>

<% if ( !(UserInfo.getApproved().equals("Y"))){%>
	<jsp:forward page="inform.jsp?info=You must become a verified seller,then you may create your product for sale!" />
	</jsp:forward>
<% }%>

<%
    boolean editPage = (request.getParameter("editPage")!=null) && (request.getParameter("editPage").equals("true"));

    PersonalProd.setLangCode(ProdInfoPagePara.langCode);
    PersonalProd.setMeasureFlag(ProdInfoPagePara.measureFlag);
    PersonalProd.setProductId(ProdInfoPagePara.productId);
    
    if (PersonalProd.initProduct())
    {
    	ProdInfoPagePara.classFlag = PersonalProd.getClassFlag();

	if ((ProdInfoPagePara.cateId==null)
	    ||(ProdInfoPagePara.cateId.length()==0))
    	{
    	    ProdInfoPagePara.cateId = PersonalProd.getCateId();
    	}
	if ( ProdInfoPagePara.cateId.equals(PersonalProd.getCateId()) )
    	{
    	    ProdInfoPagePara.typeId = PersonalProd.getTypeId();
    	    ProdInfoPagePara.gradeId = PersonalProd.getGradeId();
    	}
    }
//    else
//	ProdInfoPagePara.cateId = PersonalProd.errMsg;
    

    CateList.setLangCode(ProdInfoPagePara.langCode);
    CateList.setClassFlag(ProdInfoPagePara.classFlag);

    SpecList.setLangCode(ProdInfoPagePara.langCode);
    SpecList.setMeasureFlag(ProdInfoPagePara.measureFlag);

    BiddingForm.setLangCode(ProdInfoPagePara.langCode);
    BiddingForm.setMeasureFlag(ProdInfoPagePara.measureFlag);
    BiddingForm.setValidDay("30");

    BiddingForm.init();

    SpecList.cateId = ProdInfoPagePara.cateId;
    Spec[] specItems;
    
    if (PersonalProd.getRealProduct())
    	specItems = PersonalProd.specList.specItems;
    else
    	specItems = SpecList.fetchSpecItems();

    // for Spec Items
    String specIdArray = "";
    String specDispTypeArray = ""; 

    // for Lists    
    String[][] cateList;
    String[][] typeList;
    String[][] gradeList;
    String  cateIdArray = "";
    String  cateNameArray = "";
    String  typeIdArray = "";
    String  typeNameArray = "";
    String  gradeMark = "";
    String  gradeIdArray = "";
    String  gradeNameArray = "";
    
    cateList = CateList.fetchCateList();
    typeList = CateList.fetchTypeList(ProdInfoPagePara.cateId);
%>
<% 
    // init cateIdArray   
    cateIdArray += "[";
    cateNameArray += "[";
    for (int i=0; i<cateList.length; i++)
    {
	if (i !=0) {
    	    cateIdArray +=",";
    	    cateNameArray +=",";
    	}
	cateIdArray += "'" + cateList[i][0] + "'";
	cateNameArray += "'" + cateList[i][1] + "'";	    
    }
    cateIdArray += "]";
    cateNameArray += "]";
    
    // init typeIdArray and typeNameArray
    typeIdArray += "[";
    typeNameArray += "[";
    for (int i=0; i<typeList.length; i++)
    {
    	if (i !=0) {
    	    typeIdArray +=",";
    	    typeNameArray +=",";
    	}
    	typeIdArray += "'" + typeList[i][0] + "'";
    	typeNameArray += "'" + typeList[i][1] + "'";
    }
    typeIdArray += "]";
    typeNameArray += "]";
    
    // init gradeIdArray, gradeMark and gradeNameArray
    gradeMark += "[";
    gradeIdArray += "[";
    gradeNameArray += "[";
    for (int i=0; i<typeList.length; i++)
    {
	gradeList = CateList.fetchGradeList(typeList[i][0]);
	for(int j=0; j<gradeList.length; j++)
	{
	    if ((i !=0)||(j !=0)) {
		gradeMark += ",";
		gradeIdArray +=",";
		gradeNameArray +=",";
	    }
	    gradeMark += "'" + typeList[i][0] + "'";
	    gradeIdArray += "'" + gradeList[j][0] + "'";
	    gradeNameArray += "'" + gradeList[j][1] + "'";
	}
    }
    gradeMark += "]";
    gradeIdArray += "]";
    gradeNameArray += "]";    
    

    // for Spec Items    
    specIdArray += "[";
    specDispTypeArray += "[";
    for(int i=0, kk=0; i<specItems.length; i++) 
    { 
    	if (ProdInfoPagePara.complexity.equals("advance")
	    || (specItems[i].specRequired!=null
  	        && specItems[i].specRequired.equals("Y"))) {
	    
	    if (kk !=0) {
		specIdArray +=",";
		specDispTypeArray += ",";
	    }
	    specIdArray += "'" + specItems[i].specId + "'";
	    if(specItems[i].specValFlag.equals("N")) 
		specDispTypeArray += "'option'";
	    else if (specItems[i].specMinVal.equals(specItems[i].specMaxVal))
		specDispTypeArray += "'single'";
	    else
		specDispTypeArray += "'range'";

	    kk++;
	}
    }
    specIdArray += "]";
    specDispTypeArray += "]";


    // prepare the biding form city array
    String stateArray = "";
    String cityArray = "";
 
    stateArray += "[";
    for(int i=0; i<BiddingForm.stateParas.length; i++) 
    {
    	String stateRecArray = "["; 
	
	stateRecArray += "'" + BiddingForm.stateParas[i][0] + "'";
	stateRecArray += ",'" + BiddingForm.stateParas[i][1] + "'";
	stateRecArray += ",'" + BiddingForm.stateParas[i][2] + "']";

	if (i !=0) {
	    stateArray +=",";
	}
	stateArray += stateRecArray;
    }
    stateArray += "]";
    
    cityArray += "[";
    for(int i=0; i<BiddingForm.cityParas.length; i++) 
    {
    	String cityRecArray = "["; 
	
	cityRecArray += "'" + BiddingForm.cityParas[i][0] + "'";
	cityRecArray += ",'" + BiddingForm.cityParas[i][1] + "'";
	cityRecArray += ",'" + BiddingForm.cityParas[i][2] + "']";

	if (i !=0) {
	    cityArray +=",";
	}
	cityArray += cityRecArray;
    }
    cityArray += "]";
    
%>



<!-- ================ Functons for Building the Tree List  ==================== -->
<script language="JavaScript">

	cateIdArray=<%=cateIdArray%>;
	cateNameArray=<%=cateNameArray%>;

	typeIdArray=<%=typeIdArray%>; 
	typeNameArray=<%=typeNameArray%>;
	gradeIdArray=<%=gradeIdArray%>; 
	gradeMark=<%=gradeMark%>; 
	gradeNameArray=<%=gradeNameArray%>; 

	stateArray = <%=stateArray%>;
	cityArray = <%=cityArray%>;
</script>


<script language=javascript > 

ie=document.all?1:0; netscape=document.layers?1:0;

function ChangeProduct(){
	mf = document.mainInputForm;
	ml = document.mainListForm;
	
	mf.cateId.value = ml.list1.options[ml.list1.selectedIndex].value;
	ml.submit();
}

function recreatePaperProduct() {
	ml = document.mainListForm;
	var cnt=0;

	ml.list2.length=cnt;
	for (i=0;i<cateNameArray.length;i++) {
		ml.list1.length=cnt+1;
		ml.list1.options[cnt].text = cateNameArray[i];
		ml.list1.options[cnt].value = cateIdArray[i];
		cnt++;
	}
}

function recreatePaperTypes() {
	ml = document.mainListForm;
	var cnt=0;

	ml.list2.length=cnt;
	for (i=0;i<typeNameArray.length;i++) {
		ml.list2.length=cnt+1;
		ml.list2.options[cnt].text = typeNameArray[i];
		ml.list2.options[cnt].value = typeIdArray[i];
		cnt++;
	}
}

function recreateGrades(){
	var cnt=0;
 	var types = new Array();
  	var arrayCounter=0;
	ml = document.mainListForm;	

	// using at multiple selection
  	for (k = 0; k < ml.list2.length; k++){
		if (ml.list2[k].selected){
			types[arrayCounter]=ml.list2[k].value;
			arrayCounter++;
		}
	}
	
	// display the List3 items
	ml.list3.length=cnt;
	for (i = 0; i <gradeNameArray.length; i++){
		for (j = 0;j<types.length;j++){
			if (gradeMark[i] == types[j]){
				ml.list3.length=cnt+1;
				ml.list3.options[cnt].text = gradeNameArray[i];
				ml.list3.options[cnt].value = gradeIdArray[i];
				cnt++;
			}
		}
	}
}

function selectProduct(product) {
	ml = document.mainListForm;
	product=product.toString();
	for(var i=0;i<ml.list1.length;i++) {
		if(ml.list1.options[i].value == product) {
			ml.list1.selectedIndex = i;
		}
	}
}

function selectPaperType(paper_type){
	ml = document.mainListForm;
	
	paper_type=paper_type.toString();
	for(var i=0;i<ml.list2.length;i++){
		if(ml.list2.options[i].value == paper_type){
			ml.list2.options[i].selected =1;
		}
	}
}

function selectGrade(grade_id){
	ml = document.mainListForm;

	grade_id=grade_id.toString();
	for(var i=0;i<ml.list3.length;i++){
		if(ml.list3.options[i].value == grade_id ){
			ml.list3.options[i].selected = 1;
		}
	}  
}

function ptrim(not_trim){
	var x; var x1;
	for (x=0;not_trim.charAt(x)==' ';x++){}
	for (x1=not_trim.length-1; not_trim.charAt(x1)==' '; x1--){}
	if (x>x1) 
		return "";
	else
		return not_trim.substring(x,x1+1);
}

</script> 
<!-- ================ End of Functions for Building the Tree List  ========= -->

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

function recreateList2(list, array, key) {
	var cnt= 1;

	list.length=cnt;
	list.options[0].text = "-Select-  ";
	list.options[0].value = "";
	
	for (var i=0;i<array.length;i++) {
	    if (array[i][2]==key) {
		list.length=cnt+1;
		list.options[cnt].text = array[i][1];
		list.options[cnt].value = array[i][0];
		cnt++;
	    }
	}
}

function selectList(list, key){
	for(var i=0;i<list.length;i++){
		if(list.options[i].value == key ){
			list.options[i].selected = 1;
		}
	}  
}
</script> 





<%-- ================ CSS for Display the Items in the page ============== --%>
<style TYPE="text/css"> 
.smalltext {color: black;}   
.optionInput {position:absolute;left: 141;top:0;visibility:visible;border: 0px solid black;vertical-align:bottom;}  
.singleInput {position:absolute;left: 141;top:0;visibility:hidden;border: 0px solid black;vertical-align:bottom;}  
.rangeInput {position:absolute;left: 141;top:0;visibility:hidden;border: 0px solid black;vertical-align:bottom;}   
.label {color: black; text-decoration: none; text-align:right; position:absolute; left: 40px; top:0px; width:100px; height:24px; border: 0px solid black;} 
.unit {color: black; text-decoration: none; text-align:left; position:absolute; left: 210px; top:0px; width:30px; height:38px; border: 0px solid black;} 
</style> 

<style> 
<%for(int i=0, kk=0; i<specItems.length; i++) { %>
  <%if (ProdInfoPagePara.complexity.equals("advance")
  	|| (specItems[i].specRequired!=null 
  	    && specItems[i].specRequired.equals("Y"))) {
       kk++; %>
#container<%=kk%>{position: absolute; left: ; top: ; width: 280; height: 38px;} 
  <%}%>
<%}%>
</style> 
<%-- ================ End of CSS for the Display Items  =================== --%>




<html><!-- #BeginTemplate "/Templates/paperec_templares.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>My Paperec--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.font9 {  font-size: 13px; font-family: "Arial", "Helvetica", "sans-serif"}
.white10 {  font-size: 10pt; color: #FFFFFF; font-family: "Arial", "Helvetica", "sans-serif"}
a:link {  text-decoration: none; color: #000000}
a:visited {  text-decoration: none; color: #000000}
a:active {  text-decoration: none; color: #000000}
a:hover {  color: #330099; text-decoration: underline}
.dan10 {  font-size: 12px; color: #000000; font-family: "Arial", "Helvetica", "sans-serif"}
.big {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 14px}
.list1 {  width: 300px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
</head>

<script language="JavaScript">
function openForeignX(url){   
        OpenWindow=window.open(url, "foreignXwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,resizable=no,menubar=no,width=142,height=230");
}

function openMeasConv(url){   
        OpenWindow=window.open(url, "measConvwin", "location=no,directories=no,status=no,toolbar=no,scrollbars=no,menubar=no,width=300,height=300");
}
</script> 

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr>
    <td width="159"> 
    <script language="JavaScript" src="../../../javascript/caidan.js">
</script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
               <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../../images/images_en/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="product_list.jsp" class="font9"><font color="#000000">Offer to Sell</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="request2buy.jsp"><font color="#000000">Request to Buy</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="order_search.jsp"><font color="#000000">Browse Trading Floor</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">My Customers</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="product_list.jsp"><font color="#000000">My ProductProfiler</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">Search by ID#</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="Go">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#" onClick="openForeignX('../foreignX.htm')"><font color="#FFFFFF">Currency Converter</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="../jiaoyifu.htm"><font color="#FFFFFF">Services</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#" onClick="openMeasConv('../huansuanresult.jsp')"><font color="#FFFFFF">Metric Converter</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../../../images/images_en/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </td>
    <td valign="top"><!-- #BeginEditable "body" -->

        <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#CCCCFF">
          <tr bordercolor="#FFFFFF"> 
            <td > 
              <table width="600" border="0" cellspacing="0" cellpadding="2" bgcolor="#E6EDFB">
                <tr> 
                  <td colspan="2" height="25" bgcolor="#4078E0"><font color="#FFFFFF" class="big"><b>My Product Profiler 
                    </b> </font></td>
                </tr>
            <form name="mainListForm" method="post" action="prodInfo.jsp">
		<input type="HIDDEN" name="productId" value="<%=ProdInfoPagePara.productId%>">
                <tr bgcolor="#7EA2EB"> 
                  <td class="big" align="center" colspan="2"><font color="#FFFFFF"><b>Product</b></font></td>
                </tr>
                <tr> 
                  <td colspan="2" align="center" class="dan10"> 
                    <select name="list1" size="7" class="list1" ONCHANGE=<%if (!editPage){%>"ChangeProduct();"<%}else{%>"javascript: alert('Can not change!'); selectProduct(document.mainInputForm.cateId.value);" <%}%>>
                      <option>Product Specification</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="184" align="center" bgcolor="#7EA2EB"><font color="#FFFFFF"><b>Type</b></font></td>
                  <td width="184" align="center" bgcolor="#7EA2EB"><font color="#FFFFFF"><b>Grade</b></font></td>
                </tr>
                <tr> 
                  <td width="184" align="center" class="dan10"> 
                    <select name="list2" size="7" class="list1" ONCHANGE=<%if (!editPage){%>"recreateGrades();"<%}else{%>"javascript: alert('Can not change!'); selectPaperType(document.mainInputForm.typeId.value);" <%}%>>
                      <option>Product Specification</option>
                    </select>
                  </td>
                  <td width="184" align="center" class="dan10"> 
                    <select name="list3" size="7" class="list1" ONCHANGE=<%if (editPage){%>"javascript: alert('Can not change!'); selectGrade(document.mainInputForm.gradeId.value);" <%}%>>
                      <option>Product Specification</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" class="dan10" align="center" bgcolor="#E6EDFB"> 
                    <input type="radio" name="complexity" value="simple"
                      onClick="javascript:this.form.submit()"
                      <%if(ProdInfoPagePara.complexity.equals("simple")){%> checked <%}%>>
                    Simple 
                    <input type="radio" name="complexity" value="advance"
                      onClick="javascript:this.form.submit()"
                      <%if(!ProdInfoPagePara.complexity.equals("simple")){%> checked <%}%>>
                    Advanced <img src="../../../images/images_en/space.gif" width="80" height="1"> 
                    <input type="radio" name="measureFlag" value="M"
                      onClick="javascript:this.form.submit()"
                      <%if(!ProdInfoPagePara.measureFlag.equals("I")){%> checked <%}%>>
                    Metric 
                    <input type="radio" name="measureFlag" value="I"
                      onClick="javascript:this.form.submit();"
                      <%if(ProdInfoPagePara.measureFlag.equals("I")){%> checked <%}%>>
                    Imperial </td>
                </tr>
            </form>
                <tr> 
                  <td colspan="2" class="dan10" align="center" bgcolor="#E6EDFB" height="40"> 
                    Click on the specification name to switch between entering a single value and a range of values.
                  </td>
                </tr>


<form name="mainSpecForm" method="POST">
<%for(int i=0, kk=0; i<specItems.length; i++) { %>
  <%if (ProdInfoPagePara.complexity.equals("advance")
  	|| (specItems[i].specRequired!=null
  	    && specItems[i].specRequired.equals("Y"))) {
       kk++; %>
    <%if ((kk%2)==1){%>
                      <tr bgcolor="#E6EDFB" height="40">
    <%}%>
                        <td class="dan10">
    <%if(!specItems[i].specValFlag.equals("N")){%>
<span> <div id="container<%=kk%>" class="dan10"> <div id="label_Spec<%=specItems[i].specId%>" class="label" align="LEFT"> <a tabindex="0" href="javascript:changeActive(<%=kk%>)"><%=specItems[i].specName%></a></div> 
<div id="single_input_Spec<%=specItems[i].specId%>" class="singleInput"> <input type="TEXT" size="7" name="input_single_Spec<%=specItems[i].specId%>" onBlur="validField(this)" value=<%=specItems[i].specMinVal%>> </div> 
<div id="range_input_Spec<%=specItems[i].specId%>" class="rangeInput"> <input type="TEXT" size="2" name="input_min_Spec<%=specItems[i].specId%>" onBlur="validField(this)" value=<%=specItems[i].specMinVal%>><span class="smalltext">to</span><input type="TEXT" size="2" name="input_max_Spec<%=specItems[i].specId%>" onBlur="validField(this)" value=<%=specItems[i].specMaxVal%>> </div> 
<div id="unit" class="unit"> <%=specItems[i].specUnit%> </div> </div> </span> 
    <%}else{%>
<span> <div id="container<%=kk%>" class="dan10"> <div id="label_Spec<%=specItems[i].specId%>" class="label" align="LEFT"><%=specItems[i].specName%></div> 
<div id="option_input_Spec<%=specItems[i].specId%>" class="optionInput"> 
<select name="input_option_Spec<%=specItems[i].specId%>" onChange=""> class="smalltext"><option value="">-Select- &nbsp;&nbsp;&nbsp;&nbsp;</option>
<%for(int j=0; j<specItems[i].specParas.length; j++){%><option value="<%=specItems[i].specParas[j][0]%>" <%if(specItems[i].specParas[j][0].equals(specItems[i].specParaId)){%>Selected<%}%>><%=specItems[i].specParas[j][1]%></option><%}%>
</select> </div> 
<div id="range_input_Spec<%=specItems[i].specId%>"> </div> </div> </span> 
    <%}%>
                        </td>
    <%if ((kk%2)==0){%>
                      </tr>
    <%}%>
  <%}%>
<%}%>
<INPUT TYPE="HIDDEN" NAME="type_Spec" value="">
</form>

                <tr bgcolor="#E6EDFB"> 
                  <td colspan="2" height="26">&nbsp; </td>
                </tr>

<!-- ====== Define the Form, the important things ============= -->
<form id="mainInputForm" name="mainInputForm" action="prodInfoTest.jsp" method="POST">

<% for(int i=0; i<specItems.length; i++) {%>
  <%if (ProdInfoPagePara.complexity.equals("advance")
  	|| (specItems[i].specRequired!=null
  	    && specItems[i].specRequired.equals("Y"))) {%>
    <% if(specItems[i].specValFlag.equals("N")) {%>
<INPUT TYPE="HIDDEN" NAME="input_option_Spec<%=specItems[i].specId%>">
    <%}else{%>
<INPUT TYPE="HIDDEN" NAME="input_min_Spec<%=specItems[i].specId%>">
<INPUT TYPE="HIDDEN" NAME="input_max_Spec<%=specItems[i].specId%>">
    <%}%>
  <%}%>
<%}%>

<input type="HIDDEN" name="complexity" value="<%=ProdInfoPagePara.complexity%>">
<input type="HIDDEN" name="measureFlag" value="<%=ProdInfoPagePara.measureFlag%>"> 
<input type="HIDDEN" name="langCode" value="EN"> 

<input type="HIDDEN" name="cateId" value="<%=ProdInfoPagePara.cateId%>">
<input type="HIDDEN" name="typeId" value="<%=ProdInfoPagePara.typeId%>">
<input type="HIDDEN" name="gradeId" value="<%=ProdInfoPagePara.gradeId%>">
<input type="HIDDEN" name="productId" value="<%=ProdInfoPagePara.productId%>">

<!--</form>-->
<!-- ============== End of mainInputForm =================== -->

                <tr bgcolor="#E6EDFB" height="40">
                  <td colspan="2" class="dan10" bgcolor="#E6EDFB"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    Product Name: 
                    <input type="text" name="productName" size="10" value=<%=PersonalProd.productName%>> &nbsp;
                    Brand: 
                    <select name="brandId">
                       <option value="">-Select- &nbsp;</option>
		    <% for(int i=0; i<BiddingForm.brandParas.length; i++){%>
                       <option value=<%=BiddingForm.brandParas[i][0]%> <%if(BiddingForm.brandParas[i][0].equals(PersonalProd.brandId)){%>Selected<%}%>><%=BiddingForm.brandParas[i][1]%></option>
		    <%}%>
                    </select>&nbsp;
                    New Brand: 
                    <input type="text" name="brandDesc" size="8" value=<%=PersonalProd.brandDesc%>>
                  </td>
                </tr>
                <tr bgcolor="#E6EDFB">
                  <td colspan="2" class="dan10" bgcolor="#E6EDFB"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    ĦĦĦĦLocation: 
                    <select name="prodCounId" onChange="recreateList2(this.form.prodStateId, stateArray, this.options[this.selectedIndex].value); recreateList2(this.form.prodCityId, cityArray, this.form.prodStateId.options[this.form.prodStateId.selectedIndex].value);">
                       <option value="">-Select- &nbsp;</option>
		    <% for(int i=0; i<BiddingForm.countryParas.length; i++){%>
                       <option value=<%=BiddingForm.countryParas[i][0]%> <%if(BiddingForm.countryParas[i][0].equals(PersonalProd.prodCounId)){%>Selected<%}%>><%=BiddingForm.countryParas[i][1]%></option>
		    <%}%>
                    </select>
                    <select name="prodStateId" onChange="recreateList2(this.form.prodCityId, cityArray, this.options[this.selectedIndex].value)">
                       <option value="">--N/A--</option>
                    </select>
                    <select name="prodCityId">
                       <option value="">--N/A--</option>
                    </select>&nbsp;
                  </td>
                </tr>
                <tr bgcolor="#E6EDFB"> 
                  <td colspan="3" height="26">&nbsp; </td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                  <td colspan="3" class="big" height="25"> <font color="#FFFFFF"><b> 
                    <input type="button" name="Submit2" value="Submit" onClick="javascript:submitPage()">
                    <img src="../../../images/images_en/space.gif" width="100" height="1"> 
                    <input type="button" name="Submit2" value="Reset" onClick="javascript:document.mainSpecForm.reset();">
                    </b></font></td>
                </tr>
              </table>
            </td>
          </tr>
          </form>
        </table>
        <div align="center"></div>
      <!-- #EndEditable --> 
    </td>
  </tr>
</table>
<table width="776" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="776" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../../images/images_en/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../../images/images_en/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>





<!-- ====== Define the specIdArray and spec ============= -->
<script language="JavaScript">
	specIdArray=<%=specIdArray%>;
	specDispTypeArray=<%=specDispTypeArray%>;
</script>



<!-- ============== Init the three List ================= -->		
<script language="JAVASCRIPT">
	recreatePaperProduct();
	selectProduct(document.mainInputForm.cateId.value);

	recreatePaperTypes();
	selectPaperType(document.mainInputForm.typeId.value);

	recreateGrades();
	selectGrade(document.mainInputForm.gradeId.value);
</script>
<!-- ============== End of Init the three List ================= -->		




<!-- ============== Init the Spec Items Position  ========================= -->		
<script language="JavaScript"> 
	ie=document.all?1:0; netscape=document.layers?1:0; visible=ie?'visible':'show'; hidden=ie?'hidden':'hide';     
	if(!window.px_iw) {
		window.onresize = stopit; window.px_ih = window.innerHeight; window.px_iw = window.innerWidth;
	}        

function stopit() {
	if (px_iw < window.innerWidth || px_ih < window.innerHeight || px_iw > window.innerWidth || px_ih > window.innerHeight){ window.history.go(0); }
}     /*  :: end of netscape resized window fix */ 

function makeAttr(obj,nest) { 
	this.css=(netscape) ? eval('document.'+nest+'.'+obj):eval('document.all.'+obj+'.style'); 
	return this; 
} 

function attrInit()  { 
	var ms=document.mainSpecForm;
	var attr1, attr2;

	if (ms.type_Spec.value != "")
		specDispTypeArray = ms.type_Spec.value.split(",");

	for (var i=0; i<specIdArray.length; i++) 
	{
		if( specDispTypeArray[i] == 'single') { 
			attr1 = new makeAttr('single_input_Spec'+specIdArray[i], 'container'+(i+1)); 
			attr1.css.visibility='visible';
		} 
		else if( specDispTypeArray[i] == 'range') { 
			attr2 = new makeAttr('range_input_Spec'+specIdArray[i], 'container'+(i+1)); 
			attr2.css.visibility='visible';
		} 
	}
} 

function changeActive(kk)  { 
	attr1 = new makeAttr('single_input_Spec'+specIdArray[kk-1], 'container'+(kk)); 
	attr2 = new makeAttr('range_input_Spec'+specIdArray[kk-1], 'container'+(kk)); 

	if (attr1.css.visibility=='visible') { 
		specDispTypeArray[kk-1] = 'range'; 
		attr1.css.visibility = 'hidden';
		attr2.css.visibility = 'visible';
	} else { 
		specDispTypeArray[kk-1] = 'single'; 
		attr1.css.visibility = 'visible';
		attr2.css.visibility = 'hidden';
	}
} 

function recordValue(formElementName,formElementValue) { 
	document.mainInputForm.elements[formElementName].value=formElementValue; 
} 

attrInit();
</script>


<script language="JavaScript"> 
var tmpVal;
tmpVal = "";
if (mainInputForm.prodCounId.selectedIndex >=0) {
  tmpVal = mainInputForm.prodCounId.options[mainInputForm.prodCounId.selectedIndex].value; 
}
recreateList2(mainInputForm.prodStateId, stateArray, tmpVal);
selectList(mainInputForm.prodStateId, '<%=PersonalProd.prodStateId%>');

tmpVal = "";
if (mainInputForm.prodStateId.selectedIndex >=0) {
  tmpVal = mainInputForm.prodStateId.options[mainInputForm.prodStateId.selectedIndex].value; 
}
recreateList2(mainInputForm.prodCityId, cityArray, tmpVal);
selectList(mainInputForm.prodCityId, '<%=PersonalProd.prodCityId%>');
</script>
<!-- ============== End of Init the Spec Items Position  ================== -->		
	



<!-- ============== SubmitPage function Define ========================= -->		
<script language="JavaScript"> 
function validPage(){
	var mf=document.mainInputForm;

	if ( mf.cateId.value == "") {
		alert("Please Select Product Category!");
		return false;
	}
	if ( mf.typeId.value == "") {
		alert("Please Select Product Type!");
		return false;
	}
	if ( mf.gradeId.value == "") {
		alert("Please Select Product Grade!");
		return false;
	}

	return true;
}

function submitPage(){
	var mf=document.mainInputForm;
	var ml=document.mainListForm;
	var ms=document.mainSpecForm;

	for (var i=0; i<specIdArray.length; i++)
	{
		optionValueName='input_option_Spec'+specIdArray[i];
		singleValueName='input_single_Spec'+specIdArray[i];
		minValueName='input_min_Spec'+specIdArray[i];
		maxValueName='input_max_Spec'+specIdArray[i];

		if( specDispTypeArray[i] == 'option')
		{
			mf.elements[optionValueName].value =
				ms.elements[optionValueName].options[ms.elements[optionValueName].selectedIndex].value;
		} 
		else if( specDispTypeArray[i] == 'single')
		{
			mf.elements[minValueName].value =
				ptrim( ms.elements[singleValueName].value);
			mf.elements[maxValueName].value =
				ptrim( ms.elements[singleValueName].value);
		} 
		else 
		{
			mf.elements[minValueName].value =
				ptrim( ms.elements[minValueName].value);
			mf.elements[maxValueName].value =
				ptrim( ms.elements[maxValueName].value);
		}
	}
	
	for (var i=0; i<ml.complexity.length; i++) {
		if ( ml.complexity[i].checked) 
			mf.complexity.value = ml.complexity[i].value;
	}
	for (var i=0; i<ml.measureFlag.length; i++) {
		if ( ml.measureFlag[i].checked) 
			mf.measureFlag.value = ml.measureFlag[i].value;
	}

	if ( ml.list1.selectedIndex >= 0)
		mf.cateId.value = ml.list1.options[ml.list1.selectedIndex].value;
	if ( ml.list2.selectedIndex >= 0)
		mf.typeId.value = ml.list2.options[ml.list2.selectedIndex].value;
	if ( ml.list3.selectedIndex >= 0)
		mf.gradeId.value = ml.list3.options[ml.list3.selectedIndex].value;
	
	ms.type_Spec.value = specDispTypeArray.join(",");
	
	if ( validPage())
		mf.submit();
}
</script>

<script language="JavaScript"> 
function CheckNumber(object_value) { 
	var GoodChars = "0123456789"; 
	var firstChar = object_value.charAt(0);
	var numberStr = object_value;
 	var array = new Array();
	var i = 0; 

	if (firstChar=='+'|| firstChar=='-')
	    numberStr = object_value.substring(1, object_value.length);
	
	array = numberStr.split(".");
	if (array.length ==1){
	    if (array[0].length ==0)
		return false;
	}
	else if (array.length >2){
	    return false;
	}
	for (i=0; i< array.length; i++) {
	    for (var j=0; j< array[i].length; j++) { 
		if (GoodChars.indexOf(array[i].charAt(j)) == -1) { 
		    return false; 
		}
	    } 
	} 
	return true; 
} 

function validField(object){
	var value = ptrim(object.value);
	if (value !="")
	{
	    if ( !CheckNumber(value))
	    {
	    	alert("Illegal Vaule Entered, Please Check!");
	        object.focus();
	    }
	}
}
</script>

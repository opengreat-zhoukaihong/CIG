<%--  @# bidPage.jsp Ver.1.2 --%>

<%@ page import="postcenter.*" %>
<jsp:useBean id="price" scope="page" class="postcenter.ReleasQP" />
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
<%   String posting_id=request.getParameter("posting_id");
     String lang_code=request.getParameter("lang_code");
     String user_id=request.getParameter("user_id"); 
     String tobid_id=request.getParameter("tobid_id");
     String tobiduser_id=request.getParameter("tobiduser_id"); 
     String bid_own=request.getParameter("bid_own");         %>  


<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />

<jsp:useBean id="BiddingForm" scope="page" class="postcenter.BiddingForm" />

<jsp:setProperty name="BiddingForm" property="langCode" value="EN" />
<jsp:setProperty name="BiddingForm" property="measureFlag" value="M" />
<jsp:setProperty name="BiddingForm" property="validDay" value="30" />

<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>


<%
    BiddingForm.init();

%>
<%         
    
    // prepare the biding form city array
    String stateArray = "";
    String cityArray = "";
    String bidPayCondArray = "";
    String  priceCondArray = "";
    String  payMethArray = "";
 
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
    
    int totalCnt=0;
    bidPayCondArray += "[";
    for(int i=0; i<BiddingForm.checkKindParas.length; i++) 
    {
    	String payCondRecArray = "["; 
	
	payCondRecArray += "'" + BiddingForm.checkKindParas[i][0] + "'";
	payCondRecArray += ",'" + BiddingForm.checkKindParas[i][1] + "'";
	payCondRecArray += ",'HP']";

	if (totalCnt !=0) {
	    bidPayCondArray +=",";
	}
	bidPayCondArray += payCondRecArray;
	totalCnt++;
    }
    for(int i=0; i<BiddingForm.lofcKindParas.length; i++) 
    {
    	String payCondRecArray = "["; 
	
	payCondRecArray += "'" + BiddingForm.lofcKindParas[i][0] + "'";
	payCondRecArray += ",'" + BiddingForm.lofcKindParas[i][1] + "'";
	payCondRecArray += ",'XYZ']";

	if (totalCnt !=0) {
	    bidPayCondArray +=",";
	}
	bidPayCondArray += payCondRecArray;
	totalCnt++;
    }
    bidPayCondArray += "]";
    
    priceCondArray += "[";
    for(int i=0; i<BiddingForm.priceCondParas.length; i++) 
    {
    	String priceCondRecArray = "["; 
	
	priceCondRecArray += "'" + BiddingForm.priceCondParas[i][0] + "'";
	priceCondRecArray += ",'" + BiddingForm.priceCondParas[i][1] + "'";
	if (BiddingForm.priceCondParas[i][0].equals("EXD")
	    || BiddingForm.priceCondParas[i][0].equals("EXW"))
	    priceCondRecArray += ",'RMB']";
	else
	    priceCondRecArray += ",'USD']";

	if (i !=0) {
	    priceCondArray +=",";
	}
	priceCondArray += priceCondRecArray;
    }
    priceCondArray += "]";
    
    payMethArray += "[";
    for(int i=0; i<BiddingForm.payMethParas.length; i++) 
    {
    	String payMethRecArray = "["; 
	
	payMethRecArray += "'" + BiddingForm.payMethParas[i][0] + "'";
	payMethRecArray += ",'" + BiddingForm.payMethParas[i][1] + "'";
	if (BiddingForm.payMethParas[i][0].equals("XYZ"))
	    payMethRecArray += ",'USD']";
	else
	    payMethRecArray += ",'RMB']";

	if (i !=0) {
	    payMethArray +=",";
	}
	payMethArray += payMethRecArray;
    }
    payMethArray += "]";
        
%>



<!-- ================ Functons for Building the Tree List  ==================== -->
<script language="JavaScript">

	stateArray = <%=stateArray%>;
	cityArray = <%=cityArray%>;

	payMethArray =<%=payMethArray%>;
	bidPayCondArray = <%=bidPayCondArray%>;
	priceCondArray =<%=priceCondArray%>;

</script>


<script language=javascript > 
ie=document.all?1:0; netscape=document.layers?1:0;

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
</script> 





<%-- ================ CSS for Display the Items in the page ============== --%>
<style> 
#cont_bid_sum{position: absolute; left: ; top: ;}
#cont_bid_sum1{position: absolute; left: ; top: 6; width:160px;}
#cont_port_prompt1{position: absolute; left: ; top: 6; width:60px;}
#cont_port_prompt2{position: absolute; left: ; top: 6; width:60px;}
#cont_city_prompt1{position: absolute; left: ; top: 6; width:60px;}
#cont_city_prompt2{position: absolute; left: ; top: 6; width:60px;}
#cont_bid_city{position: absolute; left: ; top: ; } 
#cont_bid_port{position: absolute; left: ; top: ; visibility:hidden;} 
</style> 
<%-- ================ End of CSS for the Display Items  =================== --%>




<html><!-- #BeginTemplate "/Templates/paperec_templares.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=en_us">
<style type="text/css">
<!--
.font10 {  font-size: 12px; line-height: 14pt; color: #000000}
.font9 {  font-size: 14px}
.white10 {  font-size: 10pt; color: #FFFFFF}
a:link {  text-decoration: none; color: #000000; font-family: "宋体"}
a:visited {  text-decoration: none; color: #000000; font-family: "宋体"}
a:active {  text-decoration: none; color: #000000; font-family: "宋体"}
a:hover {  color: #330099; text-decoration: underline; font-family: "宋体"}
.dan10 {  font-size: 12px; color: #000000}
.big {  font-family: "宋体"; font-size: 14px}
.list1 {  width: 195px; clip:  rect(   )}
.list2 {  width: 172px; clip:    rect(   )}
-->
</style>
</head>
<% if(!lang_code.equals("none")){          
      price.setPostingid(posting_id);     price.setLangcode(lang_code);
       price.setUserid(user_id);          price.setBid_own(bid_own);
       String st[]=price.getAllResult();
       float fla=Float.valueOf(st[0]).floatValue()*Float.valueOf(st[2]).floatValue(); 
           %>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 


       
              <table width="600" border="0" cellspacing="0" cellpadding="2" bgcolor="#E6EDFB">
               <form id="mainInputForm" name="mainInputForm" action="quote.jsp" method="POST">
                <tr valign="top"> 
              
		<input type="HIDDEN" name="langCode" value="GB"> 
		
                  <td colspan="3" bgcolor="#E6EDFB"> 
                    <table width="600" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><img src="../images/keyijiaxx.gif" width="127" height="26"></td>
                      </tr>
                      <tr>
                        <td>
                          <table width="600" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left">
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">amount： 
                                <input type="text" name="bid_quantity" size="12" onBlur="validField(this); calculateSum();" value=<%=st[0]%>>
                                unit： 
                                <select name="bid_unit">
                                
                          <% for(int i=0; i<BiddingForm.unitParas.length; i++){
				        if(BiddingForm.unitParas[i].equals(st[1])){   %>
				         <option value=<%=BiddingForm.unitParas[i]%> selected><%=BiddingForm.unitParas[i]%></option>              
				     <%   }else {          %>
                                  <option value=<%=BiddingForm.unitParas[i]%>><%=BiddingForm.unitParas[i]%></option>
				<%        }     }       %>      
                             
                                </select>
                              </td>
                              <td class="dan10" height="22">quote price： 
                                <input type="text" name="bid_price" size="12" onBlur="validField(this); calculateSum();" value=<%=st[2]%>>
                                currency： 
                                <select name="bid_currency" onChange="currencyChanged();">
				<% for(int i=0; i<BiddingForm.currencyParas.length; i++){
				         if(BiddingForm.currencyParas[i][0].equals(st[3])){                    %>
				             <option value=<%=BiddingForm.currencyParas[i][0]%> selected><%=BiddingForm.currencyParas[i][1]%></option>
				     <%   }else {          %>
                                  <option value=<%=BiddingForm.currencyParas[i][0]%>><%=BiddingForm.currencyParas[i][1]%></option>
				<%         }         }    %>
                                </select>
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22" colspan="2">price condition： 
                                <select name="bid_priceCond" onChange="changeBidVisible()">
				<% for(int i=0; i<BiddingForm.priceCondParas.length; i++){
				          if(BiddingForm.priceCondParas[i][0].equals(st[4])){   %>
				         <option value=<%=BiddingForm.priceCondParas[i][0]%> selected><%=BiddingForm.priceCondParas[i][1]%></option> 
				     <%   }else {          %>     
                                  <option value=<%=BiddingForm.priceCondParas[i][0]%>><%=BiddingForm.priceCondParas[i][1]%></option>
				<%         }      } %>
                                </select>
                                &nbsp;
                                <div id="cont_bid_port" class="dan10">
                                  <div id="cont_port_prompt1" class="dan10">
                                  ship port： 
                                  </div> 
                                  <div id="cont_port_prompt2" class="dan10">
                                  dest port： 
                                  </div> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;
                                <select name="bid_destPortId">
                                <% for(int i=0; i<BiddingForm.portParas.length; i++){
				       if(BiddingForm.portParas[i][0].equals(st[6])){%>
				  <option value=<%=BiddingForm.portParas[i][0]%> selected><%=BiddingForm.portParas[i][1]%></option>
				         <%  }else{   %> 
                                  <option value=<%=BiddingForm.portParas[i][0]%>><%=BiddingForm.portParas[i][1]%></option>
				<%      }  }%>                                
                              
                                </select>
                                </div> 
                                <div id="cont_bid_city" class="dan10">
                                  <div id="cont_city_prompt1" class="dan10">
                                  delivery location： 
                                  </div> 
                                  <div id="cont_city_prompt2" class="dan10">
                                  stowage location： 
                                  </div> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;
                                <select name="bid_destStateId" onChange="recreateList(this.form.bid_destCityId, cityArray, this.options[this.selectedIndex].value)">
                                  <option value="">N/A</option>
                                </select>
                                <select name="bid_destCityId">
                                  <option value="">N/A</option>
                                </select>
                                </div> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <div id="cont_bid_sum" class="dan10">
                                  <div id="cont_bid_sum1" class="dan10">
                                  合同总金额：0 
                                  </div> 
                                </div> 
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">
                                payment method： 
                                <select name="bid_payMeth" onChange="payMethChanged()">
                                <option selected value="">--N/A--</option>
                                </select>
                              </td>
                              <td class="dan10" height="22">
                                <div id="cont_bid_payCond" class="dan10">
                                payment term： 
                                <select name="bid_payCond">
                                  <option selected value="">--N/A--</option>
                                </select>
                                </div>
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB">
                              <td class="dan10" height="22" width="291">
                                <div id="cont_bid_deliMeth" class="dan10">
                                delivery method：
                                <select name="bid_deliMeth">
                                 <% for(int i=0; i<BiddingForm.deliMethParas.length; i++){
				       if(BiddingForm.deliMethParas[i][0].equals(st[5])){%>
				  <option value=<%=BiddingForm.deliMethParas[i][0]%> selected><%=BiddingForm.deliMethParas[i][1]%></option>
				         <%  }else{   %> 
                                  <option value=<%=BiddingForm.portParas[i][0]%>><%=BiddingForm.deliMethParas[i][1]%></option>
				<%      }  }%>          
				
                                </select>
                                </div> 
                              </td>
                              <td class="dan10" height="22" width="301" bgcolor="#E6EDFB">delivery date：
                                <input type="text" name="bid_deliShipDate" size="12" value=<%=st[13]%>>
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22" width="291">quote begin time： 
                                <input type="text" name="bid_beTime" size="12" value="<%=st[11]%>" onBlur="validDateField(this)">
                              </td>
                              <td class="dan10" height="22" width="301" bgcolor="#E6EDFB">报价到期时间： 
                                <input type="text" name="bid_enTime" size="12" value="<%=st[12]%>" onBlur="validDateField(this)">
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr bgcolor="#E6EDFB" align="center"> 
                 <td colspan="3" class="big" height="25"> <font color="#FFFFFF"><b>
                    <input type="hidden" name="lang_code" value="none">
                    <input type="hidden" name="user_id" value="<%=user_id%>" >                    
                    <input type="hidden" name="posting_id" value="<%=posting_id%>">
                    <input type="hidden" name="tobid_id" value="<%=tobid_id%>" > 
                     <input type="hidden" name="bid_own" value="<%=bid_own%>" >                    
                    <input type="hidden" name="tobiduser_id" value="<%=tobiduser_id%>">
                    <input type="button" name="Submit2" value="submit" onClick="javascript:submitPage()">
                    <img src="../images/space.gif" width="100" height="1"> 
                    <input type="button" name="Submit2" value="reset" onClick="javascript:document.mainSpecForm.reset();">
                    </b></font></td>
                 
                </tr>
               </form>
              </table>
          
        <div align="center"></div>
      <!-- #EndEditable -->  

</body>
<!-- #EndTemplate --></html>





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

</script>


<script language="JavaScript"> 
function calculateSum() {
	var mf=document.mainInputForm;
	var sumVal = mf.bid_quantity.value * mf.bid_price.value; 

	document.all.cont_bid_sum1.innerHTML='合同总金额：'+sumVal;
}

function changeBidVisible() {
	var mf=document.mainInputForm;
	var priceCondVal = mf.bid_priceCond.options[mf.bid_priceCond.selectedIndex].value; 
	var attr;

	if ((priceCondVal == 'EXW')||(priceCondVal == 'EXD')) {
		attr = new makeAttr('cont_bid_port', ''); 
		attr.css.visibility='hidden';
		attr = new makeAttr('cont_bid_city', ''); 
		attr.css.visibility='visible';
		attr = new makeAttr('cont_port_prompt1', ''); 
		attr.css.visibility='hidden';
		attr = new makeAttr('cont_port_prompt2', ''); 
		attr.css.visibility='hidden';
		if( priceCondVal == 'EXW') {
		    attr = new makeAttr('cont_city_prompt1', ''); 
		    attr.css.visibility='visible';
		    attr = new makeAttr('cont_city_prompt2', ''); 
		    attr.css.visibility='hidden';
		}
		else {
		    attr = new makeAttr('cont_city_prompt1', ''); 
		    attr.css.visibility='hidden';
		    attr = new makeAttr('cont_city_prompt2', ''); 
		    attr.css.visibility='visible';
		}
	} 
	else {
		attr = new makeAttr('cont_bid_port', ''); 
		attr.css.visibility='visible';
		attr = new makeAttr('cont_bid_city', ''); 
		attr.css.visibility='hidden';
		attr = new makeAttr('cont_city_prompt1', ''); 
		attr.css.visibility='hidden';
		attr = new makeAttr('cont_city_prompt2', ''); 
		attr.css.visibility='hidden';
		if( priceCondVal == 'FOB') {
		    attr = new makeAttr('cont_port_prompt1', ''); 
		    attr.css.visibility='visible';
		    attr = new makeAttr('cont_port_prompt2', ''); 
		    attr.css.visibility='hidden';
		}
		else {
		    attr = new makeAttr('cont_port_prompt1', ''); 
		    attr.css.visibility='hidden';
		    attr = new makeAttr('cont_port_prompt2', ''); 
		    attr.css.visibility='visible';
		}
	} 
}

function changePriceCond() {
	recreateList(mainInputForm.bid_priceCond, priceCondArray, mainInputForm.bid_currency.options[mainInputForm.bid_currency.selectedIndex].value);
	changeBidVisible();
}

function changePayMeth() {
	recreateList(mainInputForm.bid_payMeth, payMethArray, mainInputForm.bid_currency.options[mainInputForm.bid_currency.selectedIndex].value);
}

function currencyChanged() {
	var mf=document.mainInputForm;
	var currencyVal = mf.bid_currency.options[mf.bid_currency.selectedIndex].value; 
	var attr;

	changePriceCond();
	changePayMeth();
	payMethChanged();

	if (currencyVal == 'USD') {
		attr = new makeAttr('cont_bid_deliMeth', ''); 
		attr.css.visibility='hidden';
	} 
	else {
		attr = new makeAttr('cont_bid_deliMeth', ''); 
		attr.css.visibility='visible';
	} 	
}

function payMethChanged() {
	var mf=document.mainInputForm;
	var payMethVal = mf.bid_payMeth.options[mf.bid_payMeth.selectedIndex].value; 
	var attr;
	
	recreateList(mainInputForm.bid_payCond, bidPayCondArray, mainInputForm.bid_payMeth.options[mainInputForm.bid_payMeth.selectedIndex].value);

	if ((payMethVal == 'HP')||(payMethVal == 'XYZ')) {
		attr = new makeAttr('cont_bid_payCond', ''); 
		attr.css.visibility='visible';
	}
	else {
		attr = new makeAttr('cont_bid_payCond', ''); 
		attr.css.visibility='hidden';
	}
}

currencyChanged();

recreateList(mainInputForm.bid_destStateId, stateArray, mainInputForm.langCode.value=="EN"?"2":"1");
recreateList(mainInputForm.bid_destCityId, cityArray, mainInputForm.bid_destStateId.options[mainInputForm.bid_destStateId.selectedIndex].value);

calculateSum();
</script>
<!-- ============== End of Init the Spec Items Position  ================== -->		
	



<!-- ============== SubmitPage function Define ========================= -->		
<script language="JavaScript"> 
function validPage(){
	var mf=document.mainInputForm;

	return true;
}

function submitPage(){
	var mf=document.mainInputForm;
		
	if ( validPage())
		mf.submit();
}
</script>

<script language="JavaScript"> 
function CheckInteger(object_value) { 
	var GoodChars = "0123456789"; 
	var i = 0; 
	for (i=0; i<= object_value.length -1; i++) { 
	    if (GoodChars.indexOf(object_value.charAt(i)) == -1) { 
		return false; 
	    } 
	} 
	return true; 
} 

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

function CheckDate(object_value) { 
 	var array = new Array();
	
	array = object_value.split("-");
	if (array.length !=3){
	    return false;
	}
	if (!CheckInteger(array[0]))
	    return false;
	if (!CheckInteger(array[1]))
	    return false;
	if (!CheckInteger(array[2]))
	    return false;
	if ( eval(array[0])<2000 ||eval(array[0])>9999)
	    return false;
	if ( eval(array[1])<1 ||eval(array[1])>12)
	    return false;
	if ( eval(array[2])<1 ||eval(array[2])>31)
	    return false;
	    
	return true; 
} 

function validField(object){
	var value = ptrim(object.value);
	if (value !="")
	{
	    if ( !CheckNumber(value))
	    {
	    	alert("输入值非法,请核实!");
	        object.focus();
	    }
	}
}

function validDateField(object){
	var value = ptrim(object.value);

	if ( !CheckDate(value))
	{
	    alert("输入值非法,请核实!");
	    object.focus();
	}
}
</script>
<%     }else{       
           price.setBid_own(bid_own); 
           String[] arr=new String[18];     
           arr[0]=request.getParameter("bid_quantity");
           arr[1]=request.getParameter("bid_unit");
           arr[2]=request.getParameter("bid_price");
           arr[3]=request.getParameter("bid_currency");
           arr[4]=request.getParameter("bid_priceCond");
           arr[5]=request.getParameter("bid_deliMeth");
           arr[6]=request.getParameter("bid_destPortId");
           arr[7]=request.getParameter("bid_destStateId");
           arr[8]=request.getParameter("bid_destCityId");
           arr[9]=request.getParameter("bid_payMeth");
           arr[10]=request.getParameter("bid_payCond");
           arr[11]=request.getParameter("bid_beTime");
           arr[12]=request.getParameter("bid_enTime");
           arr[13]=request.getParameter("bid_deliShipDate");
           arr[14]=user_id;
           arr[15]=tobid_id;
           arr[16]=tobiduser_id;
           arr[17]=posting_id; 
           for(int p=0;p<18;p++)
              if(arr[p]==null||arr[p].equals(""))arr[p]="1";          
           float fla=Float.valueOf(arr[0]).floatValue()*Float.valueOf(arr[2]).floatValue(); 
                    
            String str=price.getInsertDa(arr);
            String time=price.doRetime();
            String detial="";
            String title="";
            inqu.setUser_id(user_id);
            if(inqu.getUserLang().equals("GB")){ 
              title="中国纸网——您的供应信息ID:"+posting_id+"已经有了回应";
              detial=" 尊敬的用户："+
             "\n    用户名："+price.doRelogin(user_id)+           
             "\n    您对供应信息ID:"+arr[17]+"进行了需求报价。"+
           "\n    您发布的需求信息ID:"+arr[15]+"  发布时间:"+time+
           "\n    一俟卖方作出回应，系统立刻会以Email通知您。"+
           "\n    如果您需要我们的人工服务，请在北京时间每周一至周五的上午"+
           "8:30到下午5:30与我们的交易工作部门联系："+
           "\n      电话 +86-755-3691610 "+
            "\n      传真 +86-755-3201877" +         
           "\n         祝您好运！"+
           "\n         中国纸网"+
          "\n       交易工作小组"+
          "\n  http://www.paperec.com ";
           }else{
                        title="";
                        detial="";
                        }
             
             inqu.setTitle(title);
             inqu.setDetail (detial);
             inqu.getSingleMess();    
             inqu.setUser_id(tobiduser_id);
             if(inqu.getUserLang().equals("GB")){ 
             title="中国纸网——您对供货信息ID:"+posting_id+"作了需求报价";
             detial="尊敬的用户："+
          "\n    用户名："+price.doRelogin(user_id)+ 
          "\n    您发布的供应消息ID:"+arr[17]+"，已经有了回应："+          
          "\n    回应ID:"+arr[15]+"　回应时间:"+time+"。"+
          "\n    请登录进入中国纸网会员区域，在导航块中的ID输入框直接输入"+
          "这个回应ID号，就可进行议价或申请成交。本网保证议价过程的私密"+
          "性，即您与对方的来来往往报价内容本网其他用户是看不到的。"+          
          "\n    如果您需要我们的人工服务，请在北京时间每周一至周五的上午"+
          "8:30到下午5:30与我们的交易工作部门联系："+
          "\n      电话 +86-755-3691610 "+
          "\n      传真 +86-755-3201877" +         
          "\n         祝您好运！"+
          "\n         中国纸网"+
          "\n       交易工作小组"+
          "\n  http://www.paperec.com ";
           }else{
                        title="";
                        detial="";
                        }
             
             inqu.setTitle(title);
             inqu.setDetail (detial);    
             inqu.getSingleMess();                
                    
                     %>
           
     
                    
          
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a>      
          <tr bgcolor="#E6EDFB"> 
                  <td colspan="3" height="26"> </td>
                </tr>
                <tr valign="top"> 
                  <td colspan="3" bgcolor="#E6EDFB"> 
                    <table width="600" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><img src="../images/keyijiaxx.gif" width="127" height="26">&nbsp;&nbsp;<%=str%></td>
                      </tr>
                      <tr>
                        <td>
                          <table width="600" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left">
                           <tr bgcolor="#E6EDFB">                               
                             <td class="dan10" height="22">  &nbsp;&nbsp; number：<%=arr[0]%> &nbsp;&nbsp;  unit:                          
                           
                                <% for(int i=0; i<BiddingForm.unitParas.length; i++){
				        if(BiddingForm.unitParas[i].equals(arr[1])){   %>
				        <%=BiddingForm.unitParas[i]%> 
				        <%    }}    %>
                              </td>
                              <td class="dan10" height="22">quote price：<%=arr[2]%>  &nbsp;&nbsp;  currency：                                
				<% for(int i=0; i<BiddingForm.currencyParas.length; i++){
				         if(BiddingForm.currencyParas[i][0].equals(arr[3])){ %>  
				            <%=BiddingForm.currencyParas[i][1]%>
				                 <%   }}    %>           
                              </td>
                            </tr>                          
                            
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22" colspan="2">&nbsp; &nbsp;price condition： 
                                
				<% for(int i=0; i<BiddingForm.priceCondParas.length; i++){
				          if(BiddingForm.priceCondParas[i][0].equals(arr[4])){   %>
				         <%=BiddingForm.priceCondParas[i][1]%>
				    <%}}%>
			
	 <%   if(arr[4].equals("CFR")||arr[4].equals("CIF")){      %>	
	                           &nbsp; &nbsp; &nbsp; &nbsp;
                                  dest port：
                                  <% for(int i=0; i<BiddingForm.portParas.length; i++){
				       if(BiddingForm.portParas[i][0].equals(arr[6])){%>
				  <%=BiddingForm.portParas[i][1]%>
				  <%   }  } %> 		     
                                 		
              <%  }else if(arr[4].equals("FOB")){   %>                  
                                &nbsp; &nbsp; &nbsp; &nbsp;
                                
                                  ship port：
                                  
                                 <% for(int i=0; i<BiddingForm.portParas.length; i++){
				       if(BiddingForm.portParas[i][0].equals(arr[6])){%>
				 <%=BiddingForm.portParas[i][1]%>
				    <%   } }  %> 
                                  
              <%  }else if(arr[4].equals("EXW")){     %>
                              &nbsp; &nbsp; &nbsp; &nbsp;
                                  
                                  装货地：
                                  <% for(int i=0; i<BiddingForm.stateParas.length; i++){
				       if(BiddingForm.stateParas[i][0].equals(arr[7])){%>
				 <%=BiddingForm.stateParas[i][1]%>
				    <%   } }  %> 				    
				     &nbsp;
				  <% for(int i=0; i<BiddingForm.cityParas.length; i++){
				       if(BiddingForm.cityParas[i][0].equals(arr[8])){%>
				 <%=BiddingForm.cityParas[i][1]%>
				    <%   } }  %>    
				    
                                  
             <%   }else {  %>
                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                  目的地：
                                    <% for(int i=0; i<BiddingForm.stateParas.length; i++){
				       if(BiddingForm.stateParas[i][0].equals(arr[7])){%>
				 <%=BiddingForm.stateParas[i][1]%>
				    <%   } }  %> 				    
				     &nbsp;
				  <% for(int i=0; i<BiddingForm.cityParas.length; i++){
				       if(BiddingForm.cityParas[i][0].equals(arr[8])){%>
				 <%=BiddingForm.cityParas[i][1]%>
				    <%   } }  %>    
                                  
              
             <%       }      %>
                                
                                &nbsp; &nbsp; &nbsp; &nbsp;
                                合同总金额：  <%=fla%>
                               
                              </td>
                            </tr>                           
         
                           <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">
                               &nbsp; &nbsp;                             
                                pay method： 
                                <% for(int i=0; i<BiddingForm.payMethParas.length; i++){
				       if(BiddingForm.payMethParas[i][0].equals(arr[9])){%>
				 <%=BiddingForm.payMethParas[i][1]%>
				    <%   } }  %>    
                              
                            &nbsp; &nbsp; &nbsp; &nbsp;   
                    <%  if(arr[9].equals("XYZ")){     %>
                              信用证种类：
                              
                             <% for(int i=0; i<BiddingForm.checkKindParas.length; i++){
				       if(BiddingForm.checkKindParas[i][0].equals(arr[9])){%>
				 <%=BiddingForm.checkKindParas[i][1]%>
				    <%   } }  %>    
				    
                     <%    }else if(arr[9].equals("HP")){    %>
                               承兑期：
                               
                             <% for(int i=0; i<BiddingForm.checkKindParas.length; i++){
				       if(BiddingForm.checkKindParas[i][0].equals(arr[9])){%>
				 <%=BiddingForm.checkKindParas[i][1]%>
				    <%   } }  %>      
                               
                      <%     }   %>                   
                                
                              </td>
                      <td class="dan10" height="22" >                      
                     <%  if(!arr[9].equals("XYZ")){     %>                                 
                                交货方式：                                
                                 <% for(int i=0; i<BiddingForm.deliMethParas.length; i++){
				       if(BiddingForm.deliMethParas[i][0].equals(arr[5])){%>
				  <%=BiddingForm.deliMethParas[i][1]%>				        
				<%   }   }  }%>          
				
                             </td>   
                            </tr>
                            
         
                        <tr bgcolor="#E6EDFB">                                                    
                              <td class="dan10" height="22" >&nbsp; &nbsp;报价开始时间：<%=arr[11]%>                                
                              &nbsp; &nbsp; &nbsp; &nbsp;
                              报价到期时间：<%=arr[12]%>                                
                              </td>
                               <td class="dan10" height="22" >交货日期：<%=arr[13]%>                                
                              </td>   
                            </tr>
         
         
         
         
                            
                            
                            <tr bgcolor="#E6EDFB" align="center"> 
                  <td colspan="3" class="big" height="25"> <font color="#FFFFFF"><b>
                    
                    <input type="button" name="Submit2" value="close" onClick="winclose();">
                    </b></font></td>
                </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
</body>
<!-- #EndTemplate --></html>          
  <script language="javascript" >
    function winclose(){
      confirm("Close the window？");
       window.close()
               
       }        
  </script>      




 <%      }  %>     
 <% price.getDestroy();  %>
</jsp:useBean>
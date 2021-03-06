<%--  @# quote.jsp Ver.1.4 --%>

<%@ page import="postcenter.*" %>
<jsp:useBean id="UserInfo" scope="session" class="mypaperec.UserInfo" />
<%  if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="notAuthorized.jsp" />
	</jsp:forward>
<%    }
%>

<jsp:useBean id="price" scope="page" class="postcenter.ReleasQP" />
<jsp:useBean id="inqu" scope="page" class="postcenter.InserMessage" />
<%   String posting_id=request.getParameter("posting_id");
     String lang_code=request.getParameter("lang_code");
     String user_id=request.getParameter("user_id"); 
     String tobid_id=request.getParameter("tobid_id");
     String tobiduser_id=request.getParameter("tobiduser_id"); 
     String bid_own=request.getParameter("bid_own");     
     String bors=request.getParameter("bors");
     String ri="";  
     price.setPostingid(posting_id);  
     price.setUserid(user_id);   
     String userdet[]=new String[2];     
 %>  




<jsp:useBean id="BiddingForm" scope="page" class="postcenter.BiddingForm" />

<jsp:setProperty name="BiddingForm" property="langCode" value="GB" />
<jsp:setProperty name="BiddingForm" property="measureFlag" value="M" />
<jsp:setProperty name="BiddingForm" property="validDay" value="30" />




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

	yearArray =['2000','2001','2002','2003','2004','2005'];
	monthArray =['01','02','03','04','05','06','07','08','09','10','11','12'];
	dateArray =['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];
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

function recreateList2(list, array, key) {
	var cnt= 1;

	list.length=cnt;
	list.options[0].text = "-请选择-  ";
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

function recreateList3(list, array) {
	var cnt= 0;

	list.length=cnt;
	for (var i=0;i<array.length;i++) {
		list.length=cnt+1;
		list.options[cnt].text = array[i];
		list.options[cnt].value = array[i];
		cnt++;
	}
}

function selectList(list, value){
	value = value.toString();
	for(var i=0;i<list.length;i++){
		if(list.options[i].value == value ){
			list.options[i].selected = 1;
		}
	}  
}
</script> 





<%-- ================ CSS for Display the Items in the page ============== --%>
<style> 
#cont_bid_city{position: absolute; left: ; top: ; } 
#cont_bid_port{position: absolute; left: ; top: ; visibility:hidden;} 
#cont_bid_payCond{position: absolute; left: ; top: ; } 
</style> 
<%-- ================ End of CSS for the Display Items  =================== --%>




<html><!-- #BeginTemplate "/Templates/paperec_templares.dwt" -->
<head>
<!-- #BeginEditable "doctitle" --> 
<title>我的纸网--PaperEC.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
       price.setLangcode(lang_code);
       price.setBid_own(bid_own);
       String st[]=price.getAllResult();
       float fla=Float.valueOf(st[0]).floatValue()*Float.valueOf(st[2]).floatValue(); 
           %>

<body bgcolor="#E6EDFB" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 


       
              <table width="443" border="0" cellspacing="0" cellpadding="2" bgcolor="#E6EDFB" >
               <form id="mainInputForm" name="mainInputForm" action="quote.jsp" method="POST">
                <tr valign="top"> 
              
		<input type="HIDDEN" name="langCode" value="GB"> 
		
                  <td colspan="3" bgcolor="#E6EDFB"> 
                    <table width="447" border="0" cellspacing="0" cellpadding="0" >
                      <tr>
               <%   if(bors.equals("B")){      %>       
                        <td><img src="../../images/bidding_info.gif" width="127" height="26"></td>
               <%   }else{              %>     
                        <td><img src="../../images/offer_info.gif" width="127" height="26"></td>
               <%   }  %>       </tr>
                      <tr>
                        <td>
                          <table width="447" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left" >
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： 
                                <input type="text" name="bid_quantity" size="7" onBlur="validField(this);" value=<%=st[0]%>> <%=st[1]%>
                                <input type="HIDDEN" name="bid_unit" align="right" value="<%=st[1]%>"> 
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">                                
                                报价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： 
                                <input type="text" name="bid_price" size="7" onBlur="validField(this);" value=<%=st[2]%>><%=st[3]%>
                                <input type="HIDDEN" name="bid_currency" align="right" value="<%=st[3]%>"> 
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">价格条款&nbsp;&nbsp;&nbsp;： 
                                <select name="bid_priceCond" onChange="changeBidVisible()">
				<% for(int i=0; i<BiddingForm.priceCondParas.length; i++){
				          if(BiddingForm.priceCondParas[i][0].equals(st[4])){   %>
				         <option value=<%=BiddingForm.priceCondParas[i][0]%> selected><%=BiddingForm.priceCondParas[i][1]%></option> 
				     <%   }else {          %>     
                                  <option value=<%=BiddingForm.priceCondParas[i][0]%>><%=BiddingForm.priceCondParas[i][1]%></option>
				<%         }      } %>
                                </select>
                                <div id="cont_bid_port" class="dan10">
                                <select name="bid_destPortId">
                                  <option value="">-请选择- </option>
                                <% for(int i=0; i<BiddingForm.portParas.length; i++){
				       if(BiddingForm.portParas[i][0].equals(st[6])){%>
				  <option value=<%=BiddingForm.portParas[i][0]%> selected><%=BiddingForm.portParas[i][1]%></option>
				         <%  }else{   %> 
                                  <option value=<%=BiddingForm.portParas[i][0]%>><%=BiddingForm.portParas[i][1]%></option>
				<%      }  }%>                                
                                </select>
                                </div> 
                                <div id="cont_bid_city" class="dan10">
                                <select name="bid_destStateId" onChange="recreateList2(this.form.bid_destCityId, cityArray, this.options[this.selectedIndex].value)">
                                  <option value="">--N/A-- </option>
                                </select>
                                <select name="bid_destCityId">
                                  <option value="">--N/A-- </option>
                                </select>
                                </div> 
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">
                                支付方式&nbsp;&nbsp;&nbsp;： 
                                <select name="bid_payMeth" onChange="payMethChanged()">
                                  <option selected value="">--N/A--</option>
                                </select>
                                <div id="cont_bid_payCond" class="dan10">
                                <select name="bid_payCond">
                                  <option selected value="">--N/A--</option>
                                </select>
                                </div> 
                              </td>
                            </tr>
		<% if (st[3]!=null && st[3].equals("RMB")) { %>
                            <tr bgcolor="#E6EDFB">
                              <td class="dan10" height="22">
                                <div id="cont_bid_deliMeth" class="dan10">
                                付款方法&nbsp;&nbsp;&nbsp;：
                                <select name="bid_deliMeth">
                                 <% for(int i=0; i<BiddingForm.deliMethParas.length; i++){
				       if(BiddingForm.deliMethParas[i][0].equals(st[5])){%>
				  <option value=<%=BiddingForm.deliMethParas[i][0]%> selected><%=BiddingForm.deliMethParas[i][1]%></option>
				         <%  }else{   %> 
				  <option value=<%=BiddingForm.deliMethParas[i][0]%>><%=BiddingForm.deliMethParas[i][1]%></option>
				<%      }  }%>          
                                </select>
                                </div> 
                              </td>
                            </tr>
		<% }else { %>
				<input type="HIDDEN" name="bid_deliMeth" value=""> 
		<% } %>
                            
                            <tr bgcolor="#E6EDFB"> 
                            <% if (st[3]!=null && st[3].equals("RMB")) { %>
                              <td class="dan10" height="22" bgcolor="#E6EDFB">交货日期&nbsp;&nbsp;&nbsp;：
                            <% }else { %>
                              <td class="dan10" height="22" bgcolor="#E6EDFB">装船日期&nbsp;&nbsp;&nbsp;：
		            <% } %>   
		                <select name="dsd_y">
		                  <option value="2000">2000</option>
		                </select>
		                <select name="dsd_m">
		                  <option value="01">01</option>
		                </select>
		                <select name="dsd_d">
				  <option value="01">01</option>
		                </select>
                                <input type="HIDDEN" name="bid_deliShipDate" value=<%=st[13]%>>
                              </td>
                            </tr>
                            
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">报价有效期&nbsp;：
		                <select name="bt_y">
		                  <option value="2000">2000</option>
		                </select>
		                <select name="bt_m">
		                  <option value="01">01</option>
		                </select>
		                <select name="bt_d">
				  <option value="01">01</option>
		                </select>
                                <input type="HIDDEN" name="bid_beTime" value="<%=st[11]%>">
                                至 
		                <select name="et_y">
		                  <option value="2000">2000</option>
		                </select>
		                <select name="et_m">
		                  <option value="01">01</option>
		                </select>
		                <select name="et_d">
				  <option vaule="01">01</option>
		                </select>
                                <input type="HIDDEN" name="bid_enTime" value="<%=st[12]%>">
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
                    <input type="button" name="Submit2" value="提 交" onClick="javascript:submitPage()">
                    <img src="../../images/space.gif" width="100" height="1"> 
                    <input type="button" name="Submit2" value="重 置" onClick="javascript:document.mainSpecForm.reset();">
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
	var priceCondVal; 
	var attr;

	if (mf.bid_priceCond.selectedIndex >=0) {
	  priceCondVal = mf.bid_priceCond.options[mf.bid_priceCond.selectedIndex].value; 
	}

	if ((priceCondVal == 'EXW')||(priceCondVal == 'EXD')) {
		attr = new makeAttr('cont_bid_port', ''); 
		attr.css.visibility='hidden';
		attr = new makeAttr('cont_bid_city', ''); 
		attr.css.visibility='visible';
	} 
	else {
		attr = new makeAttr('cont_bid_port', ''); 
		attr.css.visibility='visible';
		attr = new makeAttr('cont_bid_city', ''); 
		attr.css.visibility='hidden';
	} 
}

function changePriceCond() {
	var mf=document.mainInputForm;
	var currencyVal;

	currencyVal = mf.bid_currency.value; 
	recreateList(mainInputForm.bid_priceCond, priceCondArray, currencyVal);
	changeBidVisible();
}

function changePayMeth() {
	var mf=document.mainInputForm;
	var currencyVal;

	currencyVal = mf.bid_currency.value; 
	recreateList(mainInputForm.bid_payMeth, payMethArray, currencyVal);
}

function currencyChanged() {
	var mf=document.mainInputForm;
	var currencyVal;
	var attr;

	currencyVal = mf.bid_currency.value; 

	changePriceCond();
	changePayMeth();
	payMethChanged();
}

function payMethChanged() {
	var mf=document.mainInputForm;
	var payMethVal;
	var attr;

	if (mf.bid_payMeth.selectedIndex >=0) {
	  payMethVal = mf.bid_payMeth.options[mf.bid_payMeth.selectedIndex].value; 
	}	
	recreateList(mainInputForm.bid_payCond, bidPayCondArray, payMethVal);

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

recreateList2(mainInputForm.bid_destStateId, stateArray, mainInputForm.langCode.value=="EN"?"2":"1");

var tmpVal;
tmpVal = "";
if (mainInputForm.bid_destStateId.selectedIndex >=0) {
  tmpVal = mainInputForm.bid_destStateId.options[mainInputForm.bid_destStateId.selectedIndex].value; 
}
recreateList2(mainInputForm.bid_destCityId, cityArray, tmpVal);

var array = new Array();
recreateList3(mainInputForm.dsd_y, yearArray);
recreateList3(mainInputForm.dsd_m, monthArray);
recreateList3(mainInputForm.dsd_d, dateArray);
array = mainInputForm.bid_deliShipDate.value.split("-");
selectList(mainInputForm.dsd_y, array[0]);
selectList(mainInputForm.dsd_m, array[1]);
selectList(mainInputForm.dsd_d, array[2]);

recreateList3(mainInputForm.bt_y, yearArray);
recreateList3(mainInputForm.bt_m, monthArray);
recreateList3(mainInputForm.bt_d, dateArray);
array = mainInputForm.bid_beTime.value.split("-");
selectList(mainInputForm.bt_y, array[0]);
selectList(mainInputForm.bt_m, array[1]);
selectList(mainInputForm.bt_d, array[2]);

recreateList3(mainInputForm.et_y, yearArray);
recreateList3(mainInputForm.et_m, monthArray);
recreateList3(mainInputForm.et_d, dateArray);
array = mainInputForm.bid_enTime.value.split("-");
selectList(mainInputForm.et_y, array[0]);
selectList(mainInputForm.et_m, array[1]);
selectList(mainInputForm.et_d, array[2]);

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
		
	mf.bid_deliShipDate.value = mf.dsd_y.options[mf.dsd_y.selectedIndex].value + "-" + mf.dsd_m.options[mf.dsd_m.selectedIndex].value + "-" + mf.dsd_d.options[mf.dsd_d.selectedIndex].value;
	mf.bid_beTime.value = mf.bt_y.options[mf.bt_y.selectedIndex].value + "-" + mf.bt_m.options[mf.bt_m.selectedIndex].value + "-" + mf.bt_d.options[mf.bt_d.selectedIndex].value;
	mf.bid_enTime.value = mf.et_y.options[mf.et_y.selectedIndex].value + "-" + mf.et_m.options[mf.et_m.selectedIndex].value + "-" + mf.et_d.options[mf.et_d.selectedIndex].value;

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
<%     }else{    %>
<jsp:useBean id="pro" scope="page" class="postcenter.BidList" />
 
<%           String detial="";
           String title="";    
           price.setBid_own(bid_own);            
           String[] arr=new String[18]; 
          // user_id=request.getParameter("user_id");      
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
            String serial="";
            pro.setbid_id(str);
            pro.setLangcode("GB");     
            String[] strr=new String[19];
            strr=pro.getAllResult(); 
            String[] titler=pro.getTitle();
            if(titler[1].equals(""))strr[13]="";
            if(str.equals("0")){
              str="数据库操作有误，请稍候再试！";
            }else{
              serial=str;
              str="您已成功提交了"+str+"号议价单";
            
            
            
            String time=price.doRetime(); 
       ri=price.getBuyorSale();     
            
   if(ri.equals("B")){         
             inqu.setUser_id(user_id);
        if(inqu.getUserLang().equals("GB")){ 
            price.setLangcode("GB"); 
            price.setUserid(user_id); 
            userdet=price.getUserdet(); 
            title="中国纸网——您对供货信息ID:"+posting_id+"作了需求报价";       
            detial="尊敬的"+userdet[1]+userdet[0]+"："+       
                   "\n\n    您对供应信息ID:"+tobid_id+"进行了需求报价。"+
                   "\n    您发布的需求信息ID:"+serial+"  发布时间:"+time+
                   "\n\n    该条报价只有您自己和发布这条供应信息的卖方可看到。本网其他"+
                   "会员是看不到的。本网保证议价过程的私密性，即您与该产品卖"+
                   "方的来来往往报价内容本网其他用户是看不到的。"+
          
                   "\n\n    一旦卖方作出回应，系统立刻会以Email通知您。"+
                   "\n\n    如果您需要我们的人工服务，请在北京时间每周一至周五的上午"+
                   "8:30到下午5:30与我们的交易工作部门联系："+
                   "\n    电话 +86-755-3691610 "+
                   "\n    传真 +86-755-3201877" +         
                   "\n\n    祝您好运！"+
                   "\n\n\n    中国纸网"+
                   "\n    交易工作小组"+
                   "\n\n\n    http://www.paperec.com ";        
            
        }else{
            price.setLangcode("EN"); 
            price.setUserid(user_id); 
            userdet=price.getUserdet();
            title="PaperEC.com-- You have bid on the posting ID#"+posting_id;       
            detial="Dear "+userdet[0]+userdet[1]+"："+        
                   "\n\n  You have made a bid on the posting ID#"+tobid_id+
                   "\n  Your bid ID#"+serial+", bid time:"+time+
                   "\n\n  The bidding process between you and seller is private. Other"+
                   "members of PaperEC.com are unable to view any aspect of the"+
                   "negotiation process."+
          
                   "\n\n  Upon receipt of the seller's response, PaperEC.com will notify"+
                   "you automatically through email. "+
                   "\n\n  Should you need immediate assistance,  please call us"+
                   "Monday through Friday between the hours of 8:30 am. and 6:00"+
                   "pm. Beijing Standard Time at +86-755-369-1613"+
                   "\n                             +86-755-3201877 Fax" +         
                   "\n\n\n  Best Regards, "+
                   "\n\n  PaperEC.com."+                   
                   "\n\n  http://www.paperec.com ";        
               }        
            
             inqu.setTitle(title);
             inqu.setDetail (detial);
             inqu.getSingleMess();    
             
             inqu.setUser_id(tobiduser_id);
        if(inqu.getUserLang().equals("GB")){ 
            price.setLangcode("GB"); 
            price.setUserid(tobiduser_id); 
            userdet=price.getUserdet(); 
            title="中国纸网——您的供应信息ID:"+posting_id+"已经有了回应";
            detial="尊敬的"+userdet[1]+userdet[0]+"："+
          "\n\n    您发布的供应消息ID:"+tobid_id+"，已经有了回应："+          
          "\n\n    回应ID:"+serial+"　回应时间:"+time+"。"+
          "\n\n\n    请登录进入中国纸网会员区域，在导航块中的ID输入框直接输入"+
          "您的供应发布ID号，就可进行议价或申请成交。本网保证议价过程的私密"+
          "性，即您与对方的来来往往报价内容本网其他用户是看不到的。"+          
          "\n\n\n    如果您需要我们的人工服务，请在北京时间每周一至周五的上午"+
          "8:30到下午5:30与我们的交易工作部门联系："+
          "\n    电话 +86-755-3691610 "+
          "\n    传真 +86-755-3201877" +         
          "\n\n\n    祝您好运！"+
          "\n\n\n    中国纸网"+
          "\n    交易工作小组"+
          "\n\n\n    http://www.paperec.com ";
        }else{
            price.setLangcode("EN"); 
            price.setUserid(tobiduser_id); 
            userdet=price.getUserdet(); 
            title="PaperEC.com-- There's a response to your Offer to Sell ID#"+posting_id;
            detial="Dear "+userdet[0]+userdet[1]+"："+
          "\n\n  On your Offer to Sell ID#"+tobid_id+"，a bid has been submitted. "+          
          "\n\n  The buyer's bid ID#"+serial+"　bid time "+time+"."+
          "\n\n  Please Log into My PaperEC to see the details."+
          "(Input the posting ID# into the floating pilot panel for quick"+
          "access.) You can submit a counterbid or accept the buyer's bid."+          
          "\n\n  The negotiating process between you and the buyer is private."+
          "Other members of PaperEC.com are unable to view your bids."+
          "\n\n  Should you need immediate assistance,  please call us"+
          "Monday through Friday between the hours of 8:30 am. and 6:00"+
          "pm. Beijing Standard Time at +86-755-369-1613"+          
          "\n                             +86-755-3201877 Fax. " +         
          "\n\n\nBest Regards, "+
          "\n\nPaperEC.com."+          
          "\n\nhttp://www.paperec.com ";
               }            
                             
             inqu.setTitle(title);
             inqu.setDetail(detial);    
             inqu.getSingleMess();  
    }else{
          inqu.setUser_id(user_id);
        if(inqu.getUserLang().equals("GB")){ 
            price.setLangcode("GB"); 
            price.setUserid(user_id); 
            userdet=price.getUserdet(); 
            title="中国纸网——您对需求报价ID:"+tobid_id+" 作的议价";       
            detial="尊敬的"+userdet[1]+userdet[0]+"："+        
                   "\n\n    在您发布的供应信息ID:"+posting_id+"上，您对需求报价ID:"+tobid_id+"作了议价，"+
                   "议价ID号为:"+serial+"  议价时间:"+time+
                   "\n\n    一旦该买方作出回应，系统立刻会以Email通知您。"+          
                   "\n\n    如果您需要我们的人工服务，请在北京时间每周一至周五的上午"+
                   "8:30到下午5:30与我们的交易工作部门联系："+
                   "\n    电话 +86-755-3691610 "+
                   "\n    传真 +86-755-3201877" +         
                   "\n\n    祝您好运！"+
                   "\n\n\n    中国纸网"+
                   "\n    交易工作小组"+
                   "\n\n\n    http://www.paperec.com ";        
            
        }else{
            price.setLangcode("EN"); 
            price.setUserid(user_id); 
            userdet=price.getUserdet(); 
            title="PaperEC.com-- Negotiations on buyer's bid ID#"+tobid_id;       
            detial="Dear "+userdet[0]+userdet[1]+"："+        
                   "\n\n  On your Offer to Sell ID#"+posting_id+"you have submitted a counterbid on the buyer's bid ID#"+tobid_id+
                   "Your bid ID#"+serial+", bid time "+time+
                   "\n\n  Upon receipt of the buyer's respond, PaperEC.com will notify"+  
                   "you automatically through email."+        
                   "\n\n  Should you need immediate assistance,  please call us"+
                   "Monday through Friday between the hours of 8:30 am. and 6:00"+                   
                   "pm. Beijing Standard Time at +86-755-369-1613"+
                   "\n                             +86-755-320-1877 Fax." +         
                   "\n\n\n  Best Regards, "+
                   "\n\n  PaperEC.com."+                   
                   "\n\n  http://www.paperec.com ";      
               }        
            
             inqu.setTitle(title);
             inqu.setDetail (detial);
             inqu.getSingleMess();    
             
             inqu.setUser_id(tobiduser_id);
        if(inqu.getUserLang().equals("GB")){  
             price.setLangcode("GB"); 
            price.setUserid(tobiduser_id); 
            userdet=price.getUserdet(); 
             title="中国纸网——您的需求报价ID:"+tobid_id+"已经有了回应";
             detial="尊敬的"+userdet[1]+userdet[0]+"："+
                    "\n\n    对供应信息ID:"+posting_id+"您发布的需求报价ID:"+tobid_id+"，已经有了回应,"+          
                    "回应报价ID:"+serial+"　回应时间:"+time+"。"+
                    "\n\n\n    请登录进入中国纸网会员区域，在导航块中的ID输入框直接输入"+
                    "该供应信息发布ID号，就可进行议价或申请成交。本网保证议价过程的私密"+
                    "性，即您与对方的来来往往报价内容本网其他用户是看不到的。"+          
                    "\n\n    如果您需要我们的人工服务，请在北京时间每周一至周五的上午"+
                    "8:30到下午5:30与我们的交易工作部门联系："+
                    "\n    电话 +86-755-3691610 "+
                    "\n    传真 +86-755-3201877" +         
                    "\n\n\n    祝您好运！"+
                    "\n\n\n    中国纸网"+
                    "\n    交易工作小组"+
                    "\n\n\n    http://www.paperec.com ";
        }else{
              price.setLangcode("EN"); 
            price.setUserid(tobiduser_id); 
            userdet=price.getUserdet(); 
              title="PaperEC.com-- Seller has responded to your bid ID#"+tobid_id;
             detial="Dear "+userdet[0]+userdet[1]+"："+
                    "\n\n  On the posting ID#"+posting_id+"the seller has made a counterbid on your bid ID#"+tobid_id+                           
                    "\n  Please Log into My PaperEC to see the details. (Input the"+
                    "posting ID# into the floating pilot panel for quick access.)"+
                    "You can submit a counterbid or accept the seller's bid."+          
                    "\n\n  The bidding process between you and seller is private. Other"+
                    "members of paperEC.com are unable to view the negotiating process."+
                    "\n\n  Should you need immediate assistance,  please call us"+
                    "Monday through Friday between the hours of 8:30 am. and 6:00"+
                    "pm. Beijing Standard Time at +86-755-369-1613"+                    
                    "\n                      +86-755-3201877 Fax" +         
                    "\n\n  Best Regards,"+
                    "\n\n  PaperEC.com."+                 
                    "\n\n  http://www.paperec.com ";
               }            
                             
             inqu.setTitle(title);
             inqu.setDetail(detial);    
             inqu.getSingleMess();  
         
    }          
                           
 }             
                     %>
           
     
<body bgcolor="#E6EDFB" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<tr bgcolor="#E6EDFB"> 
  <td colspan="3" height="26"> </td>
</tr>
<tr valign="top"> 
  <td colspan="3" bgcolor="#E6EDFB"> 
    <body bgcolor="#E6EDFB" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<tr bgcolor="#E6EDFB"> 
  <td colspan="3" height="26"> </td>
</tr>

<tr valign="top"> 
  <td colspan="3" bgcolor="#E6EDFB"> 
    <table width="443" border="0" cellspacing="0" cellpadding="0" height="246">
      <tr> 
        <td><img src="../../images/xiangqing.gif" width="127" height="26">&nbsp;&nbsp;<%=str%></td>
      </tr>
      <form name="ok" method="post" action="bidmodi.jsp">
        <tr> 
          <td> 
            <table width="447" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left" height="218">
              <tr> 
                <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"> 数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： 
                  <%=strr[6]%> &nbsp;&nbsp; <%=strr[7]%> </td>
              </tr>
              <tr> 
                <td class="dan10" height="22" colspan="2" >报价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：<%=strr[8]%><%=strr[9]%>/<%=strr[7]%> 
                </td>
              </tr>
              <tr> 
                <td class="dan10" height="22" colspan="2" >价格条款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： 
                  <%=strr[10]%> <%=strr[11]%> </td>
              </tr>
                <td class="dan10" height="22" colspan="2" >支付方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：<%=strr[12]%> 
                  <%=strr[13]%></td>
              </tr>
              <tr> 
                <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"> <%=titler[2] %><%=strr[14] %> 
                </td>
              </tr>
              <tr> 
                <td class="dan10" height="22" colspan="2" bgcolor="#E6EDFB"><%=titler[3]%><%=strr[18]%></td>
              </tr>
              <tr bgcolor="#E6EDFB"> 
                <td class="dan10" height="22" colspan="2">报价有效期&nbsp;&nbsp;&nbsp;：<%=strr[15]%> 至 <%=strr[16]%> </td>
              </tr>
              <tr align="center"> 
                <td colspan="3" class="big" height="25" bgcolor="#E6EDFB"> <font color="#FFFFFF"><b> 
                  <input type="button" name="Submit2" value="关 闭" onClick="winclose();">
                  </b></font></td>
              </tr>
            </table>
          </td>
        </tr>
      </form>
    </table>
  </td>
</tr>
</body>
<!-- #EndTemplate --></html>          
  <script language="javascript" >
    function winclose(){     
       window.close()
               
       }        
  </script>      



<% pro.getDestroy();  %>
 <%      }  %>     
 <% price.getDestroy();  %>
 <% inqu.getDestroy();  %>
 
</jsp:useBean>
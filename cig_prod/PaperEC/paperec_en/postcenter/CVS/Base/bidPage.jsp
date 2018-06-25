<%--  @# bidPage.jsp Ver.1.1 --%>

<%@ page import="postcenter.*" %>
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
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="top"></a> 
<table width="776" border="0" cellspacing="0" cellpadding="0" height="600">
  <tr>
    <td width="159"> <script> NS = (document.layers) ? 1 : 0;	IE = (document.all) ? 1: 0;	self.onError=null; ls_Y = 0; function goto_url(e) {var url = e.options[e.selectedIndex].value; if (url != "") location.href=url;} function smoothscrollMenu() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y) {move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); if(IE) document.all.scrollMenu.style.pixelTop += move; if(NS) document.scrollMenu.top += move; ls_Y = ls_Y + move;} else {move = Math.floor(move); if(IE) d = document.all.scrollMenu.style.pixelTop; else d =document.scrollMenu.top; var dd = d + move;	if (dd >2) { if(IE) document.all.scrollMenu.style.pixelTop += move; else document.scrollMenu.top += move; } ls_Y = ls_Y + move;	}}} function scrollpop() {if(IE) { st = document.body.scrollTop } if(NS) { st = self.pageYOffset } if(st != ls_Y){move = .1 * (st - ls_Y); if(move > 0) {move = Math.ceil(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}else {move = Math.floor(move); document.all.scrollMenu.style.pixelTop = document.body.scrollTop + 2; ls_Y = ls_Y + move;}}} if(NS || IE) action = window.setInterval("smoothscrollMenu()",1); function showInfo(){ var newWind=window.open('/dsp_site_pilot_info.html','sitepilotinfo','toolbar=no,titlebar=no,scrollbars=no,status=no,menubar=no,width=375,height=120');
 if (newWind.opener == null) { newWind.opener = window; }} </script>
      <div id="scrollMenu" style="position:absolute; left:1; top:2px; width:141px; height:249px; z-index:1" class="list2"> 
        <form name="moveBarForm" method="post" action="demand_info.jsp">
          <table width="141" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="143"> 
                <table width="139" border="1" cellspacing="0" cellpadding="0" bordercolordark="#CCCCCC" bordercolorlight="#000000" bordercolor="#000000">
                  <tr> 
                    <td><img src="../../images/jyzhx.gif" width="139" height="22"></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" align="center"><a href="product_list.jsp" class="font9"><font color="#000000">供应发布</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="request2buy.jsp"><font color="#000000">需求发布</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#F1AD0C" align="center"><a href="order_search.jsp"><font color="#000000">浏览供需</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td bgcolor="#F1AD0C" height="22" class="font9" align="center"><a href="../mycustomer.jsp"><font color="#000000">我的客户</font></a></td>
                  </tr>
                  <tr bgcolor="#F0AC10"> 
                    <td class="font9" height="22" align="center"><a href="product_list.jsp"><font color="#000000">我的产品</font></a></td>
                  </tr>
                  <tr bgcolor="#301090"> 
                    <td class="font9" height="22"><font color="#FFFFFF">ID直通车</font></td>
                  </tr>
                  <tr> 
                    <td bgcolor="#F1AD0C" align="center"> 
                      <input type="text" name="posting_id" size="8">
                      <input type="submit" name="Submit6" value="进入">
                    </td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#"><font color="#FFFFFF">外汇汇率换算</font></a></td>
                  </tr>
                  <tr> 
                    <td class="font9" height="22" bgcolor="#4078D8" align="center"><a href="#"><font color="#FFFFFF">交易服务</font></a></td>
                  </tr>
                  <tr valign="middle"> 
                    <td height="22" class="font9" bgcolor="#3F78DD" align="center"><a href="#"><font color="#FFFFFF">计量单位转换</font></a></td>
                  </tr>
                </table>
                <table width="139" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td><img src="../../images/left_down.gif" width="142" height="27" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="85,2,141,24" href="#Top"></map></td>
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
                  <td colspan="3" height="25" bgcolor="#4078E0"><font color="#FFFFFF" class="big"><b>需求发布 
                    </b> </font></td>
                </tr>
                <tr> 
                  <td bgcolor="#7EA2EB" class="big" align="center" width="184"><font color="#FFFFFF">类型</font></td>
                  <td bgcolor="#7EA2EB" class="big" align="center" width="184"><font color="#FFFFFF">产品</font></td>
                  <td bgcolor="#7EA2EB" class="big" align="center" width="184"><font color="#FFFFFF">型号</font></td>
                </tr>


                <tr bgcolor="#E6EDFB"> 
                  <td colspan="3" height="26">&nbsp; </td>
                </tr>

<!-- ====== Define the Form, the important things ============= -->
<form id="mainInputForm" name="mainInputForm" action="" method="POST">
<input type="HIDDEN" name="langCode" value="EN"> 

                <tr bgcolor="#E6EDFB"> 
                  <td colspan="3" height="26">&nbsp; </td>
                </tr>
                <tr valign="top"> 
                  <td colspan="3" bgcolor="#E6EDFB"> 
                    <table width="600" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><img src="../../images/keyijiaxx.gif" width="127" height="26"></td>
                      </tr>
                      <tr>
                        <td>
                          <table width="600" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#E6EDFB" align="left">
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22">amount： 
                                <input type="text" name="bid_quantity" size="12" onBlur="validField(this); calculateSum();">
                                unit： 
                                <select name="bid_unit">
				<% for(int i=0; i<BiddingForm.unitParas.length; i++){%>
                                  <option value=<%=BiddingForm.unitParas[i]%>><%=BiddingForm.unitParas[i]%></option>
				<%}%>
                                </select>
                              </td>
                              <td class="dan10" height="22">quote： 
                                <input type="text" name="bid_price" size="12" onBlur="validField(this); calculateSum();">
                                currency： 
                                <select name="bid_currency" onChange="currencyChanged();">
				<% for(int i=0; i<BiddingForm.currencyParas.length; i++){%>
                                  <option value=<%=BiddingForm.currencyParas[i][0]%>><%=BiddingForm.currencyParas[i][1]%></option>
				<%}%>
                                </select>
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22" colspan="2">price condition： 
                                <select name="bid_priceCond" onChange="changeBidVisible()">
				<% for(int i=0; i<BiddingForm.priceCondParas.length; i++){%>
                                  <option value=<%=BiddingForm.priceCondParas[i][0]%>><%=BiddingForm.priceCondParas[i][1]%></option>
				<%}%>
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
				<% for(int i=0; i<BiddingForm.portParas.length; i++){%>
                                  <option value=<%=BiddingForm.portParas[i][0]%>><%=BiddingForm.portParas[i][1]%></option>
				<%}%>
                                </select>
                                </div> 
                                <div id="cont_bid_city" class="dan10">
                                  <div id="cont_city_prompt1" class="dan10">
                                  交货地点： 
                                  </div> 
                                  <div id="cont_city_prompt2" class="dan10">
                                  装货地点： 
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
                                pay method： 
                                <select name="bid_payMeth" onChange="payMethChanged()">
                                  <option selected value="">--N/A--</option>
                                </select>
                              </td>
                              <td class="dan10" height="22">
                                <div id="cont_bid_payCond" class="dan10">
                                支付期限： 
                                <select name="bid_payCond">
                                  <option selected value="">--N/A--</option>
                                </select>
                                </div> 
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB">
                              <td class="dan10" height="22" width="291">
                                <div id="cont_bid_deliMeth" class="dan10">
                                交货方式：
                                <select name="bid_deliMeth">
				<% for(int i=0; i<BiddingForm.deliMethParas.length; i++){%>
                                  <option value=<%=BiddingForm.deliMethParas[i][0]%>><%=BiddingForm.deliMethParas[i][1]%></option>
				<%}%>
                                </select>
                                </div> 
                              </td>
                              <td class="dan10" height="22" width="301" bgcolor="#E6EDFB">交货日期：
                                <input type="text" name="bid_deliShipDate" size="12">
                              </td>
                            </tr>
                            <tr bgcolor="#E6EDFB"> 
                              <td class="dan10" height="22" width="291">报价开始时间： 
                                <input type="text" name="bid_beTime" size="12" value="<%=BiddingForm.beTime%>" onBlur="validDateField(this)">
                              </td>
                              <td class="dan10" height="22" width="301" bgcolor="#E6EDFB">报价到期时间： 
                                <input type="text" name="bid_enTime" size="12" value="<%=BiddingForm.enTime%>" onBlur="validDateField(this)">
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
                    <input type="button" name="Submit2" value="submit" onClick="javascript:submitPage()">
                    <img src="../../images/space.gif" width="100" height="1"> 
                    <input type="button" name="Submit2" value="reset" onClick="javascript:document.mainSpecForm.reset();">
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
          <td><img src="../../images/dline.gif" width="776" height="6"></td>
        </tr>
        <tr align="center"> 
          <td class="font9"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
            2000 PaperEC,Inc. All Right Reserved</font></td>
        </tr>
        <tr align="center"> 
          <td><a href="mailto:info@paperec.com"><img src="../../images/dipic.gif" width="80" height="24" border="0"></a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
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

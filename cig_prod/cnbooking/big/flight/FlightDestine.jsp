<html>
<head>
<!-- #BeginEditable "doctitle" -->
<title>い翠澳酒┌訂┬專家</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
 input {font-family: "燦　砰"; font-size: 12px ;color:#666666}
 select {font-family: "燦　砰"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: 燦　砰}
 A:visited {text-decoration: none; color: #715922; font-family: 燦　砰}
 A:active {text-decoration: none; font-family: 燦　砰}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "燦　砰", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "燦　砰"; font-size: 12px}
-->
</style>
</head>
<%@ page import="com.cig.*" %>
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" /> 

<%
    String ticketAgencyID = request.getParameter("ticketAgencyID").trim();
    String seatClass = request.getParameter("seatClass").trim();
    String d_Year = request.getParameter("d_Year").trim();
    String d_Month = request.getParameter("d_Month").trim();
    String d_Day = request.getParameter("d_Day").trim();
    String flight_ID = request.getParameter("flight_ID").trim();
    String flight_Seq = request.getParameter("flight_Seq");
    
    String takeoff_Time = request.getParameter("takeoff_Time").trim();
    String curr_Price = request.getParameter("curr_Price").trim();
    String currency= request.getParameter("currency").trim();
    

    String round_Trip = request.getParameter("round_Trip").trim();
    
    String a_Year ="";
    String a_Month = "";
    String a_Day = "";
    String seatClass_A = "";
    String flight_ID_A = "";
    String takeoff_Time_A = "";
    String curr_Price_A = "";
    String currency_A = "";
    String flight_Seq_A = "";
    if(round_Trip.equals("R")){
    round_Trip="R";
    a_Year = request.getParameter("a_Year").trim();
    a_Month = request.getParameter("a_Month").trim();
    a_Day = request.getParameter("a_Day").trim();
    seatClass_A = request.getParameter("seatClass_A").trim();
    flight_ID_A = request.getParameter("flight_ID_A").trim();
    flight_Seq_A = request.getParameter("flight_Seq_A");
    takeoff_Time_A = request.getParameter("takeoff_Time_A").trim();
    curr_Price_A = request.getParameter("curr_Price_A").trim();
    currency_A = request.getParameter("currency_A").trim();
    }
    else{round_Trip="O";}
    
    String currentPage="./flight/FlightDestine.jsp?ticketAgencyID="+ticketAgencyID+"&seatClass="+seatClass+"&d_Year="+d_Year+"&d_Month="
    +d_Month+"&d_Day="+d_Day+"&flight_ID="+flight_ID+"&takeoff_Time="+takeoff_Time+"&curr_Price="+curr_Price+"&currency="+currency+"&flight_Seq="+flight_Seq
    +"&round_Trip="+round_Trip+"&a_Year="+a_Year+"&a_Month="+a_Month+"&a_Day="+a_Day+"&seatClass_A="+seatClass_A+"&flight_ID_A="+flight_ID_A
    +"&takeoff_Time_A="+takeoff_Time_A+"&curr_Price_A="+curr_Price_A+"&currency_A="+currency_A+"&flight_Seq_A="+flight_Seq_A;
    
    
%>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" />
<%  UserInfo.setCurrentPage(currentPage);
if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="../notAuthorized.jsp" />
	</jsp:forward>
<%}
%>

<%
String cust_id=UserInfo.getCustId(); %>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language=javascript>
<!-- //

var placeID = new Array ('pg2', 'pg3', 'pg4', 'pg5', 'pg6');
var placeID_A = new Array ('pg2_A', 'pg3_A', 'pg4_A', 'pg5_A', 'pg6_A');
var passengerID = new Array ('passenger1', 'passenger1e', 'passenger2', 'passenger2e', 'passenger3','passenger3e', 'passenger4', 'passenger4e', 'passenger5', 'passenger5e', 'passenger6', 'passenger6e');
var passengerID_A = new Array ('passenger1_A', 'passenger1e_A', 'passenger2_A', 'passenger2e_A', 'passenger3_A','passenger3e_A', 'passenger4_A', 'passenger4e_A', 'passenger5_A', 'passenger5e_A', 'passenger6_A', 'passenger6e_A');
var pos = 1;
var idName,idNamee;
var i=1;
ie=document.all?1:0; netscape=document.layers?1:0;
visible=ie?'visible':'show'; hidden=ie?'hidden':'hide';

function passengerCheck(){
   pos=document.frmPost.quantity.options[document.frmPost.quantity.selectedIndex].value;
   document.frmPost.passenger.value="";
   tmpValue="";
   for(i=0;i<pos*2;i++){
	 idName=new makeObj(passengerID[i]);
	 if(i%2==0){
	 k=i+1;
	 idNamee=new makeObj(passengerID[k]);
	 if(idNamee.value.length>0&&idName.value.length>0){
	   tmpValue=idName.value+"-"+idNamee.value;
	 	 }else{
	  tmpValue=idName.value+idNamee.value;
	 	}
	 }
	 if(tmpValue.length<=0){
	  document.frmPost.passenger.value="";
	  alert("請輸入姓名 !\n");
          idName.focus();
          return false;
	 }
	 else{
	 i++;
	 if(i==(2*pos-1)){
	 document.frmPost.passenger.value+=tmpValue;
	 }else{
	 document.frmPost.passenger.value+=tmpValue+";";
	 }
	 }
    }
   return true;
}

function passengerCheck_A(){
   pos=document.frmPost.quantity_A.options[document.frmPost.quantity_A.selectedIndex].value;
    document.frmPost.passenger_A.value="";
   tmpValue="";
   for(i=0;i<pos*2;i++){
	 idName=new makeObj(passengerID_A[i]);
	 if(i%2==0){
	 k=i+1;
	 idNamee=new makeObj(passengerID_A[k]);
	 if(idNamee.value.length>0&&idName.value.length>0){
	  tmpValue=idName.value+"-"+idNamee.value;
	 	 }else{
	  tmpValue=idName.value+idNamee.value;
	 	}
	 }
	 if(tmpValue.length<=0){
	  document.frmPost.passenger_A.value="";
	  alert("請輸入姓名 !\n");
          idName.focus();
          return false;
	 }
	 else{
	 i++;
	 if(i==(2*pos-1)){
	 document.frmPost.passenger_A.value+=tmpValue;
	 }else{
	 document.frmPost.passenger_A.value+=tmpValue+";";
	 }
	 }
    }
   return true;
}

function checkdata(sWay){
if(passengerCheck() == true ){
 if(sWay=='R'){
  if(passengerCheck_A() != true){
  return;
  }
 }
 document.frmPost.submit();
 return;
}
  return;
}

function selectQuantity_A(){
	 pos=document.frmPost.quantity_A.options[document.frmPost.quantity_A.selectedIndex].value;
	 for(i=1;i<pos;i++){
	 idName=new makeAttr(placeID_A[i-1]);
	 idName.visibility='visible';
	 }
	 for(i=pos;i<6;i++){
	 idName=new makeAttr(placeID_A[i-1]);
	 idName.visibility='hidden';
	 }
	 if(pos==1){
	 document.all.pgtitle_A.style.visibility='hidden';
	 }
	 else{document.all.pgtitle_A.style.visibility='vislible';
	 }
	}

function selectQuantity(){
	 pos=document.frmPost.quantity.options[document.frmPost.quantity.selectedIndex].value;
	 for(i=1;i<pos;i++){
	 idName=new makeAttr(placeID[i-1]);
	 idName.visibility='visible';
	 }
	 for(i=pos;i<6;i++){
	 idName=new makeAttr(placeID[i-1]);
	 idName.visibility='hidden';
	 }
	 if(pos==1){
	 document.all.pgtitle.style.visibility='hidden';
	 }
	 else{document.all.pgtitle.style.visibility='visible';
	 }
	}
 
 function makeObj(obj) { 
	var vs=(netscape) ? eval('document.'+obj):eval('document.all.'+obj); 
	return vs; 
} 		
	
	function makeAttr(obj) { 
	var css=(netscape) ? eval('document.'+obj):eval('document.all.'+obj+'.style'); 
	return css; 
} 	
//-->
</script>
<script language="JavaScript" src="/javascript/big/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr> 
    <td width="664" height="34"> 
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr> 
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/big/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom">==&gt;&gt;<!-- #BeginEditable "top" -->机票預訂<!-- #EndEditable --></td>
          <td width="415" background="/images/top_back.gif" height="34">&nbsp;</td>
          <td width="19" height="34"><img src="/images/top_right.gif" width="19" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td colspan="3" valign="top"><!-- #BeginEditable "main" -->
     <form method="post" name="frmPost" action="FlightAddPost.jsp">
     <input type=hidden name=cust_id value="<%=cust_id%>">
     <input type=hidden name=ticketAgencyID value="<%=ticketAgencyID%>">
     <input type=hidden name=seatClass value="<%=seatClass%>">
     <input type=hidden name=d_Year value="<%=d_Year%>">
     <input type=hidden name=d_Month value="<%=d_Month%>">
     <input type=hidden name=d_Day value="<%=d_Day%>">
     <input type=hidden name=flight_ID value="<%=flight_ID%>">
     <input type=hidden name=takeoff_Time value="<%=takeoff_Time%>">
     <input type=hidden name=curr_Price value="<%=curr_Price%>">
     <input type=hidden name=currency value="<%=currency%>">
     <input type=hidden name=flight_Seq value="<%=flight_Seq%>">
     <input type=hidden name=passenger value="" >
     <input type=hidden name=passenger_A value="" >
     <input type=hidden name=a_Year value="<%=a_Year%>">
     <input type=hidden name=a_Month value="<%=a_Month%>">
     <input type=hidden name=a_Day value="<%=a_Day%>">
     <input type=hidden name=seatClass_A value="<%=seatClass_A%>">
     <input type=hidden name=flight_ID_A value="<%=flight_ID_A%>">
     <input type=hidden name=takeoff_Time_A value="<%=takeoff_Time_A%>">
     <input type=hidden name=curr_Price_A value="<%=curr_Price_A%>">
     <input type=hidden name=currency_A value="<%=currency_A%>">
     <input type=hidden name=round_Trip value="<%=round_Trip%>">
     <input type=hidden name=flight_Seq_A value="<%=flight_Seq_A%>">
        <table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr align="center"> 
            <td height="60"> 
              <p><font color="#666666" class="bigtxt"></font></p>
              <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b>出發机票</b></font></span></td>
                </tr>
                <tr align="center"> 
                  <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp; 
              <table width="450" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04">
                <tr valign="middle"> 
                  <td width="340"> 
                    <table width="450" border="0" cellspacing="0" cellpadding="0" align="center" height="274">
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">航班號：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"><%=flight_ID%></td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">起飛時間：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"><%=d_Year%> 年 <%=d_Month%>月 <%=d_Day%>日 <%=takeoff_Time%></td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">顧客姓名：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"> 中文： 
                         <input type="text" name="passenger1" maxlength="8" size="8">
                          英文/拼音： 
                          <input type="text" name="passenger1e" maxlength="8" size="8">
                        </td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td>机票數量：</td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"> 
                          <select name="quantity" ONCHANGE="javascript:selectQuantity();">
                            <option VALUE="1" selected >1</option>
                            <option VALUE="2">2</option>
                            <option VALUE="3">3</option>
                            <option VALUE="4">4</option>
                            <option VALUE="5">5</option>
                            <option VALUE="6">6</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">价格/幣別：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"><%if(curr_Price!=null){%><%=currency%><%=curr_Price%><%}else{%> 請電 <%}%></td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">艙位等級：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"> 
                          <select name="hseatClass" disabled >
                            <option <%if(seatClass.equals("E")){%> selected <%}%> >經濟艙</option>
                            <option <%if(seatClass.equals("B")){%> selected <%}%>> 公務艙</option>
                            <option <%if(seatClass.equals("F")){%> selected <%}%>>頭等艙</option>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td height="103" width="140" valign="top">&nbsp; 
                          <div id="pgtitle" style="position:absolute; width:121px; height:26px; left: 171px; top: 386px; z-index:1; visibility: hidden"> 
                            <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                              <tr align="center"> 
                                <td><font color="#000000">其他乘客：</font></td>
                              </tr>
                            </table>
                          </div>&nbsp;
                            </td>
                        <td height="103" width="310">&nbsp;&nbsp; 
                          <div id="pg2" style="position:absolute; width:289px; height:40px; z-index:1; top: 352px; left: 305px; visibility: hidden"> 
                            <br>
                            中文：
                        <input type="text" name="passenger2" maxlength="8" size="8" onMouseOver="this.focus()">
                          英文/拼音： 
                          <input type="text" name="passenger2e" maxlength="8" size="8" onMouseOver="this.focus()" >
                          <br>
                        </div>
                          <div id="pg3" style="position:absolute; width:289px; height:40px; z-index:1; top: 373px; left: 306px; visibility: hidden"> 
                            <br>
                          中文： 
                          <input type="text" name="passenger3" maxlength="8" size="8" onMouseOver="this.focus()" >
                          英文/拼音： 
                          <input type="text" name="passenger3e" maxlength="8" size="8" onMouseOver="this.focus()" >
                          <br>
                          </div>
                          <div id="pg4" style="position:absolute; width:292px; height:29px; z-index:1; left: 306px; top: 394px; visibility: hidden"> 
                            <br>
                            中文： 
                          <input type="text" name="passenger4" maxlength="8" size="8" onMouseOver="this.focus()">
                          英文/拼音： 
                          <input type="text" name="passenger4e" maxlength="8" size="8" onMouseOver="this.focus()" >
                          <br>
                          </div>
                          <div id="pg5" style="position:absolute; width:292px; height:29px; z-index:1; left: 307px; top: 416px; visibility: hidden"> 
                            <br>
                            中文： 
                        <input type="text" name="passenger5" maxlength="8" size="8" onMouseOver="this.focus()" >
                        英文/拼音： 
                        <input type="text" name="passenger5e" maxlength="8" size="8" onMouseOver="this.focus()" >
                          <br>
                          </div>
                          <div id="pg6" style="position:absolute; width:292px; height:36px; z-index:1; left: 307px; top: 438px; visibility: hidden"> 
                            <br>
                            中文： 
                        <input type="text" name="passenger6" maxlength="8" size="8" onMouseOver="this.focus()" >
                          英文/拼音： 
                        <input type="text" name="passenger6e" maxlength="8" size="8" onMouseOver="this.focus()" >
                         <br>
                         </div>&nbsp;
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <font color="#666666"> </font> </td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;</td>
          </tr>
        </table>
        <br>
        <%if(round_Trip.equals("R")){%>
        <table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr align="center"> 
            <td height="60"> 
              <p><font color="#666666" class="bigtxt"></font></p>
              <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b><font color="#000000">返程机票</font></b></font></span></td>
                </tr>
                <tr align="center"> 
                  <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp; 
              <table width="450" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04">
                <tr valign="middle"> 
                  <td width="340"> 
                    <table width="450" border="0" cellspacing="0" cellpadding="0" align="center" height="241">
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">航班號：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"><%=flight_ID_A%></td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">起飛時間：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"><%=a_Year%> 年 <%=a_Month%>月 <%=a_Day%>日 <%=takeoff_Time_A%></td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">顧客姓名：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"> 中文： 
                          <input type="text" name="passenger1_A" maxlength="8" size="8">
                          英文/拼音： 
                          <input type="text" name="passenger1e_A" maxlength="8" size="8">
                        </td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td>机票數量：</td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"> 
                          <select name="quantity_A" ONCHANGE="javascript:selectQuantity_A();" >
                            <option VALUE="1" selected >1</option>
                            <option VALUE="2">2</option>
                            <option VALUE="3">3</option>
                            <option VALUE="4">4</option>
                            <option VALUE="5">5</option>
                            <option VALUE="6">6</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">价格/幣別：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"><%if(curr_Price_A!=null){%><%=currency_A%><%=curr_Price_A%><%}else{%> 請電 <%}%></td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">艙位等級：</font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="310"> 
                          <select name="select2" disabled >
                            <option <%if(seatClass_A.equals("E")){%> selected <%}%> >經濟艙</option>
                            <option <%if(seatClass_A.equals("B")){%> selected <%}%>> 公務艙</option>
                            <option <%if(seatClass_A.equals("F")){%> selected <%}%>>頭等艙</option>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td height="121" width="140" valign="top"> &nbsp; 
                          <div id="pgtitle_A"  style="position:absolute; width:117px; height:30px; left: 185px; top: 810px; z-index:1; visibility: hidden"> 
                            <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                              <tr align="center"> 
                                <td><font color="#000000">其他乘客：</font></td>
                              </tr>
                            </table>
                          </div>
                        </td>
                        <td height="121" width="310"> 
                          <div id="pg2_A" style="position:absolute; width:289px; height:40px; z-index:1; top: 761px; left: 306px; visibility: hidden"> 
                            <br>
                            中文：
                        <input type="text" name="passenger2_A" maxlength="8" size="8">
                          英文/拼音： 
                          <input type="text" name="passenger2e_A" maxlength="8" size="8">
                          <br>
                        </div>
                          <div id="pg3_A" style="position:absolute; width:289px; height:40px; z-index:1; top: 785px; left: 314px; visibility: hidden"> 
                            <br>
                          中文： 
                          <input type="text" name="passenger3_A" maxlength="8" size="8">
                          英文/拼音： 
                          <input type="text" name="passenger3e_A" maxlength="8" size="8">
                          <br>
                          </div>
                          <div id="pg4_A" style="position:absolute; width:292px; height:29px; z-index:1; left: 324px; top: 815px; visibility: hidden"> 
                            <br>
                            中文： 
                          <input type="text" name="passenger4_A" maxlength="8" size="8">
                          英文/拼音： 
                          <input type="text" name="passenger4e_A" maxlength="8" size="8">
                          <br>
                          </div>
                          <div id="pg5_A" style="position:absolute; width:292px; height:29px; z-index:1; left: 318px; top: 831px; visibility: hidden"> 
                            <br>
                            中文： 
                        <input type="text" name="passenger5_A" maxlength="8" size="8">
                        英文/拼音： 
                        <input type="text" name="passenger5e_A" maxlength="8" size="8">
                          <br>
                          </div>
                          <div id="pg6_A" style="position:absolute; width:292px; height:36px; z-index:1; left: 320px; top: 843px; visibility: hidden"> 
                            <br>
                            中文： 
                        <input type="text" name="passenger6_A" maxlength="8" size="8">
                          英文/拼音： 
                        <input type="text" name="passenger6e_A" maxlength="8" size="8">
                         <br>
                         </div>&nbsp;
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <font color="#666666"> </font> </td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;</td>
          </tr>
        </table>
        <%}%>
        <br>
        <table width="450" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04" align="center">
          <tr valign="middle" align="center"> 
             <td width="340"> 
               <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                  <tr align="center" bgcolor="#CFC8CF"> 
                    <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                      </tr>
                      <tr align="center"> 
                        <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b>聯系信息</b></font></span></td>
                      </tr>
                      <tr align="center"> 
                        <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                      </tr>
                    </table>
                    <br>
                    <table width="333" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr> 
                        <td align=left height="18" width="363"> 姓&nbsp;&nbsp;&nbsp;&nbsp;名： 
                          <input name="userName" size="10" maxlength="20" value="<%=Convert.g2b(UserInfo.getRealName())%>" >
                          <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"></font> 
                          &nbsp;&nbsp;&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;別： 
                          <select name="gender" >
                            <option value="M" <%if(UserInfo.getGender().equals("M")){%>selected<%}%> >先生</option>
                            <option value="F" <%if(UserInfo.getGender().equals("F")){%>selected<%}%> >女士</option>
                          </select>
                          <br>
                          郵&nbsp;&nbsp;&nbsp;&nbsp;編： 
                          <input name="postcode" value="<%=Convert.g2b(UserInfo.getPostCode())%>" size="6" maxlength="10">
                          <br>
                          通訊地址： 
                          <input name="address" value="<%=Convert.g2b(UserInfo.getAddress())%>" size="30" maxlength="100">
                          <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"> 
                          </font><br>
                          電子郵件： 
                          <input name="email" value="<%=Convert.g2b(UserInfo.getEmail())%>" size="30" maxlength="100">
                          <br>
                          <table width="330" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td colspan="2" valign="top">電&nbsp;&nbsp;&nbsp;&nbsp;話： 
                                <input type="text" name="phone" size="15" value="<%=Convert.g2b(UserInfo.getTel())%>" >
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="2" valign="top">傳&nbsp;&nbsp;&nbsp;&nbsp;真： 
                               <input type="text" name="fax" size="15" value="<%=Convert.g2b(UserInfo.getFax())%>"  >
                              </td>
                            </tr>
                          </table>
                          手&nbsp;&nbsp;&nbsp;&nbsp;机： 
                          <input type="text" name="mobile" size="12" maxlength="12" value="<%=Convert.g2b(UserInfo.getMobile())%>">
                        </td>
                      </tr>
                    </table>
                    <div align="center"></div>
                  </td>
        </tr>
        </table>
        <table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <div align="center"><a href="javascript:checkdata('<%=round_Trip%>');"><img src="/images/big/enter_air1.gif" width="138" height="18" border="0"></a></div>
            </td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
  <tr align="center"> 
            <td colspan="3" height="20"><a href="javascript:window.history.go(-1)">返回</a></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
<%@ include file="../foot_tel.jsp"%>  
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <script language="JavaScript" src="/javascript/big/foot.js">
</script>
</table>
</body>
<!-- #EndTemplate -->
</html>

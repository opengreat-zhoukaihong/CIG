<html>
<%@ page import="java.util.*, java.net.*"%>
<%java.util.Date date=new Date();
int nowYear=date.getYear();
nowYear-=100;
String nowYears="";
if(nowYear<10)nowYears="0"+nowYear;
int nowMonth=date.getMonth()+1;
int nowDay=date.getDate();
String nowDate=nowYears+"-"+nowMonth+"-"+nowDay;
%>
<head>
<!-- #BeginEditable "doctitle" --> 
<title>Specialist of hotelbooking in Mainland China, Hong Kong and Macao</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
 input {font-family: "Verdana"; font-size: 12px ;color:#666666}
 select {font-family: "Verdana"; color:#666666}
 A:link {text-decoration: none; color: #715922; font-family: Verdana}
 A:visited {text-decoration: none; color: #715922; font-family: Verdana}
 A:active {text-decoration: none; font-family: Verdana}
 A:hover {text-decoration: underline; color:#CAA54D}
 td {font-family: "Verdana", "Times New Roman";font-size: 12px;}
 .email { font-size: 7.5pt}
 .title { font-size: 14pt; font-weight: bold}
 .txt { font-size: 9pt; line-height: 12pt}
 .bigtxt { font-size: 11pt; line-height: 15pt}
 .copyright { font-size: 8pt; color: #000000}
.star { font-size: 9px; color: #FF8000}
.pt9 {  font-family: "Verdana"; font-size: 12px}
-->
</style>
</head>
<%
    String tour_Line_ID=request.getParameter("tour_Line_ID").trim();
    String price=request.getParameter("price").trim();
    String weekdays=request.getParameter("weekdays").trim();
    String opendays=request.getParameter("opendays").trim();
    String currentPage="./tour/TourDestine.jsp?tour_Line_ID="+tour_Line_ID+"&price="+price+"&weekdays="+URLEncoder.encode(weekdays)+"&opendays="+URLEncoder.encode(opendays);
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
String cust_id=UserInfo.getCustId(); 
%>

<jsp:useBean id="TourViewDetail" scope="page" class="com.cnbooking.tour.TourViewDetail" /> 
<%
    TourViewDetail.setLangCode("EN");
    TourViewDetail.setTour_Line_ID(tour_Line_ID);
    TourViewDetail.getTourDetail();
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language=javascript>
<!-- //
function submitdata(){
        if(document.frmPost.userName.value.length==0){
                        window.alert("Please enter your name !");
			document.frmPost.userName.focus();
			return;
        }
	else if((numericCheck() == true )&&(DateSubmit_Check() == true)) {
		if(Week_Check() == true){
			document.frmPost.submit();
		  }
                  else{ 
		  return;}
		}
		else{ 
		return;}
	}

 function numericCheck(){
   nr1=document.frmPost.quantity.value;
   if(nr1.length==0){
   alert("man number must greater than 1 !\n");
   document.frmPost.quantity.focus();
   return false;
   }
   cmp="123456789";
   tst=nr1.substring(0,1);
   if(cmp.indexOf(tst)<0){
   alert("man number must greater than 1 and just numeric !\n");
   document.frmPost.quantity.focus();
   return false;
   }
   cmp="0123456789";
   for (var i=1;i<nr1.length;i++){
   tst=nr1.substring(i,i+1);
   if(cmp.indexOf(tst)<0){
   alert("man number must greater than 1 and just numeric !\n");   
   document.frmPost.quantity.focus();
   return false;
   }
  }
return true;
}
//-->
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--//
 var prices = new Array ("<%=TourViewDetail.getPrice0()%>", "<%=TourViewDetail.getPrice1()%>", "<%=TourViewDetail.getPrice2()%>", "<%=TourViewDetail.getPrice3()%>", "<%=TourViewDetail.getPrice4()%>", "<%=TourViewDetail.getPrice5()%>", "<%=TourViewDetail.getPrice6()%>");
        function  Week_Check(){
        var weekds,date1,k
          date1=new Date(document.frmPost.dDatePeriod1.value);
          k=date1.getDay();
          weekds=document.frmPost.weekdays.value;
          if(weekds.charAt(k)=='1'){
          document.frmPost.curr_Price.value=prices[k];
            return true;
          }
          window.alert("Attention please,the departure day is the "+k+"day of a week,no work! ");
          return false;
        }

	function DateSubmit_Check()
	{
	     document.frmPost.dDatePeriod1.value = document.frmPost.d_Month.options[document.frmPost.d_Month.selectedIndex].value + "-" + document.frmPost.d_Day.options[document.frmPost.d_Day.selectedIndex].value+"-"+document.frmPost.d_Year.options[document.frmPost.d_Year.selectedIndex].value
	     if (!isValidDate(document.frmPost.d_Year.options[document.frmPost.d_Year.selectedIndex].value, document.frmPost.d_Month.options[document.frmPost.d_Month.selectedIndex].value, document.frmPost.d_Day.options[document.frmPost.d_Day.selectedIndex].value))
	     {
				window.alert("Sorry, "+document.frmPost.d_Year.options[document.frmPost.d_Year.selectedIndex].value+"-"+document.frmPost.d_Month.options[document.frmPost.d_Month.selectedIndex].value+"-"+document.frmPost.d_Day.options[document.frmPost.d_Day.selectedIndex].value+" the day not exist, please check the departure date !");
    			        document.frmPost.d_Day.focus();
				return false;
	     }
	     if ( (new Date(document.frmPost.dDatePeriod1.value)) < parseDate(document.frmPost.curDate.value) )
	      {
        	   window.alert("Attention please, the departure date cannot earlier than today !");
		   document.frmPost.d_Year.focus();
		   return false;
	      }
	return true;
	} 
//-->
</SCRIPT>
<script language=javascript>							

function parseDate(sString, sInFormat) {						
  var sResult,undefined										
  if (sInFormat==undefined) sResult = formatDateString(sString,'M-D-YYYY')		
  else sResult = getDateString(sString, sInFormat,'M-D-YYYY')	
  var iDel1,iDel2,iY,iM,iD,sDelimiter;	
  if ( sResult != '' )	{										
		sDelimiter = getDateDelimiter(sResult);								
		iDel1 = sResult.indexOf(sDelimiter,0);     iDel2 = sResult.indexOf(sDelimiter,iDel1 + 1);		
		iY = sResult.substr(iDel2+1,sResult.length-(iDel2+1)); 
		iM = sResult.substr(0,iDel1);} 
		iD = sResult.substr(iDel1+1,iDel2-(iDel1+1)); 
  if ( sResult == '' )  return (new Date(1900,0,1))			
  else                  return (new Date(iY,iM-1,iD))  }			

function formatDateString(sString, sOutFormat){ var sResult						
  sResult = getDateString(sString, 'YMD', sOutFormat)								
  if (sResult=='') sResult = getDateString(sString, 'MDY', sOutFormat)				
  if (sResult=='') sResult = getDateString(sString, 'DMY', sOutFormat)				
  return sResult }																	

function formatDate(dDate, sOutFormat){ var undefined			
  if (dDate == undefined) return ''							
  else return OutFormatDatePortion(dDate.getYear(), dDate.getMonth() + 1, dDate.getDate(), sOutFormat) }	

function isValidDateString(sString, sInFormat) {								
   var sResult,undefined														
   if ( sInFormat == undefined) sResult = formatDateString(sString);	
   else  sResult = getDateString(sString, sInFormat);									
   if (sResult == '') return false;	  else   return true; }					
function isValidDateTime(sDateTime,sDateFormat,sTimeFormat)
{	var asDateTime = new Array()
	asDateTime = sDateTime.split(' ')
	if (asDateTime.length != 2) return false
	if (! isValidDateString(asDateTime[0],sDateFormat)) return false
	if (! isValidTimeString(asDateTime[1],sTimeFormat)) return false
	return true
}

function isValidTimeString(sTime,sInFormat)
{	var aiTime = new Array()
	var sTimeFormat
	var undefined
	if (sInFormat==undefined) sTimeFormat = 'HHMMSS'
	else sTimeFormat = sInFormat.toString();
	sTime = sTime.toString()
	if (sTimeFormat.indexOf(':') > 0)
	{	aiTime = sTime.split(':');
		return isValidTime(aiTime);
	}
	else
	{	if (sTimeFormat.length != sTime.length) return false
		if (sTimeFormat.length == 4 || sTimeFormat.length == 6)
			aiTime[0] = sTime.substr(0,2)
			aiTime[1] = sTime.substr(2,2)
			if (sTimeFormat.length == 6) aiTime[2] = sTime.substr(4,2)
		else
			return false
	}
}

function isValidTime(aiTime)
{	if (aiTime.length == 2 || aiTime.length == 3)
	{	if (aiTime[0] < 0 || aiTime[0] > 23) return false
		if (aiTime[1] < 0 || aiTime[1] > 59) return false
		if (aiTime.length == 3)
			if (aiTime[2] < 0 || aiTime[2] > 59) return false
		return true
	}
	else
		return false
}

function getDateString(sString, sInFormat, sOutFormat, sDelimiter){	
  var undefined														
  var sResult=''														
  var sY, sM, sD														
  var iDml1, iDml2														
  if ( sString == undefined || sString.toString() == '' || sString.length < 6)    return sResult		
  else sString = sString.toString().toUpperCase()														
  if ( sDelimiter == undefined)   sDelimiter = ''														
  if ( sInFormat == undefined || sInFormat.toString() == '' )											
     { sInFormat = 'YMD';  if (sDelimiter=='') sDelimiter = getDateDelimiter(sString) ; }				
  else    { sInFormat = sInFormat.toUpperCase();														
			 if (sDelimiter == '')  sDelimiter = getDateDelimiter(sInFormat)							
			 if (sDelimiter == '')  sDelimiter = getDateDelimiter(sString)								
			 else sInFormat = sInFormat.replace(sDelimiter,'').replace(sDelimiter,'')					
            sInFormat = sInFormat.replace('YYYY','Y').replace('YYY','Y').replace('YY','Y').replace('MM','M').replace('DD','D')}			
  if (sDelimiter == '')   {																			
		if (sString.length ==8)  {																		
			eval('sY=sString.substr('+(sInFormat.indexOf('Y',0)*2)+',4)')								
	        eval('sString=sString.substring(0,'+(sInFormat.indexOf('Y',0)*2)+')+sString.substring('+(sInFormat.indexOf('Y',0)*2 + 4)+',sString.length)')				
			sInFormat = sInFormat.replace('Y','')      }												
		else if (sString.length ==6)      {																
			eval('sY=sString.substr('+(sInFormat.indexOf('Y',0)*2)+',2)')								
			eval('sString=sString.substring(0,'+(sInFormat.indexOf('Y',0)*2)+')+sString.substring('+(sInFormat.indexOf('Y',0)*2 + 2)+',sString.length)')				
			sInFormat = sInFormat.replace('Y','')	   }												
		else			      return sResult;															
	    eval('s'+sInFormat.substr(0,1) + '=sString.substr(0,2)')										
		eval('s'+sInFormat.substr(1,1) + '=sString.substr(2,2)')		   }							
  else        {																						
		iDel1 = sString.indexOf(sDelimiter,0);     iDel2 = sString.indexOf(sDelimiter,iDel1 + 1);		
		if (iDel1 == -1 || iDel2==-1) return sResult													
	    eval('s'+sInFormat.substr(0,1) + '=sString.substr(0,'+iDel1 + ')')								
		eval('s'+sInFormat.substr(1,1) + '=sString.substring('+(iDel1+1)+','+iDel2.toString()+')')		
		eval('s'+sInFormat.substr(2,1) + '=sString.substring('+(iDel2+1)+','+sString.length+')')  }		
  if (isValidDate(sY,sM,sD)) sResult = outFormatDatePortion(sY,sM,sD,sOutFormat)						
  return sResult    }																					
function isLeapYear(iYear) { var undefined						
  if ( iYear != undefined && !isNaN(iYear) && iYear > 0 &&		
       (iYear%4==0 && iYear%100 !=0 || iYear%400==0)   )		
      return true												
	else return false }											
function isValidDate(iY, iM, iD) { var undefined									
  if ( iY != undefined && !isNaN(iY) && iY >=0 && iY<=9999 &&						
       iM != undefined && !isNaN(iM) && iM >=1   && iM<=12   &&					
       iD != undefined && !isNaN(iD) && iD >=1   && iD<=31  )  {					
       if (iY<50) iY = 2000+iY; else if (iY<100) iY=1900+iY;						
    if (iM == 2  && (isLeapYear(iY)  && iD > 29 || !isLeapYear(iY) && iD>28) ||	
        iD == 31 && (iM<7 && iM%2==0 || iM>7 && iM%2==1) )							
		return false																
	else	return true      }														
 else  return false }																

function getDateDelimiter(sFormatString){ var undefined				
  if (sFormatString == undefined)            return  ''				
  if (sFormatString.indexOf('-',0) > 0)		 return  '-'			
  else if (sFormatString.indexOf('/',0) > 0) return  '/'				
  else if (sFormatString.indexOf('.',0) > 0) return  '.'				
  else									     return ''	}				

function outFormatDatePortion(sY,sM,sD,sOutFormat) { var undefined		
  var sDelimiter, sResult												
  var iY,iM,iD, i1,i2,i3,sU=''											
  if ( sOutFormat == undefined || sOutFormat.toString() == '' )		
	{ sOutFormat = 'MDY';  sDelimiter = new Array('','-','-','');		
	  if (sY.toString().length == 2) { if ( parseInt(sY)<50 ) sY = '20'+sY; else sY = '19'+sY; } }	
  else   { sOutFormat = sOutFormat.toUpperCase()						
       if (sOutFormat.indexOf('YYYY') != -1 && sY.toString().length == 2) { if ( parseInt(sY)<50 ) sY = '20'+sY; else sY = '19'+sY; }	
	    if (sOutFormat.indexOf('MM') != -1 && sM.toString().length == 1) sM = '0'+sM													
		if (sOutFormat.indexOf('DD') != -1 && sD.toString().length == 1) sD = '0'+sD													
	    sOutFormat = sOutFormat.replace('YYYY','Y').replace('YYY','Y').replace('YY','Y').replace('MM','M').replace('DD','D')			
       iY = sOutFormat.indexOf('Y'); iM = sOutFormat.indexOf('M'); iD = sOutFormat.indexOf('D')										
		{i1=Math.min(iY,Math.min(iM,iD)); i2=(iY>iM)?Math.min(iY,Math.max(iM,iD)):(Math.min(iM,Math.max(iD,iY)));  i3=Math.max(iY,Math.max(iM,iD));}				
       if (i3 == -1) return ''																											
        else if (i2==-1)  {																											
			sDelimiter = new Array(sOutFormat.substring(0,i3),'','',sOutFormat.substring(i3+1,sOutFormat.length))						
			sOutFormat = 'UU'+sOutFormat.substr(i3,1)    }																				
        else if (i1==-1) {																																					
	       sDelimiter = new Array(sOutFormat.substring(0,i2),'',sOutFormat.substring(i2+1,i3),sOutFormat.substring(i3+1,sOutFormat.length))									
			sOutFormat = 'U'+sOutFormat.substr(i2,1)+sOutFormat.substr(i3,1)    }																							
        else {																																								
			sDelimiter = new Array(sOutFormat.substring(0,i1),sOutFormat.substring(i1+1,i2),sOutFormat.substring(i2+1,i3),sOutFormat.substring(i3+1,sOutFormat.length))		
			sOutFormat = sOutFormat.substr(i1,1)+sOutFormat.substr(i2,1)+sOutFormat.substr(i3,1)    }	}																	
  eval("sResult='"+ sDelimiter[0] +"'+s"+sOutFormat.substr(0,1)+"+'"+sDelimiter[1]+"'+s"+sOutFormat.substr(1,1)+"+'"+sDelimiter[2]+"'+s"+sOutFormat.substr(2,1)+"+'"+sDelimiter[3]+"'" )	
  return sResult  }									

</script>
<table width="663" border="0" cellspacing="0" cellpadding="0" height="60" align="center">
  <tr> 
    <td colspan="2" height="60">
      <script language="JavaScript" src="/javascript/en/title.js">
</script>
    </td>
  </tr>
</table>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/en/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;City Tour</font><!-- #EndEditable --></td>
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
     <form method="post" name="frmPost" action="TourAddPost.jsp">
      <input type=hidden name=tour_Line_ID value="<%=tour_Line_ID%>">
      <input type=hidden name=weekdays value="<%=weekdays%>">
      <input type=hidden name=curDate value=<%=nowDate%>>
      <input type=hidden name=cust_id value="<%=cust_id%>">
      <input type=hidden name=curr_Price >
      <input type=hidden name=currency value="<%=TourViewDetail.getCurrency()%>">
      <input name=dDatePeriod1 type=hidden>
        <table border=0 width=600 cellpadding=0 cellspacing=0 align=CENTER>
          <tr> 
            <td width=115 align="center" valign="top"> 
              <table width="45" border="0" cellspacing="0" cellpadding="0" height="45">
                <tr> 
                  <td width="30" height="30">&nbsp;</td>
                </tr>
              </table>
              <%if(TourViewDetail.getFileName()!=null){%><img src="<%=TourViewDetail.getDir_ID()%>/<%=TourViewDetail.getFileName()%>" width="140" height="88"><%}else{%>&nbsp;<%}%>
            </td>
            <td width="4" valign="top"><img src="/images/space.gif" width="4" height="1" border="0"></td>
            <td width="1" bgcolor="#999999" valign="top"><img src="/images/space.gif" width="1" height="1" border="0"></td>
            <td width="5" valign="top"><img src="/images/space.gif" width="5" height="1" border="0"></td>
            <td width=500 valign="top"><br>
              <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><%=TourViewDetail.getTitle()%>&nbsp;</span><font color="#000000"> 
                    </font></td>
                </tr>
                <tr align="center"> 
                  <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
              </table>
              <br>
              <table border="0" width="100%" cellpadding="0" cellspacing="0">
                <tr> 
                  <td class="txt"><%=TourViewDetail.getTour_Sche()%>&nbsp;<br><br>
                    <b><font color="#000000">service content:</font></b><font color="#000000"></font><br>
                    &nbsp; 
                    <table width="450" border="0" cellspacing="0" cellpadding="2">
                      <tr> 
                        <td colspan="2" valign="top"><%=TourViewDetail.getServices()%>&nbsp;</td>
                      </tr>
                    </table>
                    <br>
                    <br>
                    <table width="358" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr> 
                        <td colspan="2"> 
                          <table width="358" border="1" cellspacing="0" cellpadding="4" align="center" bordercolorlight="#CCCCCC" bordercolordark="#FFFFFF">
                            <tr> 
                              <td height="26" width="25%"> 
                                <div align="right"><font color="#666666">work date:</font></div>
                              </td>
                              <td height="26" width="75%"> 
                                <div align="left"><%=opendays%></div>
                              </td>
                            </tr>
                            <tr> 
                              <td height="26" width="25%"> 
                                <div align="right"><font color="#666666">price:</font></div>
                              </td>
                              <td height="26" width="75%"> 
                                <div align="left"><%if(price!="1000000"){%> <%=TourViewDetail.getCurrency()%><%=price%><%}else{%>please call <%}%></div>
                              </td>
                            </tr>
                            <tr> 
                              <td height="26" width="25%"> 
                                <div align="right"><font color="#666666">quantity:</font></div>
                              </td>
                              <td height="26" width="75%">
                                <input type="text" name="quantity" size="2" maxlength="2">
                              </td>
                            </tr>
                            <tr> 
                              <td height="26" width="25%"> 
                                <div align="right"><font color="#666666">departure date:</font></div>
                              </td>
                              <td height="26" width="75%">
                                <div align="center">
                            <select class=Small size=1 name=d_Year>
                              <option value="2000" >2000</option>
                              <option value="2001" >2001</option>
                            </select>
                            year
                          <SELECT NAME=d_Month SIZE=1 Class=Small><%for(int i=1;i<13;i++){%><OPTION VALUE="<%=i%>" <%if(nowMonth==i){%>selected<%}%> ><%=i%></OPTION><%}%></select>month
                          <SELECT NAME=d_Day SIZE=1 Class=Small><%for(int i=1;i<32;i++){%><OPTION VALUE="<%=i%>" <%if(nowDay==i){%>selected<%}%> ><%=i%></OPTION><%}%></select>day
                          </div></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <br>
                    <table width="340" border="1" cellspacing="0" cellpadding="10" bordercolor="#FFBC04" align="center">
                      <tr> 
                        <td width="450"> 
                          <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                            <tr align="center" bgcolor="#CFC8CF"> 
                              <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                            </tr>
                            <tr align="center"> 
                              <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b>contact infomation</b></font></span></td>
                            </tr>
                            <tr align="center"> 
                              <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                            </tr>
                          </table>
                          <br>
                          <div align="center"> 
                            <table width="333" border="0" cellspacing="0" cellpadding="0" align="center">
                              <tr> 
                                <td align=left height="18" width="363"> User Name: 
                                  <input name="userName" size="10" maxlength="20" value="<%=UserInfo.getRealName()%>">
                                  <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"></font> 
                                  Sex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 
                                  <select name="gender" >
                                <option value="M" <%if(UserInfo.getGender().equals("M")){%>selected<%}%> >Male</option>
                                <option value="F" <%if(UserInfo.getGender().equals("F")){%>selected<%}%> >Female</option>
                                </select>
                                  <br>
                                  postcode&nbsp;&nbsp;&nbsp;&nbsp;: 
                                  <input name="postcode" value="<%=UserInfo.getPostCode()%>" size="6" maxlength="10">
                                  <br>
                                  address: 
                                  <input name="address" value="<%=UserInfo.getAddress()%>" size="30" maxlength="100">
                                  <font face="Arial, Helvetica, sans-serif" size="2" color="#6C6D6D"> 
                                  </font><br>
                                  E_mail: 
                                  <input name="email" value="<%=UserInfo.getEmail()%>" size="30" maxlength="100">
                                  <br>
                                  <table width="330" border="0" cellspacing="0" cellpadding="0">
                                    <tr> 
                                      <td colspan="2" valign="top">phone: 
                                        <input type="text" name="phone" size="15"  value="<%=UserInfo.getTel()%>" >
                                      </td>
                                    </tr>
                                    <tr> 
                                      <td colspan="2" valign="top">fax: 
                                        <input type="text" name="fax" size="15"   value="<%=UserInfo.getFax()%>">
                                      </td>
                                    </tr>
                                  </table>
                                  mobile: 
                                  <input type="text" name="mobile" size="12" maxlength="12" value="<%=UserInfo.getMobile()%>">
                                </td>
                              </tr>
                            </table>
                          </div>
                        </td>
                      </tr>
                    </table>
                    <br>
                    <table width="138" border="0" cellspacing="0" cellpadding="0" align="center" height="18">
                      <tr align="center" valign="middle"> 
                        <td><a href="javascript:submitdata();"><img src="/images/en/enter_tour.gif" width="138" height="18" border="0"></a></td>
                      </tr>
                    </table>
              </table>
        </table>
      </form>
      <table width="250" border="0" cellspacing="0" cellpadding="0" align="center" height="30">
        <tr align="center" valign="middle"> 
          <td><a href="javascript:window.history.go(-1)">back</a></td>
        </tr>
      </table>
      <!-- #EndEditable --></td>
  </tr>
  <tr> 
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
  <tr valign="middle" align="center"> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <td colspan="3" align="center"> <IFRAME width=560  height=350 MARGINWIDTH=0 MARGINHEIGHT=0 HSPACE=0 VSPACE=0 FRAMEBORDER=0 SCROLLING=no BORDERcolor=000000 SRC="/cnbooking/en/foot_tel.jsp"> 
    </IFRAME> <!--Here is ad end.--></td>
  </tr>
  <tr> 
    <td colspan="3" height="3"> 
      <script language="JavaScript" src="/javascript/en/foot.js">
</script>
    </td>
  </tr>
</table>
</body>
<!-- #EndTemplate --></html>

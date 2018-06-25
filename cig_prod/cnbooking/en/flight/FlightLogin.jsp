<%@ page import="java.util.*" %>
<%java.util.Date date=new Date();
int nowYear=date.getYear();
nowYear-=100;
String nowYears="";
if(nowYear<10)nowYears="0"+nowYear;
int nowMonth=date.getMonth()+1;
int nowDay=date.getDate();
String nowDate=nowYears+"-"+nowMonth+"-"+nowDay;
%>
<html>
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
<jsp:useBean id="FlightCity" scope="page" class="com.cnbooking.flight.FlightCity" /> 
<jsp:setProperty name="FlightCity" property="dateFrom" />
<jsp:setProperty name="FlightCity" property="dateTo" />
<%
    FlightCity.setLangCode("EN");
    FlightCity.setCityFlag("S");
    int cityCount=0;
    String[][] cityList;
    cityList = FlightCity.getCityList();
    cityCount = FlightCity.getCityCount();
%>
<jsp:useBean id="FlightAirline" scope="page" class="com.cnbooking.flight.FlightAirline" /> 
<jsp:setProperty name="FlightAirline" property="dateFrom" />
<jsp:setProperty name="FlightAirline" property="dateTo" />
<%
    FlightAirline.setLangCode("EN");
    int airlineCount=0;
    String[][] airlineList;
    airlineList = FlightAirline.getAirlineList();
    airlineCount = FlightAirline.getAirlineCount();
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="5">
<script language="javascript">
<!--//
function Search_check()
{

       	if (document.searchForm.homecity.options[document.searchForm.homecity.selectedIndex].value == "none")
		{
			window.alert("Please choose your departure place !");
			document.searchForm.homecity.focus();
			return;
		}
		else if (document.searchForm.destcity.options[document.searchForm.destcity.selectedIndex].value == "none")
		{
			window.alert("Please choose your destination place !");
			document.searchForm.destcity.focus();
			return;
		}
		else if (document.searchForm.homecity.options[document.searchForm.homecity.selectedIndex].value == document.searchForm.destcity.options[document.searchForm.destcity.selectedIndex].value)
		{
			window.alert(" the departure place is the same as the destination place,please choose again !");
			document.searchForm.homecity.focus();
			return;
		}
		if ( DateSubmit_Check() == true) 
		{
			document.searchForm.submit();
		}
		else 
			return;
	}
	function selectFormCity(){
	var posr=document.searchForm.homecity.options[document.searchForm.homecity.selectedIndex].value;
	document.searchForm.homecity1.value=posr;
	document.searchForm.ticketAgencyID1.options[document.searchForm.homecity.selectedIndex].selected=1;
	document.searchForm.ticketAgencyID.value=posr;
	}
//-->
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--//
	function DateSubmit_Check()
	{
	  		document.searchForm.dDatePeriod1.value = document.searchForm.d_Month.options[document.searchForm.d_Month.selectedIndex].value + "-" + document.searchForm.d_Day.options[document.searchForm.d_Day.selectedIndex].value+"-"+document.searchForm.d_Year.options[document.searchForm.d_Year.selectedIndex].value

		if (!isValidDate(document.searchForm.d_Year.options[document.searchForm.d_Year.selectedIndex].value, document.searchForm.d_Month.options[document.searchForm.d_Month.selectedIndex].value, document.searchForm.d_Day.options[document.searchForm.d_Day.selectedIndex].value))
		{
				window.alert("sorry, "+document.searchForm.d_Year.options[document.searchForm.d_Year.selectedIndex].value+"-"+document.searchForm.d_Month.options[document.searchForm.d_Month.selectedIndex].value+"-"+document.searchForm.d_Day.options[document.searchForm.d_Day.selectedIndex].value+"  this day not exist, please check departure date !");				
				document.searchForm.homecity.focus();
    			        document.searchForm.d_Day.focus();
				return false;
		}
	     if ( (new Date(document.searchForm.dDatePeriod1.value)) < parseDate(document.searchForm.curDate.value) )
	      {
		    window.alert("Attention please, the departure date cannot earlier than today !");		    
	            document.searchForm.homecity.focus();
		   document.searchForm.d_Year.focus();
		   return false;
	      }
	     if (document.searchForm.flightWay.value == 'Double')
	      {
	        document.searchForm.aDatePeriod1.value = document.searchForm.a_Month.options[document.searchForm.a_Month.selectedIndex].value + "-" + document.searchForm.a_Day.options[document.searchForm.a_Day.selectedIndex].value+"-"+document.searchForm.a_Year.options[document.searchForm.a_Year.selectedIndex].value
		if (!isValidDate(document.searchForm.a_Year.options[document.searchForm.a_Year.selectedIndex].value,document.searchForm.a_Month.options[document.searchForm.a_Month.selectedIndex].value,document.searchForm.a_Day.options[document.searchForm.a_Day.selectedIndex].value))
		{
			window.alert("sorry, "+document.searchForm.a_Year.options[document.searchForm.a_Year.selectedIndex].value+"-"+document.searchForm.a_Month.options[document.searchForm.a_Month.selectedIndex].value+"-"+document.searchForm.a_Day.options[document.searchForm.a_Day.selectedIndex].value+"  this day not exist, please check the return date !");			
			document.searchForm.homecity.focus();
			document.searchForm.a_Day.focus();
			return false;
		}		  
		if ( (new Date(document.searchForm.aDatePeriod1.value)) < (new Date(document.searchForm.dDatePeriod1.value)) )
		{
			window.alert("Attention please, the return date cannot earlier than departure day !");			
			document.searchForm.homecity.focus();
			document.searchForm.a_Day.focus();
			return false;
		} 
	   }
	document.searchForm.homecity1.value = document.searchForm.homecity.options[document.searchForm.homecity.selectedIndex].value;
	document.searchForm.destcity1.value = document.searchForm.destcity.options[document.searchForm.destcity.selectedIndex].value;
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
<script language="JavaScript" src="/javascript/en/title.js">
</script>
<table width="665" border="0" cellspacing="0" cellpadding="0" align="center" height="34">
  <tr>
    <td width="664" height="34">
      <table width="664" border="0" cellspacing="0" cellpadding="0" height="34">
        <tr>
          <td width="30" background="/images/top_back.gif" height="34" valign="bottom"><a href="/cnbooking/en/index.jsp"><img src="/images/home.gif" width="14" height="14" align="right" border="0"></a></td>
          <td width="200" background="/images/top_back.gif" height="34" valign="bottom"><!-- #BeginEditable "top" --><font color="#666666">==&gt;&gt;Flight Line</font><!-- #EndEditable --></td>
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
      <form name=searchForm method=post action=FlightSearchList.jsp>
      <input type=hidden name=curDate value=<%=nowDate%>>
        <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr align="center"> 
            <td height="60"> 
              <p><font color="#666666" class="bigtxt"></font></p>
              <table width=200 border=0 cellpadding=0 cellspacing=0 bgcolor=#FFBC04 align="center">
                <tr align="center" bgcolor="#CFC8CF"> 
                  <td height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
                <tr align="center"> 
                  <td><span class="bigtxt"><font color="#666666" class="bigtxt"><b><font color="#000000">Search Flight</font></b></font></span></td>
                </tr>
                <tr align="center"> 
                  <td bgcolor="#CFC8CF" height="3"><img src="/images/space.gif" width="1" height="3"></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;&nbsp;&nbsp;&nbsp; 
              <table width="380" border="1" cellspacing="0" cellpadding="0" bordercolor="#FFBC04" align="center">
                <tr valign="middle" align="center"> 
                  <td width="340">
                    <table width="380" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">Departure: </font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="280">
                        <input name=homecity1 type=hidden > 
                        <SELECT NAME=homecity CLASS="Small" ONCHANGE="javascript:selectFormCity()" STYLE="WIDTH:220px">
	                <OPTION VALUE="none">choose departure city</OPTION>
	                <option value=none>--------------</option>
                        <%for(int i=0;i<cityCount;i++){ %>
	                <OPTION VALUE="<%=cityList[i][0]%>"><%=cityList[i][1]%></OPTION>
	                <%}%>
                        </select>
                        </td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">Ticket Delivery: </font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="280"> 
                        <INPUT TYPE=HIDDEN NAME="flightWay" VALUE="Single">
                        <input name=ticketAgencyID type=hidden value="1">
                        <select name="ticketAgencyID1" ONCHANGE="document.searchForm.ticketAgencyID.value=this.options[this.selectedIndex].value;" STYLE="WIDTH:220px">
                        <OPTION VALUE="none">choose delivery city</OPTION>
	                <option value=none>--------------</option>
                        <%for(int i=0;i<cityCount;i++){ %>
	                <OPTION VALUE="<%=cityList[i][0]%>"><%=cityList[i][1]%></OPTION>
	                <%}%>
                        </select>
                        </td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">Destination: </font></td>
                            </tr>
                          </table>
                        </td>
                        <%
                            FlightCity.setLangCode("EN");
                            FlightCity.setCityFlag("A");
                            cityList = FlightCity.getCityList();
                            cityCount = FlightCity.getCityCount();
                        %>
                        <input name=dDateChoice type=hidden value=Point><input name=dDatePeriod1 type=hidden><INPUT NAME=destcity1 TYPE=HIDDEN VALUE=0 >
                        <td height="30" width="280"> 
                          <SELECT NAME="destcity" CLASS="Small" ONCHANGE="document.searchForm.destcity1.value=this.options[this.selectedIndex].value;" STYLE="WIDTH:220px">
		          <OPTION VALUE="none">choose destination city</OPTION>
		          <option value=none>--------------</option>
                          <%for(int i=0;i<cityCount;i++){ %>
	                  <OPTION VALUE="<%=cityList[i][0]%>"><%=cityList[i][1]%></OPTION>
	                  <%}%>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">Departure Date: </font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="280"> 
                          <select class=Small size=1 
                  name=d_Year>
                            <option value=2000 selected>2000 
                            <option 
                    value=2001>2001</option>
                          </select>
                          Year 
                          <SELECT NAME=d_Month SIZE=1 Class=Small><%for(int i=1;i<13;i++){%><OPTION VALUE="<%=i%>" <%if(nowMonth==i){%>selected<%}%> ><%=i%></OPTION><%}%></select>Month
                          <SELECT NAME=d_Day SIZE=1 Class=Small><%for(int i=1;i<32;i++){%><OPTION VALUE="<%=i%>" <%if(nowDay==i){%>selected<%}%> ><%=i%></OPTION><%}%></select>Day</td>
                      </tr>
                      <tr> 
                        <td height="30" width="140"> 
                        <input name=aDateChoice type=hidden value=Point><input name=aDatePeriod1 type=hidden>
                          <table width="120" border="1" cellspacing="0" cellpadding="2" bordercolor="#CFC8CF" align="center">
                            <tr align="center"> 
                              <td><font color="#000000">Airlines: </font></td>
                            </tr>
                          </table>
                        </td>
                        <td height="30" width="280"> 
                        <input name=a_Year type=hidden value="2001">
                        <input name=a_Month type=hidden value="12">
                        <input name=a_Day type=hidden value="12">
                        <select class=Small size=1 
                          name=airlineChoice >
                        <OPTION VALUE="0">choose airlines</OPTION>
	                <option value="0">not limit</option>
                        <%for(int i=0;i<airlineCount;i++){ %>
	                <OPTION VALUE="<%=airlineList[i][0]%>"><%=airlineList[i][1]%></OPTION>
	                <%}%>
                        </select>
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
          <tr align="center"> 
            <td class="txt"><a href="javascript:Search_check();"><img src="/images/en/search.gif" width="138" height="18" border="0"></a></td>
          </tr>
          <tr align="center"> 
            <td class="txt">&nbsp;</td>
          </tr>
          <tr align="center"> 
            <td class="txt"><a href="javascript:window.history.go(-1)">back</a></td>
          </tr>
        </table>
      </form>
      <!-- #EndEditable --></td>
  </tr>
  <tr>
    <td colspan="3" height="20">&nbsp;</td>
  </tr>
<%@ include file="../foot_tel.jsp"%>  
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
<script language="JavaScript" src="/javascript/en/foot.js">
</script>
</table>
</body>
<!-- #EndTemplate --></html>

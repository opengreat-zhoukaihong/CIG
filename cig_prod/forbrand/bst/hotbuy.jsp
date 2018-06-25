<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" errorPage="../login/error.jsp"%>
<% if(session.getAttribute("operator")==null) {%>
<jsp:forward page="../bst/BackResultsError.jsp?message=You haven't log in."/>
<% } %>
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnHotSaleMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted)
  {
%>
<jsp:forward page="../ResultsError.jsp?message=Sorry! You have no permission!" />
<%	}	%>

<% if(request.getParameter("gift_ID")==null)
  { %>
  <jsp:forward page="../bst/BackResultsError.jsp?message=You haven't selected a gift." />
<%  } %>

<html>
<head>
<title>Hot Sale</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../public.css">
<script src="/js/formcheck.js"></script>
<script language="JavaScript">
	function checkAll()
	{
		if(document.all.price.value=="")
		{
			alert("Please enter the gift price!")
			return false
		}
		if(isNaN(parseFloat(document.all.price.value)))
		{
			alert("Invalid price!")
			return false
		}
		if(document.all.bgn_Date.value=="")
		{
			alert("Please enter the sale begin date!")
			return false
		}
		if(!checkDate(document.all.bgn_Date.value))
		{
			return false
		}
		if(document.all.end_Date.value=="")
		{
			alert("Please enter the sale end date!")
			return false
		}
		if(!checkDate(document.all.end_Date.value))
		{
			return false
		}
		document.hotform.submit()
		return true
	}
	
	function checkDate(datestr)
	{
		var dstr = datestr.split("-")
		if(dstr.length!=3)
		{
			alert("Invalid date type")
			return false
		}
		
		var yy = parseInt(dstr[0])
		var mm = parseInt(dstr[1])
		var dd = parseInt(dstr[2])

		if(isNaN(yy)||isNaN(mm)||isNaN(dd))
		{
			alert("The date should be present as digits")
			return false
		}
		if(yy<2000)
		{
			alert("The Year should not less than 2000!")
			return false
		}
		if(yy>9999)
		{
			alert("The year should only have four digits!")
			return false
		}
		if(mm>12 || mm<1)
		{
			alert("Invalid month type!")
			return false
		}
		if(dd>31 || dd<1)
		{
			alert("Invalid day type!")
			return false
		}
		return true
	}
</script>
</head>

<body bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
  <tr> 
    <td valign="middle"> 
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="white-title"  > 
            <p>Hot Sale:</p>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr class="black-m-text"> 
          <td class="bottom-menu" colspan="3" > 
<% if(request.getParameter("stype1")!=null||request.getParameter("stype2")!=null)
  { %> 
            <div align="center">
<jsp:useBean id="hotbuy" scope="page" class="com.forbrand.member.hotBuyBean" /> 
<jsp:setProperty name="hotbuy" property="*" /> 
<%! String stype1,stype2; %> 
<%  stype1=request.getParameter("stype1");
    stype2=request.getParameter("stype2");
    hotbuy.setOpe_ID((String)session.getAttribute("operator"));
    hotbuy.setGift_ID(request.getParameter("gift_ID"));
   if(stype1!=null)
		if(stype1.length()>0)
    {
      hotbuy.setSaleType(stype1);
      if(!hotbuy.insertHotSale())
      { %> </div>
            <p class="contact" align="center"> You failed to mark this gift as 
              a Hot-Sale gift. 
            <p class="contact" align="center"> Maybe this record is already in 
              the database. 
            <p align="center"> <span class="contact">Please contact the webmaster. 
              </span><%    }
			else
		  {	%> 
            <p align="center"> <span class="contact">You have successfully mark 
              this gift as a Hot-Sale gift. </span><% 	  }
		}
	if(stype2!=null)
    if(stype2.length()>0)
    {
      hotbuy.setSaleType(stype2);
      if(!hotbuy.insertHotSale())
      { %> 
            <p class="contact" align="center"> You failed to add this gift as 
              a Special-Sale gift. 
            <p class="contact" align="center"> Maybe this record is already in 
              the database. 
            <p align="center"> <span class="contact">Please contact the webmaster.</span> 
              <%    }
			else
	  	{	%> 
            <p align="center"> <span class="contact">You have successfully mark 
              this gift as a Special-Sale gift.</span> <%    }
		}	
  }
  else
  {
%> 
            <form name="hotform" method="post">
              <div align="center"> 
                <table align="center" width="477" class="black-m-text">
                  <tr> 
                    <td class="dalei" width="101"> 
                      <div align="left">Sale Type:</div>
                    </td>
                    <td colspan="2"> 
                      <div align="left"><b> 
                        <input type="checkbox" value="1"  name="stype1">
                        Hot Sale 
                        <input type="checkbox" value="2"  name="stype2">
                        Special Sale </b></div>
                    </td>
                  </tr>
                  <tr> 
                    <td class="dalei" width="101"> 
                      <div align="left">Begin Date:</div>
                    </td>
                    <td width="213"> 
                      <div align="left"> 
                        <input type="text" value="" name="bgn_Date">
                      </div>
                    </td>
                    <td rowspan="2" width="147">(Please follow this format: eg: 
                      2000-10-31)</td>
                  </tr>
                  <tr> 
                    <td class="dalei" width="101"> 
                      <div align="left">End Date:</div>
                    </td>
                    <td width="213"> 
                      <div align="left"> 
                        <input type="text" value="" name="end_Date">
                      </div>
                    </td>
                  </tr>
                  <tr> 
                    <td class="dalei" colspan="3"> 
                      <div align="center" > 
											<img src="../../images/submit-buttom.jpg" width="68" height="25" border="0" alt="" style="cursor: hand;" onClick="checkAll()"> 
                      </div>
                    </td>
                  </tr>
                </table>
                        <input type="hidden" value="<%=request.getParameter("gift_ID")%>" name="gift_ID">
                        <input type="hidden" value="0" name="price">

              </div>
            </form>
            <div align="center"><%}%> </div>
          </td>
        </tr>
      </table>
      <br>
      <table width="80%" align="center">
        <tr bgcolor="#003399" valign="middle"> 
          <td class="bottom-menu"  > 
            <p class="white-title" align="right"> &gt;&gt;<a href="javascript:window.close()"><font color="#FFFFFF">Go 
              Back</font></a>&lt;&lt;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

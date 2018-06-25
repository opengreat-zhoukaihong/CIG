<HTML>
<HEAD>
<%@ page import="java.io.*,java.sql.*,java.util.*,com.forbrand.bst.*" %>
<jsp:useBean id="DiscountCalcId" scope="session" class="com.forbrand.bst.DiscountCalc" />
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnSysInitMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted){
%>
<jsp:forward page="BackResultsError.jsp?message=Sorry! You have no permission!" />
<%}%>
<jsp:setProperty name="DiscountCalcId" property="*" />
<%! String sOperator,sAction,sErrorString;
    String sCalcs[][];
    int iCount,i,iErrorCode;
    long lId;
    double dAmountL,dAmountU,dDiscount;
    PrintWriter pw;%>
<%
try{
     sAction=request.getParameter("action");
     pw=response.getWriter();
     iErrorCode=0;
     sOperator=(String)session.getValue("operator");
     if(sAction!=null && sAction.equals("add"))
     {
       dAmountL=Double.parseDouble(request.getParameter("parmAmountL"));
       dAmountU=Double.parseDouble(request.getParameter("parmAmountU"));
       dDiscount=Double.parseDouble(request.getParameter("parmDiscount"));
       DiscountCalcId.setValues(dAmountL,dAmountU,dDiscount,sOperator);
       DiscountCalcId.addCalc();
       iErrorCode=DiscountCalcId.getErrorCode();
       sErrorString=DiscountCalcId.getErrorString();
      }
      if(sAction!=null && sAction.equals("delete"))
      {
        lId=Long.parseLong(request.getParameter("parmId"));
        DiscountCalcId.setId(lId);
        DiscountCalcId.delCalc();
        iErrorCode=DiscountCalcId.getErrorCode();
        sErrorString=DiscountCalcId.getErrorString();
      }
        iCount=Integer.parseInt(DiscountCalcId.getCount());
        sCalcs=DiscountCalcId.getCalcs();
    }catch(Exception e)
    {
      e.printStackTrace();
    }
%>
<TITLE>
discount calculation
</TITLE>
<script>
function trim(str)
{
  var bLeading=true;
  var sRet;
  var i;
  str=""+str;
  sTmp=str.substring(0,str.length);
  for(i=0;i<str.length;i++)
  {
    if (bLeading &&str.substring(i,i+1)==' ')
    {
      sTmp=str.substring(i+1,str.length);
    }else
    {
     bLeading=false;
    }
  }
  sRet=sTmp.substring(0,sTmp.length);
  bLeading=true;
  for(i=sTmp.length-1;i>=0;i--)
  {
    if(bLeading &&sTmp.substring(i,i+1)==' ')
    {
      sRet=sTmp.substring(0,i);
    }else
    {
     bLeading=false;
    }
  }
  return sRet;
}

function isNaN(str)
{
  var t;
  var i;
  var c;
  var pntCount=0;
  t=trim(str);
  for(i=0;i<t.length;i++)
  {
    c=t.substring(i,i+1);
    if(c!="0" && c!="1" && c!="2" && c!="3" && c!="4" && c!="5" && c!="6" && c!="7" && c!="8" && c!="9")
    {
     if(c=="." && pntCount==0)
     {
      pntCount=pntCount+1;
     }else
     {
      return true;
     }
    }
  }
   return false;
}

function checkForm()
{
    if(trim(document.formAdd.parmAmountL.value) == "")
    {
      alert("Please input lower limit of amount!");
      document.formAdd.parmAmountL.focus();
      return false;
    }
    if(trim(document.formAdd.parmAmountU.value) == "")
    {
      alert("Please input upper limit of amount!");
      document.formAdd.parmAmountU.focus();
      return false;
    }
    if(trim(document.formAdd.parmDiscount.value) == "")
    {
      alert("Please input discount!");
      document.formAdd.parmDiscount.focus();
      return false;
    }
    if(isNaN(document.formAdd.parmAmountL.value))
    {
      alert("The lower limit of amount you input is invalid!");
      document.formAdd.parmAmountL.focus();
      return false;
     }
    if(isNaN(document.formAdd.parmAmountU.value))
    {
      alert("The upper limit of amount you input is invalid!");
      document.formAdd.parmAmountU.focus();
      return false;
     }
    if(isNaN(document.formAdd.parmDiscount.value))
    {
      alert("The discount you input is invalid!");
      document.formAdd.parmDiscount.focus();
      return false;
     }
     if(parseFloat(document.formAdd.parmAmountU.value)<parseFloat(document.formAdd.parmAmountL.value))
     {
       alert("The upper bound must be greater than lower bound!");
       document.formAdd.parmAmountU.focus();
       return false;
      }
     if(parseFloat(document.formAdd.parmDiscount.value)>100 ||parseFloat(document.formAdd.parmDiscount.value)<0)
     {
       alert("The discount must be greater than 0 and no more than 100!");
       document.formAdd.parmAmountU.focus();
       return false;
     }
    return true;
}
function delCalc(sId)
{
   if(confirm("Are you sure to delelte this discount calculation?"))
   {
      document.formDel.parmId.value=sId;
      document.formDel.submit();
    }
}
</script>

</HEAD>
<BODY>
<H1>
</H1>
<p></p>
<table border=1>
  <tr>
    <td colspan="4" align="center"><font size="4"><b>Discount Calculation</b></font></td>
  </tr>
  <tr>
    <td >amount lowerbound</td>
    <td >amount upperbound</td>
    <td >discount</td>
    <td >Operator</td>
  </tr>
  <% for(i=0;i<iCount;i++)
  {
  %>
  <tr>
    <%if (sCalcs[i][1]!=null){%>
    <td><%=sCalcs[i][1]%></td><%}else{%>
    <td>&nbsp;</td>
    <%} if(sCalcs[i][2]!=null){%>
    <td><%=sCalcs[i][2]%></td><%}else{%>
    <td>&nbsp;</td>
    <%}if (sCalcs[i][3]!=null){%>
    <td><%=sCalcs[i][3]%></td><%}else{%>
    <td>&nbsp;</td>
     <%}if (sCalcs[i][4]!=null){%>
    <td><%=sCalcs[i][4]%></td><%}else{%>
    <td>&nbsp;</td>
    <%}%>
    <td ><a href="javascript:delCalc('<%=sCalcs[i][0]%>')">[del]</a></td>
  </tr>
  <%}%>
</table>
<% if(DiscountCalcId.getErrorCode()<0)
{%><p>
  <%=DiscountCalcId.getErrorString()%></p>
<%}%>
<FORM name="formAdd" method="post" action="/forbrand/bst/discountcalc.jsp" onsubmit="checkForm()">
<table>
<tr><td>Enter lower bound amount :</td><td><INPUT type=text NAME="parmAmountL" maxlength=38></td></tr>
<tr><td>Enter upper bound amount :</td><td><INPUT type=text NAME="parmAmountU" maxlength=38></td></tr>
<tr><td>Enter discount           :</td><td><INPUT type=text NAME="parmDiscount" maxlength=38></td></tr>
<input type=hidden name=action value="add">
<tr><td colspan="2" align="center"><INPUT TYPE="button" NAME="Submit" VALUE="Submit" onclick="
if (checkForm())
{
  formAdd.submit();
}"></td></tr>
</table>
<BR>
</FORM>
<form name="formDel" method="post" action="discountcalc.jsp">
    <input type="hidden" name="parmId">
    <input type="hidden" name="action" value="delete">
  </form>
</BODY>
</HTML>

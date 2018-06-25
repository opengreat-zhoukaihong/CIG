<HTML>
<HEAD>
<%@ page import="java.io.*,java.sql.*,java.util.*,com.forbrand.bst.*" %>
<jsp:useBean id="ConfManagerId" scope="session" class="com.forbrand.bst.ConfManager" />
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
<jsp:setProperty name="ConfManagerId" property="*" />
<%! String sName,sValue,sDesc,sOperator,sAction;
    String sConfs[][];
    int iCount,i;
    PrintWriter pw;%>
<%
try{
     sAction=request.getParameter("action");
     pw=response.getWriter();
     sOperator=(String)session.getValue("operator");
     if(sAction!=null && sAction.equals("add"))
     {
       sName=request.getParameter("parmName");
       sValue=request.getParameter("parmValue");
       sDesc=request.getParameter("parmDesc");
       ConfManagerId.setValues(sName,sValue,sDesc,sOperator);
       ConfManagerId.addConf();
      }
      if(sAction!=null && sAction.equals("delete"))
      {
        sName=request.getParameter("parmName");
        ConfManagerId.setName(sName);
        ConfManagerId.delConf();
      }
        iCount=Integer.parseInt(ConfManagerId.getCount());
        sConfs=ConfManagerId.getConfs();
    }catch(Exception e)
    {
      e.printStackTrace();
    }
%>
<TITLE>
configuration
</TITLE>
<script>
function checkForm()
  {
    if(trim(document.formAdd.parmName.value) == "")
    {
      alert("Please input parameter name!");
      document.formAdd.parmName.focus();
      return false;
    }
    if(trim(document.formAdd.parmValue.value) == "")
    {
      alert("Please input parameter value !");
      document.formAdd.parmValue.focus();
      return false;
    }
    return true;
  }
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
function delConf(sName)
{
   if(confirm("Are you sure to delelte this configuration?"))
   {
      document.formDel.parmName.value=sName;
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
    <td colspan="4" align="center"><font size="4"><b>Configuration</b></font></td>
  </tr>
  <tr>
    <td>Name</td>
    <td>Value</td>
    <td>Description</td>
    <td>Operator</td>
  </tr>
  <% for(i=0;i<iCount;i++)
  {
  %>
  <tr>
    <%if (sConfs[i][0]!=null){%>
    <td><%=sConfs[i][0]%></td><%}else{%>
    <td>&nbsp;</td>
    <%} if(sConfs[i][1]!=null){%>
    <td><%=sConfs[i][1]%></td><%}else{%>
    <td>&nbsp;</td>
    <%}if (sConfs[i][2]!=null){%>
    <td><%=sConfs[i][2]%></td><%}else{%>
    <td>&nbsp;</td>
    <%}if (sConfs[i][3]!=null){%>
    <td><%=sConfs[i][3]%></td><%}else{%>
    <td>&nbsp;</td>
    <%}%>
    <td ><a href="javascript:delConf('<%=sConfs[i][0]%>')">[del]</a></td>
  </tr>
  <%}%>
</table>


<FORM name="formAdd" method="post" action="/forbrand/bst/configuration.jsp" onsubmit="checkForm()">
<table>
<tr><td>Enter parameter name :</td><td><INPUT NAME="parmName" maxlength=20></td></tr>
<tr><td>Enter parameter value :</td><td> <INPUT type=text NAME="parmValue" maxlength=300></td></tr>
<tr><td>Enter parameter description  :</td> <td> <INPUT type=textarea rows=3 cols=50 NAME="parmDesc" maxlength=150></td></tr>
<input type=hidden name=action value="add">
<tr><td colspan=2 >
        <div align="center">
          <INPUT TYPE="button" NAME="Submit" VALUE="Submit" onclick="
if (checkForm())
{
  formAdd.submit();
}">
        </div>
      </td></tr>
</table>
<BR>
</FORM>
<form name="formDel" method="post" action="configuration.jsp">
    <input type="hidden" name="parmName">
    <input type="hidden" name="action" value="delete">
  </form>
</BODY>
</HTML>

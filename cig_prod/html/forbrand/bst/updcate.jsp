<HTML>
<HEAD>
<%@ page import="java.io.*,java.sql.*,java.util.*,com.forbrand.bst.*" %>
<jsp:useBean id="CategoryManagerId" scope="session" class="com.forbrand.bst.CategoryManager" />
<jsp:useBean id="CWId" scope="session" class="com.forbrand.bst.CommonWealth" />
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnCateMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted){
%>
<jsp:forward page="BackResultsError.jsp?message=Sorry! You have no permission!" />
<%}%>
<jsp:setProperty name="CategoryManagerId" property="*" />
<%! String sOperator,sCateName,sErrorString,sAction,sLangCode,sTypeId,sCateId;
    String[][] sTypes;
    int i,iErrorCode,iTypeCount,iLangCount;
    PrintWriter pw;%>
<%
try{
     sLangCode=request.getParameter("parmLangCode");
     pw=response.getWriter();
     sCateName=request.getParameter("parmCateName");
     sTypeId=request.getParameter("parmTypeId");
     sCateId=request.getParameter("parmCateId");
     CWId.setLangCode(sLangCode);
     iTypeCount=CWId.getTypeCount();
     sTypes=CWId.getTypes();
    }catch(Exception e)
    {
      e.printStackTrace();
    }
%>
<TITLE>
update type
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

function checkForm()
{
    if(trim(document.formUpdate.parmCateName.value) == "")
    {
      alert("Please input category name!");
      document.formUpdate.parmName.focus();
      return false;
    }
    return true;
}
</script>
</head>
<body>
<FORM name="formUpdate" method="post" action="catemanager.jsp" onsubmit="checkForm()">
<table>
<tr><td>language :</td><td><%=sLangCode%></td></tr>
<tr><td>type name :</td>
<td><INPUT type=text NAME="parmCateName" maxlength=50 <%if(sCateName!=null){%>value='<%=sCateName%>'<%}%>></td></tr>
<tr><td>type :</td><td><select NAME="parmTypeId">
<option value="">--Please select--</option>
<%for(i=0;i<iTypeCount;i++){%>
<option value='<%=sTypes[i][0]%>' <%if (sTypeId.equals(sTypes[i][0])){%>selected<%}%>><%=sTypes[i][1]%></option>
<%}%></select>
</td></tr>
<input type=hidden name=action value="update">
<input type=hidden name="parmLangCode" value='<%=sLangCode%>'>
<input type=hidden name="parmCateId" value='<%=sCateId%>'>
<input type=hidden name="parmTypeId" value='<%=sTypeId%>'>
<tr><td colspan="2" align="center"><INPUT TYPE="button" NAME="Submit" VALUE="Submit" onclick="
if (checkForm())
{
  formUpdate.submit();
}"></td></tr>
</table>
<BR>
</FORM>
</BODY>
</HTML>
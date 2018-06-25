<HTML>
<HEAD>
<%@ page import="java.io.*,java.sql.*,java.util.*,com.forbrand.bst.*" %>
<jsp:useBean id="TypeManagerId" scope="session" class="com.forbrand.bst.TypeManager" />
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnTypeMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted){
%>
<jsp:forward page="BackResultsError.jsp?message=Sorry! You have no permission!" />
<%}%>
<jsp:setProperty name="TypeManagerId" property="*" />
<%! String sOperator,sName,sErrorString,sFileName,sAction,sLangCode,sTypeId;
    String[][] sDirs;
    String[] sLangCodes;
    int i,iErrorCode,iPicDir,iDirCount,iLangCount;
    PrintWriter pw;%>
<%
try{
     sLangCode=request.getParameter("parmLangCode");
     pw=response.getWriter();
     sName=request.getParameter("parmName");
     iPicDir=Integer.parseInt(request.getParameter("parmPicDir"));
     sFileName=request.getParameter("parmFileName");
     sTypeId=request.getParameter("parmId");
     iDirCount=TypeManagerId.getDirCount();
     sDirs=TypeManagerId.getDirs();
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
    if(trim(document.formUpdate.parmName.value) == "")
    {
      alert("Please input directory name!");
      document.formUpdate.parmName.focus();
      return false;
    }
    return true;
}
</script>
</head>
<body>
<FORM name="formUpdate" method="post" action="typemanager.jsp" onsubmit="checkForm()">
<table>
<tr><td>language :</td><td><%=sLangCode%></td></tr>
<tr><td>type name :</td>
<td><INPUT type=text NAME="parmName" maxlength=50 <%if(sName!=null){%>value='<%=sName%>'<%}%>></td></tr>
<tr><td>picture directory :</td><td><select NAME="parmPicDir">
<option value="">--Please select--</option>
<%for(i=0;i<iDirCount;i++){%>
<option value='<%=sDirs[i][0]%>' <%if (iPicDir==Integer.parseInt(sDirs[i][0])){%>selected<%}%>><%=sDirs[i][1]%></option>
<%}%></select>
</td></tr>
<tr><td>filename :</td><td><INPUT type=text NAME="parmFileName" maxlength=50 <%if(sFileName!=null){%>value='<%=sFileName%>'<%}%>></td></tr>
<input type=hidden name=action value="update">
<input type=hidden name="parmLangCode" value='<%=sLangCode%>'>
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

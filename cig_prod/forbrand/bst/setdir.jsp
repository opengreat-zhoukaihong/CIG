<HTML>
<HEAD>
<%@ page import="java.io.*,java.sql.*,java.util.*,com.forbrand.bst.*" %>
<jsp:useBean id="DirSettingId" scope="session" class="com.forbrand.bst.DirSetting" />
<jsp:useBean id="permTest" scope="page" class="com.cig.permission.Permission" />
<%!
  boolean isPermitted;
  String userID;
  String funcID;
%>
<%
  funcID = "fnDirMg";
  userID = (String)session.getValue("operator");
  permTest.setFuncID(funcID);
  permTest.setUserID(userID);
  isPermitted = permTest.isPermitted();
  if(!isPermitted){
%>
<jsp:forward page="BackResultsError.jsp?message=Sorry! You have no permission!" />
<%}%>
<jsp:setProperty name="DirSettingId" property="*" />
<%! String sDir,sDesc,sOperator,sAction;
    String sDirs[][];
    String emptyString="&nbsp;";
    int iCount,i,iDirId;
    PrintWriter pw;%>
<%
try{
     sAction=request.getParameter("action");
     pw=response.getWriter();
     sOperator=(String)session.getValue("operator");
     if(sAction!=null && sAction.equals("add"))
     {
       sDir=request.getParameter("parmDir");
       sDesc=request.getParameter("parmDesc");
       DirSettingId.setValues(sDir,sDesc,sOperator);
       DirSettingId.addDir();
      }
      if(sAction!=null && sAction.equals("delete"))
      {
        iDirId=Integer.parseInt(request.getParameter("parmDirId"));
        DirSettingId.setDirId(iDirId);
        DirSettingId.delDir();
      }
        iCount=Integer.parseInt(DirSettingId.getCount());
        sDirs=DirSettingId.getDirs();
    }catch(Exception e)
    {
      e.printStackTrace();
    }
%>
<TITLE>
directory  settings
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
    if(trim(document.formAdd.parmDir.value) == "")
    {
      alert("Please input directory name!");
      document.formAdd.parmDir.focus();
      return false;
    }
    return true;
  }

function delDir(sDirId)
{
   if(confirm("Are you sure to delelte this directory configuration?"))
   {
      document.formDel.parmDirId.value=sDirId;
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
    <td colspan="3" align="center"><font size="4"><b>Directory settings</b></font></td>
  </tr>
  <tr>
    <td >Directory Name</td>
    <td >Description</td>
    <td >Operator</td>
  </tr>
  <% for(i=0;i<iCount;i++)
  {
  %>
  <tr>
    <%if (sDirs[i][1]!=null){%>
    <td ><%=sDirs[i][1]%></td><%}else{%>
    <td >&nbsp;</td>
    <%} if(sDirs[i][2]!=null){%>
    <td ><%=sDirs[i][2]%></td><%}else{%>
    <td >&nbsp;</td>
    <%}if (sDirs[i][3]!=null){%>
    <td ><%=sDirs[i][3]%></td><%}else{%>
    <td >&nbsp;</td>
    <%}%>
    <td ><a href="javascript:delDir('<%=sDirs[i][0]%>')">[del]</a></td>
  </tr>
  <%}%>
</table>


<FORM name="formAdd" method="post" action="/forbrand/bst/setdir.jsp" onsubmit="checkForm()">
<table>
<tr><td>Enter directory name         :</td><td><INPUT NAME="parmDir" maxlength=200></td></tr>
<tr><td>Enter directory description  :</td> <td> <INPUT type=text NAME="parmDesc" maxlength=100></td></tr>
<input type=hidden name=action value="add">
<tr><td colspan="2">
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
<form name="formDel" method="post" action="setdir.jsp">
    <input type="hidden" name="parmDirId">
    <input type="hidden" name="action" value="delete">
  </form>
</BODY>
</HTML>

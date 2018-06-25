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
<%! String sOperator,sName,sErrorString,sFileName,sAction,sLangCode,sSql;
    String[][] sTypes,sDirs;
    String[] sLangCodes;
    int iCount,i,iErrorCode,iTypeId,iPicDir,iDirCount,iLangCount;
    PrintWriter pw;%>
<%
try{
     sOperator=(String)session.getValue("operator");
     sAction=request.getParameter("action");
     sLangCode=request.getParameter("parmLangCode");
     pw=response.getWriter();
     if(sAction!=null && sAction.equals("add"))
     {
       sName=request.getParameter("parmName");
       iPicDir=Integer.parseInt(request.getParameter("parmPicDir"));
       sFileName=request.getParameter("parmFileName");
       TypeManagerId.setValues(sName,iPicDir,sFileName,sOperator);
       TypeManagerId.addType();
      }
      if(sAction!=null && sAction.equals("delete"))
      {
        iTypeId=Integer.parseInt(request.getParameter("parmId"));
        TypeManagerId.setTypeId(iTypeId);
        TypeManagerId.setLangCode(sLangCode);
        TypeManagerId.delType();
      }
      if(sAction!=null && sAction.equals("update"))
      {
        sName=request.getParameter("parmName");
        iPicDir=Integer.parseInt(request.getParameter("parmPicDir"));
        sFileName=request.getParameter("parmFileName");
        iTypeId=Integer.parseInt(request.getParameter("parmTypeId"));
        TypeManagerId.setValues(sName,iPicDir,sFileName,sOperator);
        TypeManagerId.setLangCode(sLangCode);
        TypeManagerId.setTypeId(iTypeId);
        TypeManagerId.updType();
      }
        iLangCount=TypeManagerId.getLangCount();
        sLangCodes=TypeManagerId.getLangCodes();
        iDirCount=TypeManagerId.getDirCount();
        sDirs=TypeManagerId.getDirs();
        if(sLangCode!=null)
        {
          TypeManagerId.setLangCode(sLangCode);
          iCount=Integer.parseInt(TypeManagerId.getCount());
          sTypes=TypeManagerId.getTypes();
        }else
        {
          sLangCode="";
        }
    }catch(Exception e)
    {
      e.printStackTrace();
    }
%>
<TITLE>
type management
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
    document.formAdd.parmLangCode.value=document.formQuery.parmLangCode.value;
    if(trim(document.formAdd.parmName.value) == "")
    {
      alert("Please input directory name!");
      document.formAdd.parmName.focus();
      return false;
    }
    return true;
}
function delType(sId)
{
   if(confirm("Are you sure to delelte this type?"))
   {
      document.formDel.parmId.value=sId;
      document.formDel.parmLangCode.value=document.formQuery.parmLangCode.value;
      document.formDel.submit();
    }
}
function updType(sId,sName,sPicDir,sFileName)
{
      document.formUpd.parmId.value=sId;
      document.formUpd.parmName.value=sName;
      document.formUpd.parmPicDir.value=sPicDir;
      document.formUpd.parmFileName.value=sFileName;
      document.formUpd.parmLangCode.value=document.formQuery.parmLangCode.value;
      document.formUpd.submit();
}

</script>

</HEAD>
<BODY>
<H1>
</H1>
<p><% if(TypeManagerId.getErrorCode()<0)
{%><p>
  <%=TypeManagerId.getErrorString()%></p>
<%}%></p>
<table><form name="formQuery" action="typemanager.jsp"><tr>
<td>please select language</td><td><select name="parmLangCode" onchange="document.formQuery.submit()">
<option value="" <%if (sLangCode==null){%>selected<%}%>>--Please select--</option>
<%for(i=0;i<iLangCount;i++){%>
<option value='<%=sLangCodes[i]%>' <%if (sLangCode.equals(sLangCodes[i])){%>selected<%}%>><%=sLangCodes[i]%></option>
<%}%></select>
</td>
</tr></form></table>
<table border=1>
  <tr>
  <td colspan="4" align="center">type management</td>
  </tr>
  <tr>
    <td >type name</td>
    <td >directory name</td>
    <td >picture filename</td>
    <td >Operator</td>
  </tr>
  <% for(i=0;i<iCount;i++)
  {
  %>
  <tr>
    <%if (sTypes[i][1]!=null){%>
    <td><%=sTypes[i][1]%></td><%}else{%>
    <td>&nbsp;</td>
    <%} if(sTypes[i][3]!=null){%>
    <td><%=sTypes[i][3]%></td><%}else{%>
    <td>&nbsp;</td>
    <%}if (sTypes[i][4]!=null){%>
    <td><%=sTypes[i][4]%></td><%}else{%>
    <td>&nbsp;</td>
     <%}if (sTypes[i][5]!=null){%>
    <td><%=sTypes[i][5]%></td><%}else{%>
    <td>&nbsp;</td>
    <%}%>
    <td ><a href="javascript:delType('<%=sTypes[i][0]%>')">[del]</a><a href="javascript:updType('<%=sTypes[i][0]%>','<%=sTypes[i][1]%>',<%if (sTypes[i][2]!=null){%>'<%=sTypes[i][2]%>'<%}else{%>''<%}%>,<%if (sTypes[i][4]!=null){%>'<%=sTypes[i][4]%>'<%}else{%>''<%}%>)">[update]</a></td>
  </tr>
  <%}%>
</table>

<FORM name="formAdd" method="post" action="typemanager.jsp" onsubmit="checkForm()">
<table>
<tr><td>type name :</td><td><INPUT type=text NAME="parmName" maxlength=50></td></tr>
<tr><td>picture directory :</td><td><select NAME="parmPicDir">
<option value="" selected>--Please select--</option>
<%for(i=0;i<iDirCount;i++){%>
<option value='<%=sDirs[i][0]%>'><%=sDirs[i][1]%></option>
<%}%></select>
</td></tr>
<tr><td>filename :</td><td><INPUT type=text NAME="parmFileName" maxlength=50></td></tr>
<input type=hidden name=action value="add">
<input type=hidden name="parmLangCode">
<tr><td colspan="2" align="center"><INPUT TYPE="button" NAME="Submit" VALUE="Submit" onclick="
if (checkForm())
{
  formAdd.submit();
}"></td></tr>
</table>
<BR>
</FORM>
<form name="formDel" method="post" action="typemanager.jsp">
    <input type="hidden" name="parmId">
    <input type="hidden" name="parmLangCode">
    <input type="hidden" name="action" value="delete">
  </form>
<form name="formUpd" method="post" action="updtype.jsp">
    <input type="hidden" name="parmId">
    <input type="hidden" name="parmLangCode">
    <input type="hidden" name="parmName">
    <input type="hidden" name="parmPicDir">
    <input type="hidden" name="parmFileName">
  </form>

</BODY>
</HTML>

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
<%! String sOperator,sCateName,sErrorString,sAction,sLangCode,sSql,sTypeId;
    String[][] sCates,sTypes;
    String[] sLangCodes;
    int iCount,i,iErrorCode,iTypeId,iCateId,iLangCount,iTypeCount;
    PrintWriter pw;%>
<%
try{
     iErrorCode=0;
     sOperator=(String)session.getValue("operator");
     sAction=request.getParameter("action");
     sLangCode=request.getParameter("parmLangCode");
     sTypeId=request.getParameter("parmTypeId");
     iLangCount=CWId.getLangCount();
     sLangCodes=CWId.getLangCodes();
     pw=response.getWriter();
     if(sAction!=null && sAction.equals("add"))
     {
       sCateName=request.getParameter("parmCateName");
       iTypeId=Integer.parseInt(request.getParameter("parmTypeId"));
       CategoryManagerId.setValues(sCateName,iTypeId,sOperator);
       CategoryManagerId.setLangCount(iLangCount);
       CategoryManagerId.setLangCodes(sLangCodes);
       CategoryManagerId.addCate();
      }

      if(sAction!=null && sAction.equals("delete"))
      {
        iCateId=Integer.parseInt(request.getParameter("parmCateId"));
        CategoryManagerId.setCateId(iCateId);
        CategoryManagerId.setLangCode(sLangCode);
        CategoryManagerId.delCate();
      }

      if(sAction!=null && sAction.equals("update"))
      {
        sCateName=request.getParameter("parmCateName");
        iCateId=Integer.parseInt(request.getParameter("parmCateId"));
        iTypeId=Integer.parseInt(request.getParameter("parmTypeId"));
        CategoryManagerId.setValues(sCateName,iTypeId,sOperator);
        CategoryManagerId.setLangCode(sLangCode);
        CategoryManagerId.setCateId(iCateId);
        CategoryManagerId.updCate();
        sErrorString=CategoryManagerId.getErrorString();
        iErrorCode=CategoryManagerId.getErrorCode();
        sSql=CategoryManagerId.getSql();
      }
        if(sLangCode!=null && sTypeId!=null)
        {
          CWId.setLangCode(sLangCode);
          iTypeCount=CWId.getTypeCount();
          sTypes=CWId.getTypes();
          CategoryManagerId.setLangCode(sLangCode);
          CategoryManagerId.setTypeId(Integer.parseInt(sTypeId));
          iCount=Integer.parseInt(CategoryManagerId.getCount());
          sCates=CategoryManagerId.getCates();
        }else
        {
          sLangCode="";
          sTypeId="";
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
    document.formAdd.parmTypeId.value=document.formQuery.parmTypeId.value;
    if(trim(document.formAdd.parmCateName.value) == "")
    {
      alert("Please input directory name!");
      document.formAdd.parmCateName.focus();
      return false;
    }
    return true;
}
function delCate(sId)
{
   if(confirm("Are you sure to delelte this category?"))
   {
      document.formDel.parmCateId.value=sId;
      document.formDel.parmLangCode.value=document.formQuery.parmLangCode.value;
      document.formDel.parmTypeId.value=document.formQuery.parmTypeId.value;
      document.formDel.submit();
    }
}
function updCate(sCateId,sCateName,sTypeId)
{
      document.formUpd.parmCateId.value=sCateId;
      document.formUpd.parmCateName.value=sCateName;
      document.formUpd.parmTypeId.value=sTypeId;
      document.formUpd.parmLangCode.value=document.formQuery.parmLangCode.value;
      document.formUpd.submit();
}

</script>

</HEAD>
<BODY>
<H1>
</H1>
<p><% if(iErrorCode<0)
{%><p><%=sErrorString%></p>
   <p><%=sSql%></p>
<%}%></p>
<table><form name="formQuery" action="catemanager.jsp"><tr>
<td>language</td><td><select name="parmLangCode" onchange="document.formQuery.submit()">
<option value="" <%if (sLangCode==null){%>selected<%}%>>--Please select--</option>
<%for(i=0;i<iLangCount;i++){%>
<option value='<%=sLangCodes[i]%>' <%if (sLangCode.equals(sLangCodes[i])){%>selected<%}%>><%=sLangCodes[i]%></option>
<%}%></select>
</td><td>type</td><td><select name="parmTypeId" onchange="document.formQuery.submit()">
<option value="" <%if (sTypeId==null){%>selected<%}%>>--Please select--</option>
<%for(i=0;i<iTypeCount;i++){%>
<option value='<%=sTypes[i][0]%>' <%if (sTypeId.equals(sTypes[i][0])){%>selected<%}%>><%=sTypes[i][1]%></option>
<%}%></select>
</td>
</tr></form></table>
<table border=1>
  <tr>
  <td colspan="2" align="center">category management</td>
  </tr>
  <tr>
    <td >category name</td>
    <td >Operator</td>
  </tr>
  <% for(i=0;i<iCount;i++)
  {
  %>
  <tr>
    <%if (sCates[i][1]!=null){%>
    <td ><%=sCates[i][1]%></td><%}else{%>
    <td >&nbsp;</td>
     <%}if (sCates[i][2]!=null){%>
    <td ><%=sCates[i][2]%></td><%}else{%>
    <td >&nbsp;</td>
    <%}%>
    <td ><a href="javascript:delCate('<%=sCates[i][0]%>')">[del]</a><a href="javascript:updCate('<%=sCates[i][0]%>','<%=sCates[i][1]%>',<%if (sTypeId!=null){%>'<%=sTypeId%>'<%}else{%>''<%}%>)">[update]</a></td>
  </tr>
  <%}%>
</table>

<FORM name="formAdd" method="post" action="catemanager.jsp" onsubmit="checkForm()">
<table>
<tr><td>category name :</td><td><INPUT type=text NAME="parmCateName" maxlength=50></td></tr>
<input type=hidden name=action value="add">
<input type=hidden name="parmLangCode">
<input type=hidden name="parmTypeId">
<tr><td colspan="2" align="center"><INPUT TYPE="button" NAME="Submit" VALUE="Submit" onclick="
if (checkForm())
{
  formAdd.submit();
}"></td></tr>
</table>
<BR>
</FORM>
<form name="formDel" method="post" action="catemanager.jsp">
    <input type="hidden" name="parmCateId">
    <input type="hidden" name="parmLangCode">
    <input type="hidden" name="parmTypeId">
    <input type="hidden" name="action" value="delete">
  </form>
<form name="formUpd" method="post" action="updcate.jsp">
    <input type="hidden" name="parmCateId">
    <input type="hidden" name="parmLangCode">
    <input type="hidden" name="parmCateName">
    <input type="hidden" name="parmTypeId">
  </form>

</BODY>
</HTML>
<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="cateManager" scope="page" class="com.cig.chinaeoa.bst.CateManager" />
<jsp:useBean id="typeManager" scope="page" class="com.cig.chinaeoa.bst.TypeManager" />

<%!
  String tempSqlStr;
  ResultSet typeInfo,cateInfo;
  String action,typeID;
  String cateID,cateName,langCode,langDesc;
  Vector v_typeID = new Vector();
  Vector v_typeName = new Vector();
  String lang_code = "GB";
%>
<%
  if(!v_typeID.isEmpty())
    v_typeID.removeAllElements();
  if(!v_typeName.isEmpty())
    v_typeName.removeAllElements();

  typeID = request.getParameter("typeID");

  try
  {
    tempSqlStr = "select typeID,name from prod_type where lang_code = '" + lang_code +"'";
    typeManager.setSqlStr(tempSqlStr);
    typeInfo = typeManager.getDatas();
    if(typeInfo != null)
    {
      while(typeInfo.next())
      {
        v_typeID.addElement(typeInfo.getString("typeID"));
        v_typeName.addElement(typeInfo.getString("name"));
      }
      typeManager.disconn();
    }
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }

%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">
<script>
  function cateDelete(tempCateID,tempLangCode)
  {
    document.cateDel.cateID.value = tempCateID;
    document.cateDel.langCode.value = tempLangCode;
    if(confirm("确实要删除吗?"))
      document.cateDel.submit();
  }
</script>

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="536" border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td rowspan="2"><img src="/images/spacer.gif" width="15" height="8"></td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr>
    <td>
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF
      cellpadding=5 cellspacing=2 width=467>
        <tr bgcolor="#FFFFFF">
          <td height="26" colspan="6" align="center" class="font3">
            <table width="100%" border="0" height="100%">
              <form name="" method="post" action="cateList.jsp?action=browse">
                <tr>
                  <td height="15" width="31%"> 
                    <div align="right">选择所属大类:</div>
                  </td>
                  <td height="15" width="39%"> 
                    <div align="center">
                      <select name="typeID">
                        <%  if((typeID == null) || (typeID.equals("")))
                    {
                      for(int i=0;i<v_typeID.size();i++)
                      {
                %> 
                        <option value="<%=v_typeID.elementAt(i)%>"><%=v_typeName.elementAt(i)%></option>
                        <%    }
                    }
                    else
                    {
                      for(int i=0;i<v_typeID.size();i++)
                      {
                        if(typeID.equals(v_typeID.elementAt(i)))
                        {
                %> 
                        <option value="<%=v_typeID.elementAt(i)%>" selected><%=v_typeName.elementAt(i)%></option>
                        <%
                        }
                        else
                        {
                %> 
                        <option value="<%=v_typeID.elementAt(i)%>"><%=v_typeName.elementAt(i)%></option>
                        <%
                        }
                      }
                    }
                %> 
                      </select>
                    </div>
                  </td>
                  <td height="15" width="30%"> 
                    <input type="submit" value="查询" name="submit">
                  </td>
                </tr>
              </form>
            </table>
          </td>
        </tr>
        <form name="cateList" >
          <tr bgcolor="#FFFFFF"> 
            <td height="30" colspan="6" align="center" class="font3">产品小类清单</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="212"> 
              <div align="center">产品小类名称</div>
            </td>
            <td width="157"> 
              <div align="center">表达语言 </div>
            </td>
            <td width="44"> 
              <div align="center">&nbsp;</div>
            </td>
            <td width="44"> 
              <div align="center">&nbsp;</div>
            </td>
          </tr>
<%
  try
  {
    action = request.getParameter("action");
    if((action != null)&&(action.equals("browse")))
    {
      tempSqlStr = "select c.cateID,c.lang_code,l.descr,c.cateName " +
        " from category c,lang_desc l " +
        " where typeID = '" + typeID + "' and c.lang_code = l.lang_code order by cateID";

      cateManager.setSqlStr(tempSqlStr);
      cateInfo = cateManager.getDatas();
      if(typeInfo != null)
      {
        while(cateInfo.next())
        {
          cateID = cateInfo.getString("cateID");
          cateName = cateInfo.getString("cateName");
          langDesc = cateInfo.getString("descr");
          langCode = cateInfo.getString("lang_code");
%>
          <tr bgcolor="#FFFFFF">
            <td align="center" width="212" height="30"><%=cateName%></td>
            <td height="30" width="157">&nbsp;&nbsp;<%=langDesc%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td height="30" width="44"><a href="cateModify.jsp?cateID=<%=cateID%>&langCode=<%=langCode%>">修改</a></td>
            <td height="30" width="44"><a href="javascript:cateDelete('<%=cateID%>','<%=langCode%>')">删除</a> 
            </td>
          </tr>
<%

        }
        cateManager.disconn();
      }
    }
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
%> 
        </form>
        <form name="cateDel" method="post" action="cateDelete.jsp">
          <input type="hidden" name="cateID" >
          <input type="hidden" name="langCode">
        </form>
      </table>
    </td>
  </tr>



</table>
</body>
</html>

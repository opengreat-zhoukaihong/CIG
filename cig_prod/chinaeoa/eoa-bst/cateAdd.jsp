<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>

<%!
    String highLevel = "5";
    String userType,userLevel,eoaLoginID;
    // userType 1:EOA; 2:individual; 3:company; 4:dealer; 5:supplier; 6:supplier&dealer;
    // userLevel 1: normal user; 5: powerUser;
%>
<%

    eoaLoginID = (String)session.getValue("cneoa.UserId");
    userLevel = (String)session.getValue("cneoa.UserLevel");
    userType = (String)session.getValue("cneoa.MemberType");

    if(eoaLoginID == null)    // can not get the loginID from session
    {
%>
      <jsp:forward page="loginIdError.jsp" />
<%
    }
    else
    {
      if(!(highLevel.equals(userLevel)))      // the user is not a power user
      {
%>
      <jsp:forward page="permError.jsp" />
<%        
      }
      else
      {
        if(!("1".equals(userType)))
        {
%>
        <jsp:forward page="permError.jsp" />
<%
        }
      }
    }
%>

<html>
<head>
<title>增加产品小类</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">

<script>

  function validateForm()
  {
    if(document.cateAdd.cateName.value == "")
    {
      alert("请先输入产品小类名称,然后再提交!");
      document.cateAdd.cateName.focus();
      return false;
    }
  }
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%!
  String lang_code = "GB";
  ResultSet langInfo,typeInfo;
  String tempSqlStr;
  Vector v_langCodeID = new Vector();
  Vector v_langCodeDesc = new Vector();
  Vector v_typeID = new Vector();
  Vector v_typeName = new Vector();
%>

<jsp:useBean id="langCode" scope="page" class="com.cig.chinaeoa.bst.LangCode" />
<jsp:useBean id="typeManager" scope="page" class="com.cig.chinaeoa.bst.TypeManager" />

<%
  try
  {
    if(!v_langCodeID.isEmpty())
      v_langCodeID.removeAllElements();
    if(!v_langCodeDesc.isEmpty())
      v_langCodeDesc.removeAllElements();
    if(!v_typeID.isEmpty())
      v_typeID.removeAllElements();
    if(!v_typeName.isEmpty())
      v_typeName.removeAllElements();

    langCode.setSqlStr("select lang_code,descr from lang_desc");
    langInfo = langCode.getDatas();
    if(langInfo != null)
    {
      while(langInfo.next())
      {
        v_langCodeID.addElement(langInfo.getString("lang_code"));
        v_langCodeDesc.addElement(langInfo.getString("descr"));
      }
      langCode.disconn();
    }
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


<table width="200" border="0" cellspacing="0" cellpadding="2">

  <tr>
    <td rowspan="2"><img src="/images/spacer.gif" width="15" height="8"></td>
    <td><img src="/images/spacer.gif" width="15" height="1"></td>
  </tr>
  <tr>
    <td>
      <table border=1 bordercolordark=#ffffff bordercolorlight=#6666FF
      cellpadding=5 cellspacing=2 width=500>
        <form name="cateAdd" method="post" action="cateAddResult.jsp" onSubmit="return validateForm()">
          <tr bgcolor="#FFFFFF">
            <td height="30" colspan="2" align="center" class="font3">添加产品小类</td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td align="center" width="134">
              <div align="right">所属大类：</div>
            </td>
            <td width="334">
              <select name="typeID">
                <%  for(int i=0;i<v_typeID.size();i++) { %>
                <option value="<%=v_typeID.elementAt(i)%>"><%=v_typeName.elementAt(i)%></option>
                <%  }   %>
              </select>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td align="center" width="134">
              <div align="right">产品小类名称：</div>
            </td>
            <td width="334">
              <input type="text" name="cateName" size="30" class="font1">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td align="center" width="134" height="30">
              <div align="right">表达语言：</div>
            </td>
            <td width="334" height="30">
              <select name="langCode">
                <%  for(int i=0;i<v_langCodeID.size();i++) { %>
                <option value="<%=v_langCodeID.elementAt(i)%>"><%=v_langCodeDesc.elementAt(i)%></option>
                <%  }   %>
              </select>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="2" align="center" height="50"> 
              <input type="image" src="/images/temp/b_add.gif" name="cancel2" value="取   消" class="font1" width="80" height="17">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a href="typeAdd.jsp" target="_self"><img src="/images/temp/reset.gif" name="cancel" value="取   消" class="font1" width="80" height="17" border="0" ></a> 
            </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>



</table>
</body>
</html>

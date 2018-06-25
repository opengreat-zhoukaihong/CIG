<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>
<%@ include file="bstChkLogin.jsp"%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">

<script>

  function validateForm()
  {
    if(document.typeAdd.typeName.value == "")
    {
      alert("���������Ʒ��������,Ȼ�����ύ!");
      document.typeAdd.typeName.focus();
      return false;
    }
  }
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%!
  ResultSet langInfo;
  Vector v_langCodeID = new Vector();
  Vector v_langCodeDesc = new Vector();
%>

<jsp:useBean id="langCode" scope="page" class="com.cig.chinaeoa.bst.LangCode" />

<%
  try
  {
    if(!v_langCodeID.isEmpty())
      v_langCodeID.removeAllElements();
    if(!v_langCodeDesc.isEmpty())
      v_langCodeDesc.removeAllElements();

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
      
        <form name="typeAdd" method="post" action="typeAddResult.jsp" onSubmit="return validateForm()">
          <tr bgcolor="#FFFFFF">
            <td height="30" colspan="2" align="center" class="font3">��Ӳ�Ʒ����</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="134">��Ʒ�������ƣ�</td>
            <td width="334"> 
              <input type="text" name="typeName" size="30" class="font1">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="134" height="30">������ԣ�</td>
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
              <input type="image" src="/images/temp/b_add.gif" name="cancel2" value="ȡ   ��" class="font1" width="80" height="17">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a href="typeAdd.jsp" target="_self"><img src="/images/temp/reset.gif" name="cancel" value="ȡ   ��" class="font1" width="80" height="17" border="0" ></a> 
            </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>



</table>
</body>
</html>

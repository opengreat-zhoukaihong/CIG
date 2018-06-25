<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="login" scope="session" class="com.cig.chinaeoa.LoginBean" />

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">

<script>
  function setDir()
  {
    document.brandAdd.picDirValue.value = document.brandAdd.picDir.options[document.brandAdd.picDir.selectedIndex].text;
  }

  function validateForm()
  {
    if(document.brandAdd.brand.value == "")
    {
      alert("请先输入品牌名称,然后再提交!");
      document.brandAdd.brand.focus();
      return false;
    }
    if(document.brandAdd.picDir.value == "0")
    {
      alert("请先选择图片目录,然后再提交!");
      document.brandAdd.picDir.focus();
      return false;
    }
    if(document.brandAdd.picFile.value == "")
    {
      alert("请先选择图片文件,然后在提交!");
      document.brandAdd.picFile.focus();
      return false;
    }
  }
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%!
  ResultSet langInfo,dirInfo;
  Vector v_langCodeID = new Vector();
  Vector v_langCodeDesc = new Vector();
  Vector v_picDirID = new Vector();
  Vector v_picDir = new Vector();
%>

<jsp:useBean id="langCode" scope="page" class="com.cig.chinaeoa.bst.LangCode" />
<jsp:useBean id="picDir" scope="page" class="com.cig.chinaeoa.bst.PicDir" />

<%
  try
  {
    if(!v_langCodeID.isEmpty())
      v_langCodeID.removeAllElements();
    if(!v_langCodeDesc.isEmpty())
      v_langCodeDesc.removeAllElements();
    if(!v_picDirID.isEmpty())
      v_picDirID.removeAllElements();
    if(!v_picDir.isEmpty())
      v_picDir.removeAllElements();

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

    picDir.setSqlStr("select dirID,dir from dir_setting");
    dirInfo = picDir.getDatas();
    if(dirInfo != null)
    {
      while(dirInfo.next())
      {
        v_picDirID.addElement(dirInfo.getString("dirID"));
        v_picDir.addElement(dirInfo.getString("dir"));
      }
      picDir.disconn();
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
      
        <form enctype="multipart/form-data" name="brandAdd" method="post" action="brandAddResult.jsp" onSubmit="return validateForm()">
          <tr bgcolor="#FFFFFF"> 
            <td height="30" colspan="2" align="center" class="font3">添加品牌</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69">品牌名称：</td>
            <td width="262"> 
              <input type="text" name="brand" size="30" class="font1">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69" height="30">表达语言：</td>
            <td width="262" height="30"> 
              <select name="langCode">

           <%  for(int i=0;i<v_langCodeID.size();i++) { %>
                <option value="<%=v_langCodeID.elementAt(i)%>"><%=v_langCodeDesc.elementAt(i)%></option>
           <%  }   %>

              </select>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69">图片目录：</td>
            <td width="262">
              <select name="picDir" onChange="setDir()">
                <option value="0">--请选择--</option>

           <%  for(int i=0;i<v_picDirID.size();i++) { %>
                <option value="<%=v_picDirID.elementAt(i)%>"><%=v_picDir.elementAt(i)%></option>
           <%  }   %>

              </select>
              <input type="hidden" name="picDirValue" >

            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69">图片文件：</td>
            <td width="262"> 
              <input type="file" name="picFile">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="2" align="center" height="50"> 
              <input type="image" src="/images/temp/b_add.gif" name="cancel2" value="取   消" class="font1" width="80" height="17">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a href="brandAdd.jsp" target="_self"><img src="/images/temp/reset.gif" name="cancel" value="取   消" class="font1" width="80" height="17" border="0" ></a>
            </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>



</table>
</body>
</html>


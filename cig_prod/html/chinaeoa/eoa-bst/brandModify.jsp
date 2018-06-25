<%@ page import="java.util.*, java.sql.*,java.io.* " session="true" language="java" errorPage="../error.jsp" %>
<%@ include file="bstChkLogin.jsp"%>
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
    if(document.brandModify.brand.value == "")
    {
      alert("请先输入品牌名称,然后再提交!");
      document.brandModify.brand.focus();
      return false;
    }
  }
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%!
  ResultSet langInfo,dirInfo,brandInfo;
  Vector v_langCodeID = new Vector();
  Vector v_langCodeDesc = new Vector();
  Vector v_picDirID = new Vector();
  Vector v_picDir = new Vector();
  String brandID,langCodeID,picDirID,picDirValue,fileName,name,srcUrl;
  String tempSqlStr;
%>

<jsp:useBean id="langCode" scope="page" class="com.cig.chinaeoa.bst.LangCode" />
<jsp:useBean id="picDir" scope="page" class="com.cig.chinaeoa.bst.PicDir" />
<jsp:useBean id="brandManager" scope="page" class="com.cig.chinaeoa.bst.BrandManager" />

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

    brandID = request.getParameter("brandID");
    langCodeID = request.getParameter("langCode");

    tempSqlStr = "select b.name,b.picDir,b.fileName,d.dir from brand b,dir_setting d where b.brandID = '" +
      brandID + "' and b.lang_code = '" + langCodeID + "' and b.picDir = d.dirID";

    brandManager.setSqlStr(tempSqlStr);
    brandInfo = brandManager.getDatas();
    if(brandInfo != null)
    {
      if(brandInfo.next())
      {
        picDirID = brandInfo.getString("picDir");
        picDirValue = brandInfo.getString("dir");
        name = brandInfo.getString("name");
        fileName = brandInfo.getString("fileName");
        srcUrl = "/" + picDirValue + fileName;
      }
      brandManager.disconn();
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
        <form enctype="multipart/form-data" name="brandModify" method="post" action="brandModifyResult.jsp" onSubmit="return validateForm()">
          <tr bgcolor="#FFFFFF"> 
            <td height="30" colspan="2" align="center" class="font3">修改品牌信息</td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69">品牌名称：</td>
            <td width="262"> 
              <input type="text" name="brand" value="<%=name%>" size="30" class="font1">
              <input type="hidden" name="brandID" value="<%=brandID%>">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69" height="30">表达语言：</td>
            <td width="262" height="30"> 
              <select name="langCode">
                <%  for(int i=0;i<v_langCodeID.size();i++)
               {
                 if(v_langCodeID.elementAt(i).equals(langCodeID))
                 {
           %> 
                <option value="<%=v_langCodeID.elementAt(i)%>" selected><%=v_langCodeDesc.elementAt(i)%></option>
                <%
                 }
                 else
                 {
           %> 
                <option value="<%=v_langCodeID.elementAt(i)%>"><%=v_langCodeDesc.elementAt(i)%></option>
                <%
                  }
                }
           %> 
              </select>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69">图片目录：</td>
            <td width="262"> 
              <select name="picDir" onChange="setDir()">
                <option value="0">--请选择--</option>
                <%   for(int i=0;i<v_picDirID.size();i++)
                {
                  if(v_picDirID.elementAt(i).equals(picDirID))
                  {
           %> 
                <option value="<%=v_picDirID.elementAt(i)%>" selected><%=v_picDir.elementAt(i)%></option>
                <%
                  }
                  else
                  {
           %> 
                <option value="<%=v_picDirID.elementAt(i)%>"><%=v_picDir.elementAt(i)%></option>
                <%
                  }
                }
           %> 
              </select>
              <input type="hidden" name="picDirValue" value="<%=picDirValue%>">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69"> 
              <div align="center">当前图标：</div>
            </td>
            <td width="262"><img src="<%=srcUrl%>"></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="center" width="69">图片文件：</td>
            <td width="262"> 
              <input type="file" name="picFile">
            </td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="2" align="center" height="50"> 
              <input type="image" src="/images/temp/b_modify.gif" name="cancel2" value="取   消" class="font1" width="80" height="17">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a href="brandModify.jsp?brandID=<%=brandID%>&langCode=<%=langCodeID%>" target="_self"><img src="/images/temp/reset.gif" name="cancel" value="取   消" class="font1" width="80" height="17" >
            </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>



</table>
</body>
</html>

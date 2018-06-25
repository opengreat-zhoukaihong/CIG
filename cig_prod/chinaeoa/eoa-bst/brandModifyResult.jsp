<%@ page language="java" import="com.jspsmart.upload.*, java.sql.* " %>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="brandManager" scope="page" class="com.cig.chinaeoa.bst.BrandManager" />


<html>
<head>
</head>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/eoa.css" rel="stylesheet" type="text/css">

<body bgcolor="#FFFFFF" >

<%!
  String brandID = "";
  String brand = "";
  String langCode = "";
  String picDir = "";
  String picFile = "";

  int count = 0;
  int errorCode;
  String fileField = "";
  String fileName = "";
  String tempStr="";
%>
<%
  myUpload.initialize(pageContext);
  myUpload.upload();

  try
  {
    count = myUpload.save("/www/html/chinaeoa/" + myUpload.getRequest().getParameter("picDirValue"));
      //out.println("/home/httpd/html/chinaeoa/" + myUpload.getRequest().getParameter("picDirValue"));
%>

    <p class="font1"><%=count%>��ͼƬ�ļ�����.</p>
<%
  }
  catch (Exception e)
  {
    out.println(e.toString());
  }

  java.util.Enumeration e = myUpload.getRequest().getParameterNames();

	// Retreive parameters
  while (e.hasMoreElements())
  {
    String key = (String)e.nextElement();
    String[] values = myUpload.getRequest().getParameterValues(key);
    if (key.equals("brand"))
      brand = values[0];
    else if (key.equals("brandID"))
      brandID = values[0];
    else if (key.equals("langCode"))
       langCode = values[0];
    else if (key.equals("picDir"))
        picDir = values[0];

  }
//out.println("<BR><STRONG>Display information about Files</STRONG><BR>");

//out.println("Number of files = " + myUpload.getFiles().getCount() + "<BR>");
	//out.println("Total size (bytes) = " + myUpload.getFiles().getSize() +"<BR>");

  for (int i=0;i<myUpload.getFiles().getCount();i++)
  {
    fileField = myUpload.getFiles().getFile(i).getFieldName();
    if (fileField.equals("picFile"))
      fileName = myUpload.getFiles().getFile(i).getFileName();
    //out.println(myUpload.getFiles().getFile(i).getFileName());
    if (!myUpload.getFiles().getFile(i).isMissing())
    {
      tempStr = "�ļ���:" + myUpload.getFiles().getFile(i).getFileName() + " (" + myUpload.getFiles().getFile(i).getSize() + ")";
%>
      <p class="font1"><%=tempStr%></p>
<%
    }
    //else
    //  out.print("��ͼƬ����.");
    out.println("<BR>");
  }

  brandManager.setBrandID(brandID);
  brandManager.setLang_code(langCode);
  brandManager.setName(brand);
  brandManager.setPicDir(picDir);
  brandManager.setFileName(fileName);

  brandManager.modifyBrand();

  errorCode = brandManager.getErrorCode();
  if(errorCode == 0)
  {
%>
    <p  class="font1">��Ϣ�޸ĳɹ�!</p>
    <p  class="font3"><a href="brandList.jsp">����</a></p>
<%
  }
  else
  {
%>
     <p  class="font1">�޸�ʧ��!</p>
     <p  class="font3"><a href="javascript:history.go(-1);">����</a></p>
<%
  }
%>

</body>
</html>
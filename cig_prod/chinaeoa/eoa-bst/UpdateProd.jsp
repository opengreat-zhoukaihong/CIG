<%@ page language="java" import="com.jspsmart.upload.*, java.sql.*"%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<html>
<head>
</head>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >

<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />


<%
String ProdId = "";         
String BrandId = "";
String TypeId = "";
String CateId = "";
String Supplier = "";
String ProductNo = "";
String PicDir1 = "";
String FileName1 = "";
String PicDir2 = "";
String FileName2 = "";
String ListPrice = "";
String Price1 = "";
String Price2 = "";
String Price3 = "";
String Price4 = "";
String Price5 = "";
String LangCode = "GB";
String ShortDesc = "";
String Desc = "";
boolean InsProd = false;
boolean InsProdL = false;
String SQL = "";
int count = 0;
String FileField = "";
String ProdName = "";
String Status = "";

myUpload.initialize(pageContext);



myUpload.upload();


//String test = myUpload.getRequest().getParameter("Brand");
//out.print("test = " + tset);
		
try 
{
  count = myUpload.save("/www/html/chinaeoa/" + myUpload.getRequest().getParameter("Dir1"));
   out.println("/home/httpd/html/chinaeoa/" + myUpload.getRequest().getParameter("Dir1"));
    ProdId = myUpload.getRequest().getParameter("ProdId");
  out.println(count + " 个图片文件上载.<br>");

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
    if (key.equals("Brand"))
      BrandId = values[0];
     else if (key.equals("Type"))
       TypeId = values[0];
       
     else if (key.equals("Category"))
        CateId = values[0];
     else if (key.equals("Supplier"))
        Supplier = values[0];
     else if (key.equals("ProductNo"))
        ProductNo = values[0];
     else if (key.equals("PicDir1"))
        PicDir1 = values[0];
     //else if (key.equals("PicDir2"))
     //   PicDir2 = values[0];
     else if (key.equals("ListPrice"))
        ListPrice = values[0];
     else if (key.equals("Price1"))
       Price1 = values[0];
     else if (key.equals("Price2"))
       Price2 = values[0];
     else if (key.equals("Price3"))
       Price3 = values[0];
     else if (key.equals("Price4"))
        Price4 = values[0];
     else if (key.equals("Price5"))
        Price5 = values[0];
     else if (key.equals("ShortDesc"))
        ShortDesc = values[0];
     else if (key.equals("Desc"))
        Desc = values[0];
     else if (key.equals("ProdName"))
        ProdName = values[0];
     else if (key.equals("Status"))
        Status = values[0];
      			
}
//out.println("<BR><STRONG>Display information about Files</STRONG><BR>");

//out.println("Number of files = " + myUpload.getFiles().getCount() + "<BR>");
	//out.println("Total size (bytes) = " + myUpload.getFiles().getSize() +"<BR>");

for (int i=0;i<myUpload.getFiles().getCount();i++)
{
  FileField = myUpload.getFiles().getFile(i).getFieldName();		
   if (FileField.equals("file1"))
     FileName1 = myUpload.getFiles().getFile(i).getFileName();
   else if (FileField.equals("file2"))
     FileName2 = myUpload.getFiles().getFile(i).getFileName();
   //out.println(myUpload.getFiles().getFile(i).getFileName());
   if (!myUpload.getFiles().getFile(i).isMissing())
      out.print("文件名:" + myUpload.getFiles().getFile(i).getFileName() + " (" + myUpload.getFiles().getFile(i).getSize() + ")");
   else
      out.print(" = vide");		
   out.println("<BR>");
}

if (PicDir1.equals("0"))
  PicDir1 = "";

if (FileName2 != null)
  PicDir2 = PicDir1;


if (count == 0)
  SQL = "update product set brandid = '" + BrandId + "'," + 
			     	"TypeId = '" + TypeId + "'," + 
			  	"CateId = '" + CateId + "'," + 
				"supplier = '" + Supplier + "'," + 
				"Price1 = '" + Price1 + "'," + 
				"Price2 = '" + Price2 + "'," + 
				"Price3 = '" + Price3 + "'," + 
				"Price4 = '" + Price4 + "'," + 
				"Price5 = '" + Price5 + "'," + 
				"Status = '" + Status + "'," + 
				"ListPrice = '" + ListPrice + "'   where prodid = " + ProdId ;
else
   SQL = "update product set brandid = '" + BrandId + "'," + 
			     	"TypeId = '" + TypeId + "'," + 
			  	"CateId = '" + CateId + "'," + 
				"supplier = '" + Supplier + "'," + 
				"PicDir1 = '" + PicDir1 + "'," + 
				"PicDir2 = '" + PicDir2 + "'," + 
				"FileName1 = '" + FileName1 + "'," + 
				"FileName2 = '" + FileName2 + "'," + 
				"Price1 = '" + Price1 + "'," + 
				"Price2 = '" + Price2 + "'," + 
				"Price3 = '" + Price3 + "'," + 
				"Price4 = '" + Price4 + "'," + 
				"Price5 = '" + Price5 + "'," + 
				"Status = '" + Status + "'," + 
				"ListPrice = '" + ListPrice  + "'  where prodid = " + ProdId ;
				
                              			
//out.println(SQL);
Result.setAutoCommit(false);
InsProd = Result.IsExecute(SQL);
SQL = "update Product_l set  shortdesc = '" + ShortDesc + "', Prod_Name='" + ProdName + 
		                 "', Descr = '" + Desc + "'  where ProdId = " + ProdId + " and Lang_code = '" + LangCode + "'";


InsProdL = Result.IsExecute(SQL);
if (InsProd && InsProdL)
{ 
  out.println("OK");
   Result.setAutoCommit(true);  
}
else
{ 
  out.println("Err");
    Result.setAutoCommit(false);
}
out.println(SQL);
//<jsp:forward page="bstLogin.htm"></jsp:forward>

      
Result.CloseStm();
if (InsProd && InsProdL)
{ 
  response.sendRedirect("bstProductEdit.jsp?LangCode=GB&ProdId=" + ProdId);
}
else
{
  out.println("Error!");
}
out.print("Status = " + Status);

%>


</body>
</html>
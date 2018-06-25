<%@ page language="java" import="com.jspsmart.upload.*, java.sql.*"%>
<%@ include file="bstChkLogin.jsp"%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="Result" scope="page" class="com.cig.chinaeoa.ResultBean" />
<html>
<head>
</head>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >




<%
String ProdId = "";         
String StartDate = "";
String EndDate = "";
String Location = "";
String PicDir1 = "";
String FileName1 = "";
String SQL = "";
int count = 0;
String FileField = "";

myUpload.initialize(pageContext);



myUpload.upload();


//String test = myUpload.getRequest().getParameter("Brand");
//out.print("test = " + tset);
		
try 
{
  count = myUpload.save("/www/html/chinaeoa/" +    myUpload.getRequest().getParameter("Dir1"));
   //out.println("/home/httpd/html/chinaeoa/" +   //myUpload.getRequest().getParameter("Dir1"));
  // out.println(count + " 个图片文件上载.<br>");
  

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
    if (key.equals("ProductNo"))
      ProdId = values[0];
    else if (key.equals("StartDate"))
      StartDate = values[0];
    else if (key.equals("EndDate"))
      EndDate = values[0];
    else if (key.equals("PicDir1"))
      PicDir1 = values[0];
    else if (key.equals("Location"))
      Location = values[0];
  
      			
}




//out.println("<BR><STRONG>Display information about Files</STRONG><BR>");

//out.println("Number of files = " + myUpload.getFiles().getCount() + "<BR>");
	//out.println("Total size (bytes) = " + myUpload.getFiles().getSize() +"<BR>");

for (int i=0;i<myUpload.getFiles().getCount();i++)
{
  FileField = myUpload.getFiles().getFile(i).getFieldName();		
   if (FileField.equals("file1"))
     FileName1 = myUpload.getFiles().getFile(i).getFileName();

}

if ((EndDate != null) && (!EndDate.equals("")))
  SQL = "insert into speci_sale ( PRODID,PICDIR1,FILENAME1,LOCATION ,BE_DATE ,END_DATE ) "         +  "values (" + ProdId + ",'" + 
                                 PicDir1 + "','" + 
                                 FileName1 + "','" + 
		         				 Location + "',to_date('" + 
                                 StartDate + "','YYYY-MM-DD'),to_date('" + 
		                         EndDate + "','YYYY-MM-DD'))";
else
  SQL = "insert into speci_sale ( PRODID,PICDIR1,FILENAME1,LOCATION ,BE_DATE  ) " + 
                     "values (" + ProdId + ",'" + 
                                 PicDir1 + "','" + 
                                 FileName1 + "','" + 
		         				 Location + "',to_date('" + 
                                 StartDate + "','YYYY-MM-DD'))";
out.println(SQL);






  
//<jsp:forward page="bstLogin.htm"></jsp:forward>


if (Result.IsExecute(SQL))
{ 
        
  Result.CloseStm();
  response.sendRedirect("bstHotEdit.jsp?ProdId=" +
            ProdId + "&StartDate=" + StartDate + "&Location=" + Location);
}
else
{  
        
  Result.CloseStm();
  out.println("Error!");
}


%>


</body>
</html>
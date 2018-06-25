<%@ page language="java" import="com.jspsmart.upload.*"%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />

<HTML>
<BODY BGCOLOR="white">

<H1>jspSmartUpload : Sample 5</H1>
<HR>

<%
	int count = 0;
	// Initialization
	myUpload.initialize(pageContext);

	// Upload
	myUpload.upload();		

	//
	// Files
	//
           try {

		// Save the files with their original names in the virtual path "/upload"
		// if it doesn't exist try to save in the physical path "/upload"
		count = myUpload.save("/home/httpd/html/chinaeoa/images");
		
		// Save the files with their original names in the virtual path "/upload"
		// count = mySmartUpload.save("/upload", mySmartUpload.SAVE_VIRTUAL);

		// Display the number of files uploaded 
		out.println(count + " file(s) uploaded.");

	} catch (Exception e) { 
		out.println(e.toString());
	}


	out.println("<BR><STRONG>Display information about Files</STRONG><BR>");

	out.println("Number of files = " + myUpload.getFiles().getCount() + "<BR>");
	//out.println("Total size (bytes) = " + myUpload.getFiles().getSize() +"<BR>");

	for (int i=0;i<myUpload.getFiles().getCount();i++){
		
		out.print(myUpload.getFiles().getFile(i).getFieldName());
		if (!myUpload.getFiles().getFile(i).isMissing())
			out.print(" = " + myUpload.getFiles().getFile(i).getFileName() + " (" + myUpload.getFiles().getFile(i).getSize() + ")");
		else
			out.print(" = vide");		
		out.println("<BR>");
	}


	//
	// Request
	//

	out.println("<BR><BR><STRONG>Display information about Requests</STRONG><BR>");


	// Retreive Requests' names
	java.util.Enumeration e = myUpload.getRequest().getParameterNames();

	// Retreive parameters
	while (e.hasMoreElements()) {

		String key = (String)e.nextElement();
		String[] values = myUpload.getRequest().getParameterValues(key);			
		
		// Browse the current parameter values
		for(int i = 0; i < values.length; i++) {
		   out.print(key + " = ");
		   out.print(values[i] + "<BR>");
		}		
	}

%>


</BODY>
</HTML>





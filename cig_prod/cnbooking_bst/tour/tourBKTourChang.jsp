<%@ page language="java" import="com.jspsmart.upload.*,java.util.*, java.net.*"%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="TourBKTourChang" scope="page" class="com.cnbooking.bst.tour.TourBKTourChang" />
<%
int count=0;
myUpload.initialize(pageContext);
myUpload.upload();
String info="";
String path="/www/html/cnbooking";
try{
  count = myUpload.save(path+myUpload.getRequest().getParameter("dirpath"));
  info= count + " 个图片文件上载.<br>";
} 
catch (Exception e){ 
 info = e.toString();
}
String ope_ID=myUpload.getRequest().getParameter("ope_ID");
String dir_ID=myUpload.getRequest().getParameter("dir_ID");
String city_ID=myUpload.getRequest().getParameter("city_ID");
String line_ID=myUpload.getRequest().getParameter("line_ID");



String imageFile1=null;
String price1 = myUpload.getRequest().getParameter("price1");
String price2 = myUpload.getRequest().getParameter("price2");
String price3 = myUpload.getRequest().getParameter("price3");
String price4 = myUpload.getRequest().getParameter("price4");
String price5 = myUpload.getRequest().getParameter("price5");
String price6 = myUpload.getRequest().getParameter("price6");
String price0 = myUpload.getRequest().getParameter("price0");
String currency =myUpload.getRequest().getParameter("currency");
String tel = myUpload.getRequest().getParameter("tel");

String fileField;
for (int i=0;i<myUpload.getFiles().getCount();i++)
{
   fileField = myUpload.getFiles().getFile(i).getFieldName();		
   if (fileField.equals("imageFile1"))
     imageFile1 = myUpload.getFiles().getFile(i).getFileName();
   if (myUpload.getFiles().getFile(i).isMissing())
      imageFile1=null;
}

 TourBKTourChang.setOpeID(ope_ID);
 if(city_ID!=null)
 TourBKTourChang.setCityID(city_ID);
 if(line_ID!=null)
 TourBKTourChang.setLineID(line_ID);
 if(dir_ID!=null)
 TourBKTourChang.setDirID(dir_ID);

 if(count>=1)
 TourBKTourChang.setFileName(imageFile1);
 TourBKTourChang.setTel(tel);
 TourBKTourChang.setCurrency(currency);
 if(price0!=null)
 TourBKTourChang.setPrice0(price0);
 if(price1!=null)
 TourBKTourChang.setPrice1(price1);
 if(price2!=null)
 TourBKTourChang.setPrice2(price2);
 if(price3!=null)
 TourBKTourChang.setPrice3(price3);
 if(price4!=null)
 TourBKTourChang.setPrice4(price4);
 if(price5!=null)
 TourBKTourChang.setPrice5(price5);
 if(price6!=null)
 TourBKTourChang.setPrice6(price6);
 if(TourBKTourChang.UpdateTourPrice()){ 
       info += "恭喜,旅游更改成功!<br>";
    }
    else{
       info +="很抱歉,旅游更改未能成功，请检查数据!";
  }
 
String title="旅游更改";
response.sendRedirect("../ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));

%>
<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

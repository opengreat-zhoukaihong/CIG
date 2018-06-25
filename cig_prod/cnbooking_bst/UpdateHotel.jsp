<%@ page language="java" import="com.jspsmart.upload.*"%>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.bst.UserInfo" /> 

<%
   String yesterday="";
   String tomorrow="";
   if (!UserInfo.getAuthorized()){
%>
	<jsp:forward page="main_middle.htm" />
	</jsp:forward>
<% }else{
   	yesterday = UserInfo.getYesterday();
   	tomorrow  = UserInfo.getTomorrow();
   }
%>
<jsp:useBean id="myUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="db" scope="page" class="com.cnbooking.hotel.Database" />
<jsp:useBean id="quHotel" scope="page" class="com.cnbooking.hotel.Query" />
<jsp:useBean id="sqlProvide" scope="page" class="com.cnbooking.hotel.SqlProvide" />
<jsp:useBean id="pqHotel" scope="page" class="com.cnbooking.hotel.PreparedQuery" />
<jsp:useBean id="pqHotelL" scope="page" class="com.cnbooking.hotel.PreparedQuery" />
<jsp:useBean id="mfHotel" scope="page" class="com.cnbooking.hotel.MoveFile" />

<html>
<head>
</head>
<title>products</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<body bgcolor="#FFFFFF" >

<%

String prodDir = "/www/html/cnbooking";
String prodTmpDir = "/www/html/cnbooking/prod_images/tmp/";

int count;
myUpload.initialize(pageContext);
myUpload.upload();


//String test = myUpload.getRequest().getParameter("Brand");
//out.print("test = " + tset);
		
try 
{
  count = myUpload.save("/www/html/cnbooking/prod_images/tmp/");
  //out.println("/home/httpd/html/chinaeoa/" + myUpload.getRequest().getParameter("Dir1"));
  out.println(count + " 个图片文件上载.<b r>");
  //countryId = myUpload.getRequest().getParameter("CountryId");
  //out.println("countryId = " + countryId);

} 
catch (Exception e) 
{ 
   out.println(e.toString());
}


String langCode = myUpload.getRequest().getParameter("LangCode");
String hotelId = myUpload.getRequest().getParameter("HotelId");
String countryId = myUpload.getRequest().getParameter("CountryId");
String cityId = myUpload.getRequest().getParameter("CityId");
String stateId = myUpload.getRequest().getParameter("StateId");
String locaId = myUpload.getRequest().getParameter("LocaId");
String tel = myUpload.getRequest().getParameter("Tel");
String postcode = myUpload.getRequest().getParameter("Postcode");
String fax = myUpload.getRequest().getParameter("Fax");
String email = myUpload.getRequest().getParameter("Email");
String contact = myUpload.getRequest().getParameter("Contact");
String url = myUpload.getRequest().getParameter("Url");
String starRating = myUpload.getRequest().getParameter("StarRating");
String imageDir = myUpload.getRequest().getParameter("ImageDir");
String imageFile1 = myUpload.getRequest().getParameter("OldImageFile1");
String imageFile2 = myUpload.getRequest().getParameter("OldImageFile2");
String imageFile3 = myUpload.getRequest().getParameter("OldImageFile3");
String oldImageFile1 = myUpload.getRequest().getParameter("OldImageFile1");
String oldImageFile2 = myUpload.getRequest().getParameter("OldImageFile2");
String oldImageFile3 = myUpload.getRequest().getParameter("OldImageFile3");
String mapDirId = myUpload.getRequest().getParameter("MapDirId");
String mapFileName = myUpload.getRequest().getParameter("OldMapFileName");
String oldMapFileName = myUpload.getRequest().getParameter("OldMapFileName");
String promotion = myUpload.getRequest().getParameter("Promotion");
String priceTypeId = myUpload.getRequest().getParameter("PriceTypeId");
String status = myUpload.getRequest().getParameter("Status");
String remark = myUpload.getRequest().getParameter("Remark");

String shortName  = myUpload.getRequest().getParameter("ShortName");
String location  = myUpload.getRequest().getParameter("Location");
String name = myUpload.getRequest().getParameter("Name");
String address = myUpload.getRequest().getParameter("Address");
String facilityDrink = myUpload.getRequest().getParameter("FacilityDrink");
String facilityEnv = myUpload.getRequest().getParameter("FacilityEnt");
String facilityServ = myUpload.getRequest().getParameter("FacilityServ");
String fullDescr = myUpload.getRequest().getParameter("FullDescr");


String fileField;
for (int i=0;i<myUpload.getFiles().getCount();i++)
{
   fileField = myUpload.getFiles().getFile(i).getFieldName();		
   if (fileField.equals("ImageFile1"))
     imageFile1 = myUpload.getFiles().getFile(i).getFileName();
   else if (fileField.equals("ImageFile2"))
     imageFile2 = myUpload.getFiles().getFile(i).getFileName();
   else if (fileField.equals("ImageFile3"))
     imageFile3 = myUpload.getFiles().getFile(i).getFileName();
   else if (fileField.equals("MapFileName"))
     mapFileName = myUpload.getFiles().getFile(i).getFileName();
   //out.println(myUpload.getFiles().getFile(i).getFileName());
   if (!myUpload.getFiles().getFile(i).isMissing())
      out.print("文件名:" + myUpload.getFiles().getFile(i).getFileName() + " (" + myUpload.getFiles().getFile(i).getSize() + ")");
   else
      out.print(" = vide");		
   out.println("<BR>");
}

if (imageFile1 == null || imageFile1.length() == 0)
  imageFile1 = oldImageFile1;
if (imageFile2 == null || imageFile2.length() == 0)
  imageFile2 = oldImageFile2;
if (imageFile3 == null || imageFile3.length() == 0)
  imageFile3 = oldImageFile3;
if (mapFileName == null || mapFileName.length() == 0)
  mapFileName = oldMapFileName;  


sqlProvide.setLangCode(langCode);
quHotel.setConnection(db.getConnection());
pqHotel.setConnection(db.getConnection());
pqHotel.setSql(sqlProvide.getUpdateSql("Bst.Hotel"));
pqHotelL.setConnection(db.getConnection());
pqHotelL.setSql(sqlProvide.getUpdateSql("Bst.Hotel_L"));
out.print(sqlProvide.getUpdateSql("Bst.Hotel_L"));
boolean isAutoCommit = false;
db.setAutoCommit(isAutoCommit);


pqHotel.createPS();

pqHotel.setParameter(1,countryId);
pqHotel.setParameter(2,stateId);
pqHotel.setParameter(3,cityId);
pqHotel.setParameter(4,locaId);
pqHotel.setParameter(5,tel);
pqHotel.setParameter(6,postcode);
pqHotel.setParameter(7,fax);
pqHotel.setParameter(8,email);
pqHotel.setParameter(9,contact);
pqHotel.setParameter(10,url);
pqHotel.setParameter(11,starRating);
pqHotel.setParameter(12,imageDir);
if (imageFile1.equals("null"))
  imageFile1 = "";
pqHotel.setParameter(13,imageFile1);
if (imageFile2.equals("null"))
  imageFile2 = "";
pqHotel.setParameter(14,imageFile2);
if (imageFile3.equals("null"))
  imageFile3 = "";
pqHotel.setParameter(15,imageFile3);
pqHotel.setParameter(16,mapDirId);
if (mapFileName.equals("null"))
  mapFileName = "";
pqHotel.setParameter(17,mapFileName);
pqHotel.setParameter(18,promotion);
pqHotel.setParameter(19,priceTypeId);
pqHotel.setParameter(20,status);
pqHotel.setParameter(21,"admin");
pqHotel.setParameter(22,remark);
pqHotel.setParameter(23,hotelId);
//pqHotel.setParameter(24,"sysdate");
//pqHotel.setParameter(25,postcode);
boolean isInsertHotel = pqHotel.execute();
out.print("hotel=" + pqHotel.getMessage());

pqHotelL.createPS();



pqHotelL.setParameter(1,shortName);
pqHotelL.setParameter(2,location);
pqHotelL.setParameter(3,name);
pqHotelL.setParameter(4,address);
pqHotelL.setParameter(5,facilityDrink);
pqHotelL.setParameter(6,facilityEnv);
pqHotelL.setParameter(7,facilityServ);
pqHotelL.setParameter(8,fullDescr);
pqHotelL.setParameter(9,hotelId);
pqHotelL.setParameter(10,langCode);

boolean isInsertHotelL = pqHotelL.execute();
out.print("detail" + pqHotelL.getMessage());

if (isInsertHotel && isInsertHotelL)
{
  db.commit();
}
else
{
  db.cancel();
}

out.println("===" + hotelId);
out.println(countryId);
out.println(stateId);
out.println(cityId);
out.println(locaId);
out.println(tel);
out.println(postcode);
out.println(fax);
out.println(email);
out.println(contact);
out.println(url);
out.println(starRating);
out.println(imageDir);
out.println(imageFile1);
out.println(imageFile2);
out.println(imageFile3);
out.println(mapDirId);
out.println(mapFileName);
out.println(promotion);
out.println(priceTypeId);
out.println(status);

out.print("pqHotel.message= " + pqHotel.getMessage());


out.print("im1" + imageFile1);
out.print("im2" + imageFile2);
out.print("im3" + imageFile2);
out.print("im4" + mapFileName);
out.print("=================");
out.println(hotelId);
out.println(langCode);
out.println(shortName);
out.println(location);
out.println(name);
out.println(address);
out.println(facilityDrink);
out.println(facilityEnv);
out.println(facilityServ);
out.println(fullDescr);
out.println(hotelId);
out.println(langCode);
//movefile
String fromFileName;
String toFileName;
sqlProvide.setDirId(imageDir);
quHotel.executeQuery(sqlProvide.getSql("Bst.GetDir"));
out.print(sqlProvide.getSql("Bst.GetDir"));
quHotel.setRow(1);
imageDir = quHotel.getFieldValue("Dir");
out.print("imageDir" + imageDir);
sqlProvide.setDirId(mapDirId);
quHotel.executeQuery(sqlProvide.getSql("Bst.GetDir"));
quHotel.setRow(1);
String mapDir = quHotel.getFieldValue("Dir");
out.print(mapDir);
if (!imageFile1.equals(oldImageFile1))
{
  fromFileName = prodTmpDir + imageFile1;
  toFileName = prodDir + imageDir + imageFile1;
  out.print(fromFileName + "//" + toFileName);
  out.print("mv=" + mfHotel.moveFile(fromFileName, toFileName));
}
if (!imageFile2.equals(oldImageFile2))
{
  fromFileName = prodTmpDir + imageFile2;
  toFileName = prodDir + imageDir + imageFile2;
  mfHotel.moveFile(fromFileName, toFileName);
}
if (!imageFile3.equals(oldImageFile1))
{
  fromFileName = prodTmpDir + imageFile3;
  toFileName = prodDir + imageDir + imageFile3;
  mfHotel.moveFile(fromFileName, toFileName);
}

if (!mapFileName.equals(oldMapFileName))
{
  fromFileName = prodTmpDir + mapFileName;
  toFileName = prodDir + mapDir + mapFileName;
  mfHotel.moveFile(fromFileName, toFileName);
}

db.closeConection();
out.print(isInsertHotel);
out.print(isInsertHotelL);
if (isInsertHotel && isInsertHotelL)
  response.sendRedirect("HotelModify.jsp?HotelId=" + hotelId + "&LangCode=" + langCode);
%>


</body>
</html>
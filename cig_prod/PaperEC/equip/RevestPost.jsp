<%@ page import="java.util.*, java.net.*" %>
<%
    Hashtable pHash =new Hashtable();
    String art_ID=request.getParameter("art_ID");
    pHash.put("art_ID",art_ID);
    pHash.put("langCode",new String("GB"));
    String cont_Name=request.getParameter("cont_Name");
    if(cont_Name!=null)
    pHash.put("cont_Name",cont_Name);
    String cont_Email=request.getParameter("cont_Email");
    if(cont_Email!=null)
    pHash.put("cont_Email",cont_Email);
    String cont_tel=request.getParameter("cont_tel");
    if(cont_tel!=null)
    pHash.put("cont_tel",cont_tel);
    String cont_Address=request.getParameter("cont_Address");
    if(cont_Address!=null)
    pHash.put("cont_Address",cont_Address);
    String cont_Postcode=request.getParameter("cont_Postcode");
    if(cont_Postcode!=null)
    pHash.put("cont_Postcode",cont_Postcode);
    String content=request.getParameter("content");
    if(content!=null)
    pHash.put("content",content);
    
    String art_Type=request.getParameter("art_Type");
    if(art_Type!=null)
    pHash.put("art_Type",art_Type);
    String type_ID=request.getParameter("type_ID");
    if(type_ID!=null)
    pHash.put("type_ID",type_ID);

    String artName=request.getParameter("artName");
    if(artName!=null)
    pHash.put("name",artName);
    String manufactory=request.getParameter("manufactory");
    if(manufactory!=null)
    pHash.put("manufactory",manufactory);
    String manuf_Date=request.getParameter("manuf_Date");
    if(manuf_Date!=null)
    pHash.put("manuf_Date",manuf_Date);
    String spec=request.getParameter("spec");
    if(spec!=null)
    pHash.put("spec",spec);
    String machine_Loca=request.getParameter("machine_Loca");
    if(machine_Loca!=null)
    pHash.put("machine_Loca",machine_Loca);
    String machine_Status=request.getParameter("machine_Status");
    if(machine_Status!=null)
    pHash.put("machine_Status",machine_Status);
    String price=request.getParameter("price");
    if(price!=null)
    pHash.put("price",price);
    String vali_Date=request.getParameter("vali_Date");
    if(vali_Date!=null)
    pHash.put("vali_Date",vali_Date);
    String comp_name=request.getParameter("comp_name");
    if(comp_name!=null)
    pHash.put("comp_name",comp_name);
    String paper_Flag=request.getParameter("paper_Flag");
    if(paper_Flag!=null)
    pHash.put("paper_Flag",paper_Flag);
    String status=request.getParameter("status");
    if(status!=null)
    pHash.put("status",status);
    String ip=request.getRemoteAddr();
    if(ip!=null)
    pHash.put("IP",ip);
%>
<jsp:useBean id="Equip_Art" scope="page" class="com.paperec.equip.Equip_Art" />
<%
  Equip_Art.setParameteres(pHash);
  String info="";

 if(Equip_Art.InsertDates()){
 	info += "恭喜,回复成功!<br>";
    }
    else{
	info +="很抱歉,回复未能成功，请检查数据!";
  }
String title="回复信息";
response.sendRedirect("ok.jsp?title="+URLEncoder.encode(title)+"&info="+URLEncoder.encode(info));
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

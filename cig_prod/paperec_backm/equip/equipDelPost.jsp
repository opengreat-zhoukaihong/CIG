<%@ page import="java.util.*, java.net.*" %>
<%
    String info="";
    Hashtable pHash =new Hashtable();
    String art_ID=request.getParameter("art_ID");
    if(art_ID!=null)
    pHash.put("art_ID",art_ID);
    String type_ID = request.getParameter("type_ID");
    String art_Type=request.getParameter("art_Type");
    if(type_ID!=null)
    pHash.put("type_ID",type_ID);
    else
    type_ID="";
    if(art_Type!=null)
    pHash.put("art_Type",art_Type);
    else
    art_Type="";

    String fromDate=request.getParameter("fromDate");
    if(fromDate!=null)
    pHash.put("fromDate",fromDate);
    String toDate=request.getParameter("toDate");
    if(toDate!=null)
    pHash.put("toDate",toDate);
    
    String pageNo=request.getParameter("pageNo");
    if(pageNo==null)
    pageNo="1";
%>
<jsp:useBean id="Equip_Art" scope="page" class="com.paperec.equip.Equip_Art" />
<%
  Equip_Art.setParameteres(pHash);

 if(Equip_Art.DelDates()){
 	info += "恭喜,删除成功!<br>";
    }
    else{
	info +="很抱歉,删除未能成功，请检查数据!";
  }
response.sendRedirect("equipBKList.jsp?art_Type="+art_Type+"&type_ID="+type_ID+"&pageNo="+pageNo);
%>
<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>
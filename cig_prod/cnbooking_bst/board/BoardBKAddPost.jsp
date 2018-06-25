<%@ page import="java.util.*, java.net.*" %>
<%
    String info="";
    String ope_ID=request.getParameter("ope_ID");
    if(ope_ID==null)
    ope_ID="admin";
    Hashtable pHash =new Hashtable();
    pHash.put("ope_ID",ope_ID);
    String pageNo=request.getParameter("pageNo");
    String str = request.getParameter("str");
    String titles=request.getParameter("titles");
    if(titles!=null)
    pHash.put("titles",titles);
    String content=request.getParameter("content");
    if(content!=null)
    pHash.put("content",content);
    String att=request.getParameter("att");
    if(att!=null)
    pHash.put("att",att);
%>
<jsp:useBean id="Int_BBS" scope="page" class="com.cnbooking.bst.board.Int_BBS" />
<%
  Int_BBS.setParameteres(pHash);

 if(Int_BBS.InsertDates()){
 	info += "恭喜,添加成功!<br>";
    }
    else{
	info +="很抱歉,添加未能成功，请检查数据!";
  }
response.sendRedirect("BoardBKList.jsp?ope_ID="+ope_ID+"&pageNo="+pageNo+str);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

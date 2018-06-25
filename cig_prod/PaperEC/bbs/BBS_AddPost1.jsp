<%@ page import="bbs.*, java.util.*, java.net.*" %>
<jsp:useBean id="PostNew" scope="page" class="bbs.PostNew" /> 
<%
    String info;
    String content=request.getParameter("content").trim();
    String name=request.getParameter("userName").trim();
    String eMail=request.getParameter("email").trim();
    String title=request.getParameter("titles").trim();
    String parent_ID=request.getParameter("parent_ID").trim();
    String cate_ID=request.getParameter("cate_ID").trim();
    String area_ID=request.getParameter("area_ID").trim();
    String root_ID=request.getParameter("root_ID").trim();
    PostNew.setRoot_ID(root_ID);
    PostNew.setParent_ID(parent_ID);
    PostNew.setCate_ID(cate_ID);
    PostNew.setName(name);
    PostNew.setEMail(eMail);
    PostNew.setTitle(title);
    PostNew.setContent(content);
    //PostNew.init(); 
  
   if(PostNew.addOrChgBBS()) 
    { 
	info = "恭喜,您已发布成功!<br>";
    }
    else
    {
	info ="很抱歉,您未能发布成功，请检查数据!";
    }
    response.sendRedirect("BBS_ViewDetail.jsp?cate_ID="+cate_ID+"&article_ID="+parent_ID+"&area_ID="+area_ID);
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>


<%@ page import="java.util.*, java.net.*" %>
<%
    String info="";
    String ope_ID=request.getParameter("ope_ID");
    if(ope_ID==null)
    ope_ID="admin";
    Hashtable pHash =new Hashtable();
    String pageNo=request.getParameter("pageNo");
    String str = request.getParameter("str");
    String parameteres=request.getParameter("parameteres");
    if(parameteres!=null)
    pHash.put("ids",parameteres);
%>
<jsp:useBean id="Int_BBS" scope="page" class="com.cnbooking.bst.board.Int_BBS" />
<%
  Int_BBS.setParameteres(pHash);

 if(Int_BBS.DelDates()){
 	info += "��ϲ,ɾ���ɹ�!<br>";
    }
    else{
	info +="�ܱ�Ǹ,ɾ��δ�ܳɹ�����������!";
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
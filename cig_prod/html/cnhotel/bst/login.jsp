<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="com.dreamerland.cnhotelbooking.bst.*" %>
<%@ page import="com.dreamerland.db.*" %>



<%! Connection conCnHotel; %>
<%! Statement stmOperator; %>
<%! ResultSet rsOperator; %>


<% 
   try
    {
      Class.forName(CDbConf.dbDriver);
      conCnHotel = DriverManager.getConnection(CDbConf.dbUrl, CDbConf.dbUser , CDbConf.dbPasswd);
      stmOperator = conCnHotel.createStatement();
    }
    catch (Exception e){}

    out.println("<html>");
    out.println("<head><title>JdbcTest12</title></head>");
    out.println("<Body>");
    
    String opLogin = request.getParameter("txtLogin");
    String opPasswd = request.getParameter("txtPassword");

    String wSql = "Select * from operator_gb where login = '" +
                   opLogin + "' and passwd = '" + opPasswd + "'";
    try
    {
      synchronized(this)
      {
        rsOperator = stmOperator.executeQuery (wSql);
        if (rsOperator.next ())
        {
          String opID = rsOperator.getString("ID");
			    session.putValue("login.isDone", opID);
//          session.removeValue("login.id");
			    session.putValue("login.id", opID);
          String wHttp = request.getScheme() + "://" + request.getServerName() +
                ":" + request.getServerPort() + "/";
          out.print("<p>&nbsp;</p><p>&nbsp;</p>");
          out.println ("<center><p></p><p></p><p></p><img src=" + wHttp + "images/loginsucess.gif></center>");


%>

<%

//          log("CbstLogin:saved in session opID=" +
//            (String)session.getValue("login.id"));
        }
        else
        {
          out.println("<p></P><a href='"+ request.getScheme() + "://" + request.getServerName() +
            ":" + request.getServerPort() + "/main_middle.htm'>登录姓名或密码不正确,请重新登录!</a></center>" );

        }
      }
    }
    catch (SQLException e)
    {
      out.println("Error=" + wSql);
    }
	
out.println(session.getValue("login.id"));
    out.println("</body></html>");

%>

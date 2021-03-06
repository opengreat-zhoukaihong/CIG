package com.db;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.dreamerland.db.*;

public class TestServlet extends HttpServlet
{
	private DBConnectionManager connMgr;

	public void init(ServletConfig conf) throws ServletException
	{
		super.init(conf);
		connMgr = DBConnectionManager.getInstance();
	}

	public void service(HttpServletRequest req, HttpServletResponse res)
		throws IOException
	{
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		Connection con = connMgr.getConnection("cnhotel");
		if (con == null)
		{
			out.println("不能获取数据库连接.");
			return;
		}
		ResultSet rs = null;
		ResultSetMetaData md = null;
		Statement stmt = null;
		try
		{
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM state_gb");
			md = rs.getMetaData();
			out.println("<H1>省份数据</H1>");
			while (rs.next())
			{
				out.println("<BR>");
				for (int i = 1; i < md.getColumnCount(); i++)
				{
					out.print(rs.getString(i) + ", ");
				}
			}
			stmt.close();
			rs.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace(out);
		}
		connMgr.freeConnection("cnhotel", con);
	}

	public void destroy()
	{
		connMgr.release();
		super.destroy();
	}
}

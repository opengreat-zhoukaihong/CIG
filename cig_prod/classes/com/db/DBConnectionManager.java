package com.db;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

/**
* 管理类DBConnectionManager支持对一个或多个由属性文件定义的数据库连接
* 池的访问.客户程序可以调用getInstance()方法访问本类的唯一实例.
*/
public class DBConnectionManager
{
	static private DBConnectionManager instance; // 唯一实例
	static private int clients;
	static private int expireTime;
//    static private MonitorThread monitorThread = null;

	private Vector drivers = new Vector();
	private PrintWriter log;
	private Hashtable pools = new Hashtable();

	/**
	* 返回唯一实例.如果是第一次调用此方法,则创建实例
	*
	* @return DBConnectionManager 唯一实例
	*/
	static synchronized public DBConnectionManager getInstance()
	{
		if (instance == null) {
			instance = new DBConnectionManager();
		}
		clients++;
		return instance;
	}

	/**
	* 建构函数私有以防止其它对象创建本类实例
	*/
	private DBConnectionManager()
	{
		init();
	}

	/**
	* 将连接对象返回给由名字指定的连接池
	*
	* @param name 在属性文件中定义的连接池名字
	* @param con 连接对象
	*/
	public void freeConnection(String name, Connection con)
	{
		DBConnectionPool pool = (DBConnectionPool) pools.get(name);
		if (pool != null)
		{
			pool.freeConnection(con);
		}
	}

	/**
	* 获得一个可用的(空闲的)连接.如果没有可用连接,且已有连接数小于最大连接数
	* 限制,则创建并返回新连接
	*
	* @param name 在属性文件中定义的连接池名字
	* @return Connection 可用连接或null
	*/
	public Connection getConnection(String name)
	{
		DBConnectionPool pool = (DBConnectionPool) pools.get(name);
		if (pool != null)
		{
			return pool.getConnection();
		}
		return null;
	}

	/**
	* 获得一个可用连接.若没有可用连接,且已有连接数小于最大连接数限制,
	* 则创建并返回新连接.否则,在指定的时间内等待其它线程释放连接.
	*
	* @param name 连接池名字
	* @param time 以毫秒计的等待时间
	* @return Connection 可用连接或null
	*/
	public Connection getConnection(String name, long time)
	{
		DBConnectionPool pool = (DBConnectionPool) pools.get(name);
		if (pool != null)
		{
			return pool.getConnection(time);
		}
		return null;
	}

	/**
	* 关闭所有连接,撤销驱动程序的注册
	*/
	public synchronized void release()
	{
		// 等待直到最后一个客户程序调用
		if (--clients != 0)
		{
			return;
		}

		Enumeration allPools = pools.elements();
		while (allPools.hasMoreElements())
		{
			DBConnectionPool pool = (DBConnectionPool) allPools.nextElement();
			pool.release();
		}
		Enumeration allDrivers = drivers.elements();
		while (allDrivers.hasMoreElements())
		{
			Driver driver = (Driver) allDrivers.nextElement();
			try
			{
				DriverManager.deregisterDriver(driver);
				log("Remove JDBC driver: " + driver.getClass().getName());
			}
			catch (SQLException e)
			{
				log(e, "Unable to remove JDBC: " + driver.getClass().getName());
			}
		}
	}

	/**
	* 根据指定属性创建连接池实例.
	*
	* @param props 连接池属性
	*/
	private void createPools(Properties props)
	{
		Enumeration propNames = props.propertyNames();
		while (propNames.hasMoreElements())
		{
			String name = (String) propNames.nextElement();
			if (name.endsWith(".url"))
			{
				String poolName = name.substring(0, name.lastIndexOf("."));
				String url = props.getProperty(poolName + ".url");
				if (url == null) {
					log("No URL for connection pool: " + poolName);
					continue;
				}
				String user = props.getProperty(poolName + ".user");
				String password = props.getProperty(poolName + ".password");
				String maxconn = props.getProperty(poolName + ".maxconn", "0");
				int max;
				try
				{
					max = Integer.valueOf(maxconn).intValue();
				}
				catch (NumberFormatException e)
				{
					log("Wrong number of max connection limitation: " + maxconn + " for db pool: " + poolName);
					max = 0;
				}
				DBConnectionPool pool =
					new DBConnectionPool(poolName, url, user, password, max);
				pools.put(poolName, pool);
				log("Successfully create connection pool: " + poolName);
			}
		}
	}

	/**
	* 读取属性完成初始化
	*/
	private void init()
	{
		InputStream is = getClass().getResourceAsStream("/db.properties");
		Properties dbProps = new Properties();
		try
		{
			dbProps.load(is);
		}
		catch (Exception e)
		{
			System.err.println("Open properties file failed. " +
				"Please ENSURE file db.properties in CLASSPATH.");
			return;
		}
		String logFile = dbProps.getProperty("logfile", "DBConnectionManager.log");
		try
		{
			log = new PrintWriter(new FileWriter(logFile, true), true);
		}
		catch (IOException e)
		{
			System.err.println("Unable to open log file: " + logFile);
			log = new PrintWriter(System.err);
		}

		String strExpireTime = dbProps.getProperty("expiretime", "20");
		try
		{
			expireTime = Integer.valueOf(strExpireTime).intValue() * 1000;
		}
		catch (NumberFormatException e)
		{
			log("Wrong expireTime");
			expireTime = 1800 * 1000;
		}

		loadDrivers(dbProps);
		createPools(dbProps);

        // create a monitor thread to monitor the connections status
//        monitorThread = new MonitorThread(10);
//        monitorThread.start();
	}

	/**
	* 装载和注册所有JDBC驱动程序
	*
	* @param props 属性
	*/
	private void loadDrivers(Properties props)
	{
		String driverClasses = props.getProperty("drivers");
		StringTokenizer st = new StringTokenizer(driverClasses);
		while (st.hasMoreElements())
		{
			String driverClassName = st.nextToken().trim();
			try
			{
				Driver driver = (Driver)
				Class.forName(driverClassName).newInstance();
				DriverManager.registerDriver(driver);
				drivers.addElement(driver);
				log("Successfully register JDBC driver: " + driverClassName);
			}
			catch (Exception e)
			{
				log("Failed to register JDBC driver: " +
					driverClassName + ", ERROR: " + e);
			}
		}
	}

	/**
	* 将文本信息写入日志文件
	*/
	private void log(String msg)
	{
		log.println(new Date() + ": " + msg);
	}

	/**
	* 将文本信息与异常写入日志文件
	*/
	private void log(Throwable e, String msg)
	{
		log.println(new Date() + ": " + msg);
		e.printStackTrace(log);
	}

	/**
	* 此内部类定义了一个连接池.它能够根据要求创建新连接,直到预定的最
	* 大连接数为止.在返回连接给客户程序之前,它能够验证连接的有效性.
	*/
	class DBConnectionPool
	{
		private int checkedOut;
		private Vector freeConnections = new Vector();
		private int maxConn;
		private String name;
		private String password;
		private String URL;
		private String user;

		/**
		* 创建新的连接池
		*
		* @param name 连接池名字
		* @param URL 数据库的JDBC URL
		* @param user 数据库帐号,或 null
		* @param password 密码,或 null
		* @param maxConn 此连接池允许建立的最大连接数
		*/
		public DBConnectionPool(String name, String URL, String user, String password,
			int maxConn)
		{
			this.name = name;
			this.URL = URL;
			this.user = user;
			this.password = password;
			this.maxConn = maxConn;
		}

		/**
		* 将不再使用的连接返回给连接池
		*
		* @param con 客户程序释放的连接
		*/
		public synchronized void freeConnection(Connection con)
		{
			ExConnection exCon = (ExConnection) con;
			if (exCon == null)
			{
				log("XXX freeConnection: got a null connection of pool " + name);
				return;
			}
			if (exCon.getExpireTime() < System.currentTimeMillis())
			{
				try {
					exCon.close();
					log("Expire time reach.  Close a connection from pool: " + name);
				} catch (SQLException ex)
				{
					log("Expired!!  Error in closing a connection from pool: " + name);
				}
				checkedOut--;
				return;
			}
			// 将指定连接加入到向量末尾
			freeConnections.addElement(con);
			checkedOut--;
			log("--- " + checkedOut + " freeConnection: return it back into pool: " + name);
			notifyAll();
		}

		/**
		* 从连接池获得一个可用连接.如没有空闲的连接且当前连接数小于最大连接
		* 数限制,则创建新连接.如原来登记为可用的连接不再有效,则从向量删除之,
		* 然后递归调用自己以尝试新的可用连接.
		*/
		public synchronized Connection getConnection()
		{
			Connection con = null;
			if (freeConnections.size() > 0)
			{
				// 获取向量中第一个可用连接
				con = (Connection) freeConnections.firstElement();
				freeConnections.removeElementAt(0);
				try
				{
					if (con.isClosed())
					{
						log("Remove an invalid connection from connection pool: " + name);
						// 递归调用自己,尝试再次获取可用连接
						con = getConnection();
					}
				}
				catch (SQLException e)
				{
					log("err: Remove an invalid connection from connection pool: " + name);
					// 递归调用自己,尝试再次获取可用连接
					con = getConnection();
				}
			}
			else if (maxConn == 0 || checkedOut < maxConn)
			{
				con = newConnection();
			}
			if (con != null)
			{
				checkedOut++;
				log("+++ " + checkedOut + " getConnection: get it from pool: " + name);
			}
			return con;
		}

		/**
		* 从连接池获取可用连接.可以指定客户程序能够等待的最长时间
		* 参见前一个getConnection()方法.
		*
		* @param timeout 以毫秒计的等待时间限制
		*/
		public synchronized Connection getConnection(long timeout)
		{
			long startTime = new Date().getTime();
			Connection con;
			while ((con = getConnection()) == null)
			{
				try
				{
					wait(timeout);
				}
				catch (InterruptedException e) {}
				if ((new Date().getTime() - startTime) >= timeout)
				{
					// wait()返回的原因是超时
					return null;
				}
			}
			return con;
		}

		/**
		* 关闭所有连接
		*/
		public synchronized void release()
		{
			Enumeration allConnections = freeConnections.elements();
			while (allConnections.hasMoreElements())
			{
				Connection con = (Connection) allConnections.nextElement();
				try
				{
					con.close();
					log("release: Close a connection from pool: " + name);
				}
				catch (SQLException e)
				{
					log(e, "release: Unable to close a connection from pool: " + name);
				}
			}
			freeConnections.removeAllElements();
		}

		/**
		* 创建新的连接
		*/
		private Connection newConnection()
		{
			Connection con = null;
			ExConnection exCon = null;
			try
			{
				if (user == null)
				{
					con = DriverManager.getConnection(URL);
				}
				else
				{
					con = DriverManager.getConnection(URL, user, password);
				}
				log("newConnection: Create a new connection from pool: " + name);
				exCon = new ExConnection(con, expireTime);
			}
			catch (SQLException e)
			{
				log(e, "newConnection: Unable to create connection using URL: " + URL);
				return null;
			}
			return exCon;
		}
	}

    class MonitorThread extends Thread
    {
        int waitTime;
        int waitCount;
        MonitorThread()
        {
            waitTime = 10000;
        }

        MonitorThread(int wait_time)
        {
            waitTime = wait_time * 1000;
        }

        public void run()
        {
            try
            {
                waitCount = 5;
                Thread.sleep(waitTime);
                waitCount ++;
            }
            catch (InterruptedException e) {}
        }
    }

/*
 * @(#)Connection.java	1.19 98/09/29
 *
 * Copyright 1996-1998 by Sun Microsystems, Inc.,
 * 901 San Antonio Road, Palo Alto, California, 94303, U.S.A.
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Sun Microsystems, Inc. ("Confidential Information").  You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with Sun.
 */

/**
 * <P>A connection (session) with a specific
 * database. Within the context of a Connection, SQL statements are
 * executed and results are returned.
 *
 * <P>A Connection's database is able to provide information
 * describing its tables, its supported SQL grammar, its stored
 * procedures, the capabilities of this connection, and so on. This
 * information is obtained with the <code>getMetaData</code> method.
 *
 * <P><B>Note:</B> By default the Connection automatically commits
 * changes after executing each statement. If auto commit has been
 * disabled, an explicit commit must be done or database changes will
 * not be saved.
 *
 * @see DriverManager#getConnection
 * @see Statement
 * @see ResultSet
 * @see DatabaseMetaData
 */
class ExConnection implements Connection
{
	Connection con;  // db connection connect to database
	long createTime; // create time of con
	long expireTime; // the time con will be expired

	public ExConnection(Connection newCon, long expire)
	{
		con = newCon;
		createTime = System.currentTimeMillis();
		expireTime = createTime + expire;
	}

	public Connection getConnection()
	{
		return con;
	}

	public void setConnection(Connection newCon)
	{
		con = newCon;
	}

	public long getExpireTime()
	{
		return expireTime;
	}

	public long getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(long newTime)
	{
		createTime = newTime;
	}

	// ---- implementation of java.sql.Connection -----
    public Statement createStatement() throws SQLException
    {
    	return con.createStatement();
    }

    public PreparedStatement prepareStatement(String sql)
	    throws SQLException
	{
		return con.prepareStatement(sql);
	}

    public CallableStatement prepareCall(String sql) throws SQLException
    {
    	return con.prepareCall(sql);
    }

	public String nativeSQL(String sql) throws SQLException
    {
    	return con.nativeSQL(sql);
    }

    public void setAutoCommit(boolean autoCommit) throws SQLException
    {
    	con.setAutoCommit(autoCommit);
    }

    public boolean getAutoCommit() throws SQLException
    {
    	return con.getAutoCommit();
    }

    public void commit() throws SQLException
    {
    	con.commit();
    }

    public void rollback() throws SQLException
    {
    	con.rollback();
    }

    public void close() throws SQLException
    {
    	con.close();
    }

    public boolean isClosed() throws SQLException
    {
    	return con.isClosed();
    }

    public DatabaseMetaData getMetaData() throws SQLException
    {
    	return con.getMetaData();
    }

    public void setReadOnly(boolean readOnly) throws SQLException
    {
    	con.setReadOnly(readOnly);
    }

    public boolean isReadOnly() throws SQLException
    {
    	return con.isReadOnly();
    }

    public void setCatalog(String catalog) throws SQLException
    {
    	con.setCatalog(catalog);
    }

    public String getCatalog() throws SQLException
    {
    	return con.getCatalog();
    }

    int TRANSACTION_NONE	     = 0;

    int TRANSACTION_READ_UNCOMMITTED = 1;

    int TRANSACTION_READ_COMMITTED   = 2;

    int TRANSACTION_REPEATABLE_READ  = 4;

    int TRANSACTION_SERIALIZABLE     = 8;

    public void setTransactionIsolation(int level) throws SQLException
    {
    	con.setTransactionIsolation(level);
    }

    public int getTransactionIsolation() throws SQLException
    {
    	return con.getTransactionIsolation();
    }

    public SQLWarning getWarnings() throws SQLException
    {
    	return con.getWarnings();
    }

    public void clearWarnings() throws SQLException
    {
    	con.clearWarnings();
    }

    //--------------------------JDBC 2.0-----------------------------
    public Statement createStatement(int resultSetType, int resultSetConcurrency)
      throws SQLException
    {
    	return con.createStatement(resultSetType, resultSetConcurrency);
    }

     public PreparedStatement prepareStatement(String sql, int resultSetType,
					int resultSetConcurrency)
       throws SQLException
    {
    	return con.prepareStatement(sql, resultSetType, resultSetConcurrency);
    }

    public CallableStatement prepareCall(String sql, int resultSetType,
				 int resultSetConcurrency) throws SQLException
    {
    	return con.prepareCall(sql, resultSetType, resultSetConcurrency);
    }

    public java.util.Map getTypeMap() throws SQLException
    {
    	return con.getTypeMap();
    }

    public void setTypeMap(java.util.Map map) throws SQLException
    {
    	con.setTypeMap(map);
    }
}

}



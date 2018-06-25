package com.db;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

/**
* ������DBConnectionManager֧�ֶ�һ�������������ļ���������ݿ�����
* �صķ���.�ͻ�������Ե���getInstance()�������ʱ����Ψһʵ��.
*/
public class DBConnectionManager
{
	static private DBConnectionManager instance; // Ψһʵ��
	static private int clients;
	static private int expireTime;
//    static private MonitorThread monitorThread = null;

	private Vector drivers = new Vector();
	private PrintWriter log;
	private Hashtable pools = new Hashtable();

	/**
	* ����Ψһʵ��.����ǵ�һ�ε��ô˷���,�򴴽�ʵ��
	*
	* @return DBConnectionManager Ψһʵ��
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
	* ��������˽���Է�ֹ�������󴴽�����ʵ��
	*/
	private DBConnectionManager()
	{
		init();
	}

	/**
	* �����Ӷ��󷵻ظ�������ָ�������ӳ�
	*
	* @param name �������ļ��ж�������ӳ�����
	* @param con ���Ӷ���
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
	* ���һ�����õ�(���е�)����.���û�п�������,������������С�����������
	* ����,�򴴽�������������
	*
	* @param name �������ļ��ж�������ӳ�����
	* @return Connection �������ӻ�null
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
	* ���һ����������.��û�п�������,������������С���������������,
	* �򴴽�������������.����,��ָ����ʱ���ڵȴ������߳��ͷ�����.
	*
	* @param name ���ӳ�����
	* @param time �Ժ���Ƶĵȴ�ʱ��
	* @return Connection �������ӻ�null
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
	* �ر���������,�������������ע��
	*/
	public synchronized void release()
	{
		// �ȴ�ֱ�����һ���ͻ��������
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
	* ����ָ�����Դ������ӳ�ʵ��.
	*
	* @param props ���ӳ�����
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
	* ��ȡ������ɳ�ʼ��
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
	* װ�غ�ע������JDBC��������
	*
	* @param props ����
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
	* ���ı���Ϣд����־�ļ�
	*/
	private void log(String msg)
	{
		log.println(new Date() + ": " + msg);
	}

	/**
	* ���ı���Ϣ���쳣д����־�ļ�
	*/
	private void log(Throwable e, String msg)
	{
		log.println(new Date() + ": " + msg);
		e.printStackTrace(log);
	}

	/**
	* ���ڲ��ඨ����һ�����ӳ�.���ܹ�����Ҫ�󴴽�������,ֱ��Ԥ������
	* ��������Ϊֹ.�ڷ������Ӹ��ͻ�����֮ǰ,���ܹ���֤���ӵ���Ч��.
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
		* �����µ����ӳ�
		*
		* @param name ���ӳ�����
		* @param URL ���ݿ��JDBC URL
		* @param user ���ݿ��ʺ�,�� null
		* @param password ����,�� null
		* @param maxConn �����ӳ������������������
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
		* ������ʹ�õ����ӷ��ظ����ӳ�
		*
		* @param con �ͻ������ͷŵ�����
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
			// ��ָ�����Ӽ��뵽����ĩβ
			freeConnections.addElement(con);
			checkedOut--;
			log("--- " + checkedOut + " freeConnection: return it back into pool: " + name);
			notifyAll();
		}

		/**
		* �����ӳػ��һ����������.��û�п��е������ҵ�ǰ������С���������
		* ������,�򴴽�������.��ԭ���Ǽ�Ϊ���õ����Ӳ�����Ч,�������ɾ��֮,
		* Ȼ��ݹ�����Լ��Գ����µĿ�������.
		*/
		public synchronized Connection getConnection()
		{
			Connection con = null;
			if (freeConnections.size() > 0)
			{
				// ��ȡ�����е�һ����������
				con = (Connection) freeConnections.firstElement();
				freeConnections.removeElementAt(0);
				try
				{
					if (con.isClosed())
					{
						log("Remove an invalid connection from connection pool: " + name);
						// �ݹ�����Լ�,�����ٴλ�ȡ��������
						con = getConnection();
					}
				}
				catch (SQLException e)
				{
					log("err: Remove an invalid connection from connection pool: " + name);
					// �ݹ�����Լ�,�����ٴλ�ȡ��������
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
		* �����ӳػ�ȡ��������.����ָ���ͻ������ܹ��ȴ����ʱ��
		* �μ�ǰһ��getConnection()����.
		*
		* @param timeout �Ժ���Ƶĵȴ�ʱ������
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
					// wait()���ص�ԭ���ǳ�ʱ
					return null;
				}
			}
			return con;
		}

		/**
		* �ر���������
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
		* �����µ�����
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



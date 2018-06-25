<%@ page import="java.sql.*,javax.servlet.http.*" %>

<HTML>
<HEAD>
<SCRIPT LANGUAGE="JavaScript">
<!--
var wStr
function PostForm(I)
{
  if ( I == 1)
  {
    fmGrid.action = "DbGrid.jsp?PageFlag=PREV";
    fmGrid.submit();
  }
  else if ( I == 2)
  {
    fmGrid.action = "DbGrid.jsp?PageFlag=NEXT";
    fmGrid.submit();
  }
   else if ( I == 3)
  {
    fmGrid.action = "DbGrid.jsp?PageFlag=GO";
    fmGrid.submit();
  }
  
}

//-->
</SCRIPT>


<jsp:useBean id="DbGridId" scope="page" class="com.cig.chinaeoa.DbGridBean">
<% DbGridId.setSample("ttttt");
DbGridId.setErrMsg("mmmmm");
String[] Titles = {"名称","name_en","telephone","fax"};
String[] Fields = {"name","name_en","telephone","fax"};
String PageFlag;
String GoPage;
String opID = "test";
int PageCount = 1 ;
String SumCount;
int SumPage = 1;
SumCount = DbGridId.getSumCount("select count(name) from hotel_gb");
if (SumCount == null)
  SumCount = "0";
SumPage = (Integer.parseInt(SumCount)/10);
if (session.getValue("cneoa.PageCount") == null)
{
  PageCount = 1;
}
else
{
  PageFlag = request.getParameter("PageFlag");
  GoPage = request.getParameter("GoPage");
  if (PageFlag.equals("NEXT"))
  {
    PageCount = Integer.parseInt((String)session.getValue ("cneoa.PageCount"));
    if ((PageCount * 10) < Integer.parseInt(SumCount))
      PageCount = PageCount + 1;
  }
  else if (PageFlag.equals("PREV"))
  {
    PageCount = Integer.parseInt((String)session.getValue ("cneoa.PageCount"));
    if (PageCount > 1)
      PageCount = PageCount - 1;
  }
  else if (GoPage != null)
  {
    PageCount = Integer.parseInt(GoPage);
  }
}

session.putValue("cneoa.PageCount", String.valueOf(PageCount));


DbGridId.setTitles(Titles);
DbGridId.setFieldNames(Fields);
String SQL;
String MinCount;
String MaxCount;



MinCount = String.valueOf((PageCount - 1) * 10);
MaxCount = String.valueOf(PageCount * 10);
SQL = "select * from (select rownum sid, fax,name,name_en, telephone from hotel_gb) where sid >=" + MinCount +" and sid <= " + MaxCount ;
DbGridId.setSql(SQL);
%>
</jsp:useBean>

<BODY>
<%=(String)session.getValue("cneoa.PageCount")%>
<p>总数
<%=(String)request.getParameter("GoPage")%>
<FORM name="fmGrid" method="post" >


<INPUT NAME="GoPage">
<INPUT TYPE="button" VALUE="上页" onClick="javascript:PostForm(1)">
<INPUT TYPE="button" VALUE="下页" onClick="javascript:PostForm(2)">
<INPUT TYPE="button" VALUE="GO"   onClick="javascript:PostForm(3)" >

<%=DbGridId.getGrid() %>
  <p>&nbsp;</p>
</FORM>
</BODY>
</HTML>

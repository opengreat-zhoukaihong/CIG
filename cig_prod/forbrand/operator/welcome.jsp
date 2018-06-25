<%@ page language="java" errorPage="../login/error.jsp"%>
<% if(session.getAttribute("operator")==null) {%>
<jsp:forward page="../ResultsError.jsp?message=You haven't log in."/>
<% }
	else
	{ %>
<jsp:forward page="/operator/operlog.html"/>
<%	}	%>

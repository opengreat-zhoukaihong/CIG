<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<% if(session.getAttribute("userid")!=null) {%>
<jsp:forward page="car.jsp"/>
<% } %>

<html>
<head>
	<title>Login -- Forbrand.com</title>
<link rel="stylesheet" href="/public.css"><link rel="stylesheet" href="/public.css">
</head>

<body bgcolor="#FFFFFF">
   <form name="form3" action="../login/welcome.jsp" method="post">

  <p class="contact" align="center">If you are already a registered member, please
    log in below. </p>
  <p align="center"><span class="legal-notice">USER NAME:<br>
    </span>
    <input type="text" name="login" size="18" maxlength="18" class="legal-notice">
    <br>
    <span class="legal-notice">PASSWORD:</span><br>
    <input type="password" name="passwd" size="18" maxlength="18" class="legal-notice">
    <br>
    <br>
    <input type="image" border="0" name="imageField" src="../../images/login-buttom.jpg" width="68" height="25">
  </p>
  <p class="contact" align="center">Forgotten your password? <a href="../login/passwdrecover.jsp" target="_blank">click
    here</a>. </p>
  <p class="contact" align="center"> If you are not a registered membe, </p>
  <p class="contact" align="center"><a href="../login/regform.jsp" target="_blank">click
    here to regist</a>. </p>
  </form>


</body>
</html>

<%@ page import="com.cnbooking.*, java.util.*, java.net.*" %>
<jsp:useBean id="Convert" scope="page" class="com.cig.Convert" />
<jsp:useBean id="UserRegist" scope="page" class="com.cnbooking.UserRegist" /> 
<%
      String loginName = request.getParameter("login_name");
      String password  = request.getParameter("password");
      String name      = request.getParameter("name");
      String gender    = request.getParameter("gender");
      String email     = request.getParameter("email");
      String mobile    = request.getParameter("mobile");
      String city      = request.getParameter("city");
      String country   = request.getParameter("country");
      String newsletter= request.getParameter("newsletter");
      String state_id=request.getParameter("state_id");

      String phone  = request.getParameter("phone");
      String phone0 = request.getParameter("phone0");
   
    if(phone0 == null)
      phone0 = "";
    if(phone0.length() > 0)
      phone0 = phone0 + "-";

     String phone1 = request.getParameter("phone1");
    if ((phone1 != null) && (phone1.length()>0))
      phone = phone0 + phone1 + "-" + phone;

    // optional ones

     String rem_ques  = request.getParameter("rem_question");
    if(rem_ques == null)
     rem_ques = "";

     String rem_answ  = request.getParameter("rem_answer");
    if(rem_answ == null)
      rem_answ = "";

    String fax  = request.getParameter("fax");
    if(fax == null){
      fax = "";
    }else
    {
      String fax0 = request.getParameter("fax0");
      if(fax0 == null)
        fax0 = "";
      if(fax0.length()>0)
        fax0 = fax0 + "-";

    String fax1 = request.getParameter("fax1");
    if((fax1 != null) && (fax1.length() >0))
        fax = fax0 + fax1 + "-" + fax;
    }

    String address  = request.getParameter("address");
    if (address == null)
      address = "";

     String postcode  = request.getParameter("postcode");
    if(postcode == null)
      postcode = "";
      
    String points = "0";
    UserRegist.setLangCode("GB");
    UserRegist.setAction("0");
    UserRegist.setPoints(Convert.b2g(points));
    UserRegist.setLoginName(Convert.b2g(loginName));
    UserRegist.setPassword(Convert.b2g(password));
    UserRegist.setName(Convert.b2g(name));
    UserRegist.setGender(Convert.b2g(gender));
    UserRegist.setEmail(Convert.b2g(email));
    UserRegist.setMobile(Convert.b2g(mobile));
    UserRegist.setCity(Convert.b2g(city));
    UserRegist.setCountry(Convert.b2g(country));
    UserRegist.setNewsletter(Convert.b2g(newsletter));
    UserRegist.setPhone(Convert.b2g(phone));
    UserRegist.setQuestion(Convert.b2g(rem_ques));
    UserRegist.setAnswer(Convert.b2g(rem_answ));
    UserRegist.setFax(Convert.b2g(fax));
    UserRegist.setAddress(Convert.b2g(address));
    UserRegist.setPostcode(Convert.b2g(postcode));
    UserRegist.setStateID(Convert.b2g(state_id));
if(UserRegist.userActioning()){
%>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" />
<%
String currentPage=UserInfo.getCurrentPage();
UserInfo.setUsername(Convert.b2g(loginName));
UserInfo.setPassword(Convert.b2g(password));
UserInfo.login();
if(UserInfo.getAuthorized()){
 if(currentPage.length()>0){
 UserInfo.setCurrentPage("");
 response.sendRedirect(currentPage);
 }else{
 response.sendRedirect("/big/register_login.htm");
 }
 }
}
else{
response.sendRedirect("/big/signup_fault.htm");
}
%>

<%--
<html>
<head>
</head>
<body>
</body>
</html>
--%>

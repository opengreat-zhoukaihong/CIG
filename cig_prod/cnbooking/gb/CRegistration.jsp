<%@ page import="com.cnbooking.*, java.util.*, java.net.*" %>
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
    UserRegist.setPoints(points);
    UserRegist.setLoginName(loginName);
    UserRegist.setPassword(password);
    UserRegist.setName(name);
    UserRegist.setGender(gender);
    UserRegist.setEmail(email);
    UserRegist.setMobile(mobile);
    UserRegist.setCity(city);
    UserRegist.setCountry(country);
    UserRegist.setNewsletter(newsletter);
    UserRegist.setPhone(phone);
    UserRegist.setQuestion(rem_ques);
    UserRegist.setAnswer(rem_answ);
    UserRegist.setFax(fax);
    UserRegist.setAddress(address);
    UserRegist.setPostcode(postcode);
    UserRegist.setStateID(state_id);
if(UserRegist.userActioning()){
%>
<jsp:useBean id="UserInfo" scope="session" class="com.cnbooking.UserInfo" />
<%
String currentPage=UserInfo.getCurrentPage();
UserInfo.setUsername(loginName);
UserInfo.setPassword(password);
UserInfo.login();
if(UserInfo.getAuthorized()){
 if(currentPage.length()>0){
 UserInfo.setCurrentPage("");
 response.sendRedirect(currentPage);
 }else{
 response.sendRedirect("/gb/register_login.htm");
 }
}
}
else{
response.sendRedirect("/gb/signup_fault.htm");
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
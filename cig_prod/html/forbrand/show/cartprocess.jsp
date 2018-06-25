<%@ page import="java.util.*, com.forbrand.show.*" %>
<jsp:useBean id="myCart" scope="session" class="com.forbrand.show.ShoppingCartBean" />
<%
String action = request.getParameter("act");
int act;
if ( action != null ) {
  act = Integer.parseInt(action);
  if ( myCart != null ) {

    HashMap itemList = myCart.getCartItemList();
    switch (act) {
      case 0 :    //remove single item
        Integer giftID_I = Integer.valueOf(request.getParameter("giftID"));
        if ( itemList.containsKey(giftID_I) ) {
          itemList.remove(giftID_I);
        }
        break;
      case 1 :    //empty the cart
        itemList.clear();
        break;
      case 2 :    //update the cart
        Enumeration enum = request.getParameterNames();
        while ( enum.hasMoreElements() ) {
          String paramName = (String) enum.nextElement();
          if ( paramName.startsWith("item") ) {
            int giftID = Integer.parseInt(paramName.substring(4));
            int quantity = Integer.parseInt(request.getParameter(paramName));
            if ( quantity <= 0 ) quantity = 1;
            try {
              myCart.updateItem(giftID, quantity);
            }
            catch (Exception ex) {
              ex.printStackTrace();
            }
          }// if

        }// while enumer
        break;

    } // switch act

  }// if myCart!=null
%>
  <jsp:forward page="cart.jsp" />
<%
}
else { //new cart
  int quantity = 1;
  String tmp = null;
  tmp = request.getParameter("quantity");
  if ( tmp != null ) quantity = Integer.parseInt(tmp);
  System.out.println("quantity="+ quantity );
  int giftID = 1;
  tmp = request.getParameter("giftID");
  if ( tmp != null ) giftID = Integer.parseInt(tmp);
  System.out.println("giftID="+ giftID );
  String langCode = "EN";
  tmp = request.getParameter("langCode");
  if ( tmp != null ) langCode = tmp;

  if ( myCart == null ) myCart = new ShoppingCartBean();
  try {
    myCart.addItem(giftID, quantity, langCode);
    System.out.println("add finished");
  }
  catch (Exception e) {
    e.printStackTrace();
    /** @todo send error message */
  }
%>
  <jsp:forward page="cart.jsp" />
<%
}
%>

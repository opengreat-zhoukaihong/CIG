<%@ page import="java.sql.*,java.util.*,com.cig.chinaeoa.orderpro.*,java.io.*,sun.net.smtp.*" session="true" language="java" errorPage="error.jsp"%>
<%-- control the access to the page --%>
<%!
    String highLevel = "5";
    String userType,userLevel,eoaLoginID;
    // userType 1:EOA; 2:individual; 3:company; 4:dealer; 5:supplier; 6:supplier&dealer;
    // userLevel 0: normal user; 1: powerUser;    
%>
<%

    eoaLoginID = (String)session.getValue("cneoa.UserId");
    userLevel = (String)session.getValue("cneoa.UserLevel");
    userType = (String)session.getValue("cneoa.MemberType");

    if(eoaLoginID == null)    // can not get the loginID from session
    {
%>
      <jsp:forward page="loginIdError.jsp" />
<%
    }
    else
    {
      if(!(highLevel.equals(userLevel)))      // the user is not a power user
      {
%>
      <jsp:forward page="permError.jsp" />
<%
      }
      else
      {
        if(!("5".equals(userType)))
        {
%>
          <jsp:forward page="permError.jsp" />
<%
        }
      }
    }

%>


<html>
<!-- #BeginTemplate "/Templates/ceoa.dwt" --> 
<head>
<!-- #BeginEditable "doctitle" --> 
<title>ChinaEOA.com</title>
<!-- #EndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="eoa.css" rel="stylesheet" type="text/css">
<script
language="JavaScript">
<!--
img1on = new Image();
img1on.src = "/images/temp/menu_1_0.gif";
img2on = new Image();
img2on.src = "/images/temp/menu_2_0.gif";
img3on = new Image();
img3on.src = "/images/temp/menu_3_0.gif";
img4on = new Image();
img4on.src = "/images/temp/menu_4_0.gif";
img5on = new Image();
img5on.src = "/images/temp/menu_5_0.gif";
img6on = new Image();
img6on.src = "/images/temp/menu_6_0.gif";
img7on = new Image();
img7on.src = "/images/temp/menu_r07_c1_f2.gif";
img8on = new Image();
img8on.src = "/images/temp/menu_r08_c1_f2.gif";
img9on = new Image();
img9on.src = "/images/temp/menu_r09_c1_f2.gif";
img0on = new Image();
img0on.src = "/images/temp/menu_r10_c1_f2.gif";
img1off = new Image();
img1off .src = "/images/temp/menu_1.gif";
img2off = new Image();
img2off .src = "/images/temp/menu_2.gif";
img3off = new Image();
img3off .src = "/images/temp/menu_3.gif";
img4off = new Image();
img4off .src = "/images/temp/menu_4.gif";
img5off = new Image();
img5off .src = "/images/temp/menu_5.gif";
img6off = new Image();
img6off .src = "/images/temp/menu_6.gif";
img7off = new Image();
img7off .src = "/images/temp/menu_7.gif";
img8off = new Image();
img8off .src = "/images/temp/menu_r08_c1.gif";
img9off = new Image();
img9off .src = "/images/temp/menu_r09_c1.gif";
img0off = new Image();
img0off .src = "/images/temp/menu_r10_c1.gif";
function imgOn (imgName) {
if (document.images) {
document[imgName].src = eval (imgName + "on.src");
}
}
function imgOff (imgName) {
if (document.images) {
document[imgName].src = eval(imgName + "off.src");
}
}
function MM_preloadImages() { //v3.0
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

//-->
</script>
<script><!--

  function goBack()
  {
    document.orderProcess.submit();
  }

//-->
</script>

</head>

<body bgcolor="#F7FBFA" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" tracingsrc="file:///F%7C/ChinaEOA/ceoa.gif" tracingopacity="80" background="/images/temp/bg.gif">

<jsp:useBean id="orderProc" scope="page" class="com.cig.chinaeoa.orderpro.OrderProcessor" />
<jsp:useBean id="subOrderProc" scope="page" class="com.cig.chinaeoa.orderpro.SubOrderProc" />
<jsp:useBean id="checkMember" scope="page" class="com.cig.chinaeoa.member.MemberDetail" />
<jsp:useBean id="shipment" scope="page" class="com.cig.chinaeoa.member.ShipManager" />

<%!
  String status,orderID,action,searchOrderID,orderDateBgn,orderDateEnd,buyerName;
  String statusName,userID,sellerID;
  int pageNo,errorCode;
  Vector subOrders = new Vector();
  SubOrder mySubOrder;
  String poNumber,compName,orderDate;
  ResultSet shipInfo;
  String receiver = "";
  String address = "";
  String telephone = "";
  String fax = "";
  String receiverEmail = "";
  String city = "";
  String remark = "";
  String lang_code = "GB";
  String serviceEmail = "service@chinaeoa.com";
  String tempSqlStr;

  SmtpClient mailConfirm;
  PrintStream psMail;
  String buyerID;
  String userInfo[] = new String[3];  //userInfo[0]:userID;userInfo[1]:password;
                                      //userInfo[2]:contact Email;

%>
<%
  userID = (String)session.getValue("cneoa.UserId");
  sellerID = (String)session.getValue("cneoa.MemberId");

  orderID = request.getParameter("orderID");
  action = request.getParameter("action");
  status = request.getParameter("status");
  remark = request.getParameter("remark");
  if(remark == null)
    remark = "";

  compName = request.getParameter("compName");           // real buyer name
  orderDate = request.getParameter("orderDate");
  poNumber = request.getParameter("poNumber");
  buyerID = request.getParameter("buyerID");

  buyerName = request.getParameter("name");              // for vague search
  orderDateBgn = request.getParameter("orderDateBgn");
  orderDateEnd = request.getParameter("orderDateEnd");
  searchOrderID = request.getParameter("searchOrderID");

  if(buyerName == null)
    buyerName = "";
  if(orderDateBgn == null||orderDateBgn.equals(""))
    orderDateBgn = "2000-07-31";
  if(orderDateEnd == null||orderDateEnd.equals(""))
    orderDateEnd = "2099-07-31";
  if(searchOrderID == null)
    searchOrderID = "";

  checkMember.setMemberID(buyerID);
  userInfo = (String[])checkMember.getUserInfo();   // get contact email

  switch(Integer.parseInt(status))
  {
    case 0:
      statusName = "ΥԼ����";
      break;
    case 1:
      statusName = "�¶���";
      break;
    case 2:
      statusName = "���յ�����";
      break;
    case 3:
      statusName = "��ȷ�϶���";
      break;
    case 4:
      statusName = "���ַ�������";
      break;
    case 5:
      statusName = "����ɶ���";
      break;
    case 6:
      statusName = "����ɶ���";
      break;
    case 7:
      statusName = "��ȡ������";
      break;
    case 8:
      statusName = "���ڶ���";
      break;
    case 9:
      statusName = "���ܾ�����";
      break;
    default:
      statusName = "״̬����";
  }

  subOrderProc.setOrderID(orderID);
  subOrderProc.setPageNo(1);

  subOrders = subOrderProc.getSubOrders();

%>


<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#000000" >
  <tr>
    <td><img src="/images/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/title.js">
</script>
<table width="640" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" width="14"> <img src="/images/temp/left_bar.gif" width="14" height="2"></td>
    <td valign="top" colspan="2"><!-- #BeginEditable "body" -->
      <table width="600" border="0" cellspacing="0" cellpadding="0" height="300" align="center">
        <tr valign="top">
          <td>
            <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr>
                <td class="font4b" height="13">������&nbsp;</td>
                <td class="font4b" height="13">&nbsp;</td>
                <td class="font4b" height="13">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3">
<%

  try
  {
    //  action ���������
    //  1: �յ�����
    //  2: ȷ�϶���
    //  3: ���ַ���
    //  4: ȫ������
    //  5: ȡ������
    //  6: ���Ӷ���
    //  7: ΥԼ����
    if((action != null) && (!action.equals("")))
    {
      orderProc.setUserID(userID);
      orderProc.setOrderID(orderID);
      orderProc.setStatus(status);
      orderProc.setRemark(remark);
      orderProc.setSellerID(sellerID);
      orderProc.setBuyerID(buyerID);
      
      switch(Integer.parseInt(action))
      {
        case 1:
          orderProc.setTargetStatus("2");
          orderProc.updateStatus();
          errorCode = orderProc.getErrorCode();
          if(errorCode == 0)
          {
            mailConfirm = new SmtpClient("cig.com.cn");
            mailConfirm.from(serviceEmail);
            mailConfirm.to(userInfo[2]);        

            psMail = mailConfirm.startMessage();

            psMail.println("Subject: �յ�����֪ͨ.");
            psMail.println(compName + ":\n");
            psMail.println("�����Ѿ��յ������Ķ�������ȷ�����Ķ�����Ϣ��\n ");
            psMail.println("���Ķ����ţ�" + orderID +"\n");
            psMail.println("�ͻ��ڲ������ţ�" + poNumber + "\n");
            psMail.println("��������:" + orderDate + "\n");
            psMail.println("�ɹ��嵥����:\n");
            psMail.println("���  Ʒ��      ��Ʒ����          �ͺ�          ����    ���� \n");
            for(int i=0;i<subOrders.size();i++)
            {
              mySubOrder = (SubOrder)subOrders.elementAt(i);
              psMail.println(String.valueOf(i+1)+"     "+mySubOrder.getBrand()+"      "+mySubOrder.getCateName()+
                "           "+mySubOrder.getProductNo()+"    "+mySubOrder.getQuantity()+"    " +
                mySubOrder.getSalePrice() + "\n");
            }
            psMail.println("���ǻᾡ�찲�Ŵ������Ķ�������Ҳ����ͨ����¼�����˺�\n");
            psMail.println("���� MyEoa����ѯ���Ķ���״̬�� \n");
            psMail.println("    �����ϣ����ΪChinaeoa�ĺ�Լ�û�������Ϊ�������� \n");
            psMail.println("�ķ���͸��Żݵļ۸� ���ڴ������ΪVIP�û������ǻᾡ \n");
            psMail.println("�찲���������������ϵ��\n");
            psMail.println("��л��ѡ��Chinaeoa! \n");

            mailConfirm.closeServer();
          }
          break;
        case 2:
          orderProc.setTargetStatus("3");
          orderProc.updateStatus();
          errorCode = orderProc.getErrorCode();
          if(errorCode == 0)
          {
            mailConfirm = new SmtpClient("cig.com.cn");
            mailConfirm.from(serviceEmail);
            mailConfirm.to(userInfo[2]);

            psMail = mailConfirm.startMessage();

            psMail.println("Subject: ȷ�϶���֪ͨ.");
            psMail.println(compName + ":\n");
            psMail.println("���Ķ����������ţ�"+orderID+"���Ѿ�����\n ");
            psMail.println("����Ϊ������������Ϣ����ȷ�ϡ�");
            psMail.println("���Ķ����ţ�" + orderID +"\n");
            psMail.println("�ͻ��ڲ������ţ�" + poNumber + "\n");
            psMail.println("��������:" + orderDate + "\n");
            psMail.println("�ɹ��嵥����:\n");
            psMail.println("���  Ʒ��      ��Ʒ����          �ͺ�      ����    ����   �ջ���  �ջ���ַ          ��ϵ�绰    email\n");
            for(int i=0;i<subOrders.size();i++)
            {
              mySubOrder = (SubOrder)subOrders.elementAt(i);
              tempSqlStr = "select s.tel,s.fax,s.email,sl.contName_F,sl.address1,c.name city " +
                " from shipment s,shipment_l sl,city c " +
                " where s.shipID = '" + mySubOrder.getShipID() + "' and sl.lang_code='" +
                lang_code + "' and s.shipID = sl.shipID and c.lang_code = '" + lang_code +
                "' and s.cityID = c.cityID";

              shipment.setSqlStr(tempSqlStr);
              shipInfo = shipment.getDetail();
              if(shipInfo != null)
              {
                if(shipInfo.next())
                {
                  receiver = shipInfo.getString("contName_F");
                  address = shipInfo.getString("address1");
                  telephone = shipInfo.getString("tel");
                  fax = shipInfo.getString("fax");
                  if(fax==null)
                    fax = "";
                  receiverEmail = shipInfo.getString("email");
                  city = shipInfo.getString("city");
                  address = city + " " + address;
                }
                shipment.disconn();
              }
              psMail.println(String.valueOf(i+1)+"     "+mySubOrder.getBrand()+"      "+mySubOrder.getCateName()+
                "           "+mySubOrder.getProductNo()+"    "+mySubOrder.getQuantity()+"    " +
                mySubOrder.getSalePrice() + "    " +receiver + "  " + address + "       " + telephone + "  " + receiverEmail +"\n");
            }
            psMail.println("��ȷ�����϶�����Ϣ.\n");
            psMail.println("�������⣬��������������ϵ. \n");
            psMail.println("Chinaeoa.com \n");

            mailConfirm.closeServer();
          }
          break;
        case 3:
          orderProc.setTargetStatus("4");
          orderProc.updateStatus();
          errorCode = orderProc.getErrorCode();
          if(errorCode == 0)
          {
            mailConfirm = new SmtpClient("cig.com.cn");
            mailConfirm.from(serviceEmail);
            mailConfirm.to(userInfo[2]);

            psMail = mailConfirm.startMessage();

            psMail.println("Subject: ����֪ͨ.");
            psMail.println(compName + ":\n");
            psMail.println("���Ķ����������ţ�"+orderID+"�������»����Ѱ��ŷ�����\n ");
            psMail.println("���Ķ����ţ�" + orderID +"\n");
            psMail.println("���  Ʒ��      ��Ʒ����          �ͺ�          ����    ��������  ����ʱ�� \n");
            for(int i=0;i<subOrders.size();i++)
            {
              mySubOrder = (SubOrder)subOrders.elementAt(i);
              if((mySubOrder.getQuantitySend() != null) && (!mySubOrder.getQuantitySend().equals(""))) {
                psMail.println(String.valueOf(i+1)+"     "+mySubOrder.getBrand()+"      "+mySubOrder.getCateName()+
                  "           "+mySubOrder.getProductNo()+"    "+mySubOrder.getQuantity()+"    " +
                  mySubOrder.getQuantitySend() + "  " + mySubOrder.getShipDate() + "\n");
              }
            }
            psMail.println("��ӭ����chinaeoa��Com �������˺ŵ�¼����ʱ��ѯ���Ķ���\n");
            psMail.println("Chinaeoa.com \n");

            mailConfirm.closeServer();
          }
          break;
        case 4:
          orderProc.setTargetStatus("5");
          orderProc.updateStatus();
          errorCode = orderProc.getErrorCode();
          if(errorCode == 0)
          {
            mailConfirm = new SmtpClient("cig.com.cn");
            mailConfirm.from(serviceEmail);
            mailConfirm.to(userInfo[2]);

            psMail = mailConfirm.startMessage();

            psMail.println("Subject: ����֪ͨ.");
            psMail.println(compName + ":\n");
            psMail.println("���Ķ����������ţ�"+orderID+"�������»����Ѱ��ŷ�����\n ");
            psMail.println("���Ķ����ţ�" + orderID +"\n");
            psMail.println("���  Ʒ��      ��Ʒ����          �ͺ�          ����    ��������  ����ʱ�� \n");
            for(int i=0;i<subOrders.size();i++)
            {
              mySubOrder = (SubOrder)subOrders.elementAt(i);
              psMail.println(String.valueOf(i+1)+"     "+mySubOrder.getBrand()+"      "+mySubOrder.getCateName()+
                  "           "+mySubOrder.getProductNo()+"    "+mySubOrder.getQuantity()+"    " +
                  mySubOrder.getQuantitySend() + "  " + mySubOrder.getShipDate() + "\n");
            }
            psMail.println("��ӭ����chinaeoa��Com �������˺ŵ�¼����ʱ��ѯ���Ķ���\n");
            psMail.println("Chinaeoa.com \n");

            mailConfirm.closeServer();
          }
          break;
        case 5:
          orderProc.setTargetStatus("7");
          orderProc.updateStatus();
          errorCode = orderProc.getErrorCode();
          if(errorCode == 0)
          {
            mailConfirm = new SmtpClient("cig.com.cn");
            mailConfirm.from(serviceEmail);
            mailConfirm.to(userInfo[2]);

            psMail = mailConfirm.startMessage();

            psMail.println("Subject: ȡ������֪ͨ.");
            psMail.println(compName + ":\n");
            psMail.println("���Ķ����������ţ�"+orderID+"�����޷���������Ҫ�󹩻���\n ");
            psMail.println(" �ö����ѱ�ȡ����\n");
            psMail.println("��ӭ��������www��chinaeoa��comѡ��������Ʒ.\n");
            psMail.println("��л������chinaeoa! \n");
            psMail.println("�����κ����ʻ��飬����������ϵ. \n");

            mailConfirm.closeServer();
          }
          break;
        case 6:
          orderProc.setTargetStatus("8");
          orderProc.updateStatus();
          errorCode = orderProc.getErrorCode();
          if(errorCode == 0)
          {
            mailConfirm = new SmtpClient("cig.com.cn");
            mailConfirm.from(serviceEmail);
            mailConfirm.to(userInfo[2]);        

            psMail = mailConfirm.startMessage();

            psMail.println("Subject: ���Ӷ���֪ͨ.");
            psMail.println(compName + ":\n");
            psMail.println("���Ķ����������ţ�"+orderID+"������ʱ�޷���������Ҫ�󹩻���\n ");
            psMail.println("���������Ӷ�����\n");
            psMail.println("��ӭ��������www��chinaeoa��comѡ��������Ʒ.\n");
            psMail.println("��л������chinaeoa! \n");
            psMail.println("�����κ����ʻ��飬����������ϵ. \n");

            mailConfirm.closeServer();
          }
          break;
        case 7:
          orderProc.setTargetStatus("0");
          orderProc.updateStatus();
          errorCode = orderProc.getErrorCode();
          break;


      }
      if(errorCode == 0)
      {
%>
        <p align="center" >����ɹ�!</p>
        <p align="center" ><a href="javascript:goBack()" class="font3b">����</a></p>
<%
      }
      else
      {
        out.println("ʧ��!");
      }
    }
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
%>

                  <form name="orderProcess" action="searchOrdersRes_supp.jsp" method="post">

                    <input type="hidden" name="action" >
                    <input type="hidden" name="orderID" value="<%=orderID%>" >
                    <input type="hidden" name="status" value="<%=status%>" >

                    <input type="hidden" name="searchOrderID" value="<%=searchOrderID%>">
                    <input type="hidden" name="name" value="<%=buyerName%>">
                    <input type="hidden" name="orderDateBgn" value="<%=orderDateBgn%>">
                    <input type="hidden" name="orderDateEnd" value="<%=orderDateEnd%>">

                  </form>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- #EndEditable --> </td>
  </tr>
</table>
<script language="JavaScript" src="/javascript/foot.js">
</script>

</body>
<!-- #EndTemplate -->
</html>

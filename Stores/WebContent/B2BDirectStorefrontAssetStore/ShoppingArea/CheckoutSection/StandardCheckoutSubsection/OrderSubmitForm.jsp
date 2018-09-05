<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>
<%-- 
  *****
  * This page shows the order summary for the users order.  The following information is shown:
  *  - An order summary table showing items in the shopping cart and the estimated shipping date
  *  - Shipping and billing address
  *  - Payment information.  One can place an order after filling in the required payment information
  *  - Scheduled order section.  One can create a scheduled order by specifying the number of days and frequency
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<c:set property="contentType" target="${pageContext.response}">
       <fmt:message key="ENCODESTATEMENT" bundle="${storeText}" />
</c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN OrderSubmitForm.jsp -->
<head>
<title><fmt:message key="OrderSum_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">

<%-- use variable "hasOrderItemDiscount" to track whether the order contains order item level discounts --%>
<c:set var="hasOrderItemDiscount" value="false" />

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<table cellpadding="0" cellspacing="0" border="0" class="p_width" id="WC_OrderSubmitForm_Table_1">
<tr>
<td id="WC_OrderSubmitForm_TableCell_1">

<%-- bread crumb trail snippet --%>
<c:set var="bctCurrentPage" value="OrderSubmit" />
<c:set var="storeText" value="${storeText}" />
<%@ include file="../../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf" %>

<h1><fmt:message key="OrderSum_Title" bundle="${storeText}"/></h1>

<table cellpadding="8" cellspacing="0" border="0" width="605" id="WC_OrderSubmitForm_Table_2">
     <tr> 
       <td id="WC_OrderSubmitForm_TableCell_3"> 
<%/* OrderSchedule Code Begins */%>
<c:set var="bScheduledOrder" value="false"/>
<c:choose>
       <c:when test="${!empty WCParam.scheduled && WCParam.scheduled=='Y'}">
              <c:set var="bScheduledOrder" value="true"/>
       </c:when>
</c:choose>                
<%/* OrderSchedule Code Ends */%>    
<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean"/>
            
<%/* OrderSchedule Code Begins */%>
<c:choose>
       <c:when test="${bScheduledOrder}">       
              <flow:ifEnabled feature="trackOrderStatus">             
              <fmt:message key="OrderCon_Text4" bundle="${storeText}" var="OrderConfirmation"/>
              </flow:ifEnabled>
              <flow:ifDisabled feature="trackOrderStatus">
              <fmt:message key="OrderCon_Text5" bundle="${storeText}" var="OrderConfirmation"/>
              </flow:ifDisabled>
       </c:when>
</c:choose>
<%/* OrderSchedule Code Ends */%>
<%//if the error status message contains content, then we print out the error status message.%>
<c:choose>
       <c:when test="${!empty errorMessage}">
              <span class="error"><c:out value="${errorMessage}"/></span><br />
              <br />
              <p></p>
       </c:when>
</c:choose>
                        
<%/* OrderSchedule Code Begins */%>
<c:choose>
       <c:when test="${empty errorMessage}">
              <c:choose>
                     <c:when test="${!empty OrderConfirmation}">
                            <p><strong><c:out value="${OrderConfirmation}"/></strong><br />
                              </p>
                     </c:when>
              </c:choose>
       </c:when>
</c:choose>

<%/* OrderSchedule Code Ends */%>


</td></tr></table>



<% out.flush(); %>
<c:import url="../../../Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
	<c:param name="orderId" value="${WCParam.orderId}"/>
	<c:param name= "showCurrentCharges" value= "true"/>
	<c:param name= "showFutureCharges"  value= "true"/>
</c:import>
<% out.flush();%>
<br/><br/>

<flow:ifEnabled feature="ShippingChargeType">
	<% out.flush(); %>
	<c:import url="../../../Snippets/Order/Ship/ShippingChargeByShipmode.jsp" >
		<c:param name="orderId" value="${WCParam.orderId}"/>
	</c:import>
	<% out.flush();%>
	<br/><br/>
</flow:ifEnabled>
<flow:ifEnabled feature="ScheduleOrder">
	<c:set var="showScheduleOrder" value="true"/>
</flow:ifEnabled>
<flow:ifDisabled feature="ScheduleOrder">
	<c:set var="showScheduleOrder" value="false"/>
</flow:ifDisabled>

<% out.flush(); %>
<c:import url="../../../Snippets/EDP/PaymentMethods/PaymentMethodsDisplay.jsp">
	<c:param name="shippingURL" value="${WCParam.ShippingURL}"/>
	<c:param name="previousURL" value="MultipleShippingMethodView"/>
	<c:param name="doNotCollectPaymentForZeroAmount" value="true"/>
	<c:param name="showScheduleOrder" value="${showScheduleOrder}"/>
	<c:param name="showPONumber" value="true"/>
</c:import>
<% out.flush(); %>

</td>
</tr>
</table>

<%-- Hide CIP --%>
<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

<script language="javascript">
       var busy = false;
       
       function Handle_Submit_Order(form)
       {
              if (!busy){
                     busy = true;
                     form.submit();
              }       
              return false;
       }
 
 function date()
{

      var form = document.CardInfo1;
       
       var d = new Date();    //today's date
      var oneday = 86400000;   
//       alert(form.start1.value*oneday);      
      var millsec = d.getTime() + (form.start1.value*oneday);
      var today = new Date(millsec);
          
       var  yy = today.getYear();
       var yy1 = ''+yy;
       if(yy1.length < 4)
       {
         yy = yy+1900;
       }

       var mm = today.getMonth();
       mm++;
       var dd=  today.getDate();
       var hrs = today.getHours();
       var min  = today.getMinutes();
       var ss  = today.getSeconds();
       var format = '';
      var flag=0;

       if(mm<10)
       {
              var mma= '0'+mm;
              format = yy+":"+mma+":"+dd+":"+'00'+":"+'00'+":"+'00';
              flag =1;
       }
       
       if(dd<10)
       {
              var dda = '0'+dd;       
              format = yy+":"+mm+":"+dda+":"+'00'+":"+'00'+":"+'00';
              flag =1;
       }
       
       if( mm<10 && dd<10)
       {
       
              format = yy+":"+mma+":"+dda+":"+'00'+":"+'00'+":"+'00';
              flag =1;       
       }
       if(flag<1)
       {
              format = yy+":"+mm+":"+dd+":"+'00'+":"+'00'+":"+'00';
              flag=0;
       }                                   

//alert(format);
       return format;

}
 
 
 
 function verifyFormCC()
{
      var flag = true;
  if (flag)
    {              
              var dat = date();
              var startDate = dat;
              document.CardInfo1.pay_cardBrand.value = document.CardInfo.cardBrand.value;       
              document.CardInfo1.pay_cardNumber.value=  document.CardInfo.cardNumber.value;       
              document.CardInfo1.pay_cardExpiryMonth.value = document.CardInfo.cardExpiryMonth.options[document.CardInfo.cardExpiryMonth.selectedIndex].value;
              document.CardInfo1.pay_cardExpiryYear.value = document.CardInfo.cardExpiryYear.options[document.CardInfo.cardExpiryYear.selectedIndex].value;
              document.CardInfo1.start.value = startDate;
              document.CardInfo1.pay_PONumber.value =  document.CardInfo.PONumber.value;

                document.CardInfo1.submit();
    }
}

function verifyFormCL()
{
      var flag = true;
  if (flag)
    {               
        var dat = date();
       var startDate = dat;

       document.CardInfo1.pay_accountNumber.value = document.PIInfo.account.value;
       document.CardInfo1.start.value = startDate;
        //document.CardInfo1.pay_PONumber.value =  document.CardInfo.PONumber.value;
       document.CardInfo1.pay_PONumber.value = <c:out value="${WCParam.orderId}" />;
                       
               document.CardInfo1.submit();

                 
     }

}
</script>



</body>
<!-- END OrderSubmitForm.jsp -->
</html>


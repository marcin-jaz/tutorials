<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2003
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>
<%-- 
  ***
  * This JSP snippet displays ... 
  *
  * How to use this snippet?
  * 1. This snippet is available under the <WC-Install Dir>/samples/Snippets/web/Order/Ship/
  *
  * 2. You can use this snippet in your xxx.jsp in the following 3-ways
  * 	A. copy and paste the entire code in your xxx.jsp
  *		B. do import <c:import url="../../../Snippets/Order/Ship/ShipAsCompleForm.jsp" />
  *		   if this snippet is going to be included in full blown JSP 
  *		C. do import <c:import url="${snippetJSPStoreDir}Snippets/Order/Ship/ShipAsCompleteForm.jsp" />
  *		   if this snippet is going to be included in another JSP Snippet
  *		
  * The snippet displays text indicating that some items are not available (they are backordered) so that the
  * shopper can choose whether they want all the items to ship together --- meaning wait until they are all 
  * available before shipping them. Alternatively the shopper can elect to accept partial shipments.
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%@ include file="../OrderEnvironmentSetup.jspf"%>


<c:set var="orderId" value ="${param.orderId}" />
<%--
<c:out value = "${orderId}" />
--%>

<wcbase:useBean id="order_OrderDataBean" classname="com.ibm.commerce.order.beans.OrderDataBean" >
   <c:set target="${order_OrderDataBean}" property="orderId" value="${orderId}" />
</wcbase:useBean>



<form name="Order_ShipAsCompleteForm" method="POST" action="OrderCopy">
<input type=hidden name="URL" value=""/>
<input type="hidden" name="ShipAsComplete" value ="${order_OrderDataBean.shipAsComplete}"/>
<input type="hidden" name="orderId" value="<c:out value="${orderId}"/>" />
<input type=hidden name="storeId" value="<c:out value="${storeId[0]}" />" />
<input type=hidden name="langId" value="<c:out value="${langId[0]}" />" />
<input type=hidden name="catalogId" value="<c:out value="${catalogId[0]}" />" />
<input type=hidden name="toOrderId" value="<c:out value="${orderId}" />" />



<table width="100%" cellpadding="3" cellspacing="0" border="0" id="Order_ShipAsComplete_Table_1">
<tr>
	<td><fmt:message key="SOME_ITEMS_NOT_AVAIL" bundle="${orderText}" />  </td>
</tr>


<!--send/update ShipAsComplete = 'Y' -->
<tr>
	<td valign="top"><LABEL for="Order_ShipAsComplteOption_1"></LABEL><input name="Order_ShipAsComplteOption" id = "Order_ShipAsComplteOption_1"  type="radio" value="1" 
	    <c:if test="${order_OrderDataBean.shipAsComplete == 'Y'}"> checked="checked" </c:if> >
	    
	<fmt:message key="WAIT_UNTIL_READY" bundle="${orderText}"  /></td>
</tr>

<!--send/update ShipAsComplete = 'N' -->
<tr>
	<td valign="top"><LABEL for="Order_ShipAsComplteOption_2"></LABEL><input name="Order_ShipAsComplteOption" id="Order_ShipAsComplteOption_2" type="radio" value="2"
		<c:if test="${order_OrderDataBean.shipAsComplete != 'Y'}"> checked="checked" </c:if> >
	<fmt:message key="SHIP_AVAIL_ITEMS_NOW" bundle="${orderText}"  /></td>
</tr>

<tr>
	<td>
		&nbsp;&nbsp;&nbsp;
		<input type="button" name = "Order_UpdateFlag" value="update" onClick="javascript:Order_updateShipAsComplete(document.Order_ShipAsCompleteForm)" > 
	</td>
</tr>
</table>

</form>




<script language ="javascript">


function Order_updateShipAsComplete(formName)
{
	if (formName.Order_ShipAsComplteOption[0].checked) {			// Ship the Entire Order at once. set ShipAsComplete ='Y'	
		formName.ShipAsComplete.value = "Y" ;
		formName.URL.value = "OrderDisplay";
		}
	else{
		formName.ShipAsComplete.value = "N" ;
		formName.URL.value = "OrderDisplay";
		}
		
	formName.submit();

}
</script>




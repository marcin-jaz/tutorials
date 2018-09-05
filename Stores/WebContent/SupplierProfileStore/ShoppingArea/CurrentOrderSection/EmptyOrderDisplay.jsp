<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>


<%-- 
  *****
  * This page is shown when there is no items in the shopping cart.  The following information is shown:
  *  - A message indicating the shopping cart is empty
  *  - A Browse Catalog button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN EmptyOrderDisplay.jsp -->
<head>
<title><fmt:message bundle="${storeText}" key="YourOrder_Title" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<flow:ifEnabled feature="customerCare"> 
<script language="javascript">
			if (typeof parent.setShoppingCartItems == 'function')
				parent.setShoppingCartItems(0);
		
</script>
</flow:ifEnabled> 
<c:set var="multipleActiveOrders" value="false" />
<flow:ifEnabled feature="MultipleActiveOrders">
	<c:set var="multipleActiveOrders" value="true" />
</flow:ifEnabled>
</head>
<body class="noMargin">

<%@ include file="../../include/LayoutContainerTop.jspf"%>
 
<c:choose>
   <c:when test="${'_ERR_RETRIEVE_PRICE.1002' eq storeError.key}">
   	<fmt:bundle basename="${jspStoreDir}storeErrorMessages">
           <fmt:message key="${storeError.key}" var="pageErrorMessage">       
                <fmt:param value="${storeError.messageParameters[4]}"/>
           </fmt:message>
       </fmt:bundle>
   </c:when>
   <c:otherwise>
         <c:set var="pageErrorMessage" value="${errorMessage}"/>
   </c:otherwise>
</c:choose>
<c:if test="${!empty pageErrorMessage}">
     <p>
     	<span class="error"><c:out value="${pageErrorMessage}"/></span><br />
     </p>
</c:if>

<!--content start-->
        <table border="0" cellspacing="0" cellpadding="0" width="700" id="WC_EmptyOrderDisplay_Table_2">
            <tr>
              <td id="WC_EmptyOrderDisplay_TableCell_3" colspan="2">
								<c:choose>       
									<c:when test="${multipleActiveOrders}" >
										<%-- message to show if multipleActiveOrders enabled --%>
										<fmt:message bundle="${storeText}" key="YourOrder_Err_EmptyCOOrder" />
									</c:when>
									<c:otherwise>	
              			<%-- message to show if multipleActiveOrders disabled --%>
										<fmt:message key="YourOrder_Err_EmptyOrder" bundle="${storeText}" />
									</c:otherwise>
								</c:choose>
							</td>
             </tr>
             <tr>
								<td id="WC_EmptyOrderDisplay_TableCell_4" valign="top">
									<c:if test="${multipleActiveOrders}" >
										<%-- show List Active Orders button if multipleActiveOrders enabled --%>
										<c:url var="ListOrdersDisplayURL" value="ListOrdersDisplay">
											<c:param name="langId" value="${langId}" />
											<c:param name="storeId" value="${storeId}" />
											<c:param name="catalogId" value="${catalogId}" />									
										</c:url>				
										<a href="<c:out value="${ListOrdersDisplayURL}" />" class="button" id="WC_EmptyOrderDisplay_Link_1">
											<fmt:message key="ListOrders_Title" bundle="${storeText}" />
										</a>
									</c:if>
                  <%-- end - show List Active Orders button --%>
                  
                  <a href="<c:url value="TopCategoriesDisplay">
										<c:param name="langId"    value="${langId}"   />
										<c:param name="catalogId" value="${catalogId}"/>
										<c:param name="storeId"   value="${storeId}"  />
										</c:url>" class="button" id="WC_EmptyOrderDisplay_Link_2">
											<fmt:message bundle="${storeText}" key="Home_Button1" />
									</a>
								</td>
								<td id="WC_EmptyOrderDisplay_TableCell_5" align="right">
									<img src="<c:out value="${jspStoreImgDir}"/>/images/shopping_cart.jpg" alt="" border="0">
								</td>
							</tr>
						</table>
        <!--content end-->

<%@ include file="../../include/LayoutContainerBottom.jspf"%>

</body>
<!-- END EmptyOrderDisplay.jsp -->
</html>

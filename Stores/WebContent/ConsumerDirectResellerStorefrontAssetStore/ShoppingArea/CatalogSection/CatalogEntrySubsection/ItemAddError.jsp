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
  * This JSP page displays informational messages if an error occurs when adding an item to a shopping cart.
  *****
--%>

<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>
<wcbase:useBean id="storeData" classname="com.ibm.commerce.common.beans.StoreDataBean"/>
<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN ItemAddError.jsp -->
<head>
<title><fmt:message key="PRODUCT_TITLE" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body>
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<%-- 
	  ***
	  *	Start: Main Content
	  *     - Import JSP based on store configuration.
	  *
	  ***
	--%>
	
	<table cellpadding="8" id="WC_ItemAddError_Table_2">
	  <tbody>
	    <tr>
	      <td id="WC_ItemAddError_TableCell_2"> <br />
	      	<c:choose>
						<%-- special case for insufficient quantity - override error message from ErrorMessageSetup.jspf --%>
						<c:when test="${storeError.key == '_API_BAD_INV.1001'}">
							<wcbase:useBean id="catEntryDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
								<c:set property="catalogEntryID" value="${RequestProperties.catEntryId[0]}" target="${catEntryDB}" />
							</wcbase:useBean>
							<p>
								<span class="errortxt">
									<fmt:message key="${storeError.key}" bundle="${storeErrorMessageBundle}" var="badInventoryErrorMessage">
										<fmt:param value="${catEntryDB.partNumber}"/>
										<fmt:param value="${RequestProperties.quantity[0]}"/>
									</fmt:message>
									<c:out value="${badInventoryErrorMessage}"/>
								</span><br /><br />
							</p>
						</c:when>	      		
						<c:when test="${storeError.key == '_ERR_RETRIEVE_PRICE.1002'}">
							<p>
								<span class="errortxt">
									<fmt:message key="${storeError.key}" bundle="${storeErrorMessageBundle}" var="priceRetrieveErrorMessage">
										<fmt:param value="${bnError.exceptionData.partNumber}"/>
										<fmt:param value="${bnError.exceptionData.quantity}"/>
									</fmt:message>
									<c:out value="${priceRetrieveErrorMessage}"/>
								</span><br /><br />
							</p>
						</c:when>
						<c:when test="${!empty errorMessage}">
							<p>
								<span class="errortxt"><c:out value="${errorMessage}" escapeXml="false" /></span><br />
								<br />
							</p>
						</c:when>
					</c:choose>
					<a href="javascript:history.back(1)" class="button" id="WC_ItemAddError_Link_1">
					<fmt:message key="PMERROR_RETURN" bundle="${storeText}"/></a> </td>
	    </tr>
	  </tbody>
	</table>
	
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
<!-- END ItemAddError.jsp -->
</html>

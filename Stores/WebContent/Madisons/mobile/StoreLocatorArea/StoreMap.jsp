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
  * This JSP displays the store map page.
  *****
--%>

<!-- BEGIN StoreMap.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>


<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>

		<title>
			<fmt:message key="MSTMP_TITLE" bundle="${storeText}">
				<fmt:param value="${storeName}" />
			</fmt:message>
		</title>
		
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />

		<link rel="stylesheet" href="${cssPath}" type="text/css" />

	</head>
	
	<body>
		
		<div id="wrapper">
		
			<%@ include file="../include/HeaderDisplay.jspf" %>
			
                        <% out.flush(); %>
			<c:import url="${jspStoreDir}mobile/Snippets/StoreLocator/StoreInfo.jsp">
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="infoType" value="Map" />
				<c:param name="storeListIndex" value="${WCParam.storeListIndex}"/>
				<c:param name="geoNodeId" value="${WCParam.geoNodeId}"/>
				<c:param name="geoCodeLatitude" value="${WCParam.geoCodeLatitude}" />
				<c:param name="geoCodeLongitude" value="${WCParam.geoCodeLongitude}" />
				<c:param name="physicalStoreId" value="${WCParam.physicalStoreId}" />
				<c:param name="page" value="${WCParam.page}"/>
				<c:param name="recordSetReferenceId" value="${WCParam.recordSetReferenceId}"/>
				<c:param name="storeAvailPage" value="${WCParam.storeAvailPage}"/>
				<c:param name="prevPage" value="${WCParam.prevPage}" />
			</c:import>
                        <% out.flush(); %>

			<%@ include file="../include/FooterDisplay.jspf" %>						
			
		</div>
		
	</body>
	
</html>

<!-- END StoreMap.jsp -->

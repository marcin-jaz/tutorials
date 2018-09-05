<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This JSP displays the store's contact information. It shows the following:
  *  - Store name
  *  - Full address
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<wcbase:useBean id="address" classname="com.ibm.commerce.common.beans.StoreAddressDataBean" scope="page" >
	<c:set value="${sdb.storeEntityDescriptionDataBean.contactAddressId}" target="${address}" property="dataBeanKeyStoreAddressId"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="CONTACT_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body>
<!-- JSP File Name:  ContactDisplay.jsp -->

<%@ include file="../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
			
	<h1><fmt:message key="CONTACT_US3" bundle="${storeText}" /></h1>

	<table cellpadding="2" cellspacing="0" width="100%" border="0" id="WC_ContactDisplay_Table_2">
	<tbody><tr>
		<td valign="top" width="100%" class="topspace" id="WC_ContactDisplay_TableCell_6">

			<table cellpadding="3" cellspacing="0" border="0" id="WC_ContactDisplay_Table_3">
			<tbody><tr>
				<td valign="top" id="WC_ContactDisplay_TableCell_7">
					<span class="addressName"><c:out value="${storeName}" /></span><br />
					<%-- Print the appropriate address information out depending on locale --%>
					<span class="address">
						<%@ include file="../Snippets/ReusableObjects/AddressDisplay.jspf"%>
					</span>

					<br/>
					<c:if test="${!empty address.fax1}"><span class="strongtext"><fmt:message key="CON_FAX" bundle="${storeText}" /></span> <span class="address"><c:out value="${address.fax1}"/></span><br/></c:if>
					<c:if test="${!empty address.email1}"><span class="strongtext"><fmt:message key="CON_EMAIL" bundle="${storeText}" /></span> <span class="address"><c:out value="${address.email1}"/></span><br/></c:if>

					<%-- More contact information.  Editable using the Change pages tool --%>
					   <c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
						<c:param name="spotName" value="ContactUsSpot" />
	 				   </c:import>
				</td>
			</tr>
			</tbody></table>
			&nbsp;
		</td>
	</tr>
	</tbody></table>

<%@ include file="../include/LayoutContainerBottom.jspf"%>

</body>
</html>

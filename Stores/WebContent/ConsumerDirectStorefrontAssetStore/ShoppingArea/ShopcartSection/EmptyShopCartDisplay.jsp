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
  * The EmptyShopCartDisplay page is displayed when the user's shopcart contains no products. 
  *****
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<!-- Start - JSP File Name:  EmtpyShopCartDisplay.jsp -->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	<head>
		<title>
			<fmt:message key="SHOPPINGCART_TITLE" bundle="${storeText}"/>
		</title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
	</head>
	<body>
	<!-- JSP File Name:  EmtpyShopCartDisplay.jsp -->

	<%@ include file="../../include/LayoutContainerTop.jspf"%>
	
		<!--MAIN CONTENT STARTS HERE-->


						<table cellpadding="0" cellspacing="0" width="100%" border="0" id="WC_EmptyShopCartDisplay_Table_1">
							<tbody>
								<tr>
									<td width="10" rowspan="20" id="WC_EmptyShopCartDisplay_TableCell_1">
										&nbsp;
									</td>
								</tr>
								<%--
									***
									* Display the Empty Shopcart Message
									***
								--%>
								<tr>
									<td id="WC_EmptyShopCartDisplay_TableCell_2" valign="top">
										<fmt:message key="CART_EMPTY" bundle="${storeText}"/>
									</td>
									<td id="WC_EmptyShopCartDisplay_TableCell_3" align="right">
										<img src="<c:out value="${jspStoreImgDir}"/>/images/shopping_cart.jpg" alt="" border="0" />
									</td>									
								</tr>
								
							</tbody>
						</table>
		<!--MAIN CONTENT ENDS HERE-->
		
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../include/LayoutContainerBottom.jspf"%>

	</body>


<!-- End - JSP File Name:  EmtpyShopCartDisplay.jsp -->

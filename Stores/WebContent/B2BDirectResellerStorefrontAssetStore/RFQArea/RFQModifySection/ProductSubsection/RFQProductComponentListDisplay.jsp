<% 
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2000, 2004
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
  * This JSP page displays a list of components for a dynamic kit.
  *
  * Imports:  
  * - RFQProductComponentListDisplay_Row.jsp
  *
  * Required parameters:
  * - offering_id
  * - catalogId
  * - catentryid
  * - productId
  *
  *****
--%>
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="../RFQModifyConstants.jspf" %>

<c:set var="catalogId" value="${param.catalogId}" />
<c:set var="rfqId" value="${param[EC_OFFERING_ID]}" scope="request" />
<c:set var="catId" value="${param[EC_OFFERING_CATENTRYID]}" scope="request" />
<c:set var="rfqprodId" value="${param[EC_RFQ_PRODUCT_ID]}" scope="request" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

<title><fmt:message key="RFQProductComponentListDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<script language="javascript">	
	function isValidString(value)
	{
		if (value == '')
		{
			return false;
		}
		return true;
	}
</script>

</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>



	<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQProductComponentListDisplay_Table_1">
		<tr>
			<td valign="top" width="630" id="WC_RFQProductComponentListDisplay_TableCell_2">

				<table cellpadding="2" cellspacing="0" width="630" border="0"  id="WC_RFQProductComponentListDisplay_Table_2">
					<tr>
                        <td  valign="top" colspan="3" class="categoryspace" id="WC_RFQProductComponentListDisplay_TableCell_3">
				<h1><fmt:message key="RFQProductComponentListDisplay_RFQConfigRep" bundle="${storeText}" /></h1>

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>


<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />		
</c:if>

<c:if test="${strErrorMessage != null}">
	<span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br />
</c:if>

						</td>
					</tr>
					

					<tr>

						<td  valign="top" width="630" class="topspace" id="WC_RFQProductComponentListDisplay_TableCell_5">

						
						<table cellpadding="0" cellspacing="0" border="0" width="630" class="bgColor" id="WC_RFQProductComponentListDisplay_Table_3">
								<tr>
									<td id="WC_RFQProductComponentListDisplay_TableCell_6">
										<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQProductComponentListDisplay_Table_4">

											<tr>
												<th id="a1" valign="center"  class="colHeader"><fmt:message key="RFQProductComponentListDisplay_ProdName" bundle="${storeText}" /></th>
												<th id="a2" valign="center"  class="colHeader"><fmt:message key="RFQProductComponentListDisplay_Description" bundle="${storeText}" /></th>
												<th id="a3" valign="center"  class="colHeader"><fmt:message key="RFQProductComponentListDisplay_PartNumber" bundle="${storeText}" /></th>
												<th id="a4" valign="center"  class="colHeader"><fmt:message key="RFQProductComponentListDisplay_Quantity" bundle="${storeText}" /></th>
												<th id="a5" valign="center"  class="colHeader_price"><fmt:message key="RFQProductComponentListDisplay_UnitPrice" bundle="${storeText}" /></th>												
											</tr>

<wcbase:useBean id="prodComproductComponents" classname="com.ibm.commerce.rfq.beans.RFQProductComponentListBean" >
<jsp:setProperty property="*" name="prodComproductComponents"/>
<c:set target="${prodComproductComponents}" property="rfqProductId" value="${rfqprodId}" />
</wcbase:useBean>
<c:set var="productComponents" value="${prodComproductComponents.RFQProductComponents}" scope="request" />

<c:choose>
<c:when test="${!empty productComponents}">
	
	 <%--iterate  through list of ProductCommentsForProduct--%>
							<c:set var="color" value="cellBG_2" />
							<c:forEach var="aComponent" items="${productComponents}" begin="0" varStatus="iter">
								<c:set var="aComponent" value="${aComponent}" scope="request" />
								<c:choose>
									<c:when test="${color eq 'cellBG_1'}">
										<c:set var="color" value="cellBG_2" />
									</c:when>
									<c:when test="${color eq 'cellBG_2'}">
										<c:set var="color" value="cellBG_1" />
									</c:when>
								</c:choose> 
								<tr class="<c:out value="${color}" />">											
									<% out.flush(); %>
									<c:import url="RFQProductComponentListDisplay_Row.jsp">
										<c:param name="index" value="${iter.index}" />
									</c:import>
									<% out.flush(); %>
								</tr>	
							</c:forEach>
							
</c:when>
<c:otherwise>
	<tr>
			<td headers="a1" class="cellBG_1 t_td" id="WC_RFQProductComponentListDisplay_TableCell_7" colspan="5"><fmt:message key="RFQProductComponentListDisplay_NoCompsFound" bundle="${storeText}" /></td>
	</tr>
</c:otherwise>
</c:choose>	
<!-- end Configuration Report section -->
										</table>

									</td>
								</tr>
							</table> 

					

					</td>

					<td width="10" rowspan="2" id="WC_RFQProductComponentListDisplay_TableCell_24">&nbsp;</td>
			</tr>

			

			<tr>
				<td id="WC_RFQProductComponentListDisplay_TableCell_26">&nbsp;</td>
			</tr>

			<tr>
			<td id="WC_RFQProductComponentListDisplay_TableCell_27">

			<table id="WC_RFQProductComponentListDisplay_Table_5">
			<tbody>
			<tr>
						

<!-- Start display for button "RFQProductComponentListDisplay_Return" -->
<td height="41" id="WC_RFQProductComponentListDisplay_TableCell_30">
<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQProductComponentListDisplay_Link_5"> &nbsp; <fmt:message key="RFQProductComponentListDisplay_Return" bundle="${storeText}" /> &nbsp;
</a>
</td>
<!-- End display for button ... -->

			</tr>
			</table>

</td>
</tr> 

				</table>

<!--FINISH MAIN CONTENT-->
			</td>
		</tr>
	</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
	</body>
</html>


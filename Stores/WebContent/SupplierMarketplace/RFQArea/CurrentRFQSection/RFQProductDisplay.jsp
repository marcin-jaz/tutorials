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
  * This JSP page displays information about an RFQ product.
  *
  * Imports:
  * - RFQProductDisplay_Attributes_Row.jsp
  * - RFQProductDisplay_Comments_Row.jsp
  *
  * Required parameters:
  * - offering_id
  * - rfqprod_id
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="rfqId" value="${WCParam.offering_id}"  />
<c:set var="rfqprodId" value="${WCParam.rfqprod_id}" scope="request" />

<wcbase:useBean id="rfqProduct"
	classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
	<jsp:setProperty property="*" name="rfqProduct"/>
	<c:set target="${rfqProduct}" property="RFQProdId" value="${rfqprodId}" />
	
</wcbase:useBean>
<c:set var="plist" value="${rfqProduct.allAttributesWithValuesForProduct}" scope="request" />
<c:set var="pcomment" value="${rfqProduct.productCommentsForProduct}" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQProductDisplay_Title"
	bundle="${storeText}" /></title>
<link rel="stylesheet"
	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"
	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio" />

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<script language="JavaScript">
   function view(attachment_id, pattrvalue_id) {
       window.open("RFQAttachmentView?attachment_id=" + attachment_id + "&pAttrValueId=" + pattrvalue_id + "&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />");
  }
</script>

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="99%" id="WC_RFQProductDisplay_Table_1">
	<tbody>
		<tr>
			<td valign="top" width="100%" id="WC_RFQProductDisplay_TableCell_1">

			<table cellpadding="2" cellspacing="0" width="100%" border="0" id="WC_RFQProductDisplay_Table_2">
				<tbody>
					<tr>
						<td width="10" rowspan="7" id="WC_RFQProductDisplay_TableCell_2">&nbsp;</td>
					</tr>
					<tr>
						<td  valign="top" colspan="2" class="categoryspace" id="WC_RFQProductDisplay_TableCell_3">
						<h1><fmt:message key="RFQProductDisplay_Prod_Spec" bundle="${storeText}" /></h1>
						</td>
					</tr>

					<tr>
						<td  valign="top" width="100%" class="topspace" id="WC_RFQProductDisplay_TableCell_4">
						<h2><fmt:message key="RFQProductDisplay_Specification" bundle="${storeText}" /></h2>
						<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RFQProductDisplay_Table_3">
							<tbody>
								<tr>
									<td id="WC_RFQProductDisplay_TableCell_5">
									<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQProductDisplay_Table_4">
										<tbody>
											<tr>
												<th id="a1" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_8"><fmt:message key="RFQProductDisplay_Spec_Name" bundle="${storeText}" /></th>
												<th id="a2" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_9"><fmt:message key="RFQProductDisplay_Spec_Op" bundle="${storeText}" /></th>
												<th id="a3" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_10"><fmt:message key="RFQProductDisplay_Spec_Val" bundle="${storeText}" /></th>
												<th id="a4" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_11"><fmt:message key="RFQProductDisplay_Spec_Unit" bundle="${storeText}" /></th>		
												<th id="a5" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_12"><fmt:message key="RFQProductDisplay_Spec_Filesize" bundle="${storeText}" /></th>
												<th id="a6" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_13"><fmt:message key="RFQProductDisplay_Spec_Man" bundle="${storeText}" /></th>
												<th id="a7" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_14"><fmt:message key="RFQProductDisplay_Comm_Change" bundle="${storeText}" /></th>
												<th id="a8" valign="top" class="colHeader_last" id="WC_RFQProductDisplay_TableCell_15"><fmt:message key="RFQProductDisplay_Spec_UserDef" bundle="${storeText}" /></th>
											</tr>
																						
											<c:set var="color" value="cellBG_2" />
											<c:forEach items="${plist}" begin="0" varStatus="iter">
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
													<c:import url="RFQProductDisplay_Attributes_Row.jsp">
														<c:param name="index" value="${iter.index}" />
													</c:import>
													<% out.flush(); %>
												</tr>
											</c:forEach>
											
											<c:if test="${empty plist}">
												<tr class="cellBG_1">
													<td  valign="top" colspan="8" class="categoryspace t_td" id="WC_RFQProductDisplay_TableCell_17"  ><fmt:message
														key="RFQProductDisplay_No_Spec" bundle="${storeText}" /></td>
												</tr>
											</c:if>
										</tbody>
									</table>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
					<tr>
						<td  valign="top" width="100%" class="topspace" id="WC_RFQProductDisplay_TableCell_18">
						<h2><fmt:message key="RFQProductDisplay_Comment" bundle="${storeText}" /></h2>
						<table cellpadding="0" cellspacing="0" border="0" width="100%" 	class="bgColor" id="WC_RFQProductDisplay_Table_16">
							<tbody>
								<tr>
									<td id="WC_RFQProductDisplay_TableCell_19">
									<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQProductDisplay_Table_17">
										<tbody>
											<tr>
												<th id="b1" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_20"><fmt:message key="RFQProductDisplay_Comm_Type" bundle="${storeText}" /></th>
												<th id="b2" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_21"><fmt:message key="RFQProductDisplay_Comm_Val" bundle="${storeText}" /></th>
												<th id="b3" valign="top" class="colHeader" id="WC_RFQProductDisplay_TableCell_22"><fmt:message key="RFQProductDisplay_Comm_Man" bundle="${storeText}" /></th>
												<th id="b4" valigh="valigh" class="colHeader_last" id="WC_RFQProductDisplay_TableCell_23"><fmt:message key="RFQProductDisplay_Comm_Change" bundle="${storeText}" /></th>
											</tr>
											<%--iterate  through list of ProductCommentsForProduct--%>
											<c:set var="color" value="cellBG_2" />
											<c:forEach var="aComment" items="${pcomment}" begin="0"
												varStatus="iter">
												<c:set var="aComment" value="${aComment}" scope="request" />
												<c:choose>
													<c:when test="${color eq 'cellBG_1'}">
														<c:set var="color" value="cellBG_2" />
													</c:when>
													<c:when test="${color eq 'cellBG_2'}">
														<c:set var="color" value="cellBG_1" />
													</c:when>
												</c:choose>
												<tr class="<c:out value="${color}" />">
													<%--include file RFQProductDisplay_Comments_Row.jsp--%>
													<% out.flush(); %>
													<c:import url="RFQProductDisplay_Comments_Row.jsp">
														<c:param name="index" value="${iter.index}" />
													</c:import>
													<% out.flush(); %>
												</tr>
											</c:forEach>
											<%--end iterate  through list of ProductCommentsForProduct--%>
											<c:if test="${empty pcomment}">
												<tr class="cellBG_1">
													<td  valign="top" colspan="4" class="categoryspace t_td" id="WC_RFQProductDisplay_TableCell_26"><fmt:message key="RFQProductDisplay_No_Comm" bundle="${storeText}" /></td>
												</tr>
											</c:if>
										</tbody>
									</table>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>

					<tr>
						<td id="WC_RFQProductDisplay_TableCell_27">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQProductDisplay_Table_22">
							<tbody>
								<tr>

									<!-- Start display for Search button "RFQCategoryDisplay_Ok" -->
									<c:url var="RFQDisplayHref" value="RFQDisplay">
										<c:param name="offering_id" value="${rfqId}" />
										<c:param name="langId" value="${langId}" />
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
									</c:url>
									<td height="41"><a class="button" id="WC_RFQProductDisplay_TableCell_28" href="<c:out value="${RFQDisplayHref}" />"> &nbsp; 
										<fmt:message key="RFQCategoryDisplay_Ok" bundle="${storeText}" /> &nbsp;
									</a></td>
									<!-- End display for Search button -->

								</tr>
							</tbody>
						</table>
						</td>
					</tr>

					<tr>
						<td id="WC_RFQProductDisplay_TableCell_29">&nbsp;</td>
					</tr>
				</tbody>
			</table>
 

			<!--FINISH MAIN CONTENT--></td>
		</tr>
	</tbody>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>


											


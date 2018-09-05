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
  * This JSP page displays information about a product in the RFQ response.
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  *
  * Required parameters:
  * - offering_id
  * - catalogId
  * - response_id
  * - catentryId
  * - productId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQResponseConstants.jspf" %> 

<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:set var="resId" value="${WCParam[EC_RFQ_RESPONSE_ID]}" />
<c:set var="rfqId" value="${WCParam[EC_OFFERING_ID]}" />
<c:set var="catId" value="${WCParam[RFQ_EC_OFFERING_CATENTRYID]}" />
<c:set var="rfqprodId" value="${WCParam[EC_RFQ_PRODUCT_ID]}" />


<wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean" scope="request">
	<jsp:setProperty property="*" name="rfqBean"/>
	<c:set target="${rfqBean}" property="rfqId" value="${rfqId}" />	
</wcbase:useBean>
<% out.flush(); %>
<c:import url="../CommonSection/RFQSetup.jsp" />
<% out.flush(); %>
<wcbase:useBean id="rfqRes" classname="com.ibm.commerce.rfq.beans.RFQResponseDataBean" scope="request">
	<c:set target="${rfqRes}" property="initKey_rfqResponseId" value="${WCParam[EC_RFQ_RESPONSE_ID]}" />
	<c:set target="${rfqRes}" property="rfqId" value="${rfqId}" />
	<c:set target="${rfqRes}" property="commandContext" value="${CommandContext}" />

</wcbase:useBean>


						
<c:url var="RFQResponseDisplayHref" value="RFQResponseDisplay" >
	<c:param name="${EC_OFFERING_ID}" value="${rfqId}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${resId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>

<wcbase:useBean id="catalogDB"	classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
	<c:set target="${catalogDB}" property="dataBeanKeyCatalogEntryReferenceNumber"	value="${WCParam[RFQ_EC_OFFERING_CATENTRYID]}" />
	<c:set target="${catalogDB}" property="dataBeanKeyLanguage_id" value="${langId}" />	
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>
	<title><fmt:message key="RFQResponseProductDisplay_Title" bundle="${storeText}"/></title>
	<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"		type="text/css" />
	<meta name="GENERATOR" content="IBM WebSphere Studio"/>

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<script language="JavaScript">
		
function view(attachment_id, pattrvalue_id) 
{
	window.open("RFQAttachmentView?<c:out value="${EC_ATTACH_ID}" />=" + attachment_id + "&<c:out value="${EC_RFQ_REQUEST_ID}" />=<c:out value="${offeringId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />");
}

</script>


				<table cellpadding="2" cellspacing="0" width="580" border="0"  id="WC_RFQResponseProductDisplay_Table_2">
					<tbody><tr>
			 			<td width="10" rowspan="5" id="WC_RFQResponseProductDisplay_TableCell_3">&nbsp;</td>
					</tr>
					<tr>
						<td  valign="top" colspan="3" class="categoryspace" id="WC_RFQResponseProductDisplay_TableCell_4">
							<h1><fmt:message key="RFQResponseProductDisplay_Spec" bundle="${storeText}"/></h1>
							<fmt:message key="RFQResponseProductDisplay_Product" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${catalogDB.shortDescription}" /><p></p>
						</td>
					</tr>

					<tr>
						<td  valign="top" width="400" class="topspace" id="WC_RFQResponseProductDisplay_TableCell_5">
							<table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQResponseProductDisplay_Table_3">
								<tbody><tr class="cellBG_1">
									<td id="WC_RFQResponseProductDisplay_TableCell_6">
										<h2><fmt:message key="RFQResponseProductDisplay_Response_Specification" bundle="${storeText}"/></h2>
									</td>
								</tr>

								<tr>
									<td id="WC_RFQResponseProductDisplay_TableCell_7">
										<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQResponseProductDisplay_Table_4">
											<tbody><tr>
												<th id="a1" valign="top" class="colHeader" id="WC_RFQResponseProductDisplay_TableCell_8"><fmt:message key="RFQResponseProductDisplay_Specification_Name" bundle="${storeText}"/></th>
												<th id="a2" valign="top" class="colHeader" id="WC_RFQResponseProductDisplay_TableCell_9"><fmt:message key="RFQResponseProductDisplay_Operator" bundle="${storeText}"/></th>
												<th id="a3" valign="top" class="colHeader" id="WC_RFQResponseProductDisplay_TableCell_10"><fmt:message key="RFQResponseProductDisplay_Value" bundle="${storeText}"/></th>
												<th id="a4" valign="top" class="colHeader_last" id="WC_RFQResponseProductDisplay_TableCell_11"><fmt:message key="RFQResponseProductDisplay_Unit" bundle="${storeText}"/></th>
											</tr>
											<wcbase:useBean id="rfqRspProd" classname="com.ibm.commerce.rfq.beans.RFQResProductDataBean" scope="page">
												<c:set target="${rfqRspProd}" property="resProdId" value="${WCParam[EC_RFQ_PRODUCT_ID]}" />
													
											</wcbase:useBean>
											
											
											<c:set var="specs" value="${rfqRspProd.resAllAttributes}" />
											


											<c:set var="color" value="cellBG_2" />
											<c:set var="count" value="0" />
											
											<c:forEach var="prodAttribute" items="${specs}" begin="0" varStatus="iter">
												<c:if test="${prodAttribute.type != EC_ATTRTYPE_FREEFORM}">
													<c:set var="count" value="${count + 1}" />
													<c:choose>
														<c:when test="${color == 'cellBG_1'}">
															<c:set var="color" value="cellBG_2" />
														</c:when>
														<c:when test="${color == 'cellBG_2'}">
															<c:set var="color" value="cellBG_1" />
														</c:when>
													</c:choose>
													<tr>				
		                                                						<c:choose>
															<c:when test="${prodAttribute.type eq EC_ATTRTYPE_ATTACHMENT}">
			 													<wcbase:useBean id="attachment"	classname="com.ibm.commerce.contract.beans.AttachmentDataBean">
																	<c:set target="${attachment}" property="dataBeanKeyAttachmentId" value="${prodAttribute.res_value}" />
																	
																</wcbase:useBean>
																<td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_12_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.name}" /></td>
																<td headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_13_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.operator_des}" /></td>
																<td headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_14_<c:out value="${iter.count}" />"><a href="javascript:view(<c:out value="${attachment.attachmentId}" />,<c:out value="${prodAttribute.resPAttrValueId}" />);" id="WC_RFQResponseProductDisplay_Link_1_<c:out value="${iter.count}" />"><c:out value="${attachment.filename}" /></a></td>
																<td headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_15_<c:out value="${iter.count}" />"></td>
																<c:remove var="attachment" />
															</c:when>
															<c:when test="${prodAttribute.type eq EC_ATTRTYPE_DATETIME}">
																
																<fmt:parseDate type="both" dateStyle="short" timeStyle="short" var="pAttributeDateTime" value="${pattribute_value}"/>						
																<fmt:formatDate value="${pAttributeDateTime}" type="date" dateStyle="short" var="pattribute_date_value" />
															    <fmt:formatDate value="${pAttributeDateTime}" type="time" dateStyle="short" var="pattribute_time_value" />
															    
																<td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_16_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.name}" /></td>
																<td headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_17_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.operator_des}" /></td>
																<td headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_18_<c:out value="${iter.count}" />"><c:out value="${pattribute_date_value} ${pattribute_time_value}" /></td>
																<td headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_19_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.unitDesc}" /></td>
																
																<c:remove var="pattribute_date_value" />
																<c:remove var="pattribute_time_value" />
															</c:when>
															
															<c:otherwise>
																<td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_20_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.name}" /></td>
																<td headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_21_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.operator_des}" /></td>
																<td headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_22_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.res_value}" /></td>
																<td headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_23_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.unitDesc}" /></td>
															</c:otherwise>
														</c:choose>
														
		                                            </tr>
	                                            </c:if>
											</c:forEach>
											


											<c:if test="${count == 0}">
												<tr class="cellBG_1">
													<td  valign="top" colspan="7" class="categoryspace t_td" id="WC_RFQResponseProductDisplay_TableCell_24">
														<fmt:message key="RFQResponseProductDisplay_NoSpec" bundle="${storeText}"/>
													</td>
												</tr>
											</c:if>
										</tbody></table>
									</td>
								</tr>
							</tbody></table>
						</td>
					</tr>
					<tr>
						<td  valign="top" width="400" class="topspace" id="WC_RFQResponseProductDisplay_TableCell_25">
							<br />
							<table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQResponseProductDisplay_Table_9">
								<tbody><tr class="cellBG_1">
									<td id="WC_RFQResponseProductDisplay_TableCell_26">
										<h2><fmt:message key="RFQResponseProductDisplay_Res_Comment" bundle="${storeText}"/></h2>
									</td>
								</tr>
								<tr>
									<td id="WC_RFQResponseProductDisplay_TableCell_27">
										<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQResponseProductDisplay_Table_10">
											<tbody><tr>
												<th id="b1" valign="top" class="colHeader" id="WC_RFQResponseProductDisplay_TableCell_28"><fmt:message key="RFQResponseProductDisplay_Type" bundle="${storeText}"/></th>
												<th id="b2" valign="top" class="colHeader_last" id="WC_RFQResponseProductDisplay_TableCell_29"><fmt:message key="RFQResponseProductDisplay_Comments" bundle="${storeText}"/></th>
											</tr>
											<c:set var="count" value="0" />
											<c:forEach var="prodAttribute" items="${specs}" begin="0" varStatus="iter">
											
												<c:if test="${prodAttribute.type eq EC_ATTRTYPE_FREEFORM}" >											
																										
													<c:set var="count" value="${count + 1}" />
													<c:choose>
														<c:when test="${color == 'cellBG_1'}">
															<c:set var="color" value="cellBG_2" />
														</c:when>
														<c:when test="${color == 'cellBG_2'}">
															<c:set var="color" value="cellBG_1" />
														</c:when>
													</c:choose>
													<tr>
														<td headers="b1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_30_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.name}" /></td>
														<td headers="b2" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseProductDisplay_TableCell_31_<c:out value="${iter.count}" />"><c:out value="${prodAttribute.res_value}" /></td>
		                                            </tr>
	                                            </c:if>
	                                            
											</c:forEach>
											
											<c:if test="${count eq '0'}">
												<tr class="cellBG_1">
													<td  valign="top" colspan="4" class="categoryspace t_td" id="WC_RFQResponseProductDisplay_TableCell_32">
														<fmt:message key="RFQResponseProductDisplay_NoComm" bundle="${storeText}"/>
													</td>
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
					                   	
                        <td id="WC_RFQResponseProductDisplay_TableCell_33">
                        <table cellpadding="0" cellspacing="0" border="0" id="WC_RFQResponseProductDisplay_Table_13">
                            <tbody>
                                <tr> 

									<td height="41" id="WC_RFQResponseProductDisplay_TableCell_34"><a class="button" href="<c:out value="${RFQResponseDisplayHref}" />" id="WC_RFQResponseProductDisplay_Link_2"> &nbsp; <fmt:message key="RFQCategoryDisplay_Ok" bundle="${storeText}"/> &nbsp; 
									</a>
									</td>

                                    <td id="WC_RFQResponseProductDisplay_TableCell_35">&nbsp;</td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQResponseProductDisplay_TableCell_36">&nbsp;</td>
                    </tr>		
				
				</tbody>
				</table>		

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
	</body>
</html>

												






					

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
  * This JSP page displays products in an RFQ response that belong to
  * a specific RFQ category.
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - RFQResponse_Prod_PriceAdjust_and_Unit_Setup.jsp
  * - CatalogEntryType_And_OfferPrice_Setup.jsp
  *
  * Required parameters:
  * - offering_id
  * - catalogId
  * - response_id
  * - rfqCategoryId
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
<c:set var="rfqCategoryId" value="${WCParam.rfqCategoryId}" />

<wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean">
	<jsp:setProperty property="*" name="rfqBean"/>
	<c:set target="${rfqBean}" property="rfqId" value="${rfqId}" />	
</wcbase:useBean>
<% out.flush(); %>	
<c:import url="../CommonSection/RFQSetup.jsp" />
<% out.flush(); %>	
    <c:choose>
	<c:when test="${langId <= -7 and langId >= -10}">
		<c:set var="wrap" value="nowrap=\"nowrap\"" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise>
    </c:choose> 
    		
<wcbase:useBean id="rfqRes" classname="com.ibm.commerce.rfq.beans.RFQResponseDataBean" scope="request">
	<c:set target="${rfqRes}" property="initKey_rfqResponseId" value="${resId}" />
	<c:set target="${rfqRes}" property="rfqId" value="${rfqId}" />
	<c:set target="${rfqRes}" property="commandContext" value="${CommandContext}" />	
</wcbase:useBean>

<fmt:message var="rfqCategoryName" key="RFQExtra_NotCategorized" bundle="${storeText}"/>
<c:if test="${rfqCategoryId != null && !empty rfqCategoryId}" >
	<wcbase:useBean id="rfqCategoryAB" classname="com.ibm.commerce.rfq.beans.RFQCategryDataBean">
		<c:set target="${rfqCategoryAB}" property="initKey_rfqCategryId" value="${rfqCategoryId}" />		
	</wcbase:useBean>
	<c:set var="rfqCategoryName" value="${rfqCategoryAB.name}" />
</c:if>

<c:url var="RFQResponseDisplayHref" value="RFQResponseDisplay" >
	<c:param name="${EC_OFFERING_ID}" value="${rfqId}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${resId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>
<title><fmt:message key="RFQResponseCategoryDisplay_Title" bundle="${storeText}"/></title>

<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />

<meta name="GENERATOR" content="IBM WebSphere Studio" />

<script language="javascript">
	function submitDuplicate(form)
	{
		if (form.newRfqName.value=='') {
			error('<fmt:message key="RFQDisplay_Err_1" bundle="${storeText}"/>');
			return;
		}
		form.submit()
	}
	function error(errMsg)
	{
		alert(errMsg);
	}
</script>

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="99%" id="WC_RFQResponseCategoryDisplay_Table_1">
    <tbody>
        <tr>
            <td valign="top" width="100%" id="WC_RFQResponseCategoryDisplay_TableCell_1">
                          
            <table cellpadding="2" cellspacing="0" width="100%" border="0" id="WC_RFQResponseCategoryDisplay_Table_2">
                <tbody>
                    <tr>
                        <td rowspan="3" id="WC_RFQResponseCategoryDisplay_TableCell_2">&nbsp;</td>
                        <td  valign="top" colspan="3" class="categoryspace" id="WC_RFQResponseCategoryDisplay_TableCell_28">
	                    <h1><fmt:message key="RFQCategoryDisplay_Category" bundle="${storeText}"/></h1>
	                    <fmt:message key="RFQCreateDisplay_Name" bundle="${storeText}"/>:&nbsp;&nbsp;<c:out value="${rfqBean.name}" /><br></br>
	                    <fmt:message key="RFQResponseCategoryDisplay_Name" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqRes.name}" /><br></br>
	                    <fmt:message key="RFQCategoryDisplay_Category_Name" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqCategoryName}" /><br></br>
			</td>
                    </tr>
                    
                    <tr>
                        <td  valign="top" width="100%" class="topspace" id="WC_RFQResponseCategoryDisplay_TableCell_3">
                        <h2><fmt:message key="RFQCategoryDisplay_ProductInfo" bundle="${storeText}"/></h2>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RFQResponseCategoryDisplay_Table_3">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQResponseCategoryDisplay_TableCell_4">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQResponseCategoryDisplay_Table_4">
                                        <tbody>
                                            <tr>
                                                <th id="a1" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseCategoryDisplay_TableCell_5"><fmt:message key="RFQResponseCategoryDisplay_ReqName" bundle="${storeText}"/></th>
                                                <th id="a2" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseCategoryDisplay_TableCell_6"><fmt:message key="RFQResponseCategoryDisplay_ResName" bundle="${storeText}"/></th>
                                                <th id="a3" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseCategoryDisplay_TableCell_7"><fmt:message key="RFQResponseDisplay_ResponseProdType" bundle="${storeText}"/></th>
                                                <th id="a4" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQResponseCategoryDisplay_TableCell_8" ><fmt:message key="RFQResponseDisplay_ResponsePriceAdjust" bundle="${storeText}"/></th>
                                                <th id="a5" <c:out value="${wrap}" /> valign="top" class="colHeader_price" id="WC_RFQResponseCategoryDisplay_TableCell_9"><fmt:message key="RFQResponseDisplay_Product_Res_Price" bundle="${storeText}"/></th>
                                                <th id="a6" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseCategoryDisplay_TableCell_10"><fmt:message key="RFQResponseDisplay_Product_Res_Curr" bundle="${storeText}"/></th>
                                                <th id="a7" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseCategoryDisplay_TableCell_11"><fmt:message key="RFQResponseCategoryDisplay_ResQuantity" bundle="${storeText}"/></th>
                                                <th id="a8" <c:out value="${wrap}" /> valign="top" class="colHeader_last" id="WC_RFQResponseCategoryDisplay_TableCell_12"><fmt:message key="RFQResponseCategoryDisplay_ResUnit" bundle="${storeText}"/></th>
                                            </tr>
       											
	<c:set var="color" value="cellBG_2" />
	<c:set var="hasProducts" value="false" />
										
	<c:set var="resProdList" value="${rfqRes.allResProducts}" scope="request"/>
        <c:forEach var="rspProd" items="${resProdList}" varStatus="iter">
            	
            	<c:if test="${rspProd.product_id != null}">											
											
			<wcbase:useBean id="rfqRspProd" classname="com.ibm.commerce.rfq.beans.RFQResProductDataBean" scope="page">
				<c:set target="${rfqRspProd}" property="resProdId" value="${rspProd.product_id}" />	
			</wcbase:useBean>
			<% out.flush(); %>
 			<c:import url="RFQResponse_Prod_PriceAdjust_and_Unit_Setup.jsp">
				<c:param name="product_id" value="${rspProd.req_productId}" />
			</c:import>
			<% out.flush(); %>				
			<c:set var="catid" value="${rfqRspProd.catentryId}" />
							
			<wcbase:useBean id="catalogDB"	classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
				<c:set target="${catalogDB}" property="dataBeanKeyCatalogEntryReferenceNumber"	value="${rfqRspProd.catentryId}" />
				<c:set target="${catalogDB}" property="dataBeanKeyLanguage_id" value="${langId}" />
			</wcbase:useBean>	
			<% out.flush(); %>
			<c:import url="CatalogEntryType_And_OfferPrice_Setup.jsp">
				<c:param name="catentryId" value="${rfqRspProd.catentryId}" />
				<c:param name="setOfferPrice_Item" value="false" />
				<c:param name="setOfferPrice_Product" value="false" />
				<c:param name="setOfferPrice_Bundle" value="false" />
				<c:param name="setOfferPrice_Package" value="false" />
			</c:import>
			<% out.flush(); %>										
			<c:set var="req_type" value="${requestScope.type}"/>
			<c:set var="unit" value="${rfqRspProd.quantityUnitId}" />
													
			<c:choose>
				<c:when test="${unit != null}" >
					<wcbase:useBean id="qudb" classname="com.ibm.commerce.common.beans.QuantityUnitDescriptionDataBean">
						<c:set target="${qudb}" property="dataBeanKeyLanguage_id" value="${langId}" />
						<c:set target="${qudb}" property="dataBeanKeyQuantityUnitId" value="${unit}" />
						<c:set var="unit" value="${qudb.description}" />
					</wcbase:useBean>
				</c:when>
				<c:otherwise>
					<c:set var="unit" value="" />
				</c:otherwise>
			</c:choose>
							
			<c:choose>
				<c:when test="${color eq 'cellBG_1'}">
					<c:set var="color" value="cellBG_2" />
				</c:when>
				<c:when test="${color eq 'cellBG_2'}">
					<c:set var="color" value="cellBG_1" />
				</c:when>
			</c:choose>
		
			<c:if test="${rspProd.req_categoryId eq WCParam.rfqCategoryId}">
				<c:set var="hasProducts" value="true" />
					    <tr>
						<td <c:out value="${wrap}" /> headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseCategoryDisplay_TableCell_15"><c:out value="${rspProd.req_name}" /></td>
						<td <c:out value="${wrap}" /> headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseCategoryDisplay_TableCell_16"><a href="RFQResponseProductDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_RFQ_RESPONSE_ID}" />=<c:out value="${resId}" />&<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${rspProd.product_id}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&<c:out value="${RFQ_EC_OFFERING_CATENTRYID}" />=<c:out value="${rspProd.catentry_id}" />"><c:out value="${rspProd.req_name}" /></a></td>
						<td <c:out value="${wrap}" /> headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseCategoryDisplay_TableCell_17"><c:out value="${req_type}" /></td>
						<td <c:out value="${wrap}" /> headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseCategoryDisplay_TableCell_18"><fmt:formatNumber value="${rfqRspProd.priceAdjustmentInEJBType}"  /></td>
						<td <c:out value="${wrap}" /> headers="a5" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseCategoryDisplay_TableCell_19" class="price"><c:out	value="${rfqRspProd.formattedProductPrice}" escapeXml="false" />&nbsp;</td>
						<td <c:out value="${wrap}" /> headers="a6" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseCategoryDisplay_TableCell_20"><c:out value="${rfqRspProd.currency}" />&nbsp;</td>
						<td <c:out value="${wrap}" /> headers="a7" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseCategoryDisplay_TableCell_21"><c:out	value="${rfqRspProd.formattedQuantity}" />&nbsp;</td>
						<td <c:out value="${wrap}" /> headers="a8" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseCategoryDisplay_TableCell_22"><c:out value="${unit}" />&nbsp;</td>
					    </tr>
			</c:if> 
														
			<c:remove var="rfqRspProd" />
			<c:remove var="qudb" />
	    	</c:if> 
	</c:forEach>
									
	<c:if test="${empty resProdList or hasProducts eq false}">
					    <tr class="cellBG_1">
                                                <td  valign="top" colspan="8" class="categoryspace t_td" id="WC_RFQResponseCategoryDisplay_TableCell_23"><fmt:message key="RFQCategoryDisplay_NoProduct" bundle="${storeText}"/></td>
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
                        <td id="WC_RFQResponseCategoryDisplay_TableCell_24">
                        <table cellpadding="0" cellspacing="0" border="0" id="WC_RFQResponseCategoryDisplay_Table_13">
                            <tbody>
                                <tr>                                                                     
				    <td height="41" id="WC_RFQResponseCategoryDisplay_TableCell_25">
					<a class="button" href="<c:out value="${RFQResponseDisplayHref}" />"> &nbsp; <fmt:message key="RFQCategoryDisplay_Ok" bundle="${storeText}"/> &nbsp; </a> 
				    </td>			
                                     
                                    <td id="WC_RFQResponseCategoryDisplay_TableCell_26">&nbsp;</td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQResponseCategoryDisplay_TableCell_27">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
            
            </td>
        </tr>
    </tbody>
</table> 

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
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
  * This JSP page allows a user to select which response products should be 
  * accepted or rejected prior to converting the response to an order/contract.
  *
  * Imports:
  * - RFQResponseSetup.jsp
  * - RFQResponse_Prod_PriceAdjust_and_Unit_Setup.jsp
  *
  * Required parameters:
  * - offering_id
  * - catalogId
  * - response_id
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<%--
	init parameters:
--%>
<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:set var="resId" value="${WCParam.response_id}" />
<c:set var="rfqId" value="${WCParam.offering_id}" />

    <c:choose>
	<c:when test="${langId <= -7 and langId >= -10}">
		<c:set var="wrap" value="nowrap=\"nowrap\"" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise>
    </c:choose> 

<wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean">
	<jsp:setProperty property="*" name="rfqBean"/>
	<c:set target="${rfqBean}" property="rfqId" value="${rfqId}" />	
</wcbase:useBean>

<wcbase:useBean id="rfqRes" classname="com.ibm.commerce.rfq.beans.RFQResponseDataBean" scope="request">
	<c:set target="${rfqRes}" property="initKey_rfqResponseId" value="${resId}" />
	<c:set target="${rfqRes}" property="rfqId" value="${rfqId}" />
	<c:set target="${rfqRes}" property="commandContext" value="${CommandContext}" />
</wcbase:useBean>

<%--
	setup response state
--%>
<% out.flush(); %>
<c:import url="RFQResponseSetup.jsp" />
<% out.flush(); %>
<c:url var="RFQResponseListDisplayHref" value="RFQResponseListDisplay">
	<c:param name="offering_id" value="${rfqId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

<title><fmt:message key="RFQResponseAcceptSomeProductDisplay_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<script language="javascript">
	function CA(form) {
		if (form.checkAll.checked) {			
			if (form.numProd.value > 1) {
				for (var i = 0; i < form.numProd.value; i++) {
					form.responseProductId[i].checked = true;
				}
			} else {
				if (form.numProd.value == 1) {
					form.responseProductId.checked = true;
				}
			}
		} else {
			if (form.numProd.value > 1) {
				for (var i = 0; i < form.numProd.value; i++) {
					form.responseProductId[i].checked = false;
				}
			} else {
				if (form.numProd.value == 1) {
					form.responseProductId.checked = false;
				}
			}
		}
	}
	function submitAccept(form)	{
		form.action = 'RFQResponseProductAccept';
		if (form.numProd.value > 1) {
			for (var i = 0; i < form.numProd.value; i++) {
				if (form.responseProductId[i].checked) {
					form.submit();
					return;
				}
			}
		} else {
			if (form.numProd.value == 1 && form.responseProductId.checked) {
				form.submit();
				return;
			}
		}
		error("<fmt:message key="RFQModifyAddProductDisplay_Error1" bundle="${storeText}" />");
	}
	function submitReject(form) {
		form.action = 'RFQResponseProductReject';
		if (form.numProd.value > 1) {
			for (var i = 0; i < form.numProd.value; i++) {
				if (form.responseProductId[i].checked) {
					form.submit();
					return;
				}
			}
		} else {
			if (form.numProd.value == 1 && form.responseProductId.checked) {
				form.submit();
				return;
			}
		}
		error("<fmt:message key="RFQModifyAddProductDisplay_Error1" bundle="${storeText}" />");

	}
	function completeEvaluation(form) {
		form.action = 'RFQResponseProductReject';
		if (form.numProd.value > 1) {
			for (var i = 0; i < form.numProd.value; i++) {
				form.responseProductId[i].checked = true;
			}
		} else {
			if (form.numProd.value == 1) {
				form.responseProductId.checked = true;
			}
		}
		form.URL.value = "RFQResponseListDisplay";
		form.submit();
	}
	function error(errMsg) { 
		alert(errMsg);
	}

</script>

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQResponseAcceptSomeProductDisplay_Table_1">
    <tbody>
        <tr>
            <td valign="top" width="630" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_2">            
            <table cellpadding="2" cellspacing="0" width="580" border="0"  id="WC_RFQResponseAcceptSomeProductDisplay_Table_2">
                <tbody>
                    <tr> 
			<td width="10" rowspan="5" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_3">&nbsp;</td>
                        <td  valign="top" colspan="3" class="categoryspace" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_4">
                            <h1><fmt:message key="RFQResponseAcceptSomeProductDisplay_Response" bundle="${storeText}"/></h1>
                            <fmt:message key="RFQResponseAcceptSomeProductDisplay_Response" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqRes.name}" /><br />
                            <fmt:message key="RFQResponseAcceptSomeProductDisplay_Remark" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqRes.remarks}" /><br />
                            <br /><fmt:message key="RFQResponseAcceptSomeProductDisplay_Message1" bundle="${storeText}"/><br />
                        </td>
                    </tr>

                    <tr>
                        <td  valign="top" width="400" class="topspace" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_11">
			    <h2><fmt:message key="RFQResponseAcceptSomeProductDisplay_Products" bundle="${storeText}"/></h2>
			<form name="rfqProdForm" action="" method="get" id="rfqProdForm">
			    <input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_langId_In_rfqProdForm_1"/>
			    <input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_storeId_In_rfqProdForm_1"/>
			    <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_catalogId_In_rfqProdForm_1"/>
                                            
                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQResponseAcceptSomeProductDisplay_Table_6">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_12">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgcolor" id="WC_RFQResponseAcceptSomeProductDisplay_Table_7">
                                        <tbody>             
                                            <tr>
                                            	<th id="a1" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_13"><label for="WC_RFQResponseAcceptSomeProductDisplay_FormInput_checkAll_In_rfqProdForm_1"></label><input class="checkbox" type="checkbox" name="checkAll" onclick="javascript:CA(document.rfqProdForm);" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_checkAll_In_rfqProdForm_1"/></th>
                                                <th id="a2" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_14"><fmt:message key="RFQResponseAcceptSomeProductDisplay_Products_Name" bundle="${storeText}"/></th>
                                                <th id="a3" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_15"><fmt:message key="RFQResponseAcceptSomeProductDisplay_Products_Category" bundle="${storeText}"/></th>
                                                <th id="a4" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_16"><fmt:message key="RFQResponseDisplay_ResponseProdType" bundle="${storeText}"/></th>
                                                <th id="a5" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_16"><fmt:message key="RFQResponseDisplay_ResponsePriceAdjust" bundle="${storeText}"/></th>
                                                <th id="a6" <c:out value="${wrap}" /> class="colHeader_price" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_17"><fmt:message key="RFQResponseDisplay_Product_Res_Price" bundle="${storeText}"/></th>
                                                <th id="a7" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_18"><fmt:message key="RFQResponseAcceptSomeProductDisplay_Products_Currency" bundle="${storeText}"/></th>
                                                <th id="a8" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_19"><fmt:message key="RFQResponseAcceptSomeProductDisplay_Products_ResQuantity" bundle="${storeText}"/> </th>
                                                <th id="a9" <c:out value="${wrap}" /> valign="top" class="colHeader_last" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_20"><fmt:message key="RFQResponseAcceptSomeProductDisplay_Products_ResUnit" bundle="${storeText}"/> </th>
                                            </tr>

        <c:set var="resProdList" value="${rfqRes.allResProducts}" scope="request"/>
        <c:set var="color" value="cellBG_2" />
        <c:set var="numProd" value="0"/>
        <c:set var="count" value="0" />
        
        <c:forEach var="rspProd" items="${resProdList}" varStatus="iter">
		<c:set var="numProd" value="${iter.count}" />
												
                <c:if test="${rspProd.product_id != null}">
		
			<wcbase:useBean id="rfqProd" classname="com.ibm.commerce.utf.beans.RFQProdDataBean" scope="request">
                		<c:set target="${rfqProd}" property="RFQProdId" value="${rspProd.req_productId}" />
			</wcbase:useBean>
			<c:set var="negotiationType" value="${rfqProd.negotiationType}" />
			
			<c:set var="isValidRspProd" value="true" />
			<c:if test="${(negotiationType eq '1' or negotiationType eq '3') and (rspProd.quantity eq '0.0')}">	
				<c:set var="isValidRspProd" value="false" />
			</c:if>	
	
		    	<c:if test="${isValidRspProd eq 'true'}">	
		    																										
				<c:set var="type" value="${rspProd.productType}" />		
				<c:choose>
					<c:when test="${type eq 'ItemBean'}">
						<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type"/>
					</c:when>
					<c:when test="${type eq 'ProductBean'}">
						<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
					</c:when>
					<c:when test="${type eq 'PackageBean'}">
						<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
					</c:when>														
					<c:when test="${type eq 'DynamicKitBean'}">
						<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>
					</c:when>
					<c:otherwise>
						<c:set var="type" value="${type}" />
					</c:otherwise>
				</c:choose>
																										
				<c:catch var="e" > 													
				    <c:choose>
					<c:when test="${rspProd.priceAdjustment < 0}" >
						<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percentage"/>
						<fmt:formatNumber value="${rspProd.priceAdjustment}" var="percentagePriceAttr" />
						<c:set var="priceAdjust" value="${percentagePriceAttr} ${percentage}" />
					</c:when>
					<c:otherwise>
						<c:set var="priceAdjust" value="" />
					</c:otherwise>
				    </c:choose>
				</c:catch>			 	
				<c:if test="${e!=null}">
					<c:set var="priceAdjust" value="" />
				</c:if>	

				<c:set var="unit" value="${rspProd.unit}" />
				<c:choose>
					<c:when test="${unit != null and unit != ''}" >
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
																						
				<fmt:message var="rfqCategoryName" key="RFQExtra_NotCategorized" bundle="${storeText}"/>
				<c:if test="${rspProd.req_categoryName != null && rspProd.req_categoryName != ''}" >
					<c:set var="rfqCategoryName" value="${rspProd.req_categoryName}" />
				</c:if>
																														
				<c:set var="res_type" value="${requestScope.type}"/>
													
				<c:url var="RFQResponseProductDisplayHref" value="RFQResponseProductDisplay" >
					<c:param name="offering_id" value="${rfqId}" />
					<c:param name="response_id" value="${resId}" />
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="rfqprod_id" value="${rspProd.product_id}" />
					<c:param name="catentryid" value="${rspProd.catentry_id}" />
				</c:url>
				<% out.flush(); %>									
				<c:import url="RFQResponse_Prod_PriceAdjust_and_Unit_Setup.jsp">														
					<c:param name="product_id" value="${rspProd.product_id}" />
				</c:import>
				<% out.flush(); %>																			
	                                    <tr>		                                            	
	                    	<c:catch var="evalExc">
		               		<c:set var="evalResult" value="${rfqRspProd.evalResult}" />
		                                            	
			       	    <c:choose>
			          	<c:when test="${evalResult eq '1'}" >
				          	<td <c:out value="${wrap}" /> headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_21_<c:out value="${iter.count}" />"><fmt:message key="RFQResponseAcceptSomeProductDisplay_Accepted" bundle="${storeText}"/></td>
				        </c:when>
				        <c:otherwise>
				                <td <c:out value="${wrap}" /> headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_22_<c:out value="${iter.count}" />"><label for="WC_RFQResponseAcceptSomeProductDisplay_FormInput_responseProductId_In_rfqProdForm_1_<c:out value="${iter.count}" />">
				                <fmt:message key="RFQResponseAcceptSomeProductDisplay_Rejected" bundle="${storeText}"/></td>
				        </c:otherwise>
			            </c:choose>
		     	        </c:catch>
		             	    
		        	<c:if test="${evalExc != null}">
		        		<c:set var="count" value="${count+1}" />
		                                <td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_23_<c:out value="${iter.count}" />"><input class="checkbox" type="checkbox" name="responseProductId" value="<c:out value="${rspProd.product_id}" />" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_responseProductId_In_rfqProdForm_1_<c:out value="${iter.count}" />"/></label>
		                                </td>
		        	</c:if>
		                                            	
		        	<c:choose>
		             		<c:when test="${rspProd.price eq '0.0'}" >
		                 		<c:set var="rsp_price" value="" />
		                	</c:when>
		                	<c:otherwise>
		                		<c:set var="rsp_price" value="${rspProd.price}" />
		               	 	</c:otherwise>
		        	</c:choose>
		                                            	
				<c:choose>
		          		<c:when test="${rspProd.quantity eq '0.0'}" >
		                       		<c:set var="rsp_quantity" value="" />
		            		</c:when>
		         		<c:otherwise>
		                		<c:set var="rsp_quantity" value="${rspProd.quantity}" />
		               		</c:otherwise>
		     		</c:choose>
												 
			<td <c:out value="${wrap}" /> headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_24_<c:out value="${iter.count}" />"><a href="<c:out value="${RFQResponseProductDisplayHref}"/>" id="WC_RFQResponseAcceptSomeProductDisplay_Link_2_<c:out value="${iter.count}" />"><c:out value="${rspProd.name}" /></a></td>
                        <td <c:out value="${wrap}" /> headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_25_<c:out value="${iter.count}" />"><c:out value="${rfqCategoryName}" /></td>
			<td <c:out value="${wrap}" /> headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_26_<c:out value="${iter.count}" />"><c:out value="${type}" /></td>
			<td <c:out value="${wrap}" /> headers="a5" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_43_<c:out value="${iter.count}" />"><c:out value="${priceAdjust}" /></td>                                                
                        <td <c:out value="${wrap}" /> headers="a6" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_27_<c:out value="${iter.count}" />" class="price"><c:out value="${requestScope.rfqRspProd.formattedProductPrice}" escapeXml="false" /></td>
                        <td <c:out value="${wrap}" /> headers="a7" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_28_<c:out value="${iter.count}" />"><c:out value="${rspProd.currency}" /></td>
                        <td <c:out value="${wrap}" /> headers="a8" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_29_<c:out value="${iter.count}" />"><c:out value="${rsp_quantity}" /></td>
                        <td <c:out value="${wrap}" /> headers="a9" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_30_<c:out value="${iter.count}" />"><c:out value="${unit}" /></td>
					    </tr> 
			</c:if>	
		</c:if>	
			
		<c:remove var="rfqProd" />																						
		<c:remove var="rfqRspProd" />
		<c:remove var="qudb" />
		<c:remove var="unit" />


	</c:forEach>
	
	<c:if test="${empty resProdList}">
					    <tr class="cellBG_1">
	                                     	<td  valign="top" colspan="8" class="categoryspace t_td" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_31"><fmt:message key="RFQResponseDisplay_NoProduct" bundle="${storeText}"/></td>
	                                    </tr>
	</c:if>
                                        </tbody>
                                    </table>
                                    

                                    </td>
                                </tr>
                            </tbody>
                        </table>
 
                            <input type="hidden" name="numProd" value="<c:out value="${count}" />" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_numProd_In_rfqProdForm_1"/>                                           
                            <input type="hidden" name="offering_id" value="<c:out value="${rfqId}" />" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_offering_id_In_rfqProdForm_1"/>
                            <input type="hidden" name="response_id" value="<c:out value="${resId}" />" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_response_id_In_rfqProdForm_1"/>
                            <input type="hidden" name="URL" value="RFQResponseAcceptSomeProductDisplay" id="WC_RFQResponseAcceptSomeProductDisplay_FormInput_URL_In_rfqProdForm_1"/>                       
                        </form>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_32">
                        <table cellpadding="0" cellspacing="0" id="WC_RFQResponseAcceptSomeProductDisplay_Table_16">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_33">
				    <table id="WC_RFQResponseAcceptSomeProductDisplay_Table_17">
					<tbody>
					    <tr>									
	<c:if test="${count > 0}">										
						<td id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_34">
											
						<td height="41" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_35">
						    <a class="button" href="javascript:submitAccept(document.rfqProdForm);" id="WC_RFQResponseAcceptSomeProductDisplay_Link_3"> &nbsp; <fmt:message key="RFQResponseAcceptSomeProductDisplay_Accept" bundle="${storeText}"/> &nbsp; </a>
						</td>
										
						<td id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_36">&nbsp;</td>
										
						<td height="41" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_37">
						    <a class="button" href="javascript:submitReject(document.rfqProdForm);" id="WC_RFQResponseAcceptSomeProductDisplay_Link_4"> &nbsp; <fmt:message key="RFQResponseAcceptSomeProductDisplay_Reject" bundle="${storeText}"/> &nbsp; </a>
						</td>
										
						<td id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_38">&nbsp;</td>
										
						<td height="41" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_39">
						    <a class="button" href="javascript:completeEvaluation(document.rfqProdForm);" id="WC_RFQResponseAcceptSomeProductDisplay_Link_5"> &nbsp; <fmt:message key="RFQResponseAcceptSomeProductDisplay_CompleteEvaluation" bundle="${storeText}"/> &nbsp; </a>
						</td>
												
						<td id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_40">&nbsp;</td>
	</c:if>
						<td height="41" id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_41">
						    <a class="button" href="<c:out value="${RFQResponseListDisplayHref}" />" id="WC_RFQResponseAcceptSomeProductDisplay_Link_6"> &nbsp; <fmt:message key="RFQExtra_Return" bundle="${storeText}"/> &nbsp; </a>
						</td>
										
					    </tr>
					</tbody>
				    </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>

                    <tr>
                        <td id="WC_RFQResponseAcceptSomeProductDisplay_TableCell_42">&nbsp;</td>
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
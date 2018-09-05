<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP page displays summary information about the RFQ response.
  *
  * Elements:  
  * - attachment information
  * - terms and conditions
  * - adjustments on categories information
  * - RFQ categories
  * - product information
  * - OK button
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - RFQResponseSetup.jsp
  * - RFQResponseDisplay_Setup.jsp
  * - RFQResponseDisplay_ResponseProduct_Row.jsp
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



<c:set var="catalogId" value="${param.catalogId}" />
<c:set var="resId" value="${param.response_id}" />
<c:set var="rfqId" value="${param.offering_id}" />

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
<% out.flush(); %>
<c:import url="../CommonSection/RFQSetup.jsp" />
<% out.flush(); %>
<c:set var="isContract" value="${rfqBean.endResultInEJBType eq '0'}" scope="request" />
	
<wcbase:useBean id="rfqRes" classname="com.ibm.commerce.rfq.beans.RFQResponseDataBean" scope="request">
	<c:set target="${rfqRes}" property="initKey_rfqResponseId" value="${param.response_id}" />
	<c:set target="${rfqRes}" property="rfqId" value="${rfqId}" />
	<c:set target="${rfqRes}" property="commandContext" value="${CommandContext}" />
</wcbase:useBean>
  
<% out.flush(); %>
<c:import url="RFQResponseSetup.jsp" />
<% out.flush(); %>
<fmt:message var="rfqCategoryName" key="RFQExtra_NotCategorized" bundle="${storeText}" />
<c:if test="${rfqCategoryId != null && !empty rfqCategoryId}" >
	<wcbase:useBean id="rfqCategoryAB" classname="com.ibm.commerce.rfq.beans.RFQCategryDataBean">
		<c:set target="${rfqCategoryAB}" property="initKey_rfqCategryId" value="${rfqId}" />
		
	</wcbase:useBean>
	<c:set var="rfqCategoryName" value="${rfqCategoryAB.name}" />
</c:if>

<% out.flush(); %>
   <c:import url="RFQResponseDisplay_Setup.jsp">
  		<c:param name="rfqId" value="${rfqId}" />
  		<c:param name="resId" value="${resId}" />  		
    		<c:param name="langId" value="${langId}" />		
  		<c:param name="storeId" value="${storeId}" />
  		<c:param name="catalogId" value="${catalogId}" />  			
    </c:import>  
 <% out.flush(); %>                                               

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQResponseDisplay_Title" bundle="${storeText}"/></title>
<link rel="stylesheet"
	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"
	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>


<script language="JavaScript">
	function view(attachment_id) { 
		window.open("RFQAttachmentView?attachment_id=" + attachment_id + "&response_id=<c:out value="${resId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />");
	}
</script>

           
                       <table cellpadding="2" cellspacing="0" width="580" border="0"  id="WC_RFQResponseDisplay_Table_2">
                <tbody>
                    <tr>
						<td width="10" rowspan="7" id="WC_RFQResponseDisplay_TableCell_3">&nbsp;</td>
                        <td  valign="top" colspan="3" class="categoryspace" id="WC_RFQResponseDisplay_TableCell_4">
                        <h1><fmt:message key="RFQResponseDisplay_Summary" bundle="${storeText}"/></h1>
                        <h2><fmt:message key="RFQResponseDisplay_General" bundle="${storeText}"/></h2>
                        <fmt:message key="RFQResponseDisplay_Name" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqRes.name}" /><br />
                        <fmt:message key="RFQResponseDisplay_Remark" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqRes.remarks}" /><br />
                        <fmt:message key="RFQResponseDisplay_State" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${requestScope.responseState}" /><br />
                        <fmt:message key="RFQ_NAME" bundle="${storeText}"/>&nbsp;&nbsp;<a href="<c:out value="${RFQDisplayHref}" />" id="WC_RFQResponseDisplay_Link_1"><c:out value="${rfqBean.name}" /></a>
                        <br />
                        </td>
                    </tr>


                    <tr>
                        <td  valign="top" width="400" class="topspace" id="WC_RFQResponseDisplay_TableCell_5">
                        <h2><fmt:message key="RFQDisplay_Attachment_Attachment" bundle="${storeText}"/></h2>
                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQResponseDisplay_Table_3">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQResponseDisplay_TableCell_6">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQResponseDisplay_Table_4">
                                        <tbody>
                                            <tr >
						<th id="a1" valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_7"><fmt:message key="RFQDisplay_Attachment_Desc" bundle="${storeText}"/></th>
                                                <th id="a2" valign="top" class="colHeader_last" id="WC_RFQResponseDisplay_TableCell_8"><fmt:message key="RFQDisplay_Attachment_Attachment" bundle="${storeText}"/></th>
                                            </tr>
                                         
                                         
<wcbase:useBean id="attachmentList" classname="com.ibm.commerce.rfq.beans.RFQAttachmentListBean" >
<jsp:setProperty property="*" name="attachmentList" />
<c:set property="tradingId" value="${resId}" target="${attachmentList}" />
</wcbase:useBean>
	
<c:set var="attachments" value="${attachmentList.attachments}" />	
			
                                         

										<c:set var="color" value="cellBG_2" />
										<c:forEach var="attachment" items="${attachments}" begin="0" varStatus="iter">
											<c:choose>
												<c:when test="${color == 'cellBG_1'}">
													<c:set var="color" value="cellBG_2" />
												</c:when>
												<c:when test="${color == 'cellBG_2'}">
													<c:set var="color" value="cellBG_1" />
												</c:when>
											</c:choose>
											<tr>
                                                <td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_9_<c:out value="${iter.count}" />"><c:out value="${attachment.description}" /></td>
                                                <td headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_10_<c:out value="${iter.count}" />"><a href="javascript:view('<c:out value="${attachment.attachmentId}" />');" id="WC_RFQDisplay_Link_3_<c:out value="${iter.count}" />"><c:out value="${attachment.filename}" /></a></td>
                                            </tr>
										</c:forEach>							


										<c:if test="${empty attachments}">
										    <tr class="cellBG_1">
                                                <td  valign="top" colspan="2" class="categoryspace t_td" id="WC_RFQResponseDisplay_TableCell_11"><fmt:message key="RFQDisplay_NoAttachment" bundle="${storeText}"/></td>
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
                    
                    
 

				<c:set var="ppArray" value="${rfqRes.allPriceAdjustmentOnCategory}"/>
				<c:if test="${requestScope.isContract and ! empty ppArray}"  >
					
					 <tr>
						<td  valign="top" width="400" class="topspace" id="WC_RFQResponseDisplay_TableCell_11">
					    	<h2><fmt:message key="RFQModifyDisplay_RFQPercentagePricing" bundle="${storeText}"/></h2>
										
						<table id="WC_RFQResponseDisplay_Table_7" width="100%" class="bgColor" cellpadding="2" cellspacing="1" border="0" >
						   <tbody> 
							<tr>		
							    <th <c:out value="${wrap}" /> id="c1"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPName" bundle="${storeText}"/></th>
							    <th <c:out value="${wrap}" /> id="c2"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPDescription" bundle="${storeText}"/></th>
					            	    <th <c:out value="${wrap}" /> id="c3"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPPrice_Res" bundle="${storeText}"/></th>
					                    <th <c:out value="${wrap}" /> id="c4"  valign="center"  class="colHeader_last" > <fmt:message key="RFQModifyDisplay_PPCatalogUpdatesSync" bundle="${storeText}"/></th>                 
					                </tr>
					         
							<c:set var="color" value="cellBG_2" />
							<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percent" />
							
							<c:forEach var="rfqPP" items="${ppArray}" begin="0" varStatus="iter">
							
								<c:set var="index" value="${iter.index}" />
								<c:set var="categoryIDreferenceNumberAttr" value="${rfqPP.category_id}" />
								<c:set var="categoryDesc" value="${rfqPP.description}" />
								<c:set var="categoryName" value="${rfqPP.catName}" />
								
								<c:url var="CategoryDisplayHref" value="CategoryDisplay">
									<c:param name="categoryId" value="${categoryIDreferenceNumberAttr}" />
									<c:param name="parent_category_rn" value="${categoryName}" />
									<c:param name="langId" value="${langId}" />
									<c:param name="storeId" value="${storeId}" />
									<c:param name="catalogId" value="${catalogId}" />
								</c:url>
								
								
								<c:choose>
									<c:when test="${color == 'cellBG_1'}">
										<c:set var="color" value="cellBG_2" />
									</c:when>
									<c:when test="${color == 'cellBG_2'}">
										<c:set var="color" value="cellBG_1" />
									</c:when>
								</c:choose>	
								
								
								<c:if test="${categoryIDreferenceNumberAttr != null && categoryIDreferenceNumberAttr > 0 }" >								
								<tr>
									<td <c:out value="${wrap}" /> class="<c:out value="${color}" /> t_td" id="<c:out value="${iter.count}" />"><a href="<c:out value="${CategoryDisplayHref}"/>"><c:out value="${rfqPP.catName}"/></a>
				            		</td>
									<td <c:out value="${wrap}" /> class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_13_<c:out value="${iter.count}" />"><c:out value="${rfqPP.catName}" />
									</td>
									<td <c:out value="${wrap}" /> class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_14_<c:out value="${iter.count}" />" align="center">
									
									<fmt:formatNumber value="${rfqPP.percentagePrice}" var="percentagePriceAttr" />
									<c:set var="percentagePriceAttr" value="${percentagePriceAttr} ${percent}" />									
									<c:out value="${percentagePriceAttr}" />
									
										</td>
									<td <c:out value="${wrap}" /> class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_15_<c:out value="${iter.count}" />" align="center">	
										<c:choose>
											<c:when test="${rfqPP.synchronize eq 'false'}">
												<fmt:message key="RFQModifyDisplay_PPSynchronize_No" bundle="${storeText}"/>
											</c:when>
											<c:otherwise>
												<fmt:message key="RFQModifyDisplay_PPSynchronize_Yes" bundle="${storeText}"/>
											</c:otherwise>
										</c:choose>	  				     
									</td>							
								</tr> 		
								</c:if>
								<c:if test="${categoryIDreferenceNumberAttr == null && index == 0 }" >								
								 	<tr>  
						            	<td id="WC_RFQCompleteContractDisplay_TableCell_5" class="cellBG_1 t_td" colspan="5"><fmt:message key="RFQModifyDisplay_PPNoCatFound" bundle="${storeText}"/> 
						           		</td>			
									</tr> 
								</c:if>
									
						 		
								 
							</c:forEach>
						</tbody>		 			
					 	</table> 
						</td>
					</tr>  							
				</c:if>  
       

     
					<c:url var="RFQResponseCategoryDisplayHref" value="RFQResponseCategoryDisplay">
						<c:param name="offering_id" value="${rfqId}" />
						<c:param name="response_id" value="${resId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="storeId" value="${storeId}" />
						<c:param name="catalogId" value="${catalogId}" />
					</c:url>
                    <tr>
                        <td  valign="top" width="400" class="topspace" id="WC_RFQResponseDisplay_TableCell_17">
                        <h2><fmt:message key="RFQDisplay_Category" bundle="${storeText}"/></h2>
                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQResponseDisplay_Table_8">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQResponseDisplay_TableCell_18">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQResponseDisplay_Table_9">
                                        <tbody>
                                            <tr>
                                                <th id="b1" valign="top" class="colHeader_last" id="WC_RFQResponseDisplay_TableCell_19"><fmt:message key="RFQDisplay_CategoryTitle" bundle="${storeText}"/></th>
                                            </tr>

                                            <tr>
                                                <td headers="b1" class="cellBG_1 t_td" id="WC_RFQResponseDisplay_TableCell_20"><a href="<c:out value="${RFQResponseCategoryDisplayHref}" />" id="WC_RFQResponseDisplay_Link_3"><fmt:message key="RFQExtra_NotCategorized" bundle="${storeText}"/></a></td>
                                            </tr>
                                            <wcbase:useBean id="rfqCategoryList" classname="com.ibm.commerce.rfq.beans.RFQCategryListBean">
												<c:set target="${rfqCategoryList}" property="rfqId" value="${rfqId}" />
												
											</wcbase:useBean>
											<c:forEach var="rfqCat" items="${rfqCategoryList.rfqCategories}" begin="0" varStatus="iter">
												<c:choose>
													<c:when test="${color == 'cellBG_1'}">
														<c:set var="color" value="cellBG_2" />
													</c:when>
													<c:when test="${color == 'cellBG_2'}">
														<c:set var="color" value="cellBG_1" />
													</c:when>
												</c:choose>
												
												<c:url var="RFQResponseCategoryDisplayHref" value="${RFQResponseCategoryDisplayHref}">
													<c:param name="rfqCategoryId" value="${rfqCat.rfqCategryIdInEJBType}" />
												</c:url>									
												<tr>
	                                                <td headers="b1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_21_<c:out value="${iter.count}" />"><a href="<c:out value="${RFQResponseCategoryDisplayHref}" />" id="WC_RFQResponseDisplay_Link_4_<c:out value="{iter.count}"/>"><c:out value="${rfqCat.name}"/></a></td>
	                                            </tr>		 
											</c:forEach>
                                        </tbody>
                                    </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                   

                    <tr>
                        <td  valign="top" width="400" class="topspace" id="WC_RFQResponseDisplay_TableCell_22">
						<h2><fmt:message key="RFQResponseDisplay_Product_Info" bundle="${storeText}"/></h2>
                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQResponseDisplay_Table_11">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQResponseDisplay_TableCell_23">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQResponseDisplay_Table_12">
                                        <tbody>
                                            <tr>
						<th id="c1" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_24"><fmt:message key="RFQResponseDisplay_Product_Req_Prod" bundle="${storeText}"/></th>
                                                <th id="c2" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_25"><fmt:message key="RFQResponseDisplay_Product_Category" bundle="${storeText}"/></th>
                                                <th id="c3" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_25"><fmt:message key="RFQResponseDisplay_RequestProdType" bundle="${storeText}"/></th>
                                                <th id="c4" <c:out value="${wrap}" /> valign="top" class="colHeader_price" id="WC_RFQResponseDisplay_TableCell_25"><fmt:message key="RFQResponseDisplay_OfferPrice" bundle="${storeText}"/></th>
                                                <th id="c5" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_26"><fmt:message key="RFQResponseDisplay_Product_Res_Prod" bundle="${storeText}"/></th>
                                                <th id="c6" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_26"><fmt:message key="RFQResponseDisplay_ResponseProdType" bundle="${storeText}"/></th>
                                                <th id="c7" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQResponseDisplay_TableCell_27"><fmt:message key="RFQResponseDisplay_ResponsePriceAdjust" bundle="${storeText}"/></th>
                                                <th id="c8" <c:out value="${wrap}" /> valign="top" class="colHeader_price" id="WC_RFQResponseDisplay_TableCell_28"><fmt:message key="RFQResponseDisplay_Product_Res_Price" bundle="${storeText}"/></th>
                                                <th id="c9" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_29"><fmt:message key="RFQResponseDisplay_Product_Res_Curr" bundle="${storeText}"/></th>
                                                <th id="c10" <c:out value="${wrap}" /> valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_30"><fmt:message key="RFQResponseDisplay_Product_Res_Quantity" bundle="${storeText}"/></th>
                                                <th id="c11" <c:out value="${wrap}" /> valign="top" class="colHeader_last" id="WC_RFQResponseDisplay_TableCell_31"><fmt:message key="RFQResponseDisplay_Product_Res_Unit" bundle="${storeText}"/></th>
                                            </tr>

                                            <c:set var="hasProducts" value="false" />
                                            <c:set var="resProdList" value="${rfqRes.allResProducts}" scope="request"/>
                                            <c:forEach var="rspProd" items="${resProdList}" varStatus="iter">
                                            	<c:if test="${rspProd.product_id != null}">
                                            		<c:set var="hasProducts" value="true" />
                                            		
                                            		
                                            		
													
	                                            	<tr class="<c:out value="${color}" />">
								<% out.flush(); %>
		                                            	<c:import url="RFQResponseDisplay_ResponseProduct_Row.jsp">
		                                            		<c:param name="count" value="${iter.count}" />
															<c:param name="product_id" value="${rspProd.product_id}" />
															<c:param name="resProdName" value="${rspProd.name}" />
															<c:param name="req_name" value="${rspProd.req_name}" />
															<c:param name="req_categoryName" value="${rspProd.req_categoryName}" />
															<c:param name="req_catentryId" value="${rspProd.req_catentryId}" />
															<c:param name="res_catentry" value="${rspProd.catentry_id}" />
														</c:import>	
														<% out.flush(); %>
													</tr> 
												</c:if>		 
											</c:forEach>

											<c:if test="${empty resProdList or hasProducts == false}">
							                   	<tr class="cellBG_1">
                                                	<td  valign="top" colspan="11" class="categoryspace t_td" id="WC_RFQResponseDisplay_TableCell_39"><fmt:message key="RFQResponseDisplay_NoProduct" bundle="${storeText}"/></td>
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
                        <td  valign="top" width="400" class="topspace" id="WC_RFQResponseDisplay_TableCell_40">
						<h2><fmt:message key="RFQResponseDisplay_TC" bundle="${storeText}"/></h2>
                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQResponseDisplay_Table_21">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQResponseDisplay_TableCell_41">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQResponseDisplay_Table_22">
                                        <tbody>
                                            <tr>
                                                <th id="d1" valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_42"><fmt:message key="RFQResponseDisplay_TC_Mandatory" bundle="${storeText}"/></th>
                                                <th id="d2" valign="top" class="colHeader" id="WC_RFQResponseDisplay_TableCell_43"><fmt:message key="RFQResponseDisplay_TC_Changeable" bundle="${storeText}"/></th>
                                                <th id="d3" valign="top" class="colHeader_last" id="WC_RFQResponseDisplay_TableCell_44"><fmt:message key="RFQResponseDisplay_TC" bundle="${storeText}"/></th>
                                            </tr>
                  							<c:set var="comments" value="${rfqRes.RFQLevelCommentsPair}" />
											<c:forEach var="comment" items="${comments}" varStatus="iter">
                                            	
                                            		
	                                            	<tr>
		                                            	<td headers="d1" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_45_<c:out value="${iter.count}" />">
			                                            	<c:choose>
																<c:when test="${comment.mandatory eq '1'}">
																<fmt:message key="RFQResponseDisplay_Yes" bundle="${storeText}"/>
																</c:when>
																
																<c:otherwise>
																	<fmt:message key="RFQResponseDisplay_No" bundle="${storeText}"/>
																</c:otherwise>
															</c:choose>
														</td>
                                                		<td headers="d2" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_46_<c:out value="${iter.count}" />">
															<c:choose>
																<c:when test="${com_changeable eq '1'}">
																	<fmt:message key="RFQResponseDisplay_Yes" bundle="${storeText}"/>
																</c:when>
																<c:otherwise>
																	<fmt:message key="RFQResponseDisplay_No" bundle="${storeText}"/>
																</c:otherwise>
															</c:choose>
														</td>
														<td headers="d3" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseDisplay_TableCell_47_<c:out value="${iter.count}" />"><c:out value="${comment.res_value}" /></td>
													</tr> 
													 
											</c:forEach>
											<c:if test="${empty comments}">
							                   	<tr class="cellBG_1">
                                                	<td  valign="top" colspan="3" class="categoryspace t_td" id="WC_RFQResponseDisplay_TableCell_48"><fmt:message key="RFQResponseDisplay_NoTC" bundle="${storeText}"/></td>
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
                        <td id="WC_RFQResponseDisplay_TableCell_49">
                        <table cellpadding="0" cellspacing="0" border="0" id="WC_RFQResponseDisplay_Table_26">
                            <tbody>
                                <tr>


									<c:url var="RFQResponseListDisplayHref" value="RFQResponseListDisplay">
										<c:param name="offering_id" value="${rfqId}" />
										<c:param name="langId" value="${langId}" />
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
									</c:url>
									<td height="41" id="WC_RFQResponseDisplay_TableCell_50">
										<a class="button" href="<c:out value="${RFQResponseListDisplayHref}" />" id="WC_RFQResponseDisplay_Link_6"> &nbsp; <fmt:message key="RFQCategoryDisplay_Ok" bundle="${storeText}"/> &nbsp; 
										</a>
									</td>


                                    <td id="WC_RFQResponseDisplay_TableCell_51">&nbsp;</td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>

                    <tr>
                        <td id="WC_RFQResponseDisplay_TableCell_52">&nbsp;</td>
                    </tr>
                </tbody> 
            </table>
           

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

                    

                    
											
											


                    
										
                                         

 

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
  * This JSP page displays a drop-down selection box with categories
  * associated with this RFQ on the RFQModifyDisplay JSP page.
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - RFQModifyDisplay_Setup.jsp
  *
  * Required parameters:
  * - offering_id
  * - catalogId
  * - storeId
  * - langId
  *
  *****
--%>
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>



<%@ include file="RFQModifyConstants.jspf" %>
<% out.flush(); %>
<c:import url="../CommonSection/RFQSetup.jsp" /> 
<% out.flush(); %>
<% out.flush(); %>
<c:import url="RFQModifyDisplay_Setup.jsp" />
<% out.flush(); %>
 
<!--Display RFQCategory--->

                    <tr class="cellBG_1">
                        <td  valign="top" width="630" class="topspace" id="WC_RFQModifyDisplay_TableCell_81"><br />
 							<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQModifyDisplay_Table_23">
								<tbody>
								<tr>
				    				<td class="header" background="<c:out value="${jspStoreImgDir}" />images/header_back.gif" id="WC_RFQModifyDisplay_TableCell_82"><fmt:message key="RFQModifyDisplay_RFQProduct" bundle="${storeText}"/></td>
								</tr>
								<tr>
				    				<td id="WC_RFQModifyDisplay_TableCell_83"><img src="<c:out value="${jspStoreImgDir}" />images/strip.gif" alt="" width="630" height="2" border="0"/></td>
								</tr>
								</tbody>
							</table>

						<br /><fmt:message key="RFQExtra_Prod" bundle="${storeText}"/>		
 
							<form name="RFQModifyDisplayGoForm" action="RFQModifyDisplay" method="post" id="RFQModifyDisplayGoForm">
                        	<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQModifyDisplayGoForm_1"/>
							<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQModifyDisplay_FormInput_langId_In_RFQModifyDisplayGoForm_1"/>
							<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQModifyDisplay_FormInput_storeId_In_RFQModifyDisplayGoForm_1"/>
							<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_FormInput_catalogId_In_RFQModifyDisplayGoForm_1"/>

						<table id="WC_RFQModifyDisplay_Table_24">
							<tbody>
							<tr>
                            	<td id="WC_RFQModifyDisplay_TableCell_84"><label for="WC_RFQModifyDisplay_RFQCategory_Select_1"><fmt:message key="RFQModifyDisplay_Category" bundle="${storeText}"/>: </label></td>
								<td id="WC_RFQModifyDisplay_TableCell_85"><select id="WC_RFQModifyDisplay_RFQCategory_Select_1" class="select" name="rfqCategoryId">															
								<option value=""
								<c:if test="${rfqCategoryId == ''}" >  
								 selected
								</c:if> 
								><fmt:message key="RFQExtra_All" bundle="${storeText}"/></option>
								
								<c:forEach var="category" items="${requestScope.categoryList}" begin="0" varStatus="iter">
									<c:set var="rfqCategoryId1" value="${category.rfqCategryIdInEJBType}" />
																				 						
									<option value="<c:out value="${rfqCategoryId1}" />"  									
																			
										<c:if test="${rfqCategoryId != 'null' and rfqCategoryId eq rfqCategoryId1 }" >
											selected
										</c:if>						
																	
									> <c:out value="${category.name}" /></option>					 	
								 	
								</c:forEach>
	                            <option value="null" 
	                            	<c:if test="${rfqCategoryId eq 'null'}" >
								 	selected
									</c:if>
	                            > <fmt:message key="RFQExtra_NotCategorized" bundle="${storeText}"/></option>                            
	                            
                            	</select>
							
							</td>

<!-- Start display for Search "Go" button -->
<td height="41" id="WC_RFQModifyDisplay_TableCell_86">
<a class="button" href="javascript:document.RFQModifyDisplayGoForm.submit()" id="WC_RFQModifyDisplay_Link_10"><fmt:message key="RFQModifyDisplay_Go" bundle="${storeText}"/>
</a>
</td>
<!-- End display for Search "Go" button -->

							</tr>
	
							</tbody>
						</table>

						</form>
						
						
								
								
								


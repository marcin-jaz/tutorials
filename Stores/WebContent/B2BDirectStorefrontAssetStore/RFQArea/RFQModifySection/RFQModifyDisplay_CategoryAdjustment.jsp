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
  * This JSP page displays the Category percentage price adjustment
  * section on the RFQModifyDisplay JSP page.
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - RFQModifyDisplay_Setup.jsp
  * - RFQModifyDisplay_CategoryAdjustment_Row.jsp
  *
  * Required parameters:
  * - RFQPriceAdjustmentOnCategory [] ppArray
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

<c:set var="wrap" value="${requestScope.wrap}" scope="request" />

    <!-- Start RFQ Category Percentage Adjustment section -->
	<%--
		Show only if RFQ is intended for contract
	--%>
  
	 <c:choose>
				<c:when test="${isContract}">
									
							
					<tr height="60" valign="bottom">					    
					    <td width="400" class="topspace" id="WC_RFQModifyDisplay_CA_TableCell_1">
					    
					    <table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_RFQModifyDisplay_CA_Table_1">					   
					    <tr width="600">
					    	<td width="600" class="header"  background="<c:out value="${jspStoreImgDir}" />images/header_back.gif" id="WC_RFQModifyDisplay_TableCell_82"><fmt:message key="RFQModifyDisplay_RFQPercentagePricing" bundle="${storeText}"/></td>
						</tr>
						<tr>
				    		<td id="WC_RFQModifyDisplay_TableCell_84"><img src="<c:out value="${jspStoreImgDir}" />images/strip.gif" alt="" width="630" height="2" border="0"/></td>
						</tr>					    
					    
					    </table>
					    
					    </td>
					</tr>
					
					
					<tr>					
						<td id="WC_RFQModifyDisplay_TableCell_66" width="400">
						<br /><fmt:message key="RFQExtra_PercentagePricing" bundle="${storeText}"/>
						<br /><br />
						</td>	
						
					</tr>
					
					
					<tr>	    
					    <td id="WC_RFQModifyDisplay_TableCell_65" width="400">
					    
					<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">
						
					</wcbase:useBean>	 
							
							<form name="RFQModifyPercentagePricingForm" action="RFQPriceAdjustmentOnCategoryUpdate" method="post" id="WC_RFQModifyDisplay_Table_67">
							
							<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" />
   							<input type="hidden" name="langId" value="<c:out value="${langId}" />" />
							<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" />
    							<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" />	
							<input type="hidden" name="URL" value="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" />
							<input type="hidden" name="deleteTC" value="0" />
					
					
							<table id="WC_RFQDisplay_Table_12" width="100%" class="bgColor" cellpadding="2" cellspacing="1" border="0" >
							   <tbody> 
								<tr>		
								<th <c:out value="${wrap}" /> id="c1"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPName" bundle="${storeText}"/></th>
						            	<th <c:out value="${wrap}" /> id="c2"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPDescription" bundle="${storeText}"/></th>
							    	<th <c:out value="${wrap}" /> id="c3"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPPrice" bundle="${storeText}"/></th>
						             	<th <c:out value="${wrap}" /> id="c4"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPCatalogUpdatesSync" bundle="${storeText}"/></th>                 
						            	<th <c:out value="${wrap}" /> id="c5"  valign="center"  class="colHeader_last" > &nbsp;</th>
						        	</tr> 
<!--iterate through RFQPriceAdjustmentOnCategory-->
								<c:set var="color" value="cellBG_2" />		
								
														
								<c:forEach var="rfqPP" items="${requestScope.ppArray}" begin="0" varStatus="iter">
									
								<%--
									rfqProdPrice stored in request to call RFQDisplay_PriceAdjustment_Row.jsp
									to display price
								--%>
								<c:set var="rfqPP" value="${rfqPP}" scope="request" />
									<c:choose>
										<c:when test="${color == 'cellBG_1'}">
									 		<c:set var="color" value="cellBG_2" />
										</c:when>
										<c:when test="${color == 'cellBG_2'}">
											<c:set var="color" value="cellBG_1" />
										</c:when>
									</c:choose>									
									<tr class="<c:out value="${color}" />">
									<% out.flush(); %>
									<c:import url="RFQModifyDisplay_CategoryAdjustment_Row.jsp">
										<c:param name="index" value="${iter.index}" />
										
									</c:import>	
									<% out.flush(); %>				
									</tr> 
								</c:forEach>							
<!-- end iterate through RFQPriceAdjustmentOnCategory -->

				   				<%---
							    	if the price adjustment array is null or zero then
									display a "No categories found" message for the table	
								--%> 
								<c:if test="${empty ppArray}">
								    <tr> 
							            <td id="WC_RFQDisplay_TableCell_22" class="cellBG_1 t_td" colspan="5"><fmt:message key="RFQModifyDisplay_PPNoCatFound" bundle="${storeText}"/> 
							            	<input type="hidden" name="tc_id_1" value="null" />
							            </td>			
									</tr> 
								</c:if>         
    
							</tbody>		 			
						 	</table> 
						 		
						 		<c:choose>
						 		<c:when test="${!empty ppArray}">
						 			<input type="hidden" name="numPPTC"  value="<c:out value="${requestScope.numPPTC}" />" />	
						 		</c:when>
						 		<c:otherwise>
						 		 	<input type="hidden" name="numPPTC" value="0"  />	
						 		
						 		</c:otherwise>
						 		</c:choose>
						 		
						 	
							<table id="WC_RFQModifyDisplay_Table_22" cellpadding="0" cellspacing="0" border="0">
							<tbody>			 	
								<tr>
									<!-- Display "Add" button -->
									<td id="WC_RFQModifyDisplay_TableCell_79" height="41">
										<a class="button" href="TopCategoriesDisplay?offering_id=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" > &nbsp; <fmt:message key="RFQModifyDisplay_PPAdd" bundle="${storeText}"/> &nbsp; 
										</a> 
									</td>		
									<!-- Display "Save Changes" button -->
									<td id="WC_RFQModifyDisplay_TableCell_80" height="41">
										&nbsp;<a class="button" href="javascript:submitUpdatePercentagePricing(document.RFQModifyPercentagePricingForm)" > &nbsp; <fmt:message key="RFQ_SAVE_CHANGES" bundle="${storeText}"/> &nbsp; 
										</a> 
									</td>					
    							</tr>
    						</tbody>
							</table>			
			
				</form>	  		 
	<br />   	 
						</td>
					</tr>	
				</c:when>
				<c:otherwise>
				    <form name="RFQModifyPercentagePricingForm" action="RFQPriceAdjustmentOnCategoryUpdate" method="post" id="WC_RFQModifyDisplay_TableCell_68">
						<input type="hidden" name="numPPTC" value="0" />
					</form>
				</c:otherwise>
	</c:choose>
	
<!-- End RFQ Category Precentage Adjustment section -->

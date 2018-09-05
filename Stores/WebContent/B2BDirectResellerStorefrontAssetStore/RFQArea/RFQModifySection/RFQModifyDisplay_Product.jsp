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
  * This JSP page displays the product section on the RFQModifyDisplay
  * JSP page.
  *
  * Imports:
  * - CommonSection/RFQPageNavigation.jsp
  * - RFQModifyDisplay_Product_Unit_Row.jsp
  * - RFQModifyDisplay_End_links.jsp
  *
  * Required parameters:
  * - offering_id
  * - pageSize
  * - initPos
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
<c:set var="wrap" value="${requestScope.wrap}" scope="request" />


	<!--display product-->
	<wcbase:useBean id="prodList" classname="com.ibm.commerce.utf.beans.RFQProdListBean">
		<jsp:setProperty property="*" name="prodList" />
		<c:set var="offeringId" value="${param.offeringId}" scope="request" /> 	
		<c:if test="${!empty rfqCategoryId}" >			
			<c:set property="RFQCategoryId" value="${rfqCategoryId}" target="${prodList}" />  
		</c:if>	 
		<%--defaults--%>	
		<c:set var="pageSize" value="5" />
		<c:set var="initPos" value="0" />
		<c:set var="numPages" value="10" />	
		<c:if test="${!empty param.pageSize}">
			<c:set var="pageSize" value="${param.pageSize}" />
		</c:if>
		<c:if test="${!empty param.initPos}">
			<c:set var="initPos" value="${param.initPos}"  />
		</c:if>	
		<c:set target="${prodList}" property="size" value="${pageSize}" />
		<c:set target="${prodList}" property="initialPosition" value="${initPos}" />
		<c:set target="${prodList}" property="RFQId" value="${rfqId}" />
	</wcbase:useBean>

	<tr>
		<td id="WC_RFQDisplay_TableCell_33">
		<table id="WC_RFQDisplay_Table_16">
		<tbody>
			<tr>
				<td  valign="top" width="100%" class="topspace"	id="WC_RFQDisplay_TableCell_34"><br />
					<strong><fmt:message key="RFQDisplay_Product" bundle="${storeText}" /></strong>
				</td>
				
				<td nowrap="nowrap" align="right" id="WC_RFQDisplay_TableCell_35"> 
					<c:set var="numRec" value="${prodList.rowCount}" />
					<c:set var="linkAction" value="RFQModifyDisplay" scope="request" /> 
					<c:set var="URL" value="" scope="request" /> 
					<%-- Display navigation to next/previous page --%>
					<% out.flush(); %>
					<c:import url="../CommonSection/RFQPageNavigation.jsp" >
						<c:param name="numRec" value="${numRec}" />
						<c:param name="initPos" value="${initPos}" />
						<c:param name="pageSize" value="${pageSize}" />
						<c:param name="numPages" value="${numPages}" />
						<c:param name="offering_id" value="${rfqId}" />					
					</c:import>
					<% out.flush(); %>
				</td> 
			</tr>
		</tbody>
		</table>
		</td>
	</tr>
 
	<tr>
		<td id="WC_RFQDisplay_TableCell_36"> 
	
		<form name="RFQModifyProductForm" action="RFQItemUpdate" method="post" id="RFQModifyProductForm">
    		<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQModifyProductForm_1"/>
    		<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQModifyDisplay_FormInput_langId_In_RFQModifyProductForm_1"/>
		<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQModifyDisplay_FormInput_storeId_In_RFQModifyProductForm_1"/>
    		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_FormInput_catalogId_In_RFQModifyProductForm_1"/>
		<input type="hidden" name="initPos" value="<c:out value="${initPos}" />" id="WC_RFQModifyDisplay_FormInput_initPos_In_RFQModifyProductForm_1"/>
	
		<table cellpadding="0" cellspacing="0" border="0" width="100%"	class="bgColor" id="WC_RFQDisplay_Table_17">
		<tbody>
			<tr>
				<td id="WC_RFQDisplay_TableCell_37">
				<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQDisplay_Table_18">
				<tbody>
					<tr>
						<th id="c1" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQModifyDisplay_TableCell_38"><fmt:message key="RFQModifyDisplay_ProdName" bundle="${storeText}" /></th>
						<th id="c2" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQModifyDisplay_TableCell_39"><fmt:message key="RFQModifyDisplay_ProdDesc" bundle="${storeText}" /></th>
	<c:if test="${multiSeller}"> 
						<th id="c3" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQModifyDisplay_TableCell_39"><fmt:message key="RFQDisplay_TargetList" bundle="${storeText}" /></th>    
	</c:if>
						<th id="c4" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_40"><fmt:message key="RFQModifyDisplay_ProdCat" bundle="${storeText}" /></th>
						<th id="c5" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQModifyDisplay_TableCell_41"><fmt:message key="RFQModifyDisplay_ProdType" bundle="${storeText}" /></th>
						<th id="c6" <c:out value="${wrap}" /> class="colHeader_price" id="WC_RFQModifyDisplay_TableCell_42"><fmt:message key="RFQModifyDisplay_Product_Offer_Price" bundle="${storeText}" /></th>
						<th id="c7" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQModifyDisplay_TableCell_42"><fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}" /></th>
						<th id="c8" <c:out value="${wrap}" /> class="colHeader_price" id="WC_RFQDisplay_TableCell_43"><fmt:message key="RFQModifyDisplay_ProdPrice" bundle="${storeText}" /></th>
						<th id="c9" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_44"><fmt:message key="RFQModifyDisplay_ProdCurr" bundle="${storeText}" /></th>
						<th id="c10" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_45"><fmt:message key="RFQModifyDisplay_ProdQuan" bundle="${storeText}" /></th>
						<th id="c11" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_46"><fmt:message key="RFQModifyDisplay_ProdUnit" bundle="${storeText}" /></th>							
						<th id="c12" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_47"><fmt:message key="RFQModifyDisplay_ProdSub" bundle="${storeText}" /></th>
						<th id="c13" <c:out value="${wrap}" /> class="colHeader_last" id="WC_RFQDisplay_TableCell_49"></th>
					</tr> 
					
				<!--iterate through product list-->
				<c:set var="color" value="cellBG_2" />
				<c:set var="pList" value="${prodList.RFQProds}" scope="request" />
				<c:forEach var="product" items="${pList}" begin="0" varStatus="iter">
					<c:set var="index" value="${iter.index}" />
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
						<c:import url="RFQModifyDisplay_Product_Unit_Row.jsp">
							<c:param name="index" value="${iter.index}" />
							<c:param name="offeringId" value="${rfqId}" />
						</c:import>
						<% out.flush(); %>	 
					</tr>
				</c:forEach>					
				<!-- end iterate through product list--> 

				<c:if test="${empty pList}">
					<tr class="cellBG_1">
						<td  valign="top" colspan="13" class="categoryspace t_td" id="WC_RFQDisplay_TableCell_48"><fmt:message key="RFQDisplay_No_Product" bundle="${storeText}" /></td>
					</tr>
				</c:if>
						
				</tbody>
				</table>
				</td>				
			</tr>
		</tbody> 
		</table>
		
		<input type="hidden" name="numProd" value="<c:out value="${requestScope.numProd}" />" id="WC_RFQModifyDisplay_FormInput_numProd_In_RFQModifyProductForm_1"/>
                <input type="hidden" name="URL" value="RFQModifyDisplay?offering_id=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_FormInput_URL_In_RFQModifyProductForm_1"/>		
		</form>
		</td>
	</tr>
	<% out.flush(); %>
 	<c:import url="RFQModifyDisplay_End_links.jsp">	
		<c:param name="numProd" value="${requestScope.numProd}" />
		<c:param name="supplier" value="${requestScope.supplier}" />
	</c:import>
	<% out.flush(); %>
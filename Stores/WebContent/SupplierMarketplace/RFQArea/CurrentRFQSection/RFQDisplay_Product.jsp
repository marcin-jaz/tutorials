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
  * This JSP page displays the Product section on the RFQ summary page.
  * It imports the RFQDisplay_Product_Unit_Row.jsp to iterate through
  * all RFQ products.    
  *
  * Imports:
  * - CommonSection/RFQPageNavigation.jsp
  * - RFQDisplay_Product_Unit_Row.jsp
  *
  * Required parameters:
  * - offeringId
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

<c:set var="wrap" value="${requestScope.wrap}" scope="request" />

<!--display product-->
<wcbase:useBean id="prodList"
       classname="com.ibm.commerce.utf.beans.RFQProdListBean">
       <jsp:setProperty property="*" name="prodList" />
       <c:set var="offeringId" value="${param.offeringId}" scope="request" /> 
       
       <c:set var="pageSize" value="10" />
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
       <c:set target="${prodList}" property="RFQId" value="${offeringId}" />       
       
</wcbase:useBean>

<tr>
       <td id="WC_RFQDisplay_Product_TableCell_1">
       <table id="WC_RFQDisplay_Product_Table_1">
              <tbody>
                     <tr>
                            <td  valign="top" width="100%" class="topspace" id="WC_RFQDisplay_Product_TableCell_2">
                            <h2><fmt:message key="RFQDisplay_Product" bundle="${storeText}" /></h2></td>
                            <td nowrap="nowrap" align="right" id="WC_RFQDisplay_Product_TableCell_3">
                            <!--reuse rfq navigation-->
                            <!-- set variables for RFQPageNavigation.jsp --> 
                            <c:set var="numRec" value="${prodList.rowCount}" />
                            <c:set var="linkAction" value="RFQDisplay" scope="request" /> 
                            <c:set var="URL" value="" scope="request" /> 
                            <!-- Display navigation to next/previous page -->
			    <% out.flush(); %>
                            <c:import url="../CommonSection/RFQPageNavigation.jsp" >
                                   <c:param name="numRec" value="${numRec}" />
                                   <c:param name="initPos" value="${initPos}" />
                                   <c:param name="pageSize" value="${pageSize}" />
                                   <c:param name="numPages" value="${numPages}" />
                            </c:import>
			    <% out.flush(); %>
                            </td>
                     </tr>
              </tbody>
       </table>
       </td>
</tr>

<tr>
       <td id="WC_RFQDisplay_Product_TableCell_4">
       <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RFQDisplay_Table_17">
              <tbody>
                     <tr>
			<td id="WC_RFQDisplay_Product_TableCell_5">
				<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQDisplay_Table_18">
				<tr>
					<th id="d1" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_38"><fmt:message key="RFQDisplay_Product_Name" bundle="${storeText}" /></th>
					<th id="d2" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_39"><fmt:message key="RFQDisplay_Product_Desc" bundle="${storeText}" /></th>
					<th id="d3" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_40"><fmt:message key="RFQDisplay_Product_Category" bundle="${storeText}" /></th>
		                        <th id="d4" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_41"><fmt:message key="RFQDisplay_Product_Type" bundle="${storeText}" /></th>
					<th id="d5" <c:out value="${wrap}" /> class="colHeader_price" id="WC_RFQDisplay_TableCell_42"><fmt:message key="RFQModifyDisplay_Product_Offer_Price" bundle="${storeText}" /></th>
					<th id="d6" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_43"><fmt:message key="RFQDisplay_Product_PPAdjust" bundle="${storeText}" /></th>
					<th id="d7" <c:out value="${wrap}" /> class="colHeader_price" id="WC_RFQDisplay_TableCell_44"><fmt:message key="RFQDisplay_Product_Price" bundle="${storeText}" /></th>
					<th id="d8" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_45"><fmt:message key="RFQDisplay_Product_Currency" bundle="${storeText}" /></th>
					<th id="d9" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_46"><fmt:message key="RFQDisplay_Product_Quantity" bundle="${storeText}" /></th>
					<th id="d10" <c:out value="${wrap}" /> class="colHeader" id="WC_RFQDisplay_TableCell_47"><fmt:message key="RFQDisplay_Product_Unit" bundle="${storeText}" /></th>
					<th id="d11" <c:out value="${wrap}" /> class="colHeader_last" id="WC_RFQDisplay_TableCell_48"><fmt:message key="RFQDisplay_Product_Substitutable" bundle="${storeText}" /></th>
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
                                                 <c:import url="RFQDisplay_Product_Unit_Row.jsp">
                                                        <c:param name="index" value="${iter.index}" />
                                                        <c:param name="offeringId" value="${offeringId}" />
                                                 </c:import>
						<% out.flush(); %>
                                                 
                                                 </tr>
                                          </c:forEach>
<!-- end iterate through product list-->

                                          <c:if test="${empty pList}">
                                                 <tr class="cellBG_1">
                                                        <td valign="top" colspan="11" class="categoryspace t_td" id="WC_RFQDisplay_Product_TableCell_48">
                                                        	<fmt:message key="RFQDisplay_No_Product" bundle="${storeText}" />
                                                        </td>
                                                 </tr>
                                          </c:if>
                                </table>
                            </td>
                     </tr>
              </tbody>
       </table>
       </td>
</tr>



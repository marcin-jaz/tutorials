<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="myAccountPage" value="true" scope="request"/>

<wcf:url var="AjaxMyAccountCenterLinkDisplayURL" value="AjaxLogonFormCenterLinksDisplayView" type="Ajax">    
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<div id="box">
	<div class="my_account" id="WC_OrderStatusCommonPage_div_1">			

					<div class="main_header" id="WC_OrderStatusCommonPage_div_2">
						<div class="left_corner" id="WC_OrderStatusCommonPage_div_3"></div>
						<div class="left" id="WC_OrderStatusCommonPage_div_4">
							<span class="main_header_text">
								<c:choose>
									<c:when test="${WCParam.isQuote eq true}">
										<fmt:message key='MO_MYQUOTES' bundle='${storeText}'/>
									</c:when>
									<c:otherwise>
										<fmt:message key='MO_MYORDERS' bundle='${storeText}'/>
									</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="right_corner" id="WC_OrderStatusCommonPage_div_5"></div>
					</div>
					
					<div class="body" id="WC_OrderStatusCommonPage_div_6">						
						<% out.flush(); %>
							<c:choose>
								<c:when test="${WCParam.isQuote eq true}">
									<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDisplay.jsp" >
										<c:param name="isQuote" value="true"/>
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDisplay.jsp" ></c:import>
								</c:otherwise>
							</c:choose>
						<% out.flush();%>
						<br/>								
						<br clear="all" />					
				    </div>
					<div class="footer" id="WC_OrderStatusCommonPage_div_7">
					  <div class="left_corner" id="WC_OrderStatusCommonPage_div_8"></div>
					  <div class="tile" id="WC_OrderStatusCommonPage_div_9"></div>
					  <div class="right_corner" id="WC_OrderStatusCommonPage_div_10"></div>
					</div>
				
	</div>
 </div>


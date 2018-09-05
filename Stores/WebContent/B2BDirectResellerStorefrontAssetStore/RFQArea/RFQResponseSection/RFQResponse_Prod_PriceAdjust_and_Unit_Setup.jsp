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
  * This JSP page sets up information used by the RFQ response pages.
  *
  * Required parameters:
  * - product_id
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:remove var="priceAdjust" scope="request" />
<c:remove var="unit" scope="request" />
<c:remove var="rfqRspProd" scope="request" />
   
<wcbase:useBean id="rfqRspProd" classname="com.ibm.commerce.rfq.beans.RFQResProductDataBean" scope="request">
		<c:set target="${rfqRspProd}" property="resProdId" value="${param.product_id}" />		
</wcbase:useBean>  





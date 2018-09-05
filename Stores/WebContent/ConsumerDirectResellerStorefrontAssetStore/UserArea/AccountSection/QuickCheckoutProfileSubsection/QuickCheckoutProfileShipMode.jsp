<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation.
 *     2006
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<%-- 
  ***
  *	Start: default shipping mode
  ***
--%>

<table cellpadding="0" cellspacing="0" border="0" width="786" class="t_table" id="WC_QuickCheckoutProfileForm_Table_21">
<tbody>
	<tr>
		<td class="t_td2" colspan="2" id="WC_QuickCheckoutProfileForm_TableCell_211">
			<h2><fmt:message key="WITHIN_US" bundle="${storeText}"/></h2>
		</td>
		<td class="t_td2" id="WC_QuickCheckoutProfileForm_TableCell_212">
			<h2><fmt:message key="DELIVERY_TIME" bundle="${storeText}"/></h2>
		</td>
	</tr>

	<c:if test="${!empty profileOrderItemBean}">
		<c:set var="shippingModeId" value="${profileOrderItemBean.shippingModeId}" />
	</c:if>

	<c:if test="${empty shippingModeId}">
		<c:set var="shippingModeId" value="${WCParam.shipModeId}" />
	</c:if>
	<wcbase:useBean id="shipModeListBean" classname="com.ibm.commerce.tools.shipping.ShippingModeListDataBean" scope="page" > 
	</wcbase:useBean>

	<c:set var="shipModeApplied" value="" />

	<c:forEach items="${shipModeListBean.shippingModeList}" var="shippingModeBean" varStatus="status">
		<c:choose>
			<c:when test="${shippingModeBean.description.shipModeId eq shippingModeId}">
				<c:set var="selection" value="checked" />
				<c:set var="shipModeApplied" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="selection" value="" />
			</c:otherwise>
		</c:choose>	
	<tr>
		<td valign="top" id="WC_QuickCheckoutProfileForm_TableCell_213_<c:out value='${status.count}'/>">
			<label for="WC_QuickCheckoutProfileForm_FormInput_shipModeId_In_QuickCheckout_1_<c:out value='${status.count}'/>"></label>
			<input type="radio" name="shipModeId" id="WC_QuickCheckoutProfileForm_FormInput_shipModeId_In_QuickCheckout_1_<c:out value='${status.count}'/>" value="<c:out value="${shippingModeBean.description.shipModeId}"/>" <c:if test="${!empty selection}"><c:out value="${selection}"/>="<c:out value="${selection}"/>"</c:if>/>
			<c:out value="${shippingModeBean.description.description}"/>
		</td>
		<td valign="top" id="WC_QuickCheckoutProfileForm_TableCell_214_<c:out value='${status.count}'/>">
			<c:out value="${shippingModeBean.description.field1}"/>
		</td>
		<td valign="top" id="WC_QuickCheckoutProfileForm_TableCell_215_<c:out value='${status.count}'/>">
			<c:out value="${shippingModeBean.description.field2}"/>
		</td>
	</tr>
	</c:forEach>

</tbody>
</table>
<%-- 
  ***
  *	End: default shipping mode
  ***
--%>

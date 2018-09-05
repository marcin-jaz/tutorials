<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%--
  *****
  * This page allows the user to choose a shipping method for the order.
  * It is present during check out if the Accelerator "Change Flow" option "Single Shipping Method" is selected.
  * The main content includes:
  * - For each shipping method: description and delivery time
  *****
 --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf" %>

<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
	<c:set property="orderId" value="${WCParam.orderId}" target="${orderBean}"/>
</wcbase:useBean>

<wcbase:useBean id="shippingDataBean" classname="com.ibm.commerce.fulfillment.beans.ShippingDataBean">
	<c:set property="catalogEntryId" value="${orderBean.orderItemDataBeans[0].catalogEntry.catalogEntryID}" target="${shippingDataBean}"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

	<title><fmt:message key="SHIPPING_TITLE" bundle="${storeText}" /></title>

	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>

	<script language="javascript">
	var busy = false;

	function Handle_Next_Click(form)
	{
		if (!busy){
			busy = true;
			form.submit();
		}
		return false;
	}

</script>
</head>

<body>
<!-- JSP File Name:  SingleShippingMethodDisplay.jsp -->

<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_SingleShippingMethodDisplay_Table_1">
<tbody>
<tr>
<td colspan="3" class="storeName" id="WC_SingleShippingMethodDisplay_TableCell_1">
	<c:import url="${headerIncludeFile}"/>
</td>
</tr>
<tr>
	<td valign="top" class="sidebar" id="WC_SingleShippingMethodDisplay_TableCell_2">
		<c:import url="${sidebarIncludeFile}"/>
	</td>
	<td width="10" id="WC_SingleShippingMethodDisplay_TableCell_4">&nbsp;</td>
	<td width="600" valign="top" class="mainContent" id="WC_SingleShippingMethodDisplay_TableCell_3">

		<!--MAIN CONTENT STARTS HERE-->

		<form name="ShipMethodPage" method="post" action="OrderItemUpdate" id="ShipMethodPage">
		<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_SingleShippingMethodDisplay_FormInput_storeId_In_ShipMethodPage_1"/>
		<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_SingleShippingMethodDisplay_FormInput_catalogId_In_ShipMethodPage_1"/>
		<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_SingleShippingMethodDisplay_FormInput_langId_In_ShipMethodPage_1"/>
		<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_SingleShippingMethodDisplay_FormInput_orderId_In_ShipMethodPage_1"/>
		<input type="hidden" name="status" value="P" id="WC_SingleShippingMethodDisplay_FormInput_status_In_ShipMethodPage_1"/>
		<input type="hidden" name="URL" value="OrderDisplay?orderItemId*=" id="WC_SingleShippingMethodDisplay_FormInput_URL_In_ShipMethodPage_1"/>

		<table width="100%" cellpadding="0" cellspacing="1" border="0" id="WC_SingleShippingMethodDisplay_Table_2">
		<tbody>

		<tr>
			<td colspan="3" id="WC_SingleShippingMethodDisplay_TableCell_5">
				<c:set var="bctCurrentPage" value="ShippingMethod" />
				<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf" %>
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="3" class="categoryspace" id="WC_SingleShippingMethodDisplay_TableCell_17">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_SingleShippingMethodDisplay_Table_4">
				<tbody><tr>
					<td valign="top" id="WC_SingleShippingMethodDisplay_TableCell_18">

						<span class="pageHeading"><fmt:message key="CHECKOUT3" bundle="${storeText}" /> &nbsp;</span> <br/><span class="subHeading"><fmt:message key="CHOOSE_SHIP_METHOD" bundle="${storeText}" /></span>


					</td>
					<td nowrap="nowrap" align="right" valign="bottom" id="WC_SingleShippingMethodDisplay_TableCell_19">

						<span class="strongtext"><fmt:message key="STEP_3_4" bundle="${storeText}" /></span>

					</td>
				</tr>
				</tbody></table>
				<hr width="100%"/>
			</td>
		</tr>
		<tr>
			<td valign="middle" colspan="2" class="labelText2" id="WC_SingleShippingMethodDisplay_TableCell_20">

				&nbsp;<fmt:message key="WITHIN_US" bundle="${storeText}" />

			</td>

			<td valign="middle" class="labelText2" id="WC_SingleShippingMethodDisplay_TableCell_21">


				<fmt:message key="DELIVERY_TIME" bundle="${storeText}" />

			</td>
		</tr>

		<!--Display Shipping Modes with their cost and description-->

		<c:forEach var="shipModeId" items="${shippingDataBean.shipModeIds}">
			<c:remove var="shipMode"/>
			<wcbase:useBean id="shipMode" classname="com.ibm.commerce.fulfillment.beans.ShippingModeDataBean">
				<c:set property="dataBeanKeyShippingModeId" value="${shipModeId}" target="${shipMode}"/>
			</wcbase:useBean>

			<c:choose>
				<c:when test="${shipModeId eq orderBean.orderItemDataBeans[0].shippingModeId}">
					<c:set var="checked" value="CHECKED" />
				</c:when>
				<c:otherwise>
					<c:set var="checked" value="" />
				</c:otherwise>
			</c:choose>


             <tr>
				<td valign="top" id="WC_SingleShippingMethodDisplay_TableCell_22">
					<input type="radio" name="shipModeId" id="WC_SingleShippingMethodDisplay_FormInput_shipModeId_In_ShipMethodPage_1" value="<c:out value="${shipModeId}"/>" <c:out value="${checked}"/>/>
				</td>
				<td valign="top" width="280" id="WC_SingleShippingMethodDisplay_TableCell_23">
					<span class="strongtext"><b><label for="WC_SingleShippingMethodDisplay_FormInput_shipModeId_In_ShipMethodPage_1"><c:out value="${shipMode.description.description}" escapeXml="false"/></label></b></span>
				</td>

				<td valign="top" id="WC_SingleShippingMethodDisplay_TableCell_24">
					<span class="text"><c:out value="${shipMode.description.field2}" escapeXml="false"/></span><br/>
					<span class="text"><c:out value="${shipMode.description.field1}" escapeXml="false"/></span>
				</td>
             </tr>
		</c:forEach>

		<!-- Display Shipping Method Discounts -->
		<c:remove var="headerPrinted"/>
		<c:remove var="hasDiscounted"/>
		<c:forEach var="shipModeId" items="${shippingDataBean.shipModeIds}" varStatus="status">
			<c:remove var="shipMode"/>
			<wcbase:useBean id="shipMode" classname="com.ibm.commerce.fulfillment.beans.ShippingModeDataBean">
				<c:set property="dataBeanKeyShippingModeId" value="${shipModeId}" target="${shipMode}"/>
			</wcbase:useBean>

			<c:remove var="calcodeListDB"/>
			<wcbase:useBean id="calcodeListDB" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
				<c:set property="calculationUsageId" value="-1" target="${calcodeListDB}"/>
				<c:set property="inShipmodeId" value="${shipModeId}" target="${calcodeListDB}"/>
			</wcbase:useBean>

			<c:if test="${!empty calcodeListDB.calculationCodeDataBeans}">
				<c:if test="${empty headerPrinted}">
					<tr>
						<td colspan="3" id="WC_SingleShippingMethodDisplay_TableCell_25_<c:out value="${status.count}"/> ">

							&nbsp;
						</td>
					</tr>
					<tr>
						<td colspan="3" align="left" valign="top" class="discountBox" id="WC_SingleShippingMethodDisplay_TableCell_26">
							<span class="strongtext"><fmt:message key="DISCOUNT2" bundle="${storeText}" /></span><br/><br/>

						<c:set var="headerPrinted" value="true"/>


				</c:if>
				<c:forEach var="calcode" items="${calcodeListDB.calculationCodeDataBeans}">
					<c:if test="${calcode.published == 1}">
						<c:set var="hasDiscount" value="true"/>
						<font class="discount">
							<c:url var="DiscountDetailsDisplayUrl" value="DiscountDetailsDisplayView">
								<c:param name="code" value="${calcode.code}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
							</c:url>
							<a href="<c:out value="${DiscountDetailsDisplayUrl}"/>" id="WC_SingleShippingMethodDisplay_Link_5">
								<c:out value="${calcode.descriptionString}" escapeXml="false"/>
							</a><br/>&nbsp;
							<img src="<c:out value="${jspStoreImgDir}"/>images/Discount_star.gif" alt="<c:out value="${calcode.descriptionString}" escapeXml="false"/>"/>
							<c:out value="${shipMode.description.description}" escapeXml="false"/>, <c:out value="${calcode.longDescriptionString}" escapeXml="false"/>
						</font><br/><br/>
					</c:if>
				</c:forEach>
			</c:if>
		</c:forEach>
		<c:if test="${headerPrinted}">
						</td>
					</tr>

		</c:if>


 		<tr>
			<c:if test="${hasDiscount}">
				<td colspan="3" width="100%" align="left" id="WC_SingleShippingMethodDisplay_TableCell_DiscountClaimer_1">
					<br/>
					<br/>
					<span class="discount">
					<img src="<c:out value="${jspStoreImgDir}"/>images/Discount_star.gif" alt="<fmt:message key="DISCOUNT_DISCLAIMER" bundle="${storeText}"/>"/>&nbsp;<fmt:message key="DISCOUNT_DISCLAIMER" bundle="${storeText}"/>
					</span>
				</td>

			</c:if>
		</tr>

		<tr>
			<td valign="top" colspan="3" class="topspace" id="WC_SingleShippingMethodDisplay_TableCell_27">
				<br/>
				<table cellpadding="0" cellspacing="0" border="0" id="WC_SingleShippingMethodDisplay_Table_5">
				<tbody><tr>
					<td class="buttoncell" id="WC_SingleShippingMethodDisplay_TableCell_28">
					 <%-- TODO convert URLs --%>
					 	<c:set var="ActaulSingleShippingMethodPage">
					 		<flow:url exitPort="ActualSingleShippingMethodPage.i1.xPrevious"/>
					 	</c:set>
					 	<c:url var="ActualSingleShippingMethodPageUrl" value="${ActaulSingleShippingMethodPage}">
							<c:param name="orderId" value="${WCParam.orderId}"/>
							<c:param name="langId" value="${langId}"/>
							<c:param name="storeId" value="${WCParam.storeId}"/>
							<c:param name="catalogId" value="${WCParam.catalogId}"/>
						</c:url>
						<a href="<c:out value="${ActualSingleShippingMethodPageUrl}" />" class="buttonStyle" id="WC_SingleShippingMethodDisplay_Link_5">
							<fmt:message key="PREVIOUS" bundle="${storeText}" />
						</a>

					<%-- to be verify  following is before change by chun
						<a href="<flow:url exitPort='ActualSingleShippingMethodPage.i1.xPrevious'/>?orderId=<c:out value="${WCParam.orderId}"/>&storeId=<c:out value="${WCParam.storeId}"/>&catalogId=<c:out value="${WCParam.catalogId}"/>&langId=<c:out value="${langId}"/>" class="buttonStyle" id="WC_SingleShippingMethodDisplay_Link_5"><fmt:message key="PREVIOUS" bundle="${storeText}" /></a>
					--%>
					</td>
					<td width="2" id="WC_SingleShippingMethodDisplay_TableCell_29"><span class="strongtext">&nbsp;</span></td>
					<td class="buttoncell" id="WC_SingleShippingMethodDisplay_TableCell_30">

						<a href="#" onclick="Handle_Next_Click(document.ShipMethodPage); return false;" class="buttonStyle" id="WC_SingleShippingMethodDisplay_Link_6"><fmt:message key="NEXT" bundle="${storeText}" /></a>

					</td>
				</tr>
				</tbody></table>
			</td>
		</tr>
		</tbody></table>
		</form>
	</td>
</tr>
<tr>
	<td colspan="3" class="footer" align="right" id="WC_SingleShippingMethodDisplay_TableCell_31">

		<c:import url="${footerIncludeFile}" />

	</td>
</tr>
</tbody></table>


</body>
</html>

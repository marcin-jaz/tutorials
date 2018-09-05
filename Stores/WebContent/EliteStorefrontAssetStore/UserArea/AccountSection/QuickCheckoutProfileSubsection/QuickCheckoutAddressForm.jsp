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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:set var="prefix" value="${param.prefix}"/>

<c:choose>
						<c:when test="${locale == 'zh_CN'}">
							<%@ include file="../../../Snippets/ReusableObjects/QuickCheckoutAddressUpdateForm_CN.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ADDRESS,ZIP,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'zh_TW'}">
							<%@ include file="../../../Snippets/ReusableObjects/QuickCheckoutAddressUpdateForm_TW.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ZIP,ADDRESS,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'ru_RU'}">
							<%@ include file="../../../Snippets/ReusableObjects/QuickCheckoutAddressUpdateForm_RU.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,middle_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
							<%@ include file="../../../Snippets/ReusableObjects/QuickCheckoutAddressUpdateForm_JP_KR.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="LAST_NAME,FIRST_NAME,COUNTRY/REGION,ZIP,STATE/PROVINCE,CITY,ADDRESS,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'de_DE' || locale == 'es_ES' || locale == 'fr_FR' || locale == 'it_IT' || locale == 'ro_RO'}">
							<%@ include file="../../../Snippets/ReusableObjects/QuickCheckoutAddressUpdateForm_DE_ES_FR_IT_RO.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'pl_PL'}">
							<%@ include file="../../../Snippets/ReusableObjects/QuickCheckoutAddressUpdateForm_PL.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,LAST_NAME,ADDRESS,ZIP,CITY,STATE/PROVINCE,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:otherwise>
							<%@ include file="../../../Snippets/ReusableObjects/QuickCheckoutAddressUpdateForm.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,LAST_NAME,ADDRESS,CITY,COUNTRY/REGION,STATE/PROVINCE,ZIP,phone1,EMAIL1"/>
						</c:otherwise>
</c:choose>

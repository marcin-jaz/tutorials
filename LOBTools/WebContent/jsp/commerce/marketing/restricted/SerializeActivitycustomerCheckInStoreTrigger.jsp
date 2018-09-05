<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>

<object objectType="customerCheckInStoreTrigger"> 
	
	<parent>
		<object objectId="${element.parentElementIdentifier.name}"/>
	</parent>
	
	<elemTemplateName><wcf:cdata data="${element.campaignElementTemplateIdentifier.externalIdentifier.name}"/></elemTemplateName>
	<elementName>${element.campaignElementIdentifier.name}</elementName>
	
	<sequence>${element.elementSequence}</sequence>
	<customerCount readonly="true">${element.count}</customerCount>
	
	<c:forEach var="elementVariable" items="${element.campaignElementVariable}">
		<c:if test="${elementVariable.name == 'locationList'}">
			<c:choose>
				<c:when test="${locationList != ''}">
					<c:set var="locationList"  value="${locationList}${','}${elementVariable.value}" />
				</c:when>
				<c:otherwise>
					<c:set var="locationList"  value="${elementVariable.value}" />
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test="${elementVariable.name != 'locationList'}">
			<${elementVariable.name}><wcf:cdata data="${elementVariable.value}"/></${elementVariable.name}>
		</c:if>
		<c:if test="${elementVariable.name == 'locationType'}">
		    <c:set var="locationType"  value="${elementVariable.value}" />
		</c:if>
	</c:forEach>

	<c:if test="${locationList != ''}">
		<c:forTokens var="location" items="${locationList}" delims=",">
		    <c:if test="${locationType == 'region'}">
			    <jsp:directive.include file="GetChildLocationRegionById.jsp" />
			</c:if>
		    <c:if test="${locationType == 'pointOfInterest'}">
			    <jsp:directive.include file="GetChildLocationPOIById.jsp" />
			</c:if>
		</c:forTokens>
	</c:if>
	
	<c:forEach var="userDataField" items="${element.userData.userDataField}">
		<x_${userDataField.typedKey}><wcf:cdata data="${userDataField.typedValue}"/></x_${userDataField.typedKey}>
	</c:forEach>
	
</object>
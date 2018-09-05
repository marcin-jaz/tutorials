<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ibm.commerce.bi.taglib.TagUtils" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.datatype.WcParam" %>

<%
// check to see if the wcparam is available; initialise it if it is not available
if( null == request.getAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM)){
	request.setAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM, new WcParam(request));
}
WcParam wcParam = (WcParam)request.getAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM);
CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Integer storeId = commandContext.getStoreId();

%>
[{
	<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set target="${catEntry}" property="catalogEntryID" value="${WCParam.productId}"/>
	</wcbase:useBean>
	productId: '<c:out value="${catEntry.partNumber}"/>', 
		
	<c:set var="singleQuote" value="'"/>
	<c:set var="escapedSingleQuote" value="\\\\'"/>
	<c:set var="doubleQuote" value="\""/>
	<c:set var="escapedDoubleQuote" value="\\\\\""/>

	<c:remove var="itemName"/>
	<c:set var="itemName" value="${fn:replace(catEntry.description.name, singleQuote, escapedSingleQuote)}"/>
	<c:set var="itemName" value="${fn:replace(itemName, doubleQuote, escapedDoubleQuote)}"/>
	name: '<c:out value="${itemName}" escapeXml="false"/>',


	<%-- code that gets category and master category --%>
	<%
  	Long productId = Long.valueOf(catEntry.getCatalogEntryID());
  	try {
			com.ibm.commerce.catalog.objects.CatalogEntryRelationAccessBean rel = new com.ibm.commerce.catalog.objects.CatalogEntryRelationAccessBean();
			java.util.Enumeration catEntryParents = rel.findByCatalogEntryChildIdAndStore(productId, storeId);
			while(catEntryParents.hasMoreElements()){
				productId = ((com.ibm.commerce.catalog.objects.CatalogEntryRelationAccessBean)catEntryParents.nextElement()).getCatalogEntryIdParentInEJBType();
				catEntryParents = rel.findByCatalogEntryChildIdAndStore(productId, storeId);
			}
	  }catch(Exception e) {
	     // a page should never throw an exception
	  }
	%>
	
	category: '<%=TagUtils.getCategoryID(commandContext, Long.valueOf(catEntry.getCatalogEntryID()))%>',
	masterCategory: '<%=TagUtils.getMasterCategoryId(commandContext, productId)%>'
}]

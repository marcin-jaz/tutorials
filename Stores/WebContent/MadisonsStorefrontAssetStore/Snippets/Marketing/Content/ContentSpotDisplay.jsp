<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2008
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been thoroughly
//* tested under all conditions. IBM, therefore, cannot guarantee its
//* reliability, serviceability or functionality.
//*
//* This sample may include the names of individuals, companies, brands and
//* products in order to illustrate concepts as completely as possible. All
//* of these names are fictitious and any similarity to the names and
//* addresses used by actual persons or business enterprises is entirely
//* coincidental.
//*---------------------------------------------------------------------
//*
%>
<%--
  *****
  *
  * This JSP can be used to display store contents associated with a content spot.
  *
  * Parameters
  *	-spotName
  *	This file can be reused in different pages of the store by including it and giving a unique
  *	value name for spotName. This unique value must match the Content Spot name used in the
  *	WebSphere Commerce Accelerator.
  *
  *
  *	-maxNumDisp
  *	This value sets the maximum number of assets to display in a content spot. If this
  *     parameter is omitted, or is <0, then the default values will be used. The default value is
  *     3.
  *
  *	-maxItemsInRow
  *	This value sets the maximum number of content assets to be displayed in a row. If this
  *     parameter is omitted, or is <0, then the default value of 3 will be used.
  *
  *	-maxColInRow
  *	This value sets the maximum number of Content assets to display in a row. If this parameter
  *     is omitted, or is <0, then the default value of 3 will be used.
  *
  *	-substitutionValues
  *	These values replace the Parameters in marketing text with values. If marketing text has any
  *	parameters and these substitution values omitted in include snippet, then the {parameterName}
  *	in marketing text will not be replaced with parameter value.

  *
  * This is an example of how this file could be included into a page:
  *		<c:import url="${jspStoreDir}/Snippets/marketing/Content/ContentSpotDisplay.jsp">
  *			<c:param name="spotName" value="FrontPageContent" />
  *			<c:param name="maxNumDisp" value="2" />
  *			<c:param name="maxItemsInRow" value="3" />
  *			<c:param name="maxColInRow" value="3" />
  *			<c:param name="substitutionValues" value="{parameterName1},parameterValue1" />
  *			<c:param name="substitutionValues" value="{parameterName2},parameterValue2" />
  *		</c:import>
  *    If the parameters maxNumDisp, maxItemsInRow, or maxColInRow, are not provided, default
  *    values will be used.
  *****
--%>

<!-- Start- JSP File Name: ContentSpotDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
	// get the Content Spot name from request parameter, and decode it in case it has been encoded
	if (request.getParameter("spotName") != null) {
		request.setAttribute("spotName", java.net.URLDecoder.decode(request.getParameter("spotName"), "UTF-8"));
	}
%>

<%--
  ***
  * Specifies whether AttachmentDisplay.jspf uses fully qualified URL for
  image tags or relative path..By default it uses relative path..Fully qualified
  URL is required for email activity functionality..
  ***
--%>
<c:set value="false" var="paramUseFullURL" />
<c:if test="${!empty param.useFullURL}">
	<c:set value="${param.useFullURL}" var="paramUseFullURL" />
</c:if>

<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="contentSpotHostPath" />

<c:set value="${pageContext.request.contextPath}/servlet/ClickInfo" var="clickInfoPath" />
<c:if test="${!empty param.clickInfoURL}">
  <c:set value="${param.clickInfoURL}" var="clickInfoPath" />
</c:if>

<%--
	The content spot requires a valid value for spotName parameter.
--%>

<c:if test="${!empty param.spotName}">

	<%-- Creates a Content Spot --%>
	<wcbase:useBean id="marketing_ContentSpot"
		classname="com.ibm.commerce.content.beans.EContentDataBean">

		<%-- Sets the name for the Content Spot --%>
		<c:set target="${marketing_ContentSpot}" property="spotName"
			value="${param.spotName}" />

		<c:choose>
			<c:when test="${param.maxNumDisp>0}">
				<c:set target="${marketing_ContentSpot}" property="maxResults"
					value="${param.maxNumDisp}" />
			</c:when>
			<c:otherwise>
				<c:set target="${marketing_ContentSpot}" property="maxResults"
					value="3" />
			</c:otherwise>
		</c:choose>
	</wcbase:useBean>

	<c:choose>
		<c:when test="${param.maxItemsInRow>0}">
			<c:set var="content_MaxInRow" value="${param.maxItemsInRow}" />
		</c:when>
		<c:otherwise>
			<c:set var="content_MaxInRow" value="3" />
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${param.maxColInRow>0}">
			<c:set var="content_MaxInCol" value="${param.maxColInRow}" />
		</c:when>
		<c:otherwise>
			<c:set var="content_MaxInCol" value="3" />
		</c:otherwise>
	</c:choose>

	<c:set var="clmwidth" value="${100%content_MaxInRow}" />
	<c:set var="colwidth" value="${100%content_MaxInCol}" />

	<table id="WC_ContentSpotDisplay_Table_3_<c:out value='${param.spotName}'/>">
		<c:set var="collateralInRow" value="0" />
		<c:forEach items="${marketing_ContentSpot.contentDataBean}"
			var="ContentObj" varStatus="status">
			<c:if test="${!empty ContentObj.urlLink}">

				<c:url value="${contentSpotHostPath}${clickInfoPath}" var="ClickInfoFullPathVar">
					<c:param name="URL" value="${ContentObj.urlLink}" />
				</c:url>

				<c:url value="/servlet/ClickInfo" var="ClickInfoPathVar">
					<c:param name="URL" value="${ContentObj.urlLink}" />
				</c:url>

			</c:if>
			<flow:ifEnabled feature="Analytics">
			<%-- Coremetrics Tag --%>
			<c:if test="${!empty ClickInfoPathVar}">
			<cm:contenturl url="${ClickInfoPathVar}" spotname="${param.spotName}" contentname="${ContentObj.name}" id="ClickInfoPathVar" />
			</c:if>	
			</flow:ifEnabled>

			<%-- Added For LI 1075 --%>
			<%-- ********************************* START *************************************** --%>
			<%-- set the substitutionValues for the Content Spot --%>
			<c:if test="${paramValues.substitutionValues != null}">
				<c:set target="${ContentObj}" property="substitutionValues" value="${paramValues.substitutionValues}" />
			</c:if>
			<%-- ********************************** END ******************************************--%>

			<%--
			Content can be of type File or Text.
			--%>

			<c:if test="${collateralInRow % content_MaxInRow==0 }">
				<tr>
			</c:if>
			<c:set var="collateralInRow" value="${collateralInRow+1}" />

			<%--
			This choose block is used to properly display the content depending on the
			type.
				--%>
			<c:choose>
				<c:when test="${ContentObj.typeName == 'File'}">

					<c:set var="content_AttachBean"
						value="${ContentObj.attachmentDataBean}" />

					<c:choose>

						<c:when test="${ContentObj.mimeType == 'image'}">

							<c:set var="id" value="${status.count}" />
							<c:set var="AttachmentDataBean" value="${content_AttachBean}" />
							<c:set var="URL" value="${ClickInfoFullPathVar}" />
							<c:if test="${empty ContentObj.urlLink}">
								<c:set var="URL" value="" />
							</c:if>
							<c:set var="useFullURL" value="false" />

							<td align="center" id="WC_ContentSpotDisplay_td_3_<c:out value='${status.count}'/>">
							<table id="WC_ContentSpotDisplay_tables_1_<c:out value='${status.count}'/>">
							<tr>
							<%@ include file="../../ReusableObjects/AttachmentDisplay.jspf"%>
							</tr>
							<c:if test="${!empty ContentObj.marketingText}">
								<tr>
								<td align="center" id="WC_ContentSpotDisplay_td_1_<c:out value='${status.count}'/>">
								<c:if test="${!empty ContentObj.urlLink}">
									<a href="<c:out value="${ClickInfoFullPathVar}" escapeXml="false"/>"
										name="WC_ContentSpotDisplay_Link_6_<c:out value="${status.count}" />"
										id="WC_ContentSpotDisplay_Link_6_<c:out value="${status.count}" />">
								</c:if>
								<c:out value="${ContentObj.marketingText}" escapeXml="false" />
								</td>
								</tr>
								<c:if test="${!empty ContentObj.urlLink}"></a>
								</c:if>
							</c:if>
							</table>
							</td>


						</c:when>
						<c:otherwise>
							<c:set var="id" value="${status.count}" />
							<c:set var="AttachmentDataBean" value="${content_AttachBean}" />
							<c:set var="useFullURL" value="${paramUseFullURL}" />
							<%@ include file="../../ReusableObjects/AttachmentDisplay.jspf"%>
							</tr><tr>
							<td id="WC_ContentSpotDisplay_td_2_<c:out value='${status.count}'/>"><a href="<c:out value="${ClickInfoFullPathVar}" escapeXml="false"/>"

								name="WC_ContentSpotDisplay_Link_6a_<c:out value="${status.count}" />"
								id="WC_ContentSpotDisplay_Link_6a_<c:out value="${status.count}" />">
							<c:out value="${ContentObj.marketingText}" escapeXml="false" />
							</a></td>
						</c:otherwise>
					</c:choose>
				</c:when>
			</c:choose>

			<c:if test="${collateralInRow % content_MaxInCol==0 }">
				<%--
				Draw another row if the number of collateral displayed on this row
				is greater than the number specified by MaxInRow.
				--%>

				</tr>
			</c:if>
		</c:forEach>
		<%-- Close out remaining space on the last row. --%>

		<c:if test="${(collateralInRow % content_MaxInCol )!= 0}">
			<td
				colspan="<c:out value="${content_MaxInCol- (collateralInRow % content_MaxInCol)}" />"
				id="WC_ContentSpotDisplay_TableCell_8_<c:out value='${param.spotName}'/>">
<%-- removed blank line
				<br />
--%>
			</td>
		</tr>

<%-- No matching "<tr>" found, and it is adding one row in the table.
			</tr>
--%>
		</c:if>



		<%--If the content is of type Text, then only one should be displayed per row. --%>

		<c:forEach items="${marketing_ContentSpot.contentDataBean}"
			var="ContentObj" varStatus="status">
			
			<c:if test="${!empty ContentObj.urlLink}">

				<c:url value="${contentSpotHostPath}${clickInfoPath}" var="ClickInfoFullPathVar">
					<c:param name="URL" value="${ContentObj.urlLink}" />
				</c:url>

				<c:url value="/servlet/ClickInfo" var="ClickInfoPathVar">
					<c:param name="URL" value="${ContentObj.urlLink}" />
				</c:url>
			</c:if>
			
			<c:if test="${ContentObj.typeName == 'Text'}">
				<tr>
					<td width="100%" align="left" valign="top"
						id="WC_ContentSpotDisplay_TableCell_7_<c:out value='${param.spotName}'/>_<c:out value="${status.count}" />">
<%-- removed blank line
					<br /> --%>
					<%-- Changes Made for D160092 - Added <c:if> & the hyperlink --%> 
	 				<c:if test="${! empty ContentObj.urlLink && !empty ContentObj.marketingText}"> 
					<a href="<c:out value="${ClickInfoFullPathVar}" escapeXml="false"/>"
					name="WC_ContentSpotDisplay_Link_7_<c:out value="${status.count}" />"
					id="WC_ContentSpotDisplay_Link_7_<c:out value="${status.count}" />">
					</c:if>
					<c:out value="${ContentObj.marketingText}" escapeXml="false" />
					<c:if test="${!empty ContentObj.urlLink && !empty ContentObj.marketingText}"></a></c:if>
<%-- removed blank line
					<br/>
--%>
					</td>
				</tr>
			</c:if>
		</c:forEach>

		<%--
	***
	* End: Collateral
	***
	--%>
	</table>
</c:if>

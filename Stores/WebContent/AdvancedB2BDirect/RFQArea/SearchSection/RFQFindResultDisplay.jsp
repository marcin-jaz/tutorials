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
  * This JSP page displays the results of a search for a particular RFQ
  * based on the selected criteria.
  * 
  * Required parameters:
  * - catalogId
  * - storeId
  * - langId
  *
  *****
--%>
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQFindConstants.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQFindResultDisplay_Title"
	bundle="${storeText}" /></title>
<link rel="stylesheet"
	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"
	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio" />

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>
<c:set var="URL" />
<wcbase:useBean id="rfq" classname="com.ibm.commerce.utf.beans.RFQListBean" scope="request">

	<jsp:setProperty property="*" name="rfq" />

	<c:set var="pageSize" value="10" />
	<c:set var="initPos" value="0" />
	<c:set var="numPages" value="10" />
	
	<c:if test="${!empty WCParam.pageSize}">
		<c:set var="pageSize" value="${WCParam.pageSize}" />
	</c:if>
	<c:if test="${!empty WCParam.initPos}">
		<c:set var="initPos" value="${WCParam.initPos}"  />
	</c:if>
	<c:set target="${rfq}" property="size" value="${pageSize}" />
	<c:set target="${rfq}" property="initialPosition" value="${initPos}" />
	<c:set target="${rfq}" property="storeId" value="${storeId}" />
	<c:set target="${rfq}" property="ownerId" value="${userId}" />
	
	<c:choose>
		<c:when test="${WCParam.searchType eq 'name'}">
			<c:set var="URL" value="searchType=name&name=${WCParam.name}" />
			<c:set target="${rfq}" property="name" value="" />
			<c:set target="${rfq}" property="matchName" value="${WCParam.name}" />
		</c:when>
		<c:when test="${WCParam.searchType eq 'state'}">
			<c:set var="URL" value="searchType=state&status=${WCParam.status}"  />
			<c:set target="${rfq}" property="state" value="${WCParam.status}" />
		</c:when>
		<c:when test="${WCParam.searchType eq 'createdate'}">
			<c:set var="URL" value="searchType=createdate&createdate=${WCParam.createdate}&createtime=${WCParam.createtime}" />
			<c:set target="${rfq}" property="createTime" value="${WCParam.createdate} ${WCParam.createtime}" />
		</c:when>
		<c:when test="${WCParam.searchType eq 'activedate'}">
			<c:set var="URL" value="searchType=activedate&activedate=${WCParam.activedate}&activetime=${WCParam.activetime}" />
			<c:set target="${rfq}" property="activateTime" value="${WCParam.activedate} ${WCParam.activetime}" />
		</c:when>
	</c:choose>
	
</wcbase:useBean> 
<c:set var="rlist" value="${rfq.RFQs}" scope="request"/>

<!--START MAIN CONTENT-->

			<table cellpadding="2" cellspacing="0" width="100%" border="0" id="WC_RFQFindResultDisplay_Table_2">

				<tbody>
					<tr>
						<td width="10" rowspan="3"	id="WC_RFQFindResultDisplay_TableCell_3">&nbsp;</td>
						<td  valign="top" colspan="2" class="categoryspace" id="WC_RFQFindResultDisplay_TableCell_4">
						<h1><fmt:message key="RFQFindResultDisplay_FindResult" bundle="${storeText}" /></h1>
						<fmt:message key="RFQFindResultDisplay_contain"
							bundle="${storeText}" /></td>
						<td align="right" id="WC_RFQFindResultDisplay_TableCell_5">

				
				<c:set var="numRec" value="${rfq.rowCount}" />
				<c:set var="linkAction" value="RFQFindResultDisplay" scope="request" /> 
				<c:set var="URL" value="${URL}" scope="request" /> 
				
				<%-- Display navigation to next/previous page --%>
				<% out.flush(); %>
				<c:import url="../CommonSection/RFQPageNavigation.jsp" >
					<c:param name="numRec" value="${numRec}" />
					<c:param name="initPos" value="${initPos}" />
					<c:param name="pageSize" value="${pageSize}" />
					<c:param name="numPages" value="${numPages}" />
				</c:import>
				<% out.flush(); %>
				<%-- End Display navigation to next/previous page --%>

						</td>
					</tr>
					<tr>
						<td  valign="top" width="100%" class="topspace"	colspan="3" id="WC_RFQFindResultDisplay_TableCell_6"><br />
						<table cellpadding="0" cellspacing="0" border="0" width="100%"	class="bgColor" id="WC_RFQFindResultDisplay_Table_3">
							<tbody>
								<tr>
									<td id="WC_RFQFindResultDisplay_TableCell_7">
									<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQFindResultDisplay_Table_4">
										<tbody>
											<tr>
												<th id="a1" valign="top" class="colHeader" id="WC_RFQFindResultDisplay_TableCell_8"><fmt:message key="RFQFindResultDisplay_Name" bundle="${storeText}" /></th>
												<th id="a2" valign="top" class="colHeader" id="WC_RFQFindResultDisplay_TableCell_9"><fmt:message key="RFQFindResultDisplay_Description" bundle="${storeText}" /></th>
												<th id="a3" valign="top" class="colHeader" id="WC_RFQFindResultDisplay_TableCell_10"><fmt:message key="RFQFindResultDisplay_Status" bundle="${storeText}" /></th>
												<th id="a4" valign="top" class="colHeader" id="WC_RFQFindResultDisplay_TableCell_11"><fmt:message key="RFQFindResultDisplay_Create_Time" bundle="${storeText}" /></th>
												<th id="a5" valign="top" class="colHeader" id="WC_RFQFindResultDisplay_TableCell_12"><fmt:message key="RFQFindResultDisplay_Submit_Date" bundle="${storeText}" /></th>
												<th id="a6" valign="top" class="colHeader_last" id="WC_RFQFindResultDisplay_TableCell_13"><fmt:message key="RFQFindResultDisplay_Close_Date" bundle="${storeText}" /></th>
											</tr>
<!--iterate through rfq list-->
											<c:set var="color" value="cellBG_2" />
											<c:forEach var="rfqBean" items="${rlist}" begin="0" varStatus="iter">
											    <c:if test="${rfqBean.storeIdInEJBType eq storeId}">
												<c:set var="rfqBean" value="${rfqBean}" scope="request" />
											    
												<c:choose>
													<c:when test="${color == 'cellBG_1'}">
														<c:set var="color" value="cellBG_2" />
													</c:when>
													<c:when test="${color == 'cellBG_2'}">
														<c:set var="color" value="cellBG_1" />
													</c:when>
												</c:choose>
													<!-- format aBean for display -->
													<c:url var="RFQDisplayHref" value="RFQDisplay">
														<c:param name="offering_id" value="${rfqBean.rfqId}" />
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
													</c:url>	
												<tr class="<c:out value="${color}"/>">	
												<% out.flush(); %>											
												<c:import url="../CommonSection/RFQSetup.jsp" />
												<% out.flush(); %>
												   <td headers="a1" class="t_td" id="WC_RFQFindResultDisplay_TableCell_14_<c:out value="${iter.count}" />"><a href="<c:out value="${RFQDisplayHref}" />" id="WC_RFQFindResultDisplay_Link_4_<c:out value="${iter.count}" />"><c:out value="${rfqBean.name}" /></a></td>
												   <td headers="a2" class="t_td" id="WC_RFQFindResultDisplay_TableCell_15_<c:out value="${iter.count}" />"><c:out value="${rfqBean.description.shortDescription}" />&nbsp;</td>
												   <td headers="a3" class="t_td" id="WC_RFQFindResultDisplay_TableCell_16_<c:out value="${iter.count}" />"><c:out value="${rfq_state}" /></td>
												   <td headers="a4" class="t_td" id="WC_RFQFindResultDisplay_TableCell_17_<c:out value="${iter.count}" />"><c:out value="${rfq_create_date}" /><br /><c:out value="${rfq_create_time}" />&nbsp;</td>
												   <td headers="a5" class="t_td" id="WC_RFQFindResultDisplay_TableCell_18_<c:out value="${iter.count}" />"><c:out value="${rfq_activate_date}" /><br /><c:out value="${rfq_activate_time}" />&nbsp;</td>                  
												   <td headers="a6" class="t_td" id="WC_RFQFindResultDisplay_TableCell_19_<c:out value="${iter.count}" />"><c:out value="${rfq_close_date}" /><br /><c:out value="${rfq_close_time}" />&nbsp;</td>
											    	</tr>
											    </c:if>
											</c:forEach>							
<!-- end through rfq list -->
											<c:if test="${empty rlist}">
										        <tr class="cellBG_1">
										            <td  valign="top" colspan="6" class="categoryspace t_td" id="WC_RFQFindResultDisplay_TableCell_20"><fmt:message key="RFQFileResultDisplay_NoRFQ" bundle="${storeText}"/></td>
										        </tr>
											</c:if>
                                        </tbody>
                                    </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3" id="WC_RFQFindResultDisplay_TableCell_21">
                        <table cellpadding="0" cellspacing="0" id="WC_RFQFindResultDisplay_Table_11">
                            <tbody>
                                <tr>
                                
<!-- Start display for Search "Again" button -->
													<td height="41" id="WC_RFQFindResultDisplay_TableCell_22">
													<c:url var="RFQFindDisplayHref" value="RFQFindDisplay">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
													</c:url> 
													<a class="button"
														href="<c:out value="${RFQFindDisplayHref}" />"
														id="WC_RFQFindResultDisplay_Link_5"> &nbsp; 
														<fmt:message key="RFQFindResultDisplay_FindAgain" bundle="${storeText}" /> &nbsp; </a></td>
<!-- End display for Search "Find Again" button -->
													<td id="WC_RFQFindResultDisplay_TableCell_23">&nbsp;</td>
													<td id="WC_RFQFindResultDisplay_TableCell_24">&nbsp;</td>
												</tr>
										</tbody>
									</table>

									</td>
								</tr>
					</tbody>
			</table> 


<!--FINISH MAIN CONTENT-->
<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>





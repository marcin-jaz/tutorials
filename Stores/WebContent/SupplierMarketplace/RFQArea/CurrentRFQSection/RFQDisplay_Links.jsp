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
  * This JSP page displays links and buttons for the RFQ summary page.
  *
  * Elements:  
  * - Modify Display button
  * - Submit button
  * - Close button
  * - Responses List button
  * - Cancel button
  * - Create for Next Round button
  * - Create Duplicate RFQ button
  *
  * Imports:
  * - CommonSection/RFQ_LinksInclude.jsp
  *
  * Required parameters:
  * - rfq_offering_id
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
 
<%--
Precondition:
	rfqBean is setup in requestScope
--%>

<c:set var="systemRFQState"  value="${param.systemRFQState}" />
<% out.flush(); %>
<c:import url="../CommonSection/RFQ_LinksInclude.jsp" >
	<c:param name="rfq_offering_id" value="${param.rfq_offering_id}" />
	<c:param name="URL" value="${param.URL}" />	 
</c:import> 
<% out.flush(); %>

                      <table valign="top" cellpadding="0" cellspacing="0" border="0" id="WC_RFQDisplay_Table_33">
                            <tbody>
                                <tr>

								<c:if test="${systemRFQState eq '5'}">
								<!-- Start display for Search button No. 1 "RFQDisplay_Button_Modify" -->
									<td height="41" id="WC_RFQDisplay_TableCell_69">
										<a class="button" href="<c:out value="${RFQModifyDisplayHref}" />" id="WC_RFQDisplay_Link_11"> &nbsp; <fmt:message key="RFQDisplay_Button_Modify" bundle="${storeText}"/> &nbsp; 
										</a>
									</td>
								<!-- End display for Search button No.1 -->
									<td id="WC_RFQDisplay_TableCell_70">&nbsp;</td>
								<!-- Start display for Search button No. 2 "RFQDisplay_Button_Submit" -->
									<td height="41" id="WC_RFQDisplay_TableCell_71">
									<a class="button" href="<c:out value="${RFQSubmitHref}" />" id="WC_RFQListDisplay_Link_12"> &nbsp; <fmt:message key="RFQDisplay_Button_Submit" bundle="${storeText}"/></a></td>
								<!-- End display for Search button No. 2 -->
			                        <td id="WC_RFQDisplay_TableCell_72">&nbsp;</td>
								</c:if>
								
								
								<c:if test="${systemRFQState eq '1'}">
								<!-- Start display for Search button No. 3 "RFQDisplay_Button_Close" -->
										<td height="41" id="WC_RFQDisplay_TableCell_73">
										<a class="button" href="<c:out value="${RFQCloseHref}" />" id="WC_RFQListDisplay_Link_13" /><fmt:message key="RFQDisplay_Button_Close" bundle="${storeText}"/></a>
										</td>	
								<!-- End display for Search button No.3 -->
										<td id="WC_RFQDisplay_TableCell_74">&nbsp;</td>
								</c:if>	
								
								
								<c:if test="${systemRFQState eq '1' or systemRFQState eq '2' or systemRFQState eq '3' or systemRFQState eq '4'}">
								<!-- Start display for Search button No. 5 "RFQDisplay_Button_Responses" -->
										<td height="41" id="WC_RFQDisplay_TableCell_77">
										<a class="button" href="<c:out value="${RFQResponseListDisplayHref}" />" id="WC_RFQDisplay_Link_15"> &nbsp; <fmt:message key="RFQDisplay_Button_Responses" bundle="${storeText}"/> &nbsp; 
										</a>
										</td>
								<!-- End display for Search button No.5 -->
			                            <td id="WC_RFQDisplay_TableCell_78">&nbsp;</td>
								</c:if>
								
								<c:if test="${systemRFQState eq '1' or systemRFQState eq '5' or systemRFQState eq '3' or systemRFQState eq '6'}">
								<!-- Start display for Search button No. 6 "RFQDisplay_Button_Cancel" -->
										<td height="41" id="WC_RFQDisplay_TableCell_79">
										<a class="button" href="<c:out value="${RFQCancelHref}" />" id="WC_RFQDisplay_Link_16"> &nbsp; <fmt:message key="RFQDisplay_Button_Cancel" bundle="${storeText}"/> &nbsp; 
										</a>
										</td>
								<!-- End display for Search button No.6 -->
			                            <td id="WC_RFQDisplay_TableCell_80">&nbsp;</td>
								</c:if>
								<c:if test="${systemRFQState eq '3'}">
								<!-- Start display for Search button No. 7 "RFQDisplay_Button_NextRound" -->
										<td height="41" id="WC_RFQDisplay_TableCell_81">
										<a class="button" href="<c:out value="${RFQCreateForNextRoundDisplayHref}" />" id="WC_RFQDisplay_Link_17"> &nbsp; <fmt:message key="RFQDisplay_Button_NextRound" bundle="${storeText}"/> &nbsp; 
										</a>
										</td>
								<!-- End display for Search button No.7 -->
			                            <td id="WC_RFQDisplay_TableCell_82">&nbsp;</td>						
								</c:if>

								<%-- Shift button to next line if language is FR --%>
								<c:if test="${WCParam.langId eq '-2'}" >
								 
								</c:if>

								<!-- Start display for Search button No. 8 "RFQDisplay_Button_Duplicate" -->
										<td height="41" id="WC_RFQDisplay_TableCell_83">
										<a class="button" href="<c:out value="${RFQDuplicateDisplayHref}" />" id="WC_RFQDisplay_Link_18"> &nbsp; <fmt:message key="RFQDisplay_Button_Duplicate" bundle="${storeText}"/> &nbsp;
										</a>
										</td>
								<!-- End display for Search button No.8 -->
			                            <td id="WC_RFQDisplay_TableCell_84">&nbsp;</td>
                                </tr>
                            </tbody>
                        </table>


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
  * This JSP page displays fields for modifying RFQ Terms and Conditions.
  *
  * Elements:  
  * - Add button
  * - Save Changes button
  *
  * Imports:
  * - RFQModify_TCRow.jsp
  *
  * Required parameters:
  * - offering_id
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


 <%@ include file="RFQModifyConstants.jspf" %>
                    <tr>

                        <td  valign="top" class="topspace" id="WC_RFQModifyDisplay_TableCell_47"><br />

                        <form name="RFQModifyTCForm" action="RFQTCUpdate" method="post" id="RFQModifyTCForm">
                        <input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQModifyTCForm_1"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQModifyDisplay_FormInput_langId_In_RFQModifyTCForm_1"/>
						<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQModifyDisplay_FormInput_storeId_In_RFQModifyTCForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_FormInput_catalogId_In_RFQModifyTCForm_1"/>

                        <table cellpadding="0" cellspacing="0" border="0" id="WC_RFQModifyDisplay_Table_13">
							<tbody>
							<tr>
				    			<td class="header" background="<c:out value="${jspStoreImgDir}" />images/header_back.gif" id="WC_RFQModifyDisplay_TableCell_48"><fmt:message key="RFQModifyDisplay_TC" bundle="${storeText}"/></td>
							</tr>
							<tr>
				    			<td id="WC_RFQModifyDisplay_TableCell_49"><img src="<c:out value="${jspStoreImgDir}" />images/strip.gif" alt="" width="630" height="2" border="0"/></td>
								</tr>
							</tbody>
						</table>

						<br /><fmt:message key="RFQExtra_TC" bundle="${storeText}"/>
						<br />&nbsp;
                                    <table border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQModifyDisplay_Table_14">
                                        <tbody>
                                            <tr>
                                                <th id="b1" class="colHeader" id="WC_RFQModifyDisplay_TableCell_50"><fmt:message key="RFQModifyDisplay_TC" bundle="${storeText}"/></th>       
                                                <th id="b2" class="colHeader" id="WC_RFQModifyDisplay_TableCell_51"><fmt:message key="RFQModifyDisplay_Man" bundle="${storeText}"/></th>
						<th id="b3" class="colHeader" id="WC_RFQModifyDisplay_TableCell_52"><fmt:message key="RFQModifyDisplay_Change" bundle="${storeText}"/></th>
                                                <th id="b4" class="colHeader_last" id="WC_RFQModifyDisplay_TableCell_53">&nbsp;</th>
                                            </tr>


<!--iterate through comments-->
										<c:set var="color" value="cellBG_2" />
										<c:set var="commentsList" value="${commentsList}" scope="request" />
										<c:forEach var="comment" items="${commentsList}" begin="0" varStatus="iter">
										
											<c:choose>
												<c:when test="${color == 'cellBG_1'}">
													<c:set var="color" value="cellBG_2" />
												</c:when>
												<c:when test="${color == 'cellBG_2'}">
													<c:set var="color" value="cellBG_1" />
												</c:when>
											</c:choose>
											<%--
												include  RFQModify_TCRow.jsp 
												--%>																
											<tr class="<c:out value="${color}" />">
												<% out.flush(); %>
	                         								<c:import url="RFQModify_TCRow.jsp">
													<c:param name="index" value="${iter.index}" />
													
												</c:import>   
												<% out.flush(); %>                    
                                            </tr>                          
                                            <input type="hidden" name="numTC" value="<c:out value="${requestScope.numTC}" />" id="WC_RFQModifyDisplay_FormInput_numTC_In_RFQModifyTCForm_1"/>
    										<input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_RFQModifyDisplay_FormInput_URL_In_RFQModifyTCForm_1"/>
   
										</c:forEach>							
<!-- end iterate through comments -->
										<c:if test="${empty commentsList}">
										    <tr class="cellBG_1">
                                                <td  valign="top" colspan="4" class="categoryspace t_td" id="WC_RFQDisplay_TableCell_20"><fmt:message key="RFQDisplay_NoTC" bundle="${storeText}"/></td>
                                            </tr>
										</c:if>

                                        </tbody>
                                    </table>
                         			<input type="hidden" name="numTC" value="" id="WC_RFQModifyDisplay_FormInput_numTC_In_RFQModifyTCForm_1"/>
                        			<input type="hidden" name="URL" value="RFQModifyDisplay?" id="WC_RFQModifyDisplay_FormInput_URL_In_RFQModifyTCForm_1"/>
                        			</form>
                                    
                                    
                                    </td>
                                </tr>
                   <tr>
                        <td id="WC_RFQModifyDisplay_TableCell_59">
                        <table id="WC_RFQModifyDisplay_Table_19">
                            <tbody>
                                <tr>

<!-- Display Add TC button --> 
<td height="41" id="WC_RFQModifyDisplay_TableCell_60">
<a class="button" href="RFQModifyAddTCDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_8"> &nbsp; <fmt:message key="RFQModifyDisplay_AddTC" bundle="${storeText}"/> &nbsp; 
</a>
</td>
<!-- End display Add TC button -->



<td id="WC_RFQModifyDisplay_TableCell_61">&nbsp;</td>

<!-- Display "Save Change" button -->
<td height="41" id="WC_RFQModifyDisplay_TableCell_62">
<a class="button" href="javascript:submitUpdateTC(document.RFQModifyTCForm)" id="WC_RFQModifyDisplay_Link_9"> &nbsp;  <fmt:message key="RFQ_SAVE_CHANGES" bundle="${storeText}"/> &nbsp; 
</a>
</td>
<!-- End display "Save Change" button -->



                                </tr>
                                
                                
                                
                                
                            </tbody>
                        </table>
                        </td>
                    </tr>





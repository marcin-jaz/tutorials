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
  * This JSP page displays fields for modifying RFQ Attachments.
  *
  * Elements:  
  * - Add button
  * - Save Changes button
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

                        <td  valign="top" width="630" class="topspace" id="WC_RFQModifyDisplay_TableCell_30">

                        <form name="RFQModifyAttachmentForm" action="RFQAttachmentDescUpdate" method="post" id="RFQModifyAttachmentForm">

                        <br />
                   			<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQModifyDisplay_Table_5">
								<tr>
				    				<td class="header" background="<c:out value="${jspStoreImgDir}" />images/header_back.gif" id="WC_RFQModifyDisplay_TableCell_31"><fmt:message key="RFQModifyDisplay_RFQAttach" bundle="${storeText}"/></td>
								</tr>
								<tr>
				    				<td id="WC_RFQModifyDisplay_TableCell_32"><img src="<c:out value="${jspStoreImgDir}" />images/strip.gif" alt="" width="630" height="2" border="0"/></td>
								</tr>
							</table>

						<br /><fmt:message key="RFQExtra_Attach" bundle="${storeText}"/><br /><br />

                        <table cellpadding="0" cellspacing="0" border="0" width="630" class="bgColor" id="WC_RFQModifyDisplay_Table_6">
                                <tr>
                                    <td id="WC_RFQModifyDisplay_TableCell_33">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQModifyDisplay_Table_7">
                                            <tr>
						<th id="a1" valign="top" class="colHeader" id="WC_RFQModifyDisplay_TableCell_34"><fmt:message key="RFQModifyDisplay_RFQAttach_Attach" bundle="${storeText}"/></th>
						<th id="a2" valign="top" class="colHeader" id="WC_RFQModifyDisplay_TableCell_35"><fmt:message key="RFQModifyDisplay_RFQAttach_Desc" bundle="${storeText}"/> </th>
						<th id="a3" valign="top" class="colHeader" id="WC_RFQModifyDisplay_TableCell_36"><fmt:message key="RFQModifyDisplay_RFQAttach_Filesize" bundle="${storeText}"/></th>
						<th id="a4" valign="top" class="colHeader_last" id="WC_RFQModifyDisplay_TableCell_37"></th>
                                            </tr>

                                    	<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQModifyAttachmentForm_1"/>
                                    	<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQModifyDisplay_FormInput_langId_In_RFQModifyAttachmentForm_1"/>
                                    	<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQModifyDisplay_FormInput_storeId_In_RFQModifyAttachmentForm_1"/>
                                    	<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_FormInput_catalogId_In_RFQModifyAttachmentForm_1"/>

										
<wcbase:useBean id="attachmentList" classname="com.ibm.commerce.rfq.beans.RFQAttachmentListBean" >
<jsp:setProperty property="*" name="attachmentList" />
<c:set property="tradingId" value="${rfqId}" target="${attachmentList}" />
</wcbase:useBean>
	
<c:set var="attachments" value="${attachmentList.attachments}" />	
										
										
										
										<c:set var="count" value="0" />
										<!--iterate through attachments-->
										<c:set var="color" value="cellBG_2" />
										<c:forEach var="attachment" items="${attachments}" begin="0" varStatus="iter">
										
											<c:set var="index" value="${iter.index}" />
											<c:choose>
												<c:when test="${color == 'cellBG_1'}">
													<c:set var="color" value="cellBG_2" />
												</c:when>
												<c:when test="${color == 'cellBG_2'}">
													<c:set var="color" value="cellBG_1" />
												</c:when>
											</c:choose>
											<tr class="<c:out value="${color}" />">
                                                <td headers="a1" class="t_td" id="WC_RFQModifyDisplay_TableCell_38_<c:out value="${iter.count}" />">
                                                	<a href="RFQAttachmentView?<c:out value="${EC_ATTACH_ID}" />=<c:out value="${attachment.attachmentId}" />&amp;<c:out value="${EC_RFQ_REQUEST_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_2_<c:out value="${iter.count}" />">
                                                	<c:out value="${attachment.filename}" /></a>
                                                </td>
                                                <td headers="a2" class="t_td" id="WC_RFQModifyDisplay_TableCell_39_<c:out value="${iter.count}" />">


												<c:set var="attachmentOwnerId" value="${attachment.ownerIdInEJBType}"  />
												<c:choose>
												<c:when test="${attachmentOwnerId eq userId}">
												
													<input name="<c:out value="${EC_ATTACH_ID}" />_<c:out value="${iter.count}" />" type="hidden" value="<c:out value="${attachment.attachmentId}" />" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_ATTACH_ID}" />_<c:out value="${iter.count}" />_In_RFQModifyAttachmentForm_1"/>
													<label for="WC_RFQModify_Attachments_TextArea_1"></label>
													<textarea id="WC_RFQModify_Attachments_TextArea_1" rows="1" name="<c:out value="${EC_ATTACH_DESC}" />_<c:out value="${iter.count}" />"><c:out value="${attachment.description}" /></textarea>
													
												</c:when>
												<c:otherwise>
													<c:out value="${attachment.description}" />
												</c:otherwise>
												</c:choose>                                               
                                                
                                                
                                                </td>                             
                                                
                                                
                                                <td headers="a3" class="t_td" id="WC_RFQModifyDisplay_TableCell_40_<c:out value="${iter.count}" />"><c:out value="${attachment.filesize}" /></td>
                                                <td headers="a4" nowrap="nowrap" class="t_td" id="WC_RFQModifyDisplay_TableCell_41_<c:out value="${iter.count}" />">
													<a href="RFQAttachmentReplaceDisplay?<c:out value="${EC_ATTACH_ID}" />=<c:out value="${attachment.attachmentId}" />&amp;<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_3_<c:out value="${iter.count}" />"><fmt:message key="RFQModifyDisplay_RFQAttach_Replace" bundle="${storeText}"/></a><br />
													<a href="RFQAttachmentDelete?<c:out value="${EC_ATTACH_ID}" />=<c:out value="${attachment.attachmentId}" />&amp;<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;URL=RFQModifyDisplay" id="WC_RFQModifyDisplay_Link_4_<c:out value="${iter.count}" />"><fmt:message key="RFQModifyDisplay_RFQAttach_Remove" bundle="${storeText}"/></a>
								
											
												</td>
                                            </tr>
                                            <c:set var="count" value="${index + 1}" scope="request" />	
										</c:forEach>							
										<!-- end iterate through attachments -->
										<c:if test="${empty attachments}">
										    <tr class="cellBG_1">
                                                <td  valign="top" colspan="4" class="categoryspace t_td" id="WC_RFQDisplay_TableCell_11"><fmt:message key="RFQDisplay_NoAttachment" bundle="${storeText}"/></td>
                                            </tr>
										</c:if>
 										</table>

                                    </td>
                                </tr>
                        </table>
                        
                         <input type="hidden" name="numAttachment" value="<c:out value="${requestScope.count}" />" id="WC_RFQModifyDisplay_FormInput_numAttachment_In_RFQModifyAttachmentForm_1"/>
                         <input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_RFQModifyDisplay_FormInput_URL_In_RFQModifyAttachmentForm_1"/>
                        

                        </form>

                        </td>
                    </tr>

       <tr>
                        <td id="WC_RFQModifyDisplay_TableCell_43">

                        <table id="WC_RFQModifyDisplay_Table_12">
                            <tbody>
                                <tr>


<!-- Display Add Attachment button -->
<td height="41" id="WC_RFQModifyDisplay_TableCell_44">
<a class="button" href="RFQAttachmentAddDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_5"> &nbsp; <fmt:message key="RFQModifyDisplay_Add_Attach" bundle="${storeText}"/> &nbsp; 
</a>
</td>
<!-- End Display Add Attachment button -->



<c:if test="${!empty attachments}" >
                     <td id="WC_RFQModifyDisplay_TableCell_45">&nbsp;</td>

<!-- Start display for Search "Save Changes" button -->
<td height="41" id="WC_RFQModifyDisplay_TableCell_46">
<a class="button" href="javascript:submitUpdateAttachment(document.RFQModifyAttachmentForm)" id="WC_RFQModifyDisplay_Link_6"> &nbsp; <fmt:message key="RFQ_SAVE_CHANGES" bundle="${storeText}"/> &nbsp; 
</a>
</td>
<!-- End display for Search "Save Changes" button -->
</c:if>

                                </tr>
                            </tbody>
                        </table>

                        </td>
                    </tr>






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
  * This JSP page displays a list of RFQ responses.
  *
  * Imports:
  * - RFQResponseSetup.jsp
  * - RFQResponse_LinksInclude.jsp
  *
  * Required parameters:
  * - offering_id
  * - catalogId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQResponseConstants.jspf" %>

<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:set var="rfqId" value="${WCParam[EC_OFFERING_ID]}" />

<wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean" >
       <jsp:setProperty property="*" name="rfqBean"/>
       <c:set target="${rfqBean}" property="rfqId" value="${rfqId}" />      
</wcbase:useBean>

<c:set var="isContract" value="${rfqBean.endResultInEJBType eq EC_UTF_ENDRESULT_CONTRACT}" scope="request" />

<wcbase:useBean id="rfqResponseList" classname="com.ibm.commerce.rfq.beans.RFQResponseListBean" >
       <c:set target="${rfqResponseList}" property="rfqId" value="${rfqId}" />      
</wcbase:useBean> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>



<title><fmt:message key="RFQResponseListDisplay_Responses" bundle="${storeText}"/></title>
<link rel="stylesheet"       href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"       type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQResponseListDisplay_Table_1">
<tbody>
<tr>
       <td valign="top" width="630" id="WC_RFQResponseListDisplay_TableCell_2">

       <!--START MAIN CONTENT-->

              <table cellpadding="2" cellspacing="0" width="580" border="0"  id="WC_RFQResponseListDisplay_Table_2">
              <tbody>
              <tr>
                     <td width="10" rowspan="3" id="WC_RFQResponseListDisplay_TableCell_3">&nbsp;</td>
                     <td  valign="top" colspan="3" class="categoryspace" id="WC_RFQResponseListDisplay_TableCell_4">
                            <h1><fmt:message key="RFQResponseListDisplay_For" bundle="${storeText}"/>&nbsp;<c:out value="${rfqBean.name}" /></h1>

                            <c:if test="${rfqBean.stateInEJBType eq EC_STATE_ACTIVE}">
                                <fmt:message key="RFQ_RESPONSE_INSTRUCTION" bundle="${storeText}"/>
                            </c:if>

                     </td>
              </tr>
              <tr>
                     <td  valign="top" width="400" class="topspace" id="WC_RFQResponseListDisplay_TableCell_5">

                            <br />
                            <table cellpadding="0" cellspacing="0" border="0" width="670" class="bgColor" id="WC_RFQResponseListDisplay_Table_3">
                            <tbody><tr>
                                   <td id="WC_RFQResponseListDisplay_TableCell_6">
                                          <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQResponseListDisplay_Table_4">
                                          <tr>
                                                 <th id="a1" valign="top" <c:out value="${requestScope.wrap}" />" class="colHeader" id="WC_RFQResponseListDisplay_TableCell_7"><fmt:message key="RFQResponseListDisplay_Name" bundle="${storeText}"/></th>
                                                 <th id="a2" valign="top" <c:out value="${requestScope.wrap}" />" class="colHeader" id="WC_RFQResponseListDisplay_TableCell_8"><fmt:message key="RFQResponseListDisplay_Status" bundle="${storeText}"/></th>
                                                 <th id="a3" valign="top" <c:out value="${requestScope.wrap}" />" class="colHeader" id="WC_RFQResponseListDisplay_TableCell_9"><fmt:message key="RFQResponseListDisplay_CreateTime" bundle="${storeText}"/></th>
                                                 <th id="a4" valign="top" <c:out value="${requestScope.wrap}" />" class="colHeader_last" id="WC_RFQResponseListDisplay_TableCell_10"><fmt:message key="RFQResponseListDisplay_Attachment" bundle="${storeText}"/></th>
                                     	<c:if test="${requestScope.responseState eq RFQ_EC_RESPONSE_STATE_IN_EVALUATION or requestScope.responseState eq RFQ_EC_RESPONSE_STATE_WON}" >
                                                 <th id="a5" valign="top" <c:out value="${requestScope.wrap}" />" class="colHeader_last" id="WC_RFQResponseListDisplay_TableCell_11">&nbsp;</th>
                                       	</c:if>
                                          </tr>
<!--iterate through responses-->

                                          <c:set var="responses" value="${rfqResponseList.responses}" />
                                          <c:set var="color" value="cellBG_2" />
                                          <c:set var="rfqRes" scope="request" />
                                          
                                          <c:forEach var="rfqRes" items="${responses}" begin="0" varStatus="iter">
                                                 <c:set var="rfqRes" value="${rfqRes}" scope="request" />
                                                 <%--
                                                        setup response state
                                                 --%>
						<% out.flush(); %>
                                                 <c:import url="RFQResponseSetup.jsp" />
						<% out.flush(); %>
                                                 <c:set var="resId" value="${rfqRes.rfqResponseId}" />
                                                 <c:set var="rfqRes_create_date"  />
                                                 <c:set var="rfqRes_create_time"  />
                                                 <c:if test="${rfqRes.createTimeInEJBType != null}">
                                                        <fmt:formatDate value="${rfqRes.createTimeInEJBType}" type="date" dateStyle="short" 
                                                                          var="rfqRes_create_date" />
                                                        <fmt:formatDate value="${rfqRes.createTimeInEJBType}" type="time" timeStyle="short"
                                                                   var="rfqRes_create_time" />
                                                 </c:if>
                                                 <c:choose>
                                                        <c:when test="${color == 'cellBG_1'}">
                                                               <c:set var="color" value="cellBG_2" />
                                                        </c:when>
                                                        <c:when test="${color == 'cellBG_2'}">
                                                               <c:set var="color" value="cellBG_1" />
                                                        </c:when>
                                                 </c:choose>
                                                 <%--import links --%>
						<% out.flush(); %>
                                                 <c:import url="RFQResponse_LinksInclude.jsp">
                                                        <c:param name="rfq_offering_id" value="${rfqId}" />
                                                        <c:param name="resId" value="${resId}" />
                                                 </c:import>
						<% out.flush(); %>
                                                 <%-- Display --%>
                                                 <tr>
                                                        <td headers="a1" <c:out value="${requestScope.wrap}" /> class="<c:out value="${color}" /> t_td" id="WC_RFQResponseListDisplay_TableCell_12_<c:out value="${iter.count}" />"><a href="<c:out value="${requestScope.RFQResponseDisplayHref}" />" id="WC_RFQResponseListDisplay_Link_1_<c:out value="${iter.count}" />"><c:out value="${rfqRes.name}" /></a></td>
                                                        <td headers="a2" <c:out value="${requestScope.wrap}" /> class="<c:out value="${color}" /> t_td" id="WC_RFQResponseListDisplay_TableCell_13_<c:out value="${iter.count}" />"><c:out value="${requestScope.responseState}" /></td>
                                                        <td headers="a3" <c:out value="${requestScope.wrap}" /> class="<c:out value="${color}" /> t_td" id="WC_RFQResponseListDisplay_TableCell_14_<c:out value="${iter.count}" />"><c:out value="${rfqRes_create_date} ${rfqRes_create_time}" /></td>
                                                                                                                
                                                        <wcbase:useBean id="attachmentList" classname="com.ibm.commerce.rfq.beans.RFQAttachmentListBean" >
                                                               <jsp:setProperty property="*" name="attachmentList" />
                                                               <c:set property="tradingId" value="${resId}" target="${attachmentList}" />
                                                        </wcbase:useBean>
                                                              
                                                        <c:set var="attachments" value="${attachmentList.attachments}" />
                                                                                                         
                                                        
                                <c:choose>
                                                               <c:when test="${!empty attachments}" >
                                                                      <td headers="a4" <c:out value="${requestScope.wrap}" /> class="<c:out value="${color}" /> t_td" id="WC_RFQResponseListDisplay_TableCell_15_<c:out value="${iter.count}" />"><fmt:message key="RFQResponseListDisplay_Yes" bundle="${storeText}"/></td>
                                                               </c:when>
                                                               <c:otherwise>
                                                                      <td headers="a4" <c:out value="${requestScope.wrap}" /> class="<c:out value="${color}" /> t_td" id="WC_RFQResponseListDisplay_TableCell_16_<c:out value="${iter.count}" />"><fmt:message key="RFQResponseListDisplay_No" bundle="${storeText}"/></td>
                                                               </c:otherwise>
                                                        </c:choose>
                                                        
                                                        <c:choose>
                                             			<c:when test="${requestScope.rfqRes.stateInEJBType eq RFQ_EC_RESPONSE_STATE_IN_EVALUATION }">
                                                                          <td headers="a5" nowrap="nowrap" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseListDisplay_TableCell_17_<c:out value="${iter.count}" />">
                                                                                                                                                          
                                                                             
                                                                             <a href="<c:out value="${requestScope.RFQAcceptResponseHref}" />" class="t_button" id="WC_RFQResponseListDisplay_Link_2_<c:out value="${iter.count}" />"><fmt:message key="RFQResponseListDisplay_AcceptAll" bundle="${storeText}"/></a>       
                                                                             
                                                                             <c:if test="${rfqRes.acceptactionInEJBType != RFQ_EC_RESPONSE_ACCEPTACTION_ALL }">
                                                                             
                                                                                                                                            
                                                                             
                                                                                    <br /><a href="<c:out value="${requestScope.RFQResponseAcceptSomeProductDisplayHref}" />" class="t_button" id="WC_RFQResponseListDisplay_Link_3_<c:out value="${iter.count}" />"><fmt:message key="RFQExtra_ReviewProd" bundle="${storeText}"/></a>
                                                                             </c:if>
                                                                             <br /><a href="<c:out value="${requestScope.RFQRejectResponseHref}" />" class="t_button" id="WC_RFQResponseListDisplay_Link_4_<c:out value="${iter.count}" />"><fmt:message key="RFQResponseListDisplay_RejectAll" bundle="${storeText}"/></a>
                                                                             </td>
                                                               	</c:when> 
                                                               	<c:when test="${requestScope.rfqRes.stateInEJBType eq RFQ_EC_RESPONSE_STATE_WON }">
                                                                          <td headers="a5" nowrap="nowrap" class="<c:out value="${color}" /> t_td" id="WC_RFQResponseListDisplay_TableCell_18_<c:out value="${iter.count}" />">
                                                                          <c:choose>
                                                                                 <c:when test="${isContract}">
                                                                                        <a href="<c:out value="${requestScope.RFQCompleteContractDisplayHref}" />" class="t_button" id="WC_RFQResponseListDisplay_Link_6_<c:out value="${iter.count}" />"><fmt:message key="RFQDisplay_Complete" bundle="${storeText}"/></a>
                                                                                 </c:when>
                                                                                 <c:otherwise>
                                                                                        <a href="RFQCompleteOrderDisplay?offering_id=<c:out value="${rfqId}" />&response_id=<c:out value="${resId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&URL=RFQResponseListDisplay" class="t_button" id="WC_RFQResponseListDisplay_Link_5_<c:out value="${iter.count}" />"><fmt:message key="RFQDisplay_Complete" bundle="${storeText}"/></a>
                                                                                 </c:otherwise>
                                                                          </c:choose>
                                                                          </td> 
                                                               	</c:when>                           
                                                               	<c:otherwise>                                                                                                                             
                                                               	</c:otherwise>
                                                        </c:choose>  
                                                                                                                                    
                            			</tr>
                            <c:remove var="rfqRes" scope="request" />
                            <c:remove var="rfqRes_create_date" />
                            <c:remove var="rfqRes_create_time" />
                            <c:remove var="attachments"/>
                            <c:remove var="attachmentList"/>                            
                                          </c:forEach>                                                 
<!-- end iterate through responses -->
                                          <c:if test="${empty responses}">
                                                 <tr class="cellBG_1">
                                                        <td  valign="top" colspan="8" class="categoryspace t_td" id="WC_RFQResponseListDisplay_TableCell_20"> <fmt:message key="RFQResponseListDisplay_NoRes" bundle="${storeText}"/>
                                                        </td>
                                                 </tr>
                                          </c:if>

                                          </table>
                                   </td>
                            </tr>
                            </tbody></table>
                     </td>
              </tr>
              
<c:url var="RFQDisplayHref" value="RFQDisplay" >
       <c:param name="${EC_OFFERING_ID}" value="${rfqId}" />
       <c:param name="langId" value="${langId}" />
       <c:param name="storeId" value="${storeId}" />
       <c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="RFQCloseHref" value="RFQClose" >
       <c:param name="${EC_OFFERING_ID}" value="${rfqId}" />
       <c:param name="URL" value="RFQResponseListDisplay" />
       <c:param name="langId" value="${langId}" />
       <c:param name="storeId" value="${storeId}" />
       <c:param name="catalogId" value="${catalogId}" />
</c:url>
                    <tr>
                        <td id="WC_RFQResponseListDisplay_TableCell_21">
                        <table cellpadding="0" cellspacing="0" border="0" id="WC_RFQResponseListDisplay_Table_10">
                            <tbody>
                                <tr>
                                <c:if test="${rfqBean.stateInEJBType eq EC_STATE_ACTIVE}" >
                                       <!-- Start display for Search button "RFQDisplay_Button_Close" -->
                                                        <td height="41" id="WC_RFQResponseListDisplay_TableCell_22">
                                                        <a class="button" href="<c:out value="${RFQCloseHref}" />" id="WC_RFQResponseListDisplay_Link_7"> &nbsp; <fmt:message key="RFQDisplay_Button_Close" bundle="${storeText}"/> &nbsp; 
                                                        </a>
                                                       </td>
                                                        <!-- End display for Search button -->
                                    <td id="WC_RFQResponseListDisplay_TableCell_23">&nbsp;</td>
                                </c:if>
                                                        <!-- Start display for Search button "RFQModifyDisplay_Return" -->
                                                        <td height="41" id="WC_RFQResponseListDisplay_TableCell_24">
                                                        <a class="button" href="<c:out value="${RFQDisplayHref}" />" id="WC_RFQResponseListDisplay_Link_8"><fmt:message key="RFQModifyDisplay_Return" bundle="${storeText}"/>
                                                        </a>
                                                        </td>
                                                        <!-- End display for Search button -->

                                    <td id="WC_RFQResponseListDisplay_TableCell_25">&nbsp;</td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQResponseListDisplay_TableCell_26">&nbsp;</td>
                    </tr>
       </tbody>
       </table>

<!--FINISH MAIN CONTENT-->

       </td>
</tr>
</tbody>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
                                          
                                          


<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
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
  * This JSP page is used to create a new RFQ.
  *
  * Elements:  
  *  - general RFQ information input fields
  *  - category percentage price adjustment section
  *    or product price adjustment section
  *  - Create button
  *  - Cancel button
  *
  * Imports:
  * - RFQCreateDisplay_javascript.jsp
  * - RFQCreateDisplay_Info.jsp
  * - RFQCreateDisplay_ItemTable.jsp
  * - RFQCreateDisplay_ProductTable.jsp
  * - RFQCreateDisplay_Order_to_RFQ_Table.jsp
  * - RFQCreateDisplay_CategoryAdjustment.jsp
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

  
<%@ include file="RFQCreateConstants.jspf" %>

<c:set var="catentry_id" value="${WCParam[RFQ_EC_OFFERING_CATENTRYID]}" scope="request" />
<c:set var="orderId" value="${WCParam.orderId}" scope="request" />
<c:set var="productId" value="${WCParam.productId}" scope="request" />
<c:set var="categoryId" value="${WCParam.categoryId}" scope="request" />

<c:if test="${catentry_id == null}" ><c:set var="catentry_id" value="" /></c:if>
<c:if test="${orderId == null}" ><c:set var="orderId" value="" /></c:if>
<c:if test="${productId == null}" ><c:set var="productId" value="" /></c:if>

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>
<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" scope="request"/>
</c:if>

<c:if test="${! multiSeller}">
       <wcbase:useBean id="acctList" classname="com.ibm.commerce.payment.beans.EligibleAccountListDataBean">
             
       </wcbase:useBean>
       
       <c:set var="accountid" value="${acctList.accountIdForLowestOrgEntity}" />
                            
</c:if>

<c:if test="${accountid == null}" >
       <c:set var="accountid" value="" />
</c:if>	       

       <c:choose>
       <c:when test="${WCParam.endresult eq '0' and accountid != ''}">
              <c:set var="isOrder" value="0"  scope="request" />
       </c:when>
       <c:otherwise>  
              <c:set var="isOrder" value="1" scope="request" />
       </c:otherwise>
       </c:choose>

<c:choose>
       <c:when test="${bnError.exceptionType != null}" >
              <c:set var="strRFQname" value="${param[EC_OFFERING_NAME]}" />
              <c:set var="strShortDesc" value="${param[EC_OFFERING_SHORTDESC]}" />
              <c:set var="strLongDesc" value="${param[EC_OFFERING_LONGDESC]}" />
              <c:set var="isOrder" value="${param[EC_OFFERING_ENDRESULT]}" />
              <c:set var="strBeginYr" value="${param.beginYr}" />
              <c:set var="strBeginMon" value="${param.beginMon}" />
              <c:set var="strBeginDay" value="${param.beginDay}" />
              <c:set var="strBeginTime" value="${param.starttime}" />
              <c:set var="strEndYr" value="${param.endYr}" />
              <c:set var="strEndMon" value="${param.endMon}" />
              <c:set var="strEndDay" value="${param.endDay}" />
              <c:set var="strEndTime" value="${param.endtime}" />
              <c:set var="catentryid" value="${RFQ_EC_OFFERING_CATENTRYID}_1" />              
              <c:set var="catentry_id" value="${requestScope.catentry_id}" scope="request" /> 
              <c:set var="orderId" value="${requestScope.orderId}" scope="request" />
			  <c:set var="productId" value="${requestScope.productId}" scope="request" />
			  <c:set var="categoryId" value="${requestScope.categoryId}" scope="request" />
       </c:when>
       <c:otherwise>
       
              <c:set var="strRFQname" value="" />
              <c:set var="strShortDesc" value="" />
              <c:set var="strLongDesc" value="" />
              <c:set var="strBeginYr" value="" />
              <c:set var="strBeginMon" value="" />
              <c:set var="strBeginDay" value="" />       
              <c:set var="strEndYr" value="" />       
              <c:set var="strEndMon" value="" />              
              <c:set var="strEndDay" value="" />       
              <c:set var="strBeginTime" value="hh:mm" />
              <c:set var="strEndTime" value="hh:mm" />

       </c:otherwise>
</c:choose>

<c:if test="${catentry_id == null}" ><c:set var="catentry_id" value="" /></c:if>
<c:if test="${orderId == null}" ><c:set var="orderId" value="" /></c:if>
<c:if test="${productId == null}" ><c:set var="productId" value="" /></c:if>
 
<c:set var="defaultCurrency" value="${sdb.storeDefaultCurrency}" scope="page" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQCreateDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"       type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio" />

   <c:choose>
	<c:when test="${langId <= -7 and langId >= -10}">
		<c:set var="wrap" value="nowrap=\"nowrap\"" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise> 
    </c:choose>  

<% out.flush(); %>
<c:import url="RFQCreateDisplay_javascript.jsp" >
<c:param name="orderId" value="${orderId}" />
       <c:param name="productId" value="${productId}" />
       <c:param name="catentry_id" value="${catentry_id}" />
       <c:param name="categoryId" value="${categoryId}" />
       <c:param name="accountid" value="${accountid}" />
       <c:param name="multiSeller" value="${multiSeller}" />        
</c:import>
<% out.flush(); %>
</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
       <c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

            <!--MAIN CONTENT STARTS HERE-->

                <form name="RFQForm" method="post" action="RFQCreate" id="RFQForm">
                <input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQCreateDisplay_FormInput_storeId_In_RFQForm_1"/>
                <input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQCreateDisplay_FormInput_langId_In_RFQForm_1"/>
                <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQCreateDisplay_FormInput_catalogId_In_RFQForm_1"/>
                <input type="hidden" name="orderId" value="<c:out value="${orderId}" />" /> 
                            
                <table border="0" width="820"  id="WC_RFQCreateDisplay_Table_1">
 
                    <tbody>
                                               <% out.flush(); %>  
						<c:import url="RFQCreateDisplay_Info.jsp" >
                                                        <c:param name="strErrorMessage" value="${strErrorMessage}" />
                                                        <c:param name="multiSeller" value="${multiSeller}" />
                                                        <c:param name="accountid" value="${accountid}" />
                                                        <c:param name="strRFQname" value="${strRFQname}" />
                                                        <c:param name="strShortDesc" value="${strShortDesc}" />                                                        
                                                        <c:param name="strLongDesc" value="${strLongDesc}" />
                                                        <c:param name="isOrder" value="${isOrder}" />
                                                        <c:param name="strBeginMon" value="${strBeginMon}" />
                                                        <c:param name="strBeginYr" value="${strBeginYr}" />                                                        
                                                        <c:param name="strBeginDay" value="${strBeginDay}" />
                                                        <c:param name="strBeginTime" value="${strBeginTime}" />
                                                        <c:param name="strEndMon" value="${strEndMon}" />
                                                        <c:param name="strEndYr" value="${strEndYr}" />
                                                        <c:param name="strEndDay" value="${strEndDay}" />                                                        
                                                        <c:param name="strEndTime" value="${strEndTime}" />                                                               
                                                 </c:import>              
						<% out.flush(); %>

                    </tbody>
               </table>
                       </td>
                   </tr>
<!-- Start item price adjustment section -->
					
                         <c:if test="${catentry_id != '' and orderId == '' and productId == ''}" >
                               
                                 <tr>
                                               <td id="WC_RFQCreateDisplay_TableCell_1">
								<% out.flush(); %>
                                               			<c:import url="RFQCreateDisplay_ItemTable.jsp" >
                                                                      <c:param name="catentry_id" value="${catentry_id}" />
                                                                      <c:param name="defaultCurrency" value="${pageScope.defaultCurrency}" />
                                                                </c:import>
								<% out.flush(); %>
                                                        </td>
                                 </tr> 
                          </c:if>
                        
<!-- end item price adjustment section -->
<!-- Start Product price adjustment section -->
                          <c:if test="${productId != '' and accountid != ''}" >                          
                                 
                                  <tr>
                                        <td id="WC_RFQCreateDisplay_TableCell_2">
							<% out.flush(); %>
                                         		<c:import url="RFQCreateDisplay_ProductTable.jsp" >
                                                               <c:param name="defaultCurrency" value="${pageScope.defaultCurrency}" />
                                                               <c:param name="productId" value="${param.productId}" />
                                                        </c:import>
							<% out.flush(); %>
                                                 </td>
                                 </tr> 
                          </c:if>
<!-- end Product price adjustment section -->
                   <!-- Start Order-to-RFQ price adjustment section -->
                       <c:if test="${orderId != ''}" >
                                  
                                  <tr>
                                        <td id="WC_RFQCreateDisplay_TableCell_3">
							<% out.flush(); %>
                                         		<c:import url="RFQCreateDisplay_Order_to_RFQ_Table.jsp" >
                                                               <c:param name="defaultCurrency" value="${pageScope.defaultCurrency}" />
                                                               <c:param name="orderId" value="${param.orderId}" />
                                                        </c:import>
							<% out.flush(); %>
                                                 </td>
                                 </tr>
                          </c:if>     
<!-- End Order-to-RFQ price adjustment section --> 
                                                <tr>
                         <td id="WC_RFQCreateDisplay_TableCell_4"><br />                
                             <table id="WC_RFQCreateDisplay_Table_2">
                             <tbody>
                             <tr>
<!-- Start Category price adjustment section -->
                             <c:if test="${param.categoryId != null and param.categoryId != '' and accountid != null and accountid != ''}" >
                                       
                                        <tr>
                                                        <td  valign="top" width="400" class="topspace" id="WC_RFQCreateDisplay_TableCell_28"><br />
								<% out.flush(); %>
                                                		<c:import url="RFQCreateDisplay_CategoryAdjustment.jsp" >
                                                                      <c:param name="categoryId" value="${categoryId}" />
                                                                      <c:param name="catentry_id" value="${catentry_id}" />
                                                                </c:import>
								<% out.flush(); %>
                                                        </td>
                                        </tr>
                                 </c:if>    
<!-- End Category price adjustment section --> 

                                                        <td height="41" id="WC_RFQCreateDisplay_TableCell_5">
                                                        <!-- Start display for Search "Create" button -->
                                                        <a class="button" href="javascript:document.RFQForm.<c:out value="${EC_OFFERING_STARTDATE}" />.value=getValueFromSelection(document.RFQForm.beginYr)+'-'+getValueFromSelection(document.RFQForm.beginMon)+'-'+getValueFromSelection(document.RFQForm.beginDay);document.RFQForm.<c:out value="${EC_OFFERING_ENDDATE}" />.value=getValueFromSelection(document.RFQForm.endYr)+'-'+getValueFromSelection(document.RFQForm.endMon)+'-'+getValueFromSelection(document.RFQForm.endDay);submitCreate(document.RFQForm)"> &nbsp; <fmt:message key="RFQCreateDisplay_Create" bundle="${storeText}" /> &nbsp; 
                                                        </a>&nbsp;
                                                        <!-- End display for Search "Create" button -->
                                                        <!-- Start display for Search "Cancel" button -->
                                                                      <c:url var="RFQListDisplayHref" value="RFQListDisplay">
                                                                             <c:param name="langId" value="${langId}" />
                                                                             <c:param name="storeId" value="${storeId}" />
                                                                             <c:param name="catalogId" value="${catalogId}" />
                                                                      </c:url>
                                                        <a class="button" href="<c:out value="${RFQListDisplayHref}" />" id="WC_RFQCreateDisplay_Link_1">&nbsp;<fmt:message key="RFQCreateDisplay_Cancel" bundle="${storeText}" />&nbsp; 
                                                        </a>
                                                        <!-- End display for Search "Cancel" button -->
                                                        </td>
<%--end display links--%>              
                                                        
                                                        <td id="WC_RFQCreateDisplay_TableCell_7">&nbsp;</td>

                                 </tr>
                                  </tbody>
                                 </table>

                       </td>
                    </tr>
                    <tr><td id="WC_RFQCreateDisplay_TableCell_9">&nbsp;</td></tr>

                    </tbody>
                </table>
                <input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_RFQCreateDisplay_FormInput_URL_In_RFQForm_1"/>
                   </form>
                     <!--content end-->
           

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html> 

<c:if test="${(! multiSeller) && (accountid eq '') && ((categoryId != null && categoryId != '') || productId != '')}" >
<script>
	alert("<fmt:message key="RFQCreateDisplay_Error6" bundle="${storeText}" />");
</script>
</c:if>	
                            
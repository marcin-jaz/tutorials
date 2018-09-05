<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%> 
<%--
  *****
  * This JSP page displays summary information about the RFQ.
  *
  * Elements:  
  *  - general RFQ information
  *  - attachments 
  *  - terms and conditions
  *  - category percentage price adjustments
  *  - RFQ categories
  *  - product adjustments
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - RFQDisplay_Setup.jsp
  * - RFQDisplay_TCRow.jsp
  * - RFQDisplay_PriceAdjustment_Row.jsp
  * - RFQDisplay_Product.jsp
  * - RFQDisplay_TargetList.jsp
  * - RFQDisplay_Links.jsp
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>

<c:if test="${bnError.exceptionType != null}">
       <c:set var="strErrorMessage" value="${bnError.message}" />
</c:if>

    <c:choose>
	<c:when test="${langId <= -7 and langId >= -10}">
		<c:set var="wrap" value="nowrap=\"nowrap\"" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise>
    </c:choose> 


<title><fmt:message key="RFQDisplay_Title" bundle="${storeText}"/></title>
<link rel="stylesheet"       href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />

<script language="javascript">
       function view(attachment_id) 
       {
              window.open("RFQAttachmentView?attachment_id=" + attachment_id + "&request_id=<c:out value="${offeringId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />");
       }
 
</script>
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

</head>
<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<c:set var="offeringId" value="${WCParam.offering_id}" scope="request" />

<wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean" scope="request">
       <jsp:setProperty property="*" name="rfqBean"/>
       <c:set property="rfqId" value="${offeringId}" target="${rfqBean}" />
</wcbase:useBean>
<% out.flush(); %>
<c:import url="../CommonSection/RFQSetup.jsp" /> 
<% out.flush(); %>
<% out.flush(); %>
<c:import url="RFQDisplay_Setup.jsp" />       
<% out.flush(); %>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQDisplay_Table_1">
    <tbody> 
        <tr valign="top"> 
            <!--START MAIN CONTENT--> 
       <td valign="top" id="WC_RFQDisplay_TableCell_2">
        <table cellpadding="2" cellspacing="0" width="1200" border="0"  id="WC_RFQDisplay_Table_2">
              <tbody>
                      <tr>
                        <td rowspan="11" id="WC_RFQDisplay_TableCell_3">&nbsp;</td>
                        <td width="630"  valign="top" colspan="3" class="categoryspace" id="WC_RFQDisplay_TableCell_4">
                               <h1><fmt:message key="RFQDisplay_Summary" bundle="${storeText}"/></h1>
       <c:if test="${strErrorMessage != null}">
                                <span class="warning"><c:out value="${strErrorMessage}" /></span><br />
                               <br />
       </c:if>
                               <h2><fmt:message key="RFQDisplay_GenInfo" bundle="${storeText}"/></h2>
                               <fmt:message key="RFQDisplay_Name" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqBean.name}" /><br />
                               <fmt:message key="RFQDisplay_SD" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqBean.description.shortDescription}" /><br />
                               <fmt:message key="RFQDisplay_LD" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqBean.description.longDescription}" /><br />                        
                               <fmt:message key="RFQDisplay_Status" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfq_state}" /><br />
                               
       <c:if test="${has_previous_off}" >
              <c:url var="RFQDisplayPrevHref" value="RFQDisplay">
                     <c:param name="offering_id" value="${previous_off_id}" />
                     <c:param name="langId" value="${langId}" />
                     <c:param name="storeId" value="${storeId}" />
                     <c:param name="catalogId" value="${catalogId}" />
              </c:url>
                             <fmt:message key="RFQDisplay_ViewPrevRound" bundle="${storeText}"/>&nbsp;&nbsp;<a href="<c:out value="${RFQDisplayPrevHref}" />" id="WC_RFQDisplay_Link_1"><c:out value="${previous_off_name}" /></a><br />
       </c:if>
 
           <c:if test="${has_next_off}" >
              <c:url var="RFQDisplayPrevHref" value="RFQDisplay">
                     <c:param name="offering_id" value="${next_off_id}" />
                     <c:param name="langId" value="${langId}" />
                     <c:param name="storeId" value="${storeId}" />
                     <c:param name="catalogId" value="${catalogId}" />
              </c:url>
                              <fmt:message key="RFQDisplay_ViewNextRound" bundle="${storeText}"/>&nbsp;&nbsp;<a href="<c:out value="${RFQDisplayPrevHref}" />" id="WC_RFQDisplay_Link_2" ><c:out value="${next_off_name}" /></a><br />
       </c:if>
                                   
       <c:choose>
              <c:when test="${isContract}" >
                            <fmt:message key="RFQDisplay_Result" bundle="${storeText}"/>&nbsp;&nbsp;<fmt:message key="RFQDisplay_Contract" bundle="${storeText}"/><p></p>
              </c:when>
              <c:otherwise>
                            <fmt:message key="RFQDisplay_Result" bundle="${storeText}"/>&nbsp;&nbsp;<fmt:message key="RFQDisplay_Order" bundle="${storeText}"/><p></p>
              </c:otherwise>
       </c:choose>
                
                               <h2><fmt:message key="RFQDisplay_Duration" bundle="${storeText}"/></h2>
                               <fmt:message key="RFQDisplay_Start" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfq_start_date} ${rfq_start_time}"/><br />
             <c:if test="${multiSeller}">
                                  <fmt:message key="RFQDisplay_CloseRule" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${closeRule}"/><br />
        </c:if>

                               <fmt:message key="RFQDisplay_End" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfq_end_date} ${rfq_end_time}"/><br />
        <c:if test="${multiSeller}">
                               <fmt:message key="RFQDisplay_MinResponse" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${rfqBean.numOfResponsesInEJBType}"/><p></p>
        </c:if>
                             </td>
                    </tr>

                    <tr>
                        <td  valign="top" width="400" class="topspace" id="WC_RFQDisplay_TableCell_5">
                               <h2><fmt:message key="RFQDisplay_Attachment" bundle="${storeText}"/></h2>

                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQDisplay_Table_3">
                        <tbody>
                                <tr>
                                           <td id="WC_RFQDisplay_TableCell_6">
                                           <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQDisplay_Table_4">
                                        	<tbody>
                                                   <tr>
                                                       <th id="a1" class="colHeader" id="WC_RFQDisplay_TableCell_7"><fmt:message key="RFQDisplay_Attachment_Desc" bundle="${storeText}"/></th>
                                                       <th id="a2" class="colHeader_last" id="WC_RFQDisplay_TableCell_8"><fmt:message key="RFQDisplay_Attachment_Attachment" bundle="${storeText}"/></th>
                                                   </tr>

       <wcbase:useBean id="attachmentList" classname="com.ibm.commerce.rfq.beans.RFQAttachmentListBean" >
              <jsp:setProperty property="*" name="attachmentList" />
              <c:set property="tradingId" value="${offeringId}" target="${attachmentList}" />
       </wcbase:useBean>
       <c:set var="attachments" value="${attachmentList.attachments}" />

       <!--iterate through attachments-->
       <c:set var="color" value="cellBG_2" />
       <c:forEach var="attachment" items="${attachments}" begin="0" varStatus="iter">
              <c:choose>
                     <c:when test="${color == 'cellBG_1'}">
                            <c:set var="color" value="cellBG_2" />
                     </c:when>
                     <c:when test="${color == 'cellBG_2'}">
                            <c:set var="color" value="cellBG_1" />
                     </c:when>
              </c:choose>
                                          <tr class="<c:out value="${color}" />">
                                                       <td headers="a1" class="t_td" id="WC_RFQDisplay_TableCell_9_<c:out value="${iter.count}" />"><c:out value="${attachment.description}" /></td>
                                                       <td headers="a2" class="t_td" id="WC_RFQDisplay_TableCell_10_<c:out value="${iter.count}" />"><a href="javascript:view('<c:out value="${attachment.attachmentId}" />');" id="WC_RFQDisplay_Link_3_<c:out value="${iter.count}" />"><c:out value="${attachment.filename}" /></a></td>
                                                   </tr>
       </c:forEach>                                                 
       <!-- end iterate through attachments -->
       
       <c:if test="${empty attachments}">
                                              <tr class="cellBG_1">
                                                       <td  valign="top" colspan="2" class="categoryspace t_td" id="WC_RFQDisplay_TableCell_11"><fmt:message key="RFQDisplay_NoAttachment" bundle="${storeText}"/></td>
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
                        <td  valign="top" width="400" class="topspace" id="WC_RFQDisplay_TableCell_12">
                        <h2><fmt:message key="RFQDisplay_TC" bundle="${storeText}"/></h2>

                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQDisplay_Table_7">
                        <tbody>
                               <tr>
                                   <td id="WC_RFQDisplay_TableCell_13">
                                     <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQDisplay_Table_8">
                                        <tbody>
                                                   <tr>
							<th id="b1" class="colHeader" id="WC_RFQDisplay_TableCell_14"><fmt:message key="RFQDisplay_Mandatory" bundle="${storeText}"/></th>
							<th id="b2" class="colHeader" id="WC_RFQDisplay_TableCell_15"><fmt:message key="RFQDisplay_Changeable" bundle="${storeText}"/></th>
							<th id="b3" class="colHeader_last" id="WC_RFQDisplay_TableCell_16"><fmt:message key="RFQDisplay_TC" bundle="${storeText}"/></th>
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
                                                 include  RFQDisplay_TCRow.jsp 
                                          --%>                                                                                                                
                                          <tr class="<c:out value="${color}" />">
							<% out.flush(); %>
                                                        <c:import url="RFQDisplay_TCRow.jsp">
                                                        <c:param name="index" value="${iter.index}" />
                                                 	</c:import>  
							<% out.flush(); %>                    
                                                   </tr>
       </c:forEach>                                                   
       <!-- end iterate through comments -->
       
       <c:if test="${empty commentsList}">
                                              <tr class="cellBG_1">
                                                       <td  valign="top" colspan="4" class="categoryspace t_td" id="WC_RFQDisplay_TableCell_20"><fmt:message key="RFQDisplay_NoTC" bundle="${storeText}"/></td>
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
                
             <!-- Start RFQ Category Percentage Adjustment section -->
       <c:if test="${isContract and ! empty ppArray}">
              <tr>
                     <td  valign="top" width="400" class="topspace" id="WC_RFQDisplay_TableCell_21">
                            <h2><fmt:message key="RFQModifyDisplay_RFQPercentagePricing" bundle="${storeText}"/></h2> 
              <wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">                            
              </wcbase:useBean>       
                                   
                     <table id="WC_RFQDisplay_Table_12" width="100%" class="bgColor" cellpadding="2" cellspacing="1" border="0" >
                     <tbody> 
                            <tr height="25" class="bgColor">              
                                   <th <c:out value="${wrap}" /> id="c1"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPName" bundle="${storeText}"/></th>
                                   <th <c:out value="${wrap}" /> id="c2"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPDescription" bundle="${storeText}"/></th>
                                   <th <c:out value="${wrap}" /> id="c3"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPPrice" bundle="${storeText}"/></th>
                                   <th <c:out value="${wrap}" /> id="c4"  valign="center"  class="colHeader_last" > <fmt:message key="RFQModifyDisplay_PPCatalogUpdatesSync" bundle="${storeText}"/></th>                 
                            </tr>
              
              <!--iterate through RFQPriceAdjustmentOnCategory-->
              <c:set var="color" value="cellBG_2" />                                          
              <c:forEach var="rfqPP" items="${requestScope.ppArray}" begin="0" varStatus="iter">
                     <%--
                            rfqProdPrice stored in request to call RFQDisplay_PriceAdjustment_Row.jsp
                            to display price
                     --%>
                     <c:set var="rfqPP" value="${rfqPP}" scope="request" />
                     <c:choose>
                            <c:when test="${color == 'cellBG_1'}">
                                   <c:set var="color" value="cellBG_2" />
                            </c:when>
                            <c:when test="${color == 'cellBG_2'}">
                                   <c:set var="color" value="cellBG_1" />
                            </c:when>
                     </c:choose>                                                               
                            <tr class="<c:out value="${color}" />">
				<% out.flush(); %>
                                   <c:import url="RFQDisplay_PriceAdjustment_Row.jsp">
                                          <c:param name="index" value="${iter.index}" />
                                   </c:import>     
				<% out.flush(); %>                              
                            </tr> 
              </c:forEach>                                                 
              <!-- end iterate through RFQPriceAdjustmentOnCategory -->
                     </tbody>                                    
                     </table>          
                     </td>
              </tr>       
       </c:if>
       <!-- End RFQ Category Precentage Adjustment section -->                                 

       <c:url var="RFQCategoryDisplayHref" value="RFQCategoryDisplay" >
              <c:param name="offering_id" value="${offeringId}" />
              <c:param name="langId" value="${langId}" />
              <c:param name="storeId" value="${storeId}" />
              <c:param name="catalogId" value="${catalogId}" />
       </c:url>
                     <tr>
                             <td  valign="top" width="400" class="topspace" id="WC_RFQDisplay_TableCell_28">
                        <h2><fmt:message key="RFQDisplay_Category" bundle="${storeText}"/></h2>
                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQDisplay_Table_13">
                        <tbody>
                                    <tr>
                                           <td id="WC_RFQDisplay_TableCell_29">
                                           <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQDisplay_Table_14">
                                        <tbody>
                                                   <tr>                                                                                   
                                                       <th id="d1" class="colHeader_last" id="WC_RFQDisplay_TableCell_30"><fmt:message key="RFQDisplay_CategoryTitle" bundle="${storeText}"/></th>
                                                   </tr>

                                                   <tr class="cellBG_1">
                                                       <td headers="d1" class="t_td" id="WC_RFQDisplay_TableCell_31"><a href="<c:out value="${RFQCategoryDisplayHref}" />" id="WC_RFQDisplay_Link_4"><fmt:message key="RFQExtra_NotCategorized" bundle="${storeText}"/></a></td>
                                                   </tr>
       <!--iterate through RFQCategry-->
       <c:set var="color" value="cellBG_2" />
       <c:forEach var="category" items="${categoryList}" begin="0" varStatus="iter">
              <c:choose>
                     <c:when test="${color == 'cellBG_1'}">
                            <c:set var="color" value="cellBG_2" />
                     </c:when>
                     <c:when test="${color == 'cellBG_2'}">
                            <c:set var="color" value="cellBG_1" />
                     </c:when>
              </c:choose>
                                          <tr class="<c:out value="${color}" />">
                                                  <c:url var="RFQCategoryDisplayHref" value="${RFQCategoryDisplayHref}">                                                                              
                                                        <c:param name="rfqCategoryId" value="${category.rfqCategryIdInEJBType}" />
                                                 </c:url>                                          
                                                       <td headers="d1" class="t_td" id="WC_RFQDisplay_TableCell_32_<c:out value="${iter.count}" />">
                                                              <a href="<c:out value="${RFQCategoryDisplayHref}" />" id="WC_RFQDisplay_Link_5_<c:out value="${iter.count}" />"><c:out value="${category.name}" /></a>
                                                       </td>
                                                   </tr>
       </c:forEach>                                                 
       <!-- end iterate through RFQCategry -->
                                        </tbody>
                                           </table>
                                           </td>
                                </tr>
                        </tbody>
                        </table>
                        </td>
       <!--end display category-->                  
                      </tr>       
       
       <!--display product-->
       <c:set var="pageSize" value="${param.pageSize}" />
       <c:set var="initPos" value="${param.initPos}"  />
       <% out.flush(); %>             
       <c:import url="RFQDisplay_Product.jsp">
              <c:param name="offeringId" value="${offeringId}" />
              <c:param name="pageSize" value="${pageSize}" />
              <c:param name="initPos" value="${initPos}" />
       </c:import> 
	<% out.flush(); %>                                   
       <!--end display product-->

        <%--
              if multiseller display TargetList
       --%>
       <c:if test="${multiSeller}">
              <%-- work is done in include file--%>
	      <% out.flush(); %>
              <c:import url="RFQDisplay_TargetList.jsp">
                     <c:param name="offeringId " value="${offeringId}" />
              </c:import>
	      <% out.flush(); %>
       </c:if>                   
                <tr>
                     <td id="WC_RFQDisplay_TableCell_67">&nbsp;</td>
                </tr>         
                      <tr>
                        <td id="WC_RFQDisplay_TableCell_68" >
                            <%-- display links according to rfq type --%>  
			    <% out.flush(); %>                                 
                            <c:import url="RFQDisplay_Links.jsp" >
                                   <c:param name="rfq_offering_id" value="${offeringId}" />
                                   <c:param name="URL" value="RFQListDisplay" />
                                   <c:param name="systemRFQState" value="${systemRFQState}" />        
                            </c:import>  
			    <% out.flush(); %>
                            <%-- end display links according to rfq type --%>
                        </td>
                     </tr>
                <tr>
                              <td id="WC_RFQDisplay_TableCell_85">&nbsp;</td>
                </tr>
             </tbody>
        </table>
              </td>
       <!--FINISH MAIN CONTENT-->
        </tr>
    </tbody>
</table>    
      
<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

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
  * This JSP page displays a list of completed RFQ responses.
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

<c:set var="EC_OFFERING_ID" value="offering_id" scope="page" />
<c:set var="EC_RFQ_RESPONSE_ID" value="response_id" scope="page" />
<c:set var="EC_UTF_ENDRESULT_ORDER" value="1" scope="page" />
<c:set var="EC_RESPONSE_STATE_WON" value="8" scope="page" />

<c:set var="rfqId" value="${WCParam[EC_OFFERING_ID]}" scope="request" />
<c:set var="catalogId" value="${WCParam.catalogId}" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQCompleteListResponse_Title" bundle="${storeText}"/></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQCompleteListResponseDisplay_Table_1">

    <tbody>
        <tr>
            <td valign="top" width="630" id="WC_RFQCompleteListResponseDisplay_TableCell_2">

            <!--START MAIN CONTENT-->

			<wcbase:useBean id="rfq" classname="com.ibm.commerce.utf.beans.RFQDataBean">
				<jsp:setProperty property="*" name="rfq"/>
				<c:set property="rfqId" value="${rfqId}" target="${rfq}" />			
			</wcbase:useBean>
			
			<wcbase:useBean id="rfqResponse" classname="com.ibm.commerce.rfq.beans.RFQResponseListBean" >
				<c:set property="rfqId" value="${rfqId}" target="${rfqResponse}" />	
				<c:set property="state" value="${EC_RESPONSE_STATE_WON}" target="${rfqResponse}" />	
			</wcbase:useBean>
			
			<c:set var="endresult" value="${rfq.endResultInEJBType}"  scope="request" />
			
			<c:choose>
				<c:when test="${endresult eq EC_UTF_ENDRESULT_ORDER}" >
					<c:set var="action" value="RFQCompleteOrderDisplay"  />
					<fmt:message key="RFQ_Convert_Order" bundle="${storeText}" var="actionDesc" />
				</c:when>
				<c:otherwise>
					<c:set var="action" value="RFQCompleteContractDisplay"  />
					<fmt:message key="RFQ_Convert_Contract" bundle="${storeText}" var="actionDesc" />
				</c:otherwise>
			</c:choose>
			
			<c:set var="rlist" value="${rfqResponse.responses}"  />
			
			 <c:if test="${empty rlist}">
			 	<c:set var="action" value="RFQDisplay"  />
			 </c:if>

			<form name="RFQCompleteForm" action="<c:out value="${action}" />" method="get" id="RFQCompleteForm">
			<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQCompleteListResponseDisplay_FormInput_langId_In_RFQCompleteForm_1"/>
			<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQCompleteListResponseDisplay_FormInput_storeId_In_RFQCompleteForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQCompleteListResponseDisplay_FormInput_catalogId_In_RFQCompleteForm_1"/>
			<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQCompleteListResponseDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQCompleteForm_1"/>

            <table cellpadding="0" cellspacing="0" width="580" border="0"  id="WC_RFQCompleteListResponseDisplay_Table_2">

                <tbody>
                    <tr>
                        <td width="10" rowspan="4" id="WC_RFQCompleteListResponseDisplay_TableCell_3">&nbsp;</td>
                        <td id="WC_RFQCompleteListResponseDisplay_TableCell_4">
                        <table width="100%" id="WC_RFQCompleteListResponseDisplay_Table_3">
                            <tbody>
                                <tr>
                                    <td  valign="top" colspan="2" class="categoryspace" id="WC_RFQCompleteListResponseDisplay_TableCell_5">
                                    <h1><fmt:message key="RFQ_Winning_Responses" bundle="${storeText}"/></h1>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>

                    <tr>
                        <td  valign="top" width="400" class="topspace" colspan="3" id="WC_RFQCompleteListResponseDisplay_TableCell_6"><br />

                        <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQCompleteListResponseDisplay_Table_4">
                            <tbody>
                                <tr></tr>
                                <tr>
                                    <td id="WC_RFQCompleteListResponseDisplay_TableCell_7">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCompleteListResponseDisplay_Table_5">
                                        <tbody>
                                            <tr>
                                                <th id="a1" valign="top" class="colHeader" id="WC_RFQCompleteListResponseDisplay_TableCell_8"></th>
                                                <th id="a2" valign="top" class="colHeader" id="WC_RFQCompleteListResponseDisplay_TableCell_9"><fmt:message key="RFQResponseListDisplay_Name" bundle="${storeText}"/></th>
                                                <th id="a3" class="colHeader_last"  id="WC_RFQCompleteListResponseDisplay_TableCell_9a"></th>
                                            </tr>
                                            
    <c:set var="color" value="cellBG_2" />
    <c:set var="rfqRes" scope="request" />  
                                           
  	<c:forEach var="rfqRes" items="${rlist}" begin="0" varStatus="iter">  
  	 	<c:set var="rfqRes" value="${rfqRes}" scope="request" />
  		<c:set var="resId" value="${rfqRes.rfqResponseId}" />
  		
  	                                          
             <c:choose>
                <c:when test="${color == 'cellBG_1'}">
                   <c:set var="color" value="cellBG_2" />
                </c:when>
                <c:when test="${color == 'cellBG_2'}">
                  <c:set var="color" value="cellBG_1" />
                </c:when>
             </c:choose>    
             
           <tr>
                <td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteListResponseDisplay_TableCell_10_<c:out value="${iter.count}" />">
                   <label for="WC_RFQCompleteListResponseDisplay_FormInput_<c:out value="${EC_RFQ_RESPONSE_ID}" />_In_RFQCompleteForm_1_<c:out value="${iter.count}" />"></label>
                   <input type="radio" class="radio" name="<c:out value="${EC_RFQ_RESPONSE_ID}" />" 
                   <c:if test="${iter.count eq '1'}" >
                   		checked="checked" 
                   </c:if>                    
                   value="<c:out value="${resId}" />" id="WC_RFQCompleteListResponseDisplay_FormInput_<c:out value="${EC_RFQ_RESPONSE_ID}" />_In_RFQCompleteForm_1_<c:out value="${iter.count}" />"/>
               
               </td>
               <td headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteListResponseDisplay_TableCell_11_<c:out value="${iter.count}" />"><a href="RFQResponseDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_RFQ_RESPONSE_ID}" />=<c:out value="${resId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQCompleteListResponseDisplay_Link_1_<c:out value="${iter.count}" />"><c:out value="${rfqRes.name}" /></a></td>
               <td headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteListResponseDisplay_TableCell_12_<c:out value="${iter.count}" />"><a href="<c:out value="${action}" />?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_RFQ_RESPONSE_ID}" />=<c:out value="${resId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQCompleteListResponseDisplay_Link_2_<c:out value="${iter.count}" />"><c:out value="${actionDesc}" /></a></td>
          </tr>   
             
                                            
	</c:forEach>
			 <c:if test="${empty rlist}">
			 	   <tr class="cellBG_1">
                        <td  valign="top" colspan="6" class="categoryspace t_td" id="WC_RFQCompleteListResponseDisplay_TableCell_13"><fmt:message key="RFQCompleteListResponse_NoRes" bundle="${storeText}"/></td>
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
                        <td colspan="3" id="WC_RFQCompleteListResponseDisplay_TableCell_14">
                        <table cellpadding="0" cellspacing="0" id="WC_RFQCompleteListResponseDisplay_Table_8">
                            <tbody>
                                <tr>

<!-- Start display for button "RFQ_Ok" -->
<td height="41" id="WC_RFQCompleteListResponseDisplay_TableCell_15">
<a class="button" href="javascript:document.RFQCompleteForm.submit();" id="WC_RFQCompleteListResponseDisplay_Link_3"> &nbsp; <fmt:message key="RFQ_Ok" bundle="${storeText}"/> &nbsp; 
</a>
</td>
<!-- End display for button ... -->

                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" id="WC_RFQCompleteListResponseDisplay_TableCell_16">&nbsp;</td>
                    </tr>
                    <!--FINISH MAIN CONTENT-->
                </tbody>
            </table>

            </form>

            </td>
        </tr>
    </tbody>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

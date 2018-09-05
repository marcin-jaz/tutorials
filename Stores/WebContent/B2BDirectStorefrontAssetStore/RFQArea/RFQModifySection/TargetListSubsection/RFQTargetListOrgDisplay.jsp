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
  * This JSP page displays information about a Target List organization.
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
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="../RFQModifyConstants.jspf" %>

<c:set var="catalogId" value="${WCParam.catalogId}" scope="request" />
<c:set var="rfqId" value="${WCParam[EC_OFFERING_ID]}" scope="request" />

   <wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean" scope="request">
        <jsp:setProperty property="*" name="rfqBean"/>         
        <c:set property="rfqId" value="${rfqId}" target="${rfqBean}" />                        
   </wcbase:useBean>  
   
   <c:set var="supplierOrgInfo" value="${rfqBean.supplierOrgInfo}"  />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

<title><fmt:message key="RFQTargetListOrgDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"
	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"
	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
	<c:set var="liveHelpPageType" value="personal" /> 
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQTargetListOrgDisplay_Table_1">
    <tbody>
        <tr>
            <td valign="top" width="630" id="WC_RFQTargetListOrgDisplay_TableCell_2">

            <!--content start-->

            <table cellpadding="0" cellspacing="0" border="0" width="620" id="WC_RFQTargetListOrgDisplay_Table_2">
                <tbody>
                    <tr>
                        <td rowspan="3" id="WC_RFQTargetListOrgDisplay_TableCell_3">&nbsp;</td>
                        <td id="WC_RFQTargetListOrgDisplay_TableCell_4">
                        <h1><fmt:message key="RFQTargetListOrgDisplay_Target" bundle="${storeText}" /></h1>
                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQTargetListOrgDisplay_TableCell_5"><fmt:message key="RFQTargetListOrgDisplay_TargetDesc" bundle="${storeText}" /><br />
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RFQTargetListOrgDisplay_Table_3">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQTargetListOrgDisplay_TableCell_6">

                    				<form name="RFQAddToTargetListForm" action="RFQTargetListAdd" method="get" id="RFQAddToTargetListForm">
									<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQTargetListOrgDisplay_FormInput_langId_In_RFQAddToTargetListForm_1"/>
									<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQTargetListOrgDisplay_FormInput_storeId_In_RFQAddToTargetListForm_1"/>
									<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQTargetListOrgDisplay_FormInput_catalogId_In_RFQAddToTargetListForm_1"/>
									<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQTargetListOrgDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQAddToTargetListForm_1"/>
									<input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_RFQTargetListOrgDisplay_FormInput_URL_In_RFQAddToTargetListForm_1"/>
									
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQTargetListOrgDisplay_Table_4">


									<c:set var="defaultCurrency" value="${sdb.storeDefaultCurrency}" scope="page" />

                                        <input type="hidden" name="currency" value="<c:out value="${defaultCurrency}" />" id="WC_RFQTargetListOrgDisplay_FormInput_currency_In_RFQAddToTargetListForm_1"/>
                                        <tbody>
                                            <tr>
                                            	<th class="colHeader" id="d1"></th>       
                                            	<th valign="top" class="colHeader" id="d2"><fmt:message key="RFQTargetListOrgDisplay_Organization" bundle="${storeText}" /></th>
                                                <th valign="top" class="colHeader" id="d3"><fmt:message key="RFQTargetListOrgDisplay_OrganizationOwner" bundle="${storeText}" /></th>
						<th class="colHeader_last" id="d4"></th>
                                     </tr>
 <c:set var="color" value="cellBG_2" />
  
 
 <c:forEach var="supplierOrg" items="${supplierOrgInfo}" begin="0" varStatus="iter">
		<c:set var="index" value="${iter.index}" />
		
		<c:choose> 
		<c:when test="${color == 'cellBG_1'}">
			<c:set var="color" value="cellBG_2" />
		</c:when>  
		<c:when test="${color == 'cellBG_2'}">
			<c:set var="color" value="cellBG_1" />
		</c:when>
		</c:choose>  
		  
		<tr>
 			<td headers="d1" class="<c:out value="${color}" /> t_td" id="WC_RFQTargetListOrgDisplay_TableCell_15_<c:out value="${index+1}" />"><label for="WC_RFQTargetListOrgDisplay_FormInput_targetOrgId_In_RFQAddToTargetListForm_1_<c:out value="${index+1}" />"></label>
 			<input type="checkbox" class="checkbox" name="targetOrgId" value="<c:out value="${supplierOrg.supOrgId}" />" id="WC_RFQTargetListOrgDisplay_FormInput_targetOrgId_In_RFQAddToTargetListForm_1_<c:out value="${index+1}" />"/></td>
			<td headers="d2" class="<c:out value="${color}" /> t_td" id="WC_RFQTargetListOrgDisplay_TableCell_16_<c:out value="${index+1}" />"><c:out value="${supplierOrg.supOrgName}" /></td>
			<td headers="d3" class="<c:out value="${color}" /> t_td" id="WC_RFQTargetListOrgDisplay_TableCell_17_<c:out value="${index+1}" />"><c:out value="${supplierOrg.parentOrgName}" /></td>
			<td headers="d4" class="<c:out value="${color}" /> t_td" id="WC_RFQTargetListOrgDisplay_TableCell_18_<c:out value="${index+1}" />"><a href="RFQTargetListStoreDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&targetOrgId=<c:out value="${supplierOrg.supOrgId}" />" class="t_button" id="WC_RFQTargetListOrgDisplay_Link_1_<c:out value="${index+1}" />"><fmt:message key="RFQTargetListOrgDisplay_TargetStores" bundle="${storeText}" /></a></td>
		</tr>
 
 </c:forEach>
 
 
 
   </form>

                                        </tbody>
                                    </table>

                                  

                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQTargetListOrgDisplay_TableCell_19">

                        <table id="WC_RFQTargetListOrgDisplay_Table_9">
                            <tbody>
                                <tr>

<c:if test="${!empty supplierOrgInfo}">

<!-- Start display for button "RFQTargetListOrgDisplay_Add" -->
<td height="41" id="WC_RFQTargetListOrgDisplay_TableCell_20">
<a class="button" href="javascript:document.RFQAddToTargetListForm.submit()" id="WC_RFQTargetListOrgDisplay_Link_2"> &nbsp;<fmt:message key="RFQTargetListOrgDisplay_Add" bundle="${storeText}" />&nbsp; 
</a>
</td>
<!-- End display for button ... -->

               <td id="WC_RFQTargetListOrgDisplay_TableCell_21">&nbsp;</td>

</c:if>

<!-- Start display for button "RFQTargetListOrgDisplay_Cancel" -->
<td height="41" id="WC_RFQTargetListOrgDisplay_TableCell_22">
<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQTargetListOrgDisplay_Link_3"> &nbsp;<fmt:message key="RFQTargetListOrgDisplay_Cancel" bundle="${storeText}" /> &nbsp; 
</a>
</td>
<!-- End display for button ... -->

                                </tr>
                            </tbody>

                        </table>

                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQTargetListOrgDisplay_TableCell_23">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
            <!--content end-->
            </td>
        </tr>
    </tbody>
</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

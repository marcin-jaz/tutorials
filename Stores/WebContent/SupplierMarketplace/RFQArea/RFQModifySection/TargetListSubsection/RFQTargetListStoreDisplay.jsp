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
  * This JSP page displays a list of Target stores.
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

<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:set var="rfqId" value="${WCParam[EC_OFFERING_ID]}" scope="request" />

   <wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean" scope="request">
        <jsp:setProperty property="*" name="rfqBean"/>         
        <c:set property="rfqId" value="${rfqId}" target="${rfqBean}" />                        
   </wcbase:useBean>  
   
   <c:set var="storesInfo" value="${rfqBean.storesInfo}"  />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

<title><fmt:message key="RFQTargetListStoreDisplay_Title" bundle="${storeText}" />
</title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<fmt:message key="RFQTargetListStoreDisplay_Error1" bundle="${storeText}" var="Error1" />
<script language="javascript">
	function submitAdd(form)
	{
		if (form.numStore.value == 1)
		{
			if (form.targetStoreId.checked != true)
			{
				error("<c:out value="${Error1}" />");
				return;
			}
			form.submit();
			return;
		}
		else
		{
			for (var i = 0; i < form.numStore.value; i++) {
				if (form.targetStoreId[i].checked) {
					form.submit();
					return;
				}
			}
			error("<c:out value="${Error1}" />");
			return;
		}
	}
	function error(errMsg)
	{
		alert(errMsg);
	}

</script>

</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
	<c:set var="liveHelpPageType" value="personal" /> 
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQTargetListStoreDisplay_Table_1">
    <tbody>
        <tr>
            <td valign="top" width="630" id="WC_RFQTargetListStoreDisplay_TableCell_2">

            <!--content start-->

            <table cellpadding="0" cellspacing="0" border="0" width="620" id="WC_RFQTargetListStoreDisplay_Table_2">
                <tbody>
                    <tr>
                        <td rowspan="4" id="WC_RFQTargetListStoreDisplay_TableCell_3">&nbsp;</td>
                        <td id="WC_RFQTargetListStoreDisplay_TableCell_4"><h1><fmt:message key="RFQTargetListStoreDisplay_Target" bundle="${storeText}" /></h1></td>
                    </tr>

                    <tr>
                        <td id="WC_RFQTargetListStoreDisplay_TableCell_5"><fmt:message key="RFQTargetListStoreDisplay_TargetDesc" bundle="${storeText}" /><br />
                        	<fmt:message key="RFQTargetListStoreDisplay_Organization" bundle="${storeText}" />: <fmt:message key="RFQDuplicateDisplay_All" bundle="${storeText}" /><br />
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RFQTargetListStoreDisplay_Table_3">
                            <tbody>
                                <tr> 
                                    <td id="WC_RFQTargetListStoreDisplay_TableCell_6">

                    				<form name="RFQAddToTargetListForm" action="RFQTargetListAdd" method="get" id="RFQAddToTargetListForm">
									<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQTargetListStoreDisplay_FormInput_langId_In_RFQAddToTargetListForm_1"/>
									<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQTargetListStoreDisplay_FormInput_storeId_In_RFQAddToTargetListForm_1"/>
									<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQTargetListStoreDisplay_FormInput_catalogId_In_RFQAddToTargetListForm_1"/>
									<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQTargetListStoreDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQAddToTargetListForm_1"/>

                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQTargetListStoreDisplay_Table_4">


							<c:set var="defaultCurrency" value="${sdb.storeDefaultCurrency}" scope="page" />

                                        <input type="hidden" name="currency" value="<c:out value="${defaultCurrency}" />" id="WC_RFQTargetListStoreDisplay_FormInput_currency_In_RFQAddToTargetListForm_1"/>
                                        <tbody>
                                            <tr>
                                            	<th class="colHeader" id="d1"></th>
                                            	<th valign="top" class="colHeader" id="d2"><fmt:message key="RFQTargetListStoreDisplay_Store" bundle="${storeText}" /></th>
                                            	<th valign="top" class="colHeader_last" id="d3"><fmt:message key="RFQTargetListStoreDisplay_StoreOwner" bundle="${storeText}" /></th>
                                            </tr>

<c:set var="color" value="cellBG_2" />
<c:set var="numStores" value="0" scope="request" />
 <c:forEach var="stores" items="${storesInfo}" begin="0" varStatus="iter">
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
            <td headers="d1" class="<c:out value="${color}" /> t_td" id="WC_RFQTargetListStoreDisplay_TableCell_13_<c:out value="${index+1}" />"><label for="WC_RFQTargetListStoreDisplay_FormInput_<c:out value="${EC_TARGETSTORE_ID}" />_In_RFQAddToTargetListForm_1_<c:out value="${index+1}" />"></label><input class="checkbox"type="checkbox" name="<c:out value="${EC_TARGETSTORE_ID}" />" value="<c:out value="${stores.storeEntityId}" />" id="WC_RFQTargetListStoreDisplay_FormInput_<c:out value="${EC_TARGETSTORE_ID}" />_In_RFQAddToTargetListForm_1_<c:out value="${index+1}" />"/></td>
            <td headers="d2" class="<c:out value="${color}" /> t_td" id="WC_RFQTargetListStoreDisplay_TableCell_14_<c:out value="${index+1}" />"><c:out value="${stores.sStoreName}" /></td>
            <td headers="d3" class="<c:out value="${color}" /> t_td" id="WC_RFQTargetListStoreDisplay_TableCell_15_<c:out value="${index+1}" />"></td>
        </tr>
        <c:set var="numStores" value="${index + 1}" scope="request" />	
 </c:forEach> 
                                            <input type="hidden" name="numStore" value="<c:out value="${requestScope.numStores}" />" id="WC_RFQTargetListStoreDisplay_FormInput_numStore_In_RFQAddToTargetListForm_1"/>
                                            <input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_RFQTargetListStoreDisplay_FormInput_URL_In_RFQAddToTargetListForm_1"/>
  </form>
                                        </tbody>
                                    </table>
                                  

                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        </td>
                    </tr>
<c:if test="${empty storesInfo}">
                    <tr>
                        <td class="warning" id="WC_RFQTargetListStoreDisplay_TableCell_16"><fmt:message key="RFQTargetListStoreDisplay_NoStore" bundle="${storeText}" /></td>
                    </tr>
</c:if>
                    <tr>
                        <td id="WC_RFQTargetListStoreDisplay_TableCell_17">
                        <table id="WC_RFQTargetListStoreDisplay_Table_8">
                            <tbody>
                                <tr>
<c:if test="${!empty storesInfo}">                                  

<!-- Start display for button "RFQTargetListStoreDisplay_Cancel" -->
<td height="41" id="WC_RFQTargetListStoreDisplay_TableCell_18">
<a class="button" href="javascript:submitAdd(document.RFQAddToTargetListForm)" id="WC_RFQTargetListStoreDisplay_Link_1"> &nbsp;<fmt:message key="RFQTargetListStoreDisplay_Add" bundle="${storeText}" />&nbsp; 
</a>
</td>
<!-- End display for button ... -->

				<td id="WC_RFQTargetListStoreDisplay_TableCell_19">&nbsp;</td>

</c:if>                                                                       

<!-- Start display for button "RFQTargetListStoreDisplay_Cancel" -->
<td height="41" id="WC_RFQTargetListStoreDisplay_TableCell_20">
<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQTargetListStoreDisplay_Link_2"> &nbsp;<fmt:message key="RFQTargetListStoreDisplay_Cancel" bundle="${storeText}" />&nbsp; 
</a>
</td>
<!-- End display for button ... -->

                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQTargetListStoreDisplay_TableCell_21">&nbsp;</td>
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

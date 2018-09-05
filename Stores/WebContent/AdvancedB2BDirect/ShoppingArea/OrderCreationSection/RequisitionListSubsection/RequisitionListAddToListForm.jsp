<%--
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
--%>
<%-- 
  *****
  * This JSP page displays the Add to Requisition List page with the following elements:
  *  - List of existing requisition lists owned by the current user showing 'Name', 'Last updated' and 'Type'
  *  - 'Add to Requisition List' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="partNumber" value="${WCParam.partNumber}" scope="request" />
<c:set var="quantity" value="${WCParam.quantity}" scope="request" />
<c:set var="totalCatentryInBundle" value="${WCParam.totalCatentryInBundle}" scope="request" />

<wcbase:useBean id="sOwnedReqListDB" classname="com.ibm.commerce.order.beans.SRequisitionOwnedByMemberIdAndStoreIdListDataBean" scope="page">
<c:set target="${sOwnedReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
<c:set target="${sOwnedReqListDB}" property="dataBeanKeyStoreId" value="${storeId}"/>
</wcbase:useBean>
<c:set var="sharedRequisitionLists" value="${sOwnedReqListDB.SRequisitionOwnedByMemberIdAndStoreIdList}" />	

<wcbase:useBean id="pReqListDB" classname="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" scope="page">
<c:set target="${pReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
<c:set target="${pReqListDB}" property="dataBeanKeyStoreId" value="${storeId}"/>
</wcbase:useBean>
<c:set var="privateRequisitionLists" value="${pReqListDB.PRequisitionByMemberIdAndStoreIdList}" />

	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN RequisitionListAddToListForm.jsp -->
<head>
<title><fmt:message key="Addtoreq_Title" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<script language="javascript">
function Add2ReqList(form)
{
	if (form.reqListId.length==null) {
		form.requisitionListId.value=form.reqListId.value;
	} else {
		for (var i=0;i<form.reqListId.length;i++) {
			if (form.reqListId[i].checked) {
				form.requisitionListId.value=form.reqListId[i].value;
				break;
			}
		}
	}
	form.submit();
}

</script>
</head>
<body class="noMargin">
<flow:ifEnabled feature="customerCare"> 
<%--
Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp
--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled> 
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	<!--content start-->
	<h1><fmt:message key="Addtoreq_Title" bundle="${storeText}" /></h1>
     
	<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_RequisitionListAddToListForm_Table_1">
        <tr>
                <td id="WC_RequisitionListAddToListForm_TableCell_1"><fmt:message key="Addtoreq_Text1" bundle="${storeText}" /></td>
        </tr>
        <tr>
		<td id="WC_RequisitionListAddToListForm_TableCell_2">
			<%--
			***
			* Start: List of requisition lists owned by current user
			***
			--%>                      
			<form name="RequisitionListForm" action="RequisitionListItemUpdate" method="post" id="RequisitionListForm">
                        <input type="hidden" name="requisitionListId" value="" id="WC_RequisitionListAddToListForm_FormInput_requisitionListId_In_RequisitionListForm_1"/>
                        <input type="hidden" name="URL" value="RequisitionListUpdateView" id="WC_RequisitionListAddToListForm_FormInput_URL_In_RequisitionListForm_1"/>
                        
                        <c:if test="${!empty partNumber && !empty quantity && quantity != 0}">
                        	<input type="hidden" name="partNumber" value="<c:out value="${partNumber}"/>" id="WC_RequisitionListAddToListForm_FormInput_partNumber_In_RequisitionListForm_1"/>
                        	<input type="hidden" name="quantity" value="<c:out value="${quantity}"/>" id="WC_RequisitionListAddToListForm_FormInput_quantity_In_RequisitionListForm_1"/>
                        </c:if>
                        <c:if test="${!empty totalCatentryInBundle}">
                        	<c:forEach var="i" begin="1" end="${totalCatentryInBundle}">
														<c:set var="strPartNumber" value="partNumber_${i}" />
	                          <c:set var="strQuantity" value="quantity_${i}" />
	                          <c:if test="${!empty WCParam[strPartNumber] && !empty WCParam[strQuantity] && WCParam[strQuantity] != 0}">
	                          	<input type="hidden" name="<c:out value="${strPartNumber}"/>" value="<c:out value="${WCParam[strPartNumber]}"/>" id="WC_RequisitionListAddToListForm_FormInput_<c:out value="${strPartNumber}"/>_In_RequisitionListForm_1"/>
	                            <input type="hidden" name="<c:out value="${strQuantity}"/>" value="<c:out value="${WCParam[strQuantity]}"/>" id="WC_RequisitionListAddToListForm_FormInput_<c:out value="${strQuantity}"/>_In_RequisitionListForm_1"/>
	                          </c:if>
	                          <c:set var="strAttrName" value="attrName_${i}" />
														<c:set var="strAttrValue" value="attrValue_${i}" />
														<c:forEach var="aParam" items="${WCParamValues}" varStatus="paramStatus">
															<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
																<c:if test="${aParam.key == strAttrName || aParam.key == strAttrValue}">
																	<input type="hidden" name="<c:out value="${aParam.key}"/>" value="<c:out value="${aValue}"/>" id="WC_RequisitionListAddToListForm_FormInput_<c:out value="${aParam.key}${aValue}"/>_In_RequisitionListForm_1"/>
																</c:if>
															</c:forEach>
														</c:forEach>
													</c:forEach>
                        </c:if>
                        
                        <input type="hidden" name="storeId" value="<c:out value="${storeId}" />" />
                        <input type="hidden" name="langId" value="<c:out value="${langId}" />" />
                        <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" />                                                    
			<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RequisitionListAddToListForm_Table_2">
				<tr>                  
					<th class="colHeader" id="RequisitionListTH_Radio" width="2%"></th>
					<th valign="top" class="colHeader" id="RequisitionListTH_Name"><fmt:message key="Addtoreq_Col1" bundle="${storeText}" /></th>
					<th valign="top" class="colHeader" id="RequisitionListTH_LastUpdated"><fmt:message key="Addtoreq_Col2" bundle="${storeText}" /></th>
					<th valign="top" class="colHeader_last" id="RequisitionListTH_Type"><fmt:message key="Addtoreq_Col3" bundle="${storeText}" /></th>
				</tr>
				<c:set var="displaySwitch" value="${true}" />
				<%--
				 ***
				 * Private requisition lists owned by user
				 ***
				--%>                    
    				<c:forEach var="requisitionListP" items="${privateRequisitionLists}" varStatus="istat">
					<c:choose>
						<c:when test="${displaySwitch eq true}">
							<c:set var="trclass" value="cellBG_1"/>
							<c:set var="displaySwitch" value="${false}"/>
						</c:when>
						<c:otherwise>
							<c:set var="trclass" value="cellBG_2"/>
							<c:set var="displaySwitch" value="${true}"/>
						</c:otherwise>
					</c:choose>
					<tr>
						<td headers="RequisitionListTH_Radio" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListAddToListForm_TableCell_3_<c:out value="${istat.count}"/>"> 
							<c:choose>
								<c:when test="${istat.count == 1}">
									<c:set var="checked" value="checked=\"checked\""/>
								</c:when>
								<c:otherwise>
									<c:set var="checked" value=""/>
								</c:otherwise>
							</c:choose>
							<input id="reqListId_<c:out value='${istat.count}'/>" type="radio" class="radio" name="reqListId" value="<c:out value="${requisitionListP.orderId}"/>" <c:out value="${checked}"/> id="WC_RequisitionListAddToListForm_FormInput_reqListId_In_RequisitionListForm_1_<c:out value="${istat.count}"/>"/>
						</td>
						<td headers="RequisitionListTH_Name" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListAddToListForm_TableCell_4_<c:out value="${istat.count}"/>"><label for="reqListId_<c:out value='${istat.count}'/>"><c:out value="${requisitionListP.description}"/></label><a id="WC_RequisitionListAddToListForm_Link_1_<c:out value="${istat.count}"/>"></a></td>
						<td headers="RequisitionListTH_LastUpdated" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListAddToListForm_TableCell_5_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.formattedLastUpdate}"/></td>
						<td headers="RequisitionListTH_Type" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListAddToListForm_TableCell_6_<c:out value="${istat.count}"/>"><fmt:message key="Addtoreq_Type1" bundle="${storeText}" /> </td>
					</tr>
				</c:forEach>
				
				<%--
				 ***
				 * Shared requisition lists owned by user
				 ***
				--%>
				<c:forEach var="requisitionListSAll" items="${sharedRequisitionLists}" varStatus="istat">
					<c:choose>
						<c:when test="${displaySwitch eq true}">
							<c:set var="trclass" value="cellBG_1"/>
							<c:set var="displaySwitch" value="${false}"/>
						</c:when>
						<c:otherwise>
							<c:set var="trclass" value="cellBG_2"/>
							<c:set var="displaySwitch" value="${true}"/>
						</c:otherwise>
					</c:choose>
					<tr>
						<td class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListAddToListForm_TableCell_7_<c:out value="${istat.count}"/>">
							<label for="WC_RequisitionListAddToListForm_FormInput_reqListId_In_RequisitionListForm_3_<c:out value="${istat.count}"/>"></label>
							<input type="radio" name="reqListId" value="<c:out value="${requisitionListSAll.orderId}"/>" id="WC_RequisitionListAddToListForm_FormInput_reqListId_In_RequisitionListForm_3_<c:out value="${istat.count}"/>"/>
						</td>
						<td class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListAddToListForm_TableCell_8_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.description}"/><a id="WC_RequisitionListAddToListForm_Link_2_<c:out value="${istat.count}"/>"></a></td>
						<td class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListAddToListForm_TableCell_9_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.formattedLastUpdate}"/></td>
						<td class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListAddToListForm_TableCell_10_<c:out value="${istat.count}"/>"><fmt:message key="Addtoreq_Type2" bundle="${storeText}" /></td>
					</tr>
				</c:forEach>
			</table>
			</form>
			<%--
		        ***
		        * End: List of requisition lists owned by current user
		        ***
		        --%>
		</td>
	</tr>

        <c:choose>
		<c:when test="${(empty privateRequisitionLists) && (empty sharedRequisitionLists)}">
			<%--
			***
			* Display message if no requisition lists owned by current user
			***
			--%>
			<tr>
				<td id="WC_RequisitionListAddToListForm_TableCell_11"><span class="warning"><fmt:message key="Addtoreq_Text2" bundle="${storeText}" /></span></td>
			</tr>
        	</c:when>
        	<c:otherwise>
			<%--
			***
			* Add to Requisition List button
			***
			--%>
		        <tr>
				<td id="WC_RequisitionListAddToListForm_TableCell_12">
				<table cellpadding="0" cellspacing="0" border="0" id="WC_RequisitionListAddToListForm_Table_3">
					<tr>
						<td id="WC_RequisitionListAddToListForm_TableCell_13">
							<a href="javascript:Add2ReqList(document.RequisitionListForm)" class="button" id="WC_RequisitionListAddToListForm_Link_3">
								<fmt:message key="Addtoreq_Button" bundle="${storeText}" />
							</a>
						</td>
					</tr>
				</table>
				</td>
		        </tr>
		</c:otherwise>
	</c:choose>
	</table>
	
	<!--content end-->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END RequisitionListAddToListForm.jsp -->
</html>

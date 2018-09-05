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
  * This JSP page displays a list of all Requisition List for the user.
  *
  * Required parameters:
  * - offering_id
  * - userid
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



<c:set var="EC_OFFERING_ID" value="offering_id" scope="request" />

<c:set var="userRefNum" value="${userId}" />
<c:set var="catalogId" value="${param.catalogId}" />
<c:set var="rfqId" value="${param[EC_OFFERING_ID]}" scope="request" />
<c:set var="requisitionListsType" value="${param.requisitionListsType}" />
<c:set var="reqListStoreId" value="${param.reqListStoreId}" />

<wcbase:useBean id="bnRegUser" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" scope="request">                                                 
          
</wcbase:useBean>  

<c:choose>
<c:when test="${empty requisitionListsType}" >
	<c:set var="requisitionListsType" value="All" />
</c:when>
<c:when test="${requisitionListsType eq 'mine' or requisitionListsType eq 'Mine'}" >
	<c:set var="requisitionListsType" value="Mine" />
</c:when>
<c:otherwise>
	<c:set var="requisitionListsType" value="All" />
</c:otherwise>
</c:choose>

<c:set var="partNumber" value="${param.partNumber}" />
<c:set var="quantity" value="${param.quantity}" />

<c:if test="${empty partNumber}" >
	<c:set var="partNumber" value="" /> 
</c:if>
<c:if test="${empty quantity}" >
	<c:set var="quantity" value="" />
</c:if>

<c:set var="thisempty" value="true" />
<c:set var="displaySwitch" value="true" />

<c:if test="${empty reqListStoreId and !multiSeller}" >
	<c:set var="reqListStoreId" value="${storeId}" />
</c:if>

 
<c:choose>
<c:when test="${!empty reqListStoreId}" >

<wcbase:useBean id="pReqListDB" classname="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" scope="request">                                                 
	<jsp:setProperty property="*" name="pReqListDB"/>         
    <c:set property="dataBeanKeyMemberId" value="${userRefNum}" target="${pReqListDB}" /> 
	<c:set property="dataBeanKeyStoreId" value="${reqListStoreId}" target="${pReqListDB}" />
           
</wcbase:useBean>
<c:set var="requisitionListsP" value="${pReqListDB.PRequisitionByMemberIdAndStoreIdList}"  />
													
</c:when>
<c:otherwise>
<wcbase:useBean id="pReqListDBSH" classname="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreHostedAtChannelStoreIdListDataBean" scope="request">                                                 
	<jsp:setProperty property="*" name="pReqListDBSH"/>         
    <c:set property="dataBeanKeyMemberId" value="${userRefNum}" target="${pReqListDBSH}" /> 
	<c:set property="dataBeanKeyStoreId" value="${storeId}" target="${pReqListDBSH}" />
           
</wcbase:useBean>
<c:set var="requisitionListsP" value="${pReqListDBSH.PRequisitionByMemberIdAndStoreHostedAtChannelStoreIdList}"  />
</c:otherwise>
</c:choose>
 
<c:choose>
<c:when test="${!empty reqListStoreId}" >

<wcbase:useBean id="sReqListDB" classname="com.ibm.commerce.order.beans.SRequisitionByMemberIdAndStoreIdListDataBean" scope="request">                                                 
	<jsp:setProperty property="*" name="sReqListDB"/>         
    <c:set property="dataBeanKeyMemberId" value="${userRefNum}" target="${sReqListDB}" /> 
	<c:set property="dataBeanKeyStoreId" value="${reqListStoreId}" target="${sReqListDB}" />
          
</wcbase:useBean>
<c:set var="requisitionListsSAll" value="${sReqListDB.SRequisitionByMemberIdAndStoreIdList}"  />
</c:when>
<c:otherwise>
<wcbase:useBean id="sReqListDBSH" classname="com.ibm.commerce.order.beans.SRequisitionByMemberIdAndStoreHostedAtChannelStoreIdListDataBean" scope="request">                                                 
	<jsp:setProperty property="*" name="sReqListDBSH"/>         
    <c:set property="dataBeanKeyMemberId" value="${userRefNum}" target="${sReqListDBSH}" /> 
	<c:set property="dataBeanKeyStoreId" value="${storeId}" target="${sReqListDBSH}" />
         
</wcbase:useBean>
<c:set var="requisitionListsSAll" value="${sReqListDBSH.SRequisitionByMemberIdAndStoreHostedAtChannelStoreIdList}"  />
</c:otherwise>
</c:choose>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
 
<head>

<title><fmt:message key="ReqList_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"
	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"
	type="text/css" />
</head> 

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
	<c:set var="liveHelpPageType" value="personal" /> 
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQAllRequisitionListsDisplay_Table_1">

<tr>
	<td valign="top" width="630" id="WC_RFQAllRequisitionListsDisplay_TableCell_2">



<table cellpadding="8" cellspacing="0" border="0" width="605" id="WC_RFQAllRequisitionListsDisplay_Table_2">
	<tr> 
		<td id="WC_RFQAllRequisitionListsDisplay_TableCell_3">

			<form name="RequisitionListsTypeForm" action="RFQAllRequisitionListsDisplay" method="post" id="RequisitionListsTypeForm">
			<input type="hidden" name="<c:out value="${EC_OFFERING_ID}"/>" value="<c:out value="${rfqId}"/>" id="WC_RFQAllRequisitionListsDisplay_FormInput_<c:out value="${EC_OFFERING_ID}"/>_In_RequisitionListsTypeForm_1">
			<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_RFQAllRequisitionListsDisplay_FormInput_langId_In_RequisitionListsTypeForm_1">
			<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_RFQAllRequisitionListsDisplay_FormInput_storeId_In_RequisitionListsTypeForm_1">
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_RFQAllRequisitionListsDisplay_FormInput_catalogId_In_RequisitionListsTypeForm_1">

			<table id="WC_RFQAllRequisitionListsDisplay_Table_3">
				<tr>
					<td colspan="2" id="WC_RFQAllRequisitionListsDisplay_TableCell_4">
						<h1><fmt:message key="ReqList_Title" bundle="${storeText}" /></h1>
					</td>
				</tr>
				<tr>
					<td colspan="2" id="WC_RFQAllRequisitionListsDisplay_TableCell_5"><strong><fmt:message key="ReqList_ViewType" bundle="${storeText}" /></strong></td>
				</tr>

				<tr>

					<td id="WC_RFQAllRequisitionListsDisplay_TableCell_6">
					<label for="WC_RFQAllRequisitionListsDisplay_Select_1"></label>
					<select name="requisitionListsType" class="select" id="WC_RFQAllRequisitionListsDisplay_Select_1" >
					<c:choose>
					<c:when test="${requisitionListsType eq 'All'}" >
						<option value="all" selected> <fmt:message key="ReqList_Drop1" bundle="${storeText}" /> </option>
						<option value="mine"> <fmt:message key="ReqList_Drop2" bundle="${storeText}" /> </option>					
					</c:when>
					<c:when test="${requisitionListsType eq 'Mine'}" >
						<option value="all"> <fmt:message key="ReqList_Drop1" bundle="${storeText}" /> </option>
						<option value="mine" selected> <fmt:message key="ReqList_Drop2" bundle="${storeText}" /> </option>					
					</c:when>
					</c:choose>				

					</select>
					
					</td>

					<!-- Start display for button "ReqList_Go" -->
					<td height=41 id="WC_RFQAllRequisitionListsDisplay_TableCell_7">
					<a class="button" href="javascript:document.RequisitionListsTypeForm.submit()" id="WC_RFQAllRequisitionListsDisplay_Link_1"> <fmt:message key="ReqList_Go" bundle="${storeText}" />
					</a>
					</td>
					<!-- End display for button ... -->

				</tr>
			</table>

			</form>

			<table cellpadding="0" cellspacing="8" border="0" width="605" id="WC_RFQAllRequisitionListsDisplay_Table_4">
				<tr>
					<td id="WC_RFQAllRequisitionListsDisplay_TableCell_10">
						<table cellpadding="0" cellspacing="0" border="0" width="605" class="bgColor" id="WC_RFQAllRequisitionListsDisplay_Table_5">
							<tr>
								<td id="WC_RFQAllRequisitionListsDisplay_TableCell_11">
									<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQAllRequisitionListsDisplay_Table_6">
										<tr>
											<th id="a1" valign="top" class="colHeader" id="WC_RFQAllRequisitionListsDisplay_TableCell_12"></th>
											<th id="a2" valign="top" class="colHeader" id="WC_RFQAllRequisitionListsDisplay_TableCell_13"><fmt:message key="ReqList_Name" bundle="${storeText}" /></th>		
											<th id="a3" valign="top" class="colHeader" id="WC_RFQAllRequisitionListsDisplay_TableCell_14"><fmt:message key="ReqList_Owner" bundle="${storeText}" /></th>		
											<th id="a4" valign="top" class="colHeader" id="WC_RFQAllRequisitionListsDisplay_TableCell_15"><fmt:message key="ReqList_Date" bundle="${storeText}" /></th>		
											<th id="a5" valign="top" class="colHeader_last" id="WC_RFQAllRequisitionListsDisplay_TableCell_16"><fmt:message key="ReqList_Type" bundle="${storeText}" /></th>
										</tr>

										<form name="RequisitionListForm" action="RFQRequisitionListDisplay" method="get" id="RequisitionListForm">
										<input type="hidden" name="<c:out value="${EC_OFFERING_ID}"/>" value="<c:out value="${rfqId}"/>" id="WC_RFQAllRequisitionListsDisplay_FormInput_<c:out value="${EC_OFFERING_ID}"/>_In_RequisitionListForm_1">
										<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_RFQAllRequisitionListsDisplay_FormInput_langId_In_RequisitionListForm_1">
										<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_RFQAllRequisitionListsDisplay_FormInput_storeId_In_RequisitionListForm_1">
										<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_RFQAllRequisitionListsDisplay_FormInput_catalogId_In_RequisitionListForm_1">
 

<c:choose>
<c:when test="${empty requisitionListsP and empty requisitionListsSAll}" >
	<!-- no requisition list, do nothing -->
</c:when>
<c:otherwise>
	<c:set var="thisempty" value="false" />
	 <%-- start display private lists --%>
	<c:forEach var="requisition" items="${requisitionListsP}" begin="0" varStatus="iter"> 
         <c:set var="memberId" value="${requisition.memberIdInEJBType}"  />	 
         
         <c:set var="lastUpdate" value="${requisition.lastUpdateInEJBType}"  />
         <c:set var="index" value="${iter.index}" />
         
         
         <c:choose>
         <c:when test="${empty lastUpdate}" >
         	<c:set var="formattedLastUpdate" value=""  />
         </c:when>
         <c:otherwise>
         
         	<fmt:formatDate value="${lastUpdate}"  pattern="MMMM dd, yyyy" var="formattedLastUpdate" />	
         	 
         </c:otherwise>
         </c:choose>	
         			
		 <c:choose>
		 <c:when test="${displaySwitch eq 'true'}" >
		 	<tr class="cellBG_1">
		 	<c:set var="displaySwitch" value="false" />
		 </c:when>
		 <c:otherwise>
		 	<tr class="cellBG_2">
		 	<c:set var="displaySwitch" value="true" />
		 </c:otherwise>
		 </c:choose>
		 
	
		<td headers="a1" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_17_<c:out value="${index+1}" />"><label for="WC_RFQAllRequisitionListsDisplay_FormInput_requisitionListId_In_Private_RequisitionListForm_1_<c:out value="${index+1}" />"></label><input id="WC_RFQAllRequisitionListsDisplay_FormInput_requisitionListId_In_Private_RequisitionListForm_1_<c:out value="${index+1}" />"  type="radio" class="radio" name="requisitionListId" value="<c:out value="${requisition.orderIdInEJBType}" />" <c:if test="${index == 0}" >	checked </c:if>	></td>
		<td headers="a2" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_18_<c:out value="${index+1}" />"><a href="RequisitionListUpdateView?requisitionListId=<c:out value="${requisition.orderIdInEJBType}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQAllRequisitionListsDisplay_Link_2_<c:out value="${index+1}" />"><c:out value="${requisition.description}" /></a></td>

		<c:choose>
		<c:when test="${locale eq 'ja_JP' or locale eq 'ko_KR' or locale eq 'zh_CN' }" >
			<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_19_<c:out value="${index+1}" />"><c:out value="${bnRegUser.lastName}" />&nbsp;<c:out value="${bnRegUser.firstName}" /></td>
		</c:when>
		<c:when test="${locale eq 'zh_TW'}" >
			<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_20_<c:out value="${index+1}" />"><c:out value="${bnRegUser.lastName}" /><c:out value="${bnRegUser.firstName}" /></td>
		</c:when>
		<c:otherwise>
			<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_21_<c:out value="${index+1}" />"><c:out value="${bnRegUser.firstName}" />&nbsp;<c:out value="${bnRegUser.lastName}" /></td>
		</c:otherwise>
		</c:choose>		

		<td headers="a4" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_22_<c:out value="${index+1}" />"><c:out value="${formattedLastUpdate}" /></td>
		<td headers="a5" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_23_<c:out value="${index+1}" />"><fmt:message key="ReqList_Type1" bundle="${storeText}" /></td>
	</tr>           	 
         	 
    </c:forEach>
    <%-- end display private lists --%>
    
	<%-- start shared lists --%>
		<c:forEach var="requisition" items="${requisitionListsSAll}" begin="0" varStatus="iter"> 
         <c:set var="memberId" value="${requisition.memberIdInEJBType}"  />	 
             <c:set var="index" value="${iter.index}" />  

		
		<c:choose>
			<c:when test="${userRefNum eq memberId}" >
			
			       <c:set var="lastUpdate" value="${requisition.lastUpdateInEJBType}"  />
         
         			<c:choose>
         			<c:when test="${empty lastUpdate}" >
         				<c:set var="formattedLastUpdate" value=""  />
         			</c:when>
         			<c:otherwise>
         			<%-- Format date appropriately from the TimeStampHelper. Allows date to be universal. --%>
         			<fmt:formatDate value="${lastUpdate}"  pattern="MMMM dd, yyyy" var="formattedLastUpdate" />	
   
         			</c:otherwise>
         			</c:choose>	
         			
		 			<c:choose>
		 			<c:when test="${displaySwitch eq 'true'}" >
		 				<tr class="cellBG_1">
		 				<c:set var="displaySwitch" value="false" />
		 			</c:when>
		 			<c:otherwise>
		 				<tr class="cellBG_2">
		 				<c:set var="displaySwitch" value="true" />
		 			</c:otherwise>
		 			</c:choose>
		 
	
					<td headers="a1" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_24_<c:out value="${index+1}" />"><label for="WC_RFQAllRequisitionListsDisplay_FormInput_requisitionListId_In_Shared_RequisitionListForm_1_<c:out value="${index+1}" />"></label><input id="WC_RFQAllRequisitionListsDisplay_FormInput_requisitionListId_In_Shared_RequisitionListForm_1_<c:out value="${index+1}" />"  type="radio" class="radio" name="requisitionListId" value="<c:out value="${requisition.orderIdInEJBType}" />" <c:if test="${index == 0}" >	checked </c:if>	></td>
					<td headers="a2" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_25_<c:out value="${index+1}" />"><a href="RequisitionListUpdateView?requisitionListId=<c:out value="${requisition.orderIdInEJBType}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQAllRequisitionListsDisplay_Link_3_<c:out value="${index+1}" />"><c:out value="${requisition.description}" /></a></td>
 
					<c:choose>
					<c:when test="${locale eq 'ja_JP' or locale eq 'ko_KR' or locale eq 'zh_CN' }" >
						<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_26_<c:out value="${index+1}" />"><c:out value="${bnRegUser.lastName}" />&nbsp;<c:out value="${bnRegUser.firstName}" /></td>
					</c:when>
					<c:when test="${locale eq 'zh_TW'}" >
						<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_27_<c:out value="${index+1}" />"><c:out value="${bnRegUser.lastName}" /><c:out value="${bnRegUser.firstName}" /></td>
					</c:when>
					<c:otherwise>
						<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_28_<c:out value="${index+1}" />"><c:out value="${bnRegUser.firstName}" />&nbsp;<c:out value="${bnRegUser.lastName}" /></td>
					</c:otherwise>
					</c:choose>		

					<td headers="a4" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_29_<c:out value="${index+1}" />"><c:out value="${formattedLastUpdate}" /></td>
					<td headers="a5" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_30_<c:out value="${index+1}" />"><fmt:message key="ReqList_Type2" bundle="${storeText}" /></td>
					</tr>     
			
			</c:when>
			<c:otherwise>
			
			
			</c:otherwise>
		</c:choose>    
        	 
    </c:forEach>

	<%-- end shared lists --%>
	
</c:otherwise>
</c:choose>


<c:if test="${requisitionListsType eq 'All'}" >
		<c:forEach var="requisition" items="${requisitionListsSOther}" begin="0" varStatus="iter"> 
         <c:set var="memberId" value="${requisition.memberIdInEJBType}"  />	
         
         <c:set var="lastUpdate" value="${requisition.lastUpdateInEJBType}"  />
          
         <c:choose>
         <c:when test="${empty lastUpdate}" >
         	<c:set var="formattedLastUpdate" value=""  />
         </c:when>
         <c:otherwise>
         <%-- Format date appropriately from the TimeStampHelper. Allows date to be universal. --%>
         	<fmt:formatDate value="${lastUpdate}"  pattern="MMMM dd, yyyy" var="formattedLastUpdate" />	
 

         </c:otherwise>
         </c:choose>	
         			
		 <c:choose>
		 <c:when test="${displaySwitch eq 'true'}" >
		 	<tr class="cellBG_1">
		 	<c:set var="displaySwitch" value="false" />
		 </c:when>
		 <c:otherwise>
		 	<tr class="cellBG_2">
		 	<c:set var="displaySwitch" value="true" />
		 </c:otherwise>
		 </c:choose>
		 
		<td headers="a1" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_31_<c:out value="${index+1}" />"><label for="WC_RFQAllRequisitionListsDisplay_FormInput_1"></label><input id="WC_RFQAllRequisitionListsDisplay_FormInput_1" type="radio" class="radio" name="requisitionListId" value="<c:out value="${requisition.orderId}" />" <c:if test="${index == 0}" >	checked </c:if>    ></td>
		<td headers="a2" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_32_<c:out value="${index+1}" />"><a href="RequisitionListDetailView?requisitionListId=<c:out value="${requisition.orderId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQAllRequisitionListsDisplay_Link_4_<c:out value="${index+1}" />"><c:out value="${requisition.description}" /></a></td>

					<c:choose>
					<c:when test="${locale eq 'ja_JP' or locale eq 'ko_KR' or locale eq 'zh_CN' }" >
						<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_33_<c:out value="${index+1}" />"><c:out value="${bnRegUser.lastName}" />&nbsp;<c:out value="${bnRegUser.firstName}" /></td>
					</c:when>
					<c:when test="${locale eq 'zh_TW'}" > 
						<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_34_<c:out value="${index+1}" />"><c:out value="${bnRegUser.lastName}" /><c:out value="${bnRegUser.firstName}" /></td>
					</c:when>
					<c:otherwise>
						<td headers="a3" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_35_<c:out value="${index+1}" />"><c:out value="${bnRegUser.firstName}" />&nbsp;<c:out value="${bnRegUser.lastName}" /></td>
					</c:otherwise>
					</c:choose>		

					<td headers="a4" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_36_<c:out value="${index+1}" />"><c:out value="${formattedLastUpdate}" /></td>
					<td headers="a5" class="t_td" id="WC_RFQAllRequisitionListsDisplay_TableCell_37_<c:out value="${index+1}" />"><fmt:message key="ReqList_Type2" bundle="${storeText}" /></td>
					</tr>  
          
    	</c:forEach> 
</c:if>
								</table>
								</td>
							</tr>
						</table>
						<p>
					</td>
				</tr>
			</table>
		</td>
	</tr>



<c:choose>	
<c:when test="${thisempty eq 'true'}" >	
	<tr>
		<td class="warning" id="WC_RFQAllRequisitionListsDisplay_TableCell_38"><fmt:message key="ReqList_Text1" bundle="${storeText}" /></td>
	</tr>
</c:when>
<c:otherwise>
	<tr>
<!-- Start display for button "RFQAllRequisitionListsDisplay_Select" -->
<td height="41" id="WC_RFQAllRequisitionListsDisplay_TableCell_39">
<a class="button" href="javascript:document.RequisitionListForm.submit()" id="WC_RFQAllRequisitionListsDisplay_Link_5">	<fmt:message key="RFQAllRequisitionListsDisplay_Select" bundle="${storeText}" /> 
</td>
<!-- End display for button ... -->
	</tr>
</c:otherwise>
</c:choose>	




</table>

<!--content end-->

	</td>
</tr>
</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>



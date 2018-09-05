<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2001, 2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN MiniRequisitionListDisplay.jsp -->
<c:forTokens items="${requestScope.requestURIPath}" delims="/" var="URLtoken">
	<c:set var="ReloadURL" value="${URLtoken}"/>
</c:forTokens>
<%--
	Screen out URLs that are not safe to link to upon deleting a Requisition List
--%>
<c:choose>
	<c:when test="${ReloadURL=='RequisitionListUpdateView'}">
		<c:set var="ReloadURL" value="RequisitionListView"/>
	</c:when>
	<c:when test="${ReloadURL=='RequisitionListDetailView'}">
		<c:set var="ReloadURL" value="RequisitionListView"/>
	</c:when>
	<c:when test="${ReloadURL=='RequisitionListDisplay'}">
		<c:set var="ReloadURL" value="RequisitionListView"/>
	</c:when>
	<c:otherwise>
		<%-- Leave ReloadURL as it is because it should be safe --%>
	</c:otherwise>
</c:choose>
<c:url var="ReloadWithParametersURL" value="${ReloadURL}">
	<c:forEach var="parameter" items="${WCParamValues}" >
		<c:if test="${parameter.key != 'logonPassword'}">
			<c:param name="${parameter.key}">
				<c:forEach var="value" items="${parameter.value}" >
					<c:out value="${value}" />
				</c:forEach>
			</c:param>
		</c:if>
	</c:forEach>
</c:url>
<c:set var="pageToDisplay" value="${param.CIPReqListPage}" />
<c:if test="${empty pageToDisplay}">
	<c:set var="pageToDisplay" value="0" />
</c:if>
<c:set var="rowsToDisplay" value="${param.rowsToDisplay}" />
<c:if test="${empty rowsToDisplay}">
	<c:set var="rowsToDisplay" value="5" />
</c:if>
<c:set var="rowStart" value="${pageToDisplay * rowsToDisplay}" />
<c:set var="rowsDisplayed" value="0"/>
<c:set var="rowsShownInFirstForEach" value="0"/>
<c:set var="rowsTotal" value="0"/>
<c:set var="requisitionListsType" value="All" />
<c:choose>
<c:when test="${!empty requisitionListsType && (requisitionListsType eq 'mine' || requisitionListsType eq 'Mine')}">
	<c:set var="requisitionListsType" value="Mine"/>
	<wcbase:useBean id="sOwnedReqListDB" classname="com.ibm.commerce.order.beans.SRequisitionOwnedByMemberIdAndStoreIdListDataBean">
		<c:set target="${sOwnedReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
		<c:set target="${sOwnedReqListDB}" property="dataBeanKeyStoreId" value="${storeId}"/>
	</wcbase:useBean>
	<c:set var="sharedRequisitionLists" value="${sOwnedReqListDB.SRequisitionOwnedByMemberIdAndStoreIdList}" />	
</c:when>
<c:otherwise>
	<c:set var="requisitionListsType" value="All"/>
	<wcbase:useBean id="sReqListDB" classname="com.ibm.commerce.order.beans.SRequisitionByMemberIdAndStoreIdListDataBean" scope="page">
		<c:set target="${sReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
		<c:set target="${sReqListDB}" property="dataBeanKeyStoreId" value="${storeId}"/>
		<c:set target="${sReqListDB}" property="priorityOwnedLists" value="${true}"/>
	</wcbase:useBean>
	<c:set var="sharedRequisitionLists" value="${sReqListDB.SRequisitionByMemberIdAndStoreIdList}" />
</c:otherwise>
</c:choose>

<wcbase:useBean id="pReqListDB" classname="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" scope="page">
	<c:set target="${pReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
	<c:set target="${pReqListDB}" property="dataBeanKeyStoreId" value="${storeId}"/>
</wcbase:useBean>
<c:set var="privateRequisitionLists" value="${pReqListDB.PRequisitionByMemberIdAndStoreIdList}" />


<!--content start-->
<fmt:message key="HUD_MiniRequisitionListDisplay" var="HUDFrameTitle" bundle="${storeText}" />
<c:url var="maximizeURL" value="RequisitionListDisplayView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerTop.jsp" >
	<c:param name="HUDFrameTitle" value="${HUDFrameTitle}" />
	<c:param name="maximizeURL" value="${maximizeURL}" />
</c:import>
<% out.flush(); %>

<c:set var="displaySwitch" value="${true}" />
<c:forEach var="requisitionListP" items="${privateRequisitionLists}" varStatus="istat">
<c:if test="${rowsTotal == 0}">
	<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_MiniRequisitionListDisplay_Table_6">
	<tr><td id="WC_MiniRequisitionListDisplay_TableCell_22a">
	<table width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_MiniRequisitionListDisplay_Table_7">
		<tr class="bgColor">
			<td valign="top" class="portlet_colHeader" id="WC_MiniRequisitionListDisplay_TableCell_14"><fmt:message key="ReqList_Name" bundle="${storeText}" /></td>
			<td valign="top" class="portlet_colHeader" id="WC_MiniRequisitionListDisplay_TableCell_16"><fmt:message key="ReqList_Owner" bundle="${storeText}" /></td>
			<td valign="top" class="portlet_colHeader" id="WC_MiniRequisitionListDisplay_TableCell_18"><fmt:message key="ReqList_Date" bundle="${storeText}" /></td>
			<td valign="top" class="portlet_colHeader" id="WC_MiniRequisitionListDisplay_TableCell_20"><fmt:message key="ReqList_Type" bundle="${storeText}" /></td>
			<td valign="top" id="WC_MiniRequisitionListDisplay_TableCell_22">&nbsp;</td>
		</tr>
</c:if>
<c:set var="rowsTotal" value="${rowsTotal + 1}"/>
<c:if test="${(((rowsToDisplay * pageToDisplay) + 1) <= istat.count) and (istat.count <= (rowsToDisplay * (pageToDisplay +1))) }">
<c:set var="rowsDisplayed" value="${rowsDisplayed + 1}"/>
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
		<c:url value="RequisitionListUpdateView" var="reqListUpdateUrl">
			<c:param name="requisitionListId" value="${requisitionListP.orderId}" />
			<c:param name="storeId" value="${storeId}"/>
			<c:param name="catalogId" value="${catalogId}"/>                            	
			<c:param name="langId" value="${langId}"/>
		</c:url>
	    <td id="WC_MiniRequisitionListDisplay_TableCell_23_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><a href="<c:out value="${reqListUpdateUrl}"/>" id="WC_MiniRequisitionListDisplay_Link_2_<c:out value="${istat.count}"/>" class="portlet_content"><c:out value="${requisitionListP.description}"/></a></td>
	    <c:choose>
	    	<c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN'}">
	    		<td id="WC_MiniRequisitionListDisplay_TableCell_24_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><c:out value="${requisitionListP.userRegistrationDataBean.lastName} ${requisitionListP.userRegistrationDataBean.firstName}"/></td>
	    	</c:when>
	    	<c:when test="${locale eq 'zh_TW'}">
	    		<td id="WC_MiniRequisitionListDisplay_TableCell_25_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><c:out value="${requisitionListP.userRegistrationDataBean.lastName}${requisitionListP.userRegistrationDataBean.firstName}"/></td>
	    	</c:when>
	    	<c:otherwise>
				<td id="WC_MiniRequisitionListDisplay_TableCell_26_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><c:out value="${requisitionListP.userRegistrationDataBean.firstName} ${requisitionListP.userRegistrationDataBean.lastName}"/></td>
			</c:otherwise>
		</c:choose>
		<td id="WC_MiniRequisitionListDisplay_TableCell_27_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><c:out value="${requisitionListP.formattedLastUpdate}"/></td>
		<td id="WC_MiniRequisitionListDisplay_TableCell_28_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><fmt:message key="ReqList_Type1" bundle="${storeText}" /></td>
	    <c:url value="RequisitionListDelete" var="reqListDelUrl">
			<c:param name="URL" value="${ReloadWithParametersURL}"/>
			<c:param name="requisitionListId" value="${requisitionListP.orderId}" />
			<c:param name="storeId" value="${storeId}"/>  
			<c:param name="catalogId" value="${catalogId}"/>                            	
			<c:param name="langId" value="${langId}"/>                            	                          	
		</c:url>
		<td class="<c:out value="${trclass}"/>" id="WC_MiniRequisitionListDisplay_TableCell_29_<c:out value="${istat.count}"/>">
			<a href="<c:out value="${reqListDelUrl}"/>" id="WC_MiniRequisitionListDisplay_Link_3_<c:out value="${istat.count}"/>" class="garbage" title="<fmt:message key="ReqList_Remove" bundle="${storeText}" />">
				<img src="<c:out value="${jspStoreImgDir}"/>images/garbage3.gif" alt="<fmt:message key="ReqList_Remove" bundle="${storeText}" />" width="16" height="16" border="0">
			</a>
		</td>
	</tr>
</c:if>
<c:set var="rowsInFirstForEach" value="${istat.count}"/>
</c:forEach>
<c:forEach var="requisitionListSAll" items="${sharedRequisitionLists}" varStatus="istat">
<c:if test="${rowsTotal == 0}">
	<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_MiniRequisitionListDisplay_Table_6">
	<tr>
	<td id="WC_MiniRequisitionListDisplay_TableCell_30">
	<table width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_MiniRequisitionListDisplay_Table_7">
		<tr class="bgColor">
			<td valign="top" class="portlet_colHeader" id="WC_MiniRequisitionListDisplay_TableCell_31"><fmt:message key="ReqList_Name" bundle="${storeText}" /></td>
			<td valign="top" class="portlet_colHeader" id="WC_MiniRequisitionListDisplay_TableCell_32"><fmt:message key="ReqList_Owner" bundle="${storeText}" /></td>
			<td valign="top" class="portlet_colHeader" id="WC_MiniRequisitionListDisplay_TableCell_33"><fmt:message key="ReqList_Date" bundle="${storeText}" /></td>
			<td valign="top" class="portlet_colHeader" id="WC_MiniRequisitionListDisplay_TableCell_34"><fmt:message key="ReqList_Type" bundle="${storeText}" /></td>
			<td valign="top" id="WC_MiniRequisitionListDisplay_TableCell_35">&nbsp;</td>
		</tr>
</c:if>
<c:set var="rowsTotal" value="${rowsTotal + 1}"/>
<c:if test="${(((rowsToDisplay * pageToDisplay) + 1) <= (istat.count + rowsInFirstForEach)) and ((istat.count + rowsInFirstForEach) <= (rowsToDisplay * (pageToDisplay +1))) }">
<c:set var="rowsDisplayed" value="${rowsDisplayed + 1}"/>
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
	    <c:choose>
	    	<c:when test="${userId eq requisitionListSAll.memberId}" >
	    		<c:set var="RequisitionViewURL" value="RequisitionListUpdateView"/>
	    	</c:when>
	    	<c:otherwise>
				<c:set var="RequisitionViewURL" value="RequisitionListDetailView"/>
	    	</c:otherwise>
	    </c:choose>
	    <c:url value="${RequisitionViewURL}" var="reqListUpdateUrl">
	    	<c:param name="requisitionListId" value="${requisitionListSAll.orderId}" />
	    	<c:param name="storeId" value="${storeId}"/>
	    	<c:param name="catalogId" value="${catalogId}"/>                            	
	    	<c:param name="langId" value="${langId}"/>                            	
	    </c:url>
        <td id="WC_MiniRequisitionListDisplay_TableCell_36_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><a href="<c:out value="${reqListUpdateUrl}"/>" id="WC_MiniRequisitionListDisplay_Link_4_<c:out value="${istat.count}"/>" class="portlet_content"><c:out value="${requisitionListSAll.description}"/></a></td>
        <c:choose>
        	<c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN'}">
        		<td id="WC_MiniRequisitionListDisplay_TableCell_37_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><c:out value="${requisitionListSAll.userRegistrationDataBean.lastName} ${requisitionListSAll.userRegistrationDataBean.firstName}"/></td>
        	</c:when>
            <c:when test="${locale eq 'zh_TW'}">
            	<td id="WC_MiniRequisitionListDisplay_TableCell_38_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><c:out value="${requisitionListSAll.userRegistrationDataBean.lastName}${requisitionListSAll.userRegistrationDataBean.firstName}"/></td>
            </c:when>
            <c:otherwise>
            	<td id="WC_MiniRequisitionListDisplay_TableCell_39_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><c:out value="${requisitionListSAll.userRegistrationDataBean.firstName} ${requisitionListSAll.userRegistrationDataBean.lastName}"/></td>
 			</c:otherwise>
		</c:choose>
        <td id="WC_MiniRequisitionListDisplay_TableCell_40_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><c:out value="${requisitionListSAll.formattedLastUpdate}"/></td>
        <td id="WC_MiniRequisitionListDisplay_TableCell_41_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"><fmt:message key="ReqList_Type2" bundle="${storeText}" /></td>
        <c:url value="RequisitionListDelete" var="reqListDelUrl">
        	<c:param name="URL" value="${ReloadWithParametersURL}"/>
        	<c:param name="requisitionListId" value="${requisitionListSAll.orderId}" />
        	<c:param name="storeId" value="${storeId}"/>   
        	<c:param name="catalogId" value="${catalogId}"/>                            	
        	<c:param name="langId" value="${langId}"/>                            	                         	
        </c:url>
        <c:choose>
        	<c:when test="${userId eq requisitionListSAll.memberId}" >
        		<td class="<c:out value="${trclass}"/>" id="WC_MiniRequisitionListDisplay_TableCell_42_<c:out value="${istat.count}"/>">
        			<a href="<c:out value="${reqListDelUrl}"/>" id="WC_MiniRequisitionListDisplay_Link_5_<c:out value="${istat.count}"/>" class="garbage" title="<fmt:message key="ReqList_Remove" bundle="${storeText}" />">
        				<img src="<c:out value="${jspStoreImgDir}"/>images/garbage3.gif" alt="<fmt:message key="ReqList_Remove" bundle="${storeText}" />" width="16" height="16" border="0">
        			</a>
        		</td>
        	</c:when>
        	<c:otherwise>
				<td id="WC_MiniRequisitionListDisplay_TableCell_43_<c:out value="${istat.count}"/>" class="<c:out value="${trclass}"/> portlet_content"></td>                            
        	</c:otherwise>
        </c:choose>
	</tr>
</c:if>
</c:forEach>
<c:if test="${rowsTotal != 0}">
	</table>
	<c:if test="${rowsDisplayed < rowsTotal}">
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
		<c:url var="RequisitionListDisplayURL" value="RequisitionListDisplay">
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<c:url var="ReloadWithParametersNextPageURL" value="${ReloadURL}">
			<c:forEach var="parameter" items="${WCParamValues}" >
				<c:if test="${parameter.key != 'CIPReqListPage' && parameter.key != 'logonPassword'}">
					<c:param name="${parameter.key}">
						<c:forEach var="value" items="${parameter.value}" >
							<c:out value="${value}" />
						</c:forEach>
					</c:param>
				</c:if>
			</c:forEach>
			<c:param name="CIPReqListPage" value="${pageToDisplay+1}"/>
		</c:url>
		<c:url var="ReloadWithParametersPrevPageURL" value="${ReloadURL}">
			<c:forEach var="parameter" items="${WCParamValues}" >
				<c:if test="${parameter.key != 'CIPReqListPage' && parameter.key != 'logonPassword'}">
					<c:param name="${parameter.key}">
						<c:forEach var="value" items="${parameter.value}" >
							<c:out value="${value}" />
						</c:forEach>
					</c:param>
				</c:if>
			</c:forEach>
			<c:param name="CIPReqListPage" value="${pageToDisplay-1}"/>
		</c:url>
		<table cellpadding="2" cellspacing="1" border="0" width="100%" id="WC_MiniRequisitionListDisplay_Table_10">
		<tr class="<c:out value="${trclass}"/>"><td id="WC_MiniRequisitionListDisplay_TableCell_34"><table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr class="<c:out value="${trclass}"/>">
				<td class="portlet_content" id="WC_MiniRequisitionListDisplay_TableCell_35">
					<fmt:message key="HUD_Page_Results" bundle="${storeText}">
						<fmt:param value="${rowStart + 1}"/>
						<fmt:param value="${rowStart + rowsDisplayed}"/>
						<fmt:param value="${rowsTotal}"/>
					</fmt:message>
					<c:if test="${pageToDisplay > 0}">
						&nbsp;
						<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_CachedHeaderDisplay_Link_8" class="portlet_content"
						><fmt:message key="HUD_Page_Prev" bundle="${storeText}" /></a>
					</c:if>
					<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
						&nbsp;
						<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_CachedHeaderDisplay_Link_8" class="portlet_content"
						><fmt:message key="HUD_Page_Next" bundle="${storeText}" /></a>
					</c:if>
					<br/>
					<a href="<c:out value="${RequisitionListDisplayURL}" />" id="WC_CachedHeaderDisplay_Link_8" class="portlet_content">
						<fmt:message key="HUD_More" bundle="${storeText}" />
					</a>
				</td>
			</tr>
			</table></td></tr>
		</table>
	</c:if>
	</td></tr></table>
</c:if>
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniRequisitionListDisplay_Table_11">
<tr>
	<td class="portlet_content" id="WC_MiniRequisitionListDisplay_TableCell_36">
		<c:if test="${(empty privateRequisitionLists) && (empty sharedRequisitionLists)}">
			<fmt:message key="ReqList_Text1" bundle="${storeText}" /><br/>
		</c:if>		
		<c:url value="RequisitionListCreateView" var="reqListCreateUrl">
			<c:param name="storeId" value="${storeId}"/>   
			<c:param name="catalogId" value="${catalogId}"/>                            	
			<c:param name="langId" value="${langId}"/>                            	                         	
		</c:url>	
		<br/>
		<a href="<c:out value="${reqListCreateUrl}"/>" class="portlet_button" id="WC_MiniRequisitionListDisplay_Link_7">
			<fmt:message key="ReqList_Create" bundle="${storeText}" />
		</a>
	</td>
</tr>
</table>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerBottom.jsp" />
<% out.flush(); %>
<!--content end-->
<!-- END MiniRequisitionListDisplay.jsp -->


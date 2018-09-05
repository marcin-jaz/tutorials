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
  * This JSP page displays the Requisition List page with the following elements:
  *  - 'View type' drop down used to filter the list by 'All lists' or 'Lists owned by me'
  *  - Requisition lists: table of requisition lists available to the current user.  Each requisition list has a link to
  *			- update or view requisition list details
  *			- remove requisition list (if user is owner)
  *  - 'Create New Requisition List' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<%--
***
* If requisitionListsType has a value of 'Mine', sharedRequisitionLists will 
* refer to shared requisition lists owned by the current user.  Otherwise, it 
* will refer to shared requisition lists available to the current user.
***
--%>
<c:set var="requisitionListsType" value="${WCParam.requisitionListsType}" scope="request" />
<c:choose>
<c:when test="${!empty requisitionListsType && (requisitionListsType eq 'mine' || requisitionListsType eq 'Mine')}">
	<c:set var="requisitionListsType" value="Mine"/>
	<wcbase:useBean id="sOwnedReqListDB" classname="com.ibm.commerce.order.beans.SRequisitionOwnedByMemberIdAndStoreIdListDataBean" scope="page">
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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN RequisitionListDisplay.jsp -->
<head>
<title><fmt:message key="ReqList_Title" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
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
      <table cellpadding="8" cellspacing="0" border="0" width="100%" id="WC_RequisitionListDisplay_Table_2">
        <tr>
          <td id="WC_RequisitionListDisplay_TableCell_3"> 
          <%-- 
			  ***
			  *	Start: View Type
			  * View Type can be 'All' or 'Lists owned by me'.  'All' displays all requisition lists available
			  * to the current user.  'Lists owned by me' displays only those requisition lists owned by the
			  * current user
			  ***
			--%>
          <form name="RequisitionListsTypeForm" action="RequisitionListView" method="post" id="RequisitionListsTypeForm">
          	<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_RequisitionListDisplay_FormInput_storeId_In_RequisitionListsTypeForm"/>
            <input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_RequisitionListDisplay_FormInput_langId_In_RequisitionListsTypeForm"/>
            <input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_RequisitionListDisplay_FormInput_catalogId_In_RequisitionListsTypeForm"/>
              <table id="WC_RequisitionListDisplay_Table_3">
                <tr>
                  <td colspan="2" id="WC_RequisitionListDisplay_TableCell_4"> <h1><fmt:message key="ReqList_Title" bundle="${storeText}" /></h1></td>
                </tr>
                <tr>
                  <td colspan="2" id="WC_RequisitionListDisplay_TableCell_5"><strong><label for="RequisitionListsTypeForm_Type"><fmt:message key="ReqList_ViewType" bundle="${storeText}" /></label></strong></td>
                </tr>
                <tr>
                  <td id="WC_RequisitionListDisplay_TableCell_6"><select class="select" name="requisitionListsType" id="RequisitionListsTypeForm_Type">
                  	  <c:choose>
                      <c:when test="${requisitionListsType eq 'Mine'}">
	                      <option value="All"><fmt:message key="ReqList_Drop1" bundle="${storeText}" /></option>
	                      <option value="Mine" selected="selected"><fmt:message key="ReqList_Drop2" bundle="${storeText}" /></option>
                      </c:when>
                      <c:otherwise>
	                      <option value="All" selected="selected"><fmt:message key="ReqList_Drop1" bundle="${storeText}" /></option>
	                      <option value="Mine"><fmt:message key="ReqList_Drop2" bundle="${storeText}" /></option>
                      </c:otherwise>
                      </c:choose>                
                    </select></td>
                  <td id="WC_RequisitionListDisplay_TableCell_7"> <table cellpadding="8" cellspacing="0" border="0" id="WC_RequisitionListDisplay_Table_4">
                      <tr>
                        <td id="WC_RequisitionListDisplay_TableCell_8"> <a class="button" href="javascript:document.RequisitionListsTypeForm.submit()" id="WC_RequisitionListDisplay_Link_1">
                          <fmt:message key="ReqList_Go" bundle="${storeText}" /></a> </td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td id="WC_RequisitionListDisplay_TableCell_9"></td>
                  <td id="WC_RequisitionListDisplay_TableCell_10"></td>
                </tr>
              </table>
            </form>
            <%-- 
			  ***
			  *	End: View Type
			  ***
			--%>
            <br /> 
            <%-- 
			  ***
			  *	Start: Requisition Lists
			  * Displays private and shared requisition lists available to the current user.
			  ***
			--%>
            <table class="bgColor" width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_RequisitionListDisplay_Table_7">
                          <tr>
                                  <th valign="top" class="colHeader" id="RequisitionListTH_Name"><fmt:message key="ReqList_Name" bundle="${storeText}" /></th>                                                           
                                  <th valign="top" class="colHeader" id="RequisitionListTH_Owner"><fmt:message key="ReqList_Owner" bundle="${storeText}" /></th>                           
                                  <th valign="top" class="colHeader" id="RequisitionListTH_Date"><fmt:message key="ReqList_Date" bundle="${storeText}" /></th>
                                  <th valign="top" class="colHeader" id="RequisitionListTH_Type"><fmt:message key="ReqList_Type" bundle="${storeText}" /></th>
                                  <th valign="top" class="colHeader_last" id="WC_RequisitionListDisplay_TableCell_22">&nbsp;</th>
                          </tr>
                    <c:set var="displaySwitch" value="${true}" />
    				<%--
    				***
    				* Displays the list of private requisition lists available to the current user.  These 
    				* requisition lists are all owned by the user.
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
                            <c:url value="RequisitionListUpdateView" var="reqListUpdateUrl">
                            	<c:param name="requisitionListId" value="${requisitionListP.orderId}" />
                            	<c:param name="storeId" value="${storeId}"/>
                            	<c:param name="catalogId" value="${catalogId}"/>                            	
                            	<c:param name="langId" value="${langId}"/>
                            </c:url>
                            <th headers="RequisitionListTH_Name" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_23_<c:out value="${istat.count}"/>"><a href="<c:out value="${reqListUpdateUrl}"/>" id="WC_RequisitionListDisplay_Link_2_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.description}"/></a></th>
                            <c:choose>
                            <c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN'}">
                            <td headers="RequisitionListTH_Owner" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_24_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.userRegistrationDataBean.lastName} ${requisitionListP.userRegistrationDataBean.firstName}"/></td>
                            </c:when>
                            <c:when test="${locale eq 'zh_TW'}">
                            <td headers="RequisitionListTH_Owner" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_25_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.userRegistrationDataBean.lastName}${requisitionListP.userRegistrationDataBean.firstName}"/></td>
                            </c:when>
                            <c:otherwise>
                            <td headers="RequisitionListTH_Owner" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_26_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.userRegistrationDataBean.firstName} ${requisitionListP.userRegistrationDataBean.lastName}"/></td>
 							</c:otherwise>
                            </c:choose>
                            <td headers="RequisitionListTH_Date" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_27_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.formattedLastUpdate}"/></td>
                            <td headers="RequisitionListTH_Type" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_28_<c:out value="${istat.count}"/>"><fmt:message key="ReqList_Type1" bundle="${storeText}" /></td>
                            <c:url value="RequisitionListDelete" var="reqListDelUrl">
                            	<c:param name="URL" value="RequisitionListView"/>
                            	<c:param name="requisitionListId" value="${requisitionListP.orderId}" />
                            	<c:param name="storeId" value="${storeId}"/>  
                            	<c:param name="catalogId" value="${catalogId}"/>                            	
                            	<c:param name="langId" value="${langId}"/>                            	                          	
                            </c:url>
                            <td class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_29_<c:out value="${istat.count}"/>"><a class="t_button" href="<c:out value="${reqListDelUrl}"/>" id="WC_RequisitionListDisplay_Link_3_<c:out value="${istat.count}"/>"><fmt:message key="ReqList_Remove" bundle="${storeText}" /></a></td>
                          </tr>
    	
    				</c:forEach>
    				<%--
    				***
    				* Displays the list of shared requisition lists available to the current user. 
    				* These requisition lists may be owned by another user if the View type is All
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
                            <%--
                            ***
                            * If the requisition list is owned by the current user,
                            * name is a link to update the requisition list; otherwise
                            * name is a link to view the requisition list details
                            ***
                            --%> 					    
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
                            <th headers="RequisitionListTH_Name" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_30_<c:out value="${istat.count}"/>"><a href="<c:out value="${reqListUpdateUrl}"/>" id="WC_RequisitionListDisplay_Link_4_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.description}"/></a></th>
                            <c:choose>
                            <c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN'}">
                            <td headers="RequisitionListTH_Owner" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_31_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.userRegistrationDataBean.lastName} ${requisitionListSAll.userRegistrationDataBean.firstName}"/></td>
                            </c:when>
                            <c:when test="${locale eq 'zh_TW'}">
                            <td headers="RequisitionListTH_Owner" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_32_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.userRegistrationDataBean.lastName}${requisitionListSAll.userRegistrationDataBean.firstName}"/></td>
                            </c:when>
                            <c:otherwise>
                            <td headers="RequisitionListTH_Owner" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_33_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.userRegistrationDataBean.firstName} ${requisitionListSAll.userRegistrationDataBean.lastName}"/></td>
 							</c:otherwise>
                            </c:choose>
                            <td headers="RequisitionListTH_Date" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_34_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.formattedLastUpdate}"/></td>
                            <td headers="RequisitionListTH_Type" class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_35_<c:out value="${istat.count}"/>"><fmt:message key="ReqList_Type2" bundle="${storeText}" /></td>
                            <%--
                            ***
                            * Remove link is displayed only if the current user owns the requisition list
                            ***
                            --%> 
                            <c:url value="RequisitionListDelete" var="reqListDelUrl">
                            	<c:param name="URL" value="RequisitionListView"/>
                            	<c:param name="requisitionListId" value="${requisitionListSAll.orderId}" />
                            	<c:param name="storeId" value="${storeId}"/>   
                            	<c:param name="catalogId" value="${catalogId}"/>                            	
                            	<c:param name="langId" value="${langId}"/>                            	                         	
                            </c:url>
                            <c:choose>
                            <c:when test="${userId eq requisitionListSAll.memberId}" >
                            <td class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_36_<c:out value="${istat.count}"/>"><a href="<c:out value="${reqListDelUrl}"/>" id="WC_RequisitionListDisplay_Link_5_<c:out value="${istat.count}"/>"><fmt:message key="ReqList_Remove" bundle="${storeText}" /></a></td>
                            </c:when>
                            <c:otherwise>
							<td class="<c:out value="${trclass}"/> t_td" id="WC_RequisitionListDisplay_TableCell_36_<c:out value="${istat.count}"/>"></td>                            
                            </c:otherwise>
                            </c:choose>
                          </tr>
    	
    				</c:forEach>    
                        </table>
            <%-- 
			  ***
			  *	End: Requisition Lists
			  ***
			--%>  
            </td>
        </tr>
        <%--
        ***
        * A message is displayed if there are no requisition lists available to the current user
        ***
        --%>
		<c:if test="${(empty privateRequisitionLists) && (empty sharedRequisitionLists)}">
        <tr>
          <td id="WC_RequisitionListDisplay_TableCell_44"><span class="warning"><fmt:message key="ReqList_Text1" bundle="${storeText}" /></span></td>
        </tr>
		</c:if>
	    <c:url value="RequisitionListCreateView" var="reqListCreateUrl">
	    	<c:param name="storeId" value="${storeId}"/>   
	    	<c:param name="catalogId" value="${catalogId}"/>                            	
	    	<c:param name="langId" value="${langId}"/>                            	                         	
	    </c:url>
        <tr>
          <td id="WC_RequisitionListDisplay_TableCell_45"> <table cellpadding="8" cellspacing="0" border="0" id="WC_RequisitionListDisplay_Table_13">
              <tr>
                <td id="WC_RequisitionListDisplay_TableCell_46"><a href="<c:out value="${reqListCreateUrl}"/>" class="button" id="WC_RequisitionListDisplay_Link_7"> <fmt:message key="ReqList_Create" bundle="${storeText}" /></a></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <!--content end-->

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END RequisitionListDisplay.jsp -->
</html>

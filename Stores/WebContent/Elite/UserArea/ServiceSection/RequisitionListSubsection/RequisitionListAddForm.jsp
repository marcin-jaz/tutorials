<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
       <wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:if test="${WCParam.newList != 'true' && !empty WCParam.requisitionListId}">
   <%-- if newList is true, this mean that an empty list is being created. orderDB is not needed in this case --%>
	<c:set var="requisitionListId" value="${WCParam.requisitionListId}"/>				
	<wcbase:useBean id="orderDB" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
		<c:set target="${orderDB}" property="orderId" value="${requisitionListId}"/>
	</wcbase:useBean>							
</c:if>
			
<!-- create a new  requisition list form -->
<div id="WC_RequisitionListAddForm_div_1" class="requisitionListBorder">
   <div class="requisition_list_info_table">
  
      <div class="row">
         <div class="label" >
       		<c:if test="${WCParam.editable == 'true'}">
       			<div class="requisition_list_required_field" id="WC_RequisitionListAddForm_div_2"> *</div>
       		</c:if>	
		<fmt:message key='REQUISITIONLIST_TABLE_NAME' bundle='${storeText}'/>
	 </div>
         <div class="info_content">
            <c:choose>
               <c:when test="${WCParam.editable == 'true'}">
	         	<label for="requisitionListName" class="nodisplay">
					<fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
						<fmt:param><fmt:message key='REQUISITIONLIST_TABLE_NAME' bundle='${storeText}'/></fmt:param>
						<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param>
					</fmt:message>         		
	       		</label>
               		<input id="requisitionListName" type="text" name="name" size="22" maxlength="254" value="<c:out value="${orderDB.description}"/>" onchange="javascript:RequisitionList.setUnsavedChanges(true);" />
               </c:when>
               <c:otherwise>
                  <span><c:out value="${orderDB.description}"/></span>
               </c:otherwise>
            </c:choose>
         </div>
         <div class="clear_float"></div>
      </div>
 
      <div class="row">
         <div class="label"><fmt:message key='REQUISITIONLIST_TABLE_CREATEDBY' bundle='${storeText}'/></div>
         <div class="info_content" id="createdBy">         
         	<%-- double byte characters won't be displayed properly in IE in ajax mode. 
         	WORKAROUND: in ajax mode, the name is saved in a javascript variable
         	and the postRefreshHandle of MyAccountCenterLinkDisplay_Controller will display it on the page --%>	
         	<flow:ifEnabled feature="AjaxMyAccountPage">
         		<c:if test="${WCParam.editable == 'true'}">
			   	<c:choose>
	               <c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN' || locale eq 'zh_TW'}">
	                  <c:out value="${person.contactInfo.contactName.lastName}"/> <c:out value="${person.contactInfo.contactName.firstName}"/>
	               </c:when>
	               <c:otherwise>
	                  <c:out value="${person.contactInfo.contactName.firstName}"/> <c:out value="${person.contactInfo.contactName.lastName}"/>
	               </c:otherwise>
	            </c:choose>
	           </c:if>
	           <%-- if WCParam.editable is not true, that means the owner does not own this list. 
	           The creator of the requisition list will be printed out with javascript --%>	              
         	</flow:ifEnabled>
         	<flow:ifDisabled feature="AjaxMyAccountPage">
         		<c:choose>
         			<c:when test="${not empty WCParam.createdBy}">
         				<c:out value="${WCParam.createdBy}"/>
         			</c:when>
         			<c:otherwise>
	         			<%-- we are creating a new list. Show the name of the current user. --%>
			         	<c:choose>
			               <c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN' || locale eq 'zh_TW'}">
			                  <c:out value="${person.contactInfo.contactName.lastName}"/> <c:out value="${person.contactInfo.contactName.firstName}"/>
			               </c:when>
			               <c:otherwise>
			                  <c:out value="${person.contactInfo.contactName.firstName}"/> <c:out value="${person.contactInfo.contactName.lastName}"/>
			               </c:otherwise>
			            </c:choose>         			
         			</c:otherwise>
         		</c:choose>
         	</flow:ifDisabled>

         </div>
         <div class="clear_float"></div>
      </div>

      <div class="row">
         <div class="label">
         	<c:if test="${WCParam.editable == 'true'}">
       			<div class="requisition_list_required_field" id="WC_RequisitionListAddForm_div_3"> *</div>
       		</c:if>
       		<fmt:message key='REQUISITIONLIST_TABLE_TYPE' bundle='${storeText}'/>
         </div>
         <div class="info_content">
            <c:choose>
               <c:when test="${WCParam.editable == 'true'}">
               	  <label for="requisitionListType" class="nodisplay">
               	  	<fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
						<fmt:param><fmt:message key='REQUISITIONLIST_TABLE_TYPE' bundle='${storeText}'/></fmt:param>
						<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param>
					</fmt:message>  
               	  </label>
                  <select name="status" id="requisitionListType" onchange="javascript:RequisitionList.setUnsavedChanges(true);">
                     <option value="Y" <c:if test="${orderDB.status eq 'Y'}">selected="selected"</c:if> ><fmt:message key='REQUISITIONLIST_TYPE_PRIVATE' bundle='${storeText}'/></option>
                     <option value="Z" <c:if test="${orderDB.status eq 'Z'}">selected="selected"</c:if> ><fmt:message key='REQUISITIONLIST_TYPE_SHARED' bundle='${storeText}'/></option>
                  </select>
               </c:when>
               <c:otherwise>
               		<c:if test="${orderDB.status eq 'Y'}">
               			<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>private.gif" alt="<fmt:message key="REQUISITIONLIST_TYPE_PRIVATE" bundle="${storeText}"/>"/>
               		</c:if>
                  	<c:if test="${orderDB.status eq 'Z'}">
                  		<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>shared.gif" alt="<fmt:message key="REQUISITIONLIST_TYPE_SHARED" bundle="${storeText}"/>"/>
                  	</c:if>
               </c:otherwise>
            </c:choose>
         </div>
         <div class="clear_float"></div>
      </div>
      
		<c:if test="${!empty requisitionListId}">
	      <div class="row">
	         <div class="label"><fmt:message key='REQUISITIONLIST_TABLE_LASTUPDATED' bundle='${storeText}'/></div>
	         <div class="info_content"><c:out value="${orderDB.formattedLastUpdateTime}"/></div>
	         <div class="clear_float"></div>
	      </div>
		</c:if>
	
   </div>

</div>				



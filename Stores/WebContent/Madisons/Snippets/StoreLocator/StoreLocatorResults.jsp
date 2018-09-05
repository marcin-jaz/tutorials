<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP displays the store locator results.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="fromPage" value="StoreLocator" />
<c:if test="${!empty WCParam.fromPage}">
  <c:set var="fromPage" value="${WCParam.fromPage}" />
</c:if>
<c:if test="${!empty param.fromPage}">
  <c:set var="fromPage" value="${param.fromPage}" />
</c:if>

<c:set var="cityId" value="-999" />
<c:if test="${!empty WCParam.cityId}">
  <c:set var="cityId" value="${WCParam.cityId}" />
</c:if>
<c:if test="${!empty param.cityId}">
  <c:set var="cityId" value="${param.cityId}" />
</c:if>

<wcf:getData type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType[]"
             var="physicalStores" varException="physicalStoreException" expressionBuilder="findPhysicalStoresByGeoNodeUniqueID">
  <wcf:param name="accessProfile" value="IBM_Store_Details" />
  <wcf:param name="uniqueId" value="${cityId}" />
</wcf:getData>

<div class="solid_line"></div>
<div class="number_info">
  <span class="content_text"><fmt:message key="STORE_RESULTS" bundle="${storeText}" /> <span class="small_bold"><fmt:message key="MAKE_SELECTION" bundle="${storeText}" /></span></span>
</div>

  <c:if test="${cityId == -999}">
    <br clear="all" />
    <span class="bold"><fmt:message key="PERFORM_FIND" bundle="${storeText}" /></span>
    <span class="bold"><fmt:message key="ADD_STORE_TO_LIST" bundle="${storeText}" /></span>
  </c:if>

  <c:if test="${!empty physicalStoreException}">
    <c:out value="${physicalStoreException.changeStatus.description.value}" />
  </c:if>
  <c:if test="${empty physicalStoreException}">
    <c:set var="resultNum" value="${fn:length(physicalStores)}" />
    <c:if test="${cityId != -999 && resultNum <= 0}">
      <br clear="all" />
      <div id="no_store_message" tabindex="-1"><span class="bold"><fmt:message key="NO_STORE_EXIST" bundle="${storeText}" /></span></div>
    </c:if>
    <c:if test="${resultNum > 0}">

<table id="bopis_table" tabindex="-1" summary="<fmt:message key='STORE_RESULTS_SUMMARY' bundle='${storeText}' />" cellpadding="0" cellspacing="0" border="0" width="100%">
  <tr class="nested">
    <th class="align_left" id="PhysicalStores_tableCell_result1"><fmt:message key="STORE_RESULTS_COLUMN1" bundle="${storeText}" /></th>
    <th class="align_left" id="PhysicalStores_tableCell_result2"><fmt:message key="STORE_RESULTS_COLUMN2" bundle="${storeText}" /></th>
    <th class="align_left" id="PhysicalStores_tableCell_result3"><fmt:message key="STORE_RESULTS_COLUMN3" bundle="${storeText}" /></th>
  </tr>
            
      <c:forEach var="i" begin="0" end="${resultNum-1}">
        <c:set var="storeHourIndex" value=-1 />
        <c:set var="attributeNum" value="${fn:length(physicalStores[i].attribute)}" />
        <c:if test="${attributeNum > 0}">
          <c:forEach var="j" begin="0" end="${attributeNum - 1}">
            <c:if test="${physicalStores[i].attribute[j].name == 'StoreHours'}">
              <c:set var="storeHoursIndex" value="${j}" />
              <c:set var="j" value="${attributeNum}" />
            </c:if>
          </c:forEach>
        </c:if>
					
  <tr>
    <td width="250" headers="PhysicalStores_tableCell_result1"><p><strong><c:out value="${physicalStores[i].description[0].name}" /></strong></p>
    <p><c:out value="${physicalStores[i].locationInfo.address.addressLine[0]}" /></p>
    <p><c:out value="${physicalStores[i].locationInfo.address.city}" />, <c:out value="${physicalStores[i].locationInfo.address.stateOrProvinceName}" />  <c:out value="${physicalStores[i].locationInfo.address.postalCode}" /></p>
    <p><c:out value="${physicalStores[i].locationInfo.telephone1.value}" /></p></td>
    
    <c:choose>
      <c:when test="${storeHoursIndex > -1}">
        <td width="160" headers="PhysicalStores_tableCell_result2"><c:out value="${physicalStores[i].attribute[storeHoursIndex].displayValue}" escapeXml="false" /></td>
      </c:when>
      <c:otherwise>
        <td width="160" headers="PhysicalStores_tableCell_result2"></td>
      </c:otherwise>
    </c:choose>                 

    <td class="avail" headers="PhysicalStores_tableCell_result3">
      <c:set var="storeExistInCookie" value="false" />
      <c:set var="cookieVal" value="${cookie.WC_physicalStores.value}" />
      <c:set var="cookieVal" value="${fn:replace(cookieVal, '%2C', ',')}"/>
      <c:forTokens items="${cookieVal}" delims="," var="physicalStoreId">
        <c:if test="${physicalStoreId == physicalStores[i].physicalStoreIdentifier.uniqueID}">
          <c:set var="storeExistInCookie" value="true" />
        </c:if>
      </c:forTokens>
		
      <c:choose>
        <c:when test="${storeExistInCookie == 'true'}">
          <div id="addPhysicalStoreToCookieDisabled<c:out value='${physicalStores[i].physicalStoreIdentifier.uniqueID}' />" style="display:block;">
          	<span class="secondary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a id="addPhysicalStoreToCookieDisabledButton<c:out value='${i}' />" disabled="true" >
												<fmt:message key="ADD_PHYSICAL_STORE" bundle="${storeText}" />
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
          </div>
          <div id="addPhysicalStoreToCookie<c:out value='${physicalStores[i].physicalStoreIdentifier.uniqueID}' />" style="display:none;">
          	<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a id="addPhysicalStoreToCookieButton<c:out value='${i}' />" onBlur="JavaScript: this.blur();" onmouseout="JavaScript: this.blur();" href="Javascript:setCurrentId('addPhysicalStoreToCookieButton${i}'); if (storeLocatorJS.addPhysicalStore(<c:out value="${physicalStores[i].physicalStoreIdentifier.uniqueID}" />, <c:out value="${i}" />)) {storeLocatorJS.refreshStoreList('<c:out value="${fromPage}" />');}">
												<fmt:message key="ADD_PHYSICAL_STORE" bundle="${storeText}" />
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
          </div>
        </c:when>
        <c:otherwise>
          <div id="addPhysicalStoreToCookieDisabled<c:out value='${physicalStores[i].physicalStoreIdentifier.uniqueID}' />" style="display:none;">
          	<span class="secondary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a id="addPhysicalStoreToCookieDisabledButton<c:out value='${i}' />" disabled="true">
												<fmt:message key="ADD_PHYSICAL_STORE" bundle="${storeText}" />
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
          </div>
          <div id="addPhysicalStoreToCookie<c:out value='${physicalStores[i].physicalStoreIdentifier.uniqueID}' />" style="display:block;">
          	<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a id="addPhysicalStoreToCookieButton<c:out value='${i}' />" onBlur="JavaScript: this.blur();" onmouseout="JavaScript: this.blur();" href="Javascript:setCurrentId('addPhysicalStoreToCookieButton${i}'); if (storeLocatorJS.addPhysicalStore(<c:out value="${physicalStores[i].physicalStoreIdentifier.uniqueID}" />, <c:out value="${i}" />)) {storeLocatorJS.refreshStoreList('<c:out value="${fromPage}" />');}">
												<fmt:message key="ADD_PHYSICAL_STORE" bundle="${storeText}" />
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
          </div>
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
  
      </c:forEach>
</table>

<span class="bold"><fmt:message key="ADD_STORES_TO_LIST" bundle="${storeText}" /></span>
    </c:if>
  </c:if>

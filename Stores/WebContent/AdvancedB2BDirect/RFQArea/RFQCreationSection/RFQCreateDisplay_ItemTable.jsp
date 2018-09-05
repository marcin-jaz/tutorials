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
  * This JSP page displays an input table for item price adjustment.
  *
  * Required parameters:
  * - catentry_id
  * - defaultCurrency
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQCreateConstants.jspf" %>

<c:set var="wrap" value="${requestScope.wrap}" scope="request" />



 
<c:if test="${itemAB.catalogEntryReferenceNumber != ''}">
	<wcbase:useBean id="ceDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">		
		<c:set target="${ceDB}" property="catalogEntryID" value="${param.catentry_id}" />
	</wcbase:useBean>
	
	
		<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="RFQModifyDisplay_Item"/>
		<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="RFQModifyDisplay_Product"/>
		<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="RFQModifyDisplay_Prebuilt_Kit"/>
		<fmt:message key="RFQModifyDisplay_Bundle" bundle="${storeText}" var="RFQModifyDisplay_Bundle"/>
		<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="RFQModifyDisplay_Dynamic_Kit"/>
	
	
	<c:choose>
		<c:when test="${ceDB.type eq EC_OFFERING_ITEMBEAN}">
			<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type"/>
			
			<wcbase:useBean id="itemAB" classname="com.ibm.commerce.catalog.beans.ItemDataBean">
				<c:set target="${itemAB}" property="initKey_catalogEntryReferenceNumber" value="${param.catentry_id}" />
				<c:set target="${itemAB}" property="itemID" value="${param.catentry_id}" />
			</wcbase:useBean> 		
			<c:set var="catalogEntryDescriptionAB" value="${itemAB.description}"/>
			<c:set var="offerPrice" value="${itemAB.standardPrice}" />  
			<c:set var="partNumber" value="${itemAB.partNumber}" /> 
			<c:set var="manufacturerName" value="${itemAB.manufacturerName}" /> 
			<c:set var="manufacturerPartNumber" value="${itemAB.manufacturerPartNumber}" /> 	
			
		</c:when>
		<c:when test="${ceDB.type eq EC_OFFERING_PRODUCTBEAN}">
			<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}">
			<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
			
			<wcbase:useBean id="packAB" classname="com.ibm.commerce.catalog.beans.PackageDataBean">
				<c:set target="${packAB}" property="initKey_catalogEntryReferenceNumber" value="${param.catentry_id}" />
				<c:set target="${packAB}" property="packageID" value="${param.catentry_id}" />
			</wcbase:useBean> 	
			<c:set var="catalogEntryDescriptionAB" value="${packAB.description}"/>
			<c:set var="offerPrice" value="${packAB.standardPrice}" /> 
			<c:set var="partNumber" value="${packAB.partNumber}" /> 
			<c:set var="manufacturerName" value="${packAB.manufacturerName}" /> 
			<c:set var="manufacturerPartNumber" value="${packAB.manufacturerPartNumber}" /> 	
	 
		</c:when>		
		<c:when test="${ceDB.type eq EC_OFFERING_DYNAMICKITBEAN}">
			<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq 'BundleBean'}">
			<fmt:message key="RFQModifyDisplay_Bundle" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="bundleAB" classname="com.ibm.commerce.catalog.beans.BundleDataBean">
				<c:set target="${bundleAB}" property="initKey_catalogEntryReferenceNumber" value="${param.catentry_id}" />
				<c:set target="${bundleAB}" property="bundleID" value="${param.catentry_id}" />
			</wcbase:useBean> 		
			<c:set var="catalogEntryDescriptionAB" value="${bundleAB.description}"/>
		</c:when>
		<c:otherwise>
			<c:set var="type" value="${ceDB.type}" />
		</c:otherwise>
	</c:choose>
</c:if>     
 

 

<wcbase:useBean id="QuantityUnitList" classname="com.ibm.commerce.common.beans.QuantityUnitListDataBean">
        <c:set target="${QuantityUnitList}" property="languageId" value="${langId}" />
</wcbase:useBean>
<c:set var="quantitiesByLanguage" value="${QuantityUnitList.quantityUnitList}"/>
 

                
  <table cellpadding="0" cellspacing="0" border="0" width="1000" class="bgColor" id="WC_RFQCreateDisplay_Info_Table_1">
	<tbody><tr>
	    <td id="WC_RFQCreateDisplay_Info_TableCell_1">
	    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCreateDisplay_Info_Table_2">
		    <tbody><tr>
                                <th <c:out value="${wrap}" /> id="c1" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemName" bundle="${storeText}" />   </th>
                                <th <c:out value="${wrap}" /> id="c2" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemDesc" bundle="${storeText}" />   </th>
                                <th <c:out value="${wrap}" /> id="c3" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemSKU" bundle="${storeText}" />    </th>
                                <th <c:out value="${wrap}" /> id="c4" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemManu" bundle="${storeText}" />   </th>
                                <th <c:out value="${wrap}" /> id="c5" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemPartNum" bundle="${storeText}" /></th>
                                <th <c:out value="${wrap}" /> id="c6" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemProdType" bundle="${storeText}" /></th>
				<th <c:out value="${wrap}" /> id="c7" valign="center"  class="colHeader_price"> <fmt:message key="RFQCreateDisplay_ItemOfferPrice" bundle="${storeText}" /></th>
				<th <c:out value="${wrap}" /> id="c8" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemPriceAdjustment" bundle="${storeText}" /></th>                                                                                      
                                <th <c:out value="${wrap}" /> id="c9" valign="center"  class="colHeader_price"> <fmt:message key="RFQCreateDisplay_ItemFixedPrice" bundle="${storeText}" />  </th>
                                <th <c:out value="${wrap}" /> id="c10" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemCurr" bundle="${storeText}" />   </th>
                                <th <c:out value="${wrap}" /> id="c11" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemQuan" bundle="${storeText}" />   </th>
                                <th <c:out value="${wrap}" /> id="c12" valign="center"  class="colHeader_last"> <fmt:message key="RFQCreateDisplay_ItemUnit" bundle="${storeText}" />   </th>
                                </tr>
                                <tr>
                                    <td headers="c1" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_3"><c:out value="${catalogEntryDescriptionAB.name}" /></td>
                                    <td headers="c2" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_4">
                                
                               <c:choose>     
                               <c:when test="${ceDB.type eq EC_OFFERING_ITEMBEAN}">     
                              		<c:set var="attrvalues" value="${itemAB.attributeValueDataBeans}" />
                              		<c:forEach items="${attrvalues}" var="attrDB" varStatus="iter">
                                 		 <c:if test="${attrDB.attributeDataBean.usage == null or attrDB.attributeDataBean.usage eq '3' or attrDB.attributeDataBean.usage eq '1'}">
                                  
                                  <c:choose> 
                                  	<c:when test="${attrDB.attributeDataBean.description != null or !empty attrDB.attributeDataBean.description}" >
                                  	 	<strong><c:out value="${attrDB.attributeDataBean.description}" />&nbsp;:&nbsp;</strong><c:out value="${attrDB.value}" /><br />
                                  	</c:when>
                                  	<c:otherwise>
                                  	   	<strong><c:out value="${attrDB.attributeDataBean.name}" />&nbsp;:&nbsp;</strong><c:out value="${attrDB.value}" /><br />
                                  	</c:otherwise>
                                  </c:choose>	                                  	 
                                  </c:if>
                              </c:forEach>
                              </c:when>  
                              <c:when test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}">
                              	<c:out value="${packAB.description.shortDescription}" escapeXml="false"/>
                              </c:when>
                              <c:when test="${ceDB.type eq 'BundleBean'}">
                              	<c:out value="${catalogEntryDescriptionAB.shortDescription}" escapeXml="false"/>
                              </c:when>
                              <c:otherwise>
                              
                              </c:otherwise>
                              </c:choose>
                              
                              
                                    </td>                                                
                                    <td headers="c3" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_5"><c:out value="${partNumber}" /></td>
                                    <td headers="c4" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_6"><c:out value="${manufacturerName}" /></td>
                                    <td headers="c5" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_7"><c:out value="${manufacturerPartNumber}" /></td>
                                    <input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}" />_1" value="<c:out value="${param.catentry_id}" />" />
		                    <td headers="c6" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_8"><c:out value="${type}" /></td>     
		                    <input type="hidden" name="prodType_1" value="<c:out value="${type}" />">
		                    
		                    <c:choose>
					<c:when test="${offerPrice != null}" >
						<td headers="c7" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_9" class="price"><c:out value="${offerPrice}" escapeXml="false" /></td>             		        
					</c:when>
					<c:otherwise>
						<td headers="c7" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_10">&nbsp;</td>
					</c:otherwise>
				    </c:choose>
				    <td headers="c8" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_11">
									 
				    <c:choose>
					<c:when test="${type eq RFQModifyDisplay_Item or type eq RFQModifyDisplay_Product or type eq RFQModifyDisplay_Prebuilt_Kit or type eq RFQModifyDisplay_Dynamic_Kit}">
						<label for="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_1_In_RFQModifyProductForm_1"></label>
							<input size="6" maxlength="9" class="input" type="text" name="<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_1" title="<fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}" /> <c:out value="${catalogEntryDescriptionAB.name}" />" value="" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_1_In_RFQModifyProductForm_1"/>
						
					</c:when>
					<c:otherwise>					
						<input type="hidden" name="<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_1" value="" >				
					</c:otherwise>
				    </c:choose>
		  							</td>                                                        
		                            <!-- input type="hidden" name="<c:out value="${EC_OFFERING_NEGOTIATIONTYPE}" />_1" value="1" / -->
		                            
		                            <input type="hidden" name="<c:out value="${EC_OFFERING_ORDERITEMID}" />_1" value="" />  
		                            
		                            <td headers="c9" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_12"><label for="WC_RFQCreateDisplay_Info_InputCell_1"></label><input class="input" type="text" id="WC_RFQCreateDisplay_Info_InputCell_1" name="<c:out value="${EC_OFFERING_PRICE}" />_1" maxlength="9" size="6" /></td>
		                            <td headers="c10" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_13"><input type="hidden" id="WC_RFQCreateDisplay_Info_InputCell_2" name="<c:out value="${EC_OFFERING_CURRENCY}" />_1" value="<c:out value="${param.defaultCurrency}" />" /><c:out value="${param.defaultCurrency}" /></td>
		                            <td headers="c11" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_14"><label for="WC_RFQCreateDisplay_Info_InputCell_3"></label><input class="input" type="text" id="WC_RFQCreateDisplay_Info_InputCell_3" name="<c:out value="${EC_OFFERING_QUANTITY}" />_1" maxlength="6" size="6" /></td>
		                            <td headers="c12" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_Info_TableCell_15"> <label for="WC_RFQCreateDisplay_Info_Select_1"></label><select class="select" id="WC_RFQCreateDisplay_Info_Select_1" name="<c:out value="${EC_OFFERING_QTYUNIT}" />_1">
		                                	<option value=""></option>
		                                <c:forEach items="${pageScope.quantitiesByLanguage}" var="quantity">
		                                	<option value="<c:out value="${quantity.quantityUnitId}" />"><c:out value="${quantity.description}" /></option>
		                                </c:forEach> 
		                            </select></td>
		                        </tr>
		                        
		                        <input type="hidden" name="<c:out value="${RFQ_EC_OFFERING_CATENTRYID}" />" value="<c:out value="${param.catentry_id}" />" id="WC_RFQCreateDisplay_FormInput_catentry_id_In_RFQCreateForm_1"/>
		                       
		                        <input type="hidden" name="numProd" value="1" id="WC_RFQCreateDisplay_FormInput_numProd_In_RFQCreateForm_1"/>
		                   
		                </tbody>
		            </table>
		            </td>
		        </tr>
		   </tbody>                           
		 </table>                            
		  

                                      

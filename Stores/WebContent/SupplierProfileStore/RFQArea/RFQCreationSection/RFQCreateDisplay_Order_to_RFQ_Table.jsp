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
  * This JSP page displays an input table for items in an order. The orderId
  * is used to find the items associated with the order.
  *
  * Required parameters:
  * - orderId
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
			 
<wcbase:useBean id="orderDB" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
 <c:set target="${orderDB}" property="orderId" value="${param.orderId}" />          

</wcbase:useBean>
<c:set var="orderItemAB" value="${ orderDB.orderItems}" />
                                                           
    <table cellpadding="0" cellspacing="0" border="0" width="1000" class="bgColor" id="WC_RFQCreateDisplay_Info_Table_1">
	<tbody>
		<tr>
		    <td id="WC_RFQCreateDisplay_Info_TableCell_1">
		    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCreateDisplay_Info_Table_2">
			<tbody>
				<tr>
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
                <c:set var="color" value="cellBG_2" />
                <c:set var="orderItemsCount" value="0"/>

                <c:forEach items="${orderItemAB}" var="orderItem" varStatus="iter">
                 	<c:set var="orderItemsCount" value="${iter.count}"/>
                 	
                 	
         			<c:choose>
						<c:when test="${color eq 'cellBG_1'}">
							<c:set var="color" value="cellBG_2" />
						</c:when>
						<c:when test="${color eq 'cellBG_2'}">
							<c:set var="color" value="cellBG_1" />
						</c:when>
					</c:choose>
					

						<wcbase:useBean id="ceDB"
								classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
								<c:set target="${ceDB}" property="catalogEntryID" value="${orderItem.catalogEntryId}" />
								
						</wcbase:useBean>



					<c:choose>
					<c:when test="${ceDB.type eq EC_OFFERING_ITEMBEAN}">
                    	<wcbase:useBean id="itemDB" classname="com.ibm.commerce.catalog.beans.ItemDataBean">
							<c:set target="${itemDB}" property="itemID" value="${orderItem.catalogEntryId}" />							
						</wcbase:useBean> 
						<c:set var="catalogEntryDescriptionAB" value="${itemDB.description}"/>
						<c:set var="attrvalues" value="${itemDB.attributeValueDataBeans}" />						
					</c:when>
					
					<c:when test="${ceDB.type eq EC_OFFERING_PRODUCTBEAN}">
                    	<wcbase:useBean id="prodDB" classname="com.ibm.commerce.catalog.beans.ProductDataBean">
							<c:set target="${prodDB}" property="productID" value="${orderItem.catalogEntryId}" />
							
						</wcbase:useBean> 
						<c:set var="catalogEntryDescriptionAB" value="${prodDB.description}"/>												
					</c:when>	
					 
					
					<c:when test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}">							
						<wcbase:useBean id="packDB" classname="com.ibm.commerce.catalog.beans.PackageDataBean">												
							<c:set target="${packDB}" property="packageID" value="${orderItem.catalogEntryId}" />							
						</wcbase:useBean> 
						<c:set var="catalogEntryDescriptionAB" value="${packDB.description}"/>												
					</c:when>
					
					<c:when test="${ceDB.type eq EC_OFFERING_DYNAMICKITBEAN}">
						<wcbase:useBean id="dynKitDB" classname="com.ibm.commerce.catalog.beans.DynamicKitDataBean">
							<c:set target="${dynKitDB}" property="dynamicKitID" value="${orderItem.catalogEntryId}" />
							
						</wcbase:useBean> 
						<c:set var="catalogEntryDescriptionAB" value="${dynKitDB.description}"/>												
					</c:when>
											
					
					<c:otherwise>
					</c:otherwise>
					</c:choose>	
						
						
						
						
						<c:set var="catid" value="${ orderItem.catalogEntryId}" />
						
		<wcbase:useBean id="QuantityUnitList" classname="com.ibm.commerce.common.beans.QuantityUnitListDataBean">
        <c:set target="${QuantityUnitList}" property="languageId" value="${langId}" />
</wcbase:useBean>
<c:set var="quantitiesByLanguage" value="${QuantityUnitList.quantityUnitList}"/>
 
  
						<c:set var="offerPrice" />  
						<c:set var="type" />
						<c:if test="${orderItem.catalogEntryId != ''}">
							
						
							<c:choose>
								<c:when test="${ceDB.type eq EC_OFFERING_ITEMBEAN}">
									<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type"/>
										<wcbase:useBean id="iDB"
											classname="com.ibm.commerce.catalog.beans.ItemDataBean">
											<c:set target="${iDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
											<c:set target="${iDB}" property="itemID" value="${catid}" />
											
										</wcbase:useBean>
										<c:set var="offerPrice" value="${iDB.standardPrice}" />
								</c:when>
								<c:when test="${ceDB.type eq EC_OFFERING_PRODUCTBEAN}">
									<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
									<wcbase:useBean id="pDB"
										classname="com.ibm.commerce.catalog.beans.ProductDataBean">
										<c:set target="${pDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
										<c:set target="${pDB}" property="productID" value="${catid}" />
										
									</wcbase:useBean>
									<c:set var="offerPrice" value="${pDB.standardPrice}" />
								</c:when>
								<c:when test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}">
									<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
									<wcbase:useBean id="pakDB"	classname="com.ibm.commerce.catalog.beans.PackageDataBean">
										<c:set target="${pakDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
										<c:set target="${pakDB}" property="packageID" value="${catid}" />										
									</wcbase:useBean>
									<c:set var="offerPrice" value="${pakDB.standardPrice}" />
								</c:when>
								
								<c:when test="${ceDB.type eq EC_OFFERING_DYNAMICKITBEAN}">
									<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>																		
														
												
								</c:when> 
								<c:otherwise>
									<c:set var="type" value="${ceDB.type}" />
								</c:otherwise>
							</c:choose>
						</c:if> 
						
						<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="RFQModifyDisplay_Item" />
						<fmt:message key="RFQModifyDisplay_Product"	bundle="${storeText}" var="RFQModifyDisplay_Product" />
						<fmt:message key="RFQModifyDisplay_Dynamic_Kit"	bundle="${storeText}" var="RFQModifyDisplay_Dynamic_Kit" />
						<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="RFQModifyDisplay_Prebuilt_Kit"/>

					

					<tr>

						<td headers="c1" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_4"><c:out value="${catalogEntryDescriptionAB.name}" /></td>
                                <td headers="c2" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_5">
                                
                                <c:choose>
                                <c:when test="${ceDB.type eq EC_OFFERING_ITEMBEAN}">
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
                                  		<c:out value="${pakDB.description.shortDescription}" escapeXml="false"/>
                                  </c:when>                                                                     
                                  </c:choose>
                                  
                                  
                                </td>
			                                                                                                                       
		                        <td headers="c3" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_6"><c:out value="${orderItem.partNumber}" /></td>
		                        <td headers="c4" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_7"><c:out value="${orderItem.catalogEntry.manufacturerName}" /></td>
		                        <td headers="c5" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_8"><c:out value="${orderItem.catalogEntry.manufacturerPartNumber}" /></td>
		                        <input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}" />_<c:out value="${orderItemsCount}" />" value="<c:out value="${orderItem.catalogEntryId}" />" />
                                <input type="hidden" name="<c:out value="${EC_OFFERING_ORDERITEMID}" />_<c:out value="${orderItemsCount}" />" value="<c:out value="${orderItem.orderItemId}" />" />
					<td headers="c6" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_9"><c:out value="${type}" /></td>
                                <input type="hidden" name="prodType_<c:out value="${orderItemsCount}" />" value="<c:out value="${type}" />">                                                                                               
                                
                                <c:choose>
					<c:when test="${offerPrice != null}" >
						<td headers="c7" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_10" class="price"><c:out value="${offerPrice}" escapeXml="false" /></td>             		        
					</c:when>
					<c:otherwise>
						<td headers="c7" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_11">&nbsp;</td>
					</c:otherwise>
				</c:choose>
				<td headers="c8" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_12">
				<c:choose>
									<c:when test="${type eq RFQModifyDisplay_Item or type eq RFQModifyDisplay_Product or type eq RFQModifyDisplay_Prebuilt_Kit }">
										<c:if test="${offerPrice != null}" >
										<label for="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}_${iter.count}" />_In_RFQModifyProductForm_<c:out value="${orderItemsCount}" />"></label>
                                                                           	<input size="6" maxlength="9" class="input"  type="text" name="<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_<c:out value="${orderItemsCount}" />" title="<fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}" /> " value="" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}_${iter.count}" />_In_RFQModifyProductForm_<c:out value="${orderItemsCount}" />"/>
										
                                                                                   </c:if>
										<c:if test="${offerPrice == null}" >
									<input type="hidden" name="<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_<c:out value="${orderItemsCount}" />" value="" >					
										</c:if>
									</c:when>
									<c:when test="${type eq RFQModifyDisplay_Dynamic_Kit}">
									<%--
										if product is a dynamic kit then display percentage adjustment column	
									--%>
								      <label for="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_<c:out value="${orderItemsCount}" />_In_RFQModifyProductForm_<c:out value="${orderItemsCount}"/>"></label>     <input size="6" maxlength="9" class="input" type="text" name="<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_<c:out value="${orderItemsCount}" />" title="<fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}" /> " value="" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_<c:out value="${orderItemsCount}" />_In_RFQModifyProductForm_<c:out value="${orderItemsCount}" />"/>
								
									</c:when>
									<c:otherwise>
										<input type="hidden" name="<c:out value="${EC_OFFERING_PERCENTAGEPRICE}" />_<c:out value="${orderItemsCount}" />" value="" >					
									</c:otherwise>
								</c:choose>  
								 </td> 
								                             
	                            <!-- input type="hidden" name="<c:out value="${EC_OFFERING_NEGOTIATIONTYPE}" />_<c:out value="${orderItemsCount}" />" value="1" / --> 
	                            <td headers="c9" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_13"><label for="WC_RFQCreateDisplay_Order_to_RFQ_FormInput_1" ></label><input class="input" type="text" id="WC_RFQCreateDisplay_Order_to_RFQ_FormInput_1" name="<c:out value="${EC_OFFERING_PRICE}" />_<c:out value="${orderItemsCount}" />" maxlength="9" size="6" /></td>
	                            <td headers="c10" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_14"><input type="hidden" name="<c:out value="${EC_OFFERING_CURRENCY}" />_<c:out value="${orderItemsCount}" />" value="<c:out value="${param.defaultCurrency}" />" /><c:out value="${param.defaultCurrency}" /></td>
	                            <td headers="c11" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_15"><label for="WC_RFQCreateDisplay_Order_to_RFQ_FormInput_2"></label><input class="input" type="text" id="WC_RFQCreateDisplay_Order_to_RFQ_FormInput_2" name="<c:out value="${EC_OFFERING_QUANTITY}" />_<c:out value="${orderItemsCount}" />" maxlength="6" size="6" /></td>
	                            <td headers="c12" class="<c:out value="${color}" /> t_td" id="WC_RFQCreateDisplay_Info_TableCell_16">
		                            <label for="WC_RFQCreateDisplay_Order_to_RFQ_FormSelect_1"></label>
		                            <select class="select" id="WC_RFQCreateDisplay_Order_to_RFQ_FormSelect_1" name="<c:out value="${EC_OFFERING_QTYUNIT}" />_<c:out value="${orderItemsCount}" />">
		                                	<option value=""></option>
		                                <c:forEach items="${pageScope.quantitiesByLanguage}" var="quantity">
		                                	<option value="<c:out value="${quantity.quantityUnitId}" />"><c:out value="${quantity.description}" /></option>
		                                </c:forEach>
		                            </select>
	                           
	                            </td>
		               </tr>   
		               <c:remove var="itemDB"/>  
		               <c:remove var="prodDB"/> 
		               <c:remove var="packDB"/> 
		               <c:remove var="dynKitDB"/>   
		                <c:remove var="ceDB"/>       
		               	
		               <c:remove var="offerPrice"/> 
		               <c:remove var="iDB"/> 	
		               <c:remove var="pDB"/>
		               <c:remove var="pakDB"/>
		               <c:remove var="bundDB"/>
               	</c:forEach>  
	                                                               
                <input type="hidden" name="numProd" value="<c:out value="${orderItemsCount}" />" id="WC_RFQCreateDisplay_FormInput_numProd_In_RFQCreateForm_1"/>        
            </tbody>
            </table>
            </td>
        </tr>
    </tbody>                           
 	</table>                           
                                                                          
                
                
   



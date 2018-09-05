<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2004
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP snippet displays a text box for shipping instructions in a store page where customers
  * enter optional special instructions for a shipping carrier such as 'leave on back porch'
  * 
  * Many shipping instruction boxes are displayed as unique combination of shipping mode id
  * and ship to address that exist in the orders order items.
  * 
  * How to use this snippet?
  * 1. This snippet is available under the WC_installdir or WCDE_installdir (development environment) directory.
  *    The file path of this snippet is samples/Snippets/web/Order/Ship/ShippingInstructionBlocks.jsp.
  *    You should copy it to the Snippets/Order/Ship/ directory under your store directory, you should copy it to your store directory.
  * 2. To display this feature in your store, you need to either 1) create a JSP file based on this code snippet or 2) use the sample wrapper JSP file 
  *    provided along with starter stores and customize it.
  * 3. To include this snippet in your wrapper JSP file, use the following statement:
  *    <c:import url="Snippets/Order/Ship/ShippingInstructionBlocks.jsp" /> , the path in this statement is the relative path of the snippet file to the store directory.
  * 4. To test this snippet, copy the sample wrapper JSP file to your store directory, from samples/JSPs/web/Order/Ship/ to /WAS_installdir/installedApps/cell_name/WC_instance_name.ear/Stores.war/store_dir/
  *    And copy the appropriate snippet file from samples/Snippets/web/Order/Ship/ to /WAS_installdir/installedApps/cell_name/WC_instance_name.ear/Stores.war/store_dir/Snippets/Order/Ship/
  *    You should also copy the required properties files from samples/Snippets/properties/Order/Ship/ to /WAS_installdir/installedApps/cell_name/WC_instance_name.ear/Stores.war/WEB-INF/classes/store_dir/Snippets/Order/Ship/       
  * 5. For details on how to enable 3-D Secure service for your store, please refer to the "WebSphere Commerce Additional Software Guide".
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../OrderEnvironmentSetup.jspf"%>

<flow:fileRef id="vfileColor" fileId="vfile.color"/>
<c:set var="orderId" value="${param.orderId}"/>
   
<wcbase:useBean id="shipInstructsBlockBean" classname="com.ibm.commerce.order.beans.UsableInstructsPerOrderItemBlockListDataBean" scope="page">
	<c:set property="orderId" value="${orderId}" target="${shipInstructsBlockBean}"  />
</wcbase:useBean>

<c:choose>     
	<c:when test="${!empty shipInstructsBlockBean.instructsPerOrderItemBlocks}">
		
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
	<c:if test="${empty pageSize}">
		<c:set var="pageSize" value="20"/>
	</c:if>
	<c:set var="currentPage" value="${WCParam.currentPage}"/>
	<c:if test="${empty currentPage}">
		<c:set var="currentPage" value="1"/>
	</c:if>
	<c:set var="beginIndex" value="${currentPage*pageSize - pageSize}"/>
	
	<c:set var="totalItems" value="0"/>
	<c:forEach items="${shipInstructsBlockBean.instructsPerOrderItemBlocks}" var="instructionBlock_data" varStatus="blocksCounter" >
		<c:forEach items="${instructionBlock_data.orderItems}" var="orderItem" varStatus="itemsCounter">
			<c:set var="totalItems" value="${totalItems + 1}"/>
		</c:forEach>
	</c:forEach>
	<fmt:parseNumber type="number" integerOnly="true" var="totalPages" value="${(totalItems/pageSize)+1}"/>
	
	<fmt:setBundle basename="${snippetJspStoreDir}tooltechtext" var="storeText" />
	<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
		<fmt:param value="${beginIndex+1}"/>
		<fmt:param value="${resultCountOnPage}"/>
		<fmt:param value="${totalItems}"/>
	</fmt:message>
	<c:if test="${resultsText eq '???SEARCH_RESULT_LIST???'}">
		<fmt:setBundle basename="${snippetJspStoreDir}storetext" var="storeText" />
		<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
			<fmt:param value="${beginIndex+1}"/>
			<fmt:param value="${resultCountOnPage}"/>
			<fmt:param value="${totalItems}"/>
		</fmt:message>
	</c:if>

	<c:set var="numberOfBlocks" value="${shipInstructsBlockBean.numberOfBlocks}"/>
	
	<c:set var="loopCount" value="${0}" /> 
	<c:forEach items="${shipInstructsBlockBean.instructsPerOrderItemBlocks}" var="instructionBlock_data" varStatus="counter" >
		<input type=hidden name="shipModeId_<c:out value="${loopCount}"/>" value="<c:out value="${instructionBlock_data.shipModeId}" />">
		<input type=hidden name="addressId_<c:out value="${loopCount}"/>" value="<c:out value="${instructionBlock_data.addressId}" />">
		<table border="0" cellpadding="0" cellspacing="0" class="bgColor" id="WC_ShippingInstructionsBlocks_Table_2">
		<tr>
			<td class="colHeader c_headings" id="WC_ShippingInstructionsBlocks_TableCell_2">
				<c:out value="${instructionBlock_data.shipModeDescDataBean.description}" />
			</td>
		</tr>
		<tr>
			<td class="cellBG_1" id="WC_ShippingInstructionsBlocks_TableCell_3">
				<c:set var="address" value="${instructionBlock_data.addressDataBean}"/>
				<strong><c:out value="${address.nickName}" /></strong>
				<br/>
				<%-- Print the appropriate address information out depending on locale --%>				
				<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>

				<c:if test="${numberOfBlocks == counter.count && numberOfBlocks == 1 && totalItems > pageSize}" >
					<c:choose>
						<c:when test="${currentPage == 1}">
							<c:set var="prevPageIndex" value="1"/>
						</c:when>
						<c:otherwise>
							<c:set var="prevPageIndex" value="${currentPage - 1}"/>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${pageSize*currentPage <= totalItems}">
							<c:set var="nextPageIndex" value="${currentPage + 1}"/>
						</c:when>
						<c:otherwise>
							<c:set var="nextPageIndex" value="${currentPage}"/>
						</c:otherwise>
					</c:choose>
					
					<c:url value="ShippingInstructionsView" var="ShippingInstructionsViewFirstURL">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="langId" value="${CommandContext.languageId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="orderId" value="${orderId}"/>
						<c:param name="pageSize" value="${pageSize}"/>
						<c:param name="currentPage" value="1"/>
					</c:url>
					<c:url value="ShippingInstructionsView" var="ShippingInstructionsViewPrevURL">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="langId" value="${CommandContext.languageId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="orderId" value="${orderId}"/>
						<c:param name="pageSize" value="${pageSize}"/>
						<c:param name="currentPage" value="${prevPageIndex}"/>
					</c:url>
					<c:url value="ShippingInstructionsView" var="ShippingInstructionsViewNextURL">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="langId" value="${CommandContext.languageId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="orderId" value="${orderId}"/>
						<c:param name="pageSize" value="${pageSize}"/>
						<c:param name="currentPage" value="${nextPageIndex}"/>
					</c:url>
					<c:url value="ShippingInstructionsView" var="ShippingInstructionsViewLastURL">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="langId" value="${CommandContext.languageId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="orderId" value="${orderId}"/>
						<c:param name="pageSize" value="${pageSize}"/>
						<c:param name="currentPage" value="${totalPages}"/>
					</c:url>
					<c:url value="ShippingInstructionsView" var="ShippingInstructionsViewJumpURL">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="langId" value="${CommandContext.languageId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="orderId" value="${orderId}"/>
						<c:param name="pageSize" value="${pageSize}"/>
					</c:url>
				
					<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_ShippingInstructionBlocks_Table_2">
						<tr>
							<td id="WC_ShippingInstructionBlocks_TableCell_2">	
								<table cellpadding="0" cellspacing="0" border="0" id="WC_ShippingInstructionBlocks_Table_3">
									<tr>
										<td id="WC_ShippingInstructionBlocks_TableCell_5"><a href="<c:out value="${ShippingInstructionsViewFirstURL}" />" id="WC_ShippingInstructionBlocks_Link_1"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_first.gif" alt="<fmt:message key="SEARCH_FIRST" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>																					
										<td class="ps_pad" id="WC_ShippingInstructionBlocks_TableCell_6"><a href="<c:out value="${ShippingInstructionsViewPrevURL}" />" id="WC_ShippingInstructionBlocks_Link_2"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_previous.gif" alt="<fmt:message key="SEARCH_PREV" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>
										<fmt:message var="pageNumberText" key="PAGE_NUMBER" bundle="${storeText}">
											<fmt:param><c:out value="${currentPage}" /></fmt:param>
											<fmt:param><c:out value="${totalPages}" /></fmt:param>
										</fmt:message>
										<td class="ps_text" id="WC_ShippingInstructionBlocks_TableCell_7"><c:out value="${pageNumberText}" /></td>																		
										<td class="ps_pad" id="WC_ShippingInstructionBlocks_TableCell_8"><a href="<c:out value="${ShippingInstructionsViewNextURL}" />" id="WC_ShippingInstructionBlocks_Link_3"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_next.gif" alt="<fmt:message key="SEARCH_NEXT" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>									
										<td class="ps_pad" id="WC_ShippingInstructionBlocks_TableCell_9"><a href="<c:out value="${ShippingInstructionsViewLastURL}" />" id="WC_ShippingInstructionBlocks_Link_4"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_last.gif" alt="<fmt:message key="SEARCH_LAST" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>
										<td class="ps_text" id="WC_ShippingInstructionBlocks_TableCell_10"><label for="WC_ShippingInstructionBlocks_JumpToPage"><fmt:message key="JUMP_TO_PAGE" bundle="${storeText}"/></label></td>
										<td class="ps_pad" id="WC_ShippingInstructionBlocks_TableCell_11"><input type="text" maxlength="4" size="3" class="ps_input" name="currentPage" id="WC_ShippingInstructionBlocks_JumpToPage"><input type="hidden" name="pageSize" value="<c:out value="${pageSize}"/>" id="WC_ShippingInstructionBlocks_FormInput_pageSize_In_JumpToPageForm_1"/></td>
										<td class="ps_pad" id="WC_ShippingInstructionBlocks_TableCell_12"><a href="javascript:jumpToPage(document.ShippingInstructionBlocksForm, '<c:out value="${ShippingInstructionsViewJumpURL}" />');" id="WC_ShippingInstructionBlocks_Link_5"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_page_jump.gif" alt="<fmt:message key="SEARCH_JUMP" bundle="${storeText}" />" width="16" height="16" border="0"></a></td>
									</tr>
								</table>
							</td>
							<td align="right" id="WC_ShippingInstructionBlocks_TableCell_12a">
								<table cellpadding="0" cellspacing="0" border="0" id="WC_ShippingInstructionBlocks_Table_3a">
									<tr>
									  <c:set var="resultCountOnPage" value="${pageSize + beginIndex}"/>
										<c:choose>
											<c:when test="${resultCountOnPage > totalItems}">
												<c:set var="resultCountOnPage" value="${totalItems}"/>
											</c:when>
										</c:choose>
										<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
											<fmt:param value="${beginIndex+1}"/>
											<fmt:param value="${resultCountOnPage}"/>
											<fmt:param value="${totalItems}"/>
										</fmt:message>
										<td class="ps_text" id="WC_ShippingInstructionBlocks_TableCell_301"><c:out value="${resultsText}" /></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</c:if>
				
				<c:if test="${ (totalItems <= pageSize) || ( numberOfBlocks == counter.count && numberOfBlocks == 1 && totalItems > pageSize) }" >
					<table cellpadding="2" cellspacing="1" border="0" class="bgColor" id="WC_ShippingInstructionsBlocks_Table_3">
						<%--
							***
							* Start: Display the main heading
							***
						--%>
						<tr class="bgColor">
							<c:if test="${showItemId eq true}">
								<th valign="top" class="colHeader" id="WC_ShippingInstructionsBlocks_ItemID" >
									<fmt:message key="ShippingMethod_ITEM_ID" bundle="${orderText}" />
								</th>
							</c:if>
							<th valign="top" class="colHeader" id="WC_ShippingInstructionsBlocks_ItemDesc">
								<fmt:message key="ShippingMethod_DESC" bundle="${orderText}" />
							</th>
							<th valign="top" class="colHeader" id="WC_ShippingInstructionsBlocks_ItemQty" >
								<span class="t_hd_cntr">
								<fmt:message key="ShippingMethod_QTY" bundle="${orderText}" />
								</span>
							</th>
							<th valign="top" class="colHeader" id="WC_ShippingInstructionsBlocks_ItemAvailDate">
								<fmt:message key="ShippingMethod_AVAILABLE_DATE" bundle="${orderText}" />
							</th>
							<th valign="top" class="colHeader_last" id="WC_ShippingInstructionsBlocks_ItemShipOptions">
								<fmt:message key="ShippingMethod_SHIPPING_OPTIONS" bundle="${orderText}" />
							</th>
							<c:if test="${showTieCode eq true}">
								<th valign="top" class="colHeader" id="WC_ShippingInstructionsBlocks_ItemTieCode">
									<fmt:message key="ShippingMethod_TIESHIPCODE" bundle="${orderText}" />
								</th>
							</c:if>
						</tr>
						<%--
							***
							* End: Display the main heading
							***
						--%>
			
			
						<%--
							***
							* Start: Display advanced order item information
							* For each order item, it displays the following information:
							*  - orderitem_id
							*  - quantity
							*  - item short description
							*  - available ship time
							*  - req ship date
							*  - isExpedited
							***
						--%>
						<c:set var="sRowColor" value="cellBG_1"/>
						<c:forEach items="${instructionBlock_data.orderItems}" var="orderItem" varStatus="counter">
							<c:if test="${ (counter.index >= beginIndex) && (counter.index < currentPage*pageSize) }">
								<c:choose>
									<c:when test="${orderItem.catalogEntryDataBean.package}">
										<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.packageDataBean}"/>
										<c:set var="catalogEntryId" value="${catalogEntry.packageID}"/>
									</c:when>
									
									<c:when test="${orderItem.catalogEntryDataBean.item}">
										<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.itemDataBean.parentProductDataBean}"/>
										<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
									</c:when>
									
									<c:otherwise>
										<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.productDataBean}" />
										<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
									</c:otherwise>
								</c:choose>
								<c:choose>
						            <c:when test="${sRowColor eq 'cellBG_1'}">
						               <c:set var="sRowColor" value="cellBG_2"/>
						        	</c:when>
						            <c:otherwise>
						               <c:set var="sRowColor" value="cellBG_1"/>
						            </c:otherwise>
								</c:choose>
								<tr valign="top">
								    <c:if test="${showItemId eq true}">
										<td headers="WC_ShippingInstructionsBlocks_ItemID" class="<c:out value="${sRowColor}"/> t_td" align="left" valign="top" id="WC_ShippingInstructionsBlocks_TableCell_ItemID_<c:out value="${counter.count}"/>">
											<c:out value="${orderItem.orderItemId}"/>
										</td>
									</c:if>
									<td headers="WC_ShippingInstructionsBlocks_ItemDesc" class="<c:out value="${sRowColor}"/> t_td" width="30%" id="WC_ShippingInstructionsBlocks_TableCell_ItemDesc_<c:out value="${counter.count}"/>" >
										 <%-- 
											 ***
											 * Display the item name as a link to the product display page 
											 ***
										 --%>
										 <c:url var="ProductDisplayURL" value="ProductDisplay">
												<c:param name="langId" value="${langId}" />
												<c:param name="storeId" value="${WCParam.storeId}" />
												<c:param name="catalogId" value="${WCParam.catalogId}" />
												<c:param name="productId" value="${catalogEntryId}" />
										</c:url>
										<a href="<c:out value="${ProductDisplayURL}"/>" id="WC_ShippingInstructionBlocks_Link_1_<c:out value="${counter.count}"/>">
											<c:out value="${catalogEntry.description.name}" escapeXml="false"  /><br/>
										</a>
									
										<%-- Display the order item SKU number --%>
										<fmt:message key="ShippingMethod_SKU" bundle="${orderText}"/> <c:out value="${orderItem.catalogEntryDataBean.partNumber}" escapeXml="false"/>
									</td>
									<td headers="WC_ShippingInstructionsBlocks_ItemQty" class="<c:out value="${sRowColor}"/> t_td" align="center" id="WC_ShippingInstructionsBlocks_TableCell_ItemQty_<c:out value="${counter.count}"/>">
										<c:set value="${counter.count}" var="rows2" scope="application" />
										<%-- Display the quantity  --%>
										<c:out value="${orderItem.formattedQuantity}"/>
									</td>
									<td headers="WC_ShippingInstructionsBlocks_ItemAvailDate" class="<c:out value="${sRowColor}"/> t_td" id="WC_ShippingInstructionsBlocks_TableCell_ItemAvailDate_<c:out value="${counter.count}"/>">
										<%-- Display item estimatedShippingTime --%>
										<c:out value="${orderItem.formattedEstimatedShippingTime}" escapeXml="false" >
											<fmt:message key="ShippingMethod_NO_TIME_AVAILABLE" bundle="${orderText}" /> 
										</c:out>
									</td>
									<td headers="WC_ShippingInstructionsBlocks_ItemShipOptions" class="<c:out value="${sRowColor}"/> t_td" id="WC_ShippingInstructionsBlocks_TableCell_ItemShipOptions_<c:out value="${counter.count}"/>">
										<c:if test="${!empty orderItem.requestedShipDateYear}" > 
											<fmt:message key="ShippingMethod_REQUESTED_SHIP_DATE" bundle="${orderText}" />
											<br/>
											<c:out value="${orderItem.formattedRequestedShipDate}"/>
											<br/>
						                		</c:if>
										<c:if test="${orderItem.expedited}" > 
											<fmt:message key="ShippingMethod_EXPEDITE" bundle="${orderText}" />
										</c:if>
					                		</td>
									<c:if test="${showTieCode eq true}">
										<td headers="WC_ShippingInstructionsBlocks_ItemTieCode" class="<c:out value="${sRowColor}"/> t_td" align="left" valign="top" id="WC_ShippingInstructionsBlocks_TableCell_ItemTieCode_<c:out value="${counter.count}"/>"><font class="text">
											<label for="tieShipCode_<c:out value="${counter.count}"/>"></label><input size="3" name="tieShipCode_<c:out value="${counter.count}"/>" id="tieShipCode_<c:out value="${counter.count}"/>" value='<c:out value="${orderItem.tieCode}"/>' /></font>
										</td>
									</c:if>
								</tr>
							</c:if>
						</c:forEach>
			
						<%--
							***
							* End: Display advanced order item information
							***
						--%>			
					</table>
				</c:if>
				
			</td>
		</tr>
		
		<tr class="cellBG_1">
			<td class="c_headings" id="WC_ShippingInstructionsBlocks_TableCell_4">
				<label for="shipInstructions_<c:out value="${loopCount}"/>"><fmt:message key="ShippingMethod_AddInstructions" bundle="${orderText}" /></label><br/>
				<textarea rows="3" cols="60" name="shipInstructions_<c:out value="${loopCount}"/>" id="shipInstructions_<c:out value="${loopCount}"/>"><c:out value="${instructionBlock_data.shipInstructions}" /></textarea>
			</td>
		</tr>
		<tr>
				<td class="c_line" id="WC_ShippingInstructionsBlocks_TableCell_5">&nbsp;</td>
		</tr>
		<tr>
				<td id="WC_ShippingInstructionsBlocks_TableCell_6">&nbsp;</td>
		</tr>
		</table>
		<c:set var="loopCount" value="${loopCount + 1}" /> 
	</c:forEach>	
	</c:when>
	<c:otherwise>
		<span class="error"><fmt:message key="ShippingMethod_NoShipBlocks" bundle="${orderText}" /></span>
	</c:otherwise>
</c:choose>

<script type="text/javascript" language="javascript">
<!--<![CDATA[
function jumpToPage(form, url)
{
		var pageNumber = parseInt(form.currentPage.value);
    if ( pageNumber !="NaN" && pageNumber >=1 && pageNumber <= <c:out value="${totalPages}" /> ) {
    	 document.location.href = url + "&currentPage=" + pageNumber;
    } else {
    	alert("<fmt:message key="SEARCH_INVALID_PAGE_NUM" bundle="${storeText}"/>");
    }
}
//[[>-->
</script>

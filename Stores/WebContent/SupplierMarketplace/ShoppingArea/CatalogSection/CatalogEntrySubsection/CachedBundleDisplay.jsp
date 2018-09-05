<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2005
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->

<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>

<% // Page specific beans%>
<%@ page import="java.lang.*" %>   <% // Needed for: Long %>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.RoleDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CompositeProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CompositeItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.supplychain.beans.SupplierHubItemDataBean" %>
<%@ page import="com.ibm.commerce.contract.beans.ContractDataBean" %>
<%@ page import="com.ibm.commerce.price.beans.PriceDataBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.AttributeAccessBean" %>
<%@ page import="com.ibm.commerce.negotiation.beans.AuctionInfoDataBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<wcbase:useBean id="bundle" classname="com.ibm.commerce.catalog.beans.BundleDataBean" />

<%
try {
    // JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted

    JSPHelper jhelper = new JSPHelper(request);

    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String storeId = jhelper.getParameter("storeId");
    String bundleId = jhelper.getParameter("productId");
    String fromIntList = jhelper.getParameter("fromIntList");
    String userState = jhelper.getParameter("userState");
    String registeredUser = jhelper.getParameter("registeredUser");
    String rfqLinkDisplayed = jhelper.getParameter("rfqLinkDisplayed");

    // support displaying prices for items in bundle
    String contractStoreIdStr = jhelper.getParameter("contractStoreId");

    // --- bundle ------- //
    //no products in bundle
    //CompositeProductDataBean[] compositeProducts = packageDB.getPackagedProducts();
    CompositeItemDataBean[] compositeItems = bundle.getBundledItems();

    //Item information
    ItemDataBean item_in_bundle = null;
    SupplierHubItemDataBean hubItem = null;
    Integer[] nApplicableSupplierStoreIds = null;

    // Determine the suppliers, if any, that support all items in this bundle
    Vector applicableSuppliersForBundle = new Vector();
    for (int k=0; k < compositeItems.length; k +=1){
        item_in_bundle = compositeItems[k].getItem();
        hubItem = new SupplierHubItemDataBean(item_in_bundle, item_in_bundle.getCommandContext());
        hubItem.setErrorMode(false);
        nApplicableSupplierStoreIds = hubItem.getApplicableSupplierStoreIds();
        PriceDataBean[] itemApplicableContractPrices = hubItem.getApplicableContractPrices();

        Vector supplierList = new Vector();
        // retain those suppliers that have a price
		if (itemApplicableContractPrices != null) {
			for (int j=0; j < itemApplicableContractPrices.length; j +=1){
				if (itemApplicableContractPrices[j] != null && !supplierList.contains(nApplicableSupplierStoreIds[j])) {
					supplierList.addElement(nApplicableSupplierStoreIds[j]);
				}
			}
		}

        if (k == 0){
            applicableSuppliersForBundle.addAll(supplierList);
        } else {
            applicableSuppliersForBundle.retainAll(supplierList);
        }
    }

%>

<script language="javascript">
	var busy = false;

	function Add2MarketPlaceShopCart(form) {
		if (!busy) {
			busy = true;
			form.action='CatalogItemAdd';
			form.URL.value='OrderItemDisplay?orderId=*';
			form.contractId.value='';
			form.submit();
		}
	}

	function selectCmdStoreId(form, sCmdStoreId) {
		form.cmdStoreId.value=sCmdStoreId;
	}


	function Add2ShopCart(form)
	{
		if (!busy) {
			if (form.cmdStoreId.value == "") {
				alert("<%=tooltechtext.getString("ItemDisp_ContractNotSelected")%>");
				return false;
			}
			busy = true;
			form.action='OrderItemAdd';
			//alert("cmdStoreId=" + form.cmdStoreId.value);
			form.URL.value="OrderItemDisplayViewShiptoAssoc?cmdStoreId=";
			//form.URL.value="OrderItemDisplay?cmdStoreId=&orderId=*";
			form.submit();
		}
	}

	function Add2InterestList(form) {
		if (!busy) {
			busy = true;
			form.submit();
		}
	}
/*
	function Add2ShopCart(form) {
		if (!busy) {
			busy = true;
			form.action="CatalogItemAdd";
			form.URL.value='OrderItemDisplay?orderId=*';
			form.submit();
		}
	}
*/
	function Add2ReqList(form) {
		if (!busy) {
			busy = true;
            // copy values from OrderItemAddForm
			form.reqListStoreId.value = document.OrderItemAddForm.cmdStoreId.value;
            for (var i=1; i < <%=compositeItems.length + 1 %>; i++){
                form["quantity_"+i].value = document.OrderItemAddForm["quantity_"+i].value;
                form["partNumber_"+i].value = document.OrderItemAddForm["partNumber_"+i].value;
                form["contractId_"+i].value = document.OrderItemAddForm["contractId_"+i].value;
            }

			if (form.reqListStoreId.value == "") {
				alert("<%=tooltechtext.getString("ItemDisp_ContractNotSelected")%>");
				busy = false;
				return false;
			}
			if (form.Type[0].checked)  {
				form.action="RequisitionListCreateView";
			} else {
				form.action="AddToExistReqListView";
			}
			form.submit();
		}
	}

	function Add2RFQ(form) {
		if (!busy) {
			busy = true;
			if (form.Type[0].checked) {
				form.action="RFQCreateDisplay";
			} else 	{
				form.action="AddToExistRFQListDisplay";
			}
			form.submit();
		}
	}

</script>

	<TABLE CELLPADDING="8">
	<tr>
		<td>
			<h1><%=tooltechtext.getString("BundleDisp_Title")%></h1>
			<table border="0" cellspacing="0" cellpadding="0">
				<!-- Display Interest List Subtitle -->
<%
				if (fromIntList != null) {
					if (fromIntList.equals("1")) {
%>
					  	<tr>
					  		<td COLSPAN="2">
					  			<font color="#E7B610" style="font-family : Verdana;" size="2">
					  			<strong><%=tooltechtext.getString("Item_interestitem_add_OK")%></strong>
					  			<br />
					  			</font>
					  			<br />
					  		</td>
					  	</tr>

<%
			  		}
			   	}

%>
				<font class="subHeading"><b><%=bundle.getDescription().getShortDescription()%></b></font><br />
				<font class="text"><%=bundle.getDescription().getLongDescription()%></font><br />
                <br>
<!-- Start to display attachments -->
            <tr>
				<td COLSPAN="2">
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${bundle.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${bundle}" />
											<table border="0" id="WC_CatalogAttachment_Table_1">
											<tr><td id="WC_CatalogAttachment_TableCell_1">
												<table border="1" cellpadding="0" cellspacing="0" width="100%" id="WC_CatalogAttachment_Table_2">
												<tr><td class="labelText1" height="16" nowrap id="WC_CatalogAttachment_TableCell_2"><span class="strongtext"><c:out value="${attachUsage.name}"  /><br /></span></td></tr>
												</table>
												<table border="1" width="100%" id="WC_CatalogAttachment_Table_3">
												<tr>
													<td class="mainContent" id="WC_CatalogAttachment_TableCell_3"> 
														<c:set var="maxNumDisp" value ="4"/>
														<c:set var="maxItemsInRow" value ="1"/>
														<c:set var="showName" value="true" /> 
														<c:set var="showShortDescription" value="false" />
														<c:set var="AttachmentDataBeans" value="${bundle.attachmentsByUsage}" />
                                                        <c:set var="iconImagePath" value="<%=fileDir%>"  />
														<%@ include file="../../../Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jspf" %>
													</td>			
												</tr>
												</table>
											</td></tr>
											</table><br/>
										</c:forEach>
										<%--
											***
											* End: Show Catalog Attachment
											***
										--%>
				</td>
            </tr>
<!-- End to display attachments -->
<%
                 // there are suppliers that support this bundle
                Integer selectedSupplierId = new Integer(0);
				String selectedSupplierName = "";
                if (applicableSuppliersForBundle.size() > 0){
%>
                <table>
					<tr>
						<td>
							<b><label for="contractStoreId"><%= tooltechtext.getString("SupplierDropDown_SelectSupplier") %></label></b>
						</td>
							<form name="SelectSupplier" action="ProductDisplay">
						<td>
								<input type="hidden" name="langId" value="<%= lang %>">
								<input type="hidden" name="storeId" value="<%= storeId %>">
								<input type="hidden" name="productId" value="<%= bundleId %>">
								<input type="hidden" name="catalogId" value="<%= catalogId %>">
				<select name="contractStoreId" id="contractStoreId">
                    <%
						com.ibm.commerce.common.objects.StoreAccessBean supplierStore;
                        Integer supplierStoreId;
                        String selected = "";
						String supplierStoreName = "";
                        // if no supplier was specified, choose the first
                        if ((contractStoreIdStr == null) || (contractStoreIdStr.length() == 0) || contractStoreIdStr.equals("null")){
                            contractStoreIdStr = ((Integer) applicableSuppliersForBundle.elementAt(0)).toString();
                        }

                        for(int i=0; i < applicableSuppliersForBundle.size(); i+=1)
                        {
                                supplierStoreId = (Integer) applicableSuppliersForBundle.elementAt(i);
                                supplierStore = cmdcontext.getStore(supplierStoreId);
								if(supplierStore.getStatus().equals("1")){
								try {
									supplierStoreName = supplierStore.getDescription(lang).getDisplayName();
								} catch (Exception e) {
									supplierStoreName = supplierStoreId.toString();
								}

                                if (supplierStoreId.toString().equals(contractStoreIdStr)){
                                    selected = "selected";
                                    selectedSupplierId = supplierStoreId;
                                    selectedSupplierName = supplierStoreName;
                                } else {
                                    selected = "";
                                }

                    %>
                    <option <%=selected%> value=<%=supplierStoreId%>><%=supplierStoreName%></option>
                    <% }} %>
                </select>
						</td>
							</form>
						<td>
							<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
							</tr>
							<tr>
								<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td bgcolor="#ea2b2b">
									<table cellpadding="2" cellspacing="0" border="0">
									<tr>
										<td class="buttontext">
											<font color="#ffffff"><b>
											<a href="javascript:document.SelectSupplier.submit()"  style="color:#ffffff; text-decoration : none;">
											<%= tooltechtext.getString("SupplierDropDown_Go") %>
											</a>
											</b></font>
										</td>
									</tr>
									</table>
								</td>
								<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							</tr>
							<tr>
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							</tr>
							</table>
						</td>
					</tr>
                    </table>
                <br/><br/>
<%
                } // else display instruction that item may be added individually
%>

				<!-- Display Item Information-->
				<FORM NAME="OrderItemAddForm" ACTION="" Method="post">
					<input type="hidden" name="orderId" value=".">
					<input type="hidden" name="langId" value="<%= languageId %>">
					<input type="hidden" name="catalogId" value="<%= catalogId %>">
					<input type="hidden" name="URL" value="">
					<input type="hidden" name="allocate" value="*n">
					<input type="hidden" name="reverse" value="*n">
					<input type="hidden" name="backorder" value="*n">

					<!-- Code for Add to Interest List -->
					<input type="hidden" name="productId" value="<%=bundleId%>">
					<input type="hidden" name="fromIntList" value="">
                    <input type="hidden" name="cmdStoreId" value="<%=contractStoreIdStr%>"/>
<%

ItemDataBean item = new ItemDataBean();
 Long[] itemApplicableContractIds = null;
 PriceDataBean[] itemApplicableContractPrices = null;
for (int k = 0; k < compositeItems.length; k++)
{
    // create a new item data bean, set supplier store id and populate
    item = new ItemDataBean();
	item.setItemID(compositeItems[k].getItem().getItemID());
    item.setErrorMode(false);
    cmdcontext.changeStore(selectedSupplierId);
    DataBeanManager.activate(item, request);
    //cmdcontext.restoreStore();

%>
			    <table cellpadding="2" cellspacing="2" border="0">
				<tr>
					<td VALIGN="top">
						<IMG HEIGHT="150" ALT="<%=item.getDescription().getShortDescription()%>" SRC="<%=fileDir%><%=item.getDescription().getFullImage()%>" WIDTH="150" BORDER="0">&nbsp;
					</td>

					<td VALIGN="top">
						<FONT CLASS="P">

						<FONT COLOR="#4C6178" STYLE="font-family : Verdana;" SIZE="2">
						<b><%=item.getDescription().getShortDescription()%></b>
						</FONT>

						<br />

						<%=item.getDescription().getLongDescription()%>
						<br /><br />

						<STRONG><%=tooltechtext.getString("ItemDisp_SKU")%></STRONG>
						<a class="catalog" href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=item.getItemID()%>&langId=<%=languageId%>"><%=item.getPartNumber()%></a>

						<br />

						<STRONG><%=tooltechtext.getString("ItemDisp_ItemID")%></STRONG> <%=item.getItemID()%><br />
						<STRONG><%=tooltechtext.getString("ItemDisp_Man")%></STRONG><%=item.getManufacturerName()%><br />
						<STRONG><%=tooltechtext.getString("ItemDisp_ManPart")%></STRONG> <%=item.getManufacturerPartNumber()%>

						<br /><br />
						<%
						AttributeValueDataBean attrvalue[];
						attrvalue = item.getAttributeValueDataBeans(new Integer(languageId));

				                // Loop through attributes values and only show the value that is relavent to the attribute for this SKU
				                for (int x=0; x < attrvalue.length; x++)
				              	{
				                     %>
				                     <strong><%=attrvalue[x].getAttributeDataBean().getDescription()%> : </strong>
				                     <%=attrvalue[x].getValue()%><br>
				              	     <%
				              	}

                    // only show contracts if there is one common supplier with prices for all items
                if (applicableSuppliersForBundle.size() > 0){
				              	%>

                    <!-- contract price table -->
                    <table width="100%" border="0" cellpadding="2" cellspacing="1">
						<tr bgcolor="#4c6178">
							<td class="list_header"></td>
							<td>
								<table>
								<tr>
									<td>
										<font style="font-family : Verdana;" color="#ffffff">
										<strong><%=tooltechtext.getString("ItemDisp_Store")%></strong>
										</font>
									</td>
								</tr>
								</table>
							</td>
							<td>
								<table>
								<tr>
									<td>
										<font style="font-family : Verdana;" color="#ffffff">
										<strong><%=tooltechtext.getString("ItemDisp_Contract")%></strong>
										</font>
									</td>
								</tr>
								</table>
							</td>
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
                  								<font style="font-family : Verdana;" color="#ffffff">
                  								<strong><%=tooltechtext.getString("ItemDisp_Price")%></strong>
                  								</font>
                  							</td>
								</tr>
								</TABLE>
							</td>
						</tr>


<%
                        // Get Contract information
                        // only done if there is a supplier (TODO)


                        itemApplicableContractIds = item.getApplicableContractIds();
                        itemApplicableContractPrices = item.getApplicableContractPrices();
                        ContractDataBean cdb[] = null;

                        if (itemApplicableContractIds != null) {
                        	cdb = new ContractDataBean[itemApplicableContractIds.length];

                        	for (int i = 0; i< itemApplicableContractIds.length; i++) {
                        		cdb[i] = new ContractDataBean();
                        		cdb[i].setDataBeanKeyReferenceNumber(itemApplicableContractIds[i].toString());
                        		DataBeanManager.activate(cdb[i], request);
                        	}

                            // if there is at least one price, this item can be added
                            if (itemApplicableContractIds.length > 0){
                            %>
				<input type="hidden" name="catEntryId_<%= k+1%>" value="<%= item.getItemID()%>" />
				<input type="hidden" name="partNumber_<%= k+1%>" value="<%= item.getPartNumber()%>" />
				<input type="hidden" name="quantity_<%= k+1%>" value="<%=(new Double (compositeItems[k].getQuantity())).longValue()%>" />
                            <%
                            }
                        }
						for (int i = 0, ii = 0; (itemApplicableContractIds != null) &&
                                        (i < itemApplicableContractIds.length); i++) {


							//Need to filter out contracts with a null price.
							//This is needed for contracts that do not apply to the entire catalog.

							if (itemApplicableContractPrices[i] != null) {

							/*
								Integer contractStoreId = nApplicableSupplierStoreIds[i];
								com.ibm.commerce.common.objects.StoreAccessBean abStore = cmdcontext.getStore(contractStoreId);

								String sStoreName = null;
								try {
									sStoreName = abStore.getDescription(lang).getDisplayName();
								} catch (Exception e) {
									sStoreName = contractStoreId.toString();
								}
                                */
%>
								<tr bgcolor="<% if (ii%2 == 0) { %>#ffffff<% } else { %>#bccbdb<% } %>">
									<td><input type="radio" name="contractId_<%=k+1%>" id="contractId_<%=k+1%>_<%=i%>" value="<%= itemApplicableContractIds[i] %>" <%= ii==0?"checked":""%>></td>
									<td><font class="P"><label for="contractId_<%=k+1%>_<%=i%>"><%= selectedSupplierName %></label></font></td>
									<td><font class="P"><%= cdb[i].getName() %>&nbsp;[<%= itemApplicableContractIds[i] %>]</font></td>
									<td><p align="right"><font class="price"><%= itemApplicableContractPrices[i] %></font></p></td>
								</tr>
<%
								ii++;
							}

						}
%>

						</table>
<%
                        } // if show contracts
 %>
                                <br/><br/>
						</FONT>
					</td>
				</tr>
  <%

    cmdcontext.restoreStore();
  } // for items
  %>
                </form>
				</TABLE>

<%
			//if (itemApplicableContractIds != null && itemApplicableContractIds.length > 0)  {
			if (applicableSuppliersForBundle.size() > 0)  {   //TODO: and there is at least one orderable item
						boolean haveOpenStore = false;
			for (int i = 0; i < itemApplicableContractIds.length; i++) {
				if (itemApplicableContractPrices[i] != null) {
					Integer contractStoreId = nApplicableSupplierStoreIds[i];
					com.ibm.commerce.common.objects.StoreAccessBean abStore = cmdcontext.getStore(contractStoreId);
					if(abStore.getStatus().equals("1")) haveOpenStore = true;
				}
			}
			if(haveOpenStore){
%>


				<br />
		<table  cellpadding="10" cellspacing="0" border="0">
				<tr>
					<td>
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
				</tr>
				<tr>
					<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ea2b2b">
						<table cellpadding="2" cellspacing="0" border="0">
						<tr>
							<td class="buttontext">
								<font color="#ffffff"><b>
								<a class="catalog" href="#" onClick="Add2ShopCart(document.OrderItemAddForm); return false;" style="color:#ffffff; text-decoration : none;"><%=tooltechtext.getString("ItemDisp_AddItem")%>
								</a>
								</b></font>
							</td>
						</tr>
						</table>
					</td>
					<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>
				<tr>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>
				</table>

				<br /><br />
				<b><%=tooltechtext.getString("ItemDisp_Label_ReqList")%></b>
				<br />
				<%=tooltechtext.getString("ItemDisp_Message2")%>
				<br /><br />

				<form name="RequisitionListSelectForm" ACTION="" Method="post">
					<input type="hidden" name="reqListStoreId" value="">
                    <%
                     for (int j=0; j < compositeItems.length; j++){

                    %>
				<input type="hidden" name="partNumber_<%= j+1%>" value="" />
				<input type="hidden" name="contractId_<%= j+1%>" value="" />
				<input type="hidden" name="quantity_<%= j+1%>" value="<%=(new Double (compositeItems[j].getQuantity())).longValue()%>" />
                    <%
                    }
                    %>

					<table>
					<tr>
						<td>
							<INPUT TYPE="radio"  NAME="Type" VALUE="NEW" id="RequisitionListSelectForm_Type_NEW" checked>
						</td>
						<td><b><label for="RequisitionListSelectForm_Type_NEW"><%=tooltechtext.getString("ItemDisp_Radio1")%></label></b></td>
					</tr>
					<tr>
						<td>
							<INPUT TYPE="radio"  NAME="Type" VALUE="EXISTING" id="RequisitionListSelectForm_Type_EXISTING">
						</td>
						<td><b><label for="RequisitionListSelectForm_Type_EXISTING"><%=tooltechtext.getString("ItemDisp_Radio2")%></label></b></td>
					</tr>

					</TABLE>
				</form>

				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
				</tr>
				<tr>
					<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ea2b2b">
						<table cellpadding="2" cellspacing="0" border="0">
						<tr>
							<td class="buttontext">
								<font color="#ffffff"><b>
								<a class="catalog" href="#" onClick="Add2ReqList(document.RequisitionListSelectForm); return false;"   style="color:#ffffff; text-decoration : none;">
								<%=tooltechtext.getString("ItemDisp_AddItemReq")%>
								</a>
								</b></font>
							</td>
						</tr>
						</table>
					</td>
					<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>
				<tr>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>
				</table>


<%
			}	} else {
%>
				<br />
				<hr width="100%" />
				<br />
				<b><%= tooltechtext.getString("ItemDisp_NoPrice") %></b>
				<br />
				<br />
<%
			} // end if price array
%>


<%
			// Code for RFQ begins. Show show to a Buyer (Buy-side) User.
//			if ((userState.equals("1") || userState.equals("")) && bnRegUser.findUser() && bBuyer) {
            if ( (userState != null && (userState.equals("1") || userState.equals(""))) &&
                 (registeredUser != null && registeredUser.equalsIgnoreCase("true")) &&
                 (rfqLinkDisplayed!=null && rfqLinkDisplayed.equalsIgnoreCase("true") ) ) {
%>

				<br /><br />
				<b><%=tooltechtext.getString("Sidebar_RFQ")%></b>
				<br />
				<%=tooltechtext.getString("RFQExtra_Desc")%>
				<br /><br />

				<form name="RFQAddForm" action="" method="post">
				<input type="hidden" name="storeId" value="<%= storeId %>">
				<input type="hidden" name="catalogId" value="<%= catalogId %>">
				<input type="hidden" name="langId" value="<%= languageId %>">
				<input type="hidden" name="<%= com.ibm.commerce.rfq.utils.RFQConstants.EC_OFFERING_CATENTRYID %>" value="<%= bundleId %>">

				<table>
				<tr>
					<td>
						<input type="radio"  name="Type" value="NEW" id="RFQAddForm_Type_NEW" checked>
					</td>
					<td><b><label for="RFQAddForm_Type_NEW"><%=tooltechtext.getString("ItemDisp_Radio1")%></label></b></td>
				</tr>
				<tr>
					<td>
						<input type="radio"  name="Type" value="EXISTING" id="RFQAddForm_Type_EXISTING">
					</td>
					<td><b><label for="RFQAddForm_Type_EXISTING"><%=tooltechtext.getString("ItemDisp_Radio2")%></label></b></td>
				</tr>
				</table>

				<table><tr>
				<td>
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
						<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
						<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
					</tr>
					<tr>
						<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
						<td bgcolor="#ea2b2b">
							<table cellpadding="2" cellspacing="0" border="0">
							<tr>
								<td class="buttontext">
									<font color="#ffffff"><b><a class="catalog" href="#" onClick="Add2RFQ(document.RFQAddForm);" style="color:#ffffff; text-decoration : none;">
										<%=tooltechtext.getString("RFQModifyAddProductDisplay_Add")%>
										</a>
									</b></font>
								</td>
							</tr>
							</table>
						</td>
						<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
					</tr>
					<tr>
						<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
						<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
					</tr>
					</table>

				</td>
				</tr></table>
				</form>

				<!-- Code for Add to Interest List ends-->

<%
			}
%>

<%
}
catch (Exception e) {
	e.printStackTrace();
	if (e instanceof javax.servlet.ServletException) {
		((javax.servlet.ServletException)e).getRootCause().printStackTrace();
	}
%>
Got Exception!!
<%
}
%>
</td></tr></table>

			</td>
		</tr>
		</TABLE>

	

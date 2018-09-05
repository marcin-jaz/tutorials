<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2001, 2005
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
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CompositeProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CompositeItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.supplychain.beans.SupplierHubItemDataBean" %>
<%@ page import="com.ibm.commerce.supplychain.beans.SupplierHubPackageDataBean" %>
<%@ page import="com.ibm.commerce.contract.beans.ContractDataBean" %>
<%@ page import="com.ibm.commerce.price.beans.PriceDataBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.AttributeAccessBean" %>
<%@ page import="com.ibm.commerce.negotiation.beans.AuctionInfoDataBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<wcbase:useBean id="packageDB" classname="com.ibm.commerce.supplychain.beans.SupplierHubPackageDataBean" />

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
			form.quantity.value = document.OrderItemAddForm.quantity.value;
			form.reqListStoreId.value = document.OrderItemAddForm.cmdStoreId.value;
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

<%
try {
    // JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted

    JSPHelper jhelper = new JSPHelper(request);

    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String storeId = jhelper.getParameter("storeId");
    String itemId = jhelper.getParameter("productId");
    String fromIntList = jhelper.getParameter("fromIntList");
    String userState = jhelper.getParameter("userState");
    String registeredUser = jhelper.getParameter("registeredUser");
    String rfqLinkDisplayed = jhelper.getParameter("rfqLinkDisplayed");

    // --- package ------- //

    //no products in package
    //CompositeProductDataBean[] compositeProducts = packageDB.getPackagedProducts();
    CompositeItemDataBean[] compositeItems = packageDB.getPackagedItems();

    Integer[] nApplicableSupplierStoreIds = packageDB.getApplicableSupplierHostedStoreIds();

    // Get Item information
    //ItemDataBean item = new ItemDataBean();
    /*
    SupplierHubItemDataBean item = new SupplierHubItemDataBean();
    item.setItemID(itemId);
    item.setErrorMode(false);
    DataBeanManager.activate(item, request);
    Integer[] nApplicableSupplierStoreIds = item.getApplicableSupplierHostedStoreIds();
    */

    //------------------ Below is not used --------------------//
    /*
    // Get Product information
    CatalogEntryDataBean dbCatalogEntryFinder = new CatalogEntryDataBean();
    DataBeanManager.activate(dbCatalogEntryFinder, request);

    Long childCatalogEntryId = Long.valueOf(item.getItemID());
    Enumeration enCatalogEntryList = dbCatalogEntryFinder.findByChildCatalogEntry(childCatalogEntryId);

    String ProductCatalogEntryId = "";

    if (enCatalogEntryList.hasMoreElements()) {
    	CatalogEntryDataBean parentCatalogEntry = (CatalogEntryDataBean) enCatalogEntryList.nextElement();
    	ProductCatalogEntryId = parentCatalogEntry.getCatalogEntryReferenceNumber();
    } else {
    	// If no parent is found, this implies that item does not have a parent.
    	// Then, the childCatalogEntryId is used as the CatalogEntryId.
    	ProductCatalogEntryId = childCatalogEntryId.toString();
    }

    ProductDataBean product = new ProductDataBean();
    product.setProductID(ProductCatalogEntryId);
    DataBeanManager.activate(product, request);

    // Get all the attributes for this product in order of sequence.
    AttributeAccessBean attributesAB[] = product.getAttributes();
    AttributeAccessBean attributeAB;

    */
    //------------------------------------------------------------


    // Get Contract information

    //String as[] = cmdcontext.getEligibleTradingAgreementIds(); // Testing code for CommandContext 08/15/2001
    Long[] itemApplicableContractIds = packageDB.getApplicableContractIds();
    PriceDataBean[] itemApplicableContractPrices = packageDB.getApplicableContractPrices();
    ContractDataBean cdb[] = null;

    if (itemApplicableContractIds != null) {
    	cdb = new ContractDataBean[itemApplicableContractIds.length];

    	for (int i = 0; i< itemApplicableContractIds.length; i++) {
    		cdb[i] = new ContractDataBean();
    		cdb[i].setDataBeanKeyReferenceNumber(itemApplicableContractIds[i].toString());
    		DataBeanManager.activate(cdb[i], request);
    	}
    }
%>

	<TABLE CELLPADDING="8">
	<tr>
		<td>
			<h1><%=tooltechtext.getString("PackageDisp_Title")%></h1>
			<br />

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
			<font class="subHeading"><b><%=packageDB.getDescription().getShortDescription()%></b></font><br />
			<font class="text"><%=packageDB.getDescription().getLongDescription()%></font><br />
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
										<c:forEach var="attachUsage" items="${packageDB.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${packageDB}" />
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
														<c:set var="AttachmentDataBeans" value="${packageDB.attachmentsByUsage}" />
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
			<!-- Display Item Information-->
<%
            ItemDataBean item = new ItemDataBean();
            for (int k = 0; k < compositeItems.length; k++)
            {
            	item = compositeItems[k].getItem();
                item.setErrorMode(false);
%>
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
						<%=item.getPartNumber()%>

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
				              	%>
                                <br/><br/>
						</FONT>
					</td>
				</tr>
              <%
              } // for items
              %>
			</TABLE>

<%
			if (itemApplicableContractIds != null && itemApplicableContractIds.length > 0)  {
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

				<FORM NAME="OrderItemAddForm" ACTION="" Method="post">
					<input type="hidden" name="orderId" value=".">
					<input type="hidden" name="langId" value="<%= languageId %>">
					<input type="hidden" name="catalogId" value="<%= catalogId %>">
					<input type="hidden" name="URL" value="">
					<input type="hidden" name="catEntryId" value="<%= packageDB.getPackageID()%>">
					<input type="hidden" name="allocate" value="*n">
					<input type="hidden" name="reverse" value="*n">
					<input type="hidden" name="backorder" value="*n">

					<!-- Code for Add to Interest List -->
					<input type="hidden" name="productId" value="<%=itemId%>">
					<input type="hidden" name="fromIntList" value="">



				<br />
				<STRONG><label for="quantity"><%=tooltechtext.getString("ItemDisp_Quantity")%></label>&nbsp;&nbsp;</STRONG>
				<input typE="text" VALUE="1" NAME="quantity" id="quantity" SIZE="2">
				<br />


				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top">
					</td>
				</tr>
				</table>


				<p><br />
				<%=tooltechtext.getString("ItemDisp_Message1")%>
				<br /><br />

				<table class="list" cellpadding="0" cellspacing="0" border="0" width="300" bgcolor="#4c6178">
				<tr>
					<td>
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
						for (int i = 0; i < itemApplicableContractIds.length; i++) {


							//Need to filter out contracts with a null price.
							//This is needed for contracts that do not apply to the entire catalog.

							if (itemApplicableContractPrices[i] != null) {

								Integer contractStoreId = nApplicableSupplierStoreIds[i];

								com.ibm.commerce.common.objects.StoreAccessBean abStore = cmdcontext.getStore(contractStoreId);
								if(abStore.getStatus().equals("1")){
								String sStoreName = null;
								try {
									sStoreName = abStore.getDescription(lang).getDisplayName();
								} catch (Exception e) {
									sStoreName = contractStoreId.toString();
								}
%>
								<tr bgcolor="<% if (i%2 == 0) { %>#ffffff<% } else { %>#bccbdb<% } %>">
									<td><input type="radio" name="contractId" value="<%= itemApplicableContractIds[i] %>" id="contractId_<%=i%>" onclick="selectCmdStoreId(document.OrderItemAddForm,<%= contractStoreId %>)"></td>
									<td><font class="P"><label for="contractId_<%=i%>"><%= sStoreName %></label></font></td>
									<td><font class="P"><%= cdb[i].getName() %>&nbsp;[<%= itemApplicableContractIds[i] %>]</font></td>
									<td><p align="right"><font class="price"><%= itemApplicableContractPrices[i] %></font></p></td>
								</tr>
<%
								}
							}

						}
%>
						<input type="hidden" name="cmdStoreId" value="">

						</table>
					</td>
				</tr>
				</table>
				</form>

				<br />
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
					<input type="hidden" name="partNumber" value="<%=item.getPartNumber()%>">
					<input type="hidden" name="quantity" value="">
					<input type="hidden" name="reqListStoreId" value="">

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
//			if ((userState.equals("1") || userState.equals("")) && bnRegUser.findUser() && bBuyer) {

          // Code for Add to RFQ begins. Show show to a Buyer (Buy-side) User.
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
				<input type="hidden" name="<%= com.ibm.commerce.rfq.utils.RFQConstants.EC_OFFERING_CATENTRYID %>" value="<%= itemId %>">

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
				<!-- Code for RFQ ends-->
<%
			}
%>

		</td>
	</tr>
	</TABLE>

<%
}
catch (Exception e) {
	e.printStackTrace(new PrintWriter(out));
	if (e instanceof javax.servlet.ServletException) {
		((javax.servlet.ServletException)e).getRootCause().printStackTrace();
	}
%>
Got Exception!!
<%
}
%>

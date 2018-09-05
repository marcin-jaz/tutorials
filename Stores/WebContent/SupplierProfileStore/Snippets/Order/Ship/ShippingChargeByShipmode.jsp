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
  * This JSP snippet displays the unique list of shipping modes that exist in the order and the 
  * shipping charge types that are pertinent to each shipping mode. Additionally if the charge
  * type of charge by carrier is relevant the shipping carrier account number is also displayed.
  *  
  * 
  * How to use this snippet?
  * 1. This snippet is available under the WC_installdir or WCDE_installdir (development environment) directory.
  *    The file path of this snippet is samples/Snippets/web/Order/Ship/ShippingChargeByShipmode.jsp.
  *    You should copy it to the Snippets/Order/Ship/ directory under your store directory, you should copy it to your store directory.
  * 3. To include this snippet in your wrapper JSP file, use the following statement:
  *    <c:import url="Snippets/Order/Ship/ShippingChargeByShipmode.jsp" >
  *         <c:param name="orderId" value=<orderId being displayed> />
  *    </c:import> 
  *    the path in this statement is the relative path of the snippet file to the store directory.
  * 4. To test this snippet, copy the sample wrapper JSP file to your store directory, from samples/JSPs/web/Order/Ship/ to /WAS_installdir/installedApps/cell_name/WC_instance_name.ear/Stores.war/store_dir/
  *    And copy the appropriate snippet file from samples/Snippets/web/Order/Ship/ to /WAS_installdir/installedApps/cell_name/WC_instance_name.ear/Stores.war/store_dir/Snippets/Order/Ship/
  *    You should also copy the required properties files from samples/Snippets/properties/Order/Ship/ to /WAS_installdir/installedApps/cell_name/WC_instance_name.ear/Stores.war/WEB-INF/classes/store_dir/Snippets/Order/Ship/       
  * 
  * 5. The urlForUpdate variable should be set up appropriately for the including page
  *    The default setting works for the OrderSummary page
  *    The function provided by this jsp snippet would be most efficiently used
  *    if included in page prior to order summary and requiring OrderPrepare to be executed one
  *    time. Placement in the OrderSummary screen will require OrderPrepare to be executed an additional
  *    time should an Update be required.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../OrderEnvironmentSetup.jspf"%> 

<c:set var="orderId" value="${param.orderId}"/>
<%--
***************************
* urlForUpdate is the URL that will be used to forward the
* ShipInfoUpdate command to, when the user clicks the Update
* button. This should be set so that it goes to the correct
* page. The default setting is to display the order and perform
* no inventory actions.
***************************
--%>
<c:set var="urlForUpdate" value="OrderDisplay?merge=*n&allocate=*n&backorder=*n&reverse=*n"/>
   
<wcbase:useBean id="shipCharges" classname="com.ibm.commerce.order.beans.UsableShipChargesAndAccountByShipModeDataBean" scope="page">
	<c:set property="orderId" value="${orderId}" 	target="${shipCharges}"  />
</wcbase:useBean>

<script language="javascript">

function MM_findObj(n, d) { //v4.01
	var p,i,x;  
	if(!d) d=document;
	if((p=n.indexOf("?"))>0&&parent.frames.length) {
	   d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
	}
	if(!(x=d[n])&&d.all) x=d.all[n]; 
	for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && d.getElementById) x=d.getElementById(n);
	return x;
}


function MM_showHideLayer() { //v6.0
	var i,p,v,obj,args=MM_showHideLayer.arguments;
    var chargeName;
	i=0;
	if ((obj=MM_findObj(args[i]))!=null) {
		if ((v=MM_findObj(args[i+2]))!=null) {
		       if (obj.style) { 
				obj=obj.style;
                    chargeName = v.options[v.selectedIndex].value;
                if (chargeName.indexOf("ShippingChargeByCarrier") > -1) {
					obj.visibility='visible';
					obj.display='block';
				} else {
					obj.visibility='hidden';
					obj.display='none';
				} 
			}
		}
	}
}

function updateShipChargeType(form)
{
    form.submit();
    return false;
}

   
</script> 

<table width="100%" id="WC_ShippingChargeByShipmode_Table_1">
	<tr>
	<td id="WC_ShippingChargeByShipmode_TableCell_1">

<c:choose>     
	<c:when test="${not empty shipCharges.shipChargesByShipMode}">
		<form name="ShipChargeTypeForm" method="post" action="ShipInfoUpdate" id="ShipChargeTypeForm">
	        	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="ShipCharge_FormInput_storeId_In_ShopCartForm_1"/>
	        	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="ShipCharge_FormInput_catalogId_In_ShopCartForm_1"/>
	       		<input type="hidden" name="langId" value="<c:out value="${CommandContext.languageId}" />" id="ShipCharge_FormInput_langId_In_ShopCartForm_1"/>
	       		<input type="hidden" name="URL" value="<c:out value="${urlForUpdate}" />" id="ShipCharge_FormInput_URL_In_ShopCartForm_1"/>
		      	<input type=hidden name="orderId" value="<c:out value="${orderId}"/>" />

			<table border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_ShippingChargeByShipmode_Table_2">
				<tr>
					<td class="colHeader c_headings" id="WC_ShippingChargeByShipmode_TableCell_2">
					    <fmt:message key="ShippingCharge_Title" bundle="${orderText}" />
					</td>
				</tr>
				<tr>
					<td class="cellBG_1 t_td2" id="WC_ShippingChargeByShipmode_TableCell_3">
						<table border="0" cellpadding="2" cellspacing="1" id="WC_ShippingChargeByShipmode_Table_3">
							<tr>
								<td class="cellBG_1 t_td2" id="WC_ShippingChargeByShipmode_TableCell_4">
									<fmt:message key="ShippingCharge_ShippingMethod" bundle="${orderText}" />
								</td>
								<td class="cellBG_1 t_td2" id="WC_ShippingChargeByShipmode_TableCell_5">
									<fmt:message key="ShippingCharge_ChargeType" bundle="${orderText}" />
								</td>
								<td class="cellBG_1 t_td2" id="WC_ShippingChargeByShipmode_TableCell_6">
									<fmt:message key="ShippingCharge_AccountNumber" bundle="${orderText}" />
								</td>
							</tr>
		
							<c:set var="rowClass" value="cellBG_2"/>
							<c:forEach items="${shipCharges.shipChargesByShipMode}" var="shipCharges_data"  varStatus="counter">
								<c:choose>
							    		<c:when test="${rowClass == 'cellBG_1'}">
							    			<c:set var="rowClass" value="cellBG_2"/>
							    		</c:when>
							    		<c:otherwise>
							    			<c:set var="rowClass" value="cellBG_1"/>
							    		</c:otherwise>
								</c:choose>
		    	
								<tr valign="top">
							                <%-- 
							                ***************************
							                * The shipping mode
							                *************************** 
							                --%>
									<td class="<c:out value="${rowClass}"/> t_td2" id="WC_ShippingChargeByShipmode_TableCell_7">
										<c:out value="${shipCharges_data.shipModeDesc}" />
										<input type="hidden" name="shipModeId_<c:out value="${counter.count}"/>" id="shipModeId_<c:out value="${counter.count}"/>" value="<c:out value="${shipCharges_data.shipModeId}" />" />
										<input type="hidden" name="addressId_<c:out value="${counter.count}"/>" id="addressId_<c:out value="${counter.count}"/>" value="-1" />
									</td>
	            
								        <%--
								        ***************************
								        * A selection of available way to apply charges
								        *   PolicyId = -7001 is shipping charges to be charged by selleer
								        *   PolicyId = -7002 is shipping charges to be charged by the carrier
								        ***************************
								        --%>
									<td id="WC_ShippingChargeByShipmode_TableCell_8">
									    	<c:set var="chargeByCarrier" value="0"/>
										<label for="shipChargTypeId_<c:out value="${counter.count}"/>"></label>
											<select class="select" name="shipChargTypeId_<c:out value="${counter.count}"/>" id="shipChargTypeId_<c:out value="${counter.count}"/>" 
											        onchange="MM_showHideLayer('ShipchargeRequestedLayer_<c:out value="${counter.count}"/>','','shipChargTypeId_<c:out value="${counter.count}"/>');" >
												<c:forEach items="${shipCharges_data.shippingChargeTypes}" var="shipChargeType_data" >				
													<option <c:if test="${shipChargeType_data.selected}">
																<c:set var="chargeByCarrier" value="${shipChargeType_data.internalPolicyId}"/>
													            selected="selected"
													        </c:if> 
													        value="<c:out value="${shipChargeType_data.policyId}"/>">
													    <fmt:message key="${shipChargeType_data.policyName}" bundle="${orderText}" />
													</option>
												</c:forEach>
											</select>
									</td>
			   
									<%--
									***************************
									* Will contain an optional input field for the carrier account number to be charged 
									***************************
									--%>
									<td id="WC_ShippingChargeByShipmode_TableCell_9">
									        <%--
									        *************************** 
									        * Show this only when ChargeByCarrier is selected 
									        * The choose handles the case when the page is being rendered
									        * javascript handles the case when the selection changes      
									        ***************************
									        --%>
										<div id="ShipchargeRequestedLayer_<c:out value="${counter.count}"/>" 
											<c:choose>
												<c:when test="${chargeByCarrier eq -7002}">
												    style="visibility: visible; display: block;"
												</c:when>
												<c:otherwise>
												    style="visibility: hidden; display: none;"
												</c:otherwise>
											</c:choose> >
									    		<label for="shipCarrAccntNum_<c:out value="${counter.count}"/>"></label><input class="input" type="text" name="shipCarrAccntNum_<c:out value="${counter.count}"/>" size="10" maxlength="100" value="<c:out value="${shipCharges_data.carrierAccountNumber}" />" ID="shipCarrAccntNum_<c:out value="${counter.count}"/>"/>
									    	</div>
									</td>
								</tr>
			
							</c:forEach>
						<tr>
						    <%--
						    ***************************
						    * The Update button to change the shipping charge options
						    ***************************
						    --%>
							<td class="cellBG_1" id="WC_ShippingChargeByShipmode_TableCell_10">
								<a href="#" class="button" onclick="javascript:updateShipChargeType(document.ShipChargeTypeForm)" id="WC_ShippingChargeByShipmode_Link_1">
									<fmt:message key="ShippingCharge_Update" bundle="${orderText}"/>
								</a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table class="t_table" id="WC_ShippingChargeByShipmode_Table_4">
			<tr>
				<td class="c_line" id="WC_ShippingChargeByShipmode_TableCell_11">&nbsp;</td>
			</tr>
		</table>	
		</form>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
	</td>
	</tr>
</table>

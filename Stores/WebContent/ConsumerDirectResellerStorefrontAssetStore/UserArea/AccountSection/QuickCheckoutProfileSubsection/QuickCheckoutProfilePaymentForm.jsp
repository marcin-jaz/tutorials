<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation.
 *     2006
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- 
  ***
  *	Start: default payment settings
  ***
--%>

<wcbase:useBean id="paymentPolicyListDataBean" classname="com.ibm.commerce.payment.beans.PaymentPolicyListDataBean" scope="page">
	<c:set value="${WCParam.storeId}" target="${paymentPolicyListDataBean}" property="storeId"/>
</wcbase:useBean>

<h2><fmt:message key="QUICK_PAY_INFO" bundle="${storeText}"/></h2>

<%--
********************
* Start:  Displays the available Payment methods in a pre populated list box
********************
--%>

<table cellpadding="0" cellspacing="0" border="0" width="786" class="t_table" id="WC_QuickCheckoutProfilePaymentForm_Table_1">
	<tr>
		<td class="t_td2" id="WC_QuickCheckoutProfilePaymentForm_TableCell_1">
			<c:choose>	
				<c:when test="${ !empty paymentPolicyListDataBean.paymentPolicyInfoUsableWithoutTA}">
                                    <label for="EDP_PaymentMethodsDisplay_FormInput_paymentMethod_In_PaymentMethodsDisplayForm_1">
					<select class="select" name="paymentMethod" title="paymentMethod" id="EDP_PaymentMethodsDisplay_FormInput_paymentMethod_In_PaymentMethodsDisplayForm_1" onchange="javascript:document.QuickCheckout.action='ProfileFormView';selectionChanged(document.QuickCheckout);document.QuickCheckout.submit();" >
					<c:forEach items="${paymentPolicyListDataBean.paymentPolicyInfoUsableWithoutTA}" var="paymentPolicyInfo" varStatus="status">
						<c:choose>							
							<%--
							***************************
							* Start : select default Payment method
							***************************
							--%>
							<c:when test="${empty paymentMethod[0]}">
								<c:choose>
							        	<%--
									 ***************************
									 * Start: PaymentMethod is set up by quick checkout profile
									 ***************************
									--%>
									<c:when test="${!empty edp_ProtocolData}"> 
							    			<c:set var="edp_SelectedValue" value="${edp_ProtocolData.payment_method}" scope="request"/> 
							    		</c:when>
							    		<%--
									 ***************************
									 * Start: VISA is selected as a default Payment method
									 ***************************
									--%>
							    		<c:otherwise>
										<c:set var="edp_SelectedValue" value="VISA" scope="request"/> 
									</c:otherwise>	
								</c:choose>
							</c:when>
							<%--
							***************************
							* End : select default Payment method
							***************************
							--%>
							
							<%--
							***************************
							* Start : use selected Payment method
							***************************
							--%>
							<c:otherwise>
								<c:set var="edp_SelectedValue" value="${paymentMethod[0]}" scope="request" /> 
							</c:otherwise>
						</c:choose>
						
						<c:if test="${ !empty paymentPolicyInfo.attrPageName }" >
							<c:if test="${paymentPolicyInfo.attrPageName == 'StandardVisa' || paymentPolicyInfo.attrPageName == 'StandardMasterCard' || paymentPolicyInfo.attrPageName == 'StandardAmex'}">
								<option <c:if test="${paymentPolicyInfo.policyName == edp_SelectedValue }" > selected="selected" </c:if> value="<c:out value="${paymentPolicyInfo.policyName}" />"> <c:out value="${paymentPolicyInfo.shortDescription}" /></option>
								<%--
								************************
								* Start : Gets the attribute Page name for the selected Payment method
								************************
								--%>
								<c:if test="${paymentPolicyInfo.policyName == edp_SelectedValue }" >
									<c:set var ="edp_AttrPageName" value="${paymentPolicyInfo.attrPageName}" />
								</c:if>
								<%--
								************************
								* End : Gets the attribute Page name for the selected Payment method
								************************
								--%>							
							</c:if>
						</c:if>
					</c:forEach>
					</select>
                                    </label>
				</c:when>
				<c:otherwise>
					<br/><font color="red"><fmt:message key="QUICK_CHECKOUT_NO_PAYMENT_METHODS_AVAILABLE" bundle="${storeText}"/></font>
				</c:otherwise>
			</c:choose>	
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_QuickCheckoutProfilePaymentForm_TableCell_2">
			<c:if test="${!empty edp_AttrPageName}">
				<c:set var="edp_AttrPageFullPath" value="../../../Snippets/EDP/PaymentMethods/${edp_AttrPageName}.jsp" />
				<c:import url="${edp_AttrPageFullPath}">
					<c:param name="hideAmounts" value= "true"/>
					<c:param name="hideButtons" value="true"/>
					<c:param name="inputPrefix" value="pay_"/>
					<c:param name="doNotShowCCVNumber" value="true"/>
				</c:import>
			</c:if>                                           
		</td>
	</tr>
</table>

<%--
********************
* End:  Displays the available Payment methods in a pre populated list box
********************
--%>

<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" />
<input type="hidden" name="langId" value="<c:out  value="${CommandContext.languageId}" />" />
<input type="hidden" name="catalogId" value="<c:out  value="${WCParam.catalogId}" />" />
<input type="hidden" name="pay_payMethodId" value="<c:out  value="${edp_SelectedValue}" />" />
<input type="hidden" name="pay_payment_method" value="<c:out  value="${edp_SelectedValue}" />" />
<input type="hidden" name="selection_changed" value="false" />


<script type="text/javascript" language="javascript">

function selectionChanged(form)
{
	form.selection_changed.value="true"
}

</script>
<%-- 
  ***
  *	End: default payment settings
  ***
--%>

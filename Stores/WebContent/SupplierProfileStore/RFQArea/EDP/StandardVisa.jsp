<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2005
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%@ include file="../../Snippets/EDP/EDPEnvironmentSetup.jspf"%>

<%-- Set the default value(current month + 1) of expire_month for this payment method --%>
<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="expire_year" value="${now.year + 1900}"/>
	
<table cellpadding="3" cellspacing="0" border="0" id="StandardVisa_Table_1">
	<!-- TR><TD  align=RIGHT width=260></TD></TR -->
	<tbody>
		<tr>
		<td colspan="4" valign="middle" class="categoryspace"  id="StandardVisa_TableCell_11">
			<LABEL for="StandardVisa_InputText_1">
				<span class="required">*</span>
				<fmt:message key="EDPPaymentMethods_VISA_CARD_NUMBER" bundle="${edpText}"  />
			</LABEL>
			
		</td>
		<td colspan="4" valign="middle" class="categoryspace"  id="StandardVisa_TableCell_12">
			<input type="text" name="account" value ="" id="StandardVisa_InputText_1" />
			
        </td>

	</tr>
	<tr>
		<td colspan="4" valign="middle" class="categoryspace"  id="StandardVisa_TableCell_21">
			<LABEL for="edp_Visa_cardExpiryMonth">
			<span class="required">*</span>
			<fmt:message key="EDPPaymentMethods_VISA_EXPIRATION_MONTH" bundle="${edpText}"  />
			</LABEL>
		</td>
		
		<td colspan="4" valign="middle" class="categoryspace"  id="StandardVisa_TableCell_22">
			<select name="expire_month" size=1 id="edp_Visa_cardExpiryMonth">
				<option selected></option>
				<option value="01">01</option>
				<option value="02">02</option>
				<option value="03">03</option>
				<option value="04">04</option>
				<option value="05">05</option>
				<option value="06">06</option>
				<option value="07">07</option>
				<option value="08">08</option>
				<option value="09">09</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select>

		</td>
	</tr>
	<tr>
		<td colspan="4" valign="middle" class="categoryspace"  id="StandardVisa_TableCell_31">
			<LABEL for="edp_Visa_cardExpiryYear">
				<span class="required">*</span>
				<fmt:message key="EDPPaymentMethods_VISA_EXPIRATION_YEAR" bundle="${edpText}"  />
			</LABEL>
		</td>
		
		<td colspan="4" valign="middle" class="categoryspace"  id="StandardVisa_TableCell_32">
			<select name="expire_year" size=1 id="edp_Visa_cardExpiryYear">
				<option selected></option>								
				<c:forEach begin="0" end="10" varStatus="counter">
					<option value="${expire_year+counter.index}">${expire_year+counter.index}</option>
				</c:forEach>		
			</select>

		</td>
	</tr>
	</tbody>
</table>

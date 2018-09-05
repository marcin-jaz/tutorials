<%
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



<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%@ include file="../../Snippets/EDP/EDPEnvironmentSetup.jspf"%>



<table cellpadding="3" cellspacing="0" border="0" id="StandardACH_Table_1">
	<tr>
		<td colspan="4" valign="middle"  id="StandardACH_TableCell_11">
			<label for ="StandardACH_InputText_1"><span class="required">*</span><fmt:message key="EDPPaymentMethods_BANK_ROUTING_NO" bundle="${edpText}"  /></label>
			
		</td>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_12">
			<input type="text" name = "check_routing_number" value ="" value ="" id="StandardACH_InputText_1" />
		</td>

	</tr>
	<tr>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_21">
			<label for="StandardACH_InputText_2"><span class="required">*</span><fmt:message key="EDPPaymentMethods_BANK_ACCOUNT_NO" bundle="${edpText}"  /></label>
		</td>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_22">
			<input type="text" name = "checkAccountNumber" value ="" id="StandardACH_InputText_2" />
		</td>

	</tr>
	
	
</table>




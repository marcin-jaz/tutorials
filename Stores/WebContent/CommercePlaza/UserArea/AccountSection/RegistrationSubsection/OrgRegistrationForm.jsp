<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2003
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%@ page language="java" %>

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>

<%@ page import="com.ibm.commerce.price.utils.CurrencyManager" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>

<%@ page import="com.ibm.commerce.user.beans.CountryStateListDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.PolicyPasswordDataBean"%>
<%@ page import="com.ibm.commerce.user.beans.PolicyAccountDataBean" %>
<%@ page import="com.ibm.commerce.common.objects.LanguageDescriptionAccessBean" %>
<%@ page import="com.ibm.commerce.common.objects.SupportedLanguageAccessBean" %>

 <%@ include file="../../../include/EnvironmentSetup.jsp"%>

 <%
 String errorMessage = request.getParameter("errorMessage");
 String numberLoc = jhelper.getParameter("numberLoc");
 String validateEmailAddress = jhelper.getParameter("validateEmailAddress");
 
 int loc = Integer.parseInt(numberLoc); 
 Vector distusrList = new Vector();
 Vector distpwdList = new Vector();
 Vector distresellerList = new Vector();
 Vector distlocList = new Vector();
 
 //This will be used to store the list of all distributor StoreIds
 Integer[] distributorStoreIds = null;  
  	 
 //Get all distributor stores
 distributorStoreIds = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
 %>
 
 <jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
 	<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %> 
 </jsp:useBean>
 
 <%
 	//Declare and Initialize all fields to empty.
 String strLogonID 				= "";
 String strPassword 			= "";
 String strPasswordVerify		= "";
 
 String strLastName 			= "";
 String strFirstName 			= "";
 String strMiddleName           = "";
 String strPreferredLanguage	= "";
 String strPreferredCurrency 	= "";
 
 String strTitle 				= "";
 String strAddress1 			= "";
 String strAddress2 			= "";
 String strCity 				= "";
 String strState 				= "";
 String strCountry				= "";
 String strZipCode				= "";
 String strPhone1				= "";
 String strPhone2				= "";
 String strFax1					= "";
 String strEmail1				= "";
 String strEmail2				= "";
 
 String strBuyerOrg				= "";
 String strBuyerFunction		= "";
 String strEmployeeId			= "";
 String strInternalMailAddr		= "";
 String strBusTitle				= "";
 
 String strOrgName				= "";
 String strLegalId				= "";
 String strOrgAddress1			= "";
 String strOrgAddress2			= "";
 String strOrgCity				= "";
 String strOrgState				= "";
 String strOrgZip				= "";
 String strOrgphone1			= "";
 String strOrgphone2			= "";
 String strOrgfax1				= "";
 String strOrgemail1			= "";
 String strOrgCountry			= "";
 
 String strErrorMessage			= "";
 String strErrorCode			= "";
 
 
 // A problem with the user's input data will be detected here.
 
 TypedProperty hshErrorProperties = bnError.getExceptionData();
 String strMessageKey = bnError.getMessageKey();

 if (hshErrorProperties != null || strMessageKey != null)
 
 	{
	       		Object[] strMessageParams = null;
			 	String strFieldName = null;
			 	strErrorMessage = bnError.getMessage();
			 	
			 	
			 	if (hshErrorProperties != null)
			 	{
			 		strErrorCode = hshErrorProperties.getString(ECConstants.EC_ERROR_CODE, "");
			 		Object[] arguments = {new Integer(0)};
			 		String policyAccount = ECSecurityConstants.ACCOUNT_POLICY;              // Get the default account policy
			 
			 		PolicyAccountDataBean policyAccountDB= new PolicyAccountDataBean();
			 		policyAccountDB.setInitKey_iPolicyAccountId(policyAccount);
			 		String passPolicyId = policyAccountDB.getPolicyPasswordId();           // Get the password policy id from the AccountPolicyDataBean
			 
			 		PolicyPasswordDataBean policyPasswordDB = new PolicyPasswordDataBean();
			 		policyPasswordDB.setInitKey_iPolicyPasswordId(passPolicyId);
			 		String minLength = policyPasswordDB.getMinimumPasswordLength();        // Get the attributes needed for the error messages
			 		String minNumeric = policyPasswordDB.getMinimumNumeric();
			 		String minAlphabetic = policyPasswordDB.getMinimumAlphabetic();
			 		String maxInstances = policyPasswordDB.getMaximumInstances();
			 		String maxConsec = policyPasswordDB.getMaximumConsecutiveType();		
			 
			 		//Logon ID and Password Errors
			 		if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_BAD_LOGONID)) {
			 			strErrorMessage = storeText.getString("Reg_ERROR_MissingLogonID");
			 		}else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_BAD_LOGONPASSWORD)) {
			 			strErrorMessage = storeText.getString("Reg_ERROR_MissingPassword");
			 		}else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_BAD_LOGONPASSWORDVERIFY)) {
			 			strErrorMessage = storeText.getString("Reg_ERROR_MissingVerifyPassword");
			 		}else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_PASSWORDS_NOT_SAME)) {	
			 			strErrorMessage = storeText.getString("Reg_ERROR_PasswordsNotTheSame");
			 		}else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_LOGONID_EXISTS))	{
			 			strErrorMessage = storeText.getString("Reg_ERROR14");
					}
			 		
					// Look for password errors			 			
			 		if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLENGTH_PASSWORD))
			 		{
			 			arguments[0] = new Integer(minLength);			
			 			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMinLength")), arguments);
			 		}		
			 		else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXCONSECUTIVECHAR_PASSWORD))
			 		{
			 			arguments[0] = new Integer(maxConsec);			
			 			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMaxConsecutiveLength")),arguments);
			 		}		
			 		else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMDIGITS_PASSWORD))
			 		{
			 			arguments[0] = new Integer(minNumeric);			
			 			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMinDigits")),arguments);		
			 		}		
			 		else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLETTERS_PASSWORD))
			 		{
			 			arguments[0] = new Integer(minAlphabetic);			
			 			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMinLetters")),arguments);
			 		}
			 		else if (strErrorCode.equals(ECSecurityConstants.ERR_USERIDMATCH_PASSWORD)) {
			 			strErrorMessage = storeText.getString("Reg_ERROR_PasswordUserIdPasswordMatch");	
			 		}
			 		else if (strErrorCode.equals(ECSecurityConstants.ERR_REUSEOLD_PASSWORD)) {
			 			strErrorMessage = storeText.getString("Reg_ERROR_PasswordReUsed");
			 		}
			 		else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXINTANCECHAR_PASSWORD))
			 		{
			 			arguments[0] = new Integer(maxInstances);			
			 			strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMaxInstanceChar")),arguments);
			 		}
			 	}
			 	else if (validateEmailAddress != null && !validateEmailAddress.equals(""))
			 	{
					// Happens if the user's validate password doesn't equal their new password entry box
			 		strErrorMessage = storeText.getString("Reg_ERROR_ValidateEmail");
			 	}
			 	
			 	
			 	// Invalid parameters.  Parameters for these fileds are defined in UserRegistration_en_US.properties
			 	// Use the Message Param string to get the appropriate field the user left empty or filled incorrectly.
			 	// We cannot use the bnError.getErrorCode() because there are similar fields on the form.  
			 	// i.e. There is a user city field as well as a organization city field.
			 	if (bnError.getMessageKey().equals("_ERR_CMD_INVALID_PARAM"))
			 	{	
		                    strMessageParams = bnError.getMessageParam();
		                    strFieldName = (String)strMessageParams[0];
		                                   
		                    if (strFieldName.equals("usr_lastName")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR61");
		                    }else if (strFieldName.equals("usr_address1")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR62");
		                    }else if (strFieldName.equals("usr_firstName")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR72");
		                    }else if (strFieldName.equals("usr_city")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR63");
		                    }else if (strFieldName.equals("usr_state")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR64");
		                    }else if (strFieldName.equals("usr_zipCode")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR66");
		                    }else if (strFieldName.equals("usr_country")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR65");                         
		                    }else if (strFieldName.equals("usr_email1")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR67");
		                    }else if (strFieldName.equals("org_address1")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR54");
		                    }else if (strFieldName.equals("org_city")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR55");
		                    }else if (strFieldName.equals("org_state")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR56");
		                    }else if (strFieldName.equals("org_zipCode")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR57");
		                    }else if (strFieldName.equals("org_email1")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR58");
		                    }else if (strFieldName.equals("org_orgEntityName")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR59");
		                    }else if (strFieldName.equals("org_country")) {
		                           strErrorMessage = storeText.getString("Upreg_ERROR60");       
		                    }
				}
			 	
			 				 		
			 	// Get for variable and redisplay what was entered when the invalid entry was submitted.
				strLogonID = jhelper.htmlTextEncoder(jhelper.getParameter("usr_logonId"));
				strPassword = jhelper.htmlTextEncoder(jhelper.getParameter("logonPassword"));
				strPasswordVerify = jhelper.htmlTextEncoder(jhelper.getParameter("logonPasswordVerify"));	
				strLastName = jhelper.htmlTextEncoder(jhelper.getParameter("usr_lastName"));
				strMiddleName = jhelper.htmlTextEncoder(jhelper.getParameter("usr_middleName"));
				strFirstName = jhelper.htmlTextEncoder(jhelper.getParameter("usr_firstName"));
				strTitle = jhelper.htmlTextEncoder(jhelper.getParameter("usr_personTitle"));
				strAddress1 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_address1"));
				strAddress2 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_address2"));
				strCity = jhelper.htmlTextEncoder(jhelper.getParameter("usr_city"));
				strState = jhelper.htmlTextEncoder(jhelper.getParameter("usr_state"));
				strZipCode = jhelper.htmlTextEncoder(jhelper.getParameter("usr_zipCode"));
       			        strCountry = jhelper.htmlTextEncoder(jhelper.getParameter("usr_country"));
				strPhone1 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_phone1"));
				strPhone2 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_phone2"));
				strEmail1 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_email1"));
				strEmail2 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_email2"));
				strFax1 = jhelper.htmlTextEncoder(jhelper.getParameter("usr_fax1"));
				strBusTitle = jhelper.htmlTextEncoder(jhelper.getParameter("usr_businessTitle")); 	
				strOrgName = jhelper.htmlTextEncoder(jhelper.getParameter("org_orgEntityName"));
				strLegalId = jhelper.htmlTextEncoder(jhelper.getParameter("org_legalId"));
				strOrgAddress1 = jhelper.htmlTextEncoder(jhelper.getParameter("org_address1"));
				strOrgAddress2 = jhelper.htmlTextEncoder(jhelper.getParameter("org_address2"));
				strOrgCity = jhelper.htmlTextEncoder(jhelper.getParameter("org_city"));
				strOrgState = jhelper.htmlTextEncoder(jhelper.getParameter("org_state"));
				strOrgZip = jhelper.htmlTextEncoder(jhelper.getParameter("org_zipCode"));
				strOrgphone1 = jhelper.htmlTextEncoder(jhelper.getParameter("org_phone1"));
				strOrgphone2 = jhelper.htmlTextEncoder(jhelper.getParameter("org_phone2"));
				strOrgfax1 = jhelper.htmlTextEncoder(jhelper.getParameter("org_fax1"));
		 		strOrgemail1 = jhelper.htmlTextEncoder(jhelper.getParameter("org_email1"));
		 		strPreferredLanguage = jhelper.getParameter(ECUserConstants.EC_USER_PREFERREDLANGUAGE);
       			        strPreferredCurrency = jhelper.getParameter(ECUserConstants.EC_USER_PREFERREDCURRENCY);
       			        strOrgCountry = jhelper.htmlTextEncoder(jhelper.getParameter("org_country"));
		 		
		 		if (distributorStoreIds != null) {
				                       
					// Get all distributor user IDs and passwords for this user from the submitted form
					for (int o=0; o<distributorStoreIds.length; o++) {				
						String orgUID1 = "usr_UserDistributorUserId" + "_" + (distributorStoreIds[o]).toString() + "_" + o;
						String orgUID2 = "usr_UserDistributorPasswordEncrypted" + "_" + (distributorStoreIds[o]).toString() + "_" + o;
						String orgUID1Value = jhelper.htmlTextEncoder(jhelper.getParameter(orgUID1));
						String orgUID2Value = jhelper.htmlTextEncoder(jhelper.getParameter(orgUID2));
						distusrList.addElement(orgUID1Value);
						distpwdList.addElement(orgUID2Value);

						String orgDisID = "org_OrgDistributorPartnerId" + "_" + (distributorStoreIds[o]).toString() + "_" + o;
						String orgDisIDValue = jhelper.htmlTextEncoder(jhelper.getParameter(orgDisID));
						distresellerList.addElement(orgDisIDValue);						
					}
				}


				
				// Get all Loc IDs submitted on form
				for (int n=0; n<loc; n++) {			
					String orgLocID = "org_locId" + "_" + storeId + "_" + n;
					String orgLocIDValue = jhelper.htmlTextEncoder(jhelper.getParameter(orgLocID));
					distlocList.addElement(orgLocIDValue);
				}
				
				// invalid parameters
				if (bnError.getMessageKey().equals("_ERR_RDN_ALREADY_EXIST"))
				{	
					strErrorMessage = storeText.getString("Upreg_ERROR70");					 						
				}
 	}
 %>
 
<jsp:useBean id="countryDB" class="com.ibm.commerce.user.beans.CountryStateListDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(countryDB, request); %>
</jsp:useBean>

<%
Vector countries = countryDB.getCountries();
CountryStateListDataBean.Country aCountry = null;
CountryStateListDataBean.StateProvince[] states = null;

// Build 2 Country drop down lists.  One for the user and the other for the organization.
StringBuffer strCountryDropDown = new StringBuffer("");
StringBuffer strOrgCountryDropDown = new StringBuffer("");

strCountryDropDown.append("<option value=\"\"");
strCountryDropDown = (strCountry !=null && strCountry.equals("")) ? strCountryDropDown.append(" selected>&nbsp; </option>") : strCountryDropDown.append(">&nbsp; </option>");
strOrgCountryDropDown.append("<option value=\"\"");
strOrgCountryDropDown = (strOrgCountry !=null && strOrgCountry.equals("")) ? strOrgCountryDropDown.append(" selected>&nbsp; </option>") : strOrgCountryDropDown.append(">&nbsp; </option>");

for (int i=0; i<countries.size(); i++) {
	aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
	
	strCountryDropDown.append("<option value=\"");
	strCountryDropDown.append(aCountry.getCode());
	strCountryDropDown.append("\"");
	strCountryDropDown = (strCountry !=null && strCountry.equals(aCountry.getCode())) ? strCountryDropDown.append(" selected>") : strCountryDropDown.append(">");
	strCountryDropDown.append(aCountry.getDisplayName());
	strCountryDropDown.append("</option>");

	strOrgCountryDropDown.append("<option value=\"");
	strOrgCountryDropDown.append(aCountry.getCode());
	strOrgCountryDropDown.append("\"");
	strOrgCountryDropDown = (strOrgCountry !=null && strOrgCountry.equals(aCountry.getCode())) ? strOrgCountryDropDown.append(" selected>") : strOrgCountryDropDown.append(">");
	strOrgCountryDropDown.append(aCountry.getDisplayName());
	strOrgCountryDropDown.append("</option>");
}

// Build 2 State drop down lists.  One for the user and the other for the organization.
StringBuffer strStateDropDown = new StringBuffer("");
StringBuffer strOrgStateDropDown = new StringBuffer("");

if (!strCountry.equals("")) {
	states = countryDB.getStates(strCountry);
	if (states != null && states.length != 0) {
		strStateDropDown.append("<select id=\"usr_state\" name=\"usr_state\" class=\"iform\" >");
		strStateDropDown.append("<option value=\"\"");
		strStateDropDown = (strState !=null && strState.equals("")) ? strStateDropDown.append(" selected>&nbsp; </option>") : strStateDropDown.append(">&nbsp; </option>");
		
		for (int k=0; k<states.length; k++) {
			strStateDropDown.append("<option value=\"");
			strStateDropDown.append(states[k].getCode());
			strStateDropDown.append("\"");
			strStateDropDown = (strState !=null && strState.equals(states[k].getCode())) ? strStateDropDown.append(" selected>") : strStateDropDown.append(">");
			strStateDropDown.append(states[k].getDisplayName());
			strStateDropDown.append("</option>");
		}
		strStateDropDown.append("</select>");
	} else {
		strStateDropDown.append("<input type=\"text\" maxlength=\"42\" size=\"20\" name=\"usr_state\" id=\"statetext\" value=\"");
		strStateDropDown.append(strState);
		strStateDropDown.append("\" class=\"iform\" />");
	}
} else {
	strStateDropDown.append("<input type=\"text\" maxlength=\"42\" size=\"20\" name=\"usr_state\" id=\"statetext\" value=\"");
	strStateDropDown.append(strState);
	strStateDropDown.append("\" class=\"iform\" />");
}

if (!strOrgCountry.equals("")) {
	states = countryDB.getStates(strOrgCountry);
	if (states != null && states.length != 0) {
		strOrgStateDropDown.append("<select id=\"org_state\" name=\"org_state\" class=\"iform\" >");
		strOrgStateDropDown.append("<option value=\"\"");
		strOrgStateDropDown = (strOrgState !=null && strOrgState.equals("")) ? strOrgStateDropDown.append(" selected>&nbsp; </option>") : strOrgStateDropDown.append(">&nbsp; </option>");
		
		for (int k=0; k<states.length; k++) {
			strOrgStateDropDown.append("<option value=\"");
			strOrgStateDropDown.append(states[k].getCode());
			strOrgStateDropDown.append("\"");
			strOrgStateDropDown = (strOrgState !=null && strOrgState.equals(states[k].getCode())) ? strOrgStateDropDown.append(" selected>") : strOrgStateDropDown.append(">");
			strOrgStateDropDown.append(states[k].getDisplayName());
			strOrgStateDropDown.append("</option>");
		}
		strOrgStateDropDown.append("</select>");
	} else {
		strOrgStateDropDown.append("<input type=\"text\" maxlength=\"42\" size=\"20\" name=\"org_state\" id=\"statetext\" value=\"");
		strOrgStateDropDown.append(strOrgState);
		strOrgStateDropDown.append("\" class=\"iform\" />");
	}
} else {
	strOrgStateDropDown.append("<input type=\"text\" maxlength=\"42\" size=\"20\" name=\"org_state\" id=\"statetext\" value=\"");
	strOrgStateDropDown.append(strOrgState);
	strOrgStateDropDown.append("\" class=\"iform\" />");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<title><%=storeText.getString("OrgReg_Title1")%></title>
	<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
	<meta name="GENERATOR" content="IBM WebSphere Studio" />
	
	<SCRIPT language="javascript" src="<%=fileDir%>javascript/Util.js"></SCRIPT>
	<script language="javascript">
	<!--
	//get the list of all countries and states available from the database.
	var countries = new Array();

	<%
	for (int i=0; i<countries.size(); i++) {
		aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
		%>
		countries["<%= aCountry.getCode() %>"] = new Object();
		countries["<%= aCountry.getCode() %>"].name = "<%= aCountry.getDisplayName() %>";
  	<%
  	states = aCountry.getStates();
		
		if (states != null && states.length != 0) {
			for (int k=0; k<states.length; k++) {
				if (k==0) {
		  	%>
					countries["<%= aCountry.getCode() %>"].states = new Object();
				<% 
				} 
				%>
				countries["<%= aCountry.getCode() %>"].states["<%= states[k].getCode() %>"] = "<%= states[k].getDisplayName() %>";
			<%
			}
		}
	}
	%>

	// Reload the state field to be input or select depending on the data
	function loadStatesUI(form, paramPrefix)
	{
		var currentState = form[paramPrefix + "state"].value;
    var currentCountryCode = form[paramPrefix + "country"].value;
    var stateDivObj = document.getElementById(paramPrefix + "stateDiv");
		while(stateDivObj.hasChildNodes()) {
			stateDivObj.removeChild(stateDivObj.firstChild);
		}

    if (countries[currentCountryCode].states) {
        // switch to state list
        stateDivObj.appendChild(createStateWithOptions(paramPrefix, currentCountryCode, currentState));
    } else {
        // switch to state text input
        stateDivObj.appendChild(createState(paramPrefix, currentState));
    }
	}

	// Create an input element to represent the state
	function createState(paramPrefix, currentState)
	{
		var stateInput = document.createElement("input");
		stateInput.setAttribute("id", paramPrefix + "state");
		stateInput.setAttribute("name", paramPrefix + "state");
		stateInput.setAttribute("className", "iform");
		stateInput.setAttribute("size", "20");
		stateInput.setAttribute("maxlength", "42");
		//stateInput.setAttribute("value", currentState);
		return stateInput
	}

	// Create an select element to represent the state and load it with the corresponding states
	// as defined in the database
	function createStateWithOptions(paramPrefix, currentCountryCode, currentState)
	{
		var stateSelect = document.createElement("select");
		stateSelect.setAttribute("id", paramPrefix + "state");
		stateSelect.setAttribute("name", paramPrefix + "state");
		stateSelect.setAttribute("className", "iform");
		
    // clear old options
    stateSelect.options.length = 0;
    
    // add all states
    for (state_code in countries[currentCountryCode].states) {
        // add a state
        aOption = document.createElement("option");
        stateSelect.options.add(aOption);
        aOption.text = countries[currentCountryCode].states[state_code];
        aOption.value = state_code;

        if (state_code == currentState || countries[currentCountryCode].states[state_code] == currentState) {
            aOption.selected = true;
        }
    }
    
    return stateSelect;
	}
	
	var busy = false;

      function checkstate() 
	        {
			
			if (document.OrgRegisterAdd.sameFlag.checked)
			{
			  document.OrgRegisterAdd.usr_address1.value = document.OrgRegisterAdd.org_address1.value;
			  document.OrgRegisterAdd.usr_address2.value = document.OrgRegisterAdd.org_address2.value;
			  document.OrgRegisterAdd.usr_city.value = document.OrgRegisterAdd.org_city.value;
			  document.OrgRegisterAdd.usr_zipCode.value = document.OrgRegisterAdd.org_zipCode.value;
			  document.OrgRegisterAdd.usr_phone1.value = document.OrgRegisterAdd.org_phone1.value;
			  document.OrgRegisterAdd.usr_phone2.value = document.OrgRegisterAdd.org_phone2.value;
			  document.OrgRegisterAdd.usr_fax1.value = document.OrgRegisterAdd.org_fax1.value;
			  document.OrgRegisterAdd.usr_country.selectedIndex = document.OrgRegisterAdd.org_country.selectedIndex;
			  loadStatesUI(document.OrgRegisterAdd, 'usr_');
			  if (document.OrgRegisterAdd.usr_state.type == 'text') {
			  	document.OrgRegisterAdd.usr_state.value = document.OrgRegisterAdd.org_state.value;
			  } else {
			  	document.OrgRegisterAdd.usr_state.selectedIndex = document.OrgRegisterAdd.org_state.selectedIndex;
			  }
			}
		}		
		
		function submitForm(form)
		{
			<% 
			if (distributorStoreIds != null) {
				for (int p=0; p<distributorStoreIds.length; p++) {
				        String temp = "org_OrgDistributorPartnerId" + "_" + (distributorStoreIds[p]).toString() + "_" + p;
					%>
					var val = document.OrgRegisterAdd.text_<%=p%>.value;
					if (parseInt(val) != 1) {
						document.OrgRegisterAdd.<%=temp%>.value = '1_' + val;
					}
					
					<% 
				} 
			}
			%>
			
			var val1 = form.usr_email1.value;
			var val2 = form.usr_email2.value;

			if ( val1 != val2 ) {
				// If email and validate email don't match, redirect to same page with error message
				document.OrgRegisterAdd.action = 'ResellerRegistrationFormView';
				document.OrgRegisterAdd.validateEmailAddress.value= 'no';
			}
			if (!isValidUTF8length(form.usr_address1.value, 50) || !isValidUTF8length(form.usr_address2.value, 50))
			{
			  alert("<%=storeText.getString("ERROR_User_AddressTooLong")%>");
			}
			else if (!isValidUTF8length(form.org_address1.value, 50) || !isValidUTF8length(form.org_address2.value, 50))
			{
			  alert("<%=storeText.getString("ERROR_Org_AddressTooLong")%>");
			}
			else
			{
				if (busy) { 
					return;
				}
				busy = true;
			  form.submit();
			}
		}
		-->
		</script>



<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
	<%@ include file="../../../include/HeaderDisplay.jspf"%>
	<table border="0" cellpadding="0" cellspacing="0" width="750">
		<tbody><tr>
			<td valign="top" class="dbg" width="150">
				<%
				String incfile = includeDir + "SidebarDisplay.jsp";
				%>
				<jsp:include page="<%=incfile%>" flush="true"></jsp:include>
			</td>
			<td width="10"><spacer type="horizontal" size="10" /><br />
			</td>
			<td><a name="mainContent"></a>
				<form name="OrgRegisterAdd" action="ResellerRegistrationAdd" method="post">
					<input type="hidden" name="langId" value="<%=languageId%>" />
					<input type="hidden" name="storeId" value="<%=storeId%>" /> 
					<input type="hidden" name="catalogId" value="<%=catalogId%>" /> <input type="hidden" name="URL" value="ResellerRegistrationApprovalView?&usr_logonId*=&usr_firstName*=&usr_lastName*=&usr_address1*=&usr_address2*=&usr_city*=&usr_country*=&usr_state*=&usr_zipCode*=&usr_email1*=&usr_phone1*=&org_legalId*=&org_orgEntityName*=&org_address1*=&org_address2*=&org_city*=&org_country*=&org_state*=&org_zipCode*=&org_email1*=&org_phone1*=" /> <input type="hidden" name="usr_profileType" value="B" /> <input type="hidden" name="org_orgEntityType" value="O" /> <input type="hidden" name="usr_challengeQuestion" value="-" /> <input type="hidden" name="usr_challengeAnswer" value="-" /> <input type="hidden" name="numberLoc" value="<%=numberLoc%>" /> <input type="hidden" name="validateEmailAddress" value="" /> <img src="<%=fileDir%>images/c.gif" height="20" width="20" />
					<table width="590" border="0" cellspacing="0" cellpadding="0" border="0">
						<tbody><tr valign="top">
							<td>
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tbody><tr>
										<td valign="top"><img src="<%=fileDir%>images/c.gif" height="11" width="11" /><br />
											<span class="title"><%=storeText.getString("OrgReg_Title1")%></span>
										</td>
										<td>
											<div align="right">
												<img src="<%=fileDir%>images/hdr_account.gif" alt='<%=storeText.getString("OrgReg_Title1")%>' /></div>
										</td>
									</tr>
								</tbody></table>
								<%
								 if (strErrorMessage != null && !strErrorMessage.equals("")) {
									//Display error messages. 
									%><span class="error"><%=strErrorMessage%></span><br />
										<br />
									<%		
								}			
								%>
								<table width="100%" border="0">
									<tbody><tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom">(<font color="#CC6600">*</font>)&nbsp;<%=storeText.getString("OrgReg_remark3")%><br/><br/></td>
									</tr>



								<tr valign="top">
									<td class="tdblue" colspan="3" height="18">&nbsp;&nbsp;<%=storeText.getString("OrgReg_remark1")%></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom">
										<b><label for="org_orgEntityName"><%=storeText.getString("OrgReg_Buyer")%></label><font color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" colspan="3" valign="top"><input type="text" name="org_orgEntityName" value="<%=strOrgName%>" class="iform" size="25" id="org_orgEntityName" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="OrgReg_Loc"><%=storeText.getString("OrgReg_Loc")%></label></b></td>
								</tr>
								<% for (int k=0; k<loc; k++) 
								{
                      
						                        String fieldName = "org_locId" + "_" + storeId + "_" + k;
						                        String strloc = "";
									if (distlocList.size() > 0 ) {
										strloc = (String) distlocList.elementAt(k);
								      	}                       
					                        %>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" name="<%=fieldName%>" value="<%=strloc%>" class="iform" size="25"  maxlength="10" id="OrgReg_Loc" /></td>
								</tr>
								<% 
								} %>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="OrgReg_Buyer1"><%=storeText.getString("OrgReg_Buyer1")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" name="org_legalId" value="<%=strLegalId%>" class="iform" size="25" id="OrgReg_Buyer1" /></td>
								</tr>
													
													
								<!-- Begin Language specific formatting of form -->
		<%
		if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) 
			{
			//Format Address : Double Byte Countries
			// Japan, China, Taiwan and Korea
			%>
				<tr>
					<td class="bodytxt1" align="left" valign="bottom" width="50%" colspan="2"><b><label for="rcountrytext"><%=storeText.getString("Reg_Country")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
					<td class="bodytxt1" align="left" valign="bottom"><b><label for="rziptext"><%=storeText.getString("OrgReg_Zipcode")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
				</tr>
				<tr>
					<td class="" align="left" colspan="2" valign="top"><select name="org_country" class="iform" id="rcountrytext" onChange="javascript:loadStatesUI(document.OrgRegisterAdd, 'org_')"><%=strOrgCountryDropDown.toString()%></select></td>
					<td class="" align="left" valign="top"><input type="text" name="org_zipCode" id="rziptext" value="<%=strZipCode%>" class="iform" size="25"  maxlength="13" /></td>
				</tr>
				<tr>
					<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="statetext"><%=storeText.getString("OrgReg_Province")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
					<td class="bodytxt1" align="left" valign="bottom"><b><label for="citytext2"><%=storeText.getString("OrgReg_City")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
				</tr>
				<tr>
					<td class="bodytxt1" align="left" valign="top" colspan="2"><div id="org_stateDiv"><%= strOrgStateDropDown.toString() %></div></td>
					<td class="bodytxt1" align="left" valign="top"><input type="text" maxlength="42" size="20" name="org_city" id="citytext2" value="<%=strCity%>" class="iform" /></td>
				</tr>
				<tr>
					<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="strAddress1"><%=storeText.getString("OrgReg_Addr1")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
				</tr>
				<tr>
					<td class="bodytxt1" colspan="3" align="left" valign="top">
						<input type="text" maxlength="50" size="40" name="org_address1" value="<%=strAddress1%>" class="iform" id="strAddress1" /><br />
						<input type="text" maxlength="50" size="40" name="org_address2"	value="<%=strAddress2%>" class="iform" id="strAddress1" /></td>
				</tr>
			<%
			}
			  // Format Address : Single Byte Countries
			else if (locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")||locale.toString().equals("it_IT")||locale.toString().equals("es_ES"))
				{
				// Format Address(Zip,City,State/Region,Country) for France, Germany, Italy and Spain
				%>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom" height="27"><b><label for="strAddress1"><%=storeText.getString("OrgReg_Addr1")%></label><font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" maxlength="50" size="40" name="org_address1" value="<%=strOrgAddress1%>" class="iform" id="strAddress1" /><br />
											<input type="text" maxlength="50" size="40" name="org_address2" value="<%=strOrgAddress2%>" class="iform" id="strAddress1" /></td>
									</tr>
									<tr>
										<td class="bodytxt1" align="left" valign="bottom"><b><label for="orgzipcodetext"><%=storeText.getString("OrgReg_Zipcode")%></label><font color="#CC6600">*</font></b></td>
										<td class="bodytxt1" align="left" valign="bottom" colspan="2" ><b><label for="orgregcitytext"><%=storeText.getString("OrgReg_City")%></label><font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" align="left" valign="top"><input type="text" maxlength="13" size="20" name="org_zipCode" id="orgzipcodetext" value="<%=strOrgZip%>" class="iform" /></td>
										<td class="bodytxt1" align="left" valign="top" colspan="2" ><input type="text" maxlength="42" size="20" name="org_city" id="orgregcitytext" value="<%=strOrgCity%>" class="iform" /></td>
									</tr>							
	                                                               <tr>
	                                                                      <td class="" align="left" valign="bottom"><b><label for="orgregprovtext"><%=storeText.getString("OrgReg_Province")%></label></b></td>
	                                                                      <td class="" align="left" valign="bottom" colspan="2"><b><label for="orgregcountrytext"><%=storeText.getString("Reg_Country")%></label><font color="#CC6600">*</font></b></td>
	                                                               </tr>
	                                                               <tr>
	                                                                      
	                                                                      	<td class="bodytxt1" align="left" valign="top"><div id="org_stateDiv"><%= strOrgStateDropDown.toString() %></div></td>
										<td class="" align="left" colspan="2" valign="top"><select name="org_country" class="iform" id="orgregcountrytext" onChange="javascript:loadStatesUI(document.OrgRegisterAdd, 'org_')"><%=strOrgCountryDropDown.toString()%></select></td>
        	                                                       </tr>

				<%
				}
				else
				{
				// Format Address(City,State/Region,Country & Zip) for Brazil and English US and unhandled locales.
				%>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom" height="27"><b><label for="strAddress1"><%=storeText.getString("OrgReg_Addr1")%></label><font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top">
											<input type="text" maxlength="50" size="40" name="org_address1" value="<%=strOrgAddress1%>" class="iform" id="strAddress1" /><br />
											<input type="text" maxlength="50" size="40" name="org_address2" value="<%=strOrgAddress2%>" class="iform" id="strAddress1" /></td>
									</tr>
									<tr>
										<td class="bodytxt1" align="left" valign="bottom"  colspan="2"><b><label for="oregcity"><%=storeText.getString("OrgReg_City")%></label><font color="#CC6600">*</font></b></td>
										<td class="" align="left" valign="bottom"><b><label for="oregprovtext"><%=storeText.getString("OrgReg_Province")%></label><font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" align="left" valign="top"  colspan="2"><input type="text" maxlength="42" size="20" name="org_city" id="oregcity" value="<%=strOrgCity%>" class="iform" /></td>
										<td class="bodytxt1" align="left" valign="top"><div id="org_stateDiv"><%= strOrgStateDropDown.toString() %></div></td>
									</tr>								
	                                                               <tr>
	                                                                      <td class="" align="left" valign="bottom" colspan="2"><b><label for="oregcountrytext"><%=storeText.getString("Reg_Country")%></label><font color="#CC6600">*</font></b></td>
	                                                                      <td class="bodytxt1" align="left" valign="bottom"><b><label for="oregzipcodetext"><%=storeText.getString("OrgReg_Zipcode")%></label><font color="#CC6600">*</font></b></td>
	                                                               </tr>
	                                                               <tr>
	                                                                      
	                                                                      	
										<td class="" align="left" colspan="2" valign="top"><select name="org_country" class="iform" id="oregcountrytext" onChange="javascript:loadStatesUI(document.OrgRegisterAdd, 'org_')"><%=strOrgCountryDropDown.toString()%></select></td>
										<td class="bodytxt1" align="left" valign="top"><input type="text" maxlength="13" size="20" name="org_zipCode" id="oregzipcodetext" value="<%=strOrgZip%>" class="iform" /></td>
        	                                                       </tr>
				<%
				}
				%>
				<!-- End Language specific formatting of form -->
							
													
									<tr>
										<td class="bodytxt1" align="left" colspan="3" valign="bottom"><b><label for="orgregphonetext"><%=storeText.getString("OrgReg_Phone")%></label></b><br />
											<span class="p"><%=storeText.getString("OrgReg_PHONE_FORMAT")%><br />
											</span></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" name="org_phone1" id="orgregphonetext" maxlength="32" value="<%=strOrgphone1%>" class="iform" size="25" /><b><label for="orgphoneexttext"><%=storeText.getString("Reg_Phone_extension")%></label></b>&nbsp;&nbsp;<input type="text" id="orgphoneexttext" name="org_phone2" maxlength="6" value="<%=strOrgphone2%>" class="iform" size="6" /></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="orgfaxtext"><%=storeText.getString("OrgReg_Fax")%></label></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" name="org_fax1" id="orgfaxtext" value="<%=strOrgfax1%>" maxlength="32" class=" iform" size="25" /></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="orgregemailtext"><%=storeText.getString("OrgReg_Email")%></label><font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" name="org_email1" id="orgregemailtext" value="<%=strOrgemail1%>" class="iform" size="25"  maxlength="80" /></td>
									</tr>
									<%
									if (distributorStoreIds != null && distributorStoreIds.length > 0) {
									%>
										<tr>
											<td class="bodytxt1" colspan="3" align="left" valign="bottom"><br />
													<%=storeText.getString("OrgReg_note3")%></td>
										</tr>
										<tr>
											<td class="bodytxt1" align="left" valign="bottom"><br />
												<b><%=storeText.getString("OrgReg_distributor")%></b></td>
											<td class="" align="left" valign="bottom" colspan="2"><br />
												<b><label for="resellertext"><%=storeText.getString("OrgReg_reseller")%></label></b></td>
										</tr>
											<%			    
			      								 for (int p=0; p<distributorStoreIds.length; p++) { 
			    	
												String distname = cmdcontext.getStore(distributorStoreIds[p]).getIdentifier();
											    	String fieldName3 = "org_OrgDistributorPartnerId" + "_" + (distributorStoreIds[p]).toString() + "_" + p;
											    	String strreseller = "";
	
												if (distresellerList.size() > 0 ) {
												    strreseller = (String) distresellerList.elementAt(p);
												    if (strreseller.length() > 1 && strreseller.substring(0,2).equals("1_")) {
												    	strreseller = strreseller.substring(2,strreseller.length());
												    }
												}
			    		                              		   	 %>
											<tr>
												<td class="bodytxt1" align="left" valign="bottom"><br />
													<b><%=distname%></b></td>
												<td class="bodytxt1" align="left" valign="bottom" colspan="2">
													<input type="hidden" name="<%=fieldName3%>" value="<%=strreseller%>" class="iform" size="25" />
													<input type="text" name="text_<%=p%>" id="resellertext" value="<%=strreseller%>" class="iform" size="25"  maxlength="25" />
												</td>
											</tr>
											<% } %>
										<% } %>



									<tr valign="top">
										<td class="tdblue" colspan="3" height="18">&nbsp;&nbsp;<%=storeText.getString("OrgReg_remark2")%></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="usr_logonId"><%=storeText.getString("OrgReg_UserID")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" maxlength="80" size="20" name="usr_logonId" value="<%=strLogonID%>" class="iform" id="usr_logonId" /></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="orgregpwd"><%=storeText.getString("OrgReg_Password")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="password" id="orgregpwd" maxlength="40" size="20" name="logonPassword" value="<%=strPassword%>" class="iform" /></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="orgregpwdverify"><%=storeText.getString("OrgReg_Verify")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="password" id="orgregpwdverify" maxlength="40" size="20" name="logonPasswordVerify" value="<%=strPasswordVerify%>" class="iform" /><br />
											<br />
										</td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="useremail"><%=storeText.getString("UserReg_Email")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" id="useremail" name="usr_email1" value="<%=strEmail1%>" class="iform" size="25" maxlength="80" /></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="useremail2"><%=storeText.getString("UserReg_Email2")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
									</tr>
									<tr>
										<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" id="useremail2" name="usr_email2" value="<%=strEmail2%>" class="iform" size="25" maxlength="80" /></td>
									</tr>
								<!-- Begin Language specific formatting of form -->		


								<% 
		if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) 
			{ 
			// Name Format for Japan, Korea, China & Taiwan
			%>
								<tr>
								  <td class="bodytxt1" colspan="2" align="left" valign="bottom" width="50%"><b><label for="userlastname"><%=storeText.getString("Reg_Buyer2")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
								</tr>
								<tr>
								  <td class="bodytxt1" colspan="2" align="left" valign="top"><input type="text" maxlength="42" size="25" name="usr_lastName" id="userlastname"  value="<%=strLastName%>" class="iform" /></td>
								</tr>
								<tr>
								  <td class="bodytxt1" align="left" valign="bottom" width="50%" colspan="2"><b><label for="strFirstName"><%=storeText.getString("Upreg_First")%></label><%if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")) {%>&nbsp;<font color="#CC6600">*</font><%}%></b></td>
								  <td class="bodytxt1" align="left" valign="bottom"><br /></td>
								</tr>
								<tr>
								  <td class="bodytxt1" align="left" valign="top" colspan="2"><input type="text" maxlength="42" size="25" name="usr_firstName" value="<%=strFirstName%>" class="iform" id="strFirstName" /></td>
								  <td class="bodytxt1" align="left" valign="top"><br /></td>
								</tr>
								<% 
			} 
		else 
			{ 
			// Name Format for English US, France, Brazil, Germany, Italy, Spain, and all unhandled locales.
			%>
								<tr>
								  <td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="usertitle"><%=storeText.getString("UserReg_Title2")%></label></b></td>
								</tr>
								<tr>
								  <td class="bodytxt1" colspan="3" align="left" valign="top"><select name="usr_personTitle" id="usertitle" class="iform">
								<%
								if (strTitle.equals ("")) 
								{
								%>
									<option selected ="selected" value="">&nbsp;</option><% 
								} 
								else 
								{
								%>
									<option value="">&nbsp;</option><%
								}

								// There are 4 titles listed in the property file.  Loop through and display the titles.
								int titlesInPropertyFile = 5;
								for (int i = 1; i < titlesInPropertyFile; i++) 
								{
									String sUpreg = "Upreg_Drop" + i;
								%>
									<option value="<%=storeText.getString(sUpreg)%>" <%= (strTitle != null && strTitle.equals (storeText.getString(sUpreg)))? "selected" : "" %>><%=storeText.getString(sUpreg)%></option><%
								} //end for
								%>
									</select>
								  </td>
								</tr>			
								<tr>
								  <td class="bodytxt1" align="left" valign="bottom" width="50%"><b><label for="strFirstName"><%=storeText.getString("Upreg_First")%></label></b></td>
								  <td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="strMiddleName"><%=storeText.getString("Reg_Buyer3")%></label></b></td>
								</tr>
								<tr>
								  <td class="bodytxt1" align="left" valign="top"><input type="text" maxlength="42" size="25" name="usr_firstName" value="<%=strFirstName%>" class="iform" id="strFirstName" /></td>
								  <td class="bodytxt1" align="left" valign="top" colspan="2"><input type="text" maxlength="42" size="10" name="usr_middleName" class="iform" id="strMiddleName" value="<%=strMiddleName%>" /></td>
								</tr>
								<tr>
								  <td class="bodytxt1" colspan="2" align="left" valign="bottom" width="50%"><b><label for="usrLastName"><%=storeText.getString("Reg_Buyer2")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
								</tr>
								<tr>
								  <td class="bodytxt1" colspan="2" align="left" valign="top"><input type="text" maxlength="42" size="25" id="usrLastName" name="usr_lastName" value="<%=strLastName%>" class="iform" /></td>
								</tr>
								<% } %>
								
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="checkbox" name="sameFlag" onclick="checkstate()" class="iform" id="sameinfo"/><b><label for="sameinfo"><%=storeText.getString("OrgReg_Checkbox1")%></label></b></td>
								</tr>
								
		<%
		if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) 
			{
			//Format Address : Double Byte Countries
			// Format Address (Country, Zip, State/Region, City, Street Address) for Japan, China, Taiwan and Korea
			%>

								<tr>
									<td class="bodytxt1" align="left" valign="bottom" width="50%"
										colspan="2"><b><label for="usrcountry"><%=storeText.getString("Reg_Country")%></label>&nbsp;<font color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="usrzipcode"><%=storeText.getString("OrgReg_Zipcode")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="" align="left" colspan="2" valign="top"><select name="usr_country" id="usrcountry" class="iform" onChange="javascript:loadStatesUI(document.OrgRegisterAdd, 'usr_')"><%=strCountryDropDown.toString()%></select>
									</td>
									<td class="" align="left" valign="top"><input type="text"
										name="usr_zipCode" id="usrzipcode"
										value="<%=strZipCode%>" class="iform" size="25" maxlength="13" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="orgregprov"><%=storeText.getString("OrgReg_Province")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="orgregcity"><%=storeText.getString("OrgReg_City")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="top" colspan="2"><div id="usr_stateDiv"><%= strStateDropDown.toString() %></div></td>
									<td class="bodytxt1" align="left" valign="top" colspan="2"><input
										type="text" maxlength="42" size="20"
										name="usr_city" id="orgregcity" value="<%=strCity%>"
										class="iform" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="strAddress2"><%=storeText.getString("OrgReg_Addr1")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input
										type="text" maxlength="50" size="50"
										name="usr_address1"
										value="<%=strAddress1%>" class="iform" id="strAddress2" /><br />
									<input type="text" maxlength="50" size="50"
										name="usr_address2"
										value="<%=strAddress2%>" class="iform" id="strAddress2" /></td>
								</tr>
								<%
				}
			// Format Address : Single Byte Countries
			else if (locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")||locale.toString().equals("it_IT")||locale.toString().equals("es_ES"))
				{
				// Format Address(Zip,City,State/Region,Country) for France, Germany, Italy and Spain
				%>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom">
									<b><label for="strAddress2"><%=storeText.getString("OrgReg_Addr1")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input
										type="text" maxlength="50" size="50"
										name="usr_address1"
										value="<%=strAddress1%>" class="iform" id="strAddress2" /><br />
									<input type="text" maxlength="50" size="50"
										name="usr_address2"
										value="<%=strAddress2%>" class="iform" id="strAddress2" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="ziptext"><%=storeText.getString("OrgReg_Zipcode")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="citytext"><%=storeText.getString("OrgReg_City")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="" align="left" valign="top"><input type="text" maxlength="13"
										name="usr_zipCode"
										value="<%=strZipCode%>" class="iform" size="25" id="ziptext"/></td>
									<td class="" align="left" colspan="2" valign="top"><input
										type="text" maxlength="42" size="20"
										name="usr_city" value="<%=strCity%>"
										class="iform" id="citytext"/></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="provtext"><%=storeText.getString("OrgReg_Province")%></label></b></td>
									<td class="bodytxt1" align="left" valign="bottom" width="50%" colspan="2"><b><label for="countrytext"><%=storeText.getString("Reg_Country")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="" align="left" valign="top"><div id="usr_stateDiv"><%= strStateDropDown.toString() %></div></td>
									<td class="" align="left" colspan="2" valign="top"><select name="usr_country" class="iform" id="countrytext" onChange="javascript:loadStatesUI(document.OrgRegisterAdd, 'usr_')"><%=strCountryDropDown.toString()%></select>
									</td>
								</tr>

								<%
				}
			else
				{
				// Format Address(City,State/Region,Country & Zip) for Brazil and English US and unhandled locales.
				%>

								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom">
									<b><label for="strAddress2"><%=storeText.getString("OrgReg_Addr1")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input
										type="text" maxlength="50" size="50"
										name="usr_address1"
										value="<%=strAddress1%>" class="iform" id="strAddress2" /><br />
									<input type="text" maxlength="50" size="50"
										name="usr_address2"
										value="<%=strAddress2%>" class="iform" id="strAddress2" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="cityreg"><%=storeText.getString("OrgReg_City")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="provreg"><%=storeText.getString("OrgReg_Province")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="" align="left" valign="top"><input
										type="text" maxlength="42" size="20"
										name="usr_city" value="<%=strCity%>"
										class="iform" id="cityreg"/></td>
									<td class="" align="left" valign="top" colspan="2"><div id="usr_stateDiv"><%= strStateDropDown.toString() %></div></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="rcountry"><%=storeText.getString("Reg_Country")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="rzip"><%=storeText.getString("OrgReg_Zipcode")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom"><select name="usr_country" class="iform" id="rcountry" onChange="javascript:loadStatesUI(document.OrgRegisterAdd, 'usr_')"><%=strCountryDropDown.toString()%></select></td>
									<td class="" align="left" valign="top" colspan="2"><input type="text"
										name="usr_zipCode"
										value="<%=strZipCode%>" class="iform" size="25" maxlength="13" id="rzip"/></td>
								</tr>

								<%
			}			
			%>						
															
								<!-- End Language specific formatting of form -->									
							
								<tr>
									<td class="bodytxt1" align="left" colspan="3" valign="bottom"><b><label for="uphone"><%=storeText.getString("UserReg_Phone")%></label></b><span class="p"><%=storeText.getString("UserReg_PHONE_FORMAT")%></span></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" name="usr_phone1" id="uphone" maxlength="32" value="<%=strPhone1%>" class="iform" size="25" /><b><label for="phoneext"><%=storeText.getString("Reg_Phone_extension")%></label></b>&nbsp;&nbsp;<input type="text" name="usr_phone2" id="phoneext" maxlength="6" value="<%=strPhone2%>" class="iform" size="6" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="faxnum"><%=storeText.getString("OrgReg_Fax")%></label></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input type="text" name="usr_fax1" id="faxnum" maxlength="32" value="<%=strFax1%>" class=" iform" size="25" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="jobtitletext"><%=storeText.getString("UserReg_Function")%></label></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" colspan="3" valign="top"><input type="text" name="usr_businessTitle" id="jobtitletext" value="<%=strBusTitle%>" class="iform" size="25" maxlength="42" /></td>
								</tr>

								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom">
									<b><label for="Reg_Curr"><%=storeText.getString("Upreg_Curr")%></label></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="top"><select
									name="<%=ECUserConstants.EC_USER_PREFERREDCURRENCY%>"
									class="iform" id="Reg_Curr">
									<%
				try {
				
				CurrencyManager cm = CurrencyManager.getInstance();
				String [] supportedCurrencies = (String []) cm.getSupportedCurrencies(cmdcontext.getStore());

				for (int i = 0; i < supportedCurrencies.length; ++i)
				{
					String currency = (String) cmdcontext.getCurrency();
					String currencydesc = cm.getDescription(cmdcontext.getStore(), supportedCurrencies[i], new Integer(languageId));
					// pre-select the approprate value in the in the drop down list.

					if ((strPreferredCurrency != null) && (strPreferredCurrency != ""))
						{
						if (strPreferredCurrency.equals(supportedCurrencies[i])) 
							{
							%>
									<option value="<%=supportedCurrencies[i]%>"
										selected="selected"><%=currencydesc%></option>
									<%
							} 
						else 
							{
							%>
									<option value="<%=supportedCurrencies[i]%>"><%=currencydesc%></option>
									<%
							}
						} 
					else
						{
						if (currency.equals(supportedCurrencies[i]))
							{
							%>
									<option value="<%=supportedCurrencies[i]%>"
										selected="selected"><%=currencydesc%></option>
									<%
							} 
						else 
							{
							%>
									<option value="<%=supportedCurrencies[i]%>"><%=currencydesc%></option>
									<%
							}
						}
					}
				} catch(Exception e) {
					out.println("exception:"+e);
				}					
					%>
								</select></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"><b><label for="Reg_Lang"><%=storeText.getString("Reg_Lang")%></label></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom">
									<select name="preferredLanguage" class="iform" id="Reg_Lang">
					
									<jsp:useBean id="supportedLanguageAccessBean" class="com.ibm.commerce.common.objects.SupportedLanguageAccessBean" scope="page" />
									<%
									Enumeration enStoreLangList = supportedLanguageAccessBean.findByStore(new Integer(storeId));
					
									while (enStoreLangList.hasMoreElements()) 
										{
										SupportedLanguageAccessBean storeLang = (SupportedLanguageAccessBean) enStoreLangList.nextElement();
										String storelangId = storeLang.getLanguageId();
					
										//Get the display name of the language in the language currently selected by the shopper.
										LanguageDescriptionAccessBean langDesc = new LanguageDescriptionAccessBean();
										langDesc.setInitKey_languageId(languageId);
										langDesc.setInitKey_descriptionLanguageId(storelangId);
					
										// pre-select the approprate value in the in the drop down list.
										if (strPreferredLanguage != null)
											{
											if (strPreferredLanguage.equals(storelangId)) 
												{
												%><option value=<%= storelangId %> selected><%=langDesc.getDescription()%></option><%
												}
											else 
												{
												%><option value=<%= storelangId %>><%=langDesc.getDescription()%></option><%
												}
											} 
										else
											{
											if (languageId.equals(storelangId)) 
												{
												%><option value=<%= storelangId %> selected><%=langDesc.getDescription()%></option><%
												} 
											else 
												{
												%><option value=<%= storelangId %>><%=langDesc.getDescription()%></option><%
												}
											}
										}
									%>
					
									</select>
									</td>
								</tr>
								<!-- Start distributor form section -->
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><br />
											<%=storeText.getString("OrgReg_note1")%></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><%=storeText.getString("OrgReg_note2")%></b>&nbsp;<%=storeText.getString("OrgReg_note4")%></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" colspan="3"><br />
										<table border="0" cellpadding="0" cellspacing="2" width="100%">
											<tbody><tr>
												<td class="bodytxt1"><b><%=storeText.getString("OrgReg_distributor")%></b></td>
												<td class="bodytxt1"><b><label for="distnametext"><%=storeText.getString("OrgReg_UID")%></label></b></td>
												<td class="bodytxt1"><b><label for="distpwdtext"><%=storeText.getString("OrgReg_PWD")%></label></b></td>
											</tr>
											<%
											if ((distributorStoreIds != null) && (distributorStoreIds.length>0)) {
                       
            										          for (int j=0; j<distributorStoreIds.length; j++) {  
												      String dist = cmdcontext.getStore(distributorStoreIds[j]).getIdentifier();
												      String fieldName1 = "usr_UserDistributorUserId" + "_" + (distributorStoreIds[j]).toString() + "_" + j;
												      String fieldName2 = "usr_UserDistributorPasswordEncrypted" + "_" + (distributorStoreIds[j]).toString() + "_" + j;
												      String strusr = "";
												      String strpwd = "";

												      if (distusrList.size() > 0 || distpwdList.size() > 0) {
												      	  strusr = (String) distusrList.elementAt(j);
												       	  strpwd = (String) distusrList.elementAt(j);
		       	  
												      } 
											%>
											<tr>
												<td class="bodytxt1"><b><%=dist%></b></td>
												<td class="bodytxt1"><input type="text" id="distnametext" name="<%=fieldName1%>" value="<%=strusr%>" class="iform" size="20" /></td>
												<td class="bodytxt1"><input type="password" id="distpwdtext" name="<%=fieldName2%>" value="<%=strpwd%>" class="iform" size="20" /></td>
											</tr>
											<% } //end for
										        } else {%>												
											<tr>
												<td colspan="3" class="bodytxt1"><%=storeText.getString("OrgReg_NoDistributor", storeName)%></td>
											</tr>
											<%}%>
										</tbody></table>
										<br />
									  </td>
								</tr>
								<!-- End distributor form section -->	
									<tr>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="3" align="left" valign="top"><a href="#" onclick="submitForm(document.OrgRegisterAdd);return false;"><img src="<%=fileDir%><%=locale.toString()%>/images/submit.gif" alt='<%=storeText.getString("Reg_Submit")%>' border="0" /></a></td>
									</tr>
								</tbody></table>
							</td>
						</tr>
					</tbody></table>
				</form>
			</td>
		</tr>
	</tbody></table>
	<%@ include file="../../../include/FooterDisplay.jspf"%>
</body>

</html>
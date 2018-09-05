<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2003, 2009
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Vector" %>

<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>
<%@ page import="com.ibm.commerce.user.beans.OrgEntityDataBean" %>
<%@ page import="com.ibm.commerce.price.utils.CurrencyManager" %>

<%@ page import="com.ibm.commerce.user.beans.CountryStateListDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.PolicyPasswordDataBean"%>
<%@ page import="com.ibm.commerce.user.beans.PolicyAccountDataBean" %>
<%@ page import="com.ibm.commerce.common.objects.LanguageDescriptionAccessBean" %>
<%@ page import="com.ibm.commerce.common.objects.SupportedLanguageAccessBean" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<jsp:useBean id="bnRegister" class="com.ibm.commerce.user.beans.UserRegistrationDataBean" scope="page">
 <% com.ibm.commerce.beans.DataBeanManager.activate(bnRegister, request); %>
</jsp:useBean>

<%!
	public String getFormattedDateTime(java.sql.Timestamp date, Locale aLocale) {
		try {
			return TimestampHelper.getDateTimeFromTimestamp(
				date,
				aLocale);
		} catch (Exception e) {
			return "";
		}
	}
%>

<%
String userId = cmdcontext.getUserId().toString();

//This is the user who is shopping in the channel store

bnRegister.setDataBeanKeyMemberId(userId );
bnRegister.populate();


//This will be used to store the list of all distributor StoreIds
Integer[] distributorStoreIds = null;
//This will store a String[] of {distributor Store Id, userId, password} 
Vector attributes = new Vector();

//Get all distributor stores
distributorStoreIds = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");

if (distributorStoreIds != null) {
       for (int i=0; i < distributorStoreIds.length; i++) {
              //Get the attributes of the user
              Vector uid = bnRegister.getAttribute("UserDistributorUserId", (distributorStoreIds[i]).toString()); 
              Vector pwd = bnRegister.getAttribute("UserDistributorPasswordEncrypted", (distributorStoreIds[i]).toString()); 
              if (uid != null) {
                     if (pwd == null) {
                            pwd = new Vector();
                            pwd.addElement("");
                     }
                     String[] values = {(distributorStoreIds[i]).toString(), (String) uid.elementAt(0), (String) pwd.elementAt(0)};
                     //Store the attributes in the Vector
                     attributes.addElement(values);
              }
       }
}


//The UserRegisrationDataBean will automatially get userId from commandContext.
// use getAttribute("RDN") here because getLogonId() will return the DN value when LDAP is used.
String strLogonID = bnRegister.getAttribute("RDN");

//The OrgEntityDataBean will automatically get the Buyer Organzaition
%>
<jsp:useBean id="dbOrgEntity" class="com.ibm.commerce.user.beans.OrgEntityDataBean" scope="page">
</jsp:useBean>
<%
String strBuyerOrg = null;

if (bnRegister.getParentMemberId() != null) 
       {
       dbOrgEntity.setOrgEntityId(bnRegister.getParentMemberId());
       }
com.ibm.commerce.beans.DataBeanManager.activate (dbOrgEntity, request);
strBuyerOrg = dbOrgEntity.getOrgEntityName();


String strPassword              = "";
String strPasswordVerify        = "";
String strLastName              = "";
String strFirstName             = "";
String strMiddleName          	= "";
String strPreferredLanguage     = "";
String strPreferredCurrency     = "";
String strTitle                 = "";
String strAddress1              = "";
String strAddress2              = "";
String strCity                  = "";
String strState                 = "";
String strCountry               = "";
String strZipCode               = "";
String strPhone1                = "";
String strPhone2                = "";
String strEmail1                = "";
String strBuyerFunction         = "";
String strFax1 					= "";
String strEmployeeId            = "";
String strInternalMailAddr      = "";

request.setAttribute("pageName", "MyProfile");

%>
<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean"
	scope="page"> <% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>
<%
// A problem with the user's input data will be detected here.

String strErrorMessage    = "";
String strErrorCode       = "";

TypedProperty hshErrorProperties = bnError.getExceptionData();

if (hshErrorProperties != null || bnError.getExceptionType() != null)

	{
	Object[] strMessageParams = null;
	String strFieldName = null;
	String strMessageKey = bnError.getMessageKey(); // Get message key
	strErrorMessage = bnError.getMessage();		// Get default message

			// Check for Invalid/Missing parameter data
			if (bnError.getMessageKey().equals("_ERR_CMD_INVALID_PARAM"))
			{	
				strMessageParams = bnError.getMessageParam();
				strFieldName = (String)strMessageParams[0];
				StringTokenizer st = new StringTokenizer(strFieldName, "=");
				strFieldName = st.nextToken();  // if the strFieldName contains '=' sign, use only the string before '='

					// Empty field errors
	              	if (strFieldName.equals(ECUserConstants.EC_ADDR_LASTNAME)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR6");
	              	}else if (strFieldName.equals(ECUserConstants.EC_ADDR_FIRSTNAME)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR17");	                     	
	              	}else if (strFieldName.equals(ECUserConstants.EC_ADDR_ADDRESS1)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR9");
	              	}else if (strFieldName.equals(ECUserConstants.EC_ADDR_CITY)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR10");
	              	}else if (strFieldName.equals(ECUserConstants.EC_ADDR_STATE)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR11");
	              	}else if (strFieldName.equals(ECUserConstants.EC_ADDR_COUNTRY)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR12");
	              	}else if (strFieldName.equals(ECUserConstants.EC_ADDR_ZIPCODE)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR13");
	              	}else if (strFieldName.equals(ECUserConstants.EC_ADDR_EMAIL1)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR1");
	              	}else if (strFieldName.equals(ECUserConstants.EC_BPROF_EMPLOYEEID)) {
	                     	strErrorMessage = storeText.getString("Upreg_ERROR16");                            
	              	}else if (strFieldName.equals(ECUserConstants.EC_UREG_LOGONID)) {
				 			strErrorMessage = storeText.getString("Reg_ERROR_MissingLogonID");	
					}else if (strFieldName.equals(ECUserConstants.EC_UREG_LOGONPASSWORD)) {
							strErrorMessage = storeText.getString("Reg_ERROR_MissingPassword");
					}else if (strFieldName.equals(ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY)) {	
							strErrorMessage = storeText.getString("Reg_ERROR_MissingVerifyPassword");
					}	              
       		}else { 
				// Check for incorrect field data
				Object[] arguments = {new Integer(0)};
				if (hshErrorProperties != null) {
					strErrorCode = hshErrorProperties.getString(ECConstants.EC_ERROR_CODE, "");	
				}
				
				// Check for Password and Logon ID errors
			
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
       
              
		       	if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_PASSWORDS_NOT_SAME)) {       
		              	strErrorMessage = storeText.getString("Reg_ERROR_PasswordsNotTheSame");
		       	}else if (strErrorCode.equals(ECUserConstants.EC_UREG_ERR_LOGONID_EXISTS))  {        
		              	strErrorMessage = storeText.getString("Reg_ERROR14");
		       	}else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLENGTH_PASSWORD)) {
		                arguments[0] = new Integer(minLength);                     
		                strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMinLength")), arguments);
		       	}else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXCONSECUTIVECHAR_PASSWORD)) {
		                arguments[0] = new Integer(maxConsec);                     
		                strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMaxConsecutiveLength")),arguments);
		       	}else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMDIGITS_PASSWORD)) {
		                arguments[0] = new Integer(minNumeric);                     
		                strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMinDigits")),arguments);              
		       	}else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLETTERS_PASSWORD)) {
		                arguments[0] = new Integer(minAlphabetic);                     
		                strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMinLetters")),arguments);
		       	}else if (strErrorCode.equals(ECSecurityConstants.ERR_USERIDMATCH_PASSWORD)) {
		         	strErrorMessage = storeText.getString("Reg_ERROR_PasswordUserIdPasswordMatch");       
		        }else if (strErrorCode.equals(ECSecurityConstants.ERR_REUSEOLD_PASSWORD)) {
		        	strErrorMessage = storeText.getString("Reg_ERROR_PasswordReUsed");
		       	}else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXINTANCECHAR_PASSWORD)) {
		                arguments[0] = new Integer(maxInstances);                     
		                strErrorMessage = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Reg_ERROR_PasswordMaxInstanceChar")),arguments);
		        }
      	}        

       

       //Note : All invalid password errors will display the bnError.getMessage() from the server.

       //Redisplay what was entered when the invalid entry was submitted.
       strPassword = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_UREG_LOGONPASSWORD));
       strPasswordVerify = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY));
       strLastName = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_LASTNAME));
       strFirstName = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_FIRSTNAME));
       strMiddleName = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_MIDDLENAME));
       strPreferredLanguage = jhelper.getParameter(ECUserConstants.EC_USER_PREFERREDLANGUAGE);
       strPreferredCurrency = jhelper.getParameter(ECUserConstants.EC_USER_PREFERREDCURRENCY);
       strTitle = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_PERSONTITLE));
       strAddress1 = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_ADDRESS1));
       strAddress2 = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_ADDRESS2));
       strCity = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_CITY));
       strState = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_STATE));
       strCountry = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_COUNTRY));
       strZipCode = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_ZIPCODE));
       strPhone1 = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_PHONE1));
       strPhone2 = jhelper.htmlTextEncoder(jhelper.getParameter("phone2"));
       strBuyerFunction = jhelper.getParameter("businessTitle");
       strEmployeeId = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_BPROF_EMPLOYEEID));
       strInternalMailAddr = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_OFFICEADDRESS));
       strEmail1 = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_ADDR_EMAIL1));
       strFax1 =jhelper.htmlTextEncoder( jhelper.getParameter("fax1"));

       }
else 
       {

       //Form is loading under normal condition.
       //Retrieve shopper's information and populate the form.

       strPassword = jhelper.htmlTextEncoder(bnRegister.getLogonPassword());
       strPasswordVerify = jhelper.htmlTextEncoder(bnRegister.getLogonPassword());
       strFirstName = jhelper.htmlTextEncoder(bnRegister.getFirstName().trim());
       strLastName = jhelper.htmlTextEncoder(bnRegister.getLastName().trim());
       strPreferredLanguage = jhelper.htmlTextEncoder(bnRegister.getPreferredLanguage().trim());
       strPreferredCurrency = jhelper.htmlTextEncoder(bnRegister.getPreferredCurrency().trim());
       strTitle = jhelper.htmlTextEncoder(bnRegister.getPersonTitle());
       strAddress1 = jhelper.htmlTextEncoder(bnRegister.getAddress1());
       strAddress2 = jhelper.htmlTextEncoder(bnRegister.getAddress2());
       strCity = jhelper.htmlTextEncoder(bnRegister.getCity());
       strState = jhelper.htmlTextEncoder(bnRegister.getState());
       strCountry = jhelper.htmlTextEncoder(bnRegister.getCountry());
       strZipCode = jhelper.htmlTextEncoder(bnRegister.getZipCode());
       strPhone1 = jhelper.htmlTextEncoder(bnRegister.getPhone1());
       strPhone2 = jhelper.htmlTextEncoder(bnRegister.getPhone2());
       strFax1 = jhelper.htmlTextEncoder(bnRegister.getFax1());
       strBuyerFunction = jhelper.htmlTextEncoder(bnRegister.getBusinessTitle());
       strMiddleName = jhelper.htmlTextEncoder(bnRegister.getMiddleName());

       try {
       Vector vecBuyerFunction = bnRegister.getAttribute("JobFunction", storeId);

       if (vecBuyerFunction != null) {
              if (!vecBuyerFunction.isEmpty()) {
                     strBuyerFunction = (String) vecBuyerFunction.lastElement(); //There's only one job function for this user, the lastElement on the vector should be the latest one.
                     }
       }
       } catch (Exception e) {
              strBuyerFunction = "";
              // System.out.println ("Error in getting Job Function");
       }
       
       strEmployeeId = jhelper.htmlTextEncoder(bnRegister.getEmployeeId());
       strInternalMailAddr = jhelper.htmlTextEncoder(bnRegister.getOfficeAddress());
       strEmail1 = jhelper.htmlTextEncoder(bnRegister.getEmail1());

       } //end if

       // Ensure our optional variables are not equal to null
       if (strBuyerFunction == null) { strBuyerFunction = ""; }
       if (strFax1 == null) { strFax1 = ""; }
%>

<jsp:useBean id="countryDB" class="com.ibm.commerce.user.beans.CountryStateListDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(countryDB, request); %>
</jsp:useBean>

<%
// Build the Country drop down list
Vector countries = countryDB.getCountries();
CountryStateListDataBean.Country aCountry = null;
CountryStateListDataBean.StateProvince[] states = null;

StringBuffer strCountryDropDown = new StringBuffer("<");
strCountryDropDown.append("select name=\"");
strCountryDropDown.append(ECUserConstants.EC_ADDR_COUNTRY); //comment to bypass id="accessiblity" tool
strCountryDropDown.append("\" class=\"iform\" onChange=\"javascript:loadStatesUI(document.RegisterUpdate,'')\">");
strCountryDropDown.append("<option value=\"\"");
strCountryDropDown = (strCountry !=null && strCountry.equals("")) ? strCountryDropDown.append(" selected>&nbsp; </option>") : strCountryDropDown.append(">&nbsp; </option>");

for (int i=0; i<countries.size(); i++) {
	aCountry = (CountryStateListDataBean.Country)countries.elementAt(i);
	
	strCountryDropDown.append("<option value=\"");
	strCountryDropDown.append(aCountry.getCode());
	strCountryDropDown.append("\"");
	strCountryDropDown = (strCountry !=null && strCountry.equals(aCountry.getCode())) ? strCountryDropDown.append(" selected>") : strCountryDropDown.append(">");
	strCountryDropDown.append(aCountry.getDisplayName());
	strCountryDropDown.append("</option>");
}
strCountryDropDown.append("</select>");

// Build state drop down list
StringBuffer strStateDropDown = new StringBuffer("");

if (!strCountry.equals("")) {
	states = countryDB.getStates(strCountry);
	if (states != null && states.length != 0) {
		strStateDropDown.append("<select id=\"state\" name=\"state\" class=\"iform\" >");
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
		strStateDropDown.append("<input type=\"text\" maxlength=\"42\" size=\"20\" name=\"state\" id=\"statetext\" value=\"");
		strStateDropDown.append(strState);
		strStateDropDown.append("\" class=\"iform\" />");
	}
} else {
	strStateDropDown.append("<input type=\"text\" maxlength=\"42\" size=\"20\" name=\"state\" id=\"statetext\" value=\"");
	strStateDropDown.append(strState);
	strStateDropDown.append("\" class=\"iform\" />");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title><%=storeText.getString("Upreg_Title1")%></title>
<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio" />

<SCRIPT language="javascript" src="<%=fileDir%>javascript/Util.js"></SCRIPT>
<script>
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
  function updateProfile(form)
	{
		if (!isValidUTF8length(form.<%=ECUserConstants.EC_ADDR_ADDRESS1%>.value, 50) 
			|| !isValidUTF8length(form.<%=ECUserConstants.EC_ADDR_ADDRESS2%>.value, 50))
		{
			alert("<%=storeText.getString("Reg_ERROR_AddressTooLong")%>");
		}
		else
		{
			if (!busy) {
				busy = true;
				form.submit();
			}
		}
	}
</script>
</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0"><%@ include file="../../../include/HeaderDisplay.jspf"%>
<table border="0" cellpadding="0" cellspacing="0" width="750">
	<tbody>
		<tr>
			<td valign="top" class="dbg" width="150"><%
                                   String incfile = includeDir + "SidebarDisplay.jsp";
                                   %> <jsp:include page="<%=incfile%>"
				flush="true"></jsp:include></td>
			<td width="10"><a name="mainContent"></a><spacer type="horizontal" size="10" /><br />
			</td>
			<td valign="top">
			<form name="RegisterUpdate" method="post"
				action="UserRegistrationUpdate"><input type="hidden" name="storeId"
				value="<%=storeId%>" /> <input type="hidden" name="catalogId"
				value="<%=catalogId%>" /> <input type="hidden" name="URL"
				value="StoreCatalogDisplay" /> <input type="hidden"
				name="errorViewName" value="UserRegistrationModifyFormView" /> <input
				type="hidden" name="page" value="account" /> <input type="hidden"
				name="<%=ECUserConstants.EC_USER_REGISTERTYPE%>"
				value="<%=bnRegister.getRegisterType()%>" /> <input type="hidden"
				name="<%=ECUserConstants.EC_USER_PROFILETYPE%>"
				value="<%=bnRegister.getProfileType()%>" /> <input type="hidden"
				name="<%= ECUserConstants.EC_UREG_CHALLENGEQUESTION %>"
				value="<%=bnRegister.getChallengeQuestion()%>" /> <input
				type="hidden" name="<%= ECUserConstants.EC_UREG_CHALLENGEANSWER %>"
				value="<%=bnRegister.getChallengeAnswer()%>" /> 
				<input type="hidden" name="langId" value="<%=languageId%>" />
				<input type="hidden" name="authToken" value="${authToken}" id="WC_UserRegistrationUpdate_FormInput_authToken_1"/>
				<img src="<%=fileDir%>images/c.gif" height="20" width="20" />

			<table width="590" border="0" cellspacing="0" cellpadding="0"
				border="0">
				<tbody>
					<tr valign="top">
						<td><!-- ===========================  CONTENT AREA ======================== -->
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tbody>
								<tr>
									<td valign="top">
									<div align="left"><img src="<%=fileDir%>images/c.gif"
										height="11" width="11" /><br />
									<font class="title"><%=storeText.getString("Upreg_Title1")%></font></div>
									</td>
									<td valign="top">
									<div align="right"><img
										src="<%=fileDir%>images/hdr_account.gif"
										alt='<%=storeText.getString("Upreg_Title1")%>' /></div>
									</td>
								</tr>
							</tbody>
						</table>
						<%
                                                             if (strErrorMessage != null && !strErrorMessage.equals("")) {
                                                                    //Display error messages. 
                                                                    %><font
							class="error"><%=strErrorMessage%></font><br />
						<br />
						<%              
                                                             }                     
                                                        %>
						<table width="415" border="0">
							<tbody>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"
										width="50%">(<font color="#CC6600">*</font>)&nbsp;<%=storeText.getString("Upreg_remark")%><br />
									<br />
									<b><%=storeText.getString("Upreg_UserID")%>&nbsp;<font
										class="oprice"><%= strLogonID %></font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"
										width="50%">
									<b><%=storeText.getString("Upreg_LAST_SUCCESSFUL_LOGIN")%>&nbsp;<font
										class="oprice"><%= getFormattedDateTime(cmdcontext.getUser().getLastSessionInEJBType(), locale) %></font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"
										width="50%"><b><%=storeText.getString("Upreg_Buyer")%>&nbsp;<%=strBuyerOrg%></b></td>
								</tr>

								<!-- Begin Language specific formatting of form -->

								<% 
		if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) 
			{ 
			// Name Format for Japan, Korea, China & Taiwan
			%>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"
										width="50%"><b><label for="<%=ECUserConstants.EC_ADDR_LASTNAME%>"><%=storeText.getString("Reg_Buyer2")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="top"><input
										type="text" maxlength="42" size="25"
										name="<%=ECUserConstants.EC_ADDR_LASTNAME%>"
										id="<%=ECUserConstants.EC_ADDR_LASTNAME%>"
										value="<%=strLastName%>" class="iform" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" width="50%"
										colspan="2"><b><label for="<%=ECUserConstants.EC_ADDR_FIRSTNAME%>"><%=storeText.getString("Reg_Buyer1")%></label>
										<%if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")) {%>
										&nbsp;<font color="#CC6600">*</font><%}%>
										</b></td>
									<td class="bodytxt1" align="left" valign="bottom"><br /></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="top" colspan="2"><input
										type="text" maxlength="42" size="25"
										name="<%=ECUserConstants.EC_ADDR_FIRSTNAME%>"
										id="<%=ECUserConstants.EC_ADDR_FIRSTNAME%>"
										value="<%=strFirstName%>" class="iform" /></td>
									<td class="bodytxt1" align="left" valign="top"><br /></td>
								</tr>
								<% 
			} 
		else 
			{ 
			// Name Format for English US, France, Brazil, Germany, Italy, Spain, and all unhandled locales.
			%>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"
										width="50%"><b><label for="usrtitletext"><%=storeText.getString("Reg_Title2")%></label></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="top"><select
										name="personTitle" class="iform" id="usrtitletext">
										<%
			if (strTitle.equals ("")) 
			{
 				%>
										<option selected="selected" value="">&nbsp;</option>
										<% 
			} 
			else 
			{
				%>
										<option value="">&nbsp;</option>
										<%
 			}
     
			for (int i = 1; i < 5; i++) 
			{
  				String sUpreg = "Reg_Drop" + i;
				%>
										<option value="<%=storeText.getString(sUpreg)%>"
											<%= (strTitle != null && strTitle.equals (storeText.getString(sUpreg)))? "selected" : "" %>>
										<%=storeText.getString(sUpreg)%></option>
										<%
			} //end for
     			%>
									</select></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" width="50%"><b><label for="userfirstnametext"><%=storeText.getString("Reg_Buyer1")%></label></b></td>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="usermiddlenametext"><%=storeText.getString("Reg_Buyer3")%></label></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="top"><input
										type="text" maxlength="42" size="25"
										name="<%=ECUserConstants.EC_ADDR_FIRSTNAME%>"
										value="<%=strFirstName%>" class="iform" id="userfirstnametext" /></td>
									<td class="bodytxt1" align="left" valign="top" colspan="2"><input
										type="text" maxlength="40" size="10"
										name="<%=ECUserConstants.EC_ADDR_MIDDLENAME%>" class="iform"
										value="<%=strMiddleName%>" id="usermiddlenametext" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"
										width="50%"><b><label for="userlastnametext"><%=storeText.getString("Reg_Buyer2")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="top"><input
										type="text"  maxlength="42" size="25"
										name="<%=ECUserConstants.EC_ADDR_LASTNAME%>"
										value="<%=strLastName%>" class="iform" id="userlastnametext"/></td>
								</tr>
								<% 
			} 
			
		if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) 
			{
			//Format Address : Double Byte Countries
			// Format Address (Country, Zip, State/Region, City, Street Address) for Japan, China, Taiwan and Korea
				%>

								<tr>
									<td class="bodytxt1" align="left" valign="bottom" width="50%"
										colspan="2"><b><label for="regcountrytext"><%=storeText.getString("Reg_Country")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="zipcodetext"><%=storeText.getString("Reg_Zipcode")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="" align="left" colspan="2" valign="top"><%=strCountryDropDown.toString()%>
									</td>
									<td class="" align="left" valign="top"><input type="text" maxlength="13"
										name="<%=ECUserConstants.EC_ADDR_ZIPCODE%>"
										value="<%=strZipCode%>" class="iform" size="25" id="zipcodetext"/></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="regprovtext"><%=storeText.getString("Reg_Province")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom">
									<b><label for="regcitytext"><%=storeText.getString("Reg_City")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="top" colspan="2"><div id="stateDiv"><%=strStateDropDown.toString()%></div></td>
									<td class="bodytxt1" align="left" valign="top"><input
										type="text" maxlength="42" size="20"
										name="<%=ECUserConstants.EC_ADDR_CITY%>" value="<%=strCity%>"
										class="iform" id="regcitytext"/></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="strAddress1"><%=storeText.getString("Reg_Addr1")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input
										type="text" maxlength="50" size="40"
										name="<%=ECUserConstants.EC_ADDR_ADDRESS1%>"
										value="<%=strAddress1%>" class="iform" id="strAddress1" /><br />
									<input type="text" maxlength="50" size="40"
										name="<%=ECUserConstants.EC_ADDR_ADDRESS2%>"
										value="<%=strAddress2%>" class="iform" id="strAddress1" /></td>
								</tr>
								<%
				}
			// Format Address : Single Byte Countries
			else if (locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")||locale.toString().equals("it_IT")||locale.toString().equals("es_ES"))
				{
				// Format Address(Zip,City,State/Region,Country) for France, Germany, Italy and Spain
				%>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="strAddress1"><%=storeText.getString("Reg_Addr1")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input
										type="text" maxlength="50" size="40"
										name="<%=ECUserConstants.EC_ADDR_ADDRESS1%>"
										value="<%=strAddress1%>" class="iform" id="strAddress1" /><br />
									<input type="text" maxlength="50" size="40"
										name="<%=ECUserConstants.EC_ADDR_ADDRESS2%>"
										value="<%=strAddress2%>" class="iform" id="strAddress1" /></td>
								</tr>				

								<tr>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="regzipcodetext"><%=storeText.getString("Reg_Zipcode")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="regcitytext"><%=storeText.getString("Reg_City")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="" align="left" valign="top"><input type="text" maxlength="13"
										name="<%=ECUserConstants.EC_ADDR_ZIPCODE%>"
										value="<%=strZipCode%>" class="iform" size="25" id="regzipcodetext"/></td>
									<td class="" align="left" colspan="2" valign="top"><input
										type="text" maxlength="42" size="20"
										name="<%=ECUserConstants.EC_ADDR_CITY%>" value="<%=strCity%>"
										class="iform"  id="regcitytext"/></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="regprovtext"><%=storeText.getString("Reg_Province")%></label></b></td>
									<td class="bodytxt1" align="left" valign="bottom" width="50%"
										colspan="2"><b><label for="rcountrytext"><%=storeText.getString("Reg_Country")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="" align="left" valign="top"><div id="stateDiv"><%=strStateDropDown.toString()%></div></td>
									<td class="" align="left" colspan="2" valign="top"><%=strCountryDropDown.toString()%>
									</td>
								</tr>

								<%
				}
			else
				{
				// Format Address(City,State/Region,Country & Zip) for Brazil and English US and unhandled locales.
				%>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="bottom"><b><label for="strAddress1"><%=storeText.getString("Reg_Addr1")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input
										type="text" maxlength="50" size="40"
										name="<%=ECUserConstants.EC_ADDR_ADDRESS1%>"
										value="<%=strAddress1%>" class="iform" id="strAddress1" /><br />
									<input type="text" maxlength="50" size="40"
										name="<%=ECUserConstants.EC_ADDR_ADDRESS2%>"
										value="<%=strAddress2%>" class="iform" id="strAddress1" /></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="rcitytext"><%=storeText.getString("Reg_City")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="rprovtext"><%=storeText.getString("Reg_Province")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="" align="left" valign="top" colspan="2"><input
										type="text" maxlength="42" size="20"
										name="<%=ECUserConstants.EC_ADDR_CITY%>" value="<%=strCity%>"
										class="iform" id="rcitytext"/></td>
									<td class="" align="left" valign="top"><div id="stateDiv"><%=strStateDropDown.toString()%></div></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><b><label for="rctytext"><%=storeText.getString("Reg_Country")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
									<td class="bodytxt1" align="left" valign="bottom"><b><label for="rzctext"><%=storeText.getString("Reg_Zipcode")%></label>&nbsp;<font
										color="#CC6600">*</font></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" colspan="2"><%=strCountryDropDown.toString()%></td>
									<td class="" align="left" valign="top"><input type="text" maxlength="13"
										name="<%=ECUserConstants.EC_ADDR_ZIPCODE%>"
										value="<%=strZipCode%>" class="iform" size="25" id="rzctext" /></td>
								</tr>

								<%
			}			
			%>


								<tr>
									<td class="bodytxt1" align="left" colspan="2" valign="bottom">
									<b><%=storeText.getString("Reg_Phone")%></b><br />
									<font class="p"><label for="phonetext"><%=storeText.getString("Reg_PHONE_FORMAT")%></label><br />
									</font></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input
										type="text" name="<%=ECUserConstants.EC_ADDR_PHONE1%>"
										maxlength="32" value="<%=strPhone1%>" class="iform" size="25" id="phonetext" />
									<b><label for="phoneexttext"><%=storeText.getString("Reg_Phone_extension")%></label></b>&nbsp;&nbsp;<input
										type="text" name="<%=ECUserConstants.EC_ADDR_PHONE2%>"
										maxlength="6" value="<%=strPhone2%>" class="iform" size="6" id="phoneexttext"/>
									</td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" colspan="2" valign="bottom">
									<b><label for="regemailtext"><%=storeText.getString("Reg_Email")%></label>&nbsp;<font
										color="#CC6600">*</font></b><br />
									</td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="3" align="left" valign="top"><input
										type="text" name="<%=ECUserConstants.EC_ADDR_EMAIL1%>"
										maxlength="80" value="<%=strEmail1%>" class="iform" size="25" id="regemailtext" />
									</td>
								</tr>

								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom">
									<b><label for="regfaxtext"><%=storeText.getString("OrgReg_Fax")%></label> </b></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="top"><input
										type="text" name="fax1" value="<%=strFax1%>" maxlength="32"
										class=" iform" size="25" id="regfaxtext"/></td>
								</tr>
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"
										width="50%"><b><label for="regfunctiontext"><%=storeText.getString("Reg_Function")%></label></b></td>
								</tr>
								<tr>
									<td class="bodytxt1" align="left" colspan="2" valign="top"><input
										type="text" name="businessTitle" value="<%=strBuyerFunction%>"
										class="iform" size="25" id="regfunctiontext"/></td>
								</tr>


								<!-- End Language specific formatting of form -->
								<tr>
									<td class="bodytxt1" colspan="2" align="left" valign="bottom"><b><label for="Reg_Curr"><%=storeText.getString("Upreg_Curr")%></label></b></td>
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
                                                        
                                                                                           if (strPreferredCurrency != null)
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
								<%  
                                                                if (!attributes.isEmpty())
                                                                      {          
                                                                      %>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" colspan="3"><br />
									<table border="0" cellpadding="0" cellspacing="2" width="100%">
										<tbody>
											<tr>
												<td class="bodytxt1" align="left" valign="bottom"><b><%=storeText.getString("OrgReg_distributor")%></b></td>
												<td class="bodytxt1" align="left" valign="bottom"><b><label for="distid"><%=storeText.getString("OrgReg_UID")%></label></b></td>
												<td class="bodytxt1" align="left" valign="bottom"><b><label for="distpwd"><%=storeText.getString("OrgReg_PWD")%></label></b></td>
											</tr>
											<tr>
												<td colspan="3">&nbsp;</td>
											</tr>
											<%              
                                                                                            for (int j=0; j<attributes.size(); j++) 
                                                                                           {
                                                                                                       String[] val = (String[])(attributes.elementAt(j));
                                                                                                       //Get the attributes of the user
                                                                                                  String distid = val[0]; 
                                                                                                  String uid = val[1];
                                                                                                  String pwd = val[2];
                                                                                                  String fieldName1 = "UserDistributorUserId" + "_" + distid + "_" + "r" + "_" + j ;
                                                                                                       String fieldName2 = "UserDistributorPasswordEncrypted" + "_" + distid + "_" + "r" + "_" + j;
                                                                                                       String dist = cmdcontext.getStore(Integer.valueOf(distid)).getIdentifier();      
                                                                                                %>
											<tr>
												<td class="bodytxt1" align="left" valign="bottom"><b><%=dist%></b></td>
												<td class="bodytxt1" align="left" valign="bottom"><input
													type="text" name="<%=fieldName1%>" value="<%=uid%>"
													class="iform" size="25" maxlength="25" id="distid"/></td>
												<td class="bodytxt1" align="left" valign="bottom"><input
													type="password" name="<%=fieldName2%>" value="<%=pwd%>"
													class="iform" size="25" maxlength="25" id="distpwd"/></td>
											</tr>
											<% } %>
										</tbody>
									</table>
									</td>
								</tr>
								<% 
                                                               }
                                                               else {
                                                                       %>
								<tr>
									<td class="bodytxt1" align="left" valign="bottom" colspan="3"><%=storeText.getString("Upreg_ERROR71")%><br />
									</td>
								</tr>
								<%
                                                                      }
                                                               %>
								<tr>
									<td align="left" valign="top" colspan="3" height="24"><spacer
										type="block" width="24" height="24" /></td>
								</tr>
								<tr>
									<td colspan="2" align="left" valign="top"><a
										onclick="updateProfile(document.RegisterUpdate); return false;"
										href="#"><img
										src="<%=fileDir%><%=locale.toString()%>/images/submit.gif"
										alt='<%=storeText.getString("Upreg_Button")%>' border="0" /><br />
									<br />
									</a></td>
								</tr>
							</tbody>
						</table>
						<!-- ===========================  END CONTENT AREA ======================== -->
						</td>
					</tr>
				</tbody>
			</table>
			</form>
			</td>
		</tr>
	</tbody>
</table>
<%@ include file="../../../include/FooterDisplay.jspf"%></body>

</html>
